#!/bin/bash
make defconfig
# IGNORE_ERRORS=1
make -j$(nproc) package/luci-app-passwall/compile package/dnsmasq/compile || make -j1 package/luci-app-passwall/compile package/dnsmasq/compile V=s
