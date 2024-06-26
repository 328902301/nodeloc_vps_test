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
    clear
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
    echo "8. 回程路由"
    echo ""
    echo -e "${RED}按任意键开始测试...${NC}"
    read -n 1 -s
    clear
}

# 创建results.md
touch /root/results.md
chmod 777 /root/results.md

#获取IP输出结果
extract_ip_report() {
    echo "开始执行 IP 质量检测..." >&2
    local curl_output
    curl_output=$(curl -Ls IP.Check.Place)
    local curl_exit_code=$?
    
    echo "curl 退出码: $curl_exit_code" >&2
    echo "curl 输出长度: $(echo "$curl_output" | wc -c) 字节" >&2
    
    if [ $curl_exit_code -ne 0 ] || [ -z "$curl_output" ]; then
        echo "curl 命令失败或返回空输出" >&2
        return 1
    fi
    
    local bash_output
    bash_output=$(echo "$curl_output" | bash)
    local bash_exit_code=$?
    
    echo "bash 退出码: $bash_exit_code" >&2
    echo "bash 输出长度: $(echo "$bash_output" | wc -l) 行" >&2
    
    if [ $bash_exit_code -ne 0 ] || [ -z "$bash_output" ]; then
        echo "bash 执行失败或返回空输出" >&2
        return 1
    fi
    
    echo "$bash_output" | awk '
        BEGIN {flag=0; lines=0}
        /^########################################################################$/ {flag=1}
        flag && !/按回车键返回主菜单.../ {print; lines++}
        /按回车键返回主菜单.../ {flag=0}
        END {print "awk 处理后的行数: " lines > "/dev/stderr"}
    '
}

#运行测试
run_all_tests() {
    echo -e "${RED}开始测试，测试时间较长，请耐心等待...${NC}"
    
    # IP质量
    echo -e "运行${YELLOW}IP质量测试...${NC}"
    ip_quality_result=$(extract_ip_report 2>&1)
    extract_exit_code=$?
    
    echo "extract_ip_report 退出码: $extract_exit_code" >&2
    echo "IP质量结果长度: $(echo "$ip_quality_result" | wc -l) 行" >&2
    
    if [ $extract_exit_code -ne 0 ] || [ -z "$ip_quality_result" ]; then
        echo "extract_ip_report 函数失败或返回空结果" >&2
        ip_quality_result="无法获取 IP 质量报告。请检查网络连接或脚本执行权限。"
    fi
    
    # 格式化结果
    echo -e "${YELLOW}此报告由Nodeloc_VPS_自动脚本测试生成...${NC}"
    format_results "$ip_quality_result"
}

#格式化输出结果
format_results() {
    local ip_quality_result="$1"
    echo "格式化结果，输入长度: $(echo "$ip_quality_result" | wc -l) 行" >&2
    # 检查 ip_quality_result 是否为空
    if [ -z "$ip_quality_result" ]; then
        echo "警告：IP 质量结果为空" >&2
        ip_quality_result="无法获取 IP 质量报告。请检查网络连接或脚本执行权限。"
    fi
    result="[tabs]
[tab=\"IP质量\"]
\`\`\`
$ip_quality_result
\`\`\`
[/tab]
[/tabs]"
    echo "$result" > /root/results.md
    echo -e "${GREEN}结果已保存到 /root/results.md 文件中。${NC}"
    echo "保存的结果长度: $(wc -l < /root/results.md) 行" >&2
}

# 复制结果到剪贴板
copy_to_clipboard() {
    if [ -f /root/results.md ]; then
        if command -v xclip > /dev/null; then
            xclip -selection clipboard < /root/results.md
            echo -e "${GREEN}结果已复制到剪贴板。${NC}"
        elif command -v pbcopy > /dev/null; then
            pbcopy < /root/results.md
            echo -e "${GREEN}结果已复制到剪贴板。${NC}"
        else
            echo -e "${RED}无法复制到剪贴板。请手动复制 /root/results.md 文件内容。${NC}"
        fi
    else
        echo -e "${RED}/root/results.md 文件不存在。${NC}"
    fi
}

# 主函数
main() {
    install_dependencies
    show_welcome
    run_all_tests
    echo -e "${GREEN}所有测试完成。点击屏幕任意位置复制结果。${NC}"
    echo "最终结果文件内容:" >&2
    cat /root/results.md >&2
    read -n 1 -s
    copy_to_clipboard
}

main
