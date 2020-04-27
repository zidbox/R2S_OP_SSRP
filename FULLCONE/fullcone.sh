#!/bin/bash
#diff -rNEZbwBdu3 22 24 > update.patch
cd kernel
wget -O net/netfilter/xt_FULLCONENAT.c https://raw.githubusercontent.com/Chion82/netfilter-full-cone-nat/master/xt_FULLCONENAT.c
git apply ../../FULLCONE/001-kernel-add-full_cone_nat.patch
exit 0
