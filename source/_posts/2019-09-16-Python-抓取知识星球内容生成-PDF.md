---
title: Python 抓取知识星球内容生成 PDF
date: 2019-09-16 20:29:10
tags:
- 公众号
---
知识星球是什么?
> 知识星球是创作者连接铁杆粉丝，做出高品质社群，实现知识变现的工具。创作者可以用知识星球连接铁杆粉丝，做出高品质社群，实现知识变现。
知识星球解决的核心问题是社群收费管理难问题和内容不能沉淀问题。微信公众号、微博和行业专家——这些有粉丝的创作者是知识星球的核心用户，都可以用知识星球运营社群，知识变现。

以上来自知识星球官网的介绍 [https://help.zsxq.com/](https://help.zsxq.com/) 口号是连接1000位铁杆粉丝。
### 为什么用星球
我没做过社群，也不是什么行业专家，毕竟不是什么大v，为什么要用知识星球呢？主要是现在获取的资讯太多了，想沉淀记录些东西，方便自己，也方便他人找，为什么不用微博呢？微博用了很多年，每天都在更新，目前已经8万多条微博了。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-840f9df6851655c4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

微博上有很多mark党，不断转发微博，但几乎没再去看过，不知道你是否也这样，以为收藏就看过了，其实只是种心里安慰。

而且微博上转发的东西经常被删，微博太多管理起来也麻烦，于是6月份的时候建立了一个免费的星球，就是这个了https://wx.zsxq.com/dweb2/index/group/141281112142
![image.png](https://upload-images.jianshu.io/upload_images/17817191-935a32b13ae6980f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![免费星球](https://upload-images.jianshu.io/upload_images/17817191-393b26173c148690.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
星球还可以上传文件，和微博一样加标签方便分类，还提供网页版，比微信方便多了。


### 导出星球 
过去3个月更新几百条信息了，也都加好标签。现在有200多个小伙伴了，你有兴趣也加入吧。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-c78802c9c772446f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/17817191-0bc2f593ae8857eb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
比如工具这个标签列表的内容https://wx.zsxq.com/dweb2/index/tags/%E5%B7%A5%E5%85%B7/828821151512
![image.png](https://upload-images.jianshu.io/upload_images/17817191-2a3fe75088709eb8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



但内容多了以后翻起来也麻烦，于是想着下载下来看，最好能导出PDF，于是准备研究下，搜索下发现有人已经做过了 https://github.com/wbsabc/zsxq-spider https://github.com/96chh/crawl-zsxq
思路为抓取网页版的接口https://api.zsxq.com/v1.10/groups/141281112142/topics?scope=all&count=20 每次加载20条，每次的最后一条的create_time为下次的开始时间，如果没有20条说明加载完了。不过他的代码还有些问题，需要改动下，于是开始动手了。

```js
import re
import requests
import json
import os
import pdfkit
import shutil
import datetime
import urllib.request
from bs4 import BeautifulSoup
from urllib.parse import quote
from urllib.parse import unquote
import re,jieba,pandas as pd
import matplotlib.pyplot as plt
from wordcloud import WordCloud, STOPWORDS, ImageColorGenerator
import numpy as np
from pyquery import PyQuery
ZSXQ_ACCESS_TOKEN = '2B9BA4A2-8CAB-3A7C-32E7-' # 登录后Cookie中的Token
GROUP_ID = '142452821282'                                  # 知识星球中的小组ID 141281112142  每日分享554228114224
PDF_FILE_NAME = '知识星球_斜杠星球.pdf'                               # 生成PDF文件的名字
DOWLOAD_PICS = False                                        # 是否下载图片 True | False 下载会导致程序变慢
DOWLOAD_COMMENTS = False                                    # 是否下载评论
ONLY_DIGESTS = False                                       # True-只精华 | False-全部
FROM_DATE_TO_DATE = False                                  # 按时间区间下载
EARLY_DATE = '2017-05-25T00:00:00.000+0800'                # 最早时间 当FROM_DATE_TO_DATE=True时生效 为空表示不限制 形如'2017-05-25T00:00:00.000+0800'
LATE_DATE = '2019-09-25T00:00:00.000+0800'                 # 最晚时间 当FROM_DATE_TO_DATE=True时生效 为空表示不限制 形如'2017-05-25T00:00:00.000+0800'
DELETE_PICS_WHEN_DONE = True                               # 运行完毕后是否删除下载的图片
DELETE_HTML_WHEN_DONE = True                               # 运行完毕后是否删除生成的HTML
COUNTS_PER_TIME = 30                                       # 每次请求加载几个主题 最大可设置为30
DEBUG = False                                              # DEBUG开关
DEBUG_NUM = 120                                            # DEBUG时 跑多少条数据后停止 需与COUNTS_PER_TIME结合考虑

html_template = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
</head>
<body>
<h1>{title}</h1>
<br>{author} - {cretime}<br>
<p>{text}</p>
</body>
</html>
"""
htmls = []
num = 0
def headers_to_dict(headers):
    """
    将字符串
    '''
    Host: mp.weixin.qq.com
    Connection: keep-alive
    Cache-Control: max-age=
    '''
    转换成字典类型
    :param headers: str
    :return: dict
    """
    headers = headers.split("\n")
    d_headers = dict()
    for h in headers:
        h = h.strip()
        if h:
            k, v = h.split(":", 1)
            d_headers[k] = v.strip()
    return d_headers
def get_data(url):

    OVER_DATE_BREAK = False

    global htmls, num
        
   
    header = """
Accept:application/json, text/plain, */*
Accept-Encoding:gzip, deflate, br
Accept-Language:zh-CN
Connection:keep-alive
Cookie:sensorsdata2015jssdkcross=%7B%22dis ; zsxq_access_token=BA53 6025A
DNT:1
Host:api.zsxq.com
Origin:https://wx.zsxq.com
Referer:https://wx.zsxq.com/dweb2/index/group/224445125221
User-Agent:Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.79 Safari/537.36 Maxthon/5.2.7.5000
X-Request-Id:fcf935489-5997-674e-9db2-a02ea9b389f
X-Signature:81b69d88df26231776893554ec8d733448743908
X-Timestamp:1567682270
X-Version:1.10.17
    """
    headers = headers_to_dict(header)
    t = []
    
    rsp = requests.get(url, headers=headers)
    print(url,headers,rsp.json())
    """
    cat temp.json
    {
      "succeeded": true,
      "resp_data": {
        "topics": []
      }
    }
    cat temp.css
    h1 {font-size:40px; color:red; text-align:center;}
    p {font-size:30px;}
    img{
    	max-width:100%;
    	margin:20px auto;
    	height:auto;
    	border:0;
    	outline:0
    	-webkit-box-shadow: 1px 4px 16px 8px #5CA2BE;
        -moz-box-shadow: 1px 4px 16px 8px #5CA2BE;
        box-shadow: 1px 4px 16px 8px #5CA2BE;
        /*set the images aligned*/
        display: block;
        margin-left: auto;
        margin-right: auto;
    }
    """
    with open('temp.json', 'w', encoding='utf-8') as f: # 将返回数据写入temp.json方便查看
        f.write(json.dumps(rsp.json(), indent=2, ensure_ascii=False))
    
    with open('temp.json', encoding='utf-8') as f, open('contents2.txt', 'a+', encoding='utf-8') as f2:
        for topic in json.loads(f.read()).get('resp_data').get('topics'):
            if FROM_DATE_TO_DATE and EARLY_DATE.strip():
                if topic.get('create_time') < EARLY_DATE.strip():
                    OVER_DATE_BREAK = True
                    break

            content = topic.get('question', topic.get('talk', topic.get('task', topic.get('solution'))))

            anonymous = content.get('anonymous')
            if anonymous:
                author = '匿名用户'
            else:
                author = content.get('owner').get('name')

            cretime = (topic.get('create_time')[:23]).replace('T', ' ')

            text = content.get('text', '')
            f2.write(text)

            text = handle_link(text)
            #f2.write(PyQuery(text).text())
            t.append(text)
            title = str(num) + '_' + cretime[:16]
            num += 1
            if topic.get('digested') == True:
                title += '_精华'

            if DOWLOAD_PICS and content.get('images'):
                soup = BeautifulSoup(html_template, 'html.parser')
                images_index = 0
                for img in content.get('images'):
                    url = img.get('large').get('url')
                    local_url = './images/' + str(num - 1) + '_' + str(images_index) + '.jpg'
                    images_index += 1
                    urllib.request.urlretrieve(url, local_url)
                    img_tag = soup.new_tag('img', src=local_url)
                    soup.body.append(img_tag)
                html_img = str(soup)
                html = html_img.format(title=title, text=text, author=author, cretime=cretime)
            else:
                html = html_template.format(title=title, text=text, author=author, cretime=cretime)

            if topic.get('question'):
                answer_author = topic.get('answer').get('owner').get('name', '')
                answer = topic.get('answer').get('text', "")
                answer = handle_link(answer)

                soup = BeautifulSoup(html, 'html.parser')
                answer_tag = soup.new_tag('p')

                answer = '【' + answer_author + '】 回答：<br>' + answer
                soup_temp = BeautifulSoup(answer, 'html.parser')
                answer_tag.append(soup_temp)

                soup.body.append(answer_tag)
                html = str(soup) 
			
            files = content.get('files')
            if files:
                files_content = '<i>文件列表(需访问网站下载) :<br>'
                for f in files:
                    files_content += f.get('name') + '<br>'
                files_content += '</i>'
                soup = BeautifulSoup(html, 'html.parser')
                files_tag = soup.new_tag('p')
                soup_temp = BeautifulSoup(files_content, 'html.parser')
                files_tag.append(soup_temp)
                soup.body.append(files_tag)
                html = str(soup)

            comments = topic.get('show_comments')
            if DOWLOAD_COMMENTS and comments:
                soup = BeautifulSoup(html, 'html.parser')
                hr_tag = soup.new_tag('hr')
                soup.body.append(hr_tag)
                for comment in comments:
                    comment_str = ''
                    if comment.get('repliee'):
                        comment_str = '[' + comment.get('owner').get('name') + ' 回复 ' + comment.get('repliee').get('name') + '] : ' + handle_link(comment.get('text'))
                    else:
                        comment_str = '[' + comment.get('owner').get('name') + '] : ' + handle_link(comment.get('text'))

                    comment_tag = soup.new_tag('p')
                    soup_temp = BeautifulSoup(comment_str, 'html.parser')
                    comment_tag.append(soup_temp)
                    soup.body.append(comment_tag)
                html = str(soup)

            htmls.append(html)

    # DEBUG 仅导出部分数据时使用
    if DEBUG and num >= DEBUG_NUM:
       return htmls

    if OVER_DATE_BREAK:
        return htmls

    next_page = rsp.json().get('resp_data').get('topics')
    if next_page:
        create_time = next_page[-1].get('create_time')
        if create_time[20:23] == "000":
            end_time = create_time[:20]+"999"+create_time[23:]
            str_date_time = end_time[:19]
            delta = datetime.timedelta(seconds=1)
            date_time = datetime.datetime.strptime(str_date_time, '%Y-%m-%dT%H:%M:%S')
            date_time = date_time - delta
            str_date_time = date_time.strftime('%Y-%m-%dT%H:%M:%S')
            end_time = str_date_time + end_time[19:]
        else :
            res = int(create_time[20:23])-1
            end_time = create_time[:20]+str(res).zfill(3)+create_time[23:] # zfill 函数补足结果前面的零，始终为3位数
        end_time = quote(end_time)
        if len(end_time) == 33:
            end_time = end_time[:24] + '0' + end_time[24:]
        next_url = start_url + '&end_time=' + end_time
        print(next_url)
        get_data(next_url)

    return htmls,t

def handle_link(text):
    soup = BeautifulSoup(text, "html.parser")

    mention = soup.find_all('e', attrs={'type' : 'mention'})
    if len(mention):
        for m in mention:
            mention_name = m.attrs['title']
            new_tag = soup.new_tag('span')
            new_tag.string = mention_name
            m.replace_with(new_tag)

    hashtag = soup.find_all('e', attrs={'type' : 'hashtag'})
    if len(hashtag):
        for tag in hashtag:
            tag_name = unquote(tag.attrs['title'])
            new_tag = soup.new_tag('span')
            new_tag.string = tag_name
            tag.replace_with(new_tag)

    links = soup.find_all('e', attrs={'type' : 'web'})
    if len(links):
        for link in links:
            title = unquote(link.attrs['title'])
            href = unquote(link.attrs['href'])
            new_a_tag = soup.new_tag('a', href=href)
            new_a_tag.string = title
            link.replace_with(new_a_tag)

    text = str(soup)
    text = re.sub(r'<e[^>]*>', '', text).strip()
    text = text.replace('\n', '<br>')
    return text

def make_pdf(htmls):
    html_files = []
    for index, html in enumerate(htmls):
        file = str(index) + ".html"
        html_files.append(file)
        with open(file, "w", encoding="utf-8") as f:
            f.write(html)

    options = {
        "user-style-sheet": "temp.css",
        "page-size": "Letter",
        "margin-top": "0.75in",
        "margin-right": "0.75in",
        "margin-bottom": "0.75in",
        "margin-left": "0.75in",
        "encoding": "UTF-8",
        "custom-header": [("Accept-Encoding", "gzip")],
        "cookie": [
            ("cookie-name1", "cookie-value1"), ("cookie-name2", "cookie-value2")
        ],
        "outline-depth": 10,
    }
    try:
        pdfkit.from_file(html_files, PDF_FILE_NAME, options=options)
    except Exception as e:
        pass

    if DELETE_HTML_WHEN_DONE:
        for file in html_files:
            os.remove(file)

    print("电子书生成成功！")
def wordimage(content):
    comments = ''
    for k in range(len(content)):
        comments = comments + (str(content[k])).strip()
    doc = PyQuery(comments)
    #使用正则表达式去除标点符号
    #pattern = re.compile(r'[\u4e00-\u9fa5]+')
    #filterdata = re.findall(pattern, comments)
    #cleaned_comments = ''.join(filterdata)
    cleaned_comments = ''.join(jieba.cut(doc.text()))
    print(cleaned_comments)
    #使用结巴分词进行中文分词
    segment = jieba.lcut(cleaned_comments)
    words_df=pd.DataFrame({'segment':segment})
    #去掉停用词，先下载https://github.com/wendy1990/short_text_classification/blob/master/conf/stopwords.txt
    stopwords=pd.read_csv("stopwords.txt",index_col=False,quoting=3,sep="\t",names=['stopword'], encoding='utf-8')#quoting=3全不引用words_df=words_df[~words_df.segment.isin(stopwords.stopword)]
    #统计词频 看看哪些词出现概率高
    words_stat=words_df.groupby(by=['segment'])['segment'].agg({"计数":np.size})
    words_stat=words_stat.reset_index().sort_values(by=["计数"],ascending=False)
    #print(words_stat.head(1000).values)
    stopwords = set(STOPWORDS)
    #用词云进行显示
    wordcloud=WordCloud(font_path="c:\windos\fonts\simhei.ttf",background_color="white",max_font_size=80,stopwords=STOPWORDS.add("said")).generate(cleaned_comments)
    #word_frequence = {x[0]:x[1] for x in words_stat.head(1000).values}
    #word_frequence_list = []
    #for key in word_frequence:
    #    temp = (key,word_frequence[key])
    #    word_frequence_list.append(temp)
    #wordcloud=wordcloud.fit_words(word_frequence_list)
    #plt.imshow(wordcloud)
    #plt.show()
    plt.imshow(wordcloud, interpolation="bilinear")
    plt.axis("off")
    plt.show()
    wordcloud.to_file('zsxq_tool.jpg')
if __name__ == '__main__':
    images_path = r'./images'
    if DOWLOAD_PICS:
        if os.path.exists(images_path):
            shutil.rmtree(images_path)
        os.mkdir(images_path)

    # 仅精华
    #start_url = 'https://api.zsxq.com/v1.10/groups/481818518558/topics?scope=digests&count=30'
    # 全部
    #start_url = 'https://api.zsxq.com/v1.10/groups/481818518558/topics?count=30'
    start_url = ''
    if ONLY_DIGESTS:
        start_url = 'https://api.zsxq.com/v1.10/groups/' + GROUP_ID + '/topics?scope=digests&count=' + str(COUNTS_PER_TIME)
    else:
        start_url = 'https://api.zsxq.com/v1.10/groups/' + GROUP_ID + '/topics?scope=all&count=' + str(COUNTS_PER_TIME)

    url = start_url
    if FROM_DATE_TO_DATE and LATE_DATE.strip():
        url = start_url + '&end_time=' + quote(LATE_DATE.strip())
    data = get_data(url)
    #print(data[1])
    #wordimage(data[1])
    #make_pdf(data[0])

    if DOWLOAD_PICS and DELETE_PICS_WHEN_DONE:
        shutil.rmtree(images_path) 


```
执行效果见图
![image.png](https://upload-images.jianshu.io/upload_images/17817191-07b0a8ce1442ea8a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
生成的PDF文件有点大，565页 ，50多M，主要是评论和图片都下载了，不下载的话5M差不多。

![image.png](https://upload-images.jianshu.io/upload_images/17817191-87020a336d8967cf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


为了验证付费星球也能下载，我还建了个付费星球https://wx.zsxq.com/dweb2/index/group/224445125221，以后也会经常更新。
 ![image.png](https://upload-images.jianshu.io/upload_images/17817191-5f36737e35dbbff9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/17817191-aeca99f305f23d61.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

评论和回复也下载了
![image.png](https://upload-images.jianshu.io/upload_images/17817191-dc036a80532a5ce1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/17817191-70a44013887caa7d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

2019.6.19创建的星球
![image.png](https://upload-images.jianshu.io/upload_images/17817191-1818e57b45d5027b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
Python生成的词云效果不大好，还没过滤好无用的词。

![image.png](https://upload-images.jianshu.io/upload_images/17817191-1a497d8234026372.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

文字版也导出到TXT了。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-a86943499b797fd1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

在词云网站 http://cloud.niucodata.com/  将下载的文字放进去就能看到词频统计和词云图。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-aace6c380516b87f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/17817191-ec6b0234c3353915.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

如果你想看下载这个PDF，公众号回复 `星球` 获取PDF和文字版。
https://pan.baidu.com/s/1pJ-nLiLLMlK08_vwoE0ZuA
https://pan.baidu.com/s/1TcYpM4x5td2GLjkltHJhBQ

### wkhtmltopdf
使用过程中发现wkhtmltopdf这个工具很好用 https://wkhtmltopdf.org/ 这个软件很方便在命令行生成图片和PDF，
执行 `wkhtmltoimage www.qq.com qq.png`，就会在当前目录下生成了一张png图片。
```js
$ wkhtmltoimage www.qq.com qq.png
Loading page (1/2)
QFont::setPixelSize: Pixel size <= 0 (0)                     ] 44%
libpng warning: iCCP: known incorrect sRGB profile           ] 64%
Rendering (2/2)
Done

 $ wkhtmltopdf www.qq.com qq.pdf
Loading pages (1/6)
QFont::setPixelSize: Pixel size <= 0 (0)                     ] 44%
libpng warning: iCCP: known incorrect sRGB profile===>       ] 87%
Counting pages (2/6)
QFont::setPixelSize: Pixel size <= 0 (0)=====================] Object 1 of 1
Resolving links (4/6)
Loading headers and footers (5/6)
Printing pages (6/6)
Done
Warning: Received createRequest signal on a disposed ResourceObject's NetworkAccessManager. This might be an indication of an iframe taking too long to load.
Warning: Received createRequest signal on a disposed ResourceObject's NetworkAccessManager. This might be an indication of an iframe taking too long to load.

```
![image.png](https://upload-images.jianshu.io/upload_images/17817191-b20148873f1dc5a0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这个命令还可以增加一些参数，比如常用的设置宽高，图片质量等参数
执行`wkhtmltoimage --crop-w 410 --width 410 --quality 50 www.bing.com bing2.png`看看
```js
--crop-w 410：截图宽度410px

--width 410：浏览器模拟宽度410px

--quality 50：图片质量(这个值越大，图片质量越高，当然文件也会比较大)

还有更多参数用法，请 wkhtmltoimage -h查看。
HTML转pdf同理，wkhtmltopdf -h
wkhtmltopdf -v
--collate             当输出多个副本时进行校验（这是默认设置）
    --no-collate          当输出多个副本时不进行校验
    --cookie-jar <path>   从提供的 JAR 文件中读写 cookie 数据
    --copies <number>     设置输出副本的数量（默认主 1)，其实为 1 就够了
-d, --dpi <dpi>           指定一个要分辨率（这在 X11 系统中并没有什么卵用）
-H, --extended-help       相对 -h 参数，显示更详细的说明文档
-g, --grayscale           指定以灰度图生成 PDF 文档。占用的空间更小
-h, --help                显示帮助信息
    --htmldoc             输出程序的 html 帮助文档
    --image-dpi <integer> 当页面中有内嵌的图片时，
                          会下载此命令行参数指定尺寸的图片（默认值是 600)
    --image-quality <interger> 当使用 jpeg 算法压缩图片时使用这个参数指定的质量（默认为 94)
    --license             输出授权信息并退出
-l, --lowquality          生成低质量的 PDF/PS , 能够很好的节约最终生成文档所占存储空间
    --manpage             输出程序的手册页
-B, --margin-bottom <unitreal> 设置页面的 底边距
-L, --margin-left <unitreal>   设置页面的 左边距 （默认是 10mm)
-R, --margin-right <unitreal>  设置页面的 右边距 （默认是 10mm)
-T, --margin-top <unitreal>    设置页面的 上边距
-O, --orientation <orientation> 设置为“风景 (Landscape)”或“肖像 (Portrait)”模式，
                                默认是肖像模块 (Portrait)
    --page-height <unitreal>   页面高度
-s, --page-size <Size>         设置页面的尺寸，如：A4,Letter 等，默认是：A4
    --page-width <unitreal>    页面宽度
    --no-pdf-compression       不对 PDF 对象使用丢失少量信息的压缩算法，不建议使用些参数，
                               因为生成的 PDF 文件会非常大。
-q, --quiet                    静态模式，不在标准输出中打印任何信息
    --read-args-from-stdin     从标准输入中读取命令行参数，后续会有针对此指令的详细介绍，
                               请参见 **从标准输入获取参数**
    --readme                   输出程序的 readme 文档
    --title <text>             生成的 PDF 文档的标题，如果不指定则使用第一个文档的标题
-V, --version                  输出版本信息后退出
```
wkhtmltopdf "/home/wang/test.html" /home/wang/test.pdf

wkhtmltopdf "https://www.jd.com" /home/wang/jj.pdf

### 中文乱码
如果你是在 linux 上执行脚本可能会出现中文乱码，解决方法就是从windows拷贝宋体字体文件 ` c:\windos\fonts\simhei.ttf`到`/usr/share/fonts/`下
```js
cd /usr/share/fonts/
cp simhei.ttf .
mkfontscale
mkfontdir
fc-cache 
```
再次执行fc-list可以看到已经安装的字体了。

 ### phantomjs
除了wkhtmltopdf生成PDF还有phantomjs 的功能也很强大，做爬虫应用，抓取网页数据、网页截屏、页面访问自动化等。
```js
set_time_limit(0);
$path = '/bin/phantomjs';		//phantomjs路径
//$jsPath = '/home/test/phantomjs/examples/test.js';	
$url = 'https://baidu.com/';		//要抓取的网页
$out = 'baidu.png';			//图片保存路径
$cmd = "$path --output-encoding=utf-8 $jsPath $url $out";
echo $cmd;
system($cmd);

创建test.js
```js
var page = require('webpage').create();
var args = require('system').args;
var url = args[1];
var filename = args[2];
page.open(url, function () {
    page.render(filename);
    phantom.exit();
});
```
执行 /home/test/phantomjs/bin/phantomjs  test.js   http://www.baidu.com   baidu.png
  
###  puppeteer
puppeteer 是 chrome 提供的一个无头浏览器，它是替代 phantomjs 的一个替代品，多用于实现自动化测试。官方仓库地址：https://github.com/GoogleChrome/puppeteer,Puppeteer 能用来干啥，有哪些功能：
生成页面的截图和 PDF
爬取网站内容
模拟登陆、自动提交表单，UI 测试，键盘输入等
使用最新的 JavaScript 和浏览器功能，直接在最新版本的 Chrome 中运行测试。
捕获网站的时间线跟踪，以帮助诊断性能问题
测试 Chrome 扩展
screenshoteer是基于Puppeteer 的命令行工具
```js
npm i -g screenshoteer
screenshoteer --url https://nicelinks.site/
λ screenshoteer --url http://qq.com
http://qq.com
true
腾讯首页
```
 ### pdfkit
这是个Python生成PDF的库 
```js
>>> import pdfkit
>>> config = pdfkit.configuration(wkhtmltopdf=r'd:\wkhtmltopdf\bin\wkhtmltopdf.exe')
>>> pdfkit.from_url('https://sogou.com', 'sogou.pdf', configuration=config)
Loading pages (1/6)
Counting pages (2/6)
Resolving links (4/6)
Loading headers and footers (5/6)
Printing pages (6/6)
Done
True
```
也可以将本地文件生成PDF
 pdfkit.from_file('test.html', r'D:\test' + id + '.pdf', configuration=config)
### popple
pdf软件 poppler  https://github.com/freedesktop/poppler
```js

$ pdfinfo   知识星球_苏生不惑.pdf
Title:
Creator:        wkhtmltopdf 0.12.5
Producer:       Qt 4.8.7
CreationDate:   09/04/19 21:02:59 
Tagged:         no
UserProperties: no
Suspects:       no
Form:           none
JavaScript:     no
Pages:          565
Encrypted:      no
Page size:      612 x 792 pts (letter)
Page rot:       0
File size:      0 bytes
Optimized:      no
PDF version:    1.4

 
λ pdf
pdfdetach.exe    pdfimages.exe    pdfseparate.exe  pdftohtml.exe    pdftops.exe      pdfunite.exe
pdffonts.exe     pdfinfo.exe      pdftocairo.exe   pdftoppm.exe     pdftotext.exe
```
### 资源
pdf合并工具pdftk https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/ 
  [初识wkhtmltopdf](https://segmentfault.com/a/1190000018765575)
中文字体https://github.com/sonatype/maven-guide-zh/raw/master/content-zh/src/main/resources/fonts/simsun.ttc
http://einverne.github.io/post/2019/01/html-to-pdf.html
[ Web 屏幕截图工具](https://hacpai.com/article/1544237764458)
使用 Laravel-snappy 生成 PDF 踩坑记录https://learnku.com/articles/25922
 https://github.com/Kozea/WeasyPrint
基于前端技术生成PDF方案https://juejin.im/post/5d036a78f265da1bce3dcd40 
 [HTML转成PDF的4个方案及实现](https://segmentfault.com/a/1190000018701596)
js导出图片与pdf的方案https://www.jianshu.com/p/408748cfa76e
 [HTML 转换 PDF 解决方案](https://brianshen1990.github.io/HTML_To_PDF_Solutions.html "Permalink to HTML To PDF Solutions / HTML 转换 PDF 解决方案")
抓取网页生成 PDF http://jartto.wang/2018/10/13/nodejs-pdf/
### 星球导航网站

https://tooltowin.com/zsxq/1124/
https://www.101ker.com/p/2284 
 https://xiaogenhua.com/2019/05/20/caozsay/ 
https://www.kindkp.com/ 


### 推荐星球 
这段时间也加入了不少星球，推荐一个我几乎每天看的星球，为什么每天看呢，因为星主每天分享，太勤快了，星球名叫 `风巢套利日享（限免）`，免费的https://wx.zsxq.com/dweb2/index/group/554228114224
这是这个星球的词云，看到这些关键词，你心动了吗？点击阅读原文或扫码加入星球。
![image.png](https://upload-images.jianshu.io/upload_images/17817191-2211005aef836d43.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/17817191-5d2c9bc76a82c136.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

路人甲
![image.png](https://upload-images.jianshu.io/upload_images/17817191-410eb89d1155c975.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
不安分的
![image.png](https://upload-images.jianshu.io/upload_images/17817191-2b1906c35e8a37da.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
大门口
![image.png](https://upload-images.jianshu.io/upload_images/17817191-5bd614a2d0559d20.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

最后如果你也想导出哪个星球，拉我进去帮你导出来。

推荐阅读:

[没有提取码怎么获取百度网盘资源？](https://mp.weixin.qq.com/s/MUIPj4OgSxAeRl5Hk-2tuw)

[如何发一条空白的朋友圈](https://mp.weixin.qq.com/s/Xz1m-mqtCcBF_4hmGCpkUQ)

[如何在电脑上登陆多个微信](https://mp.weixin.qq.com/s/_3AeNahwbs8c3UJ0is1t4A)

[如何提取公积金 9 天到账](https://mp.weixin.qq.com/s/qyFvOgHf1mXwPKO0tQwUyg)

[免费在线听周杰伦歌曲](https://mp.weixin.qq.com/s/1omFkK5PPyeJEzUTagj9qg)

[那些你可能不知道的微信奇技淫巧](https://mp.weixin.qq.com/s/eGDO0Y8el_dsEyriCoAgog)

[如何在豆瓣租房小组快速找到满意的房子](https://mp.weixin.qq.com/s/k5lBwiDzGgSU3fh2v2Rw9A)

[那些你可能用得上的简历写作工具](https://mp.weixin.qq.com/s/sng3uK9Nge1OD2gc5DDuZg)

[Chrome 浏览器扩展神器油猴](https://mp.weixin.qq.com/s/adJFh_9LH0N-vvvYaiQqXg)

[我的新浪工作日常](https://mp.weixin.qq.com/s/mI5kubVY2t5jwJ9ub7A1iA)

### 公众号：苏生不惑
 ![扫描二维码关注](https://upload-images.jianshu.io/upload_images/17817191-6e0079f95d4c0338.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
