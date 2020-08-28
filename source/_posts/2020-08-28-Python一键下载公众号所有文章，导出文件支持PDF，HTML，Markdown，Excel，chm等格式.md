---
title: Python一键下载公众号所有文章，导出文件支持PDF，HTML，Markdown，Excel，chm等格式
date: 2020-08-28 19:44:20
tags:
- 公众号
- python
---
> 苏生不惑第167 篇原创文章，将本公众号设为`星标`，第一时间看最新文章。

关于备份之前写过以下文章：

[再谈备份微博](https://mp.weixin.qq.com/s/AUS5oCukv8hIFZIjO2Drjg)

[一键备份微博并导出生成PDF，顺便用Python分析微博账号数据](https://mp.weixin.qq.com/s/PlkPDmK2SUdQT59CzOJFMA)

[再谈备份网页和公众号文章](https://mp.weixin.qq.com/s/BddM3RzStg0Qos9cSrQXIw)

[如何备份可能被删的公众号文章和网页](https://mp.weixin.qq.com/s/bIE23HBq_sqvLkV18_BlbQ)

[想看的公众号文章被删了怎么办？](https://mp.weixin.qq.com/s/l2bQJk1qjb6IzroODBpoOg)

上面写的备份公众号方法都是单篇备份，如果你想备份某个公众号的所有文章，就有点太麻烦了，所以今天分享的是用Python一键备份某个公众号的所有文章，这里就以我自己的`公众号苏生不惑`为例了，原理就是通过抓包抓取微信客户端的接口，用Python请求微信接口获取公众号文章链接再下载。

### charles 抓包
常见的抓包工具有Fiddler，charles，这里用的charles，先去官网 https://www.charlesproxy.com/download 下载软件,然后打开微信客户端找到公众号，进入文章列表可以看到发过的文章。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-91217817ab889f5d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

不过charles没安装证书前获取不到https接口数据，显示unknown。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-d6323050d5a76412.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
安装证书后在 proxy->ssl proxying settings 添加域名和host 。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-f12ade2adea0aaf2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
再次抓取可以看到公众号文章接口数据了。

![image.png](https://upload-images.jianshu.io/upload_images/23152173-bc7af8b0553b9c8d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
公众号文章的接口地址 https://mp.weixin.qq.com/mp/profile_ext?action=getmsg&__biz=MjM5ODIzNDEx&f=json&offset=25&count=10&is_ok=1&scene=124&uin=MTU0MTQzNj&key=f57423 ，参数比较多，其中有用的参数 __biz 是用户和公众号之间的唯一id，uin是用户的id，这个是不变的，key 是请求的秘钥，一段时间就会失效，offset 是偏移量，count 是每次请求的条数，返回值结构如下：
```js
{
	"ret": 0,
	"errmsg": "ok",
	"msg_count": 10,信息条数
	"can_msg_continue": 1,是否还可以继续获取，1代表可以。0代表不可以，也就是最后一页
	"general_msg_list": "{\"list\":[{\"comm_msg_info\":{\"id\":1000000182,\"type\":49,\"datetime\":1585702800,\"fakeid\":\"2398234112\",\"status\":2,\"content\":\"\"},\"app_msg_ext_info\":{\"title\":\"张国荣音乐\/演唱会\/电影全集网盘分享\",\"digest\":\"#17宠爱张国荣#\",\"content\":\"\",\"fileid\":0,\"content_url\":\"http:\/\/mp.weixin.qq.com\/s?__biz=MjM5ODIzNDExMg==&amp;mid=2257484715&amp;idx=1&amp;sn=2fab0a11d62090d5e30e03e334bce636&amp;chksm=a5b70ac492c083d275b6e15f0de85b8baf488ebb76e5429b08f40cdc53ab6e27b0ce5474fb30&amp;scene=27#wechat_redirect\",\"source_url\":\"\",\"cover\":\"http:\/\/mmbiz.qpic.cn\/mmbiz_jpg\/pchiblEh3tErdgYu06FFVuvnKr9aAkddJLB7pgNhaiav0aYGQKJI0Dwn0kpT4wnmQkIglGH1Nciam5IThX19ibyEag\/0?wx_fmt=jpeg\",\"subtype\":9,\"is_multi\":0,\"multi_app_msg_item_list\":[],\"author\":\"苏生\",\"copyright_stat\":100,\"duration\":0,\"del_flag\":1,\"item_show_type\":0,\"audio_fileid\":0,\"play_url\":\"\",\"malicious_title_reason_id\":0,\"malicious_content_type\":0}}]}", 
	"next_offset": 37,
	"video_count": 1,
	"use_video_tab": 1,
	"real_type": 0,
	"home_page_list": []
}
```
可以看到返回数据包括文章标题titile、摘要digest、文章地址content_url、阅读原文地址source_url、封面图cover、作者author ，只要抓取这些有用的数据就行了。
### python 抓取公众号文章
上面分析了接口参数和返回数据，开始用Python请求微信接口就是了。

```js
import requests,pdfkit,json,time,datetime,os
biz = 'MzU1OTgyMzQzNw=='#随公众号改变
uin = 'NjQ3OTQwMT'#不变
key = '54ce6b15dc70fa9428deb6f18a00ac92db141f743dfe6d5a800bf2e99d82c2c372af771b204ec1db1f6f769ab66ad7c0294db04862aecbd043c24ab4be675cf55bcb2316b384f5612fb8a73daee911389bf94d6ed0fae9285e5996b831da8ea9f1af341f0314a937fd4c840edc1986fc74961857388588e83567137c42993a80'
def parse(offset, biz, uin, key):
    # url前缀
    url = "https://mp.weixin.qq.com/mp/profile_ext"
    # 请求头
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36 QBCore/4.0.1301.400 QQBrowser/9.0.2524.400 Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2875.116 Safari/537.36 NetType/WIFI MicroMessenger/7.0.5 WindowsWechat"
    }
    proxies = {
        'https': None,
        'http': None,
    }
    # 重要参数https://mp.weixin.qq.com/mp/profile_ext?action=getmsg&__biz=MjM5ODIzNDExMg==&f=json&offset=48&count=10&is_ok=1&scene=124&uin=MTU0MTQzNjQwMw%3D%3D&key=a42654d5f06828b5d9e40deca0ea5f73004fecbf9ae4cfe0d37653465b623e26d82d0948a73d3cdf4fffd5df19bebafed06815f22f05bac0e5679625c86bb429885529cea1973bfb4d9f18481e624a0cea7cd12932fb55e7ed892ccd6dcda141737cf5ed9811d477cd90cdf4d8371a8b1bdd63de15e193787fc75f186cdf41b5&pass_ticket=FjDlSKDCqgdl0E5WNMPJLuBO3eeqP%2FdrlM1Q8%2FzEHxisVbm7ZVemLp6VeXsrLd0i&wxtoken=&appmsg_token=1074_NFjOFA%252FiWPMoGcRLiG7SzMUc-NoJp7QhKSYmYw~~&x5=0&f=json
    param = {
        'action': 'getmsg',
        '__biz': biz,
        'f': 'json',
        'offset': offset,
        'count': '10',
        'is_ok': '1',
        'scene': '124',
        'uin': uin,
        'key': key,
        'wxtoken': '',
        'x5': '0',
    }
    # 发送请求，获取响应
    response = requests.get(url, headers=headers, params=param, proxies=proxies)
    response_dict = response.json()
    print(response_dict)
    next_offset = response_dict['next_offset']
    can_msg_continue = response_dict['can_msg_continue']
    general_msg_list = response_dict['general_msg_list']
    data_list = json.loads(general_msg_list)['list']
    htmls = []
    # print(data_list)
    for data in data_list:
        try:
            # 文章发布时间
            date = time.strftime('%Y-%m-%d', time.localtime(data['comm_msg_info']['datetime']))
            msg_info = data['app_msg_ext_info']
            #原创
            if msg_info['copyright_stat'] == 11:
                # 文章标题
                title = msg_info['title']
                # 文章链接
                url = msg_info['content_url']
                #文章摘要digest
                #文章封面cover

                res = requests.get(url,proxies={'http': None,'https': None},verify=False, headers=headers)
                content = res.text.replace('data-src', 'src')
                filename=str(int(time.time()))+'.html'
                #生成HTML文件
                #htmls.append(filename)
                with open(date+'_'+title+'.html', 'w', encoding='utf-8') as f:
                    f.write(content)
                #生成Excel
                #with open('wechat2.csv', 'a+', encoding='gbk') as f:
                #    f.write(title.replace(',', '，')+','+msg_info['digest'].replace(',', '，')+',' + msg_info['cover'].replace(',', '，') + ',' +url.replace(',', '，')+','+str(date)+ '\n')
                #生成markdown
                #with open('wechat.md', 'a+', encoding='utf-8') as f:
                #    f.write('[{}]'.format(title) + '({})'.format(url)+ '\n')
                #生成PDF
                #try:
                #    pdfkit.from_string(content,'./' + date + '_' + title.replace(' ', '')+'.pdf')
                #except Exception as err:
                #    print(err)
                # 部分文章标题含特殊字符，不能作为文件名
                    #f = datetime.datetime.now().strftime('%Y%m%d%H%M%S') + '.pdf'
                    #pdfkit.from_string(content,f)
                    # 自己定义存储路径（绝对路径）
                #finally:
                #    os.remove(filename)
                #pdfkit.from_url(url, './' + date + title + '.pdf') #图片获取不到
                print(url + title + date + '成功')
        except Exception as err:
            print(err)
    #try:
        #pdfkit.from_file(htmls,'公众号文章备份.pdf')
    #except:
    #    pass
    if can_msg_continue == 1:
        time.sleep(1)
        parse(next_offset,biz,uin,key)
        return True
    else:
        print('爬取完毕')
        return False

parse(0,biz,uin,key)
```
![image.png](https://upload-images.jianshu.io/upload_images/23152173-834294997521f48b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这里只抓取原创文章，我的公众号有160多篇原创，生成HTML文件2分钟就搞定。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-f3e04f4805eba9df.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
用谷歌浏览器打开就能看。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-54e029f1ac7012e3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

生成的HTML文件还可以转成chm格式，需要先安装软件 Easy CHM，这是一款强大的CHM电子书或CHM帮助文件的快速制作工具 http://www.etextwizard.com/cn/easychm.html 
![image.png](https://upload-images.jianshu.io/upload_images/23152173-6cdab3313db44bdb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
左侧是文章标题，右侧是文章内容，看起来非常方便。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-2fac2bea9b8e365e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
然后编译成一个chm文件，这样直接双击文件就能打开浏览了。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-0b0b6f20624f493a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![image.png](https://upload-images.jianshu.io/upload_images/23152173-805d067031574009.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


还有含有文章标题和链接的 markdown  文件，关于markdown之前文章介绍过 [用 Markdown 来写简历和 PPT](https://mp.weixin.qq.com/s/K5-1y2RRcgAu9sRsxKfZpQ)。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-151a8b5944557392.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240) 
excel文件格式也有。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-5b734bbb2713b8a6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

生成HTML，markdown和Excel都比较快，因为都是文本，下面开始导出PDF。
### 导出PDF 
导出PDF用的工具是wkhtmltopdf  ，先到官网https://wkhtmltopdf.org/downloads.html  下载安装 wkhtmltopdf ， 安装后设置环境变量，之前文章写过 [那些你可能不知道的 windows 奇技淫巧](https://mp.weixin.qq.com/s/y7Xo1BtiGwuij9-ILRWxZg)，然后直接命令行就能生成PDF。
```js
λ wkhtmltopdf http://www.baidu.com baidu.pdf
Loading pages (1/6)
Counting pages (2/6)
Resolving links (4/6)
Loading headers and footers (5/6)
Printing pages (6/6)
Done
```
比如生成百度首页的PDF。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-91e5fef1f6c2e0a4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
Python中使用pdfkit 模块来调用wkhtmltopdf ，先用`pip install pdfkit -i http://pypi.douban.com/simple --trusted-host pypi.douban.com `来安装它。

再次运行程序，PDF文件也生成了。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-cf04c0093d228441.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
PDF也可以用谷歌浏览器打开，比如这篇[一键解锁网易云音乐变灰歌曲](https://mp.weixin.qq.com/s/BSfjFnv54EAHmc6eE75T9g)。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-8972ab3cade2c4ab.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

不过由于生成PDF比较慢，文章多的话key参数会失效，需要重新获取，然后修改next_offset继续抓取。
`{'base_resp': {'ret': -3, 'errmsg': 'no session', 'cookie_count': 0, 'csp_nonce': 406210942}, 'ret': -3, 'errmsg': 'no session', 'cookie_count': 0}`
![image.png](https://upload-images.jianshu.io/upload_images/23152173-6a7bef5d7bd73ffe.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这样就完美的把我公众号的所有文章下载到本地了，有HTML，PDF，Excel，markdown，chm 格式（在公众号后台回复 `公众号` 获取我的所有原创文章，如果你有想下载的公众号可以加我微信免费帮忙下载）。
![风.png](https://upload-images.jianshu.io/upload_images/23152173-fe2c352b8ee985cf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

目前有个问题是如果公众号有付费文章，下载的也只能看一部分内容。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-5f060dc53c637f43.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

还有文章的评论也是有接口获取的，有空再研究下。
![image.png](https://upload-images.jianshu.io/upload_images/23152173-5633948d4f0ecb4a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


> 大家的点赞和在看转发对我非常重要，如果文章对你有帮助还请支持下， 感谢各位！

| 公众号后台回复关键词    |  用途   |
| --- | --- |
| 微信    | 获取你的微信好友头像拼图及查看微信撤回消息    |
|  b站   |  获取下载b站视频工具及找回被删b站视频方法   |
|  视频   |  获取下载腾讯，优酷，爱奇艺，微博视频工具及去除logo脚本   |
|  百度网盘   | 获取加速下载网盘文件方法及查找电影电视剧网站    |
|   朋友圈  |  获取发空白朋友圈方法   |
|  微博   |  获取备份微博工具及分析微博账号数据   |
|  音乐   |   获取下载音乐工具及在线听歌网站  |
|  油猴   |   获取油猴脚本  |
|谷歌|获取安装Chrome扩展方法|
|公众号|一键下载公众号所有文章|

![免费知识星球，每天更新](https://upload-images.jianshu.io/upload_images/17817191-9d41aa25edcd25c4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 公众号 苏生不惑
 ![扫描二维码关注或搜索微信susheng_buhuo](https://upload-images.jianshu.io/upload_images/17817191-6e0079f95d4c0338.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)