---
title: Pyhon 爬虫框架 looter
date: 2019-05-22 11:52:54
tags:
---

知名的pyspider，scrapy就不说了，今天说说这个 looter
## 安装
先安装好python3，需要3.6以上，然后执行 pip install looter
```js
λ looter -h
Looter, a python package designed for web crawler lovers :)
Author: alphardex  QQ:2582347430
If any suggestion, please contact me.
Thank you for cooperation!

Usage:
  looter genspider <name> [--async]
  looter shell [<url>]
  looter (-h | --help | --version)

Options:
  -h --help        Show this screen.
  --version        Show version.
  --async          Use async instead of concurrent.
```
## 图片爬虫
```js
λ looter shell https://konachan.com/post

Available objects:
    url           The url of the site you crawled.
    res           The response of the site.
    tree          The element source tree to be parsed.

Available functions:
    fetch         Send HTTP request to the site and parse it as a tree. [has async version]
    view          View the page in your browser. (test rendering)
    links         Get the links of the page.
    save          Save what you crawled as a file. (json or csv)

Examples:
    Get all the <li> elements of a <ul> table:
        >>> items = tree.css('ul li')

    Get the links with a regex pattern:
        >>> items = links(res, pattern=r'.*/(jpeg|image)/.*')

For more info, plz refer to documentation:
    [looter]: https://looter.readthedocs.io/en/latest/
 imgs = tree.css('a.directlink::attr(href)').extract()
>>> imgs[1:10]
['https://konachan.com/jpeg/c67d38b73df6e32199127998fc0f3338/Konachan.com%20-%20283270%20ass%20bed%20blush%20breasts%20clover_%28sakura_gamer%29%20game_cg%20nipples%20pussy_juice%20red_hair%20sakura_gamer%20wanaca%20winged_cloud.jpg', 'https://konachan.com/image/a0952daaf9aa94cd676901203680fec4/Konachan.com%20-%20283269%20aliasing%20anus%20azur_lane%20blush%20breasts%20cum%20gray_hair%20group%20long_hair%20nipples%20nude%20penis%20pussy%20rak_%28kuraga%29%20red_eyes%20twintails%20uncensored.jpg', 'https://konachan.com/image/e8ea71c93a895d87338ebf17e3aef5b3/Konachan.com%20-%20283268%20aliasing%20anthropomorphism%20azur_lane%20blush%20breasts%20gray_hair%20group%20long_hair%20nipples%20nude%20penis%20pussy%20rak_%28kuraga%29%20red_eyes%20sex%20twintails%20uncensored.jpg', 'https://konachan.com/image/8ffb6f968ffe372ea90a339934a9749d/Konachan.com%20-%20283267%20bed%20blush%20brown_eyes%20brown_hair%20condom%20inanaki_shiki%20long_hair%20navel%20no_bra%20open_shirt%20original%20panties%20tie%20underwear.jpg', 'https://konachan.com/jpeg/0d1de5c59eaf6fc717d63912e076de1d/Konachan.com%20-%20283266%20ass%20bed%20black_hair%20brown_eyes%20long_hair%20matsuzaki_miyuki%20original%20ponytail%20shorts.jpg', 'https://konachan.com/jpeg/7b34654c53e43879f20a8fd642c32acc/Konachan.com%20-%20283264%20aqua_eyes%20bed%20blonde_hair%20blush%20breasts%20censored%20dark_skin%20navel%20nipples%20no_bra%20original%20penis%20pubic_hair%20pussy%20sex%20shirt_lift%20spread_legs%20tan_lines.jpg', 'https://konachan.com/image/00a0eb43c07e9361679b5389e284ef7f/Konachan.com%20-%20283263%20ass%20ball%20brown_eyes%20cameltoe%20dress%20erect_nipples%20gray_hair%20kokkoro%20loli%20panties%20pizanuko%20pointed_ears%20princess_connect%21%20underwear%20upskirt%20wristwear.jpg', 'https://konachan.com/jpeg/889214118e9a891c63f0cb759d809775/Konachan.com%20-%20283262%202girls%20animal%20bow%20brown_eyes%20brown_hair%20clouds%20dress%20feathers%20flowers%20gloves%20green_eyes%20headdress%20idolmaster%20loli%20ribbons%20rose%20short_hair%20sky%20tiara.jpg', 'https://konachan.com/image/c7a3f7f9d6a2c1dc17c4c13733f72aed/Konachan.com%20-%20283261%20bikini_top%20black_hair%20blue_eyes%20boots%20chain%20flat_chest%20gloves%20hoodie%20inosia%20kuroi_mato%20long_hair%20magic%20navel%20scar%20shorts%20signed%20sword%20twintails%20weapon.jpg']
Path('konachan.txt').write_text('\n'.join(imgs))
wget -i konachan.txt
```
![image.png](https://upload-images.jianshu.io/upload_images/17817191-a0229a3f0c166a90.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 抓取 v2
```js
import time
import looter as lt
from pprint import pprint
from concurrent import futures

domain = 'https://www.v2ex.com'
total = []


def crawl(url):
    tree = lt.fetch(url)
    items = tree.css('#TopicsNode .cell')
    for item in items:
        data = {}
        data['title'] = item.css('span.item_title a::text').extract_first()
        data['author'] = item.css('span.small.fade strong a::text').extract_first()
        data['source'] = f"{domain}{item.css('span.item_title a::attr(href)').extract_first()}"
        reply = item.css('a.count_livid::text').extract_first()
        data['reply'] = int(reply) if reply else 0
        pprint(data)
        total.append(data)
    time.sleep(1)


if __name__ == '__main__':
    tasklist = [f'{domain}/go/python?p={n}' for n in range(1, 10)]
    [crawl(task) for task in tasklist]
    lt.save(total, name='v2ex.csv', sort_by='reply', order='desc')
```
抓取10页python主题的数据，按照回复数倒序排列
![image.png](https://upload-images.jianshu.io/upload_images/17817191-c05d10edeffae35e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/17817191-77c6224b3f5761c4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
```js
,author,reply,source,title
0,chinesehuazhou,127,https://www.v2ex.com/t/562327#reply127,10 行 Python 代码，批量压缩图片 500 张，简直太强大了（内有公号宣传，不喜勿进）
1,chinesehuazhou,103,https://www.v2ex.com/t/557286#reply103,len(x) 击败 x.len()，从内置函数看 Python 的设计思想（内有公号宣传，不喜勿进）
2,nfroot,73,https://www.v2ex.com/t/555249#reply73,面对 Python 的强大和难用性表示深深的迷茫，莫非打开方式不对？
3,css3,58,https://www.v2ex.com/t/554724#reply58,你们用什么工具来管理 Python 的库啊？
4,Northxw,54,https://www.v2ex.com/t/558529#reply54,花式反爬之某众点评网
5,akmonde,48,https://www.v2ex.com/t/559926#reply48,Python 项目移植到其他机器，要求全 Linux 系统适配
6,kayseen,47,https://www.v2ex.com/t/562683#reply47,这道 Python 题目有大神会做吗?
7,hellomacos,41,https://www.v2ex.com/t/562413#reply41,老生常谈的问题：如何学好 Python
```
公众号：苏生不惑
 ![扫描二维码关注](https://upload-images.jianshu.io/upload_images/17817191-6e0079f95d4c0338.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)