#!/bin/bash

./scripts/feeds update -a
./scripts/feeds install -a
cp config.default .config
make olddefconfig

ADMIN="htop"
BASE="block-mount ca-bundle"
DOCKER="docker docker-compose"
HARDWARE="open-vm-tools kmod-usb-core kmod-usb-ohci kmod-usb2 kmod-usb3 kmod-usb-storage intel-microcode kmod-ixgbe"
FS="kmod-fs-vfat kmod-fs-exfat kmod-fs-ext4 kmod-fs-xfs kmod-fs-nfs"
LUCI="luci-i18n-base"
NET="bind-dig bind-host curl ethtool iftop openssh-server wget"
SYS="pciutils usbutils"
TOOLS=""
UTILS="bash lsof shadow-useradd vim-fuller"
REMOVE=""

make image PACKAGES="$ADMIN $BASE $DOCKER $HARDWARE $FS $LUCI $NET $SYS $TOOLS $UTILS $REMOVE" V=s