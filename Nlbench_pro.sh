#!/bin/bash

# 定义版本
VERSION="2.2.0"

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
    
    local dependencies=("curl" "wget" "iperf3" "awk" "sed")
    
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
get_ip_address() {
    ipv4_address=$(curl -s --max-time 5 ipv4.ip.sb)
    [ -z "$ipv4_address" ] && ipv4_address=$(ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v '127.0.0.1' | head -n1)

    ipv6_address=$(curl -s --max-time 5 ipv6.ip.sb)
    [ -z "$ipv6_address" ] && ipv6_address=$(ip -6 addr show | grep -oP '(?<=inet6\s)[\da-f:]+' | grep -v '^::1' | grep -v '^fe80' | head -n1)
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

# 显示欢迎信息
show_welcome() {
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
}

# Markdown 转义函数
escape_markdown() {
    sed -E 's/\x1b\[[0-9;]*[a-zA-Z]//g'
}

# 执行YABS测试
run_yabs() {
    echo "执行YABS测试..."
    yabs_result=$(wget -qO- yabs.sh | bash)
    echo "$yabs_result" > yabs_result.txt
}

# 执行融合怪测试
run_fusion() {
    echo "执行融合怪测试..."
    fusion_result=$(curl -L https://gitlab.com/spiritysdx/za/-/raw/main/ecs.sh -o ecs.sh && chmod +x ecs.sh && bash ecs.sh)
    fusion_result=$(echo "$fusion_result" | awk '/A Bench Script/{f=1} f; /短链/{f=0}')
    echo "$fusion_result" > fusion_result.txt
}

# 执行IP质量测试
run_ip_quality() {
    echo "执行IP质量测试..."
    ip_quality_result=$(bash <(curl -Ls IP.Check.Place))
    
    local start_line=$(echo "$ip_quality_result" | grep -n '正在检测黑名单数据库' | tail -n 1 | cut -d ':' -f 1)
    start_line=$((start_line + 1))  # 移动到下一行
    local end_line=$(echo "$ip_quality_result" | grep -n '按回车键返回主菜单' | head -n 1 | cut -d ':' -f 1)
    
    if [ -n "$start_line" ] && [ -n "$end_line" ]; then
        ip_quality_result=$(tail -n +"$start_line" <<< "$ip_quality_result" | head -n $(($end_line - $start_line)) | sed -E 's/\x1b\[[0-9;]*[a-zA-Z]//g')
    elif [ -n "$start_line" ]; then
        ip_quality_result=$(tail -n +"$start_line" <<< "$ip_quality_result" | sed -E 's/\x1b\[[0-9;]*[a-zA-Z]//g')
    fi
    
    echo "$ip_quality_result" > ip_quality_result.txt
}

# 执行流媒体解锁测试
run_streaming() {
    echo "执行流媒体解锁测试..."
    region=$(detect_region)
    streaming_result=$(bash <(curl -L -s media.ispvps.com) $region)
    streaming_result=$(echo "$streaming_result" | awk '/项目地址/{f=1} f; /检测脚本当天运行次数/{f=0}')
    echo "$streaming_result" > streaming_result.txt
}

# 执行响应测试
run_response() {
    echo "执行响应测试..."
    response_result=$(bash <(curl -sL https://nodebench.mereith.com/scripts/curltime.sh))
    echo "$response_result" > response_result.txt
}

# 执行三网测速（多线程）
run_speedtest_multi() {
    echo "执行三网测速（多线程）..."
    speedtest_multi_result=$(bash <(curl -sL bash.icu/speedtest) 1)
    speedtest_multi_result=$(echo "$speedtest_multi_result" | sed -e '1,/序号\:/d' -e '/测试进行中/d' -e '/^\s*$/d')
    echo "$speedtest_multi_result" > speedtest_multi_result.txt
}

# 执行三网测速（单线程）
run_speedtest_single() {
    echo "执行三网测速（单线程）..."
    speedtest_single_result=$(bash <(curl -sL bash.icu/speedtest) 2)
    speedtest_single_result=$(echo "$speedtest_single_result" | sed -e '1,/序号\:/d' -e '/测试进行中/d' -e '/^\s*$/d')
    echo "$speedtest_single_result" > speedtest_single_result.txt
}

# 执行回程路由测试
run_traceroute() {
    echo "执行回程路由测试..."
    traceroute_result=$(wget -N --no-check-certificate https://raw.githubusercontent.com/Chennhaoo/Shell_Bash/master/AutoTrace.sh && chmod +x AutoTrace.sh && bash AutoTrace.sh)
    traceroute_result=$(echo "$traceroute_result" | sed -e '/测试项/,+9d' -e '/信息/d' -e '/^\s*$/d')
    echo "$traceroute_result" > traceroute_result.txt
}

# 生成Markdown文件
generate_markdown() {
    local output_file="nodeloc_vps_test_$(date +%Y%m%d_%H%M%S).md"
    {
        echo "# VPS 测试结果"
        echo "测试时间：$(date)"
        echo ""
        echo "## 系统信息"
        echo "- IPv4: $ipv4_address"
        echo "- IPv6: $ipv6_address"
        echo ""
        echo "[tabs]"
        echo "[tab=\"YABS\"]"
        echo "\`\`\`"
        cat yabs_result.txt | escape_markdown
        echo "\`\`\`"
        echo "[/tab]"
        
        echo "[tab=\"融合怪\"]"
        echo "\`\`\`"
        cat fusion_result.txt | escape_markdown
        echo "\`\`\`"
        echo "[/tab]"
        
        echo "[tab=\"IP质量\"]"
        echo "\`\`\`"
        echo "########################################################################"
        cat ip_quality_result.txt | escape_markdown
        echo "\`\`\`"
        echo "[/tab]"
        
        echo "[tab=\"流媒体\"]"
        echo "\`\`\`"
        cat streaming_result.txt | escape_markdown
        echo "\`\`\`"
        echo "[/tab]"
        
        echo "[tab=\"响应\"]"
        echo "\`\`\`"
        cat response_result.txt | escape_markdown
        echo "\`\`\`"
        echo "[/tab]"
        
        echo "[tab=\"多线程测速\"]"
        echo "\`\`\`"
        cat speedtest_multi_result.txt | escape_markdown
        echo "\`\`\`"
        echo "[/tab]"
        
        echo "[tab=\"单线程测速\"]"
        echo "\`\`\`"
        cat speedtest_single_result.txt | escape_markdown
        echo "\`\`\`"
        echo "[/tab]"
        
        echo "[tab=\"回程路由\"]"
        echo "\`\`\`"
        cat traceroute_result.txt | escape_markdown
        echo "\`\`\`"
        echo "[/tab]"
        
        echo "[/tabs]"
    } > "$output_file"

    echo "测试结果已保存到 $output_file"
}

# 主函数
main() {
    check_root
    install_dependencies
    get_ip_address
    sum_run_times
    show_welcome

    while true; do
        echo "请选择测试选项："
        echo "1. 测试全部脚本"
        echo "2. 选择特定脚本测试"
        echo "0. 退出"
        read -p "请输入选项 (0-2): " option

        case $option in
            1)
                run_yabs
                run_fusion
                run_ip_quality
                run_streaming
                run_response
                run_speedtest_multi
                run_traceroute
                break
                ;;
            2)
                echo "请输入要测试的脚本编号（用逗号分隔，如1,2,3）:"
                echo "1. Yabs"
                echo "2. 融合怪"
                echo "3. IP质量"
                echo "4. 流媒体解锁"
                echo "5. 响应测试"
                echo "6. 多线程测试"
                echo "7. 单线程测试"
                echo "8. 回程路由"
                read -p "输入选择: " scripts
                IFS=',' read -ra ADDR <<< "$scripts"
                for i in "${ADDR[@]}"; do
                    case $i in
                        1) run_yabs ;;
                        2) run_fusion ;;
                        3) run_ip_quality ;;
                        4) run_streaming ;;
                        5) run_response ;;
                        6) run_speedtest_multi ;;
                        7) run_speedtest_single ;;
                        8) run_traceroute ;;
                        *) echo "无效的选项: $i" ;;
                    esac
                done
                break
                ;;
            0)
                echo "感谢使用，再见！"
                exit 0
                ;;
            *)
                echo "无效的选项，请重新输入。"
                ;;
        esac
    done

    # 生成 Markdown 文件
    generate_markdown

    # 清理临时文件
    rm -f yabs_result.txt fusion_result.txt ip_quality_result.txt streaming_result.txt response_result.txt speedtest_multi_result.txt speedtest_single_result.txt traceroute_result.txt

    echo "测试完成！结果已保存到 nodeloc_vps_test_$(date +%Y%m%d_%H%M%S).md"
}
