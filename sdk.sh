#!/bin/bash

./scripts/feeds update -a && ./scripts/feeds install luci-app-passwall
echo Before defconfig
cat .config

make defconfig

echo After defconfig
cat .config

# IGNORE_ERRORS=1
make -j$(nproc) package/luci-app-passwall/compile || make -j1 package/luci-app-passwall/compile V=s
