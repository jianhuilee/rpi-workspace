#!/bin/sh

PITOOL_TREE="https://github.com/raspberrypi/tools"
if [ ! -e $ROOT_PATH/host-tools/pi-tools ]; then
    git clone $PITOOL_TREE $ROOT_PATH/host-tools/pi-tools
fi

STABLE_KERNEL_TREE="git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git"
if [ ! -e $ROOT_PATH/source/stable-linux ]; then
    git clone $STABLE_KERNEL_TREE $ROOT_PATH/source/stable-linux
fi

UBOOT_PRIVATE_TREE="https://github.com/jianhuilee/u-boot.git"
if [ ! -e $ROOT_PATH/source/u-boot ]; then
    git clone $UBOOT_PRIVATE_TREE $ROOT_PATH/source/u-boot
fi

DRM_TREE="git://anongit.freedesktop.org/mesa/drm"
if [ ! -e $ROOT_PATH/source/drm ]; then
    git clone $DRM_TREE $ROOT_PATH/source/drm
fi

MESA_TREE="git://anongit.freedesktop.org/mesa/mesa"
if [ ! -e $ROOT_PATH/source/mesa ]; then
    git clone $MESA_TREE $ROOT_PATH/source/mesa
fi
