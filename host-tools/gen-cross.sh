#!/bin/sh

PI_TOOLS_PATH="$ROOT_PATH/host-tools/$PI_TOOLS"

bin_list()
{
    # Check environment variable setting
	case "${COMPILER_NAME}" in
		"linaro")
        echo "c = '$PI_TOOLS_PATH/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-gcc'"
        echo "cpp = '$PI_TOOLS_PATH/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-g++'"
        echo "ar = '$PI_TOOLS_PATH/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-ar'"
        echo "strip = '$PI_TOOLS_PATH/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-strip'"
		;;
		"rpi")
        echo "c = '$PI_TOOLS_PATH/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc'"
        echo "cpp = '$PI_TOOLS_PATH/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf-g++'"
        echo "ar = '$PI_TOOLS_PATH/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf-ar'"
        echo "strip = '$PI_TOOLS_PATH/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf-strip'"
		;;
	esac

    echo "pkgconfig = '$ROOT_PATH/host-tools/arm-linux-gnueabihf-pkg-config'"
}

BINARIES="$(bin_list)"

cat << EOF > $ROOT_PATH/host-tools/cross
[binaries]
${BINARIES}

[host_machine]
system = 'linux'
cpu_family = 'arm'
cpu = 'armv7hl'
endian = 'little'
EOF
