#!/bin/bash
make image PROFILE="xiaomi_redmi-router-ax6s" PACKAGES="libubox-lua smartdns kmod-nft-socket kmod-nft-tproxy kmod-nft-nat luci luci-app-passwall luci-i18n-base-zh-cn luci-i18n-opkg-zh-cn luci-i18n-firewall-zh-cn luci-i18n-passwall-zh-cn" FILES="files"
