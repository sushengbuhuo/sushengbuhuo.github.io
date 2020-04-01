---
title: bilibili(b站)升级到BV号了，还想用av号怎么办？
date: 2020-04-01 19:43:40
tags:
- 公众号
---
> 苏生不惑第113 篇原创文章，将本公众号设为星标，第一时间看最新文章。


就在3月23日b站宣布b站链接由原来的av改为BV了，具体看官方说明
`【升级公告】AV号全面升级至BV号 `https://www.bilibili.com/read/cv5167957/

![image.png](https://upload-images.jianshu.io/upload_images/17817191-5fdfe4f0d70ab411.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/17817191-fce6bb9563cd320d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
详细规则 https://www.bilibili.com/blackboard/activity-BV-PC.html 

![image.png](https://upload-images.jianshu.io/upload_images/17817191-107f63bba646aa26.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
有什么想吐槽的去话题 ‍#BV号来了# https://www.bilibili.com/tag/name/BV%E5%8F%B7%E6%9D%A5%E4%BA%86/feed

ps: acg.tv 这个域名会跳转到https://www.bilibili.com/，之前的 av 前缀大概率是 acg video 。

原来的链接都是 av+id， 如 av170001 这样，现在都变成了 BV+string ，于是大批网友去 https://www.bilibili.com/video/av170001/ 考古。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-e8617f060d4cb1d8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

据说170001是b站的镇站之宝，这是保加利亚妖王的成名曲，洗脑程度相当厉害，节奏感极强，成为许多音乐游戏的素材，改为bv后的链接成了https://www.bilibili.com/video/BV17x411w7KC/ ，需要注意区分大小写。

不过在谷歌都能搜到。

![image.png](https://upload-images.jianshu.io/upload_images/17817191-5826b7e2ed4916c3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/17817191-ee3d7e46de38b0f1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

b站第一个av id是这个 https://www.bilibili.com/video/av2，不知道为什么av1没了，第一篇专栏还在 https://www.bilibili.com/read/cv1 。

### bv和av互转
虽然改bv了，但和av是共存的，比如这个视频`【周杰伦纪录片】第四集：天马行空`https://www.bilibili.com/video/av97863448 ，打开控制台输入bvid 可以得出对应的BV号为BV1jE411A7ha，用链接https://www.bilibili.com/video/BV1jE411A7ha也能访问。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-637507d09d559be3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

输入aid可以得到97863448
![image.png](https://upload-images.jianshu.io/upload_images/17817191-8840035c37c3eb9f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

其实b站还有接口可以查询，比如aid查cid https://www.bilibili.com/widget/getPageList?aid=97863448 ，https://api.bilibili.com/x/player/pagelist?aid=97863448 
使用bv参数 https://api.bilibili.com/x/player/pagelist?bvid=BV1jE411A7ha
 ![image.png](https://upload-images.jianshu.io/upload_images/17817191-a13f198b6fa0e0fe.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

aid查bv https://api.bilibili.com/x/web-interface/archive/stat?aid=97863448 
![image.png](https://upload-images.jianshu.io/upload_images/17817191-27dd175cede9dc26.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

使用bv参数 https://api.bilibili.com/x/web-interface/archive/stat?bvid=BV1jE411A7ha或者
 https://api.bilibili.com/x/web-interface/view?bvid=BV1jE411A7ha
 

如果嫌麻烦，有人还开发了油猴脚本https://greasyfork.org/zh-CN/scripts/398535-bv2av，关于安装油猴脚本见之前的文章[Chrome 浏览器扩展神器油猴](https://mp.weixin.qq.com/s/adJFh_9LH0N-vvvYaiQqXg)
![image.png](https://upload-images.jianshu.io/upload_images/17817191-356e94ad225cbfe9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
进入bv链接 https://www.bilibili.com/video/BV1jE411A7ha 会自动跳转到 https://www.bilibili.com/video/av97863448，网友开发的https://bv2av.com/index.php?BV=BV1jE411A7ha
### 跳转播放
b 站视频链接可以带时间戳参数，加上参数
 t=126s 会直接跳转到2分6秒 https://www.bilibili.com/video/av97863448?t=126s ，有什么用呢？方便发给别人看指定片段。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-1802724dbf682926.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### 404  
b站的视频被删除会跳转到404页面 https://www.bilibili.com/404，比如这个https://www.bilibili.com/video/av1/
![image.png](https://upload-images.jianshu.io/upload_images/17817191-3617a54f8a538627.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
点换一张可以不断看图。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-c55845b59b00d88e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### 弹幕词云
http://danmu.xiezuoguan.cn/#/ 输入视频aid可以生成弹幕词云图，比如https://www.bilibili.com/video/av97863448 的弹幕
![image.png](https://upload-images.jianshu.io/upload_images/17817191-00c6d30405b3e3c5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
### 短链接
嫌链接太长？b站还有短链接 https://b23.tv/av97863448 

### 下载视频
关于下载视频之前写过[如何轻松下载腾讯/微博/优酷/爱奇艺/b站等全网视频？](https://mp.weixin.qq.com/s/3rB23e9L55hDBaPLDu6WMg)，依然推荐这个下载工具下载b站视频，支持bv。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-000091cb207725ef.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![image.png](https://upload-images.jianshu.io/upload_images/17817191-133c223eac348439.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

命令行推荐 https://github.com/soimort/you-get，annie 还没兼容。

关于b站更多使用技巧参考之前的文章[那些你可能不知道的 bilibili 奇技淫巧](https://mp.weixin.qq.com/s/HpuInXUCjSYT7HLqhoRcCA)

推荐历史文章:

[如何发一条空白的朋友圈](https://mp.weixin.qq.com/s/Xz1m-mqtCcBF_4hmGCpkUQ)

[2019 年公众号 苏生不惑 近百篇原创文章整理](https://mp.weixin.qq.com/s/Lm4l_aPCSXymUGcqO_Yf3g)

[2019年11月最新使用油猴加速百度网盘下载方法](https://mp.weixin.qq.com/s/XTn8wPEyThacR3GLHyzBLA)

[那些有意思的谷歌/百度搜索彩蛋](https://mp.weixin.qq.com/s/dXZhN3GbqQslg7-YHcRL3A)

[如何备份可能被删的公众号文章和网页 ](https://mp.weixin.qq.com/s/bIE23HBq_sqvLkV18_BlbQ)

[如何将视频轻松转换为 GIF](https://mp.weixin.qq.com/s/bGcMIz0dOoDe3quo5G0-Ug)

[如何轻松的将文字转语音](https://mp.weixin.qq.com/s/klBMLhsQXOEzsWA5a_rpIQ)

[那些好玩的生成器网站](https://mp.weixin.qq.com/s/mPpRYbjfgpVqKcpFwnPYtA)

[那些你可能不知道的网络冷知识奇技淫巧](https://mp.weixin.qq.com/s/-p-RZLh8ovNiCYv6YQkbrw)

 
![免费知识星球，每天更新](https://upload-images.jianshu.io/upload_images/17817191-9d41aa25edcd25c4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### 公众号 苏生不惑
 ![扫描二维码关注或搜索微信susheng_buhuo](https://upload-images.jianshu.io/upload_images/17817191-6e0079f95d4c0338.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

