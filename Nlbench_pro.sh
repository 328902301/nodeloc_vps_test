#!/bin/bash

# 定义版本
VERSION="1.0.2"

# 定义颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查 root 权限并获取 sudo 权限
check_root() {
    if [ "$(id -u)" != "0" ]; then
        echo "此脚本需要 root 权限运行。"
        if ! sudo -v; then
            echo "无法获取 sudo 权限，退出脚本。"
            exit 1
        fi
        echo "已获取 sudo 权限。"
    fi
}

# 检查并安装依赖
install_dependencies() {
    echo -e "${YELLOW}正在检查并安装必要的依赖项...${NC}"
    
    # 更新包列表
    if ! sudo apt-get update; then
        echo -e "${RED}无法更新包列表。请检查您的网络连接和系统设置。${NC}"
        exit 1
    fi
    
    # 安装依赖
    local dependencies=(
        "curl"
        "wget"
        "iperf3"
    )
    
    for dep in "${dependencies[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            echo -e "${YELLOW}正在安装 $dep...${NC}"
            if ! sudo apt-get install -y "$dep"; then
                echo -e "${RED}无法安装 $dep。请手动安装此依赖项。${NC}"
            fi
        else
            echo -e "${GREEN}$dep 已安装。${NC}"
        fi
    done
    
    echo -e "${GREEN}依赖项检查和安装完成。${NC}"
}

# 获取IP地址
ip_address() {
    ipv4_address=$(curl -s --max-time 5 ipv4.ip.sb)
    if [ -z "$ipv4_address" ]; then
        ipv4_address=$(ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v '127.0.0.1' | head -n1)
    fi

    ipv6_address=$(curl -s --max-time 5 ipv6.ip.sb)
    if [ -z "$ipv6_address" ]; then
        ipv6_address=$(ip -6 addr show | grep -oP '(?<=inet6\s)[\da-f:]+' | grep -v '^::1' | grep -v '^fe80' | head -n1)
    fi
}

# 检测VPS地理位置
detect_region() {
    local country
    country=$(curl -s ipinfo.io/country)
    case $country in
        "TW") echo "1" ;;          # 台湾
        "HK") echo "2" ;;          # 香港
        "JP") echo "3" ;;          # 日本
        "US" | "CA") echo "4" ;;   # 北美
        "BR" | "AR" | "CL") echo "5" ;;  # 南美
        "GB" | "DE" | "FR" | "NL" | "SE" | "NO" | "FI" | "DK" | "IT" | "ES" | "CH" | "AT" | "BE" | "IE" | "PT" | "GR" | "PL" | "CZ" | "HU" | "RO" | "BG" | "HR" | "SI" | "SK" | "LT" | "LV" | "EE") echo "6" ;;  # 欧洲
        "AU" | "NZ") echo "7" ;;   # 大洋洲
        "KR") echo "8" ;;          # 韩国
        "SG" | "MY" | "TH" | "ID" | "PH" | "VN") echo "9" ;;  # 东南亚
        "IN") echo "10" ;;         # 印度
        "ZA" | "NG" | "EG" | "KE" | "MA" | "TN" | "GH" | "CI" | "SN" | "UG" | "ET" | "MZ" | "ZM" | "ZW" | "BW" | "MW" | "NA" | "RW" | "SD" | "DJ" | "CM" | "AO") echo "11" ;;  # 非洲
        *) echo "0" ;;             # 跨国平台
    esac
}

# 统计使用次数
sum_run_times() {
    local COUNT
    COUNT=$(wget --no-check-certificate -qO- --tries=2 --timeout=2 "https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https://github.com/everett7623/nodeloc_vps_test/edit/main/Nlbench.sh" 2>&1 | grep -m1 -oE "[0-9]+[ ]+/[ ]+[0-9]+")
    if [[ -n "$COUNT" ]]; then
        daily_count=$(cut -d " " -f1 <<< "$COUNT")
        total_count=$(cut -d " " -f3 <<< "$COUNT")
    else
        echo "Failed to fetch usage counts."
        daily_count=0
        total_count=0
    fi
}

