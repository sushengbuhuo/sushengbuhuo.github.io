---
title: 借助 potplayer 播放器，在本地播放b站视频也能看弹幕了
date: 2020-08-28 19:30:36
tags:
- 公众号
---
> 苏生不惑第164 篇原创文章，将本公众号设为`星标`，第一时间看最新文章。

关于b站之前已经写过了下列文章，有兴趣可以点击阅读：

 [那些我关注的 b 站 up 主](https://mp.weixin.qq.com/s/952eqef1Rm3HpH5DYbTjZg)

[bilibili(b站)升级到BV号了，还想用av号怎么办？](https://mp.weixin.qq.com/s/I3LR8ikHoX80WjaMCoMVlw)

[那些你可能不知道的 bilibili 奇技淫巧](https://mp.weixin.qq.com/s/HpuInXUCjSYT7HLqhoRcCA)

[如何轻松下载腾讯/微博/优酷/爱奇艺/b站等全网视频？](https://mp.weixin.qq.com/s/3rB23e9L55hDBaPLDu6WMg)

[如何更优雅地使用 bilibili(b站)](https://mp.weixin.qq.com/s/a_lxHOQVA9RR_dYyzr56Gw)

[如何找回bilibili(b站)收藏夹里失效的视频？](https://mp.weixin.qq.com/s/i53iORP49o_4eRGGQEthsg)

[如何免登陆观看b站大会员番剧](https://mp.weixin.qq.com/s/UtfjurjQOCBFdxNhh-rFSA)
  
b站视频被删后，即使根据 [如何找回bilibili(b站)收藏夹里失效的视频？](https://mp.weixin.qq.com/s/i53iORP49o_4eRGGQEthsg) 这里的方法找回了视频，但曾经的弹幕没有了，为了以防万一可以提前下载视频和弹幕，在本地用potplayer播放器（公众号内回复 `播放器` 获取软件）播放b站视频就可以看弹幕了，获得和b站一样的观看体验。

### potplayer 播放器
之前我一直用的QQ影音播放器，自从发现了potplayer，体验简直惊艳， potplayer内置支持多种解码器，无需额外安装就能播放几乎所有视频格式文件。https://www.potplayer.org/  https://www.lanzoux.com/izb4nfjtksb

一个比较有用的功能是支持直播源，右键打开链接。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-20d75126b5af4bb4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
输入m3u直播源地址 http://tv.sason.xyz/new.m3u ，欢迎分享更多直播源。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-2c52e7f8d5ee9920.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
加载直播源后右侧可以看到n多电视台直播源，比如央视6套电影频道，实现了在本地播放器上看电视。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-4902047ebd982bf3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

还有实时字幕翻译功能，这个看英语电影的时候比较实用。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-edab2834008fc4ca.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

再一个就是可以播放视频的时候看弹幕，只需要弹幕文件名和视频文件名相同即可。

下面开始体验下在本地用potplayer播放器播放有弹幕的b站视频。

### 下载b站视频
关于下载b站视频之前写过文章 [如何轻松下载腾讯/微博/优酷/爱奇艺/b站等全网视频？](https://mp.weixin.qq.com/s/3rB23e9L55hDBaPLDu6WMg) ，推荐使用BiliBili视频下载工具（公众号内回复 `b站` 获取软件），输入视频地址直接下载 。https://www.lanzous.com/b0lkrxzg
![image.png](https://upload-images.jianshu.io/upload_images/23152173-8ae8cbfaddfc60b6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

不过我还是习惯用命令行来下载。
```js 
annie -f 16 https://www.bilibili.com/video/BV1ip4y1D7iY

 Site:      哔哩哔哩 bilibili.com
 Title:     【周杰伦纪录片】第七集：夏日狂想
 Type:      video
 Stream:
     [16]  -------------------
     Quality:         流畅 360P
     Size:            131.72 MiB (138122013 Bytes)
     # download with: annie -f 16 ...

 131.72 MiB / 131.72 MiB [=========================================] 100.00% 139.06 KiB/s 16m9s
```
视频下载后开始下载弹幕。
### 下载弹幕

b站提供接口使用av号获取cid ，比如https://api.bilibili.com/x/player/pagelist?aid=968504505 获取到cid=205245882
![image.png](https://upload-images.jianshu.io/upload_images/23152173-ac18a40c9748f587.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
如果觉得这样麻烦可以安装油猴脚本，可以直接显示 视频 av 号、bv 号及弹幕 cid
 https://greasyfork.org/zh-CN/scripts/403846-bilibili-display-video-av-bv-number-below-the-title-bar
![image.png](https://upload-images.jianshu.io/upload_images/23152173-2af743751f73cadc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

之后根据cid获取弹幕文件，弹幕文件采用 xml 格式存储，接口地址 https://api.bilibili.com/x/v1/dm/list.so?oid=205245882 或者 https://comment.bilibili.com/205245882.xml ，直接保存到本地即可。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-866fcff88f95e1c3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

然后使用 bilibili ASS 弹幕在线转换网站把xml格式转换为ass格式，上传即可转换。
https://tiansh.github.io/us-danmaku/bilibili/
![image.png](https://upload-images.jianshu.io/upload_images/23152173-2e8ef869fe2ba43c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
 

还可以安装 Chrome扩展 哔哩哔哩助手 https://bilibili-helper.github.io/ ，安装方法见之前文章 [上不了谷歌如何安装 Chrome 扩展？](https://mp.weixin.qq.com/s/xC9K_z7zpmAIEzUK6s1x3w)
![image.png](https://upload-images.jianshu.io/upload_images/23152173-c9f091b9bffa3ccb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
打开b站视频 https://www.bilibili.com/video/BV1ip4y1D7iY ，可以看到弹幕列表（还支持搜索），直接提供xml和ass 2种格式弹幕下载。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-a5e2e1c3360ae491.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这个和之前介绍的油猴扩展`哔哩哔哩增强脚本`一样的 https://greasyfork.org/zh-CN/scripts/373563-bilibili-evolved
![image.png](https://upload-images.jianshu.io/upload_images/23152173-f262db4ed639c026.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


视频和弹幕文件下载后放同一个目录下，即`【周杰伦纪录片】第七集：夏日狂想.flv`和 `【周杰伦纪录片】第七集：夏日狂想.ass`，播放视频的时候字幕也出来了。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-565bc9f6556352b9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
如果想关闭弹幕可以在选择字幕里勾选不显示。

> 分享个小技巧，b站视频的倍速播放最大到2倍，如果想更快（比如2.5倍）可以在控制台执行`document.querySelector('video').playbackRate = 2.5`

![image.png](https://upload-images.jianshu.io/upload_images/23152173-a8cb2a7e4e10c641.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

最后分享一个可以用来分享、管理你在b站设置弹幕屏蔽词的网站 https://harrynull.tech/bilibili/
![image.png](https://upload-images.jianshu.io/upload_images/23152173-08e6d7bf75720667.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
> 大家的点赞和在看转发对我非常重要，如果文章对你有帮助还请支持下， 感谢各位！

| 公众号后台回复关键词    |  用途   |
| --- | --- |
| 微信    | 获取你的微信好友头像拼图及查看微信撤回消息    |
|  b站   |  获取下载b站视频工具及找回被删b站视频方法   |
|  视频   |  获取下载腾讯，优酷，爱奇艺，微博视频工具及去除logo脚本   |
|  百度网盘   | 获取加速下载网盘文件方法及查找电影电视剧网站    |
|   朋友圈  |  获取发空白朋友圈方法   |
|  微博   |  获取备份微博工具及分析微博账号数据   |
|  音乐   |   获取下载音乐工具及解锁网易云音乐无版权歌曲 |
|  油猴   |   获取油猴脚本  |
|谷歌|获取安装Chrome扩展方法|

![免费知识星球，每天更新](https://upload-images.jianshu.io/upload_images/17817191-9d41aa25edcd25c4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 公众号 苏生不惑
 ![扫描二维码关注或搜索微信susheng_buhuo](https://upload-images.jianshu.io/upload_images/17817191-6e0079f95d4c0338.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)