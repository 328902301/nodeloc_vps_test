#!/bin/bash

# 定义颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

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

# 函数：检测VPS地理位置
detect_region() {
    local country
    country=$(curl -s ipinfo.io/country)
    case $country in
        "US") echo "na" ;; # 北美
        "CA") echo "na" ;;
        # 添加更多国家和地区的映射
        *) echo "default" ;;
    esac
}

# 统计使用次数
sum_run_times() {
    local COUNT
    COUNT=$(wget --no-check-certificate -qO- --tries=2 --timeout=2 "https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Feverett7623%2Fvps_scripts%2Fblob%2Fmain%2Fvps_scripts.sh" 2>&1 | grep -m1 -oE "[0-9]+[ ]+/[ ]+[0-9]+")
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

# 运行所有测试
run_all_tests() {
    echo "开始运行测试..."

    # YABS
    echo "运行 YABS..."
    yabs_result=$(run_and_capture "wget -qO- yabs.sh | bash")

    # 融合怪
    echo "运行融合怪..."
    fusion_result=$(run_and_capture "curl -L https://gitlab.com/spiritysdx/za/-/raw/main/ecs.sh -o ecs.sh && chmod +x ecs.sh && echo '1' | bash ecs.sh")

    # IP质量
    echo "运行 IP 质量测试..."
    ip_quality_result=$(run_and_capture "bash <(curl -Ls IP.Check.Place)")

    # 流媒体解锁
    echo "运行流媒体解锁测试..."
    region=$(detect_region)
    streaming_result=$(run_and_capture "echo '$region' | bash <(curl -L -s media.ispvps.com)")

    # 响应测试
    echo "运行响应测试..."
    response_result=$(run_and_capture "bash <(curl -sL https://nodebench.mereith.com/scripts/curltime.sh)")

    # 三网测速
    echo "运行三网测速..."
    speedtest_multi_result=$(run_and_capture "echo '1' | bash <(curl -sL bash.icu/speedtest)")
    speedtest_single_result=$(run_and_capture "echo '2' | bash <(curl -sL bash.icu/speedtest)")

    # AutoTrace三网回程路由
    echo "运行 AutoTrace 三网回程路由..."
    autotrace_result=$(run_and_capture "wget -N --no-check-certificate https://raw.githubusercontent.com/Chennhaoo/Shell_Bash/master/AutoTrace.sh && chmod +x AutoTrace.sh && bash AutoTrace.sh")

    # 格式化结果
    format_results
}

# 格式化结果为 Markdown
format_results() {
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
    run_all_tests
    echo -e "${GREEN}所有测试完成。点击屏幕任意位置复制结果。${NC}"
    echo ""
    echo -e "今日运行次数: ${YELLOW}$daily_count${NC} 次，累计运行次数: ${YELLOW}$total_count${NC} 次"
    read -n 1 -s
    copy_to_clipboard
}

main
