# respberry pi 3 + raspbain
# find out system info
uname -a ##print system info
uname -r --kernel-release 

# build and install linux kernel
# https://www.raspberrypi.org/documentation/linux/kernel/building.md
sudo apt-get install git bc #install git and log in
git clone --depth=1 https://github.com/raspberrypi/linux  #get src
git clone --depth=1 --branch rpi-4.18.y https://github.com/raspberrypi/linux  #get src of specific branch

cd linux
KERNEL=kernel7
make bcm2709_defconfig  #config 

make -j4 zImage modules dtbs
sudo make modules_install
sudo cp arch/arm/boot/dts/*.dtb /boot/
sudo cp arch/arm/boot/dts/overlays/*.dtb* /boot/overlays/
sudo cp arch/arm/boot/dts/overlays/README /boot/overlays/
sudo cp arch/arm/boot/zImage /boot/$KERNEL.img #build and install kernel, modules, device driver blobs

lsblk #list block device
''''
sdb
  sdb1
  sdb2
  sdb5
  sdb6
  sdb7
'''' #NOOBS SD Cards
# with sdb6 being the FAT (boot) partition, 
# and sdb7 being the ext4 filesystem (root) partition.

mkdir mnt
mkdir mnt/fat32
mkdir mnt/ext4
sudo mount /dev/sdb1 mnt/fat32
sudo mount /dev/sdb2 mnt/ext4 #adjust parition numbers

sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=mnt/ext4 modules_install #install mudules

sudo cp mnt/fat32/$KERNEL.img mnt/fat32/$KERNEL-backup.img
sudo cp arch/arm/boot/zImage mnt/fat32/$KERNEL.img
sudo cp arch/arm/boot/dts/*.dtb mnt/fat32/
sudo cp arch/arm/boot/dts/overlays/*.dtb* mnt/fat32/overlays/
sudo cp arch/arm/boot/dts/overlays/README mnt/fat32/overlays/
sudo umount mnt/fat32
sudo umount mnt/ext4 #cp kernel and device blob

kernel=kernel-myconfig.img
