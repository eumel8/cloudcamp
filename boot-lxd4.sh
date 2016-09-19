#!/bin/sh

neutron port-create \
     --security-group default --security-group lab \
     --fixed-ip subnet_id=e22256d6-ef3c-4704-91b2-a300d0e1abf9,ip_address=10.12.251.16 \
     --fixed-ip subnet_id=e22256d6-ef3c-4704-91b2-a300d0e1abf9,ip_address=10.12.251.17 \
     --name lxd4 \
    cd4b178b-cee7-4864-8b72-7030b87bf45e
PORT=`neutron  port-list | grep lxd4 | awk '{print $2}'` 

nova boot \
    --flavor 172 \
    --image 1ca535de-8a3c-4e09-98ae-598b20387290 \
    --key-name ops \
    --user-data user-data.lxd4 \
    --nic net-id=cd4b178b-cee7-4864-8b72-7030b87bf45e,port-id=${PORT} \
    --security-groups default,lab \
    --poll \
    lxd4

nova volume-attach lxd4 f32f6b8f-ee75-4612-bdce-b32f309aadf5 /dev/vdb
nova volume-attach lxd4 3502fedd-ae5c-42cc-8c81-98d49717b3a1

# nova add-floating-ip lxd 87.138.51.205

