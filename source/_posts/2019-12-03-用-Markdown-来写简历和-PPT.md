---
title: 用 Markdown 来写简历和 PPT
date: 2019-12-03 20:09:00
tags:
- 公众号
---
之前写过 markdown 的使用[我是如何用 Markdown 写公众号文章的](https://mp.weixin.qq.com/s/TuJIqv5wv27avFKG8zmJUQ) ，强烈建议你花10分钟学学markdown，那时候你才知道原来写作可以如此顺畅。

除了网页版 markdown 编辑器， 这里推荐一款非常好用的支持实时预览的markdown客户端软件 Typora ，它支持 Windows mac Linux等系统，能自动保存，不用担心写好的文档丢失，导入文件格式支持.docx, .latex,.epub等，导出文件格式支持 PDF，HTML等格式，如果要导出LaTeX格式需要安装 Pandoc 插件。

软件下载地址 https://github.com/typora https://www.typora.io/ 。

![image.png](https://upload-images.jianshu.io/upload_images/17817191-eb5719fb2c6a7255.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
使用markdown语法编辑（非常易学）。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-e407c54f52452211.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
退出源代码模式可以显示效果（可以看到字体加粗了），最后保存文件名后缀为.md，然后可以直接用Typora打开。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-7e5c6b81a8a54beb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

比如我之前用一个工具将 MySQL 表结构生成 Markdown 文件https://learnku.com/articles/36523 

![image.png](https://upload-images.jianshu.io/upload_images/17817191-6c01906a534a5226.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


然后将markdown文件导出为PDF
![image.png](https://upload-images.jianshu.io/upload_images/17817191-6cbf883442ccbad0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![image.png](https://upload-images.jianshu.io/upload_images/17817191-a3342d4fd2acc58c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

效果如图，左侧还有目录结构，是每个表的表名。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-06ed8ba88dc2f6d2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


markdown文件还可以导出为HTML，这样可以直接复制到微信公众号发布，当然这有点麻烦，还是建议使用 https://mdnice.com/ 这样的在线工具。

导入文件需要 pandoc插件支持  https://pandoc.org/installing.html
![image.png](https://upload-images.jianshu.io/upload_images/17817191-2009e8b3e1d5014a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
 

![image.png](https://upload-images.jianshu.io/upload_images/17817191-711213f2c8723889.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### markdown简历  
学会了markdown，就可以用来写简历了，比如之前写过的[那些你可能用得上的简历写作工具](https://mp.weixin.qq.com/s/sng3uK9Nge1OD2gc5DDuZg) ，这里推荐一个非常好用的在线markdown工具 http://resumd.t9t.io/  ，可以自定义样式(GitHub theme, timqian.com theme, TUI theme)，最后导出为md PDF 或者HTML。

 比如我之前的文章 [公众号苏生不惑原创文章整理](https://mp.weixin.qq.com/s/iL6WyI-TChtjZMuu5G5W8A)  copy到这里。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-e3cefb291eaabcfc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
导出为resume.md，然后用 Typora 打开。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-34274530f81b0382.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
导出为HTML格式，用浏览器打开。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-f17f14b8d4426801.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
导出为PDF ，用浏览器打开。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-c569963b22ae707c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/17817191-9119477400a44191.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
最后将写好的简历分享出来发给别人看。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-c5a356483a1b12df.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
如果遇到问题可以到 https://github.com/timqian/resumd/issues 提问。

### Markdown 文档转成高大上 PPT
累死累活干不过做 PPT 的，那就将markdown转为PPT吧，推荐一款能将 Markdown 文档转成高大上 PPT 的开源工具，支持图表、流程图、数学符号、自定义主题配色以及样式等  https://github.com/ksky521/nodeppt https://nodeppt.js.org/#slide=1 直接按方向键翻页，和使用office一样。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-92bc1052487eb294.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
使用方法很简单
```js
npm install -g nodeppt
 
 # create a new slide with an official template
$ nodeppt new slide.md

# create a new slide straight from a github template
$ nodeppt new slide.md -t username/repo

# start local sever show slide
$ nodeppt serve slide.md

# to build a slide
$ nodeppt build slide.md
```
类似的还有  https://eloc.now.sh/  https://badgen-5min.now.sh/  
https://github.com/amio/eloc https://github.com/hakimel/reveal.js ，我之前也写过 [ppt 神器 reveal](https://mp.weixin.qq.com/s/WNuRKxtvwK_6AAnKmNU8yw) ，我还做个了周杰伦的在线个人PPT https://sushengbuhuo.gitee.io/blog/jay/#/start 。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-96ccf00df3fd5ce4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


最后推荐一个  Markdown 的表格格式在线生成工具，图形化操作，一键生成，可以生成 Letex、HTML Table、MediaWiki 等，有点意思，可以玩玩 https://www.tablesgenerator.com/  
![image.png](https://upload-images.jianshu.io/upload_images/17817191-047d1c257756b3e0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
### 其他
在线简历 https://resume.mdnice.com/ 
Typora 完全使用详解 https://sspai.com/post/54912  
推介一个不错的在线公式、图形编辑生成器，可以在线转化为 SVG、Letex 格式，方便的插入支持 Letex 的 Markdown 编辑器中，在支持的编辑器前后加上 `$$` 即可，附上我在 Typora 中画的一个公式～  https://www.mathcha.io 
推介一个炫酷的字符码图在线生成工具，附上我自己画的一个 Nodejs 事件循环机制图～ http://asciiflow.com/ 
让 Markdown 写作更简单，免费极简编辑器 https://sspai.com/post/30292
使用 Pandoc 与 Markdown 生成 PDF 文件 https://jdhao.github.io/2017/12/10/pandoc-markdown-with-chinese/
https://github.com/jgm/pandoc/wiki/Pandoc-With-Chinese-(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)
https://www.bbsmax.com/A/A7zgplD1J4/  
https://www.bajins.com/Other/Markdown%E5%B7%A5%E5%85%B7.html#微信公众号排版 http://cv.ftqq.com/#
简历https://github.com/geekcompany/DeerResume
使用 Markdown 制作漂亮的在线简历 https://bigliao.github.io/markCV/  https://github.com/BigLiao/markCV
简历https://github.com/timqian/resumd   
一款 Markdown 语法排版简历的工具 https://github.com/mdnice/markdown-resume
https://openwrite.cn
https://www.mdnice.com/
http://blog.didispace.com/tools/online-markdown/
https://md.phodal.com/
http://md.codingpy.com/
http://js8.in/mpeditor/
公众号排版 https://github.com/didadi599/wechat-markdown-editor
通过导入json、csv、excel、html table生成Markdown表格，一个写博客必备神器 https://tableconvert.com/
一款基于 Vue、Vditor，为未来而构建的在线 Markdown 编辑器；轻量且强大：内置粘贴 HTML 自动转换为 Markdown，支持流程图、甘特图、时序图、任务列表，可导出携带样式的图片、PDF、微信公众号特制的 HTML 等等。 https://markdown.lovejade.cn/export/pdf/   https://www.lovejade.cn/zh/works/ 
 
推荐阅读:


[如何发一条空白的朋友圈](https://mp.weixin.qq.com/s/Xz1m-mqtCcBF_4hmGCpkUQ)

[那些你可能不知道的微信奇技淫巧](https://mp.weixin.qq.com/s/eGDO0Y8el_dsEyriCoAgog)

[如何在豆瓣租房小组快速找到满意的房子](https://mp.weixin.qq.com/s/k5lBwiDzGgSU3fh2v2Rw9A)

[那些我关注的 b 站 up 主](https://mp.weixin.qq.com/s/952eqef1Rm3HpH5DYbTjZg)

[那些我常听的中文播客节目](https://mp.weixin.qq.com/s/Y8wlutMFZymzCAKM3fp8SA)

[2019年11月最新使用油猴加速百度网盘下载方法](https://mp.weixin.qq.com/s/XTn8wPEyThacR3GLHyzBLA)

[比谷歌更有意思的知识提取搜索引擎 magi](https://mp.weixin.qq.com/s/f36fXJbMYgWMTSTaGMeFCg)

[有了内网穿透神器 ngrok ，个人电脑也能做服务器](https://mp.weixin.qq.com/s/I6Cd01c9fDx3MFeE3pGauw)

 ![免费星球](https://upload-images.jianshu.io/upload_images/17817191-8ff6e00de5b0726e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
### 公众号：苏生不惑
 ![扫描二维码关注或搜索微信susheng_buhuo](https://upload-images.jianshu.io/upload_images/17817191-6e0079f95d4c0338.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)