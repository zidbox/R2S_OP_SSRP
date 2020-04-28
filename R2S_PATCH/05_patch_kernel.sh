#!/bin/bash
#enable 1512mhz
cd kernel
wget https://github.com/armbian/build/raw/master/patch/kernel/rockchip64-dev/RK3328-enable-1512mhz-opp.patch
git apply RK3328-enable-1512mhz-opp.patch
#rebase kernel
git config --local user.email "action@github.com" && git config --local user.name "GitHub Action"
git remote add upstream https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git && git fetch upstream
git rebase 400467c^ --onto upstream/linux-5.4.y -X theirs
rm -f ./arch/arm64/configs/nanopi-r2_linux_defconfig
wget -O arch/arm64/configs/nanopi-r2_linux_defconfig https://raw.githubusercontent.com/fanck0605/friendlywrt-kernel/nanopi-r2-v5.4.y/arch/arm64/configs/nanopi-r2_linux_defconfig
#apply openwrt patch
cd ../
git clone https://git.openwrt.org/openwrt/openwrt.git --depth=1
cd openwrt
./scripts/patch-kernel.sh ../kernel ./target/linux/generic/backport-5.4
./scripts/patch-kernel.sh ../kernel ./target/linux/generic/pending-5.4
./scripts/patch-kernel.sh ../kernel ./target/linux/generic/hack-5.4
./scripts/patch-kernel.sh ../kernel ./target/linux/octeontx/patches-5.4
cp -a ./target/linux/generic/files/* ../kernel/
cd ../
#fullcone patch
cd kernel/
wget -O net/netfilter/xt_FULLCONENAT.c https://raw.githubusercontent.com/Chion82/netfilter-full-cone-nat/master/xt_FULLCONENAT.c
git apply ../../FULLCONE/001-kernel-add-full_cone_nat.patch
exit 0
