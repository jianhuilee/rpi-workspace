#!/bin/bash

PACKAGES_PATH=packages
INSTALL_PATH=install

if [ ! -e $PACKAGES_PATH ]; then
    mkdir $PACKAGES_PATH
fi
if [ ! -e $INSTALL_PATH ]; then
    mkdir $INSTALL_PATH
fi

cd $PACKAGES_PATH

declare -a pkgs=("zlib1g" "zlib1g-dev"
# 2019-12-18: Use expat library in mesa subprojects to avoid cross compiler error like 'undefined reference to getrandom' 
#                "libexpat1" "libexpat1-dev"
                "libx11-6" "libx11-dev"
                "x11proto-dev" "x11proto-core-dev" "x11proto-dri2-dev" "x11proto-dri3-dev"
                "x11proto-present-dev"  "x11proto-gl-dev" "x11proto-kb-dev"
                "libxcb1" "libxcb1-dev"
                "libpthread-stubs0-dev"
                "libxau6" "libxau-dev"
                "libxdmcp6" "libxdmcp-dev"
                "libxext6" "libxext-dev"
                "x11proto-xext-dev"
                "libxdamage1" "libxdamage-dev"
                "x11proto-damage-dev"
                "libxfixes3" "libxfixes-dev"
                "x11proto-fixes-dev"
                "libxcb-glx0" "libxcb-glx0-dev"
                "libx11-xcb1" "libx11-xcb-dev"
                "libxcb-dri2-0" "libxcb-dri2-0-dev"
                "libxcb-dri3-0" "libxcb-dri3-dev"
                "libxcb-present0" "libxcb-present-dev"
                "libxcb-randr0" "libxcb-randr0-dev"
                "libxcb-render0" "libxcb-render0-dev"
                "libxcb-xfixes0" "libxcb-xfixes0-dev"
                "libxcb-shape0" "libxcb-shape0-dev"
                "libxcb-sync1" "libxcb-sync-dev"
                "libxshmfence1" "libxshmfence-dev"
                "libxxf86vm1" "libxxf86vm-dev"
                "x11proto-xf86vidmode-dev"
                "libxrandr2" "libxrandr-dev"
                "x11proto-randr-dev"
                "libxrender1" "libxrender-dev"
                "x11proto-render-dev"
                )

ALL_PKGS_STR=`printf '%s\n' "${pkgs[@]}"`

apt-get download $ALL_PKGS_STR

if [ ! $? ]; then
    echo "Download packages error!"
    exit 1
fi

for entry in "."/*
do
    echo "Installing $entry ..."
    dpkg -x "$entry" ../$INSTALL_PATH

    if [ ! $? ]; then
        echo "Install $entry error!"
        exit 1
    fi
done

echo "Warning: You have to fix some dangling symbolic link in the $INSTALL_PATH yourself."
echo "Execute the following command to find them one the *host pc*, not pi."
echo "find YOUR_INSTALL_PATH -xtype l"
echo "Or execute fix-dangling-lib.sh in host-tools directory on the host machine."
