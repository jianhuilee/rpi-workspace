#!/bin/sh

cd $ROOT_PATH/source/drm
$ROOT_PATH/host-tools/pi2meson
env DESTDIR=$ROOT_PATH/install ninja -C build/ install

cd -
