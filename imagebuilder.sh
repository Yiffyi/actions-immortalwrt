#!/bin/bash
make image PROFILE="xiaomi_redmi-router-ax6s" PACKAGES="libubox-lua -dnsmasq dnsmasq-full luci luci-app-passwall luci-i18n-base-zh-cn luci-i18n-firewall-zh-cn luci-i18n-passwall-zh-cn" FILES="files"
