#!/bin/sh

help () {
    echo "Usage: $0 [Options]"
    echo ""
    echo "Mandatory arguments to long options:"
    echo -e "\tkernel \tBuild VC4 Raspberry PI Kernel."
    echo -e "\tmesa\tBuild MESA library"
    echo -e "\tupdate\tUpdate all repository."
    exit 0
}

check_and_exit () {
    ret_val=$?
    if [ $ret_val -eq 1 ]; then
        echo "Exit because error occurs!"
    fi
    exit $ret_val
}

CURRENT_PATH="`pwd`"
UBOOT_PATH="$1"

if [ -z "$UBOOT_PATH" ]; then
    echo "Please assign the u-boot path."
    exit 1
elif [ ! -d "$UBOOT_PATH" ]; then
    echo "The assigned u-boot path is not valid."
    exit 1
fi

if [ ! -d $INSTALL_PATH ]; then
    mkdir -p $INSTALL_PATH
fi

echo "Build U-boot: $UBOOT_PATH"
cd $UBOOT_PATH

make rpi_2_defconfig
ARCH=arm CROSS_COMPILE=arm-linux-gnu- make all

cd $CURRENT_PATH

