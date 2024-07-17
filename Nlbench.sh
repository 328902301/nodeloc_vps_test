#!/bin/bash

# 定义版本
CURRENT_VERSION="2024-07-18 v1.0.5"

# 定义颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 定义渐变颜色数组
colors=(
    '\033[38;2;0;255;0m'    # 绿色
    '\033[38;2;64;255;0m'
    '\033[38;2;128;255;0m'
    '\033[38;2;192;255;0m'
    '\033[38;2;255;255;0m'  # 黄色
)

# 检查更新
check_update() {
    echo "正在检查更新..."
    
    # 从GitHub获取最新版本号
    latest_version=$(curl -s https://raw.githubusercontent.com/everett7623/nodeloc_vps_test/main/version.sh | tail -n 1 | grep -o "v[0-9]\+\.[0-9]\+\.[0-9]\+")
    
    if [ -z "$latest_version" ]; then
        echo "无法获取最新版本信息。"
        return
    fi
    
    # 提取当前版本号
    current_version=$(echo "$CURRENT_VERSION" | grep -o "v[0-9]\+\.[0-9]\+\.[0-9]\+")
    
    # 比较版本号
    if [ "$current_version" != "$latest_version" ]; then
        echo "发现新版本: $latest_version"
        echo "当前版本: $current_version"
        echo "正在自动更新..."
        if curl -o "$0.tmp" https://raw.githubusercontent.com/everett7623/nodeloc_vps_test/main/NLbench.sh && mv "$0.tmp" "$0"; then
            echo "更新完成。重新启动脚本..."
            exec "$0" "$@"
        else
            echo "更新失败。"
            rm -f "$0.tmp"
        fi
    else
        echo "当前已是最新版本。"
    fi
}

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

# 检测操作系统类型和版本
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        os_type=$ID
        os_version=$VERSION_ID
    elif type lsb_release >/dev/null 2>&1; then
        os_type=$(lsb_release -si)
        os_version=$(lsb_release -sr)
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        os_type=$DISTRIB_ID
        os_version=$DISTRIB_RELEASE
    else
        echo -e "${RED}无法检测操作系统类型和版本。${NC}"
        return 1
    fi
    echo -e "${YELLOW}检测到的系统: $os_type $os_version${NC}"
}

# 更新系统
update_system() {
    detect_os || return 1

    # 根据操作系统类型选择更新命令
    case "${os_type,,}" in
        ubuntu|debian|linuxmint|elementary|pop)
            update_cmd="apt-get update"
            upgrade_cmd="apt-get upgrade -y"
            install_cmd="apt-get install -y"
            ;;
        fedora|centos|rhel|ol|rocky|almalinux)
            if [ "${os_version%%.*}" -ge 22 ] || [ "${os_version%%.*}" -ge 8 ]; then
                update_cmd="dnf check-update"
                upgrade_cmd="dnf upgrade -y"
                install_cmd="dnf install -y"
            else
                update_cmd="yum check-update"
                upgrade_cmd="yum upgrade -y"
                install_cmd="yum install -y"
            fi
            ;;
        opensuse*|sles)
            update_cmd="zypper refresh"
            upgrade_cmd="zypper update -y"
            install_cmd="zypper install -y"
            ;;
        arch|manjaro)
            update_cmd="pacman -Sy"
            upgrade_cmd="pacman -Su --noconfirm"
            install_cmd="pacman -S --noconfirm"
            ;;
        alpine)
            update_cmd="apk update"
            upgrade_cmd="apk upgrade"
            install_cmd="apk add"
            ;;
        *)
            echo -e "${RED}不支持的 Linux 发行版: $os_type${NC}"
            return 1
            ;;
    esac

    echo -e "${YELLOW}正在更新系统...${NC}"
    sudo $update_cmd && sudo $upgrade_cmd
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}系统更新失败。${NC}"
        return 1
    fi
    echo -e "${GREEN}系统更新完成。${NC}"
    
    # 检查是否需要重启
    if [ -f /var/run/reboot-required ]; then
        echo -e "${YELLOW}系统更新需要重启才能完成。请在方便时重启系统。${NC}"
    fi
    return 0
}

