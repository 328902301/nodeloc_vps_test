#!/bin/bash

# 检查是否以 root 权限运行
if [ "$EUID" -ne 0 ]; then
  echo "请以 root 权限运行此脚本"
  exit 1
fi

# 检查 iperf3 是否安装
if ! command -v iperf3 &> /dev/null; then
    echo "iperf3 未安装. 正在尝试安装..."
    if command -v apt-get &> /dev/null; then
        apt-get update && apt-get install -y iperf3
    elif command -v yum &> /dev/null; then
        yum install -y iperf3
    else
        echo "无法安装 iperf3。请手动安装。"
        exit 1
    fi
fi

# 创建 systemd 服务文件
cat << EOF > /etc/systemd/system/iperf3-server.service
[Unit]
Description=iperf3 Server
After=network.target

[Service]
ExecStart=/usr/bin/iperf3 -s
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

# 重新加载 systemd，启用并启动服务
systemctl daemon-reload
systemctl enable iperf3-server.service
systemctl start iperf3-server.service

echo "iperf3 服务器已设置为在后台运行，并将在系统重启后自动启动。"
echo "使用以下命令管理服务："
echo "  启动: systemctl start iperf3-server"
echo "  停止: systemctl stop iperf3-server"
echo "  重启: systemctl restart iperf3-server"
echo "  查看状态: systemctl status iperf3-server"
