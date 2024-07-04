#!/bin/bash

# 定义版本
VERSION="1.0.2"

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
    clear
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

# 服务器 VPS 信息
AUXILIARY_VPS="205.185.119.208"
IPERF_PORT=5201
TEST_DURATION=30
PARALLEL_STREAMS=3

run_iperf3_test() {
    echo -e "${GREEN}服务端VPS位于美国拉斯维加斯${NC}"
    echo -e "${GREEN}连接到服务端进行iperf3测试。。。${NC}"
    if iperf3 -c $AUXILIARY_VPS -p $IPERF_PORT -t $TEST_DURATION -P $PARALLEL_STREAMS; then
    echo -e "${YELLOW}iperf3 测试完成${NC}"
    else
    echo -e "${RED}iperf3 测试失败${NC}"
    fi
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

# 更新系统
update_system() {
    if command -v apt &>/dev/null; then
        apt-get update && apt-get upgrade -y
    elif command -v dnf &>/dev/null; then
        dnf check-update && dnf upgrade -y
    elif command -v yum &>/dev/null; then
        yum check-update && yum upgrade -y
    elif command -v apk &>/dev/null; then
        apk update && apk upgrade
    else
        echo -e "${RED}不支持的Linux发行版${NC}"
        return 1
    fi
    return 0
}

# 执行单个脚本并输出结果到文件
run_script() {
    local script_number=$1
    local output_file=$2
    local temp_file=$(mktemp)
    case $script_number in
        # YABS
        1)
            echo -e "运行${YELLOW}YABS...${NC}"
            wget -qO- yabs.sh | bash | tee "$temp_file"
            sed -i 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file"
            sed -i 's/\.\.\./\.\.\.\n/g' "$temp_file"
            sed -i '/\.\.\./d' "$temp_file"
            sed -i '/^\s*$/d'   "$temp_file"
            cp "$temp_file" "${output_file}_yabs"
            ;;
        # 融合怪
        2)
            echo -e "运行${YELLOW}融合怪...${NC}"
            curl -L https://gitlab.com/spiritysdx/za/-/raw/main/ecs.sh -o ecs.sh && chmod +x ecs.sh && bash ecs.sh -m 1 <<< "y" | tee "$temp_file"
            sed -i 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file"
            sed -i 's/\.\.\.\.\.\./\.\.\.\.\.\.\n/g' "$temp_file"
            sed -i '1,/\.\.\.\.\.\./d' "$temp_file"
            cp "$temp_file" "${output_file}_fusion"
            ;;
        # IP质量
        3)
            echo -e "运行${YELLOW}IP质量测试...${NC}"
            bash <(curl -Ls IP.Check.Place) | tee "$temp_file"
            sed -i 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file"
            sed -i -r 's/(⠋|⠙|⠹|⠸|⠼|⠴|⠦|⠧|⠇|⠏)/\n/g' "$temp_file"
            sed -i -n '/########################################################################/,${s/^.*\(########################################################################\)/\1/;p}' "$temp_file"
            cp "$temp_file" "${output_file}_ip_quality"
            ;;
        # 流媒体解锁
        4)
            echo -e "运行${YELLOW}流媒体解锁测试...${NC}"
            local region=$(detect_region)
            bash <(curl -L -s media.ispvps.com) <<< "$region" | tee "$temp_file"
            sed -i 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file"
            sed -i -n '/流媒体平台及游戏区域限制测试/,$p' "$temp_file"
            sed -i '1d' "$temp_file"
            sed -i '/^$/d' "$temp_file"
            cp "$temp_file" "${output_file}_streaming"
            ;;
        # 响应测试
        5)
            echo -e "运行${YELLOW}响应测试...${NC}"
            bash <(curl -sL https://nodebench.mereith.com/scripts/curltime.sh) | tee "$temp_file"
            sed -i 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file"
            cp "$temp_file" "${output_file}_response"
            ;;
        # 多线程测速
        6)
            echo -e "运行${YELLOW}多线程测速...${NC}"
            bash <(curl -sL bash.icu/speedtest) <<< "1" |tee "$temp_file"
            sed -r -i 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file"
            sed -i -r '1,/序号\:/d' "$temp_file"
            sed -i -r 's/(⠋|⠙|⠹|⠸|⠼|⠴|⠦|⠧|⠇|⠏)/\n/g' "$temp_file"
            sed -i -r '/测试进行中/d' "$temp_file"
            cp "$temp_file" "${output_file}_multi_thread"
            ;;
        # 单线程测速
        7)
            echo -e "运行${YELLOW}单线程测速...${NC}"
            bash <(curl -sL bash.icu/speedtest) <<< "2" |tee "$temp_file"
            sed -r -i 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file"
            sed -i -r '1,/序号\:/d' "$temp_file"
            sed -i -r 's/(⠋|⠙|⠹|⠸|⠼|⠴|⠦|⠧|⠇|⠏)/\n/g' "$temp_file"
            sed -i -r '/测试进行中/d' "$temp_file"
            cp "$temp_file" "${output_file}_single_thread"
            ;;
        # iperf3测试
        8)
            echo -e "运行${YELLOW}iperf3测试...${NC}"
            run_iperf3_test | tee "$temp_file"
            sed -i -e 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file"
            sed -i -r '1,/\[ ID\] /d' "$temp_file"
            cp "$temp_file" "${output_file}_iperf3"
            ;;
       # 回程路由
        9)
            echo -e "运行${YELLOW}回程路由测试...${NC}"
            wget -N --no-check-certificate https://raw.githubusercontent.com/Chennhaoo/Shell_Bash/master/AutoTrace.sh && chmod +x AutoTrace.sh && bash AutoTrace.sh <<< "1" | tee "$temp_file"
            sed -i -e 's/\x1B\[[0-9;]*[JKmsu]//g' -e '/测试项/,+9d' -e '/信息/d' -e '/^\s*$/d' "$temp_file"
            cp "$temp_file" "${output_file}_route"
            ;;
    esac
    rm "$temp_file"
    echo -e "${GREEN}测试完成。${NC}"
}

