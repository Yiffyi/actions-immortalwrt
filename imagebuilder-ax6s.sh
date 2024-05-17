#!/bin/bash
pkgs=(
    -dnsmasq dnsmasq-full
    luci-app-passwall luci-i18n-passwall-zh-cn
    luci luci-i18n-base-zh-cn luci-i18n-opkg-zh-cn luci-i18n-firewall-zh-cn 
)

make image PROFILE="xiaomi_redmi-router-ax6s" PACKAGES="${pkgs[*]}" FILES="files"
