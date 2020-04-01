#!/bin/bash
clear
cp -r ./FULLCONE/. ./
cp -r ./SEED/. ./
cp -r ./OTHER/. ./
git clone -b master https://github.com/QiuSimons/R2S_PATCH.git ./R2S_TMP
cp -r ./R2S_TMP/. ./R2S_PATCH
mkdir friendlywrt-rk3328
cd friendlywrt-rk3328
repo init -u https://github.com/friendlyarm/friendlywrt_manifests -b master-v19.07.1 -m rk3328.xml --repo-url=https://github.com/friendlyarm/repo --no-clone-bundle --depth=1
repo sync -c --no-tags --no-clone-bundle -j8
latest_feed="$(curl -s https://github.com/openwrt/openwrt/releases |grep -Eo "v[0-9\.]+.tar.gz" |sed -n 1p |sed 's/v//g' |sed 's/.tar.gz//g')"
sed -i 's,19.07.1,'"${latest_feed}"',g' device/friendlyelec/rk3328/common-files/etc/opkg/distfeeds.conf
cd friendlywrt
shopt -s extglob 
rm --recursive --force !(dl)
rm .*
cd ..
cd ..
latest_release="$(curl -s https://github.com/openwrt/openwrt/releases |grep -Eo "v[0-9\.]+.tar.gz" |sed -n 1p)"
curl -LO "https://github.com/openwrt/openwrt/archive/${latest_release}"
tar zxvf ${latest_release}  --strip-components 1 -C ./friendlywrt-rk3328/friendlywrt
rm -f ./friendlywrt-rk3328/friendlywrt/feeds.conf.default
wget -P friendlywrt-rk3328/friendlywrt/ https://raw.githubusercontent.com/openwrt/openwrt/openwrt-19.07/feeds.conf.default
rm -f ${latest_release}
rm -rf ./R2S_PATCH/.git
cp -rf ./R2S_PATCH/. ./friendlywrt-rk3328/friendlywrt/
cp -f ./R2S_PATCH/05_patch_kernel.sh ./friendlywrt-rk3328/05_patch_kernel.sh
cd friendlywrt-rk3328
sed -i 's,./scripts,#./scripts,g' scripts/mk-friendlywrt.sh
sed -i 's/set -eu/set -u/' scripts/mk-friendlywrt.sh
exit 0
