#!/bin/bash
./scripts/feeds install luci-app-passwall2

make defconfig

echo "Generated .config >>>"
cat .config
echo ".config end <<<"

# IGNORE_ERRORS=1
make -j$(nproc) package/luci-app-passwall2/compile || make -j1 package/luci-app-passwall2/compile V=s
