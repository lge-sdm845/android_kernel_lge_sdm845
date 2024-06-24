#!/bin/bash

export ARCH=arm64
make O=out lineageos_judyln_defconfig
PATH="/home/juleast/clang-proton/bin:/home/juleast/clang-proton/aarch64-linux-gnu/bin:${PATH}"
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC="ccache clang" \
                      CROSS_COMPILE=aarch64-linux-gnu- \
                      CROSS_COMPILE_ARM32=arm-linux-gnueabi-