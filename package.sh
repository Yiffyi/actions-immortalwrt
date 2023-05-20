#!/bin/bash
make defconfig
make -j package/luci-app-passwall/compile || make -j1 package/luci-app-passwall/compile V=s
