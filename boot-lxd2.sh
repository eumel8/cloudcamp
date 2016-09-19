#!/bin/sh
nova boot \
    --flavor 172 \
    --image 1ca535de-8a3c-4e09-98ae-598b20387290 \
    --key-name ops \
    --user-data user-data.lxd2 \
    --nic net-id=cd4b178b-cee7-4864-8b72-7030b87bf45e \
    --security-groups default,lab \
    --poll \
    lxd2
nova volume-attach lxd2 3f76d62d-9ab8-4d53-837b-3f6720bb67f7
# nova add-floating-ip lxd 87.138.51.205

