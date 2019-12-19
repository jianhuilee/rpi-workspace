#!/bin/bash

export COMPILER_NAME="rpi"

#export KERNEL=stable-kernel
#export KERNEL=debug-kernel
export KERNEL=ras-kernel
export PI_TOOLS=pi-tools
export MESA=mesa
export DRM=drm
export JOBS=12
export BUILD_KERNEL=0
export BUILD_MESA=0
export BUILD_PERF=0

export ROOT_PATH=`pwd`
export INSTALL_PATH=$ROOT_PATH/install
export KERNEL_PATH=$ROOT_PATH/$KERNEL

path_setup()
{
	case "${COMPILER_NAME}" in
		"linaro")
        export PATH=$ROOT_PATH/host-tools/$PI_TOOLS/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin:$PATH
		;;
		"rpi")
        export PATH=$ROOT_PATH/host-tools/$PI_TOOLS/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin:$PATH
		;;
	esac
}
#export PATH=$ROOT_PATH/host-tools/$PI_TOOLS/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin:$PATH
