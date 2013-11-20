#!/bin/bash

CONTAINER_NAME=$1
mkdir /root/$CONTAINER_NAME
mkdir /root/$CONTAINER_NAME/bin
mkdir /root/$CONTAINER_NAME/sbin
cp /sbin/busybox /root/$CONTAINER_NAME/sbin
for cmd in sh ls chdir chmod rm cat vi
do
    ln -s /root/$CONTAINER_NAME/bin/$cmd ../sbin/busybox
done
cat > /root/$CONTAINER_NAME/sbin/init <<EOF
#!/sbin/busybox
sh
EOF