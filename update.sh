#!/bin/bash

update_scripts() {
    CURRENT_VERSION="2024-07-18 v1.0.4"  # 当前版本号
    SCRIPT_URL="https://raw.githubusercontent.com/everett7623/nodeloc_vps_test/main/Nlbench.sh"
    VERSION_URL="https://raw.githubusercontent.com/everett7623/nodeloc_vps_test/main/version.sh"
    
    # 获取远程版本号
    REMOTE_VERSION=$(curl -s $VERSION_URL)
    if [ -z "$REMOTE_VERSION" ]; then
        echo -e "${RED}无法获取远程版本信息。请检查您的网络连接。${NC}"
        sleep 2
        return 1
    fi

    # 对比版本号
    if [ "$REMOTE_VERSION" != "$CURRENT_VERSION" ]; then
        clear
        echo "脚本更新日志"
        echo "-------------------------"   
        echo "2024-07-05 v1.0.0"
        echo "初始化版本，包含基础功能和菜单选择，一键测试或者手动多选测试"
        echo "发现新版本 $REMOTE_VERSION，当前版本 $CURRENT_VERSION"
        echo "正在更新..."
        
        # 下载新的脚本文件
        if curl -s -o /tmp/Nlbench.sh $SCRIPT_URL; then
            if [ -f /tmp/Nlbench.sh ]; then
                NEW_VERSION=$(grep '^VERSION=' /tmp/Nlbench.sh | cut -d'"' -f2)
                sed -i "s/^CURRENT_VERSION=.*/CURRENT_VERSION=\"$NEW_VERSION\"/" "$0"
                
                # 替换脚本文件
                if mv /tmp/Nlbench.sh /path/to/Nlbench.sh; then
                    chmod +x /path/to/Nlbench.sh
                    echo -e "${GREEN}脚本更新成功！新版本: $NEW_VERSION${NC}"
                    echo -e "${YELLOW}请等待 3 秒...${NC}"
                    sleep 3
                    exit 0
                else
                    echo -e "${RED}无法替换脚本文件。请检查权限。${NC}"
                    sleep 2
                    return 1
                fi
            else
                echo -e "${RED}下载的新脚本文件不存在。请检查下载过程。${NC}"
                sleep 2
                return 1
            fi
        else
            echo -e "${RED}下载新版本失败。请稍后重试。${NC}"
            sleep 2
            return 1
        fi
    else
        echo -e "${GREEN}脚本已是最新版本 $CURRENT_VERSION。${NC}"
        sleep 2
        exit 0
    fi
}

update_scripts
