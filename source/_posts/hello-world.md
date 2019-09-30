---
title: hexo搭建博客
tags:
- hexo
---
通常我们可以使用github pages 来搭建静态博客，建立一个username.github.io的项目就可以了，如果要将其他项目也作为页面展示，可以将代码推送到gh-pages分支。

GitHub pages木有默认样式，所以如果你不会自己写css，博客很难看的，所以有了hexo.
### 准备
先安装好git node hexo
#### 初始化
```javascript
$ hexo init blog
INFO  Cloning hexo-starter to D:\code\hexo\blog
Cloning into 'D:\code\hexo\blog'...
remote: Enumerating objects: 68, done.
remote: Total 68 (delta 0), reused 0 (delta 0), pack-reused 68
Unpacking objects: 100% (68/68), done.
Submodule 'themes/landscape' (https://github.com/hexojs/hexo-theme-landscape.git) registered for path 'themes/landscape'
Cloning into 'D:/code/hexo/blog/themes/landscape'...
remote: Enumerating objects: 5, done.
remote: Counting objects: 100% (5/5), done.
remote: Compressing objects: 100% (5/5), done.
remote: Total 846 (delta 0), reused 1 (delta 0), pack-reused 841
Receiving objects: 100% (846/846), 2.55 MiB | 16.00 KiB/s, done.
Resolving deltas: 100% (445/445), done.
Submodule path 'themes/landscape': checked out '73a23c51f8487cfcd7c6deec96ccc7543960d350'
INFO  Install dependencies
yarn install v1.9.4
info No lockfile found.
[1/4] Resolving packages...
warning hexo > titlecase@1.1.2: no longer maintained
warning hexo > nunjucks > postinstall-build@5.0.3: postinstall-build's behavior is now built into npm! You should migrate off of postinstall-build and use the new `prepare` lifecycle script with npm 5.0.0 or greater.
[2/4] Fetching packages...
info fsevents@1.2.4: The platform "win32" is incompatible with this module.
info "fsevents@1.2.4" is an optional dependency and failed compatibility check. Excluding it from installation.
[3/4] Linking dependencies...
[4/4] Building fresh packages...
success Saved lockfile.
Done in 18.06s.
INFO  Start blogging with Hexo!

$ cd blog
hexo的目录结构
.
├── .deploy       #需要部署的文件
├── node_modules  #Hexo插件
├── public        #生成的静态网页文件
├── scaffolds     #模板
├── source        #博客正文和其他源文件, 404 favicon CNAME 等都应该放在这里
|   ├── _drafts   #草稿
|   └── _posts    #文章
├── themes        #主题
├── _config.yml   #全局配置文件
└── package.json
$ npm install
npm WARN deprecated titlecase@1.1.2: no longer maintained
npm WARN deprecated postinstall-build@5.0.3: postinstall-build's behavior is now built into npm! You should migrate off of postinstall-build and use the new `prepare` lifecycle script with npm 5.0.0 or greater.

> nunjucks@3.1.4 postinstall D:\code\hexo\blog\node_modules\nunjucks
> node postinstall-build.js src

npm WARN rollback Rolling back node-pre-gyp@0.10.0 failed (this is probably harmless): EPERM: operation not permitted, rmdir 'D:\code\hexo\blog\node_modules\fsevents\node_modules'
npm notice created a lockfile as package-lock.json. You should commit this file.
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@1.2.4 (node_modules\fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@1.2.4: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})

added 101 packages, removed 40 packages and updated 321 packages in 23.882s

$ ls
_config.yml    package.json       scaffolds/  themes/
node_modules/  package-lock.json  source/     yarn.lock

$ hexo g
INFO  Start processing
INFO  Files loaded in 655 ms
INFO  Generated: index.html
INFO  Generated: archives/index.html
INFO  Generated: fancybox/jquery.fancybox.css
INFO  Generated: fancybox/blank.gif
INFO  Generated: fancybox/fancybox_loading@2x.gif
INFO  Generated: fancybox/fancybox_sprite@2x.png
INFO  Generated: fancybox/jquery.fancybox.js
INFO  Generated: fancybox/jquery.fancybox.pack.js
INFO  Generated: fancybox/fancybox_sprite.png
INFO  Generated: fancybox/fancybox_overlay.png
INFO  Generated: archives/2018/11/index.html
INFO  Generated: fancybox/fancybox_loading.gif
INFO  Generated: css/fonts/FontAwesome.otf
INFO  Generated: fancybox/helpers/jquery.fancybox-thumbs.css
INFO  Generated: js/script.js
INFO  Generated: fancybox/helpers/jquery.fancybox-buttons.js
INFO  Generated: fancybox/helpers/jquery.fancybox-media.js
INFO  Generated: fancybox/helpers/jquery.fancybox-buttons.css
INFO  Generated: css/fonts/fontawesome-webfont.eot
INFO  Generated: css/fonts/fontawesome-webfont.woff
INFO  Generated: fancybox/helpers/fancybox_buttons.png
INFO  Generated: fancybox/helpers/jquery.fancybox-thumbs.js
INFO  Generated: css/style.css
INFO  Generated: css/fonts/fontawesome-webfont.ttf
INFO  Generated: archives/2018/index.html
INFO  Generated: css/images/banner.jpg
INFO  Generated: css/fonts/fontawesome-webfont.svg
INFO  Generated: 2018/11/20/hello-world/index.html
INFO  28 files generated in 1.26 s


$ hexo s
INFO  Start processing
INFO  Hexo is running at http://localhost:4000 . Press Ctrl+C to stop

$ hexo d
ERROR Deployer not found: git

```
### GitHub key 配置
```javascript
1.生成指定名字的密钥 
ssh-keygen -t rsa -C “xx@sina.com” -f ~/.ssh/github_sushengbuhuo 
会生成 github_sushengbuhuo 和 github_sushengbuhuo.pub 这两个文件

2.密钥复制到托管平台上 
vim ~/.ssh/github_sushengbuhuo.pub ，把内容复制至代码托管平台上

3.修改config文件 vim ~/.ssh/config #修改config文件，如果没有创建 config

Host sushengbuhuo.github.com
HostName github.com
User git
IdentityFile ~/.ssh/github_sushengbuhuo

Host github.com
HostName github.com
User git
IdentityFile ~/.ssh/github
4.测试验证
$ ssh -T git@github.com:
ssh: Could not resolve hostname github.com:: Name or service not known

$ ssh -T git@github.com
git@github.com: Permission denied (publickey).

$ ssh -T  git@sushengbuhuo.github.com
Hi sushengbuhuo! You've successfully authenticated, but GitHub does not provide shell access.
```
#### 配置config.yml
```javascript
deploy:
  type: git
  repository: git@sushengbuhuo.github.com:sushengbuhuo/sushengbuhuo.github.io.git
  branch: master
  
theme: next
```
### 推送到GitHub
```javascript
$ hexo clean && hexo g
INFO  Deleted database.
INFO  Deleted public folder.
INFO  Start processing
INFO  Files loaded in 545 ms
INFO  Generated: index.html
INFO  Generated: archives/index.html
INFO  Generated: fancybox/fancybox_loading.gif
INFO  Generated: fancybox/fancybox_sprite@2x.png
INFO  Generated: fancybox/jquery.fancybox.js
INFO  Generated: fancybox/fancybox_overlay.png
INFO  Generated: fancybox/jquery.fancybox.css
INFO  Generated: fancybox/jquery.fancybox.pack.js
INFO  Generated: fancybox/blank.gif
INFO  Generated: fancybox/fancybox_loading@2x.gif
INFO  Generated: fancybox/fancybox_sprite.png
INFO  Generated: css/fonts/FontAwesome.otf
INFO  Generated: archives/2018/11/index.html
INFO  Generated: css/fonts/fontawesome-webfont.eot
INFO  Generated: archives/2018/index.html
INFO  Generated: fancybox/helpers/fancybox_buttons.png
INFO  Generated: fancybox/helpers/jquery.fancybox-thumbs.js
INFO  Generated: css/fonts/fontawesome-webfont.woff
INFO  Generated: fancybox/helpers/jquery.fancybox-buttons.css
INFO  Generated: js/script.js
INFO  Generated: fancybox/helpers/jquery.fancybox-buttons.js
INFO  Generated: css/style.css
INFO  Generated: fancybox/helpers/jquery.fancybox-thumbs.css
INFO  Generated: 2018/11/20/hello-world/index.html
INFO  Generated: css/fonts/fontawesome-webfont.ttf
INFO  Generated: css/fonts/fontawesome-webfont.svg
INFO  Generated: css/images/banner.jpg
INFO  Generated: fancybox/helpers/jquery.fancybox-media.js
INFO  28 files generated in 1.13 s

$ hexo d
ERROR Deployer not found: git

$ npm install hexo-deployer-git --save
npm WARN deprecated swig@1.4.2: This package is no longer maintained
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@1.2.4 (node_modules\fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@1.2.4: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})

+ hexo-deployer-git@0.3.1
added 31 packages in 17.866s

$ hexo d
INFO  Deploying: git
INFO  Setting up Git deployment...
Initialized empty Git repository in D:/code/hexo/blog/.deploy_git/.git/
[master (root-commit) 9c86786] First commit
 Committer: unknown <xxx@sina.com.cn>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly:

    git config --global user.name "Your Name"
    git config --global user.email you@example.com

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 placeholder
INFO  Clearing .deploy_git folder...
INFO  Copying files from public folder...
INFO  Copying files from extend dirs...
warning: LF will be replaced by CRLF in 2018/11/20/hello-world/index.html.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in archives/2018/11/index.html.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in archives/2018/index.html.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in archives/index.html.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in css/style.css.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in fancybox/helpers/jquery.fancybox-buttons.css.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in fancybox/helpers/jquery.fancybox-buttons.js.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in fancybox/helpers/jquery.fancybox-media.js.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in fancybox/helpers/jquery.fancybox-thumbs.css.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in fancybox/helpers/jquery.fancybox-thumbs.js.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in fancybox/jquery.fancybox.css.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in fancybox/jquery.fancybox.js.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in fancybox/jquery.fancybox.pack.js.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in index.html.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in js/script.js.
The file will have its original line endings in your working directory.
[master b7f7580] Site updated: 2018-11-20 11:51:50
 Committer: unknown <xxx@sina.com.cn>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly:

    git config --global user.name "Your Name"
    git config --global user.email you@example.com

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

 29 files changed, 5777 insertions(+)
 create mode 100644 2018/11/20/hello-world/index.html
 create mode 100644 archives/2018/11/index.html
 create mode 100644 archives/2018/index.html
 create mode 100644 archives/index.html
 create mode 100644 css/fonts/FontAwesome.otf
 create mode 100644 css/fonts/fontawesome-webfont.eot
 create mode 100644 css/fonts/fontawesome-webfont.svg
 create mode 100644 css/fonts/fontawesome-webfont.ttf
 create mode 100644 css/fonts/fontawesome-webfont.woff
 create mode 100644 css/images/banner.jpg
 create mode 100644 css/style.css
 create mode 100644 fancybox/blank.gif
 create mode 100644 fancybox/fancybox_loading.gif
 create mode 100644 fancybox/fancybox_loading@2x.gif
 create mode 100644 fancybox/fancybox_overlay.png
 create mode 100644 fancybox/fancybox_sprite.png
 create mode 100644 fancybox/fancybox_sprite@2x.png
 create mode 100644 fancybox/helpers/fancybox_buttons.png
 create mode 100644 fancybox/helpers/jquery.fancybox-buttons.css
 create mode 100644 fancybox/helpers/jquery.fancybox-buttons.js
 create mode 100644 fancybox/helpers/jquery.fancybox-media.js
 create mode 100644 fancybox/helpers/jquery.fancybox-thumbs.css
 create mode 100644 fancybox/helpers/jquery.fancybox-thumbs.js
 create mode 100644 fancybox/jquery.fancybox.css
 create mode 100644 fancybox/jquery.fancybox.js
 create mode 100644 fancybox/jquery.fancybox.pack.js
 create mode 100644 index.html
 create mode 100644 js/script.js
 delete mode 100644 placeholder
git@github.com: Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
FATAL Something's wrong. Maybe you can find the solution here: http://hexo.io/docs/troubleshooting.html
Error: git@github.com: Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

    at ChildProcess.<anonymous> (D:\code\hexo\blog\node_modules\hexo-util\lib\spawn.js:37:17)
    at emitTwo (events.js:126:13)
    at ChildProcess.emit (events.js:214:7)
    at ChildProcess.cp.emit (D:\code\hexo\blog\node_modules\cross-spawn\lib\enoent.js:40:29)
    at maybeClose (internal/child_process.js:925:16)
    at Socket.stream.socket.on (internal/child_process.js:346:11)
    at emitOne (events.js:116:13)
    at Socket.emit (events.js:211:7)
    at Pipe._handle.close [as _onclose] (net.js:557:12)

$ hexo d
INFO  Deploying: git
INFO  Clearing .deploy_git folder...
INFO  Copying files from public folder...
INFO  Copying files from extend dirs...
warning: LF will be replaced by CRLF in 2018/11/20/hello-world/index.html.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in archives/2018/11/index.html.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in archives/2018/index.html.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in archives/index.html.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in css/style.css.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in fancybox/helpers/jquery.fancybox-buttons.css.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in fancybox/helpers/jquery.fancybox-buttons.js.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in fancybox/helpers/jquery.fancybox-media.js.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in fancybox/helpers/jquery.fancybox-thumbs.css.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in fancybox/helpers/jquery.fancybox-thumbs.js.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in fancybox/jquery.fancybox.css.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in fancybox/jquery.fancybox.js.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in fancybox/jquery.fancybox.pack.js.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in js/script.js.
The file will have its original line endings in your working directory.
On branch master
nothing to commit, working tree clean
Branch 'master' set up to track remote branch 'master' from 'git@sushengbuhuo.github.com:sushengbuhuo/sushengbuhuo.github.io.git'.
To sushengbuhuo.github.com:sushengbuhuo/sushengbuhuo.github.io.git
 + 3037877...b7f7580 HEAD -> master (forced update)
INFO  Deploy done: git

$ git clone https://github.com/iissnan/hexo-theme-next themes/next
Cloning into 'themes/next'...
remote: Enumerating objects: 12033, done.
remote: Total 12033 (delta 0), reused 0 (delta 0), pack-reused 12033
Receiving objects: 100% (12033/12033), 12.95 MiB | 79.00 KiB/s, done.
Resolving deltas: 100% (6966/6966), done.

$ hexo clean && hexo g
INFO  Deleted database.
INFO  Deleted public folder.
INFO  Start processing
$ hexo d

$ hexo s
INFO  Start processing
WARN  ===============================================================
WARN  ========================= ATTENTION! ==========================
WARN  ===============================================================
WARN   NexT repository is moving here: https://github.com/theme-next
WARN  ===============================================================
WARN   It's rebase to v6.0.0 and future maintenance will resume there
WARN  ===============================================================
INFO  Hexo is running at http://localhost:4000 . Press Ctrl+C to stop
```
### 安装插件
登录[admin](http://localhost:4000/admin) 即可看到我们所有的文章内容
```javascript
λ npm i hexo-admin --save
npm WARN deprecated minimatch@2.0.10: Please update to minimatch 3.0.2 or higher to avoid a RegExp DoS issue
npm WARN deprecated connect@2.7.11: connect 2.x series is deprecated
npm WARN deprecated cryptiles@2.0.5: This version is no longer maintained. Please upgrade to the latest version.
npm WARN deprecated boom@2.10.1: This version is no longer maintained. Please upgrade to the latest version.
npm WARN deprecated hoek@2.16.3: This version is no longer maintained. Please upgrade to the latest version.
npm WARN acorn-dynamic-import@4.0.0 requires a peer of acorn@^6.0.0 but none is installed. You must install peer dependencies yourself.
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@1.2.4 (node_modules\fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@1.2.4: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})

+ hexo-admin@2.3.0
added 251 packages in 23.975s


   ╭─────────────────────────────────────╮
   │                                     │
   │   Update available 5.6.0 → 6.4.1    │
   │       Run npm i npm to update       │
   │                                     │
   ╰─────────────────────────────────────╯

#网站底部字数统计
d:\code\hexo\blog
λ npm install hexo-wordcount --save
npm WARN rollback Rolling back node-pre-gyp@0.10.0 failed (this is probably harmless): EPERM: operation not permitted, scandir 'd:\code\hexo\blog\node_modules\fsevents\node_modules'
npm WARN acorn-dynamic-import@4.0.0 requires a peer of acorn@^6.0.0 but none is installed. You must install peer dependencies yourself.
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@1.2.4 (node_modules\fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@1.2.4: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})

+ hexo-wordcount@6.0.1
added 1 package in 10.289s

搜索npm install hexo-generator-searchdb --save 
npm install hexo-generator-search  --save

在根目录下的/theme/next/_config.yml文件中添加配置：
search:
  path: search.xml
  field: post
  format: html
  limit: 10000
  
 在根目录下的/theme/next/_config.yml文件中搜索local_search，将enable改为true：
 local_search:
   enable: true 
  
```
### 问题
中文乱码

将config.yml 和md文件编码转为utf-8

修改config.yml `language: zh-Hans`
### 新建文章

``` bash
$ hexo new "PHP依赖注入"
```
Hexo 默认以标题做为文件名称，但您可编辑_config.yml `new_post_name` 参数来改变默认的文件名称，举例来说，设为 :year-:month-:day-:title.md 可让您更方便的通过日期来管理文章。
### 标签分类
```javascript
主菜单设置 blog/_config.yml 添加如下配置
menu:
  home: /
  archives: /archives
  categories: /categories   #手动新建
  tags: /tags               #手动新建
  commonweal: /404.html     #手动新建
  about: /about             #手动新建
 
 
  next/_config.yml 添加如下配置
menu:
  home: / || home
  about: /about/ || user
  tags: /tags/ || tags
  categories: /categories/ || th
  archives: /archives/ || archive
  
  
标签云 页面
命令

hexo new page tags
页面设置

title: tags
date: 2015-09-19 22:37:08
type: "tags"
comments: false
---
关于 页面
命令

hexo new page about
页面设置

title: about
date: 2015-09-19 22:37:08
comments: false
---
About Me #这里编辑 '关于我' 的内容
分类 页面
命令

hexo new page categories
页面设置

title: categories
date: 2015-09-19 22:37:08
type: "categories"
comments: false
---

```
### 显示统计字数和估计阅读时长
```javascript
npm install hexo-wordcount --save
vi blog\themes\hexo-theme-next\_config.yml
post_wordcount:
  item_text: true
  wordcount: true
  min2read: true
  totalcount: false
  separated_meta: false
vi blog\themes\hexo-theme-next\layout\_macro\ **post.swig**文件
 {{ wordcount(post.content) }} 字
   {{ min2read(post.content) }} 分钟 
```
### 显示总访客数和总浏览量
```javascript
vi  D:\blog\themes\hexo-theme-next\layout_partials\ footer.swig
首行添加如下代码：
<script async src="https://dn-lbstatics.qbox.me/busuanzi/2.3/busuanzi.pure.mini.js"></script>

#接着修改相应代码：
# 添加总访客量
<span id="busuanzi_container_site_uv">
  访客数:<span id="busuanzi_value_site_uv"></span>人次
</span>

{% if theme.footer.powered %}
  <!--<div class="powered-by">{#
  #}{{ __('footer.powered', '<a class="theme-link" target="_blank" href="https://hexo.io">Hexo</a>') }}{#
#}</div>-->
{% endif %}

# 添加'|'符号
{% if theme.footer.powered and theme.footer.theme.enable %}
  <span class="post-meta-divider">|</span>
{% endif %}


{% if theme.footer.custom_text %}
  <div class="footer-custom">{#
  #}{{ theme.footer.custom_text }}{#
#}</div>
{% endif %}

# 添加总访问量
<span id="busuanzi_container_site_pv">
   总访问量:<span id="busuanzi_value_site_pv"></span>次
</span>

# 添加'|'符号
{% if theme.footer.powered and theme.footer.theme.enable %}
  <span class="post-meta-divider">|</span>
{% endif %}

# 添加博客全站共：
<div class="theme-info">
  <div class="powered-by"></div>
  <span class="post-count">博客全站共{{ totalcount(site) }}字</span>
</div>
```
### 备份文章
```javascript
将themes/next/(我用的是NexT主题)中的.git/删除，否则无法将主题文件夹push；
在本地blog文件夹下创建文件.gitignore(一般都自带一个)，打开后写入
 
 https://yfzhou.coding.me/2018/09/17/Hexo-Next%E6%90%AD%E5%BB%BA%E4%B8%AA%E4%BA%BA%E5%8D%9A%E5%AE%A2%EF%BC%88Hexo%E5%8D%9A%E5%AE%A2%E5%A4%87%E4%BB%BD%EF%BC%89/
.DS_Store
Thumbs.db
db.json
*.log
node_modules/
public/
.deploy*/
在本地blog文件夹下执行命令
#git初始化
git init
#创建hexo分支，用来存放源码
git checkout -b hexo
#git 文件添加
git add .
#git 提交
git commit -m "init"
#添加远程仓库
git remote add origin git@github.com:sushengbuhuo/sushengbuhuo.github.io.git
#push到hexo分支
git push origin hexo
执行hexo d -g生成网站并部署到GitHub上

这样一来，在GitHub上的git@github.com:sushengbuhuo/sushengbuhuo.github.io.git仓库就有两个分支，
一个hexo分支用来存放网站的原始文件，一个master分支用来存放生成的静态网页。

当重装电脑之后，或者想在其他电脑上修改博客，可以使用下列步骤：

1、先安装hexo
$ npm install -g hexo-cli
2、存在github上的git clone下来
git clone git@github.com:sushengbuhuo/sushengbuhuo.github.io.git
3、项目文件夹下npm
cd项目名/ 
npm install –no-bin-links
$ npm install hexo-deployer-git
4、重新配置github和coding的公钥


每次写作之后,可以使用下列步骤：

hexo d#生成网站并部署到GitHub上
git add .
git commit -m 'update'
git push origin hexo
```
### 添加gitter在线交流
用GitHub登录 https://gitter.im
```javascript
vi next/layout/_third-party/gitter.swig

<script>
  ((window.gitter = {}).chat = {}).options = {
    //room替换成自己的聊天室名称即可，room的名称规则是：username/roomname
    //http://www.xetlab.com/2019/04/14/%E7%BB%99%E5%9F%BA%E4%BA%8EHEXO%E7%9A%84%E5%8D%9A%E5%AE%A2%E6%B7%BB%E5%8A%A0gitter%E5%9C%A8%E7%BA%BF%E4%BA%A4%E6%B5%81/
    room: 'sushengbuhuo/chat'
  };
</script>
<script src="https://sidecar.gitter.im/dist/sidecar.v1.js" async defer></script>

vi next/layout/layout/_layout.swig

{% include '_third-party/gitter.swig' %}
```
### 增加评论utterance
```javascript
https://www.njphper.com/posts/a4cd94b2.html
通过https://github.com/apps/utterances 用GitHub登录，然后设置一个公开目录接受评论。比如 sushengbuhuo/laravel_ioc_demo
<script src="https://utteranc.es/client.js"
        repo="sushengbuhuo/laravel_ioc_demo"
        issue-term="pathname"
        label="susheng"
        theme="github-light"
        crossorigin="anonymous"
        async>
</script>

vi _confgi.yml 增加
utterance:
  enable: true
  repo: sushengbuhuo/laravel_ioc_demo
  theme: github-light
  issue-term: pathname
评论主题的 theme 选项如下:

github-light
github-dark
github-dark-orange
icy-dark
dark-blue
photon-dark
评论 issue-term 映射配置选项如下：

pathname
url
title
og:title
issue-number
specific-term

vi thems\next\layout\_third-party\comments\utterance.swig
<script type="text/javascript">
    (function() {
        // 匿名函数，防止污染全局变量
        var utterances = document.createElement('script');
        utterances.type = 'text/javascript';
        utterances.async = true;
        utterances.setAttribute('issue-term','{{ theme.utterance.issue-item }}')
        utterances.setAttribute('theme','{{ themm.utterance.theme }}')
        utterances.setAttribute('repo','{{ theme.utterance.repo }}')
        utterances.crossorigin = 'anonymous';
        utterances.src = 'https://utteranc.es/client.js';
        // content 是要插入评论的地方
        document.getElementById('gitment-container').appendChild(utterances);
    })();
</script>
vi thems\next\layout\_partials\comments.swig
{% endif %}之前添加
{% elif theme.utterance.enable %}
          <div class="comments" id="comments">
             <div id="gitment-container"></div>
         </div>
 vi thems\next\layout\_third-party\comments\index.swig  
  {% include 'utterance.swig' %}        
       
  评论后内容在 https://github.com/sushengbuhuo/laravel_ioc_demo/issues
```
### 备份到GitHub
```javascript
https://github.com/coneycode/hexo-git-backup

if your hexo version is 2.x.x, you should install as follow:

$ npm install hexo-git-backup@0.0.91 --save
if version is 3.x.x, you should install as follow:

$ npm install hexo-git-backup --save
Update

if you install with --save, you must remove firstly when you update it.

$ npm remove hexo-git-backup
$ npm install hexo-git-backup --save
Configure

You should configure this plugin in _config.yml.

backup:
    type: git
    repository:
       github: git@github.com:xxx/xxx.git,branchName
       gitcafe: git@github.com:xxx/xxx.git,branchName
 

hexo b 

```
### 微博图床失效问题
```javascript
打开/themes/next/layout/_partials/head.swig文件,添加一行代码：<meta name="referrer" content="no-referrer" />,具体如下所示：
<meta charset="UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="referrer" content="no-referrer" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
<meta name="theme-color" content="{{ theme.android_chrome_color }}">
https://xuezheng-wei.com/posts/d970820/
```
### Travis CI 自动部署
```javascript
新建hexo分支
添加 .travis.yml 在博客源文件根目录下并上传:
language: node_js
node_js: stable

cache:
  directories:
    - node_modules
before_install:
  - npm install hexo-cli -g

install:
  - npm install
  - npm install hexo-deployer-git --save

script:
  - hexo clean
  - hexo generate

after_script:
  - cd ./public
  - git init
  - git config user.name "username"
  - git config user.email "useremail"
  - git add .
  - git commit -m "Update docs"
  - git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:master

branches:
  only:
    - hexo
env:
 global:
   - GH_REF: github.com/username/username.github.io.git
   
 （三）配置GitHub Access Token：
 
 GitHub 主页 ——> Settings ——> Developer Settings ——> Personal access tokens ——> Generate new token
 
 （四）Travis CI 设置：
 
    （1）登录 https://travis-ci.org/ 网站用 github 授权登录；
    （2）登录后在个人主页选择你需要 CI 的仓库；
    （3）点击你选择的 hexo 博客的仓库进行配置；
    （4）在 Travis 仓库配置界面 setting 里面对环境变量 Environment Variables 进行 token 配置；
 
 （五）撰写文章并 push 到 github pages：
 
 每次写完文章，只需要执行下面的命令，其余部分会自动完成部署。https://xuezheng-wei.com/posts/8a945b8a/
 git add .
 git commit -m "updated docs"
 git push origin hexo
  
   
```
### 博客备份
```javascript
$ git init //git初始化
$ git add . //git 文件添加
$ git commit -m "init" //git 提交
$ git pull origin hexo //pull到hexo分支
$ git push origin hexo //push到hexo分支
博客恢复
（一）配置 ssh 连接 Github
$ cd ~/.ssh 或cd .ssh //检查本机是否有ssh key设置
$ cd ~  //若没有 ssh ，则切换当前路径在 ”~” 下
$ ssh-keygen -t rsa -C "user@example.com" //引号内为自己邮箱，三个回车后生成ssh key;添加id_rsa.pub内容到Github;
$ git config --global user.name “your_username”  //设置用户名
$ git config --global user.email “your_registered_github_Email”  //设置邮箱地址(建议用注册giuhub的邮箱)
$ ssh -T git@github.com //测试ssh key是否设置成功
（二）安装 Node.js；Git；Hexo；
$ git clone -b hexo git@github.com:user/user.github.io.git  //将Github中hexo分支clone到本地
$ cd user.github.io //切换到hexo目录下
$ npm install hexo
$ npm install 
$ npm install hexo *** //安装需要的插件：feed;deployer;abbrlink;sitemap;pdf;nofollow;baidu-url-submit等
$ hexo g -d //测试能否正常编译上传
https://xuezheng-wei.com/posts/45a0debd/
```
### 图片防盗链
```javascript
<meta name="referrer" content="never" /> ​​​​
Next 主题只需要在 themes/next/layout/_partials/head/custom-head.swig 中添加上面一行内容即可
https://michael728.github.io/2019/05/19/hexo-blog-full-note/
```
### 文章加密
```javascript
打开themes->next->layout->_partials->head.swig文件,在以下位置插入这样一段代码：
<script>
    (function () {
        if ('{{ page.password }}') {
            if (prompt('请输入文章密码') !== '{{ page.password }}') {
                alert('密码错误！');
                if (history.length === 1) {
                    location.replace("http://xxxxxxx.xxx"); // 这里替换成你的首页
                } else {
                    history.back();
                }
            }
        }
    })();
</script>

在文章上写成类似这样
---
title: {{ title }}
date: {{ date }}
tags:
description: 
copyright: 
categories:
password: password
---

但是通过curl工具浏览网页是直接显示网页源代码就可以看到密码
curl -L http://
可以使用https://github.com/MikeCoder/hexo-blog-encrypt/blob/master/ReadMe.zh.md 这个插件加密
https://www.jianshu.com/p/44e211829447 
```
[新写文章文档](https://hexo.io/zh-cn/docs/writing.html)

### 资源
[至简的 hexo 主题](https://github.com/8090Lambert/hexo-theme-easy)


[开源的工具 HexoClient （跨平台的哦）]( https://www.mspring.org/2018/11/29/HexoClient%E4%BD%BF%E7%94%A8%E5%B8%AE%E5%8A%A9/)

[next主题模板一些配置](https://duanruilong.github.io/blog/2018/05/05/next%E4%B8%BB%E9%A2%98%E6%A8%A1%E6%9D%BF%E4%B8%80%E4%BA%9B%E9%85%8D%E7%BD%AE/)

[动动手指，NexT主题与Hexo更搭哦（基础篇）](http://www.arao.me/2015/hexo-next-theme-optimize-base/)

[Next 主题增加新的第三方评论系统 utterance](https://www.njphper.com/posts/a4cd94b2.html)

[Github Pages部署教程](https://juejin.im/post/5b14b2f06fb9a01e5e3d3121)

[GitHub.io 个人站点绑定独立的域名](https://www.playpi.org/2018112701.html)

[打造个性超赞博客Hexo+NexT+GitHubPages的超深度优化](https://reuixiy.github.io/technology/computer/computer-aided-art/2017/06/09/hexo-next-optimization.html#附上我的-custom-styl)

[用Github+Hexo搭建你的个人博客：美化篇](https://www.makcyun.top/hexo02.html)

[hexo干货系列](http://tengj.top/2016/02/20/hexoTotal/)

[hexo文档](https://hexo.io/docs/)

[hexo问题交流](https://hexo.io/docs/troubleshooting.html) 
 
[Deployment](https://hexo.io/docs/deployment.html)

[绝配：hexo+next主题及我走过的坑](https://www.jianshu.com/p/21c94eb7bcd1)

[Hexo+Pages静态博客-Next主题篇](https://blog.csdn.net/mango_haoming/article/details/78207534)

[hexo部署到服务器](https://laravel-china.org/articles/20991)

[关于HEXO搭建个人博客的点点滴滴](https://juejin.im/post/5a6ee00ef265da3e4b770ac1#heading-6)

[搭建博客](https://alvabill.ml/hexo%E6%90%AD%E5%BB%BA%E4%B8%AA%E4%BA%BA%E5%8D%9A%E5%AE%A2--%E5%9F%BA%E7%A1%80%E7%AF%87/)

[手把手教你用Hexo搭建个人技术博客](https://juejin.im/post/5abcd2286fb9a028d66440ba)

[基于CentOS搭建Hexo博客](https://segmentfault.com/a/1190000012907499)

[最快的 Hexo 博客搭建方法](https://blog.coding.net/blog/CS-Hexo)

[超详细Hexo+Github博客搭建小白教程](https://zhuanlan.zhihu.com/p/35668237)

[在Github上备份Hexo博客](https://lrscy.github.io/2018/01/26/Hexo-Github-Backup/)

[最快的 Hexo 博客搭建方法](https://blog.coding.net/blog/CS-Hexo)

[Hugo是由Go语言实现的静态网站生成器](http://www.gohugo.org/)

[带点Geek味的独立博客](http://linbinghe.com/2017/982b12f0.html)

[将 Hexo 博客发布到自己的服务器上](https://blog.mutoe.com/2017/deploy-hexo-website-to-self-server/)

[yilia主题](https://github.com/litten/hexo-theme-yilia)

[使用 Hugo 搭建博客](https://segmentfault.com/a/1190000012975914#articleHeader7)

[博客发布上线方案 — Hexo](https://www.fanhaobai.com/2018/03/hexo-deploy.html)

[hexo博客](https://github.com/fan-haobai/blog)

[使用HEXO搭建博客](http://coderlt.coding.me/2015/09/21/blog-with-hexo/)

[部署Hexo博客到Coding](http://coderlt.coding.me/2015/09/24/hexo-to-coding-150924/)

[用Github+Hexo搭建你的个人博客：美化篇](https://www.makcyun.top/hexo02.html)

[无后端评论系统](https://valine.js.org/)

[hexo博客专题](https://yfzhou.coding.me/categories/Hexo/)

[hexo博客添加标签功能](https://swoole.app/2016/07/23/hexo%E5%8D%9A%E5%AE%A2%E6%B7%BB%E5%8A%A0%E6%A0%87%E7%AD%BE%E5%8A%9F%E8%83%BD/)

[第三方评论系统 utterance](https://www.njphper.com/posts/a4cd94b2.html)

[ Hexo + Github Pages 搭建博客并优化 Next 主题教程](https://michael728.github.io/2019/05/19/hexo-blog-full-note/)

[博客看板娘](https://live2d.fghrsh.net/demo/1.4.2/autoload.html)



