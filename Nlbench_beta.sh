#!/bin/bash

# 定义版本
VERSION="1.0.0"

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
    clear
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

# 调用函数获取统计数据
sum_run_times

# 输出欢迎信息
show_welcome() {
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
    echo -e "${RED}按任意键进入测试选项...${NC}"
    read -n 1 -s
    clear
}

# 定义一个数组来存储每个命令的输出
declare -a test_results

# 在每个命令执行后保存结果
run_and_capture() {
    local command_output=$(eval "$1" 2>&1)
    test_results+=("$command_output")
    echo "$command_output"
}

# 去除Yabs板块ANSI转义码
yabs_process_output() {
    local input="$1"
    echo "$input" | sed -E 's/\x1b\[[0-9;]*[a-zA-Z]//g'
}

# 去除融合怪板块ANSI转义码并截取
fusion_process_output() {
    local input="$1"
    # 使用更全面的 sed 命令去除所有 ANSI 转义码
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

# 去除三网测速板块板块ANSI转义码并截取（多线程）
speedtest_multi_process_output() {
    local input="$1"
    # Step 1: 去除 ANSI 转义码
    local no_ansi
    no_ansi=$(echo "$input" | sed -E 's/\x1b\[[0-9;]*[a-zA-Z]//g')
    echo "去除 ANSI 转义码后的输出: $no_ansi" >&2

    # Step 2: 过滤掉包含 "测试进行中" 的行
    local no_progress=$(echo "$no_ansi" | grep -v "^ *测试进行中")
    echo "过滤掉包含 '测试进行中' 的行后的输出: $no_progress" >&2

    # Step 3: 截取所需的测试结果
    local speedtest_multi_process_output_result=$(echo "$no_progress" | awk '/大陆三网\+教育网 IPv4 多线程测速/{f=1} f; /北京时间/{f=0}')
    echo "$speedtest_multi_process_output_result"
}

# 去除三网测速板块板块ANSI转义码并截取（单线程）
speedtest_single_process_output() {
    local input="$1"
    # Step 1: 去除 ANSI 转义码
    local no_ansi
    no_ansi=$(echo "$input" | sed -E 's/\x1b\[[0-9;]*[a-zA-Z]//g')
    echo "去除 ANSI 转义码后的输出: $no_ansi" >&2

    # Step 2: 过滤掉包含 "测试进行中" 的行
    local no_progress
    no_progress=$(echo "$no_ansi" | grep -v "^ *测试进行中")
    echo "过滤掉包含 '测试进行中' 的行后的输出: $no_progress" >&2

    # Step 3: 截取所需的测试结果
    local speedtest_single_process_output_result=$(echo "$no_progress" | awk '/大陆三网\+教育网 IPv4 单线程测速/{f=1} f; /北京时间/{f=0}')
    echo "$speedtest_single_process_output_result"
}

# 去除回程路由板块板块ANSI转义码并截取
autotrace_process_output() {
    local input="$1"
    # 使用更全面的 sed 命令去除所有 ANSI 转义码
    echo "$input" | sed -E 's/\x1b\[[0-9;]*[a-zA-Z]//g' | awk '/No:1/9 Traceroute/{f=1} f; /[信息] 已删除 Nexttrace 文件/{f=0}'
}

# 根据编号执行特定测试
perform_test() {
    case $1 in
        # YABS
        1) echo -e "运行${YELLOW}YABS...${NC}"
           yabs_result=$(run_and_capture "wget -qO- yabs.sh | bash")
           ;;
        # 融合怪
        2) echo -e "运行${YELLOW}融合怪...${NC}"
           fusion_result=$(run_and_capture "curl -L https://gitlab.com/spiritysdx/za/-/raw/main/ecs.sh -o ecs.sh && chmod +x ecs.sh && echo '1' | bash ecs.sh")
           ;;
        # IP质量
        3) echo -e "运行${YELLOW}IP质量测试...${NC}"
           ip_quality_result=$(run_and_capture "bash <(curl -Ls IP.Check.Place)")
           ;;
        # 流媒体解锁
        4) echo -e "运行${YELLOW}流媒体解锁测试...${NC}"
           local region=$(detect_region)
           streaming_result=$(run_and_capture "echo '$region' | bash <(curl -L -s media.ispvps.com)")
           ;;
        # 响应测试
        5) echo -e "运行${YELLOW}响应测试...${NC}"
           response_result=$(run_and_capture "bash <(curl -sL https://nodebench.mereith.com/scripts/curltime.sh)")
           ;;
        # 多线程测试
        6) echo -e "运行${YELLOW}多线程测试...${NC}"
           speedtest_multi_result=$(run_and_capture "echo '1' | bash <(curl -sL bash.icu/speedtest)")
           ;;
        # 单线程测试
        7) echo -e "运行${YELLOW}单线程测试...${NC}"
           speedtest_single_result=$(run_and_capture "echo '2' | bash <(curl -sL bash.icu/speedtest)")
           ;;
        # 回程路由
        8) echo -e "运行${YELLOW}回程路由...${NC}"
           autotrace_result=$(run_and_capture "wget -N --no-check-certificate https://raw.githubusercontent.com/Chennhaoo/Shell_Bash/master/AutoTrace.sh && chmod +x AutoTrace.sh && echo '1' | bash AutoTrace.sh")
           ;;
        *)
           echo -e "${RED}未知测试编号：$1${NC}"
           ;;
    esac
}

