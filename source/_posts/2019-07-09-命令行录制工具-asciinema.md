---
title: 命令行录制工具 asciinema
date: 2019-07-09 19:59:26
tags:
- 公众号
---
平常出bug求助的时候有时候贴代码或者截图往往不直观，如果能重现给对方看就好了，这里推荐 2 个命令行的录制工具。
### asciinema
网站`https://asciinema.org/ `，github主页https://github.com/asciinema 
直接使用 `pip install asciinema `来安装。
 执行`asciinema rec` 开始录制,录制完成后  exit 退出，可以保存到本地或者上传到 `https://asciinema.org`  。
```js
[root@VM_0_14_centos ~]# asciinema rec
asciinema: recording asciicast to /tmp/tmp1ua5a2rx-ascii.cast
asciinema: press <ctrl-d> or type "exit" when you're done
[root@VM_0_14_centos ~]# pwd
/root
[root@VM_0_14_centos ~]# cd /usr/share/nginx/html/
[root@VM_0_14_centos html]# pip install asciinema
DEPRECATION: Python 3.4 support has been deprecated. pip 19.1 will be the last one supporting it. Please upgrade your Python as Python 3.4 won't be maintained after March 2019 (cf PEP 429).
Looking in indexes: http://mirrors.tencentyun.com/pypi/simple
Requirement already satisfied: asciinema in /usr/lib/python3.4/site-packages (2.0.2)
You are using pip version 19.0.3, however version 19.1.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
[root@VM_0_14_centos html]# pip list |grep ascii
DEPRECATION: Python 3.4 support has been deprecated. pip 19.1 will be the last one supporting it. Please upgrade your Python as Python 3.4 won't be maintained after March 2019 (cf PEP 429).
asciinema              2.0.2
You are using pip version 19.0.3, however version 19.1.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
[root@VM_0_14_centos html]# exit
exit
asciinema: recording finished
asciinema: press <enter> to upload to asciinema.org, <ctrl-c> to save locally

View the recording at:

    https://asciinema.org/a/AdnqMX0QfOg5c7USOtwHZ4Hz1

This installation of asciinema recorder hasn't been linked to any asciinema.org
account. All unclaimed recordings (from unknown installations like this one)
are automatically archived 7 days after upload.

If you want to preserve all recordings made on this machine, connect this
installation with asciinema.org account by opening the following link:

    https://asciinema.org/connect/01fb0f0e-c56a-450f-80ac-4020188dd957
```
 录制过程在https://asciinema.org/a/AdnqMX0QfOg5c7USOtwHZ4Hz1 可以看到了。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-2c63f9c98c78d4ed.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
 如果分享给他人可以用邮箱注册，它不需要密码就可以注册。我注册后的主页[https://asciinema.org/~susheng](https://asciinema.org/~susheng)
然后打开这个链接 https://asciinema.org/connect/01fb0f0e-c56a-450f-80ac-4020188dd957 就会保存到你账号下。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-f7c40ae5768692a2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
设置为public 后可生成公开链接，可分享给他人观看，还可以嵌入到自己的网站。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-b5912fb223a74a81.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/17817191-af4bf33fde51c8cd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
视频链接后加 .png 是视频截图 https://asciinema.org/a/254348.png ，而链接后加 .js 就可以直接嵌入网站了。
 ```js
<a href="https://asciinema.org/a/254348" target="_blank"><img src="https://asciinema.org/a/254348.svg" /></a>
<script src="https://asciinema.org/a/254348.js" id="asciicast-254348" async data-autoplay="true" data-size="big"></script>
```
###  TermRecord
TermRecord也是用 pip 安装 `pip install TermRecord`, 直接开始录制 `TermRecord -o termrecord.html `输入 exit 结束录制 。这个 termrecord.html 就是录制生成的文件，可以直接用浏览器打开。
```js
[root@VM_0_14_centos html]# TermRecord -o termrecord.html
Script started, file is /tmp/tmpdekpz_p2
[root@VM_0_14_centos html]# pwd
/usr/share/nginx/html
[root@VM_0_14_centos html]# whoami
root
[root@VM_0_14_centos html]# pip install TermRecord
DEPRECATION: Python 3.4 support has been deprecated. pip 19.1 will be the last one supporting it. Please upgrade your Python as Python 3.4 won't be maintained after March 2019 (cf PEP 429).
Looking in indexes: http://mirrors.tencentyun.com/pypi/simple
Requirement already satisfied: TermRecord in /usr/lib/python3.4/site-packages (1.2.5)
Requirement already satisfied: Jinja2>=2.6 in /usr/lib64/python3.4/site-packages (from TermRecord) (2.10.1)
Requirement already satisfied: MarkupSafe>=0.23 in /usr/lib64/python3.4/site-packages (from Jinja2>=2.6->TermRecord) (1.1.1)
You are using pip version 19.0.3, however version 19.1.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
[root@VM_0_14_centos html]# pip list|grep Term
DEPRECATION: Python 3.4 support has been deprecated. pip 19.1 will be the last one supporting it. Please upgrade your Python as Python 3.4 won't be maintained after March 2019 (cf PEP 429).
TermRecord             1.2.5
You are using pip version 19.0.3, however version 19.1.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
[root@VM_0_14_centos html]# exit
exit
Script done, file is /tmp/tmpdekpz_p2
```
然后打开文件就可以看到录制过程了 http://118.24.158.116:8888/termrecord.html
![image.png](https://upload-images.jianshu.io/upload_images/17817191-70fe211b10dbc15c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

另外还有个基于ruby的showterm和termtosvg就不演示了 [http://showterm.io/](http://showterm.io/)  [https://github.com/nbedos/termtosvg](https://github.com/nbedos/termtosvg)

推荐阅读：

[那些你可能不知道的浏览器奇技淫巧](https://mp.weixin.qq.com/s/-cSjrvkibYGp5Fx8gCTFuw)

[那些你可能不知道的微信奇技淫巧](https://mp.weixin.qq.com/s/eGDO0Y8el_dsEyriCoAgog)

[那些你可能不知道的微博奇技淫巧](https://mp.weixin.qq.com/s/j7VhoZXmUTnOWC5C_B8jlQ)

[那些你可能不知道的网易云音乐奇技淫巧](https://mp.weixin.qq.com/s/LtI2piwAIDXA590NEsXvuw)

 [那些你可能不知道的搜索奇技淫巧](https://mp.weixin.qq.com/s?__biz=MzIyMjg2ODExMA==&mid=2247483979&idx=1&sn=0735daa1d805b66d346ed0e8e60a841f&scene=21#wechat_redirect)

[那些你可能不知道的视频下载奇技淫巧](https://mp.weixin.qq.com/s?__biz=MzIyMjg2ODExMA==&mid=2247483983&idx=1&sn=f0e1d9a8e22caf609d6c21431a530186&chksm=e827a5aedf502cb8b72f2036054753fcfd9c20c28b9fbccdeae619a254a80e1024f18ba06523&token=457023358&lang=zh_CN#rd)

[那些你可能不知道的免费观看 VIP 视频奇技淫巧](https://mp.weixin.qq.com/s/R3x-xZwqLIVwPjlgikDQ9A)

### 公众号：苏生不惑
 ![扫描二维码关注](https://upload-images.jianshu.io/upload_images/17817191-6e0079f95d4c0338.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)