# 生成最终的 Markdown 输出
generate_markdown_output() {
    local base_output_file=$1
    local final_output_file="${base_output_file}.md"

    echo "[tabs]" > "$final_output_file"

    echo "[tab=\"YABS\"]" >> "$final_output_file"
    echo "\`\`\`" >> "$final_output_file"
    if [ -f "${base_output_file}_yabs" ]; then
        cat "${base_output_file}_yabs" >> "$final_output_file"
        rm "${base_output_file}_yabs"
    fi
    echo "\`\`\`" >> "$final_output_file"
    echo "[/tab]" >> "$final_output_file"

    echo "[tab=\"融合怪\"]" >> "$final_output_file"
    echo "\`\`\`" >> "$final_output_file"
    if [ -f "${base_output_file}_fusion" ]; then
        cat "${base_output_file}_fusion" >> "$final_output_file"
        rm "${base_output_file}_fusion"
    fi
    echo "\`\`\`" >> "$final_output_file"
    echo "[/tab]" >> "$final_output_file"

    echo "[tab=\"IP质量\"]" >> "$final_output_file"
    echo "\`\`\`" >> "$final_output_file"
    if [ -f "${base_output_file}_ip_quality" ]; then
        cat "${base_output_file}_ip_quality" >> "$final_output_file"
        rm "${base_output_file}_ip_quality"
    fi
    echo "\`\`\`" >> "$final_output_file"
    echo "[/tab]" >> "$final_output_file"

    echo "[tab=\"流媒体\"]" >> "$final_output_file"
    echo "\`\`\`" >> "$final_output_file"
    if [ -f "${base_output_file}_streaming" ]; then
        cat "${base_output_file}_streaming" >> "$final_output_file"
        rm "${base_output_file}_streaming"
    fi
    echo "\`\`\`" >> "$final_output_file"
    echo "[/tab]" >> "$final_output_file"

    echo "[tab=\"响应\"]" >> "$final_output_file"
    echo "\`\`\`" >> "$final_output_file"
    if [ -f "${base_output_file}_response" ]; then
        cat "${base_output_file}_response" >> "$final_output_file"
        rm "${base_output_file}_response"
    fi
    echo "\`\`\`" >> "$final_output_file"
    echo "[/tab]" >> "$final_output_file"

    echo "[tab=\"多线程测速\"]" >> "$final_output_file"
    echo "\`\`\`" >> "$final_output_file"
    if [ -f "${base_output_file}_multi_thread" ]; then
        cat "${base_output_file}_multi_thread" >> "$final_output_file"
        rm "${base_output_file}_multi_thread"
    fi
    echo "\`\`\`" >> "$final_output_file"
    echo "[/tab]" >> "$final_output_file"

    echo "[tab=\"单线程测速\"]" >> "$final_output_file"
    echo "\`\`\`" >> "$final_output_file"
    if [ -f "${base_output_file}_single_thread" ]; then
        cat "${base_output_file}_single_thread" >> "$final_output_file"
        rm "${base_output_file}_single_thread"
    fi
    echo "\`\`\`" >> "$final_output_file"
    echo "[/tab]" >> "$final_output_file"

    echo "[tab=\"iperf3\"]" >> "$final_output_file"
    echo "\`\`\`" >> "$final_output_file"
    if [ -f "${base_output_file}_iperf3" ]; then
    cat "${base_output_file}_iperf3" >> "$final_output_file"
    rm "${base_output_file}_iperf3"
    fi
    echo "\`\`\`" >> "$final_output_file"
    echo "[/tab]" >> "$final_output_file"

    echo "[tab=\"回程路由\"]" >> "$final_output_file"
    echo "\`\`\`" >> "$final_output_file"
    if [ -f "${base_output_file}_route" ]; then
        cat "${base_output_file}_route" >> "$final_output_file"
        rm "${base_output_file}_route"
    fi
    echo "\`\`\`" >> "$final_output_file"
    echo "[/tab]" >> "$final_output_file"

    echo "[tab=\"去程路由\"]" >> "$final_output_file"
    echo "[/tab]" >> "$final_output_file"

    echo "[tab=\"Ping.pe\"]" >> "$final_output_file"
    echo "[/tab]" >> "$final_output_file"

    echo "[tab=\"哪吒 ICMP\"]" >> "$final_output_file"
    echo "[/tab]" >> "$final_output_file"

    echo "[tab=\"其他\"]" >> "$final_output_file"
    echo "[/tab]" >> "$final_output_file"

    echo "[/tabs]" >> "$final_output_file"

    echo "所有测试完成，结果已保存在 $final_output_file 中。"
    read -p "按回车键继续..."
    clear
}

