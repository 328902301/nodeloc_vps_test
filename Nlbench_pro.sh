#!/bin/bash

# 定义版本
VERSION="1.0.1"

# 定义颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查 root 权限并获取 sudo 权限
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要 root 权限运行。"
    if ! sudo -v; then
        echo "无法获取 sudo 权限，退出脚本。"
        exit 1
    fi
    echo "已获取 sudo 权限。"
fi

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

# 执行测试脚本并保存结果
run_test() {
    local script=$1
    local output_file=$2
    local temp_file=$(mktemp)

    case $script in
        1)
            wget -qO- yabs.sh | bash > "$temp_file" 2>&1
            sed 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file" > "${output_file}_yabs"
            ;;
        2)
            curl -L https://gitlab.com/spiritysdx/za/-/raw/main/ecs.sh -o ecs.sh && chmod +x ecs.sh && bash ecs.sh > "$temp_file" 2>&1
            sed 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file" > "${output_file}_ecs"
            ;;
        3)
            bash <(curl -Ls IP.Check.Place) > "$temp_file" 2>&1
            sed 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file" > "${output_file}_ip_quality"
            ;;
        4)
            region=$(detect_region)
            bash <(curl -L -s media.ispvps.com) <<< "$region" > "$temp_file" 2>&1
            sed 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file" > "${output_file}_streaming"
            ;;
        5)
            bash <(curl -sL https://nodebench.mereith.com/scripts/curltime.sh) > "$temp_file" 2>&1
            sed 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file" > "${output_file}_response"
            ;;
        6)
            bash <(curl -sL bash.icu/speedtest) <<< "1" > "$temp_file" 2>&1
            sed 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file" > "${output_file}_multi_thread"
            ;;
        7)
            bash <(curl -sL bash.icu/speedtest) <<< "2" > "$temp_file" 2>&1
            sed 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file" > "${output_file}_single_thread"
            ;;
        8)
            wget -N --no-check-certificate https://raw.githubusercontent.com/Chennhaoo/Shell_Bash/master/AutoTrace.sh && chmod +x AutoTrace.sh && bash AutoTrace.sh <<< "1" > "$temp_file" 2>&1
            sed 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file" > "${output_file}_route"
            ;;
    esac

    rm "$temp_file"
}

# 生成输出结果
generate_output() {
    local output_file=$1
    echo "[tabs]"
    echo
    echo "[tab=\"YABS\"]"
    echo "\`\`\`"
    cat "${output_file}_yabs"
    echo "\`\`\`"
    echo "[/tab]"
    echo
    echo "[tab=\"融合怪\"]"
    echo "\`\`\`"
    cat "${output_file}_ecs"
    echo "\`\`\`"
    echo "[/tab]"
    echo
    echo "[tab=\"IP质量\"]"
    cat "${output_file}_ip_quality"
    echo "[/tab]"
    echo
    echo "[tab=\"流媒体\"]"
    echo "\`\`\`"
    cat "${output_file}_streaming"
    echo "\`\`\`"
    echo "[/tab]"
    echo
    echo "[tab=\"响应\"]"
    echo "\`\`\`"
    cat "${output_file}_response"
    echo "\`\`\`"
    echo "[/tab]"
    echo
    echo "[tab=\"多线程测速\"]"
    echo "\`\`\`"
    cat "${output_file}_multi_thread"
    echo "\`\`\`"
    echo "[/tab]"
    echo
    echo "[tab=\"单线程测速\"]"
    echo "\`\`\`"
    cat "${output_file}_single_thread"
    echo "\`\`\`"
    echo "[/tab]"
    echo
    echo "[tab=\"回程路由\"]"
    echo "\`\`\`"
    cat "${output_file}_route"
    echo "\`\`\`"
    echo "[/tab]"
    echo
    echo "[tab=\"去程路由\"]"
    echo "[/tab]"
    echo
    echo "[tab=\"iperf3\"]"
    echo "\`\`\`"
    echo "\`\`\`"
    echo "[/tab]"
    echo
    echo "[tab=\"Ping.pe\"]"
    echo "[/tab]"
    echo
    echo "[tab=\"哪吒 ICMP\"]"
    echo "[/tab]"
    echo
    echo "[tab=\"其他\"]"
    echo "[/tab]"
    echo
    echo "[/tabs]"
}

# 主函数
main() {
    install_dependencies
    ip_address
    sum_run_times

    # 输出欢迎信息
    clear
    echo ""
    echo -e "${RED}---------------------------------By'Jensfrank---------------------------------${NC}"
    echo ""
    echo "Nodeloc_VPS_自动脚本测试 $VERSION"
    echo "GitHub地址: https://github.com/everett7623/nodeloc_vps_test"
    echo "VPS选购: https://www.nodeloc.com/vps"
    echo ""
    echo -e "${YELLOW}#     #  #####  ####  ###### #       ####   ####    #    # ####   ####${NC}"
    echo -e "${YELLOW}##    # #     # #   # #      #      #    # #    #   #    # #   # #     #${NC}"
    echo -e "${YELLOW}# #   # #     # #   # #####  #      #    # #        #    # ####   ####${NC}"
    echo -e "${YELLOW}#  #  # #     # #   # #      #      #    # #        #    # #          #${NC}"
    echo -e "${YELLOW}#   # # #     # #   # #      #      #    # #    #   #    # #     #    #${NC}"
    echo -e "${YELLOW}#    ##  #####  ####  ###### ######  ####   ####     ####  #      ####${NC}"
    echo ""
    echo "支持Ubuntu/Debian"
    echo ""
    echo -e "今日运行次数: ${RED}$daily_count${NC} 次，累计运行次数: ${RED}$total_count${NC} 次"
    echo ""
    echo -e "${RED}---------------------------------By'Jensfrank---------------------------------${NC}"
    echo ""
    echo "一键脚本将测试以下项目："
    echo "1. Yabs"
    echo "2. 融合怪"
    echo "3. IP质量"
    echo "4. 流媒体解锁"
    echo "5. 响应测试"
    echo "6. 多线程测试"
    echo "7. 单线程测试"
    echo "8. 回程路由（调试中）"
    echo ""

    echo "选择测试模式："
    echo "1. 测试全部脚本"
    echo "2. 选择特定脚本测试"
    read -p "请输入选择 (1/2): " mode

    local output_file="/tmp/test_results"

    if [ "$mode" = "1" ]; then
        for i in {1..8}; do
            run_test $i "$output_file"
        done
    elif [ "$mode" = "2" ]; then
        read -p "请输入要测试的脚本编号（用逗号分隔，如 1,2,3）: " scripts
        IFS=',' read -ra ADDR <<< "$scripts"
        for i in "${ADDR[@]}"; do
            run_test $i "$output_file"
        done
    else
        echo "无效的选择，退出脚本。"
        exit 1
    fi

    generate_output "$output_file"
    rm ${output_file}*
}

main
