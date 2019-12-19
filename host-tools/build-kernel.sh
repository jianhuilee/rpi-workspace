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
KERNEL_PATH="$1"

if [ -z "$KERNEL_PATH" ]; then
    echo "Please assign the kernel path."
    exit 1
elif [ ! -d "$KERNEL_PATH" ]; then
    echo "The assigned kernel path is not valid."
    exit 1
fi

if [ ! -d $INSTALL_PATH ]; then
    mkdir -p $INSTALL_PATH
fi

# DEBUG

echo "Build Kernel: $KERNEL_PATH"
cd $KERNEL_PATH

# For Raspberry Pi 1 and Zero, use bcm2835_defconfig
# For Raspberry Pi 2, use multi_v7_defconfig
#
# Downstream Kernel
# For Raspberry Pi 1, use bcmrpi_defconfig
# For Raspberry Pi 2 and Pi 3, use bcm2709_defconfig

# Upstream Kernel
make -j$JOBS ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- multi_v7_defconfig 
# make -j$JOBS ARCH=arm CROSS_COMPILE=arm-linux-gnu- multi_v7_defconfig 

# Downstream Kernel
# make -j$JOBS ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig

make -j$JOBS ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage modules dtbs
make -j$JOBS ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- modules_install INSTALL_MOD_PATH=$INSTALL_PATH
# make -j$JOBS ARCH=arm CROSS_COMPILE=arm-linux-gnu- zImage modules dtbs
# make -j$JOBS ARCH=arm CROSS_COMPILE=arm-linux-gnu- modules_install INSTALL_MOD_PATH=$INSTALL_PATH

# Copy to the install path
cp arch/arm/boot/dts/bcm2836-rpi-2-b.dtb $INSTALL_PATH
cp arch/arm/boot/zImage $INSTALL_PATH/kernel-vc4.img

echo "Build Kernel perf: $KERNEL_PATH"
cd tools/perf
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-

cd $CURRENT_PATH