# 运行所有测试
run_all_tests() {
    echo -e "${RED}请选择测试模式：${NC}"
    echo "1. 全部测试"
    echo "2. 选择性测试（输入数字，用英文逗号分隔，如：1,2,3）"
    read -r test_choice

    case "$test_choice" in
        1)
            echo -e "${RED}执行全部测试...${NC}"
            echo -e "${RED}开始测试，测试时间较长，请耐心等待...${NC}"
            perform_test 1
            perform_test 2
            perform_test 3
            perform_test 4
            perform_test 5
            perform_test 6
            perform_test 7
            perform_test 8
            format_results
            ;;
        2)
            echo "请输入要测试的编号，用逗号分隔（如：1,2,3）："
            echo -e "${RED}开始测试，测试时间较长，请耐心等待...${NC}"
            read -r test_numbers
            IFS=',' read -ra selected_tests <<< "$test_numbers"
            for test_num in "${selected_tests[@]}"; do
                perform_test "$test_num"
            done

            # 格式化结果
            echo -e "${YELLOW}此报告由Nodeloc_VPS_自动脚本测试生成...${NC}"
            format_results
            ;;
        *)
            echo -e "${RED}无效的选项：$choice${NC}"
            ;;
    esac
}

# 格式化结果为 Markdown
format_results() {

# 处理yabs测试结果
local processed_yabs_result=$(response_yabs_output "$yabs_result")

# 处理融合怪结果
local processed_fusion_result=$(fusion_process_output "$fusion_result")

# 处理IP质量结果
local processed_ip_result=$(ip_process_output "$ip_quality_result")

# 处理流媒体解锁结果
local processed_streaming_result=$(streaming_process_output "$streaming_result")

# 处理响应测试结果
local processed_response_result=$(response_process_output "$response_result")

# 处理三网测速结果
local processed_speedtest_multi_result=$(speedtest_multi_process_output "$speedtest_multi_result")
local processed_speedtest_single_result=$(speedtest_single_process_output "$speedtest_single_result")

# 处理回程路由结果
local processed_autotrace_result=$(autotrace_process_output "$autotrace_result")

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

\`\`\`
[/tab]
[tab=\"Ping.pe\"]

[/tab]
[tab=\"哪吒 ICMP\"]

[/tab]
[tab=\"其他\"]

[/tab]
[/tabs]"

    echo "$result" > results.md
    echo -e "${YELLOW}结果已保存到 results.md 文件中。${NC}"
}

# 主函数
main() {
    install_dependencies
    show_welcome
    run_all_tests
    echo -e "${YELLOW}所有测试完成，可到results.md复制到Nodeloc使用。${NC}"
    read -n 1 -s
    echo "最终测试结果如下:" >&2
    cat results.md >&2
}

main
