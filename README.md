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
#### 运行截图
![image](https://s.rmimg.com/2024/07/03/568e9f492ca50cd0af4cce8b88a6f156.png)

![image](https://s.rmimg.com/2024/07/03/b13a1c30c5ad58d6ad56c8ce0cdbb43c.png)

![image](https://s.rmimg.com/2024/07/03/40fa7d2f292b798199ef2b58d25e624b.png)
#### 生成内容
以NiiHost商家提供的香港国际线路机器测试，此机器以免费虚拟主机的形式将上架Free NodeLoc
```
[tabs]
[tab="YABS"]
# ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## #
#              Yet-Another-Bench-Script              #
#                     v2024-06-09                    #
# https://github.com/masonr/yet-another-bench-script #
# ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## #
Fri Jul  5 05:39:07 UTC 2024
Basic System Information:
---------------------------------
Uptime     : 2 days, 13 hours, 38 minutes
Processor  : Common KVM processor
CPU cores  : 4 @ 2299.996 MHz
AES-NI     : ✔ Enabled
VM-x/AMD-V : ❌ Disabled
RAM        : 7.7 GiB
Swap       : 0.0 KiB
Disk       : 78.7 GiB
Distro     : Debian GNU/Linux 12 (bookworm)
Kernel     : 6.1.0-22-amd64
VM Type    : KVM
IPv4/IPv6  : ✔ Online / ❌ Offline
IPv4 Network Information:
---------------------------------
ISP        : Eons Data Communications Limited
ASN        : AS138997 Eons Data Communications Limited
Location   : Ha Kwai Chung, Kwai Tsing (NKT)
Country    : Hong Kong

fio Disk Speed Tests (Mixed R/W 50/50) (Partition /dev/sda1):
---------------------------------
Block Size | 4k            (IOPS) | 64k           (IOPS)
  ------   | ---            ----  | ----           ---- 
Read       | 291.25 MB/s  (72.8k) | 606.45 MB/s   (9.4k)
Write      | 292.02 MB/s  (73.0k) | 609.64 MB/s   (9.5k)
Total      | 583.27 MB/s (145.8k) | 1.21 GB/s    (19.0k)
           |                      |                     
Block Size | 512k          (IOPS) | 1m            (IOPS)
  ------   | ---            ----  | ----           ---- 
Read       | 738.56 MB/s   (1.4k) | 857.80 MB/s    (837)
Write      | 777.81 MB/s   (1.5k) | 914.93 MB/s    (893)
Total      | 1.51 GB/s     (2.9k) | 1.77 GB/s     (1.7k)
iperf3 Network Speed Tests (IPv4):
---------------------------------
Provider        | Location (Link)           | Send Speed      | Recv Speed      | Ping           
-----           | -----                     | ----            | ----            | ----           

Clouvider       | London, UK (10G)          | 288 Mbits/sec   | 705 Mbits/sec   | 237 ms         

Eranium         | Amsterdam, NL (100G)      | busy            | busy            | --             

Uztelecom       | Tashkent, UZ (10G)        | busy            | busy            | 207 ms         

Leaseweb        | Singapore, SG (10G)       | 3.31 Gbits/sec  | 5.15 Gbits/sec  | 33.6 ms        

Clouvider       | Los Angeles, CA, US (10G) | 597 Mbits/sec   | 1.06 Gbits/sec  | 173 ms         

Leaseweb        | NYC, NY, US (10G)         | 557 Mbits/sec   | 792 Mbits/sec   | 225 ms         

Edgoo           | Sao Paulo, BR (1G)        | 492 Mbits/sec   | 511 Mbits/sec   | 322 ms         
 *cue elevator music*
Geekbench 6 Benchmark Test:
---------------------------------
Test            | Value                         
                |                               
Single Core     | 562                           
Multi Core      | 1760                          
Full Test       | https://browser.geekbench.com/v6/cpu/6788766
YABS completed in 18 min 10 sec
[/tab]
[tab="融合怪"]

[H--------------------- A Bench Script By spiritlhl ----------------------
                   测评频道: https://t.me/vps_reviews                    
版本：2024.06.24
更新日志：VPS融合怪测试(集百家之长)                       
---------------------基础信息查询--感谢所有开源项目---------------------
 CPU 型号          : Common KVM processor
 CPU 核心数        : 4
 CPU 频率          : 2299.996 MHz
 CPU 缓存          : L1: 128.00 KB / L2: 16.00 MB / L3: 16.00 MB
 AES-NI指令集      : ✔ Enabled
 VM-x/AMD-V支持    : ❌ Disabled
 内存              : 502.55 MiB / 7.73 GiB
 Swap              : [ no swap partition or swap file detected ]
 硬盘空间          : 2.44 GiB / 78.58 GiB
 启动盘路径        : /dev/sda1
 系统在线时间      : 2 days, 13 hour 56 min
 负载              : 1.47, 1.75, 0.98
 系统              : Debian GNU/Linux 12 (bookworm) (x86_64)
 架构              : x86_64 (64 Bit)
 内核              : 6.1.0-22-amd64
 TCP加速方式       : cubic
 虚拟化架构        : KVM
 NAT类型           : Full Cone
 IPV4 ASN          : AS138997 Eons Data Communications Limited
 IPV4 位置         : Kwai Chung / Kwai Tsing / HK
----------------------CPU测试--通过sysbench测试-------------------------
 -> CPU 测试中 (Fast Mode, 1-Pass @ 5sec)

 1 线程测试(单核)得分: 		1/1 
 1 线程测试(单核)得分: 		895 Scores

 4 线程测试(多核)得分: 		1/1 
 4 线程测试(多核)得分: 		3086 Scores
---------------------内存测试--感谢lemonbench开源-----------------------
 -> 内存测试 Test (Fast Mode, 1-Pass @ 5sec)

 单线程读测试:		1/1 
 单线程读测试:		17645.38 MB/s

 单线程写测试:		1/1 
 单线程写测试:		13026.89 MB/s
------------------磁盘dd读写测试--感谢lemonbench开源--------------------
 -> 磁盘IO测试中 (4K Block/1M Block, Direct Mode)
 测试操作		写速度					读速度
 100MB-4K Block		->
 100MB-4K Block		44.5 MB/s (10.87K IOPS, 2.36s)		->
 100MB-4K Block		44.5 MB/s (10.87 IOPS, 2.36s)		57.2 MB/s (13967 IOPS, 1.83s)
 1GB-1M Block		->
 1GB-1M Block		534 MB/s (509 IOPS, 1.97s)		->
 1GB-1M Block		534 MB/s (509 IOPS, 1.97s)		1.2 GB/s (1107 IOPS, 0.90s)
---------------------磁盘fio读写测试--感谢yabs开源----------------------

Running fio test...
Block Size | 4k            (IOPS) | 64k           (IOPS)
  ------   | ---            ----  | ----           ---- 
Read       | 292.96 MB/s  (73.2k) | 609.27 MB/s   (9.5k)
Write      | 293.73 MB/s  (73.4k) | 612.48 MB/s   (9.5k)
Total      | 586.69 MB/s (146.6k) | 1.22 GB/s    (19.0k)
           |                      |                     
Block Size | 512k          (IOPS) | 1m            (IOPS)
  ------   | ---            ----  | ----           ---- 
Read       | 746.12 MB/s   (1.4k) | 852.75 MB/s    (832)
Write      | 785.76 MB/s   (1.5k) | 909.55 MB/s    (888)
Total      | 1.53 GB/s     (2.9k) | 1.76 GB/s     (1.7k)
------------流媒体解锁--基于oneclickvirt/CommonMediaTests开源-----------
以下测试的解锁地区是准确的，但是不是完整解锁的判断可能有误，这方面仅作参考使用
----------------Netflix-----------------
[IPV4]
您的出口IP完整解锁Netflix，支持非自制剧的观看
NF所识别的IP地域信息：中国香港
[IPV6]
您的网络可能没有正常配置IPv6，或者没有IPv6网络接入
----------------Youtube-----------------
[IPV4]
连接方式: Youtube Video Server
视频缓存节点地域: 中国香港(HKG33S01)
Youtube识别地域: 中国香港(HK)
[IPV6]
Youtube在您的出口IP所在的国家不提供服务
---------------DisneyPlus---------------
[IPV4]
当前出口所在地区解锁DisneyPlus
区域：HK 区
[IPV6]
DisneyPlus在您的出口IP所在的国家不提供服务
解锁Netflix，Youtube，DisneyPlus上面和下面进行比较，不同之处自行判断
----------------流媒体解锁--感谢RegionRestrictionCheck开源--------------
 以下为IPV4网络测试，若无IPV4网络则无输出
============[ Multination ]============

 Dazn:					Yes (Region: HK)

 Disney+:				Yes (Region: HK)

 Netflix:				Yes (Region: HK)

 YouTube Premium:			Yes (Region: HK)

 Amazon Prime Video:			Yes (Region: HK)

 TVBAnywhere+:				No

 Spotify Registration:			Yes (Region: HK)

 Instagram Licensed Audio:		No

 OneTrust Region:			HK [Kwai Tsing]

 iQyi Oversea Region:			HK

 Bing Region:				HK

 YouTube CDN:				Hong Kong

 Netflix Preferred CDN:			Hong Kong

 ChatGPT:				No (Only Available with Mobile APP)

 Wikipedia Editability:			No

 Google Search CAPTCHA Free:		Yes

 Steam Currency:			HKD
 ---Forum---

 Reddit:				Yes
=======================================
 以下为IPV6网络测试，若无IPV6网络则无输出
---------------TikTok解锁--感谢lmc999的源脚本及fscarmen PR--------------

 Tiktok Region:		Failed
-------------IP质量检测--基于oneclickvirt/securityCheck使用-------------
数据仅作参考，不代表100%准确，如果和实际情况不一致请手动查询多个数据库比对
以下为各数据库编号，输出结果后将自带数据库来源对应的编号
ipinfo数据库  [0] | scamalytics数据库 [1] | virustotal数据库   [2] | abuseipdb数据库   [3] | ip2location数据库    [4]
ip-api数据库  [5] | ipwhois数据库     [6] | ipregistry数据库   [7] | ipdata数据库      [8] | db-ip数据库          [9]
ipapiis数据库 [A] | ipapicom数据库    [B] | bigdatacloud数据库 [C] | cheervision数据库 [D] | ipqualityscore数据库 [E]
IPV4:
安全得分:
声誉(越高越好): 0 [2] 
信任得分(越高越好): 37 [8]
VPN得分(越低越好): 10 [8] 
代理得分(越低越好): 100 [8] 
社区投票-无害: 0 [2] 
社区投票-恶意: 0 [2] 
威胁得分(越低越好): 79 [8] 
欺诈得分(越低越好): 17 [1] 72 [E]
滥用得分(越低越好): 0 [3] 
ASN滥用得分(越低越好): 0.0008 (Low) [A] 
公司滥用得分(越低越好): 0.0017 (Low) [A] 
威胁级别: low [9 B] 
黑名单记录统计:(有多少黑名单网站有记录):
无害记录数: 0 [2]  恶意记录数: 0 [2]  可疑记录数: 0 [2]  无记录数: 92 [2]  
安全信息:
使用类型: unknown [C] DataCenter/WebHosting/Transit [3] hosting [0 7 A] corporate [9] business [8]
公司类型: isp [7] business [0] hosting [A]
是否云提供商: Yes [7 D] 
是否数据中心: Yes [1 A] No [0 5 6 8 C]
是否移动设备: No [5 A C] Yes [E]
是否代理: No [0 1 4 5 6 7 8 9 A B C D] Yes [E]
是否VPN: Yes [E] No [0 1 6 7 A C D]
是否Tor: No [0 1 3 6 7 8 A B C D E] 
是否Tor出口: No [1 7 D] 
是否网络爬虫: No [9 A B E] 
是否匿名: No [1 6 7 8 D]
是否攻击者: No [7 8 D] 
是否滥用者: No [7 8 A C D E] 
是否威胁: No [7 8 C D] 
是否中继: No [0 7 8 C D] 
是否Bogon: No [7 8 A C D] 
是否机器人: No [E] 
DNS-黑名单: 311(Total_Check) 0(Clean) 9(Blacklisted) 13(Other) 
Google搜索可行性：YES
-------------邮件端口检测--基于oneclickvirt/portchecker开源-------------
Platform  SMTP  SMTPS POP3  POP3S IMAP  IMAPS
LocalPort ✘     ✔     ✔     ✔     ✔     ✔    
QQ        ✔     ✔     ✔     ✘     ✔     ✘    
163       ✔     ✔     ✔     ✘     ✔     ✘    
Sohu      ✔     ✔     ✔     ✘     ✔     ✘    
Yandex    ✔     ✔     ✔     ✘     ✔     ✘    
Gmail     ✔     ✔     ✘     ✘     ✘     ✘    
Outlook   ✔     ✘     ✔     ✘     ✔     ✘    
Office365 ✔     ✘     ✔     ✘     ✔     ✘    
Yahoo     ✔     ✔     ✘     ✘     ✘     ✘    
MailCOM   ✔     ✔     ✔     ✘     ✔     ✘    
MailRU    ✔     ✔     ✘     ✘     ✘     ✘    
AOL       ✔     ✔     ✘     ✘     ✘     ✘    
GMX       ✔     ✘     ✔     ✘     ✔     ✘    
Sina      ✔     ✘     ✔     ✘     ✔     ✘    
----------------三网回程--基于oneclickvirt/backtrace开源----------------
北京电信 219.141.140.10  电信163    [普通线路] 
北京联通 202.106.195.68  检测不到回程路由节点的IP地址
北京移动 221.179.155.161 移动CMI    [普通线路] 
上海电信 202.96.209.133  电信163    [普通线路] 
上海联通 210.22.97.1     检测不到回程路由节点的IP地址
上海移动 211.136.112.200 移动CMI    [普通线路] 
广州电信 58.60.188.222   电信163    [普通线路] 
广州联通 210.21.196.6    检测不到回程路由节点的IP地址
广州移动 120.196.165.24  移动CMI    [普通线路] 
成都电信 61.139.2.69     电信163    [普通线路] 
成都联通 119.6.6.6       检测不到回程路由节点的IP地址
成都移动 211.137.96.205  移动CMI    [普通线路] 
准确线路自行查看详细路由，本测试结果仅作参考
同一目标地址多个线路时，可能检测已越过汇聚层，除了第一个线路外，后续信息可能无效
---------------------回程路由--感谢fscarmen开源及PR---------------------
依次测试电信/联通/移动经过的地区及线路，核心程序来自ipip.net或nexttrace，请知悉!
广州电信 58.60.188.222
0.39 ms  AS138997  中国, 香港, cogentco.com
0.81 ms  AS138997  中国, 香港, eons.cloud
2.82 ms  AS138997  中国, 香港, eons.cloud
0.67 ms  AS138997  中国, 香港, eons.cloud
2.68 ms  AS138997  中国, 香港, eons.cloud
0.71 ms  AS138997  中国, 香港, eons.cloud
0.88 ms  AS138997  中国, 香港, eons.cloud
1.62 ms  AS3356  中国, 香港, level3.com
159.63 ms  AS3356  美国, 加利福尼亚州, 圣何塞, level3.com
327.71 ms  AS4134  中国, 广东, 广州, chinatelecom.com.cn, 电信
324.31 ms  AS4134  中国, 广东, 广州, chinatelecom.com.cn, 电信
330.29 ms  AS4134  中国, 广东, 广州, chinatelecom.com.cn, 电信
335.84 ms  AS4134  中国, 广东, 深圳, chinatelecom.com.cn, 电信
广州联通 210.21.196.6
0.43 ms  AS138997  中国, 香港, cogentco.com
0.91 ms  AS138997  中国, 香港, eons.cloud
3.14 ms  AS138997  中国, 香港, eons.cloud
0.63 ms  AS138997  中国, 香港, eons.cloud
4.01 ms  AS138997  中国, 香港, eons.cloud
0.57 ms  AS138997  中国, 香港, eons.cloud
50.81 ms  AS138997  中国, 香港, eons.cloud
47.90 ms  AS7578  COGENTCO.COM 骨干网, cogentco.com
47.89 ms  AS7578  COGENTCO.COM 骨干网, cogentco.com
47.98 ms  AS7578  中国, 台湾, 台北市, cogentco.com
47.90 ms  AS7578  日本, 东京都, 东京, cogentco.com
47.88 ms  AS7578  日本, 东京都, 东京, cogentco.com
48.03 ms  AS7578  日本, 东京都, 东京, cogentco.com
91.81 ms  AS17676  中国, 北京, bbtec.net
98.21 ms  AS4837  中国, 北京, chinaunicom.com, 联通
95.86 ms  AS17816  中国, 广东, 广州, chinaunicom.com, 联通
广州移动 120.196.165.24
0.34 ms  AS138997  中国, 香港, cogentco.com
0.70 ms  AS138997  中国, 香港, eons.cloud
3.41 ms  AS138997  中国, 香港, eons.cloud
0.32 ms  AS138997  中国, 香港, eons.cloud
3.67 ms  AS138997  中国, 香港, eons.cloud
0.63 ms  AS138997  中国, 香港, eons.cloud
1.27 ms  *  中国, 香港, nube.sh
35.10 ms  AS58453  新加坡, chinamobile.com, 移动
38.32 ms  AS58453  中国, 香港, chinamobile.com, 移动
87.87 ms  AS58453  中国, 广东, 广州, chinamobile.com, 移动
87.65 ms  AS9808  中国, 广东, 广州, chinamobile.com, 移动
44.19 ms  AS9808  中国, 广东, 广州, chinamobile.com, 移动
45.37 ms  AS9808  中国, 广东, 广州, chinamobile.com, 移动
44.18 ms  AS56040  中国, 广东, 深圳, chinamobile.com, 移动
--------------------自动更新测速节点列表--本脚本原创--------------------
位置		 上传速度	 下载速度	 延迟	  丢包率
--------------------自动更新测速节点列表--本脚本原创--------------------
位置		 上传速度	 下载速度	 延迟	  丢包率

------------------------------------------------------------------------
 总共花费      : 4 分 10 秒
 时间          : Fri Jul  5 06:01:40 UTC 2024

------------------------------------------------------------------------
  短链:
    https://paste.spiritlhl.net/u/KNVPE0.txt
[/tab]
[tab="IP质量"]
########################################################################

                       IP质量体检报告：38.181.*.*

                    bash <(curl -sL IP.Check.Place)

                   https://github.com/xykt/IPQuality

        报告时间：2024-07-05 14:02:39 CST  脚本版本：v2024-07-02
########################################################################

一、基础信息（Maxmind 数据库）

自治系统号：            AS138997

组织：                  Eons Data Communications Limited

坐标：                  114°8′3″E, 22°21′14″N

地图：                  https://check.place/22.3539,114.1342,15,cn

城市：                  Kwai Tsing, 下葵涌

使用地：                [HK]香港, [AS]亚洲

注册地：                [US]美国

时区：                  Asia/Hong_Kong

IP类型：                 广播IP 

二、IP类型属性

数据库：      IPinfo    ipregistry    ipapi     AbuseIPDB  IP2LOCATION 

使用类型：     机房        机房        机房        机房        机房    

公司类型：     商业        机房        机房    

三、风险评分

风险等级：      极低         低       中等       高         极高

SCAMALYTICS：           17|低风险

ipapi：       0.17%|低风险

AbuseIPDB：    0|低风险

IPQS：                                   82|可疑IP

DB-IP：         |低风险

四、风险因子

库： IP2LOCATION ipapi ipregistry IPQS SCAMALYTICS ipdata IPinfo IPWHOIS

地区：    [HK]    [HK]    [HK]    [HK]    [HK]    [HK]    [HK]    [HK]

代理：     否      否      否      是      否      否      否      否 

Tor：      否      否      否      否      否      否      否      否 

VPN：      否      否      否      是      否      无      否      否 

服务器：   是      是      是      无      否      否      否      否 

滥用：     否      否      否      否      无      否      无      无 

机器人：   否      否      无      否      否      无      无      无 

五、流媒体及AI服务解锁检测

服务商：  TikTok   Disney+  Netflix Youtube  AmazonPV  Spotify  ChatGPT 

状态：     失败     解锁     解锁     解锁     解锁     解锁     仅APP  

地区：              [HK]     [HK]     [HK]     [HK]     [HK]     [HK]   

方式：              原生     原生     原生     原生     原生     原生   

六、邮局连通性及黑名单检测

本地25端口：可用

通信：Gmail Outlook Yahoo Apple QQ MailRU AOL GMX MailCOM 163 Sohu Sina 

IP地址黑名单数据库：  有效 439   正常 429   已标记 8   黑名单 2

========================================================================

今日IP检测量：183；总检测量：39828。感谢使用xy系列脚本！ 

报告链接：https://Report.Check.Place/IP/7N4NUD3MV.svg

[/tab]
[tab="流媒体"]
项目地址 https://github.com/lmc999/RegionRestrictionCheck 
改版地址 https://github.com/xykt/RegionRestrictionCheck 
脚本适配OS: CentOS 6+, Ubuntu 14.04+, Debian 8+, MacOS, Android (Termux), iOS (iSH)
 ** 测试时间: Fri Jul  5 06:04:08 UTC 2024
 ** 正在测试IPv4解锁情况 
--------------------------------
 ** 您的网络为: Eons Data Communications (38.181.*.*) 
============[ Multination ]============

 Dazn:			原生解锁	Yes (Region: HK)

 TikTok:				Failed

 Disney+:		原生解锁	Yes (Region: HK)

 Netflix:		原生解锁	Yes (Region: HK)

 YouTube Premium:	原生解锁	Yes (Region: HK)

 Amazon Prime Video:	原生解锁	Yes (Region: HK)

 TVBAnywhere+:				No

 iQyi Oversea Region:	原生解锁	HK

 YouTube CDN:				Hong Kong 

 Netflix Preferred CDN:			Hong Kong  

 Spotify Registration:	原生解锁	Yes (Region: HK)

 Steam Currency:			HKD

 ChatGPT:		原生解锁	APP Only (Region: HK)

 Bing Region:				HK

 Wikipedia Editability:			No
 Instagram Licensed Audio:		->
 Instagram Licensed Audio:		Failed
 ---Forum---

 Reddit:				Yes
=======================================
=============[ Hong Kong ]=============

 Now E:					Yes

 Viu.com:		原生解锁	Yes (Region: HK)

 Viu.TV:				Yes

 MyTVSuper:				No

 HBO GO Asia:				Yes (Region: HK)

 BiliBili Hongkong/Macau/Taiwan:	Yes
=======================================
当前主机不支持IPv6,跳过...
本次测试已结束，感谢使用此脚本 
检测脚本当天运行次数: 118; 共计运行次数: 119848 
[/tab]
[tab="响应"]
正在测试 https://www.google.com
尝试 1: 123.977000 ms
尝试 2: 113.421000 ms
尝试 3: 118.469000 ms
尝试 4: 122.473000 ms
尝试 5: 114.715000 ms
平均时间: 118.61 ms for https://www.google.com
----------------------------------
正在测试 https://www.facebook.com
尝试 1: 267.527000 ms
尝试 2: 245.732000 ms
尝试 3: 247.248000 ms
尝试 4: 246.017000 ms
尝试 5: 235.772000 ms
平均时间: 248.45 ms for https://www.facebook.com
----------------------------------
正在测试 https://www.twitter.com
尝试 1: 269.469000 ms
尝试 2: 269.910000 ms
尝试 3: 269.345000 ms
尝试 4: 269.430000 ms
尝试 5: 270.358000 ms
平均时间: 269.70 ms for https://www.twitter.com
----------------------------------
正在测试 https://www.youtube.com
尝试 1: 296.221000 ms
尝试 2: 216.790000 ms
尝试 3: 185.519000 ms
尝试 4: 210.229000 ms
尝试 5: 208.982000 ms
平均时间: 223.54 ms for https://www.youtube.com
----------------------------------
正在测试 https://www.netflix.com
尝试 1: 685.459000 ms
尝试 2: 656.525000 ms
尝试 3: 676.979000 ms
尝试 4: 595.173000 ms
尝试 5: 580.629000 ms
平均时间: 638.95 ms for https://www.netflix.com
----------------------------------
正在测试 https://chat.openai.com
尝试 1: 79.918000 ms
尝试 2: 79.438000 ms
尝试 3: 79.444000 ms
尝试 4: 82.534000 ms
尝试 5: 77.781000 ms
平均时间: 79.82 ms for https://chat.openai.com
----------------------------------
正在测试 https://www.github.com
尝试 1: 124.884000 ms
尝试 2: 117.591000 ms
尝试 3: 134.474000 ms
尝试 4: 137.963000 ms
尝试 5: 143.214000 ms
平均时间: 131.62 ms for https://www.github.com
----------------------------------
网站                          平均时间(ms)
--------------------------------------------------
https://www.google.com               118.61 ms
https://www.facebook.com             248.45 ms
https://www.twitter.com              269.70 ms
https://www.youtube.com              223.54 ms
https://www.netflix.com              638.95 ms
https://chat.openai.com               79.82 ms
https://www.github.com               131.62 ms
--------------------------------------------------
Total Avg                            244.38 ms

[/tab]
[tab="多线程测速"]

 Version               : v2024-04-25
 Usage                 : bash <(curl -sL bash.icu/speedtest)
 GitHub                : https://github.com/i-abc/speedtest
------------------------------------------------------------------------
大陆三网+教育网 IPv4 多线程测速，v2024-03-15
------------------------------------------------------------------------
测速节点            下载/Mbps      上传/Mbps      延迟/ms      抖动/ms
 
最近的测速点        1.14 Mbps      4.99 Mbps      1.95 ms      0.05 ms      
 
电信 安徽合肥 5G    140.90 Mbps    49.10 Mbps     339.02 ms    4.24 ms      
 
电信 浙江宁波 5G    867.27 Mbps    125.26 Mbps    312.23 ms    0.91 ms      
 
电信 江苏镇江 5G    1079.01 Mbps   98.77 Mbps     292.75 ms    2.43 ms      
 
电信 江苏南京 5G    896.52 Mbps    1.77 Mbps      297.27 ms    0.52 ms      
 

测速次数过多，暂时被限制，请过一段时间后再进行测试
 
教育网 北京           失败         350.18 Mbps    35.55 ms     0.31 ms      
 
教育网 上海 1       22.57 Mbps     10.89 Mbps     62.73 ms     0.78 ms      
 
教育网 上海 2       17.47 Mbps     128.37 Mbps    60.00 ms      失败        
 
教育网 江苏南京 1   747.91 Mbps    1094.04 Mbps   61.00 ms      失败        
 

------------------------------------------------------------------------
系统时间：2024-07-05 06:16:32 UTC
北京时间: 2024-07-05 14:16:32 CST
------------------------------------------------------------------------


[/tab]
[tab="单线程测速"]

 Version               : v2024-04-25
 Usage                 : bash <(curl -sL bash.icu/speedtest)
 GitHub                : https://github.com/i-abc/speedtest
------------------------------------------------------------------------
大陆三网+教育网 IPv4 单线程测速，v2024-03-15
------------------------------------------------------------------------
测速节点            下载/Mbps      上传/Mbps      延迟/ms      抖动/ms
 
电信 四川成都       0.60 Mbps      74.70 Mbps     326.00 ms    18.20 ms     
 
电信 江苏苏州       2.00 Mbps      0.20 Mbps      317.40 ms    17.80 ms     
 
电信 浙江杭州       5.80 Mbps        失败         328.60 ms    0.50 ms      
 
电信 安徽合肥 5G    1.70 Mbps      0.20 Mbps      326.80 ms    201.90 ms    
 
电信 浙江宁波 5G    2.40 Mbps      16.50 Mbps     322.20 ms    53.70 ms     
 
电信 江苏镇江 5G    63.40 Mbps     48.40 Mbps     293.60 ms    38.40 ms     
 
电信 江苏南京 5G    64.80 Mbps       失败         296.00 ms    13.70 ms     
 
移动 浙江杭州 5G    165.30 Mbps    63.00 Mbps     35.80 ms     21.40 ms     
 
联通 江苏无锡         失败           失败         87.60 ms     2.80 ms      
 
联通 天津 5G        0.10 Mbps      107.20 Mbps    235.80 ms    4.70 ms      
 
广电 重庆             失败           失败         232.30 ms    16.10 ms     

------------------------------------------------------------------------
系统时间：2024-07-05 06:28:06 UTC
北京时间: 2024-07-05 14:28:06 CST
------------------------------------------------------------------------


[/tab]
[tab="iperf3"]

[  5]   0.00-1.00   sec  1.04 MBytes  8.69 Mbits/sec    0    327 KBytes       
[  7]   0.00-1.00   sec   671 KBytes  5.50 Mbits/sec    0    210 KBytes       
[  9]   0.00-1.00   sec  1.58 MBytes  13.3 Mbits/sec    0    434 KBytes       
[SUM]   0.00-1.00   sec  3.27 MBytes  27.5 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]   1.00-2.00   sec  10.2 MBytes  85.7 Mbits/sec    0   3.58 MBytes       
[  7]   1.00-2.00   sec  10.7 MBytes  89.9 Mbits/sec    0   3.30 MBytes       
[  9]   1.00-2.00   sec  11.4 MBytes  95.8 Mbits/sec    0   3.34 MBytes       
[SUM]   1.00-2.00   sec  32.4 MBytes   271 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]   2.00-3.00   sec  11.2 MBytes  94.4 Mbits/sec    0   3.58 MBytes       
[  7]   2.00-3.00   sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]   2.00-3.00   sec  10.0 MBytes  83.9 Mbits/sec    0   3.34 MBytes       
[SUM]   2.00-3.00   sec  32.5 MBytes   273 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]   3.00-4.00   sec  11.2 MBytes  94.4 Mbits/sec    0   3.58 MBytes       
[  7]   3.00-4.00   sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]   3.00-4.00   sec  11.2 MBytes  94.4 Mbits/sec    0   3.34 MBytes       
[SUM]   3.00-4.00   sec  33.8 MBytes   283 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]   4.00-5.00   sec  10.0 MBytes  83.9 Mbits/sec    0   3.58 MBytes       
[  7]   4.00-5.00   sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]   4.00-5.00   sec  11.2 MBytes  94.4 Mbits/sec    0   3.34 MBytes       
[SUM]   4.00-5.00   sec  32.5 MBytes   273 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]   5.00-6.00   sec  10.0 MBytes  83.9 Mbits/sec    0   3.58 MBytes       
[  7]   5.00-6.00   sec  10.0 MBytes  83.9 Mbits/sec    0   3.30 MBytes       
[  9]   5.00-6.00   sec  10.0 MBytes  83.9 Mbits/sec    0   3.34 MBytes       
[SUM]   5.00-6.00   sec  30.0 MBytes   252 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]   6.00-7.00   sec  11.2 MBytes  94.4 Mbits/sec    0   3.58 MBytes       
[  7]   6.00-7.00   sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]   6.00-7.00   sec  11.2 MBytes  94.4 Mbits/sec    0   3.34 MBytes       
[SUM]   6.00-7.00   sec  33.8 MBytes   283 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]   7.00-8.00   sec  11.2 MBytes  94.4 Mbits/sec    0   3.58 MBytes       
[  7]   7.00-8.00   sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]   7.00-8.00   sec  11.2 MBytes  94.4 Mbits/sec    0   3.34 MBytes       
[SUM]   7.00-8.00   sec  33.8 MBytes   283 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]   8.00-9.00   sec  11.2 MBytes  94.4 Mbits/sec    0   3.58 MBytes       
[  7]   8.00-9.00   sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]   8.00-9.00   sec  11.2 MBytes  94.4 Mbits/sec    0   3.34 MBytes       
[SUM]   8.00-9.00   sec  33.8 MBytes   283 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]   9.00-10.00  sec  12.5 MBytes   105 Mbits/sec    0   3.58 MBytes       
[  7]   9.00-10.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]   9.00-10.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.34 MBytes       
[SUM]   9.00-10.00  sec  35.0 MBytes   294 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]  10.00-11.00  sec  10.0 MBytes  83.9 Mbits/sec    0   3.58 MBytes       
[  7]  10.00-11.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]  10.00-11.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.34 MBytes       
[SUM]  10.00-11.00  sec  32.5 MBytes   273 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]  11.00-12.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.58 MBytes       
[  7]  11.00-12.00  sec  10.0 MBytes  83.9 Mbits/sec    0   3.30 MBytes       
[  9]  11.00-12.00  sec  10.0 MBytes  83.9 Mbits/sec    0   3.34 MBytes       
[SUM]  11.00-12.00  sec  31.2 MBytes   262 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]  12.00-13.00  sec  10.0 MBytes  83.9 Mbits/sec    0   3.58 MBytes       
[  7]  12.00-13.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]  12.00-13.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.34 MBytes       
[SUM]  12.00-13.00  sec  32.5 MBytes   273 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]  13.00-14.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.58 MBytes       
[  7]  13.00-14.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]  13.00-14.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.34 MBytes       
[SUM]  13.00-14.00  sec  33.8 MBytes   283 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]  14.00-15.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.58 MBytes       
[  7]  14.00-15.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]  14.00-15.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.34 MBytes       
[SUM]  14.00-15.00  sec  33.8 MBytes   283 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]  15.00-16.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.58 MBytes       
[  7]  15.00-16.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]  15.00-16.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.34 MBytes       
[SUM]  15.00-16.00  sec  33.8 MBytes   283 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]  16.00-17.00  sec  12.5 MBytes   105 Mbits/sec    0   3.58 MBytes       
[  7]  16.00-17.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]  16.00-17.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.34 MBytes       
[SUM]  16.00-17.00  sec  35.0 MBytes   294 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]  17.00-18.00  sec  8.75 MBytes  73.4 Mbits/sec    0   3.58 MBytes       
[  7]  17.00-18.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]  17.00-18.00  sec  10.0 MBytes  83.9 Mbits/sec    0   3.34 MBytes       
[SUM]  17.00-18.00  sec  30.0 MBytes   252 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]  18.00-19.00  sec  10.0 MBytes  83.9 Mbits/sec    0   3.58 MBytes       
[  7]  18.00-19.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]  18.00-19.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.34 MBytes       
[SUM]  18.00-19.00  sec  32.5 MBytes   273 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]  19.00-20.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.58 MBytes       
[  7]  19.00-20.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]  19.00-20.00  sec  10.0 MBytes  83.9 Mbits/sec    0   3.34 MBytes       
[SUM]  19.00-20.00  sec  32.5 MBytes   273 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]  20.00-21.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.58 MBytes       
[  7]  20.00-21.00  sec  10.0 MBytes  83.9 Mbits/sec    0   3.30 MBytes       
[  9]  20.00-21.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.34 MBytes       
[SUM]  20.00-21.00  sec  32.5 MBytes   273 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]  21.00-22.00  sec  12.5 MBytes   105 Mbits/sec    0   3.58 MBytes       
[  7]  21.00-22.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]  21.00-22.00  sec  12.5 MBytes   105 Mbits/sec    0   3.34 MBytes       
[SUM]  21.00-22.00  sec  36.2 MBytes   304 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]  22.00-23.00  sec  10.0 MBytes  83.9 Mbits/sec    0   3.58 MBytes       
[  7]  22.00-23.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]  22.00-23.00  sec  10.0 MBytes  83.9 Mbits/sec    0   3.34 MBytes       
[SUM]  22.00-23.00  sec  31.2 MBytes   262 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]  23.00-24.00  sec  10.0 MBytes  83.9 Mbits/sec    0   3.58 MBytes       
[  7]  23.00-24.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]  23.00-24.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.34 MBytes       
[SUM]  23.00-24.00  sec  32.5 MBytes   273 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]  24.00-25.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.58 MBytes       
[  7]  24.00-25.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]  24.00-25.00  sec  10.0 MBytes  83.9 Mbits/sec    0   3.34 MBytes       
[SUM]  24.00-25.00  sec  32.5 MBytes   273 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]  25.00-26.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.58 MBytes       
[  7]  25.00-26.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]  25.00-26.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.34 MBytes       
[SUM]  25.00-26.00  sec  33.8 MBytes   283 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]  26.00-27.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.58 MBytes       
[  7]  26.00-27.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]  26.00-27.00  sec  12.5 MBytes   105 Mbits/sec    0   3.34 MBytes       
[SUM]  26.00-27.00  sec  35.0 MBytes   294 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]  27.00-28.00  sec  12.5 MBytes   105 Mbits/sec    0   3.58 MBytes       
[  7]  27.00-28.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]  27.00-28.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.34 MBytes       
[SUM]  27.00-28.00  sec  35.0 MBytes   294 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]  28.00-29.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.58 MBytes       
[  7]  28.00-29.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.30 MBytes       
[  9]  28.00-29.00  sec  11.2 MBytes  94.4 Mbits/sec    0   3.34 MBytes       
[SUM]  28.00-29.00  sec  33.8 MBytes   283 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5]  29.00-30.00  sec  10.0 MBytes  83.9 Mbits/sec    0   3.58 MBytes       
[  7]  29.00-30.00  sec  8.75 MBytes  73.4 Mbits/sec   59   2.31 MBytes       
[  9]  29.00-30.00  sec  7.50 MBytes  62.9 Mbits/sec  132   2.34 MBytes       
[SUM]  29.00-30.00  sec  26.2 MBytes   220 Mbits/sec  191             
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-30.00  sec   319 MBytes  89.1 Mbits/sec    0             sender
[  5]   0.00-30.15  sec   317 MBytes  88.2 Mbits/sec                  receiver
[  7]   0.00-30.00  sec   320 MBytes  89.5 Mbits/sec   59             sender
[  7]   0.00-30.15  sec   319 MBytes  88.8 Mbits/sec                  receiver
[  9]   0.00-30.00  sec   318 MBytes  88.9 Mbits/sec  132             sender
[  9]   0.00-30.15  sec   316 MBytes  88.0 Mbits/sec                  receiver
[SUM]   0.00-30.00  sec   957 MBytes   268 Mbits/sec  191             sender
[SUM]   0.00-30.15  sec   952 MBytes   265 Mbits/sec                  receiver

iperf Done.
iperf3 测试完成

[/tab]
[tab="回程路由"]

————————————————————————————————————
 ISP      : Eons Data Communications
 ASN      : AS138997 Eons Data Communications Limited
 服务商   : 
 国家     : Hong Kong
 地址     : Ha Kwai Chung, Kwai Tsing (NKT)
 IPv4地址 : 38.181.76.132
 IPv6地址 : 无 IPv6
 IP 性质  : 数据中心
 IP 危险性: 17/100（建议小于60分，分数越高说明 IP 可能存在滥用欺诈行为）
[H
No:1/9 Traceroute to 中国 深圳 电信 (TCP Mode, Max 30 Hop, IPv4)
===================================================================
NextTrace v1.3.1 2024-05-31T02:04:05Z f303397
[NextTrace API] preferred API IP - 104.21.40.176 - 56.63ms - Misaka.HKG
IP Geo Data Provider: LeoMoeAPI
traceroute to 59.36.216.1, 30 hops max, 52 bytes payload
1   38.181.76.1     AS138997                  中国 香港   eons.cloud 
                                              0.27 ms
2   103.138.72.23   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.73 ms
3   103.138.72.98   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              1.24 ms
4   103.138.72.94   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.69 ms
5   103.138.72.95   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              2.76 ms
6   103.138.72.9    AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.79 ms
7   103.138.72.58   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.97 ms
8   *
9   *
10  *
11  202.97.27.241   AS4134   [CHINANET-BB]    中国 广东 广州 X-I www.chinatelecom.com.cn  电信
                                              323.81 ms
12  *
13  202.97.93.78    AS4134   [CHINANET-BB]    中国 北京   www.chinatelecom.com.cn 
                                              311.91 ms
14  *
15  119.147.61.146  AS4134   [CHINANET-GD]    中国 广东 深圳  www.chinatelecom.com.cn  电信
                                              400.24 ms
16  *
17  *
18  *
19  *
20  *
21  *
22  *
23  *
24  *
25  *
26  *
27  *
28  *
29  *
30  *
No:2/9 Traceroute to 中国 上海 电信 (TCP Mode, Max 30 Hop, IPv4)
===================================================================
NextTrace v1.3.1 2024-05-31T02:04:05Z f303397
[NextTrace API] preferred API IP - 104.21.40.176 - 56.32ms - Misaka.HKG
IP Geo Data Provider: LeoMoeAPI
traceroute to 101.226.41.65, 30 hops max, 52 bytes payload
1   38.181.76.1     AS138997                  中国 香港   eons.cloud 
                                              0.43 ms
2   103.138.72.23   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.96 ms
3   103.138.72.20   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              2.69 ms
4   103.138.72.94   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.50 ms
5   103.138.72.95   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              2.63 ms
6   103.138.72.9    AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              1.23 ms
7   103.138.72.58   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.88 ms
8   *
9   4.69.219.61     AS3356                    美国 加利福尼亚 圣何塞  lumen.com 
                                              158.62 ms
10  *
11  *
12  202.97.12.189   AS4134   [CHINANET-BB]    中国 上海   www.chinatelecom.com.cn  电信
                                              292.29 ms
13  *
14  *
15  *
16  *
17  *
18  *
19  *
20  *
21  *
22  *
23  *
24  *
25  *
26  *
27  *
28  *
29  *
30  *
No:3/9 Traceroute to 中国 北京 电信 (TCP Mode, Max 30 Hop, IPv4)
===================================================================
NextTrace v1.3.1 2024-05-31T02:04:05Z f303397
[NextTrace API] preferred API IP - 104.21.40.176 - 59.29ms - Misaka.HKG
IP Geo Data Provider: LeoMoeAPI
traceroute to 220.181.53.1, 30 hops max, 52 bytes payload
1   38.181.76.1     AS138997                  中国 香港   eons.cloud 
                                              0.33 ms
2   103.138.72.21   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.97 ms
3   103.138.72.20   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              3.86 ms
4   103.138.72.90   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.44 ms
5   103.138.72.95   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              1.94 ms
6   103.138.72.9    AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.89 ms
7   103.138.72.58   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.85 ms
8   *
9   *
10  *
11  *
12  *
13  *
14  *
15  *
16  *
17  *
18  *
19  *
20  *
21  *
22  *
23  *
24  *
25  *
26  *
27  *
28  *
29  *
30  *
No:4/9 Traceroute to 中国 广州 联通 (TCP Mode, Max 30 Hop, IPv4)
===================================================================
NextTrace v1.3.1 2024-05-31T02:04:05Z f303397
[NextTrace API] preferred API IP - 172.67.155.192 - 50.51ms - Misaka.HKG
IP Geo Data Provider: LeoMoeAPI
traceroute to 210.21.4.130, 30 hops max, 52 bytes payload
1   38.181.76.1     AS138997                  中国 香港   eons.cloud 
                                              0.25 ms
2   103.138.72.23   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.87 ms
3   103.138.72.22   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              4.30 ms
4   103.138.72.94   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.60 ms
5   103.138.72.95   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              2.78 ms
6   103.138.72.9    AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.41 ms
7   103.138.72.19   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              47.87 ms
8   206.148.24.185  AS7578                    日本 东京都 东京  globalsecurelayer.com 
                                              47.96 ms
9   206.148.24.184  AS7578                    中国 香港   globalsecurelayer.com 
                                              48.03 ms
10  *
11  *
12  *
13  206.148.24.36   AS7578                    日本 东京都 东京  globalsecurelayer.com 
                                              48.12 ms
14  *
15  *
16  *
17  *
18  221.111.202.70  AS17676  [BBTEC]          中国 北京   softbank.jp 
                                              167.06 ms
19  219.158.3.49    AS4837   [CU169-BACKBONE] 中国 北京   chinaunicom.cn  联通
                                              170.00 ms
20  *
21  *
22  112.92.0.62     AS17816  [APNIC-AP]       中国 广东 广州  chinaunicom.cn  联通
                                              103.43 ms
23  120.80.169.118  AS17622  [APNIC-AP]       中国 广东 广州  chinaunicom.cn  联通
                                              103.08 ms
24  *
25  *
26  *
27  *
28  *
29  *
30  *
No:5/9 Traceroute to 中国 上海 联通 (TCP Mode, Max 30 Hop, IPv4)
===================================================================
NextTrace v1.3.1 2024-05-31T02:04:05Z f303397
[NextTrace API] preferred API IP - 104.21.40.176 - 51.17ms - Misaka.HKG
IP Geo Data Provider: LeoMoeAPI
traceroute to 112.65.95.129, 30 hops max, 52 bytes payload
1   38.181.76.1     AS138997                  中国 香港   eons.cloud 
                                              0.33 ms
2   103.138.72.23   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.71 ms
3   103.138.72.98   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              2.49 ms
4   103.138.72.90   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.30 ms
5   103.138.72.91   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              2.99 ms
6   103.138.72.9    AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.55 ms
7   103.138.72.19   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              47.94 ms
8   206.148.24.185  AS7578                    日本 东京都 东京  globalsecurelayer.com 
                                              47.96 ms
9   206.148.24.184  AS7578                    中国 香港   globalsecurelayer.com 
                                              47.94 ms
10  *
11  *
12  *
13  206.148.24.36   AS7578                    日本 东京都 东京  globalsecurelayer.com 
                                              48.11 ms
14  *
15  *
16  *
17  *
18  221.111.202.70  AS17676  [BBTEC]          中国 北京   softbank.jp 
                                              97.64 ms
19  219.158.16.69   AS4837   [CU169-BACKBONE] 中国 北京   chinaunicom.cn  联通
                                              100.06 ms
20  *
21  *
22  *
23  210.22.66.178   AS17621  [APNIC-AP]       中国 上海   chinaunicom.cn  联通
                                              104.49 ms
24  *
25  *
26  *
27  *
28  *
29  *
30  *
No:6/9 Traceroute to 中国 北京 联通 (TCP Mode, Max 30 Hop, IPv4)
===================================================================
NextTrace v1.3.1 2024-05-31T02:04:05Z f303397
[NextTrace API] preferred API IP - 172.67.155.192 - 45.87ms - Misaka.HKG
IP Geo Data Provider: LeoMoeAPI
traceroute to 61.49.140.217, 30 hops max, 52 bytes payload
1   38.181.76.1     AS138997                  中国 香港   eons.cloud 
                                              0.25 ms
2   103.138.72.21   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.86 ms
3   103.138.72.98   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              2.74 ms
4   103.138.72.90   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.38 ms
5   103.138.72.95   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              1.63 ms
6   103.138.72.9    AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.72 ms
7   103.138.72.19   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              48.06 ms
8   206.148.24.185  AS7578                    日本 东京都 东京  globalsecurelayer.com 
                                              47.92 ms
9   206.148.24.184  AS7578                    中国 香港   globalsecurelayer.com 
                                              48.02 ms
10  *
11  *
12  *
13  206.148.24.36   AS7578                    日本 东京都 东京  globalsecurelayer.com 
                                              48.04 ms
14  *
15  *
16  *
17  *
18  221.111.202.70  AS17676  [BBTEC]          中国 北京   softbank.jp 
                                              94.96 ms
19  219.158.3.29    AS4837   [CU169-BACKBONE] 中国 北京   chinaunicom.cn  联通
                                              95.99 ms
20  *
21  *
22  61.49.140.217   AS4808                    中国 北京   中国联通  联通
                                              105.43 ms
No:7/9 Traceroute to 中国 深圳 移动 (TCP Mode, Max 30 Hop, IPv4)
===================================================================
NextTrace v1.3.1 2024-05-31T02:04:05Z f303397
[NextTrace API] preferred API IP - 104.21.40.176 - 56.11ms - Misaka.HKG
IP Geo Data Provider: LeoMoeAPI
traceroute to 120.233.53.1, 30 hops max, 52 bytes payload
1   38.181.76.1     AS138997                  中国 香港   eons.cloud 
                                              0.29 ms
2   103.138.72.23   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.80 ms
3   103.138.72.26   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              2.93 ms
4   103.138.72.94   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.29 ms
5   103.138.72.91   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              2.18 ms
6   103.138.72.9    AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.86 ms
7   103.138.72.58   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              1.00 ms
8   *
9   4.69.208.58     AS3356                    中国 香港   lumen.com 
                                              7.30 ms
10  223.121.3.9     AS58453  [CMI-INT]        中国 香港   cmi.chinamobile.com  移动
                                              5.93 ms
11  *
12  223.120.22.206  AS58453  [CMI-INT]        中国 广东 广州  cmi.chinamobile.com 
                                              9.53 ms
13  221.183.92.201  AS9808   [CMNET]          中国 广东 广州  chinamobileltd.com  移动
                                              10.10 ms
14  221.183.92.213  AS9808   [CMNET]          中国 广东 广州  chinamobileltd.com  移动
                                              57.21 ms
15  221.183.166.209 AS9808   [CMNET]          中国 广东 广州  chinamobileltd.com 
                                              14.99 ms
16  *
17  *
18  211.136.242.178 AS56040  [CMNET]          中国 广东 广州  chinamobile.com  移动
                                              63.46 ms
19  *
20  *
21  *
22  *
23  *
24  *
25  *
26  *
27  *
28  *
29  *
30  *
No:8/9 Traceroute to 中国 上海 移动 (TCP Mode, Max 30 Hop, IPv4)
===================================================================
NextTrace v1.3.1 2024-05-31T02:04:05Z f303397
[NextTrace API] preferred API IP - 172.67.155.192 - 51.06ms - Misaka.HKG
IP Geo Data Provider: LeoMoeAPI
traceroute to 183.194.216.129, 30 hops max, 52 bytes payload
1   38.181.76.1     AS138997                  中国 香港   eons.cloud 
                                              0.35 ms
2   103.138.72.21   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.72 ms
3   103.138.72.20   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              2.67 ms
4   103.138.72.90   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              17.76 ms
5   103.138.72.91   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              3.15 ms
6   103.138.72.9    AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.77 ms
7   103.138.72.58   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.89 ms
8   *
9   4.69.218.150    AS3356                    中国 香港   lumen.com 
                                              6.36 ms
10  *
11  *
12  *
13  221.183.89.178  AS9808   [CMNET]          中国 上海   chinamobileltd.com  移动
                                              31.62 ms
14  *
15  *
16  *
17  *
18  *
19  *
20  *
21  *
22  *
23  *
24  *
25  *
26  *
27  *
28  *
29  *
30  *
No:9/9 Traceroute to 中国 北京 移动 (TCP Mode, Max 30 Hop, IPv4)
===================================================================
NextTrace v1.3.1 2024-05-31T02:04:05Z f303397
[NextTrace API] preferred API IP - 104.21.40.176 - 42.87ms - Misaka.HKG
IP Geo Data Provider: LeoMoeAPI
traceroute to 211.136.25.153, 30 hops max, 52 bytes payload
1   38.181.76.1     AS138997                  中国 香港   eons.cloud 
                                              0.42 ms
2   103.138.72.21   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              1.08 ms
3   103.138.72.98   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              2.83 ms
4   103.138.72.94   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.65 ms
5   103.138.72.95   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              3.29 ms
6   103.138.72.9    AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.83 ms
7   103.138.72.58   AS138997 [EDCL-HK]        中国 香港   eons.cloud 
                                              0.97 ms
8   *
9   4.69.218.150    AS3356                    中国 香港   lumen.com 
                                              1.86 ms
10  *
11  223.120.22.69   AS58453  [CMI-INT]        中国 香港   cmi.chinamobile.com  移动
                                              3.52 ms
12  *
13  221.183.55.114  AS9808   [CMNET]          中国 北京   chinamobileltd.com  移动
                                              86.85 ms
14  221.183.25.201  AS9808   [CMNET]          中国 北京   chinamobileltd.com  移动
                                              88.82 ms
15  *
16  221.183.76.86   AS9808   [CMNET]          中国 北京   chinamobileltd.com  移动
                                              70.77 ms
17  *
18  *
19  211.136.95.226  AS56048  [CMNET]          中国 北京   chinamobile.com  移动
                                              70.74 ms
20  211.136.95.226  AS56048  [CMNET]          中国 北京   chinamobile.com  移动
                                              70.24 ms
21  *
22  211.136.25.153  AS56048  [CMNET]          中国 北京   chinamobile.com  移动
                                              68.65 ms
[/tab]
[tab="去程路由"]
[/tab]
[tab="Ping.pe"]
[/tab]
[tab="哪吒 ICMP"]
[/tab]
[tab="其他"]
[/tab]
[/tabs]
```

**测试结束后将生成以NLvps_results开头的MarkDown格式的文件，可直接将文件内容复制到[NodeLoc论坛](https://www.nodeloc.com/)，无需进行更多操作**


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
