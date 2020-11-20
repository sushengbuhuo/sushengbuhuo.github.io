---
title: 不用写代码，Chrome 扩展神器 web scraper 抓取知乎热榜/话题/回答/专栏，豆瓣电影
date: 2020-11-20 18:49:40
tags:
- 公众号
---
> 苏生不惑第`195` 篇原创文章，将本公众号设为`星标`，第一时间看最新文章。

之前分享过[不会 Python 没关系，手把手教你用 web scraper 抓取豆瓣电影 top 250 和 b 站排行榜](https://mp.weixin.qq.com/s/6UrMYkJoQGhNS_JvCZYwWA) ，后来我又玩了下，这个插件还是挺有意思的，所以通过抓取知乎和豆瓣再总结分享下。

### 知乎热榜
知乎热榜地址 https://www.zhihu.com/hot  （其实知乎还有个单独的热榜页面https://www.zhihu.com/billboard ），这里新增一个type `Element attribute` ，因为之前抓取豆瓣链接用的 link，它把文字也抓取了，而我们只要里面的href属性。

同样的先创建一个element的容器。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-18e11ee17b7f2f13.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

里面加4个选择器：知乎排名 ，知乎标题， 知乎链接 ，知乎热度 。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-5af1882718979e0a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
预览下数据没问题。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-24935e13fbd0455b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
开始抓取数据并导出CSV文件。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-cfbf4b54ee671e9e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
不过生成的CSV文件排序乱了  。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-09010d986c156d33.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
在排序和筛选里按照排名重新排下就好了（如果需要更复杂的排序可以借助Python的pandas），看最后的结果。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-acc96121f9326100.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
不过有个问题，热榜里的广告 https://www.zhihu.com/xen/market/ecom-page/1305179157022478336 没有热度，所以结果为null。 
为了方便大家学习抓取，我导出了sitemap，你可以直接导入使用。
```js
{"_id":"zhihu_hot","startUrl":["https://www.zhihu.com/hot"],"selectors":[{"id":"知乎排名","type":"SelectorText","parentSelectors":["内容容器"],"selector":"div.HotItem-rank","multiple":false,"regex":"","delay":0},{"id":"知乎标题","type":"SelectorText","parentSelectors":["内容容器"],"selector":"h2","multiple":false,"regex":"","delay":0},{"id":"知乎链接","type":"SelectorElementAttribute","parentSelectors":["内容容器"],"selector":".HotItem-content a","multiple":false,"extractAttribute":"href","delay":0},{"id":"知乎热度","type":"SelectorText","parentSelectors":["内容容器"],"selector":"div.HotItem-metrics","multiple":false,"regex":"","delay":0},{"id":"内容容器","type":"SelectorElement","parentSelectors":["_root"],"selector":"section","multiple":true,"delay":0}]}
```
![image.png](https://upload-images.jianshu.io/upload_images/23152173-6813b967bbca7647.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 知乎回答
这里以知乎日报的回答为例  
https://www.zhihu.com/org/zhi-hu-ri-bao-51-41/answers 
![image.png](https://upload-images.jianshu.io/upload_images/23152173-3ab27631a502be51.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
需要注意知乎的回答需要点击阅读全文才能完全展示。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-5af6a554ed66b5d0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
所以这里又增加个type `element click`  
![image.png](https://upload-images.jianshu.io/upload_images/23152173-af3c9b14782225a4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
里面有4个选择器：问题标题，赞同数，阅读全文，回答内容，回答链接。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-0e7d0a63274e249a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
看下抓取结果没问题。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-331fa72ff0a9867e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

为了方便大家学习抓取，我导出了sitemap，你可以直接导入使用。
```js
{"_id":"zhihu_answer","startUrl":["https://www.zhihu.com/people/san-sheng-ruo-meng/answers"],"selectors":[{"id":"回答容器","type":"SelectorElement","parentSelectors":["_root"],"selector":"div.List-item","multiple":true,"delay":0},{"id":"问题标题","type":"SelectorText","parentSelectors":["回答容器"],"selector":"[itemprop='zhihu:question'] a","multiple":false,"regex":"","delay":0},{"id":"赞同数","type":"SelectorText","parentSelectors":["回答容器"],"selector":"button.VoteButton--up","multiple":false,"regex":"","delay":0},{"id":"阅读全文","type":"SelectorElementClick","parentSelectors":["回答容器"],"selector":"button.ContentItem-more","multiple":true,"delay":2000,"clickElementSelector":"button.ContentItem-more","clickType":"clickOnce","discardInitialElements":"do-not-discard","clickElementUniquenessType":"uniqueText"},{"id":"回答内容","type":"SelectorText","parentSelectors":["回答容器"],"selector":"div.RichContent-inner","multiple":false,"regex":"","delay":0},{"id":"回答链接","type":"SelectorElementAttribute","parentSelectors":["回答容器"],"selector":"[itemprop='zhihu:question'] a","multiple":false,"extractAttribute":"href","delay":0}]}
```

### 知乎专栏文章

这里以另一面专栏为例 https://zhuanlan.zhihu.com/Wisdom  ，由于文章是滚动式加载，因此增加type `Element scroll down`
![image.png](https://upload-images.jianshu.io/upload_images/23152173-654a05c6a19f4544.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
里面有5个选择器：文章标题，阅读全文，文章内容，文章链接，文章赞数。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-9ed9aa216b2e9768.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
抓取后页面会自动滚动加载，并且点击阅读全文展开内容。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-a240067de240ef73.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
为了方便大家学习抓取，我导出了sitemap，你可以直接导入使用，如果还想导出文章转PDF可以参考这个Python脚本 https://gitee.com/crossin/snippet/blob/master/get_zhihu/get_zhihu.py 。
```js
{"_id":"zhihu_zhuanlan","startUrl":["https://zhuanlan.zhihu.com/Wisdom"],"selectors":[{"id":"文章容器","type":"SelectorElementScroll","parentSelectors":["_root"],"selector":"div.css-8txec3","multiple":true,"delay":2000},{"id":"文章标题","type":"SelectorText","parentSelectors":["文章容器"],"selector":".ContentItem-title a","multiple":false,"regex":"","delay":0},{"id":"阅读全文","type":"SelectorElementClick","parentSelectors":["文章容器"],"selector":"button.ContentItem-more","multiple":true,"delay":2000,"clickElementSelector":"button.ContentItem-more","clickType":"clickOnce","discardInitialElements":"do-not-discard","clickElementUniquenessType":"uniqueHTMLText"},{"id":"文章内容","type":"SelectorText","parentSelectors":["文章容器"],"selector":"div.RichContent-inner","multiple":false,"regex":"","delay":0},{"id":"文章链接","type":"SelectorElementAttribute","parentSelectors":["文章容器"],"selector":".ContentItem-title a","multiple":false,"extractAttribute":"href","delay":0},{"id":"文章赞数","type":"SelectorText","parentSelectors":["文章容器"],"selector":"button.VoteButton--up","multiple":false,"regex":"","delay":0}]}
```
### 知乎话题
这里以电影话题为例 https://www.zhihu.com/topic/19550429/top-answers ，由于这个话题下回答太多，我们只取前50条，因此在元素后增加`-n+50` nth-of-type(-n+50) ，同样是滚动加载 `Element scroll down` 。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-a5ec4444493997fa.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

里面有3个选择器 ：知乎问题，回答人，赞同数 。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-ffc6aaf59aa5fe03.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

需要注意title 不能直接用`[itemprop='zhihu:question'] a` ，有些标题没有这个类，可以点击两次 P 键，匹配到标题的父标签 h2 或者 h2.ContentItem-title。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-99a6f666ac0e7096.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
看下抓取结果没问题。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-f2fc8c835cfeea69.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
为了方便大家学习抓取，我导出了sitemap，你可以直接导入使用。
```js
{"_id":"zhihu_topic","startUrl":["https://www.zhihu.com/topic/19550429/top-answers"],"selectors":[{"id":"topic","type":"SelectorElementScroll","parentSelectors":["_root"],"selector":"div.List-item:nth-of-type(-n+100)","multiple":true,"delay":2000},{"id":"知乎问题","type":"SelectorText","parentSelectors":["topic"],"selector":"h2","multiple":false,"regex":"","delay":0},{"id":"回答人","type":"SelectorText","parentSelectors":["topic"],"selector":".AuthorInfo-name div.Popover","multiple":false,"regex":"","delay":0},{"id":"赞同数","type":"SelectorText","parentSelectors":["topic"],"selector":"button.VoteButton--up","multiple":false,"regex":"","delay":0}]}
```
### 微博转发
这里以李健的这条微博转发为例 https://weibo.com/1744395855/JpvzPo9Rx?type=repost ，翻页的type为 `element click ` ，这种翻页页面不会刷新。

![image.png](https://upload-images.jianshu.io/upload_images/23152173-28429c28ba30a4ab.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

 里面有3个选择器：微博昵称，微博评论，评论时间。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-c4bee952b8316839.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
看下抓取结果没问题。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-930df52bd087cb56.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/23152173-bac91764a2bd27c0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

为了方便大家学习抓取，我导出了sitemap，你可以直接导入使用。
```js
{"_id":"weibo","startUrl":["https://weibo.com/1744395855/JpvzPo9Rx?type=repost"],"selectors":[{"id":"content","type":"SelectorElementClick","parentSelectors":["_root"],"selector":"div.list_li","multiple":true,"delay":2000,"clickElementSelector":"a.page[action-data]","clickType":"clickOnce","discardInitialElements":"do-not-discard","clickElementUniquenessType":"uniqueText"},{"id":"微博昵称","type":"SelectorText","parentSelectors":["content"],"selector":".WB_text a[usercard]","multiple":false,"regex":"","delay":0},{"id":"微博评论","type":"SelectorText","parentSelectors":["content"],"selector":".WB_text span","multiple":false,"regex":"","delay":0},{"id":"评论时间","type":"SelectorText","parentSelectors":["content"],"selector":".WB_from a","multiple":false,"regex":"","delay":0}]}
```
### 豆瓣电影
之前文章抓取豆瓣电影是通过URL分页来抓取 https://movie.douban.com/top250?start=[0-250:25]&filter=  ，这里通过点击下一页来抓取，新增type 为 `link` ，它有两个父节点：_root 和自己（按 shift 可以多选）。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-9d8e78ed05fc62a6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
结构图如下：
![image.png](https://upload-images.jianshu.io/upload_images/23152173-af79a3c10e1e4c1b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
电影元素里有5个选择器：电影名称，电影排名，电影简介，豆瓣评分，豆瓣链接。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-1ca3b589518541d4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
抓取结果也很完美。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-263856e78477e958.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

为了方便大家学习抓取，我导出了sitemap，你可以直接导入使用。
```js
{"_id":"douban_movies","startUrl":["https://movie.douban.com/top250?start=0&filter="],"selectors":[{"id":"下一页","type":"SelectorLink","parentSelectors":["_root","下一页"],"selector":".next a","multiple":true,"delay":0},{"id":"电影元素","type":"SelectorElement","parentSelectors":["_root","下一页"],"selector":".grid_view li","multiple":true,"delay":0},{"id":"电影名称","type":"SelectorText","parentSelectors":["电影元素"],"selector":"span.title:nth-of-type(1)","multiple":false,"regex":"","delay":0},{"id":"电影排名","type":"SelectorText","parentSelectors":["电影元素"],"selector":"em","multiple":false,"regex":"","delay":0},{"id":"电影简介","type":"SelectorText","parentSelectors":["电影元素"],"selector":"span.inq","multiple":false,"regex":"","delay":0},{"id":"豆瓣评分","type":"SelectorText","parentSelectors":["电影元素"],"selector":"span.rating_num","multiple":false,"regex":"","delay":0},{"id":"豆瓣链接","type":"SelectorElementAttribute","parentSelectors":["电影元素"],"selector":"div.hd a","multiple":false,"extractAttribute":"href","delay":0}]}
```
通过这次新增的几个type ：`Element attribute` ， `element click` ，`Element scroll down`， `link`，以及 nth-of-type(-n+50) 应该可以完成大部分网站的数据抓取。

最近文章：

[视频下载神器：支持腾讯/优酷/爱奇艺/b站/微博等全网视频](https://mp.weixin.qq.com/s/n9ddxx6Zu5hC7cqEXRnMOg)

[良心整理：PDF工具合集](https://mp.weixin.qq.com/s/j88qrbHF9k-h7zrgfD87iw)

[2020 最全电子书搜索网站，找电子书不再愁](https://mp.weixin.qq.com/s/pt0hCthceThMZVU0Ht89AA)

[b 站账号快速升级到 Lv6：每天自动签到，观看，分享，投币视频 ](https://mp.weixin.qq.com/s/Agh5EAgkd6__jq3J6CCNlA)

[集赞生成器：朋友圈集赞不求人](https://mp.weixin.qq.com/s/Zjhap47PGpIhQi79gkekCg)

### 公众号 苏生不惑
 ![扫描二维码关注或搜索微信susheng_buhuo](https://upload-images.jianshu.io/upload_images/17817191-6e0079f95d4c0338.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)