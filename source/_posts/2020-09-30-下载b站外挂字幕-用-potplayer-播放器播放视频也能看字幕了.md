---
title: '下载b站外挂字幕,用 potplayer 播放器播放视频也能看字幕了'
date: 2020-09-30 19:10:47
tags:
- 公众号
---
> 苏生不惑第175 篇原创文章，将本公众号设为`星标`，第一时间看最新文章。

关于b站之前已经写过很多文章了，有兴趣可以点击阅读：


[bilibili(b站)升级到BV号了，还想用av号怎么办？](https://mp.weixin.qq.com/s/I3LR8ikHoX80WjaMCoMVlw)

[那些你可能不知道的 bilibili 奇技淫巧](https://mp.weixin.qq.com/s/HpuInXUCjSYT7HLqhoRcCA)

[如何轻松下载腾讯/微博/优酷/爱奇艺/b站等全网视频？](https://mp.weixin.qq.com/s/3rB23e9L55hDBaPLDu6WMg)

[如何更优雅地使用 bilibili(b站)](https://mp.weixin.qq.com/s/a_lxHOQVA9RR_dYyzr56Gw)

[如何找回bilibili(b站)收藏夹里失效的视频？](https://mp.weixin.qq.com/s/i53iORP49o_4eRGGQEthsg)

[如何免登陆观看b站大会员番剧](https://mp.weixin.qq.com/s/UtfjurjQOCBFdxNhh-rFSA)

[借助 potplayer 播放器，在本地播放 b 站视频也能看弹幕了](https://mp.weixin.qq.com/s/tlV7G943bHP5WqZeuaOolw)

今天分享的是下载b站外挂字幕 ，在本地用 potplayer 播放器播放b站视频也能看字幕了，需要用到 potplayer 播放器 （公众号后台回复 `播放器` 获取软件）和字幕文件。

### b站字幕
b站的外挂字幕是2018年上线的，详情看官方文章 https://www.bilibili.com/read/cv1374773/ 
![image.png](https://upload-images.jianshu.io/upload_images/23152173-e387b48731bbd458.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
b站的外挂CC字幕其实就是个 srt 文件，这是一种非常流行的文本字幕，内容为一行时间，一行字幕，制作规范非常简单。
 
有字幕的视频可以在底部看见cc字样（客户端也有），比如这个 https://www.bilibili.com/video/BV1Jt411P77c?p=2 有中英文字幕，对于没有字幕的视频还可以自己添加字幕（ass格式文），up主审核通过后就可以看到了。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-6d5fe56b08116430.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

通过控制台可以找到字幕json文件https://i0.hdslb.com/bfs/subtitle/9d71b0913bed9966fcccb99d211208d31290ad09.json 
![image.png](https://upload-images.jianshu.io/upload_images/23152173-62eefb17b96f2aa4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
可以看到字幕文件内容。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-7a434bfe35330fbe.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 下载字幕 
找到字幕文件就很好下载了，不过这个字幕文件是json格式，我们需要的是srt格式，因此需要转换下，这里可以使用Python脚本 https://github.com/taseikyo/backup-utils/blob/master/Python/008_download_and_convert_b23_subtitle.py   来完成。

直接输入b站地址执行脚本下载，本地会生成一个srt文件。 
```js
λ python bilibili.py
请输入b站地址:https://www.bilibili.com/video/BV1Jt411P77c?p=2

```

当然用代码还是有点麻烦，已经有油猴脚本了 https://greasyfork.org/zh-TW/scripts/378513-bilibili-cc%E5%AD%97%E5%B9%95%E5%B7%A5%E5%85%B7 ，关于油猴脚本下载使用参考之前文章[实用油猴脚本推荐，让你的谷歌浏览器更强大](https://mp.weixin.qq.com/s/4sCwNc4fz7IxlL8XfY95rQ)
![image.png](https://upload-images.jianshu.io/upload_images/23152173-33726f502e7c1c97.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
点击下载可以看到字幕内容，下载格式支持ass,srt等。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-9020f51999e53eca.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

如果你觉得安装油猴插件还是麻烦推荐这个用于下载B站CC字幕及转换的工具BiliBiliCCSubtitle （公众号后台回复 `b站` 获取） https://github.com/nathanli97/BiliBiliCCSubtitle


在命令行执行 ccdown.exe -d -c  https://www.bilibili.com/video/BV1Jt411P77c?p=2 即可下载json格式和srt格式字幕文件。
```js
λ ccdown.exe -d -c https://www.bilibili.com/video/BV1Jt411P77c?p=2
Bilibili JSON format CC subtitle downloader Ver 1.1.0 by Nathanli97
Found: zh-Hans 中文（简体）  ==> AV60977932(BV1Jt411P77c)-P2-zh-Hans.json
AV60977932(BV1Jt411P77c)-P2-zh-Hans.json ==> AV60977932(BV1Jt411P77c)-P2-zh-Hans.srt
Found: en-US 英语（美国）  ==> AV60977932(BV1Jt411P77c)-P2-en-US.json
AV60977932(BV1Jt411P77c)-P2-en-US.json ==> AV60977932(BV1Jt411P77c)-P2-en-US.srt
```
### 下载视频
下载字幕后再下载b站视频，之前已经分享过工具 [如何轻松下载腾讯/微博/优酷/爱奇艺/b站等全网视频？](https://mp.weixin.qq.com/s/3rB23e9L55hDBaPLDu6WMg) ，我喜欢用命令行下载。
```js
λ annie -f 16 https://www.bilibili.com/video/BV1Jt411P77c?p=2

 Site:      哔哩哔哩 bilibili.com
 Title:     普林斯顿大学丨算法第四版  Princeton University 丨 Algorithms Part 1 P2 01_dynamic-co
nnectivity 动态连通性
 Type:      video
 Stream:
     [16]  -------------------
     Quality:         流畅 360P
     Size:            21.35 MiB (22385288 Bytes)
     # download with: annie -f 16 ...

 21.35 MiB / 21.35 MiB [================================================] 100.00% 3.08 MiB/s 6s Merging video parts into 普林斯顿大学丨算法第四版  Princeton University 丨 Algorithms Part 1 P2
01_dynamic-connectivity 动态连通性.mp4
```
下载字幕和视频文件后，将字幕和视频文件名改成一样，比如`普林斯顿大学丨算法第四版.mp4` 和 `普林斯顿大学丨算法第四版.srt`，播放 视频就能看到字幕了 。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-22a7d123432888a1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

如果还想看弹幕参考之前文章 [借助 potplayer 播放器，在本地播放 b 站视频也能看弹幕了](https://mp.weixin.qq.com/s/tlV7G943bHP5WqZeuaOolw) 下载弹幕文件也能看了。


除了工具还有在线网站下载https://wivwiv.com/youtube ，不过只支持av号地址https://www.bilibili.com/video/av60977932?p=2 
![image.png](https://upload-images.jianshu.io/upload_images/23152173-1fd69f8486e565ec.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

最后分享个神器彩云小译Chrome扩展 https://chrome.google.com/webstore/detail/lingocloud-web-translatio/jmpepeebcbihafjjadogphmbgiffiajh  ，这个扩展能让你看外文视频的时候自动翻译为中文，安装Chrome扩展见之前文章 [上不了谷歌如何安装 Chrome 扩展？](https://mp.weixin.qq.com/s/xC9K_z7zpmAIEzUK6s1x3w) ，安装扩展后可以看到视频翻译。

 ![image.png](https://upload-images.jianshu.io/upload_images/23152173-9a56c965a0649d7f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
点击视频翻译后开启音频识别 。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-d91f4144e6eeade2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
比如这个视频（其实不限制于b站，任何视频网站都可以） https://www.bilibili.com/video/BV1g7411K7ut  ，可以实时看到下面翻译的中文字幕，效果不错。
 ![image.png](https://upload-images.jianshu.io/upload_images/23152173-e97d443dd10ba7c3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

| 公众号后台回复关键词    |  用途   |
| --- | --- |
| 微信    | 获取你的微信好友头像拼图及查看微信撤回消息    |
|  b站   |  获取下载b站视频工具及找回被删b站视频方法   |
|  视频   |  获取下载腾讯，优酷，爱奇艺，微博视频工具及去除logo脚本   |
|  百度网盘   | 获取加速下载网盘文件方法及查找电影电视剧网站    |
|   朋友圈  |  获取发空白朋友圈方法和九宫格图片   |
|  微博   |  获取备份微博工具及分析微博账号数据   |
|  音乐   |   获取下载音乐工具及在线听歌网站  |
|  油猴   |   获取油猴脚本  |
|谷歌|获取安装Chrome扩展方法|
|公众号|一键下载公众号所有文章|
|抖音|一键下载无水印抖音视频|

![免费知识星球，每天更新](https://upload-images.jianshu.io/upload_images/17817191-9d41aa25edcd25c4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 公众号 苏生不惑
 ![扫描二维码关注或搜索微信susheng_buhuo](https://upload-images.jianshu.io/upload_images/17817191-6e0079f95d4c0338.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)