---
title: Python 文档生成器 mkdocs
date: 2019-06-21 21:18:23
tags:
---
mkdocs 是一个基于Python 对 Markdown 非常友好的文档生成器，[中文文档地址](https://markdown-docs-zh.readthedocs.io/zh_CN/latest/)

使用 mkdocs 我们可以用 md 编写自己的文档，而且可以免费部署到 GitHub 。
### 安装
pip install mkdocs

### 新建文档

```js
λ mkdocs.exe new mydoc
INFO    -  Creating project directory: mydoc
INFO    -  Writing config file: mydoc\mkdocs.yml
INFO    -  Writing initial docs: mydoc\docs\index.md
λ cd mydoc\

d:\code\mydoc
λ ls
docs/  mkdocs.yml

d:\code\mydoc
λ mkdocs serve
INFO    -  Building documentation...
INFO    -  Cleaning site directory
[I 190528 20:32:49 server:296] Serving on http://127.0.0.1:8000
[I 190528 20:32:49 handlers:62] Start watching changes
[I 190528 20:32:49 handlers:64] Start detecting changes
[I 190528 20:33:06 handlers:135] Browser Connected: http://127.0.0.1:8000/
```


![image.png](https://upload-images.jianshu.io/upload_images/17817191-019df8f12e96ddfc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### 编辑文档
`vi docs/index.md`
把 command 改为中文 命令 记得把文件改为 utf8 编码，否则会出错
```js
INFO    -  Building documentation...
ERROR   -  Encoding error reading file: index.md
ERROR   -  Error reading page 'index.md': 'utf-8' codec can't decode byte 0xc3 in position 92: invalid continuation byte
[E 190528 20:38:45 ioloop:801] Exception in callback <bound method LiveReloadHandler.poll_tasks of <class 'livereload.handlers.LiveReloadHandler'>>
```
刷新看到效果

![image.png](https://upload-images.jianshu.io/upload_images/17817191-ba459a7c208de3d5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


`vi mkdocs.yml `
把site_name 的 my docs 改为中文 我的文档

![image.png](https://upload-images.jianshu.io/upload_images/17817191-e18ba256f5b093b2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### 添加页面
vi about.md 

vi mkdocs.yml
```js
site_name: 文档
pages:
- [index.md, Home]
- [about.md, About]
```
然后报错了
```js
INFO    -  Building documentation...
ERROR   -  Config value: 'pages'. Error: Invalid pages config. {<class 'list'>} {<class 'str'>, <class 'dict'>}
[E 190529 09:57:45 ioloop:801] Exception in callback <bound method LiveReloadHandler.poll_tasks of <class 'livereload.handlers.LiveReloadHandler'>>
    Traceback (most recent call last):
      File "d:\python\lib\site-packages\tornado\ioloop.py", line 1229, in _run
        return self.callback()
      File "d:\python\lib\site-packages\livereload\handlers.py", line 69, in poll_tasks
        filepath, delay = cls.watcher.examine()
      File "d:\python\lib\site-packages\livereload\watcher.py", line 105, in examine
        func()
      File "d:\python\lib\site-packages\mkdocs\commands\serve.py", line 107, in builder
        site_dir=site_dir
      File "d:\python\lib\site-packages\mkdocs\config\base.py", line 210, in load_config
        "Aborted with {0} Configuration Errors!".format(len(errors))
    mkdocs.exceptions.ConfigurationError: Aborted with 1 Configuration Errors!
λ mkdocs -V
mkdocs, version 1.0.4 from d:\python\lib\site-packages\mkdocs (Python 3.7)
```

![image.png](https://upload-images.jianshu.io/upload_images/17817191-79dac36c5c72db1c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



Google 查找到issue https://github.com/mkdocs/mkdocs/issues/1770
https://www.mkdocs.org/user-guide/writing-your-docs/#configure-pages-and-navigation 
改为 
```js
site_name: 我的文档
nav:
- 主页: 'index.md'
- 关于: 'about.md'
theme: readthedocs
```
![image.png](https://upload-images.jianshu.io/upload_images/17817191-d175d642d3aa159b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


[https://markdown-docs-zh.readthedocs.io/zh_CN/latest/](https://markdown-docs-zh.readthedocs.io/zh_CN/latest/)

原来是中文文档过时了。


### 站点生成
```js
λ mkdocs build
INFO    -  Cleaning site directory
INFO    -  Building documentation to directory: d:\code\mydoc\site

d:\code\mydoc
λ ls
docs/  mkdocs.yml  site/
```
一段时间后, 可能有文件被从源码中移除了, 但是相关的文档仍残留在 site 目录中. 在构建命令中添加  --clean 参数即可移除这些文档.
```js
$ mkdocs build --clean

λ cd site\

d:\code\mydoc\site
λ ls
404.html  css/    img/        js/      search.html  sitemap.xml.gz
about/    fonts/  index.html  search/  sitemap.xml

d:\code\mydoc\site
λ php -S localhost:8000
PHP 7.1.13 Development Server started at Wed May 29 10:17:19 2019
Listening on http://localhost:8000
```
### 部署到GitHub
部署之前先配置下GitHub秘钥
cd ~/.ssh
ssh-keygen -t rsa -C “mysusheng@gmail.com”
这里不要一路回车，我们自己手动填写保存路径
vi config
```js
Host github.com
HostName github.com
User git
IdentityFile ~/.ssh/mysusheng
λ ssh -T git@github.com
Hi sushengbuhuo! You've successfully authenticated, but GitHub does not provide shell access.
```
然后将公钥上传到GitHub 配置。
```js
λ git clone https://github.com/sushengbuhuo/markdown_doc
Cloning into 'markdown_doc'...
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (3/3), done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (3/3), done.

d:\code
λ cd markdown_doc\

d:\code\markdown_doc (master)
λ ls
README.md

d:\code\markdown_doc (master)
λ mkdir docs

d:\code\markdown_doc (master)
λ cd docs\

d:\code\markdown_doc\docs (master)
λ mkdocs.exe new .
INFO    -  Writing config file: .\mkdocs.yml
INFO    -  Writing initial docs: .\docs\index.md

d:\code\markdown_doc\docs (master)
λ mkdocs build
INFO    -  Cleaning site directory
INFO    -  Building documentation to directory: d:\code\markdown_doc\docs\site

d:\code\markdown_doc\docs (master)
λ echo "site/" >> .gitignore

d:\code\markdown_doc\docs (master)
λ mkdocs gh-deploy --clean
INFO    -  Cleaning site directory
INFO    -  Building documentation to directory: d:\code\markdown_doc\docs\site
WARNING -  Version check skipped: No version specificed in previous deployment.
INFO    -  Copying 'd:\code\markdown_doc\docs\site' to 'gh-pages' branch and pushing to GitHub.
INFO    -  Your documentation should shortly be available at: https://sushengbuhuo.github.io/markdown_doc/
```
就是把site目录代码上传到github gh-pages分支了.

推送完成后浏览器访问 https://sushengbuhuo.github.io/markdown_doc/ 就可以看到效果了，接着修改md文件完善你的文档。

![image.png](https://upload-images.jianshu.io/upload_images/17817191-9dcf12e27ceea940.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



 
### 资源
[Python 中文数据结构和算法教程](https://github.com/PegasusWang/python_data_structures_and_algorithms)
[类似gitbook生成文档工具](https://docsify.js.org/#/zh-cn/deploy)
[Python Web 入坑指南](https://python-web-guide.readthedocs.io/zh/latest/)
[mkdocs配置](https://yangfangs.github.io/2016/08/09/install-build-mkdocs/)
[文档查询工具](http://devdocs.io)
[支持数学公式](https://stackoverflow.com/questions/27882261/mkdocs-and-mathjax/31874157)
[git配置多个SSH Key](https://www.awaimai.com/2200.html)
[图说设计模式，使用图形和代码结合的方式来解析设计模式
 ](https://design-patterns.readthedocs.io/zh_CN/latest/index.html)
推荐阅读：
[Pyhon 爬虫框架 looter ](https://mp.weixin.qq.com/s/-l7CnvU6Yu3CIcLizPJtYg)
[5 分钟使用 hugo 搭建一个自己的博客]( https://mp.weixin.qq.com/s/-yta6BOJPfmLs9WVzFulyw)
[Python 词云分析周杰伦《晴天》]( https://mp.weixin.qq.com/s/pBD7lq-5zu22qKeC5PvDyA)

### 公众号：苏生不惑
 ![扫描二维码关注](https://upload-images.jianshu.io/upload_images/17817191-6e0079f95d4c0338.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
