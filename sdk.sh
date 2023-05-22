#!/bin/bash
make defconfig
# IGNORE_ERRORS=1
make -j$(nproc) package/luci-app-passwall/compile package/dnsmasq-full/compile || make -j1 package/luci-app-passwall/compile package/dnsmasq-full/compile V=s
