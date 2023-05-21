#!/bin/bash

./scripts/feeds update -a && ./scripts/feeds install luci-app-passwall

make defconfig
IGNORE_ERRORS=1 make -j || make -j1 V=s
