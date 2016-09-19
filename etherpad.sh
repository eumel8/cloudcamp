#!/bin/sh

# install packages
apt-get update
apt-get -y install gzip git curl python libssl-dev pkg-config build-essential abiword nginx nodejs-legacy npm nodejs nodejs-legacy

# add user
useradd -m etherpad

# create log dir
mkdir /var/log/etherpad
chown etherpad:etherpad /var/log/etherpad

# clone git repo
sudo -u etherpad bash << EOF
cd ~etherpad
git clone https://github.com/ether/etherpad-lite
cd etherpad-lite/
cp settings.json.template settings.json
EOF

# create service
cat > /lib/systemd/system/etherpad.service << EOF
[Unit]
Description=Etherpad-lite, the collaborative editor.
After=syslog.target network.target

[Service]
Type=simple
User=etherpad
Group=etherpad
WorkingDirectory=/home/etherpad/etherpad-lite
ExecStart=/home/etherpad/etherpad-lite/bin/safeRun.sh /var/log/etherpad/etherpad.log
Restart=always

[Install]
WantedBy=multi-user.target

EOF

# start application
ln -s /lib/systemd/system/etherpad.service /etc/systemd/system/multi-user.target.wants/etherpad.service
systemctl enable etherpad.service
systemctl start etherpad.service
systemctl status etherpad.service

