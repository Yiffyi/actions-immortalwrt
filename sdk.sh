#!/bin/bash

./scripts/feeds update -a && ./scripts/feeds install luci-app-passwall
make defconfig
cat .config
# IGNORE_ERRORS=1
make -j$(nproc) package/luci-app-passwall/compile || make -j1 package/luci-app-passwall/compile V=s
