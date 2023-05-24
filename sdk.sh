#!/bin/bash
make defconfig

echo Generated .config
cat .config

# IGNORE_ERRORS=1
make -j$(nproc) package/luci-app-passwall/compile || make -j1 package/luci-app-passwall/compile V=s
