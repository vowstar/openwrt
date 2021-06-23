#!/bin/bash

./scripts/feeds update -a
./scripts/feeds install -a

make clean
cp -f config.default .config
yes "" | make oldconfig
make -j $((1+`nproc`)) download

ADMIN="htop"
BASE="block-mount ca-bundle"
DOCKER="docker docker-compose"
HARDWARE="open-vm-tools kmod-usb-core kmod-usb-ohci kmod-usb2 kmod-usb3 kmod-usb-storage intel-microcode kmod-ixgbe kmod-mlx4-core"
FS="kmod-fs-vfat kmod-fs-exfat kmod-fs-ext4 kmod-fs-xfs kmod-fs-nfs"
LUCI="luci-i18n-base"
NET="curl ethtool iftop openssh-server wget"
SYS="pciutils usbutils"
TOOLS=""
UTILS="bash lsof shadow-useradd vim-fuller"
REMOVE=""

if [ "x$V" != "x" ]; then
    make -j $((1+`nproc`)) PACKAGES="$ADMIN $BASE $DOCKER $HARDWARE $FS $LUCI $NET $SYS $TOOLS $UTILS $REMOVE" V=s
else
    make -j $((1+`nproc`)) PACKAGES="$ADMIN $BASE $DOCKER $HARDWARE $FS $LUCI $NET $SYS $TOOLS $UTILS $REMOVE"
fi
