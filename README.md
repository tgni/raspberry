This Project is for u-boot booting offical raspberry os, which has already using in booting ubuntu etc. 
which gives pretty much fun for who wants to develop uboot or linux kernel of raspberry. uboot version is 2021.01, linux kernel is 5.10.

STEPS:
1. insert SD card reader, SD card has raspberry system prepared (boot and rootfs parted)
2. modify BOOT_PATH and ROOTFS_PATH of your SD card at build.sh
3. run build.sh, it will compile uboot and kernel, and copy reference bin and dtbs into SD card automatically.
4. replace boot_files/config.txt in SD card, which modifies kernel=u-boot.bin and other params. 
5. insert serial line to pi, open the minicom, have fun! 

NOTES:
1. the system builds u-boot 32bits and linux kernel 32bits. 64bits of them have some issues, they may not work.
2. u-boot 64-bits may have some bugs of fatxx operations, which will trigger data abort exceptions.
3. DONOT saveenv for u-boot, it won't boot kernel if you do it. another bug for 32bits or 64bits uboot.
