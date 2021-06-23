#!/bin/bash

./scripts/feeds update -a
./scripts/feeds install -a

if [ -f ".config" ]; then
    echo ".config exists."
    make clean
fi
make clean
cp -f config.default .config
yes "" | make oldconfig
make -j $((1+`nproc`)) download

REMOVE=""

if [ "x$V" != "x" ]; then
    make -j $((1+`nproc`)) PACKAGES="$REMOVE" V=s
else
    make -j $((1+`nproc`)) PACKAGES="$REMOVE"
fi
