#!/bin/bash

./scripts/feeds update -a && ./scripts/feeds install luci-app-passwall

make defconfig
make -j IGNORE_ERRORS=m package/luci-app-passwall/compile || make -j1 IGNORE_ERRORS=m package/luci-app-passwall/compile V=s
