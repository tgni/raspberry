#!/bin/bash

UBOOT_BUILD_DIR="$(pwd)/u-boot-v2021.01"
KERNEL_BUILD_DIR="$(pwd)/linux-rpi-5.10.y"
BOOT_PATH=/media/tgni/boot
ROOTFS_PATH=/media/tgni/rootfs
#CROSS_COMPILE=aarch64-linux-gnu-
CROSS_COMPILE=arm-linux-gnueabihf-

export UBOOT_BUILD_DIR KERNEL_BUILD_DIR BOOT_PATH ROOTFS_PATH CROSS_COMPILE

if !(test -d $UBOOT_BUILD_DIR); then
	echo "uboot dir not exist!"
	exit $?
fi

if !(test -d $KERNEL_BUILD_DIR); then
	echo "kernel dir not exist!"
	exit $?
fi

if !(test -d $BOOT_PATH); then
	echo "boot dir not exist!"
	exit $?
fi

if !(test -d $ROOTFS_PATH); then
	echo "rootfs dir not exist!"
	exit $?
fi

cd $UBOOT_BUILD_DIR && ./build.sh && cd ..
cd $KERNEL_BUILD_DIR && ./build.sh && cd ..

echo "done!"
