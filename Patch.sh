#!/bin/bash
#diff -rNEZbwBdu3 22 24 > update.patch
mv ../update.patch ./ && cd kernel/ && patch -Np1 < ../update.patch
exit 0