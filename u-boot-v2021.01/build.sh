#!/bin/bash

BOOT_PATH=/media/tgni/boot
ROOTFS_PATH=/media/tgni/rootfs
#CROSS_COMPILE=aarch64-linux-gnu-
CROSS_COMPILE=arm-linux-gnueabihf-

export BOOT_PATH ROOTFS_PATH CROSS_COMPILE

echo "build uboot ..."

make distclean
#make rpi_4_defconfig
make rpi_4_32b_defconfig
make -j

#echo "build boot.scr.uimg ..."
#cat << EOF > boot.cmd
#mmc dev 0
#fatload mmc 0:1 \${fdt_addr} bcm2711-rpi-4-b.dtb
#fatload mmc 0:1 \${kernel_addr_r} uImage
#setenv bootargs 8250.nr_uarts=1 console=ttyS0,115200 root=/dev/mmcblk0p2 rootwait rw
#booti \${kernel_addr_r} - \${fdt_addr}
#EOF
#

echo "build boot.scr.uimg ..."
cat << EOF > boot.cmd
mmc dev 0
fatload mmc 0:1 \${fdt_addr} bcm2711-rpi-4-b.dtb
fatload mmc 0:1 \${kernel_addr_r} zImage
setenv bootargs 8250.nr_uarts=1 console=ttyS0,115200 root=/dev/mmcblk0p2 rootwait rw
bootz \${kernel_addr_r} - \${fdt_addr}
EOF


#mkimage -A arm -T script -C none -n "Boot script" -d "boot.cmd" boot.scr
#mkimage -A arm -O linux -T script -C none -n boot.scr -d boot.cmd boot.scr
mkimage -A arm -O linux -T script -C none -n boot.scr -d boot.cmd boot.scr.uimg

echo "copy u-boot.bin boot.scr.uimg to $BOOT_PATH"
cp u-boot.bin $BOOT_PATH/
cp boot.scr.uimg  $BOOT_PATH/
