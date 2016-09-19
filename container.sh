#!/bin/sh

BRANCH=$CI_BUILD_REF_NAME
CBRANCH=$(echo $BRANCH | sed "s/\\//-/")
DATE=`date +%s`
TENANT=`git remote -v | head -n1 | awk '{print $2}' | sed -e 's,.*:\(.*/\)\?,,' -e 's/\.git$//'`
CONTAINER=${TENANT}-${DATE}

destroy_container() {
   echo "something went wrong"
   lxc delete ${CONTAINER} --force || exit 1
   exit 1
}

lxc launch ubuntu:14.04 ${CONTAINER} || destroy_container

pwd
ls -l 

PACKAGE=`ls ${TENANT}_01-${CBRANCH}*.deb`
lxc file push ${PACKAGE} ${CONTAINER}/ || destroy_container

cat > deploy.sh << EOF
sleep 20
apt-get update
apt-get -y install puppet git
git clone -b eisbrecher https://github.com/TelekomCloud/puppet-dns.git /etc/puppet/modules/dns
git clone https://github.com/TelekomCloud/puppetlabs-concat /etc/puppet/modules/concat
git clone https://github.com/TelekomCloud/puppetlabs-stdlib /etc/puppet/modules/stdlib
dpkg -i /${PACKAGE}
puppet apply /srv/puppetmaster/conf/manifests/test.pp
host app.telekomcloud.com 127.0.0.1 || exit 1
EOF

lxc file push deploy.sh ${PACKAGE} ${CONTAINER}/
lxc exec ${CONTAINER} -- bash /deploy.sh || destroy_container

lxc stop ${CONTAINER} || destroy_container
lxc delete ${CONTAINER} || destroy_container

echo "done"


