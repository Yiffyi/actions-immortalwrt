#!/bin/bash
exit
./scripts/feeds update -a && ./scripts/feeds install luci-app-passwall

make defconfig
make -j package/luci-app-passwall/compile || make -j1 package/luci-app-passwall/compile V=s
