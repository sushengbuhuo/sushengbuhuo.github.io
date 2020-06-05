---
title: 一键备份微博并导出生成PDF，顺便用Python分析微博账号数据
date: 2020-06-05 19:23:18
tags:
- 公众号
---
> 苏生不惑第139 篇原创文章，将本公众号设为`星标`，第一时间看最新文章。

关于微博之前写过以下文章：

[那些你可能不知道的微博奇技淫巧](https://mp.weixin.qq.com/s/j7VhoZXmUTnOWC5C_B8jlQ)

[想方便快捷的分享/收藏图片？试试免费好用的微博/b站图床](https://mp.weixin.qq.com/s/sGToO710n2h5avFk8aRQEw)  

[如何轻松下载腾讯/微博/优酷/爱奇艺/b站等全网视频？](https://mp.weixin.qq.com/s/3rB23e9L55hDBaPLDu6WMg)

这里再分享下如何快速导出你的所有微博数据，然后用Python分析某个微博账号的数据，比如高赞，转发，评论微博，微博词云，微博发布时间轴，以及使用的手机。

### 稳部落
 这是一个专业备份导出微博记录工具 https://www.yaozeyuan.online/stablog/ ，备份原理是登录https://m.weibo.cn/ 后, 模拟浏览器访问, 获取登录用户发布的所有微博并备份，即使炸号的微博, 只要能登录 https://m.weibo.cn/ 后还能看见自己的微博就可以备份。

这个工具使用说明见 https://github.com/YaoZeyuan/stablog ，支持Windows和Mac版。

打开软件后登录自己的微博，这里也可以刷微博。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-39accce2026ce533.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

打开系统设置可以看到总共微博条数2695，有269页，抓取时间要2个多小时。

![image.png](https://upload-images.jianshu.io/upload_images/23152173-902c1e5031fdb406.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
设置下排序规则，是否需要图片，PDF清晰度还有时间范围。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-261d2a67ca3326f5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
```js
支持增量备份, 备份过一次后, 可以只备份前10页内容, 加快备份速度

可在【管理数据】标签页中浏览已备份的微博记录列表

支持断点续传, 中途停止后, 可以记下备份的页码, 再次运行时修改【备份范围】配置项, 从该页之后再备份即可

32位操作系统下, 当pdf体积超过2GB后, 会提示文件已损坏. => 解决方案是更换64位操作系统, 或调整【时间范围】/【自动分卷】配置项, 通过限定单本pdf容量, 手工将pdf体积控制在2GB之内

利用【开发者模式】配置项, 可以极大加快微博备份速度。
```
![image.png](https://upload-images.jianshu.io/upload_images/23152173-7d3ffe3a76cf280e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

点击开始备份，可以看到运行日志。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-41a74665958172d4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/23152173-870cda32eae4f04b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
```js
2020-05-26 19:56:44.780: [FetchCustomer] 本次抓取的页码范围为:0~10 
2020-05-26 19:56:44.824: [FetchCustomer] 准备抓取第1/271页微博记录 
2020-05-26 19:56:45.275: [FetchCustomer] 第1/271页微博记录抓取成功, 准备存入数据库 
2020-05-26 19:56:45.967: [FetchCustomer] 第1/271页微博记录成功存入数据库 
2020-05-26 19:56:45.968: [FetchCustomer] 已抓取1/271页记录, 休眠20s, 避免被封 
2020-05-26 19:57:05.970: [FetchCustomer] 准备抓取第2/271页微博记录 
2020-05-26 19:57:06.310: [FetchCustomer] 第2/271页微博记录抓取成功, 准备存入数据库 
2020-05-26 19:57:07.039: [FetchCustomer] 第2/271页微博记录成功存入数据库 
2020-05-26 19:57:07.040: [FetchCustomer] 已抓取2/271页记录, 休眠20s, 避免被封 
2020-05-26 19:57:27.041: [FetchCustomer] 准备抓取第3/271页微博记录 
```
开始下载图片。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-beb4e59b537273b4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![image.png](https://upload-images.jianshu.io/upload_images/23152173-fb5854d053e8b4a7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
执行完毕，在本地生成了你的微博电子书。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-8342b3d7ba5cfc87.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
生成目录下有源文件和PDF。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-313e8bdde298b50c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
打开里面的HTML文件，备份的微博按照月份分类。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-81559eee5375b88f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
看看2019年4月7号的这条微博，图片都下载到本地了。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-9b8aae9564175dd3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
生成的PDF文件近30MB，不算太大。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-b40c25b08d683a85.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这个工具只能备份自己的微博数据，如果想备份其他人的，可以使用下面的Python脚本，它还能分析某个微博账号的数据。

### Python 备份和分析微博
这是个开源项目https://github.com/nlpjoe/weiboSpider ，使用方法很简单，先登录微博复制你的cookie，然后修改配置文件，之后执行脚本就可以了，看我的操作流程。

打开 https://m.weibo.cn/ 登录你的微博账号获取headers的 cookie ，就是箭头里那一长串字符。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-593e145d61493234.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
下载代码到本地，由于是国外网站下载会比较慢，可以在公众号内回复 `微博` 获取。

之后修改配置文件config.json ，这里说明下，user_id_list填你要分析的微博账号uid，可以填多个，我这里填的是非常喜欢的歌手李健。filter为1表示分析原创微博，如果分析所有微博填0即可。since_date为从哪天的微博开始分析，然后就是把上面复制的cookie填到对应位置。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-603ff0c6b5bdea31.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```js
{
	"user_id_list": ["1744395855"],
    "filter": 1,
    "since_date": "2015-01-01",
    "write_mode": ["csv", "txt"],
    "pic_download": 1,
    "video_download": 1,
    "cookie": "xxx",
    "mysql_config": {
        "host": "localhost",
        "port": 3306,
        "user": "root",
        "password": "123456",
        "charset": "utf8mb4"
    }
}
```
接着执行`pip install -r requirements.txt`安装以下依赖包。
```js
requests==2.22.0
jieba==0.42.1
wordcloud==1.6.0
scipy==1.2.1
seaborn==0.10.0
pandas
lxml
tqdm
```
当然你也可以单独安装  `pip --trusted-host pypi.doubanio.com install -U tqdm -i http://pypi.doubanio.com/simple`

scipy要安装指定版本 `pip --trusted-host pypi.doubanio.com install scipy==1.2.1 -i http://pypi.doubanio.com/simple`

上面都配置好了，就开始执行脚本 `python weibospider.py` ，我是在Windows下使用的Python3.7，可能跟作者环境不一样，遇到了些问题。


如果执行出现错误`SSLError(SSLCertVerificationError(1, '[SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed` ，改动文件 weibospider.py 里的requests请求参数。

`html = requests.get(url, cookies=self.cookie,verify=False).content`

需要注意如果提示`cookie错误或已过期`,再刷新下 m.weibo.cn复制cookie填到配置文件。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-d80b9e43d2562c7f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
没问题的话可以看到脚本开始执行了。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-c7b3dc6bd098a43e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![image.png](https://upload-images.jianshu.io/upload_images/23152173-7d8499f1872dea07.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

抓取完毕，开始生成李健的微博词云图，他的微博关键词为音乐，北京，朋友，歌手，电影，居然还提到了周杰伦。

![image.png](https://upload-images.jianshu.io/upload_images/23152173-50ab26c9061dc3ff.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
每个月转发评论点赞总数图，可以看到2016-2018年的微博数据是高峰期。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-e90ac700d23bcc29.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
原创微博和转发微博数据比例。

![image.png](https://upload-images.jianshu.io/upload_images/23152173-41ce3fd4cd954fed.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
李健发微博的工具主要为pc网页和iPad。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-b66bfcb9a738db8f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
生成的目录下还有所有微博的图片，视频，txt文件和excel数据。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-6dd57a962f05bb9c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
原创微博里转发最高的为2015年这条宣传电影《太平轮》主题曲 假如爱有天意 的微博https://www.weibo.com/1744395855/CruOoDGtB ，不过也才2万多，和某些动辄百万转发的流量明星的确不能比，毕竟人家水军多。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-a8164c54e141bc13.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
下图是李健微博转发最高的20条微博，平均不到1万的转发和评论，点赞倒是都有几万。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-85761c52c40c0094.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

ps:如果你想分析某个微博账号，自己又不会使用Python，联系我，包教包会，当然直接给你数据也可以。

推荐历史文章:

[如何发一条空白的朋友圈](https://mp.weixin.qq.com/s/Xz1m-mqtCcBF_4hmGCpkUQ)

[2019 年公众号 苏生不惑 近百篇原创文章整理](https://mp.weixin.qq.com/s/Lm4l_aPCSXymUGcqO_Yf3g)

[一个骚操作，公众号粉丝破10万！](https://mp.weixin.qq.com/s/0AJUFviGMYOMirdn1KDonA)

[微信撤回的消息也能看到！](https://mp.weixin.qq.com/s/PTRAREoFRfOJqOUlMCWhbQ)

[如何找回bilibili(b站)收藏夹里失效的视频？](https://mp.weixin.qq.com/s/i53iORP49o_4eRGGQEthsg)

[如何更优雅地使用 bilibili(b站)](https://mp.weixin.qq.com/s/a_lxHOQVA9RR_dYyzr56Gw)

[如何更优雅地看电影/刷剧](https://mp.weixin.qq.com/s/ksElusubk3s7dKtAqI4HKg)

[那些你可能不知道的网络冷知识奇技淫巧](https://mp.weixin.qq.com/s/-p-RZLh8ovNiCYv6YQkbrw)

[2020 最全百度网盘搜索，找电影资源不再愁](https://mp.weixin.qq.com/s/0uOyrcz0KP-qZhCNNCELhw)

![免费知识星球，每天更新](https://upload-images.jianshu.io/upload_images/17817191-9d41aa25edcd25c4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 公众号 苏生不惑
 ![扫描二维码关注或搜索微信susheng_buhuo](https://upload-images.jianshu.io/upload_images/17817191-6e0079f95d4c0338.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)