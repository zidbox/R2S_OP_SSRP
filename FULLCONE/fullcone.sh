#!/bin/bash
#diff -rNEZbwBdu3 22 24 > update.patch
cd kernel
patch -Ntp1 < ../../fullcone.patch
cd ..
sed -i '/CONFIG_BLK_DEV_IO_TRACE/a\CONFIG_NETFILTER_XT_TARGET_FULLCONENAT=y' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
exit 0
