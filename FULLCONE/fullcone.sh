#!/bin/bash
#diff -rNEZbwBdu3 22 24 > update.patch
cd kernel
patch -Ntp1 < ../../fullcone.patch
cd ..
sed -i '/CONFIG_NETFILTER_XT_TARGET_HMARK/i\CONFIG_NETFILTER_XT_TARGET_FULLCONENAT=y' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
sed -i '/CONFIG_IP_NF_TARGET_NETMAP/i\CONFIG_IP_NF_TARGET_FULLCONENAT=y' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
exit 0
