#!/bin/bash
cd kernel
wget https://github.com/armbian/build/raw/master/patch/kernel/rockchip64-dev/RK3328-enable-1512mhz-opp.patch
git apply RK3328-enable-1512mhz-opp.patch
cd ../
git clone https://git.openwrt.org/openwrt/openwrt.git
rm openwrt/target/linux/generic/pending-5.4/403-mtd-hook-mtdsplit-to-Kbuild.patch
rm openwrt/target/linux/generic/hack-5.4/700-swconfig_switch_drivers.patch
friendlywrt/scripts/patch-kernel.sh kernel openwrt/target/linux/generic/backport-5.4
friendlywrt/scripts/patch-kernel.sh kernel openwrt/target/linux/generic/pending-5.4
friendlywrt/scripts/patch-kernel.sh kernel openwrt/target/linux/generic/hack-5.4
bash ../fullcone.sh
wget https://github.com/torvalds/linux/raw/master/scripts/kconfig/merge_config.sh && chmod +x merge_config.sh
grep -i '_NETFILTER_\|FLOW' ../.config.override > .config.override
./merge_config.sh -m .config.override kernel/arch/arm64/configs/nanopi-r2_linux_defconfig && mv .config kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i -r 's/# (CONFIG_.*_ERRATUM_.*?) is.*/\1=y/g' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i 's/CONFIG_BPFILTER=y/CONFIG_BPFILTER=n/' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i 's/CONFIG_NFT_FLOW_OFFLOAD=m/CONFIG_NFT_FLOW_OFFLOAD=y/' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
echo "CONFIG_NETFILTER_XT_TARGET_FLOWOFFLOAD=m" >> kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
