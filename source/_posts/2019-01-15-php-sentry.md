---
title: php sentry
date: 2019-01-15 16:04:16
tags:
- php
- sentry
---
sentry 是一个

### 配置sentry
可以在sentry.io注册账号获取配置https://sentry.io/settings/sina-tl/sina/keys/ ，如 http://root:root@127.0.0.1:1234/2
当然也可以自己搭建服务器，参考 https://laravel-china.org/articles/4285/build-your-own-sentry-service

### sentry扩展

```javascript
composer require "sentry/sentry"
require_once APP_BASE_PATH.'/vendor/autoload.php';
$client = new \Raven_Client('http://root:root@127.0.0.1:1234/2');
$error_handler = new \Raven_ErrorHandler($client);
$error_handler->registerExceptionHandler();
$error_handler->registerErrorHandler();
$error_handler->registerShutdownFunction();
 //直接写日志
 $client->captureMessage('my log message');


```
### monolog日志写入Redis
```javascript
 composer require "monolog/monolog: 1.18.0"
 composer require 'predis/predis'
use Monolog\Handler\RedisHandler;
use Monolog\Formatter\JsonFormatter;
use Monolog\Formatter\LineFormatter;
use Monolog\Processor\MemoryPeakUsageProcessor;
use Monolog\Processor\WebProcessor;
use Monolog\Processor\IntrospectionProcessor;
use Monolog\Handler\RavenHandler;
use Monolog\Logger;

class Monolog{
    public $logger;

    public function __construct($name)
    {
        $this->logger = new Logger($name);
        //https://docs.sentry.io/clients/php/integrations/monolog/
        $redis = new \Predis\Client([
            'scheme' => 'tcp',
            'host'   => '127.0.0.1',
            'port'   => 6379,
            'read_write_timeout' => 0,
        ]);
        $handler = new RedisHandler($redis, "app:sentry", \Monolog\Logger::DEBUG);
        $this->logger->pushHandler($handler);
        $handler->setFormatter(new JsonFormatter(JsonFormatter::BATCH_MODE_NEWLINES, true));
        $handler->pushProcessor(new MemoryPeakUsageProcessor(true));
        $handler->pushProcessor(new IntrospectionProcessor());
        $arr = [
            'url' => 'REQUEST_URI',
            'ip' => 'REMOTE_ADDR',
            'http_method' => 'REQUEST_METHOD',
            'query_string' => 'QUERY_STRING',
            'cookies' => 'HTTP_COOKIE',
            'host' => 'HTTP_HOST',
            'referrer' => 'HTTP_REFERER',
            'ua' => 'HTTP_USER_AGENT',
        ];

        $handler->pushProcessor(new WebProcessor(null, $arr));
        $this->logger->addinfo('applog',['info'=>'test']);
    }
    
```
### 消费redis入sentry
```javascript
use Raven_Client;
use Monolog\Handler\RavenHandler;
use Monolog\Formatter\LineFormatter;
while (true) {
            
            $redis = new \Predis\Client([
                        'scheme' => 'tcp',
                        'host'   => '127.0.0.1',
                        'port'   => 6379,
                        'read_write_timeout' => 0,
                    ]);
            $data = $redis->lpop("app:sentry");

            if (empty($data)) {
                sleep(1);
                continue;
            }
            $data = json_decode($data, true);
            $raven_client= new Raven_Client('http://root:root@127.0.0.1:1234/3',[
                'extra'=>$data['extra'],
                'tags'=>[]
            ]);
            $raven_hanlder=new RavenHandler($raven_client);

            $data['extra'] = [];
            $r=$raven_hanlder->handle($data);
            $raven_client->__destruct();
```
### 查看错误日志
```javascript
https://sentry.io/sina-tl/sina/issues/845243592/?query=is%3Aunresolved 
```
[php sentry](https://juejin.im/post/5a992115f265da239f06d0d7)

[Docker部署Sentry监控Django应用并使用email+钉钉通知](https://blog.ansheng.me/article/docker-sentry-django-email-dingtalk/)

[php sentry usage](https://docs.sentry.io/clients/php/usage/)

[搭建私有的前端监控服务: sentry](https://juejin.im/post/5b226cbe51882574d02f9f62)

[sentry异常提醒](https://laravel-china.org/articles/4235/sentry-automation-exception-alert)

[CentOS6 基于 Python 安装 Sentry ](https://laravel-china.org/articles/4295/centos6-install-python-based-on-sentry#reply22542)