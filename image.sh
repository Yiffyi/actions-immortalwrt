#!/bin/bash

git clone --depth=1 https://github.com/immortalwrt/keyring /workdir/keyring
rm -r keys && ln -sf /workdir/keyring/usign keys

echo "src/gz immortalwrt_2102_packages https://downloads.immortalwrt.org/releases/21.02-SNAPSHOT/packages/aarch64_cortex-a53/packages" > repositories.conf.new
echo "src from_sdk file:///workdir/sdk/bin/packages" >> repositories.conf.new
cat repositories.conf >> repositories.conf.new
mv repositories.conf.new repositories.conf

mkdir -p files/etc/opkg/keys
echo "src/gz immortalwrt_2102_packages https://downloads.immortalwrt.org/releases/21.02-SNAPSHOT/packages/aarch64_cortex-a53/packages" > files/etc/opkg/customfeeds.conf
cp /workdir/keyring/usign/*  files/etc/opkg/keys

make image PROFILE="xiaomi_redmi-router-ax6s" PACKAGES="libubox-lua luci luci-app-passwall luci-i18n-base-zh-cn luci-i18n-firewall-zh-cn luci-i18n-passwall-zh-cn" FILES="files"
