---
title: laravel swoole
date: 2018-12-10 15:03:09
tags:
- laravel
- swoole
---

### laravel 响应慢
```javascript
https://laravel-china.org/topics/2550/the-speed-of-laravel-5-is-indeed-a-bit-slow-here-are-the-results-of-the-oneapm-test
https://laravel-china.org/topics/3583/laravel-performance-has-always-been-difficult-to-let-go-seek-guidance
项目的可维护性，是相对更加重要的。用框架损耗一点性能，来换取开发效率、可维护性是值得。至于优化性能，手段很多，一般找到性能瓶颈对其优化即可，而性能瓶颈一般不会是在框架上。
比如：用 Laravel 比用XX框架，框架多消耗了 50ms。但是你发现流量上来后，瓶颈是在 IO 上（比如数据库，服务器硬盘，网络 IO）。假如可能是 mysql 数据库查询就慢了 1s。这时候要引入缓存，就可以解决该阶段的问题。在实施方案时，发现用XX框架加缓存，代码写得乱七八糟，漏洞百出。而用 Laravel，花了很短的时间和精力就上了缓存功能，并且代码优雅，结构清晰，易于维护。
那么，框架的优势就体现了。

不要轻易、任性、随意添加各种各样的 package ，特别是需要添加 provicder 的那种，捡最需要的来。
模型的 Observer 多的话，确实会影响框架启动速度，当前的项目有二三十个，影响10~40ms的启动速度（服务器配置不一样，影响不一样），这个没办法处理了。
上面这两条是我的项目确实存在的问题，并且确实对哪怕一个 hello world 的简单输出也要有影响，但是很难处理掉的。

其他的挺好的，laravel 对我们的项目的进度和开发的质量真的相比其它框架提高了很多。并且线上的 8核16G OPCache，影响不太大，项目现在有100多个表，业务密集型的应用，速度满足我们的需要，大部分页面和接口 200ms 以内。

最后，SQL 一定要处理好，这个可能永远是你们项目性能最大的瓶颈。

Laravel 的确是一个高效且优雅的框架，作为其重度使用者的我也觉得这个框架已经被神话了。如果你有足够的时间且理解你所开发的项目，真心推荐使用 Laravel 作为项目开发框架。但是，如果，就像我说的，如果你对项目做不到知根知底、PHP 基础不扎实、周期紧张、项目影响大，所有综合因素来判定后，慎重决定。如果你真的很希望使用且愿意为后果买单，像我这样愿意深入学习其优秀特性、思想，仔细阅读文档、源码，做到举一反三甚至能做到任意改造且升级自如，那么，你还会提出这种问题吗？
php7 用了吗
opcache 开了吗
optimaize 了吗
最有用的是 php7 opcache 然后 gzip 

先说内存的事，Java 和 Go 都有成熟的 GC，除非你开着全局变量并且一直往里塞东西，否则泄露不了内存，每个请求的 handler 是个闭包或者函数，只要不故意定义超过函数生命周期的变量，你不玩 off-heap 黑魔法，完全不会泄露内存。

部署的话，php 和 python 差不多，比起 Java 和 Go 麻烦太多了，Go 最简单，就一个可执行文件，大部分情况下也不依赖什么运行库。Java 比起 go 稍微麻烦一点，就是需要先安装一个 JRE，然后也是一个 jar 包直接运行(现代 javaweb 一般内置了 tomcat 这类 webserver)，复杂一点就是把 war 扔到 tomcat 的 webapps 目录，它会自动重启。

php 和 python 就麻烦很多了，用 pip/pear 安装扩展的时候经常会遇到 xxx.h 找不到，典型的比如 db 驱动。然后还必须前置一个 nginx 或者 apache，fastcgi 配起来还麻烦，不同框架配置方法不一样，还要提防 cgi 的 fixpath 问题。python 稍微好一些，uwsgi 比较简单，或者直接走 http 协议更简单。Java 和 Go 的最简单，把 static 资源外的直接 proxy_pass 走就行了。
PHP 光是把环境搭一遍都很麻烦。

php7.1 开始内置代码的 cache 了，改 php 文件是没用的，改完文件得重启 fpm 进程才能生效，这个应该是性能增强带来的副作用。在需要重启服务以后，php 的新版本手动部署，已经跟 java 或者 go 没有不同了。


如果是关联数组：数组转对象可以直接用(object)()；对象转数组则要用get_object_vars()；

如果是索引数组：数组转对象可以直接用(object)()；对象转数组直接用(array)()；

觉得 php 部署简单的，我提个前几年遇到过好几次的场景，看看大家有没有好办法。

几台服务器，无外网连接，系统有 rhel5 和 rhel6，还有 ubuntu12 和 14，还有 windows 32 位和 64 位都有，用到的数据库是 pgsql 和 db2，如何打包 php 程序过去部署？

当时我的解法是，Java 给每个平台下载一个 JRE，应用打成 jar 包就好了，db 驱动也是 java 实现的，直接打进 jar 包里了，不依赖运行库。php 真的难倒了我，最后，我给每个平台下载了对应版本的 vmware，然后为 php 制作了虚拟机镜像，把兼容性工作交给了 vmware 去做。还好那些机器都有图形界面和 root 帐号，不然还得折腾无 gui 甚至无 root 的情况下怎么安装 vmware。
http://php.net/manual/en/intro.opcache.php 

Laravel 慢不是什么地方出瓶颈了，而是 Laravel 这个框架本身就是瓶颈。
优化点：
1. 重构 router，特别是你的路由比较多的时候，foreach 之后还要正则就是找不痛快；
2. 用 swoole 服务模式把需要重复初始化的地方抹平，只初始化一次，不过这个会进入普通 php 程序员不熟悉的领域，而且大部分业务逻辑以及第三方组件需要修改以适应服务模式；
3. 放弃 Laravel
我用 lumen + php 7.1 测过，Laravel 的 echo time();
在 i5 的机器上，2 个路由的时候，QPS 能跑 5000 左右。
路由数量 100 的时候，QPS 下降到 4000 左右。
路由数量 1000 的时候，QPS 下降到 1100+。
如果用了 1000 个正则做路由，我相信还会更慢。

当我用 100 路由，再开启 session 的时候，QPS 从 4000 左右跌到了 1500+，腰斩了有没有？随便再引入几条正则路由，再开几个 Middleware，那 QPS 估计就跟楼主那个一样了。
```
### 修改器
```javascript
<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Baby extends Model
{
    protected $table = 'baby';
    protected $appends = ['age'];

    public function getAgeAttribute()
    {
        $date = new Carbon($this->birthday);
        return Carbon::now()->diffInYears($date);
    }
}
return $baby->age;//得到几岁 https://laravel-china.org/articles/21982
```
###  Supervisor 管理 Laravel 队列
```javascript
sudo pip install supervisor
echo_supervisord_conf
echo_supervisord_conf > /etc/supervisord.conf
默认配置文件中的supervisord.sock、supervisord.log以及supervisord.pid是放在/tmp目录下，这个目录存放的是Linux中的临时文件，一旦被系统删除，就会提示unix:///tmp/supervisor.sock no such file，所以我们要把这三个文件放到其他目录中保存。
sudo chmod 777 /var/run
sudo chmod 777 /var/log/supervisor
supervisord -c /etc/supervisord.conf
pgrep supervisord | xargs ps -u --pid
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root     13744  0.0  1.7 226320 17460 ?        Ss   1月12   0:08 /bin/python /usr/bin/supervisord -c /etc/supervi

[program:larashop-worker]  ;项目名称
process_name=%(program_name)s_%(process_num)02d
command=php (填入你的artisan路径)/artisan queue:work redis --sleep=3 --tries=3  ;需要启动的命令
autostart=true
autorestart=true
user=root ;此处填入你运行WEB应用的用户
numprocs=8  ;进程数
redirect_stderr=true  ;把 stderr 重定向到 stdout，默认 false
stdout_logfile=/var/log/supervisor/larashop-queue.log  ;注意分配好日志文件夹权限
supervisorctl reread  # 读取有更新（增加）的配置文件，不会启动新添加的程序

supervisorctl update # 重启配置文件修改过的程序

supervisorctl start larashop-worker:* # 启动 larashop-worker 程序
supervisorctl status # 查看状态 如果在Laravel中修改了队列代码，需要重启Supervisor才能生效
                            


```
### Swoole 与 Laravel 结合使用
```javascript
修改php.ini，增加swoole.use_namespace=On开启。使用命名空间类名后，旧式的下划线风格类名将不可用。
namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Repositories\PushRepository;

class Push extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'push:start';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = '推送服务启动命令';

    /**
    * push处理推送任务的对象实例
    */
    protected $_repPush;

    /**
     * Create a new command instance.
     *
     * @param  DripEmailer  $drip
     * @return void
     */
    public function __construct(PushRepository $repPush)
    {
        parent::__construct();
        $this->_repPush = $repPush;
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
      $this->_repPush->start();
    }

}/**
  * 消息推送服务
  * @author: KongSeng <643828892@qq.com>
  */
 namespace App\Repositories;
 use \Swoole\Server;
 use Config;
 
 class PushRepository extends BaseRepository
 {
 
   /**
   * Swoole Server 服务
   */
   private $__serv = null;
 
   /**
   * 构造函数
   */
   public function __construct(){
     $this->__initSwoole();
   }
 
   /**
   * 初始化swoole
   */
   private function __initSwoole(){
     $host = Config::get('swoole.host');
     $port = Config::get('swoole.port');
     $setConf = Config::get('swoole.set');
 
     $this->__serv = new Server($host,$port);
     $this->__serv->set($setConf);
 
     $this->__serv->on('receive', array($this,'onReceive'));
   }
 
   /**
   * 数据接收回调
   */
   public function onReceive($serv, $fd, $from_id, $data){
     $serv->send($fd,$data."\r\n");
   }
 
   /**
   * 开启服务https://laravel-china.org/articles/22712
   */
   public function start(){
     $this->__serv->start();
   }
 
 }
 php artisan push:start
 

```
### Websocket 服务中使用 Swoole
```javascript
$server = new swoole_websocket_server('php', 9501);
$server->on('start', function (swoole_websocket_server $server) {
    echo "Server has been started!\n";
});
$server->on('open', function (swoole_websocket_server $server, $request) {
    echo "websocket: new connection, id: {$request->fd}\n";
});
$server->on('message', function (swoole_websocket_server $server, $frame) {
    echo "websocket: {$frame->fd}:{$frame->data},opcode:{$frame->opcode},fin:{$frame->finish}\n";
    $server->push($frame->fd, "Replying, you sent " . $frame->data);
});
$server->on('close', function (swoole_websocket_server $server, $fd) {
    echo "websocket: connection with id {$fd} has been closed\n";
});
$server->start();
```
### Lumen 5.2 手动补回 artisan serve 指令
```javascript
Lumen 5.2 版本之前，通过php artisan serve指令即可快速启动调试
https://blog.gxxsite.com/lumen-php-artisan-serve-local-debug-solution/
Lumen 5.2 简化了 artisan，把serve精简掉了，用以下代码可以快速启动：

php -S localhost:8080 -t ./public
但是习惯了还是 serve 顺手吧，补充的方法如下：

通过composer安装lumen-artisan-serve：

 composer require mlntn/lumen-artisan-serve "~1"
修改app/Console/Kernel.php文件扩展artisan命令

 protected $commands = [
     \Mlntn\Console\Commands\Serve::class
 ];
至此，serve指令又能用了：

php artisan serve --port=8080
```
### MySQL 频繁出错 Packets out of order. Expected 1 received 111. Packet size
```javascript
在swoole start函数前创建了mysql连接, 那么后续所有的worker以及task多个子进程都是使用一开始主进程的这个数据库连接。如果有多个子进程同时使用该连接与数据库通信(进程切换)，那么就可能因为通信协议时序的不正确导致mysql出现异常。
解决方案:

在swoole start函数前注销mysql连接, DB::disconnect();
相关文章:

1.Server中对象的4层生命周期 https://wiki.swoole.com/wiki/page/354.html
2.是否可以共用1个redis或mysql连接 https://wiki.swoole.com/wiki/page/325.html
https://learnku.com/articles/28953
```
[基于swoole实现的微信机器人](https://github.com/kcloze/swoole-bot)

[ swoole 协程之旅](https://learnku.com/articles/28112#topnav)

[轻松部署 Laravel 应用](https://github.com/wi1dcard/laravel-deployment)

[《Laravel 入门教程》](https://github.com/summerblue/laravel-tutorial)

[Swoole 是 PHP 中的 Node.js](https://learnku.com/laravel/t/22245)

[-从生命周期看 Dingo API 是如何接管 Laravel 路由的](https://laravel-china.org/articles/19945#a44a83)

[配置 Supervisor 管理 Laravel 队列](https://laravel-china.org/articles/22321#e655a4)

[swoole 协程之旅](https://learnku.com/articles/28112)

[workerman实现服务间通讯](https://www.goozp.com/article/64.html)

[Laravel Queue——消息队列任务处理器源码剖析](https://laravel-china.org/articles/7038/laravel-queue-source-analysis-of-message-queue-task-processor#efa8e7)

[Laravel 源码阅读之二：Illuminate\Foundation\Application 类初始化分析](https://laravel-china.org/articles/20802#5db9fd)

[开源了一个小小的商城](https://laravel-china.org/articles/20281#2020e7)

[Laravel 和 Swoole 的高性能框架](https://github.com/lawoole/lawoole)

[基于 swoole 的高性能 PHP 框架](https://laravel-china.org/articles/21358)

[ Laravel 应用中的 Swoole 集成](https://laravel-china.org/articles/18801)

[聊天室系统](https://github.com/walkor/workerman-chat)

[不用三方包 给 Laravel 开启 Swoole](https://laravel-china.org/topics/17351)

[基于 Laravel-swoole 开发部署的在线聊天室](https://laravel-china.org/topics/20181)

[一个线上提交作业的平台](https://github.com/blankqwq/stu_x)

[使用数据库连接池提高性能](https://github.com/louislivi/SMProxy)

[laravel swoole](https://github.com/swooletw/laravel-swoole/wiki/4.-Installation)

[为什么我不太想用 Laravel ](https://www.v2ex.com/t/371855)

[ laravel 寫 APP 接口](https://www.v2ex.com/t/441162)

[laracast 视频教程系列笔记](https://github.com/qianhuihuiji/notebook)

[我独自走进 Laravel5.5 的❤（八）](https://laravel-china.org/articles/19737)

[Laravel面试](https://www.v2ex.com/t/478257)

[Laravel，PHP 如何使用数据库连接池提高性能](https://learnku.com/articles/20793#topnav)

[Swoole 源码分析](https://laravel-china.org/articles/18062)

[Laravel 5 系列入门教程](https://lvwenhan.com/laravel/432.html)

[Laravel 到底能慢到什么程度](https://lax.v2ex.com/t/420124)

[使用 laragon 的 ngrok 功能在本地开发微信公众号](https://laravel-china.org/articles/18123)

[php框架压测](https://github.com/kenjis/php-framework-benchmark/blob/master/README.md)

[Laravel 每个控制器都需要写个路由](https://www.v2ex.com/t/272328?hmsr=toutiao.io&utm_medium=toutiao.io&utm_source=toutiao.io)

[Laravel 项目加速指南](http://www.dahouduan.com/2018/03/18/laravel-speed-up/)

[opcache 的统计功能](https://github.com/rlerdorf/opcache-status)

[laravel 优化](https://www.v2ex.com/t/398902)

[国内使用 laravel ](https://lax.v2ex.com/t/357983?p=1)

[phwoolcon](https://github.com/phwoolcon/phwoolcon/blob/master/README-zh.md)

[laravel和Uikit开发的后台管理系统雏形 自带完整oauth授权管理模块](https://github.com/ydtg1993/admin)

[Laravel HTML 导出 PDF 方案 -](https://laravel-china.org/articles/20450?#reply77440)

[《2018年小米高级 PHP 工程师面试题（模拟考试卷）》答案解析 [ 未指定版本 ]](https://laravel-china.org/articles/21048)

[laravel Facades 原理 (代码执行流程分析)](https://laravel-china.org/articles/21985?#reply77444)

[MySQL · 最佳实践 · 分区表基本类型](http://mysql.taobao.org/monthly/2017/11/09/)

[《2019年小米春季上海 PHP 实习生招聘面试题》部分答案解析 [ 千人千面 ]](https://laravel-china.org/articles/21993)

[Laravel 之道](https://laravel-china.org/docs/the-laravel-way/5.6)

[基于 laravelS 和 layim 的聊天系统](https://github.com/woann/chat)

[PHP 高级工程面试题汇总](https://laravel-china.org/articles/20714)

[Laravel 深入浅出指南](https://github.com/xiaohuilam/laravel/wiki)

[基于 swoole 协程的 MySQL 连接池](https://laravel-china.org/articles/21979)

[swoole 加速 Lumen5.7 Restful API 接口](https://laravel-china.org/articles/21966)

[Laracasts 系列教程](https://github.com/SakyaVarro/laracasts-translation)

[Laravel核心代码学习](https://github.com/kevinyan815/Learning_Laravel_Kernel)

[laravel5.5 支付—— 支付宝](https://laravel-china.org/articles/19427)

[GatewayWorker 手册](http://doc2.workerman.net/)

[Laravel 深入核心系列教程](https://github.com/cxp1539/laravel-core-learn)

[PHP 框架性能测试比较](https://www.v2ex.com/t/401168)

[Swoole 加速 Laravel/Lumen](https://www.v2ex.com/t/428497)

[swoft](https://doc.swoft.org/master/zh-CN/quickstart/install.html)

[Laravel 源码阅读指南](https://learnku.com/articles/23935)

[基于 laravelS 和 layim 的聊天系统](https://learnku.com/articles/22094)

[快速集成Swoole到Laravel lumen](https://github.com/hhxsv5/laravel-s/blob/master/README-CN.md)

[Laravel 源码阅读之一：Composer 自动加载分析](https://laravel-china.org/articles/20816)

[Laravel 中文文档检索 Alfred Workflow](https://github.com/zhuqipeng/alfred-workflow)

[基于 Laravel 框架开发的基础权限后台系统](https://learnku.com/articles/24742#topnav)

[Laravel 下 Elasticsearch 使用](https://learnku.com/articles/25179)

[markdown文档](https://larecipe.binarytorch.com.my/docs/1.3/installation)

[基于 Laravel 框架的 rbac 后台管理系统](https://learnku.com/articles/20539)

[Laravel5配置读写分离和源码分析](http://www.luckybird.me/laravel5%E9%85%8D%E7%BD%AE%E8%AF%BB%E5%86%99%E5%88%86%E7%A6%BB%E5%92%8C%E6%BA%90%E7%A0%81%E5%88%86%E6%9E%90.html)

[Laravel-swoole 开发部署的在线聊天室](https://github.com/shisiying/webim)

[PHP 与 Swoole 浅析与学习](https://learnku.com/articles/28607)