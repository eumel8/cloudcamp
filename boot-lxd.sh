#!/bin/sh
nova boot \
    --flavor 172 \
    --image 1ca535de-8a3c-4e09-98ae-598b20387290 \
    --key-name ops \
    --user-data user-data.lxd \
    --nic net-id=cd4b178b-cee7-4864-8b72-7030b87bf45e \
    --security-groups default,lab \
    --poll \
    lxd
nova volume-attach lxd a195167d-e7e5-40f4-a40c-c60449ffbbd0
# nova add-floating-ip lxd 87.138.51.205

