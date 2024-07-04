#!/bin/bash

# 检查 iperf3 是否安装
if ! command -v iperf3 &> /dev/null; then
    echo "iperf3 未安装. 正在尝试安装..."
    sudo apt-get update && sudo apt-get install -y iperf3 || sudo yum install -y iperf3
fi

# 启动 iperf3 服务器
echo "启动 iperf3 服务器..."
iperf3 -s -D

echo "iperf3 服务器已在后台启动。使用 'sudo killall iperf3' 来停止服务器。"
