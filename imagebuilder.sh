#!/bin/bash

mkdir -p files/etc/opkg/keys
git clone --depth=1 https://github.com/immortalwrt/keyring /workdir/keyring
cp /workdir/keyring/usign/* keys/
# cp /workdir/keyring/usign/* files/etc/opkg/keys/
# echo "src/gz immortalwrt_2102_packages https://downloads.immortalwrt.org/releases/21.02-SNAPSHOT/packages/aarch64_cortex-a53/packages" > files/etc/opkg/customfeeds.conf

echo "src from_sdk file:///workdir/sdk/bin/packages" >> repositories.conf.new
cat repositories.conf >> repositories.conf.new
echo "src/gz immortalwrt_packages https://downloads.immortalwrt.org/releases/21.02-SNAPSHOT/packages/aarch64_cortex-a53/packages" >> repositories.conf.new
# echo "src/gz immortalwrt_luci https://downloads.immortalwrt.org/releases/21.02-SNAPSHOT/packages/aarch64_cortex-a53/luci" >> repositories.conf.new
mv repositories.conf.new repositories.conf

make image PROFILE="xiaomi_redmi-router-ax6s" PACKAGES="libubox-lua -dnsmasq https://downloads.openwrt.org/snapshots/packages/aarch64_cortex-a53/base/dnsmasq-full_2.89-4_aarch64_cortex-a53.ipk luci luci-app-passwall luci-i18n-base-zh-cn luci-i18n-firewall-zh-cn luci-i18n-passwall-zh-cn" FILES="files"
