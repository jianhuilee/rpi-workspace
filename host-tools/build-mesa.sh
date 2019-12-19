#!/bin/sh

cd $ROOT_PATH/source/mesa
$ROOT_PATH/host-tools/pi2meson \
  -Dtexture-float=true \
  -Ddri-drivers= \
  -Dgallium-drivers=vc4,swrast \
  -Dvulkan-drivers= \
  -Dllvm=false \
  -Dplatforms=x11,drm,surfaceless \
  -Dlibunwind=false \
  -Dllvm=false \
  "$@"

env DESTDIR=$ROOT_PATH/install ninja -C build/ install

cd -
