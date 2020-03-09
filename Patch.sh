#!/bin/bash
#diff -rNEZbwBdu3 22 24 > update.patch
cd kernel
patch -Ntp1 < ../../update.patch
cd ..
exit 0
