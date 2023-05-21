#!/bin/bash

./scripts/feeds update -a && ./scripts/feeds install luci-app-passwall

make defconfig
IGNORE_ERRORS=1 make -j IGNORE_ERRORS=m package/luci-app-passwall/compile || make -j1 package/luci-app-passwall/compile V=s