# 去除Yabs板块ANSI转义码
yabs_process_output() {
    local input="$1"
    echo "$input" | sed -E 's/\x1b\[[0-9;]*[a-zA-Z]//g'
}

# 去除融合怪板块ANSI转义码并截取
fusion_process_output() {
    local input="$1"
    echo "$input" | sed -E 's/\x1b\[[0-9;]*[a-zA-Z]//g' | awk '/A Bench Script/{f=1} f; /短链/{f=0}'
}

# 去除IP质量板块ANSI转义码并截取
ip_process_output() {
    local input="$1"
    local start_line=$(echo "$input" | grep -n '正在检测黑名单数据库' | tail -n 1 | cut -d ':' -f 1)
    start_line=$((start_line + 1))  # 移动到下一行
    local end_line=$(echo "$input" | grep -n '按回车键返回主菜单' | head -n 1 | cut -d ':' -f 1)
    
    if [ -n "$start_line" ] && [ -n "$end_line" ]; then
        tail -n +"$start_line" <<< "$input" | head -n $(($end_line - $start_line)) | sed -E 's/\x1b\[[0-9;]*[a-zA-Z]//g'
    elif [ -n "$start_line" ]; then
        tail -n +"$start_line" <<< "$input" | sed -E 's/\x1b\[[0-9;]*[a-zA-Z]//g'
    else
        echo "未找到合适的日志内容。"
    fi
}

# 去除流媒体板块ANSI转义码并截取
streaming_process_output() {
    local input="$1"
    echo "$input" | sed -E 's/\x1b\[[0-9;]*[a-zA-Z]//g' | awk '/项目地址/{f=1} f; /检测脚本当天运行次数/{f=0}'
}

# 去除响应板块ANSI转义码
response_process_output() {
    local input="$1"
    echo "$input" | sed -E 's/\x1b\[[0-9;]*[a-zA-Z]//g'
}

# 去除三网测速板块ANSI转义码并截取
speedtest_process_output() {
    local input="$1"
    echo "$input" | sed -E 's/\x1b\[[0-9;]*[a-zA-Z]//g'
}

# 去除回程路由板块ANSI转义码并截取
autotrace_process_output() {
    local input="$1"
    echo "$input" | sed -E 's/\x1b\[[0-9;]*[a-zA-Z]//g' | awk '/No:1\/9 Traceroute to 中国/{f=1} f; /\[信息\] 已删除 Nexttrace 文件/{f=0}'
}

# 执行测试脚本并保存结果
run_test() {
    local script=$1
    local output_file=$2
    local temp_file=$(mktemp)

    case $script in
        1)
            echo "执行 Yabs 测试..."
            wget -qO- yabs.sh | bash > "$temp_file" 2>&1
            yabs_process_output "$(cat "$temp_file")" > "${output_file}_yabs"
            ;;
        2)
            echo "执行融合怪测试..."
            curl -L https://gitlab.com/spiritysdx/za/-/raw/main/ecs.sh -o ecs.sh && chmod +x ecs.sh && bash ecs.sh > "$temp_file" 2>&1
            fusion_process_output "$(cat "$temp_file")" > "${output_file}_ecs"
            ;;
        3)
            echo "执行 IP 质量测试..."
            bash <(curl -Ls IP.Check.Place) > "$temp_file" 2>&1
            ip_process_output "$(cat "$temp_file")" > "${output_file}_ip_quality"
            ;;
        4)
            echo "执行流媒体解锁测试..."
            region=$(detect_region)
            bash <(curl -L -s media.ispvps.com) <<< "$region" > "$temp_file" 2>&1
            streaming_process_output "$(cat "$temp_file")" > "${output_file}_streaming"
            ;;
        5)
            echo "执行响应测试..."
            bash <(curl -sL https://nodebench.mereith.com/scripts/curltime.sh) > "$temp_file" 2>&1
            response_process_output "$(cat "$temp_file")" > "${output_file}_response"
            ;;
        6)
            echo "执行三网测速（多线程）..."
            bash <(curl -sL bash.icu/speedtest) <<< "1" > "$temp_file" 2>&1
            speedtest_process_output "$(cat "$temp_file")" > "${output_file}_multi_thread"
            ;;
        7)
            echo "执行三网测速（单线程）..."
            bash <(curl -sL bash.icu/speedtest) <<< "2" > "$temp_file" 2>&1
            speedtest_process_output "$(cat "$temp_file")" > "${output_file}_single_thread"
            ;;
        8)
            echo "执行回程路由测试..."
            wget -N --no-check-certificate https://raw.githubusercontent.com/Chennhaoo/Shell_Bash/master/AutoTrace.sh && chmod +x AutoTrace.sh && bash AutoTrace.sh <<< "1" > "$temp_file" 2>&1
            autotrace_process_output "$(cat "$temp_file")" > "${output_file}_route"
            ;;
    esac

    rm "$temp_file"
}

