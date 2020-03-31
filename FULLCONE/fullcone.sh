#!/bin/bash
#diff -rNEZbwBdu3 22 24 > update.patch
cd kernel
patch -Ntp1 < ../../fullcone.patch
patch -Ntp1 < ../../952-net-conntrack-events-support-multiple-registrant.patch
patch -Ntp1 < ../../000-printk.patch
cd ..
sed -i '/CONFIG_BLK_DEV_IO_TRACE/a\CONFIG_NETFILTER_XT_TARGET_FULLCONENAT=m' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
exit 0
