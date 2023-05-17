#!/bin/sh
echo -e "$(nproc) thread compile"
make defconfig
make -j$(nproc) package/luci-app-passwall/compile
