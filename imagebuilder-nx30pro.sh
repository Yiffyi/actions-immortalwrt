#!/bin/bash
pkgs=(
    libubox-lua
    -dnsmasq dnsmasq-full
    tailscale
    smartdns luci-app-smartdns luci-i18n-smartdns-zh-cn
    luci-app-passwall luci-i18n-passwall-zh-cn kmod-nft-socket kmod-nft-tproxy kmod-nft-nat
    luci luci-i18n-base-zh-cn luci-i18n-opkg-zh-cn luci-i18n-firewall-zh-cn 
)

cp $GITHUB_WORKSPACE/mt7981b-h3c-magic-nx30-pro-112M.dts target/linux/mediatek/dts/mt7981b-h3c-magic-nx30-pro.dts

make image PROFILE="h3c_magic-nx30-pro" PACKAGES="${pkgs[*]}" FILES="files"
