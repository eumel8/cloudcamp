#!/bin/sh
nova boot \
    --flavor 172 \
    --image 1ca535de-8a3c-4e09-98ae-598b20387290 \
    --key-name ops \
    --user-data user-data.lxd3 \
    --nic net-id=cd4b178b-cee7-4864-8b72-7030b87bf45e \
    --security-groups default,lab \
    --poll \
    lxd3
nova volume-attach lxd3 cd9ea045-8070-452b-b9d1-6b07943234cb
nova volume-attach lxd3 d01ed49b-00a0-4654-b6c3-4b7b4b4bed43
# nova add-floating-ip lxd 87.138.51.205

