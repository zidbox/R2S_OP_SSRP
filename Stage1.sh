#!/bin/bash
clear
git clone -b master https://github.com/QiuSimons/R2S_PATCH.git ./R2S_TMP
cp -r ./R2S_TMP/. ./R2S_PATCH
mkdir friendlywrt-rk3328
pushd friendlywrt-rk3328
repo init -u https://github.com/friendlyarm/friendlywrt_manifests -b master-v19.07.1 -m rk3328.xml --repo-url=https://github.com/friendlyarm/repo  --no-clone-bundle
repo sync -c  --no-clone-bundle
popd
pushd friendlywrt-rk3328/friendlywrt
shopt -s extglob 
rm --recursive --force !(dl)
rm .*
popd
latest_release="$(curl -s https://github.com/openwrt/openwrt/releases |grep -Eo "v[0-9\.]+.tar.gz" |sed -n 1p)"
curl -LO "https://github.com/openwrt/openwrt/archive/${latest_release}"
tar zxvf ${latest_release}  --strip-components 1 -C ./friendlywrt-rk3328/friendlywrt
rm -f ./friendlywrt-rk3328/friendlywrt/feeds.conf.default
wget -P friendlywrt-rk3328/friendlywrt/ https://raw.githubusercontent.com/openwrt/openwrt/openwrt-19.07/feeds.conf.default
rm -f ${latest_release}
rm -rf ./R2S_PATCH/.git
cp -rf ./R2S_PATCH/. ./friendlywrt-rk3328/friendlywrt/
cd friendlywrt-rk3328
sed -i 's,./scripts,#./scripts,g' scripts/mk-friendlywrt.sh
#git clone -b linux-5.4.y https://github.com/gregkh/linux.git
#git clone -b master https://github.com/QiuSimons/Kernel_Patch_RK3328_5.4.y.git
#rm -rf ./kernel/.
#cp -rf ./Kernel_Patch_RK3328_5.4.y/. ./linux
#rm -rf ./Kernel_Patch_RK3328_5.4.y
#cp -rf ./linux/. ./kernel
#rm -rf ./linux
sed -i 's,CONFIG_BPFILTER=y,CONFIG_BPFILTER=n,g' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
pushd friendlywrt
#bash OpenPatch.sh
popd
#./scripts/build.sh nanopi_r2s.mk
exit 0
