#!/bin/bash
clear
./scripts/feeds update -a && ./scripts/feeds install -a
#RPCD依赖
rm -rf ./package/system/rpcd
svn co https://github.com/openwrt/openwrt/branches/openwrt-19.07/package/system/rpcd package/system/rpcd
#AutoCore
svn co https://github.com/project-openwrt/openwrt-19.07/trunk/package/lean/autocore package/lean/autocore
svn co https://github.com/project-openwrt/openwrt-19.07/trunk/package/lean/coremark package/lean/coremark
#网易云解锁
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/UnblockNeteaseMusicGo package/lean/UnblockNeteaseMusicGo
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-unblockmusic package/lean/luci-app-unblockmusic
sed -i "s,+UnblockNeteaseMusic_NodeJS:UnblockNeteaseMusic ,,g" package/lean/luci-app-unblockmusic/Makefile
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-lib-fs package/lean/luci-lib-fs
#irqbalance
sed -i 's/0/1/g' feeds/packages/utils/irqbalance/files/irqbalance.config
#定时重启
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-autoreboot package/lean/luci-app-autoreboot
#主题
git clone -b master --single-branch https://github.com/QiuSimons/Luci-argon-19 package/new/luci-theme-argon
#git clone -b master --single-branch https://github.com/jerrykuku/luci-theme-argon package/new/luci-theme-argon
#AdGuard
git clone -b master --single-branch https://github.com/rufengsuixing/luci-app-adguardhome package/new/luci-app-adguardhome
#SSRP
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-ssr-plus package/lean/luci-app-ssr-plus
sed -i 's,mux = 1,mux = 0,g' package/lean/luci-app-ssr-plus/root/usr/share/shadowsocksr/subscribe.lua
sed -i "s,'uci','luci.model.uci',g" package/lean/luci-app-ssr-plus/root/usr/share/shadowsocksr/subscribe.lua
sed -i 's,local ucic = uci.cursor(),local ucic = luci.model.uci.cursor(),g' package/lean/luci-app-ssr-plus/root/usr/share/shadowsocksr/subscribe.lua
rm -f ./package/lean/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/client.lua
wget -P ./package/lean/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr https://raw.githubusercontent.com/QiuSimons/SSR_PATCH/master/luasrc/model/cbi/shadowsocksr/client.lua
rm -f ./package/lean/luci-app-ssr-plus/root/usr/share/shadowsocksr/genv2config.lua
wget -P ./package/lean/luci-app-ssr-plus/root/usr/share/shadowsocksr https://raw.githubusercontent.com/QiuSimons/SSR_PATCH/master/root/usr/share/shadowsocksr/genv2config.lua
#SSRP依赖
rm -rf ./feeds/packages/net/kcptun
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/shadowsocksr-libev package/lean/shadowsocksr-libev
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/pdnsd-alt package/lean/pdnsd
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/v2ray package/lean/v2ray
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/trojan package/lean/trojan
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ipt2socks package/lean/ipt2socks
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/kcptun package/lean/kcptun
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/simple-obfs package/lean/simple-obfs
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/v2ray-plugin package/lean/v2ray-plugin
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/srelay package/lean/srelay
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/microsocks package/lean/microsocks
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/dns2socks package/lean/dns2socks
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/redsocks2 package/lean/redsocks2
#订阅转换
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/subconverter package/new/subconverter
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/jpcre2 package/new/jpcre2
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/rapidjson package/new/rapidjson
#清理内存
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-ramfree package/lean/luci-app-ramfree
#打印机
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-usb-printer package/lean/luci-app-usb-printer
#流量监视
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-wrtbwmon package/lean/luci-app-wrtbwmon
#流量监管
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-netdata package/lean/luci-app-netdata
#OpenClash
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/new/luci-app-openclash
#SeverChan
git clone -b master --single-branch https://github.com/tty228/luci-app-serverchan package/new/luci-app-serverchan
#SmartDNS
svn co https://github.com/pymumu/smartdns/trunk/package/openwrt package/new/smartdns/smart-op
svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/luci-app-smartdns package/new/smartdns/smart-luci
#上网APP过滤
git clone -b master --single-branch https://github.com/destan19/OpenAppFilter package/new/OpenAppFilter
#BBR_Patch
wget -P target/linux/generic/pending-4.14/ https://raw.githubusercontent.com/QiuSimons/Others/master/607-tcp_bbr-adapt-cwnd-based-on-ack-aggregation-estimation.patch
#FullCone补丁
# FullCone 
git clone -b master --single-branch https://github.com/QiuSimons/openwrt-fullconenat package/fullconenat
# FireWall Patch
mkdir package/network/config/firewall/patches
wget -P package/network/config/firewall/patches/ https://github.com/LGA1150/fullconenat-fw3-patch/raw/master/fullconenat.patch
# Patch LuCI
pushd feeds/luci
wget -O- https://github.com/LGA1150/fullconenat-fw3-patch/raw/master/luci.patch | git apply
popd
# Patch Kernel
pushd target/linux/generic/hack-4.14
wget https://github.com/coolsnowwolf/lede/raw/master/target/linux/generic/hack-4.14/952-net-conntrack-events-support-multiple-registrant.patch
wget https://github.com/coolsnowwolf/lede/raw/master/target/linux/generic/hack-4.14/202-reduce_module_size.patch
popd
#最大连接
sed -i 's/16384/65536/g' package/kernel/linux/files/sysctl-nf-conntrack.conf
#翻译
git clone -b master --single-branch https://github.com/QiuSimons/addition-trans-zh package/lean/lean-translate
chmod -R 755 ./
#生成默认配置及缓存
rm -rf .config
mv R2.config .config
#修正架构
sed -i "s,boardinfo.system,'ARMv8',g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
exit 0
