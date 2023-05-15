#!/bin/sh

LV_SIZE=100G

# Create a 100GB volume on /dev/sdb
pvcreate /dev/sdb
vgcreate data /dev/sdb
lvcreate -n storage -L "${LV_SIZE}" data
mkfs.xfs /dev/data/storage
mkdir -p /mnt/storage/vol1
mount /dev/data/storage /mnt/storage/vol1
