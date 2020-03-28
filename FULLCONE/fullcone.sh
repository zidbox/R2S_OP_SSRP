#!/bin/bash
#diff -rNEZbwBdu3 22 24 > update.patch
cd kernel
patch -Ntp1 < ../../fullcone.patch
cd ..
sed -i '/CONFIG_NETFILTER_XT_TARGET_HMARK/i\CONFIG_NETFILTER_XT_TARGET_FULLCONENAT=m' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
exit 0