# 格式化结果为 Markdown
format_results() {

local output_file=$1
local processed_yabs_result=$(yabs_process_output "$(cat "${output_file}_yabs")")
local processed_fusion_result=$(fusion_process_output "$(cat "${output_file}_ecs")")
local processed_ip_result=$(ip_process_output "$(cat "${output_file}_ip_quality")")
local processed_streaming_result=$(streaming_process_output "$(cat "${output_file}_streaming")")
local processed_response_result=$(response_process_output "$(cat "${output_file}_response")")
local processed_speedtest_multi_result=$(speedtest_process_output "$(cat "${output_file}_multi_thread")")
local processed_speedtest_single_result=$(speedtest_process_output "$(cat "${output_file}_single_thread")")
local processed_autotrace_result=$(autotrace_process_output "$(cat "${output_file}_route")")

# Tabs分栏输出结果，用于复制到Nodeloc论坛
result="[tabs]
[tab=\"YABS\"]
\`\`\`
$processed_yabs_result
\`\`\`
[/tab]
[tab=\"融合怪\"]
\`\`\`
$processed_fusion_result
\`\`\`
[/tab]
[tab=\"IP质量\"]
\`\`\`
########################################################################
$processed_ip_result
\`\`\`
[/tab]
[tab=\"流媒体\"]
\`\`\`
$processed_streaming_result
\`\`\`
[/tab]
[tab=\"响应\"]
\`\`\`
$processed_response_result
\`\`\`
[/tab]
[tab=\"多线程测速\"]
\`\`\`
$processed_speedtest_multi_result
\`\`\`
[/tab]
[tab=\"单线程测速\"]
\`\`\`
$processed_speedtest_single_result
\`\`\`
[/tab]
[tab=\"回程路由\"]
\`\`\`
$processed_autotrace_result
\`\`\`
[/tab]
[tab=\"去程路由\"]

[/tab]
[tab=\"iperf3\"]
\`\`\`
$(iperf3 -c iperf.online -P 8 -t 10)
\`\`\`
[/tab]
[tab=\"Ping.pe\"]
\`\`\`
$(curl -s https://ping.pe/$ipv4_address | grep -E 'AS|Country|City')
\`\`\`
[/tab]
[tab=\"哪吒 ICMP\"]

[/tab]
[tab=\"其他\"]

[/tab]
[/tabs]"

    echo "$result" > "${output_file}.md"
    echo -e "${YELLOW}结果已保存到 ${output_file}.md 文件中。${NC}"
}

# 主函数
main() {
    check_root
    install_dependencies
    sum_run_times
    ip_address

    # 创建输出文件
    output_file="nodeloc_vps_test_$(date +%Y%m%d%H%M%S)"

    # 显示欢迎信息
    clear
    echo -e "${RED}---------------------------------By'Jensfrank---------------------------------${NC}"
    echo ""
    echo "Nodeloc_VPS_自动脚本测试 $VERSION"
    echo "GitHub地址: https://github.com/everett7623/nodeloc_vps_test"
    echo "VPS选购: https://www.nodeloc.com/vps"
    echo ""
    echo -e "${YELLOW}#     #  #####  ####  ###### #       ####   ####    #    # ####   ####${NC}"
    echo -e "${YELLOW}##    # #     # #   # #      #      #    # #    #   #    # #   # #    #${NC}"
    echo -e "${YELLOW}# #   # #     # #   # #####  #      #    # #        #    # ####   ####${NC}"
    echo -e "${YELLOW}#  #  # #     # #   # #      #      #    # #        #    # #         #${NC}"
    echo -e "${YELLOW}#   # # #     # #   # #      #      #    # #    #   #    # #     #    #${NC}"
    echo -e "${YELLOW}#    ##  #####  ####  ###### ######  ####   ####     ####  #      ####${NC}"
    echo ""
    echo "支持Ubuntu/Debian"
    echo ""
    echo -e "今日运行次数: ${RED}$daily_count${NC} 次，累计运行次数: ${RED}$total_count${NC} 次"
    echo ""
    echo -e "${RED}---------------------------------By'Jensfrank---------------------------------${NC}"
    echo ""

    # 用户选择
    echo "请选择测试模式："
    echo "1. 测试全部脚本"
    echo "2. 选择特定脚本测试"
    read -p "输入选择 (1 或 2): " mode_choice

    if [ "$mode_choice" == "1" ]; then
        echo "您选择了测试全部脚本。测试将按以下顺序进行："
        echo "1. Yabs"
        echo "2. 融合怪"
        echo "3. IP质量"
        echo "4. 流媒体解锁"
        echo "5. 响应测试"
        echo "6. 三网测速（多线程）"
        echo "7. 三网测速（单线程）"
        echo "8. 回程路由"
        echo "请耐心等待，测试可能需要一些时间..."
        
        for i in {1..8}; do
            run_test $i "$output_file"
        done
    elif [ "$mode_choice" == "2" ]; then
        echo "输入要测试的脚本编号（用逗号分隔，如 1,2,3）："
        echo "1. Yabs"
        echo "2. 融合怪"
        echo "3. IP质量"
        echo "4. 流媒体解锁"
        echo "5. 响应测试"
        echo "6. 三网测速（多线程）"
        echo "7. 三网测速（单线程）"
        echo "8. 回程路由"
        read -p "输入选择: " script_choices

        echo "您选择了以下测试："
        IFS=',' read -ra ADDR <<< "$script_choices"
        for i in "${ADDR[@]}"; do
            case $i in
                1) echo "- Yabs" ;;
                2) echo "- 融合怪" ;;
                3) echo "- IP质量" ;;
                4) echo "- 流媒体解锁" ;;
                5) echo "- 响应测试" ;;
                6) echo "- 三网测速（多线程）" ;;
                7) echo "- 三网测速（单线程）" ;;
                8) echo "- 回程路由" ;;
                *) echo "- 无效选择: $i" ;;
            esac
        done
        echo "请耐心等待，测试可能需要一些时间..."

        for i in "${ADDR[@]}"; do
            if [[ $i =~ ^[1-8]$ ]]; then
                run_test $i "$output_file"
            else
                echo "跳过无效选择: $i"
            fi
        done
    else
        echo "无效选择，退出程序。"
        exit 1
    fi

    # 生成最终输出
    format_results "$output_file"

    # 清理临时文件
    rm -f "${output_file}_"*

    echo "测试完成，结果已保存到 ${output_file}.md"
    echo "您可以使用文本编辑器打开该文件查看详细结果。"
}

# 运行主函数
main
