---
title: 不会 Python 没关系，手把手教你用 web scraper 抓取豆瓣电影 top 250 和 b 站排行榜
date: 2020-11-06 19:13:34
tags:
- 公众号
---
> 苏生不惑第190 篇原创文章，将本公众号设为`星标`，第一时间看最新文章。

关于Python之前分享过很多文章了：

[Python 抓取知乎电影话题下万千网友推荐的电影，这个国庆节不愁没电影看了](https://mp.weixin.qq.com/s/DwFv-Ry680gdT1yQAJ-u8g)

 [王菲k歌又上微博热搜，Python分析下微博网友评论](https://mp.weixin.qq.com/s/Y-zItsbQ0XrxcClvUilarQ) 

[如何批量下载知乎回答图片](https://mp.weixin.qq.com/s/oSvtFuH2_RYn_AE10x8iSQ)

 [如何发一条九宫格图片的朋友圈](https://mp.weixin.qq.com/s/AD7RAJm8p30LMdrgjy1CVw)

 [一键批量下载抖音无水印视频](https://mp.weixin.qq.com/s/UhLx4cjkfNVsdUyod7te0g)

[一键下载公众号所有文章，导出文件支持PDF，HTML，Markdown，Excel，chm等格式](https://mp.weixin.qq.com/s/sBK_NkSnS3qTOnajl6Y94Q)

[七夕又来了，给女朋友做个动态二维码](https://mp.weixin.qq.com/s/PnGaI1GkMABPCI7UXDRA1A)

[一键备份微博并导出生成PDF，顺便用Python分析微博账号数据](https://mp.weixin.qq.com/s/PlkPDmK2SUdQT59CzOJFMA)

如果要抓取数据，一般使用Python是很方便的，不过如果你还不会推荐使用Chrome扩展 web scraper，下面就分别用Python和 web scraper 抓取豆瓣电影top 250 和b站排行榜的数据。

### Python 抓取豆瓣电影
打开豆瓣电影top 250 主页 https://movie.douban.com/top250 
![image.png](https://upload-images.jianshu.io/upload_images/23152173-d752e7084bc65fc5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

我们需要抓取电影标题，排行，评分，和简介，python  抓取数据的步骤一般为请求网页，解析网页，提取数据和保存数据，下面是一段简单的Python代码。
```js
import requests
import re
import os
from hashlib import md5
from requests.exceptions import RequestException
import bs4
from requests import RequestException
from selenium import webdriver
import time
from matplotlib import pyplot as plt
import re
from wordcloud import WordCloud
import jieba
import pandas as pd

def request_url(url):
    headers = {
        'Referer': 'https://movie.douban.com',
        'Host': 'movie.douban.com',
        'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36'
    }
    response = requests.get(url, headers=headers)
    return response.text
def movie_info(html):
    data = []
    soup = bs4.BeautifulSoup(html, 'html.parser')
    items = soup.select('li > div.item')
    for item in items:
        desc_item = item.select('div.info > div.bd > p.quote > span')
        desc = ''
        if desc_item is not None and len(desc_item) > 0:
        	desc = desc_item[0].text
        data.append({
        	'url':item.select('div.info > div.hd > a')[0]['href'],
        	'title':item.select('div.info > div.hd > a > span')[0].text,
            'rank':item.select('div.pic > em')[0].text,
            'score':item.select('div.info > div.bd > div.star > span.rating_num')[0].text,
            'desc':desc,
        	})#{'url': 'https://movie.douban.com/subject/1292052/', 'title': '肖申克的救赎', 'rank': '1', 'score':
 '9.7', 'desc': '希望让人自由。'}
    return data

if __name__ == '__main__':
    urls = ['https://movie.douban.com/top250?start={0}&filter='.format(i * 25) for i in range(10)]
    movie_list = [request_url(url) for url in urls]
    movie_list = []
    for url in urls:
    	movie_list.append(request_url(url))
    	time.sleep(1)
    movie_url_list = [movie_info(movie) for movie in movie_list]
    data = []
    for j in movie_url_list:
    	for k in j:
    		data.append(k)
    print(data)
    df = pd.DataFrame(data)
    df.to_csv("douban_movies.csv",encoding="utf_8_sig",index=False)
```
执行 Python 脚本后会生成一个CSV文件，不过有些电影没有简介 ，比如周星驰的《九品芝麻官》https://movie.douban.com/subject/1297518/  
![image.png](https://upload-images.jianshu.io/upload_images/23152173-1ce2348db3202048.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### web scraper 抓取豆瓣电影
这是一款免费的Chrome扩展，只要建立sitemap即可抓取相应的数据，无需写代码即可抓取95%以上的网站数据（比如博客列表，知乎回答，微博评论等）， Chrome扩展地址 https://chrome.google.com/webstore/detail/web-scraper-free-web-scra/jnhgnonknehpejjnehehllkliplmbmhn ，如果你上不了谷歌在公众号后台回复 `Python` 获取我下载好的crx文件，先改文件名后缀为`.rar`，解压到一个目录中，然后加载已解压的扩展程序即可安装成功。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-9794451e95b6e812.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

使用web scraper抓取数据步骤为 创建 sitemap，新建 selector （抓取规则），启动抓取程序，导出 csv文件 。
 
打开谷歌浏览器控制台，可以看到多了个web scraper 标签，下面有sitemaps，sitemap，create new sitemap ，点击create新建一个爬虫抓取任务。

![image.png](https://upload-images.jianshu.io/upload_images/23152173-ff2e48811b601dcd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
豆瓣电影的分页链接为 https://movie.douban.com/top250?start=0&filter=，共10页，所以URL填入 https://movie.douban.com/top250?start=[0-250:25]&filter=  ，name随意填一个。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-471aded357fb1747.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
然后点击add new selector 添加新的选择器。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-3fafb4fa41267086.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
给id起个名，type为 element ，点击 select 选中第一部电影《肖申克的救赎》，可以看到网页标红了。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-3cb9d70a60bcb07e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
然后再选择第二条，可以看到下面的电影都选中了，点击 done selecting 就好了。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-685ce0272e1e032b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

ps：抓取到的选择器其实就是css结构，右键copy selector也可以看到。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-039d8cedebe19837.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

接着点击 element preview 预览下可以看到电影元素都抓取到了，因为一页有多部电影还要选中  Multiple 。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-4b54ca0eecf16e63.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
然后进入刚才建的 element 里新加选择器。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-9b02903c70dffe18.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
共有5个选择器，分别为电影名，豆瓣链接，电影排名，电影简介，豆瓣评分。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-2089427651cad4a3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
可以预览下新建的电影名选择器看看效果。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-5e5684233c5d3ece.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

 点击selector graph 可以看到抓取的选择器关系图。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-2ab374b2ace19c27.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
选择器都建好后点击 scrape 开始抓取数据了。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-80470c8c5957f7df.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/23152173-ff284b6f58be9472.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
浏览器自动弹出窗口抓取数据，不用管它，抓取完后它会自动关闭。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-768942cb88a0ceb5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
很快抓取完了。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-8b0a28cbc0146f1d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
再预览下抓取的数据是否正常。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-3a4c5aaca22fac77.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
确认没问题后点击 export data as CSV 导出CSV文件。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-ef90ca2293b7a137.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
打开生成的CSV文件，可以看到抓取的电影排序乱了。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-695151dcbad776ac.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
没关系，选中电影排名这列，选择升序排列。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-c80a28006beddf88.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
最后抓取的250条豆瓣电影数据结果就是这样了。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-3aa889ffd2854df1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

最后可以export sitemap 导出这个爬虫任务，是个json格式字符串，你可以直接复制我这个导入直接抓取豆瓣电影数据。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-57ae1f634a3d3c88.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```js
{"_id":"douban","startUrl":["https://movie.douban.com/top250?start=[0-250:25]&filter="],"selectors":[{"id":"row","type":"SelectorElement","parentSelectors":["_root"],"selector":".grid_view li","multiple":true,"delay":0},{"id":"电影名","type":"SelectorText","parentSelectors":["row"],"selector":"span.title","multiple":false,"regex":"","delay":0},{"id":"豆瓣链接","type":"SelectorLink","parentSelectors":["row"],"selector":".hd a","multiple":false,"delay":0},{"id":"电影排名","type":"SelectorText","parentSelectors":["row"],"selector":"em","multiple":false,"regex":"","delay":0},{"id":"电影简介","type":"SelectorText","parentSelectors":["row"],"selector":"span.inq","multiple":false,"regex":"","delay":0},{"id":"豆瓣评分","type":"SelectorText","parentSelectors":["row"],"selector":"span.rating_num","multiple":false,"regex":"","delay":0}]}
```
使用 web scraper 抓取数据就是这么简单，不用写代码也能轻松完成抓取任务，不过第一次操作还是有点难，尤其对不熟悉网页结构的小伙伴，之后有空我录制一个视频方便大家自己操作下（有问题文末评论或者加我微信交流），下面再用 web scraper 抓取b站排行榜 https://www.bilibili.com/v/popular/rank/all 
![image.png](https://upload-images.jianshu.io/upload_images/23152173-3abdd826851774b4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
这里抓取视频排名，标题，播放量，弹幕数，up主，点赞数，投币数，收藏数。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-ee130eb8635e49f6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
其中点赞数，投币数，收藏数在视频链接的二级页。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-e9e4cb694a31c493.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

先预览下抓取的效果。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-9e8f1ac22cade61a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/23152173-0c9f8a3852cb5872.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
最后导出的CSV文件。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-eefb9874e5e660af.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

为了方便你抓取，我也提供了json字符串，你可以直接导入抓取。
 ```js
{"_id":"bilibili_rank","startUrl":["https://www.bilibili.com/v/popular/rank/all"],"selectors":[{"id":"row","type":"SelectorElement","parentSelectors":["_root"],"selector":"li.rank-item","multiple":true,"delay":0},{"id":"视频排名","type":"SelectorText","parentSelectors":["row"],"selector":"div.num","multiple":false,"regex":"","delay":0},{"id":"视频标题","type":"SelectorText","parentSelectors":["row"],"selector":"a.title","multiple":false,"regex":"","delay":0},{"id":"播放量","type":"SelectorText","parentSelectors":["row"],"selector":".detail > span:nth-of-type(1)","multiple":false,"regex":"","delay":0},{"id":"弹幕数","type":"SelectorText","parentSelectors":["row"],"selector":"span:nth-of-type(2)","multiple":false,"regex":"","delay":0},{"id":"up主","type":"SelectorText","parentSelectors":["row"],"selector":"a span","multiple":false,"regex":"","delay":0},{"id":"视频链接","type":"SelectorLink","parentSelectors":["row"],"selector":"a.title","multiple":false,"delay":0},{"id":"点赞数","type":"SelectorText","parentSelectors":["视频链接"],"selector":"span.like","multiple":false,"regex":"","delay":0},{"id":"投币数","type":"SelectorText","parentSelectors":["视频链接"],"selector":"span.coin","multiple":false,"regex":"","delay":0},{"id":"收藏数","type":"SelectorText","parentSelectors":["视频链接"],"selector":"span.collect","multiple":false,"regex":"","delay":0}]}
```
### 公众号 苏生不惑
 ![扫描二维码关注或搜索微信susheng_buhuo](https://upload-images.jianshu.io/upload_images/17817191-6e0079f95d4c0338.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

