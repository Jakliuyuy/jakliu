#!/bin/sh
set -e

# 临时目录
TMP_DIR="/tmp"

# 依赖安装
echo "更新 opkg 并安装依赖..."
opkg update
opkg install bash iptables dnsmasq-full curl ca-bundle ipset ip-full iptables-mod-tproxy iptables-mod-extra ruby ruby-yaml kmod-tun kmod-inet-diag unzip luci-compat luci luci-base -y

# 下载 OpenClash ipk
echo "下载 OpenClash ipk..."
curl -L -A "Mozilla/5.0" -o $TMP_DIR/openclash.ipk https://github.com/vernesong/OpenClash/releases/download/v0.47.001/luci-app-openclash_0.47.001_all.ipk

# 安装 OpenClash ipk
echo "安装 OpenClash ipk..."
opkg install $TMP_DIR/openclash.ipk

# 下载 Clash 内核
CLASH_DIR="/etc/openclash/core"
mkdir -p $CLASH_DIR
echo "下载 Clash 内核..."
curl -L -A "Mozilla/5.0" -o $TMP_DIR/clash-linux-armv8.tar.gz https://github.com/vernesong/OpenClash/releases/download/Clash/clash-linux-armv8.tar.gz

# 解压内核到指定目录
echo "解压 Clash 内核..."
tar -xzvf $TMP_DIR/clash-linux-armv8.tar.gz -C $CLASH_DIR

# 设置权限
echo "设置权限..."
chmod +x $CLASH_DIR/clash

echo "OpenClash 安装完成！请前往 LuCI 界面启用 OpenClash。"
