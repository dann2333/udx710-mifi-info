#!/bin/bash
echo -n "Input ubi image path:"
read ubipath 
echo -n "Input ubi image size, with MiB:"
read ubisize
modprobe mtd
modprobe mtdblock
modprobe ubi
modprobe ubifs
modprobe nandsim first_id_byte=0x98 second_id_byte=0xaa third_id_byte=0x90 fourth_id_byte=0x15 block_size=139264
echo "Modprobe OK. Here is mtdinfo\n"
mtdinfo /dev/mtd0
ubiformat -s 2048 -O 2048 /dev/mtd0
ubiattach -p /dev/mtd0 -O 2048
echo "Here is ubi info of /dev/ubi0"
ubinfo /dev/ubi0 -a
ubimkvol -N volume1 -s $ubisize /dev/ubi0
ubiupdatevol /dev/ubi0_0 $ubipath
mkdir /mnt/r106-sys
mount -t ubifs /dev/ubi0_0 /mnt/r106-sys/
