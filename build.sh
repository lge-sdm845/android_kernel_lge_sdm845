#!/bin/bash

echo "1. judyln"
echo "2. judypn"
echo "3. judyp"
echo "4. exit"
read -r -p "Choose a device (1-4): " choice

case $choice in
  1)
    device="judyln"
    ;;
  2)
    device="judypn"
    ;;
  3)
    device="judyp"
    ;;
  *)
    exit 1
    ;;
esac

echo -e "[*] Building for ${device}."
echo -e "[*] Make sure the clang-proton folder is in the root of you home directory."
echo -e "[*] Checking for toolchain path..."

if [ ! -d "/home/$(whoami)/clang-proton" ]; then
  echo -e "[!] Could not find clang-proton in home directory. Please check path or" \
          "clone the toolchain into your home folder as clang-proton"
  exit 1
fi

export ARCH=arm64
make O=out lineageos_${device}_defconfig
PATH="/home/$(whoami)/clang-proton/bin:/home/juleast/clang-proton/aarch64-linux-gnu/bin:${PATH}"
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC="ccache clang" \
                      CROSS_COMPILE=aarch64-linux-gnu- \
                      CROSS_COMPILE_ARM32=arm-linux-gnueabi-

echo -e "[*] Done. If the build was successful, please check out."