# 更新系统并安装依赖
install_dependencies() {
    echo -e "${YELLOW}正在检查并安装必要的依赖项...${NC}"
    
    # 更新系统
    update_system || echo -e "${RED}系统更新失败。继续安装依赖项。${NC}"
    
    # 安装依赖
    local dependencies=("curl" "wget" "iperf3")
    
    for dep in "${dependencies[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            echo -e "${YELLOW}正在安装 $dep...${NC}"
            if ! sudo $install_cmd "$dep"; then
                echo -e "${RED}无法安装 $dep。请手动安装此依赖项。${NC}"
            fi
        else
            echo -e "${GREEN}$dep 已安装。${NC}"
        fi
    done
    
    echo -e "${GREEN}依赖项检查和安装完成。${NC}"
    clear
}

# 获取IP地址和ISP信息
ip_address_and_isp() {
    ipv4_address=$(curl -s --max-time 5 ipv4.ip.sb)
    if [ -z "$ipv4_address" ]; then
        ipv4_address=$(ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v '127.0.0.1' | head -n1)
    fi

    ipv6_address=$(curl -s --max-time 5 ipv6.ip.sb)
    if [ -z "$ipv6_address" ]; then
        ipv6_address=$(ip -6 addr show | grep -oP '(?<=inet6\s)[\da-f:]+' | grep -v '^::1' | grep -v '^fe80' | head -n1)
    fi

    # 获取ISP信息
    isp_info=$(curl -s ipinfo.io/org)

    # 检查是否为WARP或Cloudflare
    is_warp=false
    if echo "$isp_info" | grep -iq "cloudflare\|warp\|1.1.1.1"; then
        is_warp=true
    fi

    # 判断使用IPv6还是IPv4
    use_ipv6=false
    if [ "$is_warp" = true ] || [ -z "$ipv4_address" ]; then
        use_ipv6=true
    fi

    echo "IPv4: $ipv4_address"
    echo "IPv6: $ipv6_address"
    echo "ISP: $isp_info"
    echo "Is WARP: $is_warp"
    echo "Use IPv6: $use_ipv6"
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

run_iperf3_test() {
    echo -e "${GREEN}服务端VPS位于美国拉斯维加斯${NC}"
    echo -e "${GREEN}连接到服务端进行iperf3测试。。。${NC}"
    if iperf3 -c $AUXILIARY_VPS -p $IPERF_PORT -t $TEST_DURATION; then
    echo -e "${YELLOW}iperf3 测试完成${NC}"
    else
    echo -e "${RED}iperf3 测试失败${NC}"
    fi
}

# 统计使用次数
sum_run_times() {
    local COUNT=$(wget --no-check-certificate -qO- --tries=2 --timeout=2 "https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Feverett7623%2Fnodeloc_vps_test%2Fblob%2Fmain%2FNlbench.sh" 2>&1 | grep -m1 -oE "[0-9]+[ ]+/[ ]+[0-9]+")
    if [[ -n "$COUNT" ]]; then
        daily_count=$(cut -d " " -f1 <<< "$COUNT")
        total_count=$(cut -d " " -f3 <<< "$COUNT")
    else
        echo "Failed to fetch usage counts."
        daily_count=0
        total_count=0
    fi
}

# 执行单个脚本并输出结果到文件
run_script() {
    local script_number=$1
    local output_file=$2
    local temp_file=$(mktemp)
    # 调用ip_address_and_isp函数获取IP地址和ISP信息
    ip_address_and_isp
    case $script_number in
        # YABS
        1)
            echo -e "运行${YELLOW}YABS...${NC}"
            curl -sL yabs.sh | bash -s -- -i -5 | tee "$temp_file"
            sed -i 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file"
            sed -i 's/\.\.\./\.\.\.\n/g' "$temp_file"
            sed -i '/\.\.\./d' "$temp_file"
            sed -i '/^\s*$/d'   "$temp_file"
            cp "$temp_file" "${output_file}_yabs"
            ;;
        # Geekbench5
        2)
            echo -e "运行${YELLOW}Geekbench 5...${NC}"
            bash <(curl -sL gb5.top) | tee "$temp_file"
            sed -i 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file"
            sed -i 's/\x1B\[.*?[mGKH]//g' "$temp_file"
            sed -i 's/\r//' "$temp_file" 
            sed -i '/^$/d' "$temp_file" 
            sed -i -n '/当前时间：/,${p}' "$temp_file"
            cp "$temp_file" "${output_file}_gb5"
            ;;
        # 融合怪
        3)
            echo -e "运行${YELLOW}融合怪...${NC}"
            curl -L https://gitlab.com/spiritysdx/za/-/raw/main/ecs.sh -o ecs.sh && chmod +x ecs.sh && bash ecs.sh -m 1 <<< "y" | tee "$temp_file"
            sed -i 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file"
            sed -i 's/\.\.\.\.\.\./\.\.\.\.\.\.\n/g' "$temp_file"
            sed -i '1,/\.\.\.\.\.\./d' "$temp_file"
            sed -i -n '/--------------------- A Bench Script By spiritlhl ----------------------/,${s/^.*\(--------------------- A Bench Script By spiritlhl ----------------------\)/\1/;p}' "$temp_file"
            cp "$temp_file" "${output_file}_fusion"
            ;;
        # IP质量
        4)
            echo -e "运行${YELLOW}IP质量测试...${NC}"
            bash <(curl -Ls IP.Check.Place) | tee "$temp_file"
            sed -i 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file"
            sed -i -r 's/(⠋|⠙|⠹|⠸|⠼|⠴|⠦|⠧|⠇|⠏)/\n/g' "$temp_file"
            sed -i -r '/正在检测/d' "$temp_file"
            sed -i -n '/########################################################################/,${s/^.*\(########################################################################\)/\1/;p}' "$temp_file"
            cp "$temp_file" "${output_file}_ip_quality"
            ;;
        # 流媒体解锁
        5)
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
        6)
            echo -e "运行${YELLOW}响应测试...${NC}"
            bash <(curl -sL https://nodebench.mereith.com/scripts/curltime.sh) | tee "$temp_file"
            sed -i 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file"
            cp "$temp_file" "${output_file}_response"
            ;;
        # 多线程测速
        7)
            echo -e "运行${YELLOW}多线程测速...${NC}"
            if [ "$use_ipv6" = true ]; then
            echo "使用IPv6测试选项"
            bash <(curl -sL bash.icu/speedtest) <<< "3" | tee "$temp_file"
            else
            echo "使用IPv4测试选项"
             bash <(curl -sL bash.icu/speedtest) <<< "1" | tee "$temp_file"
            fi
            sed -r -i 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file"
            sed -i -r '1,/序号\:/d' "$temp_file"
            sed -i -r 's/(⠋|⠙|⠹|⠸|⠼|⠴|⠦|⠧|⠇|⠏)/\n/g' "$temp_file"
            sed -i -r '/测试进行中/d' "$temp_file"
            cp "$temp_file" "${output_file}_multi_thread"
            ;;
        # 单线程测速
        8)
            echo -e "运行${YELLOW}单线程测速...${NC}"
            if [ "$use_ipv6" = true ]; then
            echo "使用IPv6测试选项"
            bash <(curl -sL bash.icu/speedtest) <<< "17" | tee "$temp_file"
            else
            echo "使用IPv4测试选项"
            bash <(curl -sL bash.icu/speedtest) <<< "2" | tee "$temp_file"
            fi
            sed -r -i 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file"
            sed -i -r '1,/序号\:/d' "$temp_file"
            sed -i -r 's/(⠋|⠙|⠹|⠸|⠼|⠴|⠦|⠧|⠇|⠏)/\n/g' "$temp_file"
            sed -i -r '/测试进行中/d' "$temp_file"
            cp "$temp_file" "${output_file}_single_thread"
            ;;
        # iperf3测试
        9)
            echo -e "运行${YELLOW}iperf3测试...${NC}"
            run_iperf3_test | tee "$temp_file"
            sed -i -e 's/\x1B\[[0-9;]*[JKmsu]//g' "$temp_file"
            sed -i -r '1,/\[ ID\] /d' "$temp_file"
            sed -i '/^$/d' "$temp_file"
            cp "$temp_file" "${output_file}_iperf3"
            ;;
        # 回程路由
        10)
            echo -e "运行${YELLOW}回程路由测试...${NC}"
            if [ "$use_ipv6" = true ]; then
            echo "使用IPv6测试选项"
            wget -N --no-check-certificate https://raw.githubusercontent.com/Chennhaoo/Shell_Bash/master/AutoTrace.sh && chmod +x AutoTrace.sh && bash AutoTrace.sh <<< "4" | tee "$temp_file"
            else
            echo "使用IPv4测试选项"
            wget -N --no-check-certificate https://raw.githubusercontent.com/Chennhaoo/Shell_Bash/master/AutoTrace.sh && chmod +x AutoTrace.sh && bash AutoTrace.sh <<< "1" | tee "$temp_file"
            fi
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
    local sections=("YABS" "Geekbench5" "融合怪" "IP质量" "流媒体" "响应" "多线程测速" "单线程测速" "iperf3" "回程路由")
    local file_suffixes=("yabs" "gb5" "fusion" "ip_quality" "streaming" "response" "multi_thread" "single_thread" "iperf3" "route")

    echo "[tabs]" > "$final_output_file"

    for i in "${!sections[@]}"; do
        section="${sections[$i]}"
        suffix="${file_suffixes[$i]}"
        echo "[tab=\"$section\"]" >> "$final_output_file"
        echo "\`\`\`" >> "$final_output_file"
        if [ -f "${base_output_file}_${suffix}" ]; then
            cat "${base_output_file}_${suffix}" >> "$final_output_file"
            rm "${base_output_file}_${suffix}"
        fi
        echo "\`\`\`" >> "$final_output_file"
        echo "[/tab]" >> "$final_output_file"
    done

    # Adding remaining empty tabs
    local empty_tabs=("去程路由" "Ping.pe" "哪吒 ICMP" "其他")
    for tab in "${empty_tabs[@]}"; do
        echo "[tab=\"$tab\"]" >> "$final_output_file"
        echo "[/tab]" >> "$final_output_file"
    done

    echo "[/tabs]" >> "$final_output_file"

    echo "所有测试完成，结果已保存在 $final_output_file 中。"
    read -p "按回车键继续..."
    clear
}

