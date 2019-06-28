---
title: elasticsearch
date: 2019-01-16 20:34:55
tags:
- elasticsearch
---
### 安装java
elasticsearch 需要 java8 以上；我们到 https://www.oracle.com/technetwork/java/javase/downloads/index.html 下载安装最新版的 java11 jdk，
选中 Accept License Agreement 然后右键点击 jdk-11.0.2_linux-x6 4_bin.rpm 复制链接
```javascript
[root@VM_0_14_centos ~]# wget https://download.oracle.com/otn-pub/java/jdk/11.0.2+7/f51449fcd52f4d52b93a989c5c56ed3c/jdk-11.0.2_linux-x6 4_bin.rpm
--2019-01-16 12:42:46--  https://download.oracle.com/otn-pub/java/jdk/11.0.2+7/f51449fcd52f4d52b93a989c5c56ed3c/jdk-11.0.2_linux-x64_bin.rpm
Resolving download.oracle.com (download.oracle.com)... 23.56.20.195
Connecting to download.oracle.com (download.oracle.com)|23.56.20.195|:443... connected.
HTTP request sent, awaiting response... 302 Moved Temporarily
Location: https://edelivery.oracle.com/otn-pub/java/jdk/11.0.2+7/f51449fcd52f4d52b93a989c5c56ed3c/jdk-11.0.2_linux-x64_bin.rpm [following]
--2019-01-16 12:42:47--  https://edelivery.oracle.com/otn-pub/java/jdk/11.0.2+7/f51449fcd52f4d52b93a989c5c56ed3c/jdk-11.0.2_linux-x64_bin.rpm
Resolving edelivery.oracle.com (edelivery.oracle.com)... 23.10.0.83, 2600:140e:6:39b::366, 2600:140e:6:38b::366
Connecting to edelivery.oracle.com (edelivery.oracle.com)|23.10.0.83|:443... connected.
HTTP request sent, awaiting response... 302 Moved Temporarily
Location: http://download.oracle.com/errors/download-fail-1505220.html [following]
--2019-01-16 12:42:48--  http://download.oracle.com/errors/download-fail-1505220.html
Connecting to download.oracle.com (download.oracle.com)|23.56.20.195|:80... connected.
HTTP request sent, awaiting response... 301 Moved Permanently
Location: https://download.oracle.com/errors/download-fail-1505220.html [following]
--2019-01-16 12:42:48--  https://download.oracle.com/errors/download-fail-1505220.html
Connecting to download.oracle.com (download.oracle.com)|23.56.20.195|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 5307 (5.2K) [text/html]
Saving to: ‘jdk-11.0.2_linux-x64_bin.rpm’

100%[===============================================================================================>] 5,307       --.-K/s   in 0s

2019-01-16 12:42:49 (319 MB/s) - ‘jdk-11.0.2_linux-x64_bin.rpm’ saved [5307/5307]

[root@VM_0_14_centos ~]# rpm -ivh jdk-11.0.2_linux-x6 4_bin.rpm
error: open of <html> failed: No such file or directory
error: open of <head> failed: No such file or directory
#rm -rf jdk-11.0.2_linux-x6 4_bin.rpm
#wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http:%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "https://download.oracle.com/otn-pub/java/jdk/11.0.2+7/f51449fcd52f4d52b93a989c5c56ed3c/jdk-11.0.2_linux-x6 4_bin.rpm"
[root@VM_0_14_centos ~]#  rpm -ivh jdk-11.0.2_linux-x64_bin.rpm
warning: jdk-11.0.2_linux-x64_bin.rpm: Header V3 RSA/SHA256 Signature, key ID ec551f03: NOKEY
Preparing...                          ################################# [100%]
Updating / installing...
   1:jdk-11.0.2-2000:11.0.2-ga        ##########                        ( 31%)
################################# [100%]
[root@VM_0_14_centos ~]# java -h
Usage: java [options] <mainclass> [args...]
           (to execute a class)
   or  java [options] -jar <jarfile> [args...]
           (to execute a jar file)
   or  java [options] -m <module>[/<mainclass>] [args...]
       java [options] --module <module>[/<mainclass>] [args...]
           (to execute the main class in a module)
   or  java [options] <sourcefile> [args]
           (to execute a single source-file program)
```
### 安装es
```javascript
[root@VM_0_14_centos ~]# rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
[root@VM_0_14_centos ~]# wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.4.2.rpm
--2019-01-16 13:04:37--  https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.4.2.rpm

Connecting to artifacts.elastic.co (artifacts.elastic.co)|107.21.239.197|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 97875508 (93M) [application/octet-stream]
Saving to: ‘elasticsearch-6.4.2.rpm’

83% [==============================================================================>                 ] 81,427,954   221KB/s   in 15m 2s

2019-01-16 13:19:45 (88.2 KB/s) - Connection closed at byte 81427954. Retrying.

--2019-01-16 13:19:46--  (try: 2)  https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.4.2.rpm
Connecting to artifacts.elastic.co (artifacts.elastic.co)|107.21.239.197|:443... connected.
HTTP request sent, awaiting response... 206 Partial Content
Length: 97875508 (93M), 16447554 (16M) remaining [application/octet-stream]
Saving to: ‘elasticsearch-6.4.2.rpm’

100%[+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++================>] 97,875,508  1.66MB/s   in 14s

2019-01-16 13:20:02 (1.16 MB/s) - ‘elasticsearch-6.4.2.rpm’ saved [97875508/97875508]
[root@VM_0_14_centos ~]# rpm -ivh elasticsearch-6.4.2.rpm
Preparing...                          ################################# [100%]

Creating elasticsearch user... OK
Updating / installing...
   1:elasticsearch-0:6.4.2-1          ################################# [100%]
### NOT starting on installation, please execute the following statements to configure elasticsearch service to start automatically using systemd
 sudo systemctl daemon-reload
 sudo systemctl enable elasticsearch.service
### You can start elasticsearch service by executing
 sudo systemctl start elasticsearch.service
Created elasticsearch keystore in /etc/elasticsearch
vim /etc/elasticsearch/elasticsearch.yml
bootstrap.memory_lock: true
network.host: localhost
http.port: 9200
[root@VM_0_14_centos ~]# systemctl daemon-reload
[root@VM_0_14_centos ~]# systemctl enable elasticsearch.service
Created symlink from /etc/systemd/system/multi-user.target.wants/elasticsearch.service to /usr/lib/systemd/system/elasticsearch.service. [root@VM_0_14_centos ~]# systemctl start elasticsearch

[root@VM_0_14_centos ~]# systemctl status elasticsearch
● elasticsearch.service - Elasticsearch
   Loaded: loaded (/usr/lib/systemd/system/elasticsearch.service; enabled; vendor preset: disabled)
   Active: failed (Result: signal) since Wed 2019-01-16 20:35:07 CST; 20min ago
     Docs: http://www.elastic.co
  Process: 31064 ExecStart=/usr/share/elasticsearch/bin/elasticsearch -p ${PID_DIR}/elasticsearch.pid --quiet (code=killed, signal=KILL)  Main PID: 31064 (code=killed, signal=KILL)

Jan 16 20:34:13 VM_0_14_centos systemd[1]: Started Elasticsearch.
Jan 16 20:34:13 VM_0_14_centos systemd[1]: Starting Elasticsearch...
Jan 16 20:34:18 VM_0_14_centos elasticsearch[31064]: Java HotSpot(TM) 64-Bit Server VM warning: Option UseConcMarkSweepGC was de...lease.

Jan 16 20:35:07 VM_0_14_centos systemd[1]: elasticsearch.service: main process exited, code=killed, status=9/KILL
Jan 16 20:35:07 VM_0_14_centos systemd[1]: Unit elasticsearch.service entered failed state.
Jan 16 20:35:11 VM_0_14_centos systemd[1]: elasticsearch.service failed.
Hint: Some lines were ellipsized, use -l to show in full.
//https://learnku.com/laravel/t/25013
安装的话可以参考腾讯实验室的功能；挺好用的； https://cloud.tencent.com/developer/labs/lab/10433
#wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.6.1.tar.gz
tar -zxvf elasticsearch-6.6.1.tar.gz
cd elasticsearch-6.6.1
./bin/elasticsearch
curl 'http://localhost:9200/?pretty'
```
### Elasticsearch 中文分词器 ik-analyzer
```javascript
/usr/share/elasticsearch/bin/elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v6.4.2/elasticsearch-analysis-ik-6.4.2.zip
sudo systemctl restart elasticsearch
curl -H 'Content-Type: application/json'  -XGET 'localhost:9200/_analyze?pretty' -d '{"analyzer":"ik_max_word","text":"ytkah博客园"}'

```
[Laravel 项目中使用 Elasticsearch 做引擎](https://learnku.com/laravel/t/25013)

[Elasticsearch 实现简单搜索](https://learnku.com/articles/25066)

[ELK集中式日志平台之二 — 部署](https://www.fanhaobai.com/2017/12/elk-install.html)

[elk demo](https://demo.elastic.co/app/kibana#/discover?)

[ElasticSearch的安装与使用必知问题](https://blog.csdn.net/tanmx219/article/details/78704544)

[配置Elasticsearch](https://segmentfault.com/a/1190000015189799)

[像使用 Laravel Query 一样的搜索 Elasticsearch](https://laravel-china.org/articles/9410/search-elasticsearch-like-laravel-query)

[elasticsearch-centos7安装教程](https://smirkcat.github.io/2017/03/21/elasticsearch-install/)

[CentOS 7 安装 Elasticsearch 6.4.2 教程](https://laravel-china.org/articles/19402?#reply78416)

[Elasticsearch入门教程之安装与基本使用](https://www.cnblogs.com/luke44/p/elasticsearch-doc.html)

[ Elasticsearch 入门教程](http://www.ruanyifeng.com/blog/2017/08/elasticsearch.html)

[开源的项目有用到 Elasticsearch](https://github.com/yanthink/blog-api)

[5 分钟配置并使用 Elasticsearch](https://laravel-china.org/topics/2757/5-minutes-to-configure-and-use-elasticsearch)

[Elasticsearch 的配置与使用，为了全文搜索](https://laravel-china.org/articles/10126/the-configuration-and-use-of-elasticsearch-for-full-text-search)

[CentOS 7.x 安装 Elasticsearch 6.x](https://www.einsition.com/article/3/details)

[Elasticsearch，为了搜索](https://laravel-china.org/articles/2765/elasticsearch-in-order-to-search)

[Elasticsearch入门教程之安装与基本使用](https://www.cnblogs.com/luke44/p/elasticsearch-doc.html)

[在Laravel5.5中使用搜索 Elasticsearch](https://juejin.im/post/5a3730ff6fb9a045076fc2b1)

[ELK 搭建笔记](https://laravel-china.org/articles/22569)

[elasticsearch-centos7安装教程](https://smirkcat.github.io/2017/03/21/elasticsearch-install/)

[Solr的使用 — 部署和数据推送](https://www.fanhaobai.com/2017/08/solr-install-push.html)

[一文上手 Elasticsearch常用可视化管理工具](https://mp.weixin.qq.com/s/BE8LrpviJNXGV41bhzGFTw)

[Laravel 下 Elasticsearch 使用](https://learnku.com/articles/25179#topnav)

[CentOS 7.6 安装 Elasticsearch 7.2](https://learnku.com/articles/30389)