# 执行全部脚本
run_all_scripts() {
    local base_output_file="NLvps_results_$(date +%Y%m%d_%H%M%S)"
    echo "开始执行全部测试脚本..."
    for i in {1..9}; do
        run_script $i "$base_output_file"
    done
    generate_markdown_output "$base_output_file"
    clear
}

# 执行选定的脚本
run_selected_scripts() {
    clear
    local base_output_file="NLvps_results_$(date +%Y%m%d_%H%M%S)"
    echo -e "${YELLOW}Nodeloc VPS 自动测试脚本 $VERSION${NC}"
    echo "1. Yabs"
    echo "2. 融合怪"
    echo "3. IP质量"
    echo "4. 流媒体解锁"
    echo "5. 响应测试"
    echo "6. 多线程测试"
    echo "7. 单线程测试"
    echo "8. iperf3"
    echo "9. 回程路由"
    echo "0. 返回"
    
    while true; do
        read -p "请输入要执行的脚本编号（用英文逗号分隔，例如：1,2,3):" script_numbers
        if [[ "$script_numbers" =~ ^[0-9](,[0-9])*$ ]]; then
            break
        else
            echo -e "${RED}无效输入，请输入0-9之间的数字，用英文逗号分隔。${NC}"
        fi
    done

    IFS=',' read -ra selected_scripts <<< "$script_numbers"
    echo "开始执行选定的测试脚本..."
    if [ "$script_numbers" == "0" ]; then
        clear
        show_welcome
    else
        for number in "${selected_scripts[@]}"; do
            clear
            run_script "$number" "$base_output_file"
        done
        generate_markdown_output "$base_output_file"
    fi
}

# 主菜单
main_menu() {
    echo -e "${GREEN}测试项目：${NC}Yabs，融合怪，IP质量，流媒体解锁，响应测试，多线程测试，单线程测试，iperf3，回程路由。"
    echo -e "${YELLOW}1. 执行所有测试脚本${NC}"
    echo -e "${YELLOW}2. 选择特定测试脚本${NC}"
    echo -e "${YELLOW}0. 退出${NC}"
    read -p "请选择操作 [0-2]: " choice

    case $choice in
        1)
            run_all_scripts
            ;;
        2)
            run_selected_scripts
            ;;
        0)
            echo -e "${RED}感谢使用NodeLoc聚合测试脚本，已退出脚本，期待你的下次使用！${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}无效选择，请重新输入。${NC}"
            sleep 3s
            clear
            show_welcome
            ;;
    esac
}

# 输出欢迎信息
show_welcome() {
    echo ""
    echo -e "${RED}---------------------------------By'Jensfrank---------------------------------${NC}"
    echo ""
    echo -e "${GREEN}Nodeloc VPS 自动测试脚本 $VERSION${NC}"
    echo -e "${GREEN}GitHub地址: https://github.com/everett7623/nodeloc_vps_test${NC}"
    echo -e "${GREEN}VPS选购: https://www.nodeloc.com/vps${NC}"
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

# 主函数
main() {
    # 检查并安装依赖
    install_dependencies

    # 获取统计数据
    sum_run_times

    # 主循环
    while true; do
        clear
        show_welcome
        main_menu
    done
}

# 运行主函数
main
