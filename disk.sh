pvcreate /dev/sdb
vgcreate data /dev/sdb
lvcreate -n storage -L 100G data
mkfs.xfs /dev/data/storage
mkdir -p /mnt/storage/vol1
mount /dev/data/storage /mnt/storage/vol1