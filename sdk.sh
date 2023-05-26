#!/bin/bash
make defconfig

echo "Generated .config >>>"
cat .config
echo ".config end <<<"

# IGNORE_ERRORS=1
make -j$(nproc) package/{luci-app-passwall,dnsmasq,smartdns,luci-app-smartdns}/compile || make -j1 package/{luci-app-passwall,dnsmasq,smartdns,luci-app-smartdns}/compile V=s
