#!/bin/bash

# 定义版本
VERSION="1.0.0"

# 定义颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 定义渐变颜色数组
colors=(
    '\033[38;2;255;0;0m'    # 红色
    '\033[38;2;255;127;0m'  # 橙色
    '\033[38;2;255;255;0m'  # 黄色
    '\033[38;2;0;255;0m'    # 绿色
    '\033[38;2;0;0;255m'    # 蓝色
)

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
        "xclip"
        "iperf3"
        "mtr"
        "traceroute"
        "speedtest-cli"
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

# 函数：运行命令并捕获输出
run_and_capture() {
    local output
    output=$(eval "$1" 2>&1)
    echo "$output"
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
    COUNT=$(wget --no-check-certificate -qO- --tries=2 --timeout=2 "https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https://github.com/everett7623/nodeloc_vps_test/blob/main/nodeloc_vps_autotest.sh" 2>&1 | grep -m1 -oE "[0-9]+[ ]+/[ ]+[0-9]+")
    if [[ -n "$COUNT" ]]; then
        daily_count=$(cut -d " " -f1 <<< "$COUNT")
        total_count=$(cut -d " " -f3 <<< "$COUNT")
    else
        echo "Failed to fetch usage counts."
        daily_count=0
        total_count=0
    fi
}

# 调用函数获取统计数据
sum_run_times

# 输出欢迎信息
show_welcome() {
    echo ""
    echo -e "${YELLOW}---------------------------------By'Jensfrank---------------------------------${NC}"
    echo ""
    echo "Nodeloc_VPS_自动脚本测试 $VERSION"
    echo "GitHub地址: https://github.com/everett7623/nodeloc_vps_test"
    echo "VPS选购: https://www.nodeloc.com/vps"
    echo ""
    echo -e "${colors[0]}#     #  #####  ####  ###### #       ####   ####    #    # ####   ####  ${NC}"
    echo -e "${colors[1]}##    # #     # #   # #      #      #    # #    #   #    # #   # #     #  ${NC}"
    echo -e "${colors[2]}# #   # #     # #   # #####  #      #    # #        #    # ####   ####  ${NC}"
    echo -e "${colors[3]}#  #  # #     # #   # #      #      #    # #        #    # #          #  ${NC}"
    echo -e "${colors[4]}#   # # #     # #   # #      #      #    # #    #   #    # #     #    # ${NC}"
    echo -e "${colors[0]}#    ##  #####  ####  ###### ######  ####   ####     ####  #      ####  ${NC}"
    echo ""
    echo "支持Ubuntu/Debian"
    echo ""
    echo -e "今日运行次数: ${PURPLE}$daily_count${NC} 次，累计运行次数: ${PURPLE}$total_count${NC} 次"
    echo ""
    echo -e "${YELLOW}---------------------------------By'Jensfrank---------------------------------${NC}"
    echo ""
    echo "本一键脚本将测试以下项目："
    echo "1. Yabs"
    echo "2. 融合怪"
    echo "3. IP质量"
    echo "4. 流媒体解锁"
    echo "5. 响应测试"
    echo "6. 多线程测试"
    echo "7. 单线程测试"
    echo "8. 回程路由"
    echo ""
    echo -e "${YELLOW}按任意键开始测试，测试时间较长，请耐心等待...${NC}"
    read -n 1 -s
    clear
}

# 运行所有测试
run_all_tests() {
    echo "开始运行测试..."

    # YABS
    echo "运行${YELLOW}YABS...${NC}"
    yabs_result=$(run_and_capture "wget -qO- yabs.sh | bash")

    # 融合怪
    echo "运行${YELLOW}融合怪...${NC}"
    fusion_result=$(run_and_capture "curl -L https://gitlab.com/spiritysdx/za/-/raw/main/ecs.sh -o ecs.sh && chmod +x ecs.sh && echo '1' | bash ecs.sh")

    # IP质量
    echo "运行${YELLOW}IP质量测试...${NC}"
    ip_quality_result=$(run_and_capture "bash <(curl -Ls IP.Check.Place)")

    # 流媒体解锁
    echo "运行${YELLOW}流媒体解锁测试...${NC}"
    local region
    region=$(detect_region)
    streaming_result=$(run_and_capture "echo '$region' | bash <(curl -L -s media.ispvps.com)")

    # 响应测试
    echo "运行${YELLOW}响应测试...${NC}"
    response_result=$(run_and_capture "bash <(curl -sL https://nodebench.mereith.com/scripts/curltime.sh)")

    # 三网测速
    echo "运行${YELLOW}三网测速（多线程/单线程）...${NC}"
    speedtest_multi_result=$(run_and_capture "echo '1' | bash <(curl -sL bash.icu/speedtest)")
    speedtest_single_result=$(run_and_capture "echo '2' | bash <(curl -sL bash.icu/speedtest)")

    # AutoTrace三网回程路由
    echo "运行${YELLOW}AutoTrace三网回程路由...${NC}"
    autotrace_result=$(run_and_capture "wget -N --no-check-certificate https://raw.githubusercontent.com/Chennhaoo/Shell_Bash/master/AutoTrace.sh && chmod +x AutoTrace.sh && bash AutoTrace.sh")

    # 格式化结果
    format_results
}

# 格式化结果为 Markdown
format_results() {
echo -e "${YELLOW}此报告由Nodeloc_VPS_自动脚本测试生成...${NC}"
result="[tabs]
[tab=\"YABS\"]
\`\`\`
$yabs_result
\`\`\`
[/tab]
[tab=\"融合怪\"]
\`\`\`
$fusion_result
\`\`\`
[/tab]
[tab=\"IP质量\"]
\`\`\`
$ip_quality_result
\`\`\`
[/tab]
[tab=\"流媒体\"]
\`\`\`
$streaming_result
\`\`\`
[/tab]
[tab=\"响应\"]
\`\`\`
$response_result
\`\`\`
[/tab]
[tab=\"多线程测速\"]
\`\`\`
$speedtest_multi_result
\`\`\`
[/tab]
[tab=\"单线程测速\"]
\`\`\`
$speedtest_single_result
\`\`\`
[/tab]
[tab=\"iperf3\"]
\`\`\`

\`\`\`
[/tab]
[tab=\"回程路由\"]
\`\`\`
$autotrace_result
\`\`\`
[/tab]
[tab=\"去程路由\"]

[/tab]
[tab=\"Ping.pe\"]

[/tab]
[tab=\"哪吒 ICMP\"]

[/tab]
[tab=\"其他\"]

[/tab]
[/tabs]"

    echo "$result" > results.md
    echo -e "${GREEN}结果已保存到 results.md 文件中。${NC}"
}

# 复制结果到剪贴板
copy_to_clipboard() {
    if [ -f results.md ]; then
        if command -v xclip > /dev/null; then
            xclip -selection clipboard < results.md
            echo -e "${GREEN}结果已复制到剪贴板。${NC}"
        elif command -v pbcopy > /dev/null; then
            pbcopy < results.md
            echo -e "${GREEN}结果已复制到剪贴板。${NC}"
        else
            echo -e "${RED}无法复制到剪贴板。请手动复制 results.md 文件内容。${NC}"
        fi
    else
        echo -e "${RED}results.md 文件不存在。${NC}"
    fi
}

# 主函数
main() {
    install_dependencies
    show_welcome
    run_all_tests
    echo -e "${GREEN}所有测试完成。点击屏幕任意位置复制结果。${NC}"
    read -n 1 -s
    copy_to_clipboard
}

main
