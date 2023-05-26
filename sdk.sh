#!/bin/bash
make defconfig

echo "Generated .config >>>"
cat .config
echo ".config end <<<"

# IGNORE_ERRORS=1
make -j$(nproc) || make -j1 V=s
