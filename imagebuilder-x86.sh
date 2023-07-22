#!/bin/bash
pkgs=(
    libubox-lua
    -dnsmasq dnsmasq-full
    smartdns luci-app-smartdns luci-i18n-smartdns-zh-cn
    luci-app-passwall luci-i18n-passwall-zh-cn kmod-nft-socket kmod-nft-tproxy kmod-nft-nat
    luci luci-i18n-base-zh-cn luci-i18n-opkg-zh-cn luci-i18n-firewall-zh-cn 
)

make image PROFILE="openwrt-x86-64-generic" PACKAGES="${pkgs[*]}" FILES="files"
