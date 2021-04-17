#!/bin/bash

BOOT_PATH=/media/tgni/boot
ROOTFS_PATH=/media/tgni/rootfs
#CROSS_COMPILE=aarch64-linux-gnu-
CROSS_COMPILE=arm-linux-gnueabihf-

export BOOT_PATH ROOTFS_PATH CROSS_COMPILE

KERNEL=kernel7l
#ARCH=arm64
ARCH=arm
export KERNEL ARCH

echo "build kernel ..."
#make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- bcm2711_defconfig
#make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image modules dtbs -j 4

#make clean
make bcm2711_defconfig
#make Image modules dtbs -j 4
make zImage modules dtbs -j 4

echo "install kernel modules ..."
#sudo env PATH=$PATH make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- INSTALL_MOD_PATH=$ROOTFS_PATH modules_install
sudo env PATH=$PATH make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=$ROOTFS_PATH modules_install

#cp $BOOT_PATH/$KERNEL.img $BOOT_PATH/$KERNEL-backup.img
#cp arch/arm64/boot/Image $BOOT_PATH/$KERNEL.img
#cp arch/arm64/boot/Image $BOOT_PATH/

cp $BOOT_PATH/$KERNEL.img $BOOT_PATH/$KERNEL-backup.img
cp arch/arm/boot/zImage $BOOT_PATH/$KERNEL.img
cp arch/arm/boot/zImage $BOOT_PATH/

#echo "make uImage ..."
#mkimage -A arm -O linux -T kernel -C none -a 0x00008000 -e 0x00008000 -n "Linux kernel" -d arch/arm64/boot/Image $BOOT_PATH/uImage

echo "copy device table base ..."
#cp arch/arm64/boot/dts/broadcom/*.dtb $BOOT_PATH/
#cp arch/arm64/boot/dts/overlays/*.dtb* $BOOT_PATH/overlays/
#cp arch/arm64/boot/dts/overlays/README $BOOT_PATH/overlays/

cp arch/arm/boot/dts/*.dtb $BOOT_PATH/
cp arch/arm/boot/dts/overlays/*.dtb* $BOOT_PATH/overlays/
cp arch/arm/boot/dts/overlays/README $BOOT_PATH/overlays/
