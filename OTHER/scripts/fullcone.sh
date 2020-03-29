#!/bin/sh
sleep 300
/sbin/insmod xt_FULLCONENAT.ko
/etc/init.d/firewall reload
done