# 执行全部脚本
run_all_scripts() {
    local base_output_file="NLvps_results_$(date +%Y%m%d_%H%M%S)"
    echo "开始执行全部测试脚本..."
    for i in {1..10}; do
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
    echo "2. Geekbench5"
    echo "3. 融合怪"
    echo "4. IP质量"
    echo "5. 流媒体解锁"
    echo "6. 响应测试"
    echo "7. 多线程测试"
    echo "8. 单线程测试"
    echo "9. iperf3"
    echo "10. 回程路由"
    echo "0. 返回"
    
    while true; do
        read -p "请输入要执行的脚本编号（用英文逗号分隔，例如：1,2,3):" script_numbers
        if [[ "$script_numbers" =~ ^(0|10|[1-9])(,(0|10|[1-9]))*$ ]]; then
            break
        else
            echo -e "${RED}无效输入，请输入0-10之间的数字，用英文逗号分隔。${NC}"
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
    echo -e "${GREEN}测试项目：${NC}Yabs，geekbench5，融合怪，IP质量，流媒体解锁，响应测试，多线程测试，单线程测试，iperf3，回程路由。"
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
    echo -e "${GREEN}Nodeloc聚合测试脚本 $CURRENT_VERSION ${NC}"
    echo -e "${GREEN}GitHub地址: https://github.com/everett7623/nodeloc_vps_test${NC}"
    echo -e "${GREEN}VPS选购: https://www.nodeloc.com/vps${NC}"
    echo ""
    echo -e "${colors[0]}  _   _  ___  ____  _____ _     ___   ____   __     ______  ____  ${NC}"
    echo -e "${colors[1]} | \ | |/ _ \|  _ \| ____| |   / _ \ / ___|  \ \   / /  _ \/ ___| ${NC}"
    echo -e "${colors[2]} |  \| | | | | | | |  _| | |  | | | | |       \ \ / /| |_) \___ \ ${NC}"
    echo -e "${colors[3]} | |\  | |_| | |_| | |___| |__| |_| | |___     \ V / |  __/ ___) |${NC}"
    echo -e "${colors[4]} |_| \_|\___/|____/|_____|_____\___/ \____|     \_/  |_|   |____/ ${NC}"
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

    # 检查更新
    check_update
    
    # 检查是不是root用户
    check_root
    
    # 检查并安装依赖
    install_dependencies
    
    # 调用函数获取统计数据
    sum_run_times

    # 主循环
    while true; do
        show_welcome
        main_menu
    done
}

# 运行主函数
main
