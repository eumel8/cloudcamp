#!/bin/sh
nova boot \
    --flavor 172 \
    --image 1ca535de-8a3c-4e09-98ae-598b20387290 \
    --key-name ops \
    --user-data user-data.lxd-test \
    --nic net-id=cd4b178b-cee7-4864-8b72-7030b87bf45e \
    --security-groups default,lab \
    --poll \
    lxd-test

