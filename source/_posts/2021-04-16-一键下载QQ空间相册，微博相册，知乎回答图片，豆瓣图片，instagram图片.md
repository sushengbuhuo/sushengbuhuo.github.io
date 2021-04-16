---
title: 一键下载QQ空间相册，微博相册，知乎回答图片，豆瓣图片，instagram图片
date: 2021-04-16 19:48:33
tags:
- 公众号
---
> 苏生不惑第`237` 篇原创文章，将本公众号设为`星标`，第一时间看最新文章。

 关于下载图片之前分享过几篇文章：

[如何批量下载知乎回答图片](https://mp.weixin.qq.com/s/oSvtFuH2_RYn_AE10x8iSQ)

[如何用 Chrome 扩展备份你的 QQ 空间相册](https://mp.weixin.qq.com/s/KIXUAI_Zkz_jwJ9FgUMUoQ)


之前分享过[如何批量下载知乎回答图片](https://mp.weixin.qq.com/s/oSvtFuH2_RYn_AE10x8iSQ)，这里再做个整理，一键下载QQ空间相册，微博相册，知乎回答图片，豆瓣图片，instagram图片。
### QQ空间相册

话说2019年QQ空间推出的那个视频《时光密码》还是挺感动人的 https://user.qzone.qq.com/20050606/blog/1559786793 ，内容取材于一对QQ网友 “往事随风”和“轻舞飞扬” 的爱与缘。  https://www.bilibili.com/video/av54233111/ 

>你好，我是往事随风，
>你好，我叫轻舞飞扬。

![image.png](https://upload-images.jianshu.io/upload_images/23152173-5a5009e2736e6b32.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
 
有兴趣点击下面的视频号观看，如果想下载视频号里的视频参考之前文章[2021年4月如何下载微信视频号的视频？简直不要太简单](https://mp.weixin.qq.com/s/ig_aD0B2n7Vi6CdDeZ11Zg) 。

这里用Python脚本下载QQ空间照片 https://github.com/dslwind/qzone-photo-downloader  ，先pip install selenium 安装库，然后下载chromedriver  
https://sites.google.com/a/chromium.org/chromedriver/downloads ，如果打不开谷歌下载国内镜像一样的https://npm.taobao.org/mirrors/chromedriver  ，下载解压后将chromedriver.exe放在脚本目录或者加入系统环境变量。

注意下载 chromedriver  前先打开chrome://settings/hel p看看自己Chrome浏览器版本，要下载版本一样的文件。

![image.png](https://upload-images.jianshu.io/upload_images/23152173-9c300caca5a7269a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
我把Python代码打包好了，不用安装Python直接双击运行软件即可（在公众号后台回复`QQ`获取软件），输入自己QQ号和要导出的QQ号。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-45da1528102c549a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

它会打开你的默认浏览器，点击登录QQ。

![image.png](https://upload-images.jianshu.io/upload_images/23152173-063b24cd3fde3fc8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
很快脚本下载完了。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-f719afd97c0c1beb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

如果你还想导出QQ空间其他资料可以安装Chrome扩展 QQ空间导出助手https://chrome.google.com/webstore/detail/qq%E7%A9%BA%E9%97%B4%E5%AF%BC%E5%87%BA%E5%8A%A9%E6%89%8B/aofadimegphfgllgjblddapiaojbglhf?hl=zh-CN， 扩展最近更新时间2021年1月27日， 关于如何安装和使用Chrome扩展见之前文章 [上不了谷歌如何安装 Chrome 扩展？](https://mp.weixin.qq.com/s/xC9K_z7zpmAIEzUK6s1x3w)   ，它可以导出备份QQ空间的日志、私密日志、说说、相册、留言板、QQ好友、视频、收藏夹为文件，便于永久保存与迁移。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-5e9eecad197a27f0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
使用很简单，就不多介绍了。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-41a2dd886e4afcf8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
 ### 知乎所有回答图片
关于下载知乎回答图片之前写过 [如何批量下载知乎回答图片](https://mp.weixin.qq.com/s/oSvtFuH2_RYn_AE10x8iSQ)，不过只能下载单个回答，如果想下载所有回答图片可以使用这个工具（在公众号后台回复 `知乎` 获取软件）。

打开软件后输入问题id回车运行即可，比如 关于刘亦菲的这个问题https://www.zhihu.com/question/374798860 ，id为374798860 
![image.png](https://upload-images.jianshu.io/upload_images/23152173-bde694f03f76e6dd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
回答里共2751张美图。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-8f18ab331cce4037.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
200多个回答的图片都下载下来了，下载文件在以问题id为名的目录里。
 ![image.png](https://upload-images.jianshu.io/upload_images/23152173-489db6580038c9af.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
神仙姐姐的颜值简直惊为天人，在知乎找壁纸不愁了。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-4fda2cc572b7fdb2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
### 微博相册
先安装Chrome扩展 https://chrome.google.com/webstore/detail/octo%E5%BE%AE%E5%8D%9A%E7%9B%B8%E5%86%8C%E6%89%B9%E9%87%8F%E4%B8%8B%E8%BD%BD/cdimdlckbkfelaogjhfbkjcfncbpngkn?hl=zh-CN ，扩展最近更新时间2021年2月6日。

安装成功后进入微博主页，这里选择王菲的微博 https://www.weibo.com/u/1629810574 ，天后已经6年不更新微博了，  点击扩展图标，选择需要下载的相册 。

![image.png](https://upload-images.jianshu.io/upload_images/17817191-c578ea05e796c6b5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
这个相册有6张图片，很快就下载好了。
 ![image.png](https://upload-images.jianshu.io/upload_images/23152173-3939594b6fa01885.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![image.png](https://upload-images.jianshu.io/upload_images/17817191-853765f66bad3d54.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
如果还想下载微博内容可以安装 Octoman 微博备份工具  https://github.com/misswell/octoman-weibo-backup，https://chrome.google.com/webstore/detail/octoman%E5%BE%AE%E5%8D%9A%E5%A4%87%E4%BB%BD/pojodomdlpobompicdllljgiomnfpmho  ，扩展最近更新时间2021年2月7日，这个在之前文章[再谈备份微博](https://mp.weixin.qq.com/s/AUS5oCukv8hIFZIjO2Drjg)已经分享过 。


安装扩展后点击Chrome扩展图标，在下拉列表中选择需要下载的用户，然后点击保存即可。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-d71a715e9860dcca.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这个扩展将每500条微博（会展开长微博）存为一个HTML文件， 也可以在选项设置调整，不过这个扩展有个不方便的地方没有时间段选择，每次都得重新备份。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-cb2f6f79ba9c16f3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


如果还想下载和分析微博账号数据可以看看我之前的文章 [一键备份微博并导出生成PDF，顺便用Python分析微博账号数据](https://mp.weixin.qq.com/s/PlkPDmK2SUdQT59CzOJFMA) ，我分析过李健的微博词云图，他的微博关键词为音乐，北京，朋友，歌手，电影，居然还提到了周杰伦。

![image.png](https://upload-images.jianshu.io/upload_images/23152173-50ab26c9061dc3ff.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
每个月转发评论点赞总数图，可以看到2016-2018年的微博数据是高峰期。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-e90ac700d23bcc29.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
原创微博和转发微博数据比例。

![image.png](https://upload-images.jianshu.io/upload_images/23152173-41ce3fd4cd954fed.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
发微博的工具主要为pc网页和iPad。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-b66bfcb9a738db8f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

 
### instagram图片
 前几天分享过上ins的APP [上 Instagram 看看周杰伦又更新了什么动态](https://mp.weixin.qq.com/s/9We-13XFA28Ay11cmKuEww)，这里再分享个下载ins图片的Chrome扩展 https://chrome.google.com/webstore/detail/download-instagram-videos/bjpgfccobjfpicoddafljhplofcmgfjh/related?hl=zh-CN ,扩展最近更新时间2020年9月28日，它支持从Instagram下载视频，卷轴视频，照片，故事和IGTV视频，打开ins详情页点击底部的下载按钮。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-40a3537f6c849cd6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
然后跳转到下载页。https://fbion.com/zh-CN/instagram-downloader.html#https://www.instagram.com/p/CM162urH4s5/
![image.png](https://upload-images.jianshu.io/upload_images/23152173-9a48ad18e634a266.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
 
 ### 豆瓣相册
 
这个Chrome扩展用于备份豆瓣的用户数据及图片，并支持将备份数据导出到 Excel，扩展地址 https://chrome.google.com/webstore/detail/%E8%B1%86%E4%BC%B4%EF%BC%9A%E8%B1%86%E7%93%A3%E8%B4%A6%E5%8F%B7%E5%A4%87%E4%BB%BD%E5%B7%A5%E5%85%B7/ghppfgfeoafdcaebjoglabppkfmbcjdd ，扩展最近更新时间2021年1月14日，功能有这些：
```js
 • 备份本人或他人的豆瓣账号数据
 • 脱机浏览备份数据
 • 将备份数据导出为 Excel 文件
 • 将备份数据中的图片上传到 Cloudinary 云存储
 • 迁移备份数据到当前豆瓣帐号
```
登录账号后点击新建任务，选择备份的项目，这里选相册。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-50ebf142508b74d4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
还可以导出数据。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-c065a66ba83d7b87.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

>  如果文章对你有帮助还请 `点赞/在看/分享` 三连支持下， 感谢各位！

### 公众号苏生不惑
![扫描二维码关注或搜索微信susheng_buhuo](https://upload-images.jianshu.io/upload_images/23152173-61c280d775baf3e6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)