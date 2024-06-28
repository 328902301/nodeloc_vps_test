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
    echo "脚本将测试以下项目："
    echo "Yabs"
    echo ""
    echo -e "${RED}按任意键开始测试...${NC}"
    read -n 1 -s
    clear
}

# 定义一个数组来存储每个命令的输出
declare -a test_results

# 在每个命令执行后保存结果
run_and_capture() {
    local command_output
    command_output=$(eval "$1" 2>&1)
    test_results+=("$command_output")
    echo "$command_output"
}

# 运行所有测试
run_all_tests() {
    echo -e "${RED}开始测试，测试时间较长，请耐心等待...${NC}"

    # YABS
    echo -e "运行${YELLOW}YABS...${NC}"
    yabs_result=$(run_and_capture "wget -qO- yabs.sh | bash")

    # 格式化结果
    echo -e "${YELLOW}此报告由Nodeloc_VPS_自动脚本测试生成...${NC}"
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
