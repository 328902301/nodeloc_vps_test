# NodeLoc聚合测评脚本 [![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Feverett7623%2Fnodeloc_vps_test%2Fblob%2Fmain%2FNlbench.sh&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)

这是NodeLoc提供给各位用户的主机聚合测评脚本，可一键自动对主机进行Yabs、融合怪、IP质量、流媒体解锁，三网测速，iperf3，回程路由等测评，测评结束后将会保存结果为MarkDown文件，方便快速上传至NodeLoc论坛。

**版本：** 2024-07-05 v1.0.0

**Github地址：** https://github.com/everett7623/nodeloc_vps_test

**VPS 选购:** [NodeLoc VPS](https://www.nodeloc.com/vps)

### 使用方法
确保用户为ROOT，主机网络通畅，复制下面任意命令运行

**支持Debian/Ubuntu/Deepin，不支持CentOS**
```bash
wget -O Nlbench.sh https://raw.githubusercontent.com/everett7623/nodeloc_vps_test/main/Nlbench.sh && chmod +x Nlbench.sh && ./Nlbench.sh
```

### 效果图
![image](https://s.rmimg.com/2024/07/03/568e9f492ca50cd0af4cce8b88a6f156.png)

![image](https://s.rmimg.com/2024/07/03/b13a1c30c5ad58d6ad56c8ce0cdbb43c.png)

![image](https://s.rmimg.com/2024/07/03/40fa7d2f292b798199ef2b58d25e624b.png)

**测试结束后将生成MarkDown格式的文件，可直接将文件内容复制到[NodeLoc论坛](https://www.nodeloc.com/)，无需进行更多操作**


## 免责声明

* NodeLoc聚合测评脚本属于自用分享工具，本脚本仅为各类脚本聚合。
* 工具中所有脚本均来自互联网，未对官方脚本文件进行任何更改，不对脚本安全性负责。如果你比较在意安全，请勿使用各类一键脚本。

## 问题反馈

如果您在使用过程中遇到问题，或者有功能建议，欢迎通过 [GitHub Issues](https://github.com/everett7623/nodeloc_vps_test/issues) 提交反馈。

## 许可协议

本项目采用 [AGPL-3.0 license](LICENSE) 许可。

### 鸣谢
1. [Yabs脚本](https://yabs.sh)——[masonr](https://github.com/masonr)
2. [融合怪脚本](https://gitlab.com/spiritysdx/za/-/raw/main/ecs.sh)——[spirit lhl](https://gitlab.com/spiritysdx)
3. [IP质量测试脚本](https://IP.Check.Place)——[xykt](https://github.com/xykt/)
4. [流媒体测试脚本](https://media.ispvps.com)——[xykt](https://github.com/xykt/)
5. [响应测试脚本](https://nodebench.mereith.com/scripts/curltime.sh)——[nodebench](https://nodebench.mereith.com)
6. [测速脚本](https://bash.icu/speedtest)——[i-abc](https://github.com/i-abc)
7. [回程测试脚本](https://raw.githubusercontent.com/Chennhaoo/Shell_Bash/master/AutoTrace.sh)——[陈豪](https://github.com/Chennhaoo/)

特别感谢以上作者提供的脚本
