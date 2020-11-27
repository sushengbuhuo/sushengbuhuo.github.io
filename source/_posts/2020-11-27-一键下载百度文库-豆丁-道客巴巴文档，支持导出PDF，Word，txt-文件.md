---
title: 一键下载百度文库/豆丁/道客巴巴文档，支持导出PDF，Word，txt 文件
date: 2020-11-27 19:11:15
tags:
- 公众号
---
> 苏生不惑第`198` 篇原创文章，将本公众号设为`星标`，第一时间看最新文章。

先说个题外话，昨天文章 [解除网页查看限制，自由查看和跳转网站](https://mp.weixin.qq.com/s/q17hBoWiFX1tct6ep7539A) 评论下有小伙伴问是否有插件可以直接打开新标签页，一般我用右键在新标签页打开链接，不过这样有点麻烦。

![image.png](https://upload-images.jianshu.io/upload_images/23152173-3207b1dff2c4a993.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
其实自己写个油猴脚本就可以了。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-611c8a5c96775f21.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
脚本内容如下，其实就一行代码，开启这个脚本后所有链接都会在新标签页打开。
```js
// ==UserScript==
// @name         新标签打开网页
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  新标签打开网页
// @author       苏生不惑
// @match        *://*/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';
    document.querySelectorAll("a").forEach(function(item,index,arr){item.target='_blank';});
})();
```

另外文章里分享了安装Chrome扩展即可复制百度文库上的文字，后台有小伙伴问能不能下载百度文库，于是这里再做个整理。

### 小叶文档下载器 
这个软件（公众号后台回复`文库`获取该软件）支持百度文库/豆丁/道客/新浪爱问/淘豆/帮帮文库/蚂蚁文库等文档的下载， 支持PDF和Word格式输出，同时支持OCR文字识别 （如果需要提取文字）https://pan.lanzoux.com/iqihJiagvhc    

输入百度文库地址 https://wenku.baidu.com/view/021014797dd184254b35eefdc8d376eeaeaa172f.html ，下载的文件在当前自录下的download目录。

![image.png](https://upload-images.jianshu.io/upload_images/23152173-a2ddbfd88d61c411.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/23152173-fdaba414d911b0eb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
打开下载的PDF没问题。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-6e960a5b5d9560ae.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
再来下载豆丁文档 https://www.docin.com/p-513589737.html ，这个是Word格式。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-780eea0febb19003.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
还有道客巴巴文档 https://www.doc88.com/p-9029134991389.html  
![image.png](https://upload-images.jianshu.io/upload_images/23152173-e20f16fd61602b05.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
 
![image.png](https://upload-images.jianshu.io/upload_images/23152173-2fe529efccaa6a74.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 冰点文库 
这个软件运行很久了（公众号后台回复`文库`获取该软件），无需积分就可以自由下载百度/豆丁/丁香/MBALib/Book118等文库文档（付费文档也支持）。


![image.png](https://upload-images.jianshu.io/upload_images/23152173-e624cfbde8f92227.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
会同时下载 PDF和txt格式文件。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-2fb7bb6c80116362.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
豆丁文档也一样（其他网站就不一一测试了）。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-4955e7ee5c39f943.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![image.png](https://upload-images.jianshu.io/upload_images/23152173-e1e776aa138a6d45.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

如果你使用的Mac系统，上面的Windows软件就没法用了，推荐下面的Chrome扩展和油猴脚本。

### Chrome扩展
比如这个百度文库https://wenku.baidu.com/view/021014797dd184254b35eefdc8d376eeaeaa172f.html  剩余3页不能看。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-57ff63b67933f741.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
安装 https://github.com/wxbool/baidu-wenku 这个Chrome扩展后右侧多了清理dom和导出文档按钮。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-84e2beaa3c9dddbc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
点击清理dom会自动运行。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-3e36ac1c02a1efa7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/23152173-734f651539babe71.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/23152173-3b727bbdf8eaa6e1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
清理完成后页面上只剩下文档。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-a402d01bb214b521.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
点击导出文档会调用谷歌浏览器的另存为PDF，保存即可。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-08f5c59d5b8ece67.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

如果想将下载后的 PDF 文档转换为 Word 文档格式推荐之前文章 [良心整理：PDF工具合集](https://mp.weixin.qq.com/s/j88qrbHF9k-h7zrgfD87iw)
 分享的软件 pdfsharper 

![image.png](https://upload-images.jianshu.io/upload_images/23152173-5a6995a3e2a84384.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
提取文本也很方便。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-0839ed5e2ba2b08d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
 
 
### 油猴脚本
https://greasyfork.org/zh-CN/scripts/405373 这个脚本会将百度文库内文章中的文本内容转换为 word 并下载，关于油猴脚本的安装使用见之前文章 [实用油猴脚本推荐，让你的谷歌浏览器更强大](https://mp.weixin.qq.com/s/4sCwNc4fz7IxlL8XfY95rQ) 

![image.png](https://upload-images.jianshu.io/upload_images/23152173-ac3df6be28e84bea.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
下载的Word文件没问题。

![image.png](https://upload-images.jianshu.io/upload_images/23152173-7fadec21a8fe3a30.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

最后分享个下载豆丁文档的网站 https://www.docin365.com/ ， 这个网站是豆丁网文档复制抓取工具，导出的文档为word形式，非源文件，但文字可编辑，包含图片，尽量保持原文档的格式。

![image.png](https://upload-images.jianshu.io/upload_images/23152173-01c84e2598cb3b8b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

>  如果文章对你有帮助还请 点赞/在看/分享 三连支持下， 感谢各位！

最近原创文章：

[不用写代码，Chrome 扩展神器 web scraper 抓取知乎热榜/话题/回答/专栏，豆瓣电影](https://mp.weixin.qq.com/s/1PVwF-vtVizWSkiNXNkAkg)

[视频下载神器：支持腾讯/优酷/爱奇艺/b站/微博等全网视频](https://mp.weixin.qq.com/s/n9ddxx6Zu5hC7cqEXRnMOg)

[良心整理：PDF工具合集](https://mp.weixin.qq.com/s/j88qrbHF9k-h7zrgfD87iw)

[2020 最全电子书搜索网站，找电子书不再愁](https://mp.weixin.qq.com/s/pt0hCthceThMZVU0Ht89AA)

[b 站账号快速升级到 Lv6：每天自动签到，观看，分享，投币视频 ](https://mp.weixin.qq.com/s/Agh5EAgkd6__jq3J6CCNlA)

[集赞生成器：朋友圈集赞不求人](https://mp.weixin.qq.com/s/Zjhap47PGpIhQi79gkekCg)

[百度网盘下载太慢？不限速的阿里云盘来了](https://mp.weixin.qq.com/s/-UlmFs6mj0ZUocFtEbWNFg)

### 公众号 苏生不惑
 ![扫描二维码关注或搜索微信susheng_buhuo](https://upload-images.jianshu.io/upload_images/17817191-6e0079f95d4c0338.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
