echo "src/gz immortalwrt_2102_packages https://downloads.immortalwrt.org/releases/21.02-SNAPSHOT/packages/aarch64_cortex-a53/packages" | cat - /workdir/imgbuilder/repositories.conf > /workdir/imgbuilder/repositories.conf.new
mv /workdir/imgbuilder/repositories.conf.new /workdir/imgbuilder/repositories.conf

git clone --depth=1 https://github.com/immortalwrt/keyring /workdir/keyring
rm -r keys && ln -sf /workdir/keyring/usign keys

make image PROFILE="xiaomi_redmi-router-ax6s" PACKAGES="libubox-lua luci luci-app-passwall luci-i18n-base-zh-cn luci-i18n-firewall-zh-cn luci-i18n-passwall-zh-cn" FILES="files"
