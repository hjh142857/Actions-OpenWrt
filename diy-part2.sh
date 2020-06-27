#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

# 设置LAN IP为192.168.0.100
sed -i 's/192.168.1.1/192.168.0.100/g' package/base-files/files/bin/config_generate

# 设置LAN网关为192.168.0.1
sed -i "/\$ipad/a\\\t\t\t\tset network.\$1.gateway='192.168.0.1'" package/base-files/files/bin/config_generate

# 修改XXR+ Server默认监听IPv4成IPv6
sed -i 's/\"server\": \"0.0.0.0\",/\"server\": [\"[::0]\"],/g' package/feeds/helloworld/luci-app-ssr-plus/root/etc/init.d/shadowsocksr

# 取消XXR+订阅更新中Server项校验
sed -i "/result.alias = nil/a\\\tlocal server = result.server\n\tresult.server = nil" package/feeds/helloworld/luci-app-ssr-plus/root/usr/share/shadowsocksr/subscribe.lua
sed -i "/result.alias = alias/a\\\tresult.server = server" package/feeds/helloworld/luci-app-ssr-plus/root/usr/share/shadowsocksr/subscribe.lua
