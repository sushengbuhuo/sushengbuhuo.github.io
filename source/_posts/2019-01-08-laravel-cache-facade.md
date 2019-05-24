---
title: laravel cache facade
date: 2019-01-08 14:03:46
tags:
- laravel
---
本文使用版本为laravel5.5

### cache get
```js
public function cache()
    {
    	$c=\Cache::get('app');
    	if(!$c) {
    		\Cache::put('app', 'cache', 1);
    	}
    	dump($c);//cache
    }
    
```
### config/app.php
```js
 'aliases' => [

        'App' => Illuminate\Support\Facades\App::class,
        'Artisan' => Illuminate\Support\Facades\Artisan::class,
        'Auth' => Illuminate\Support\Facades\Auth::class,
        'Blade' => Illuminate\Support\Facades\Blade::class,
        'Broadcast' => Illuminate\Support\Facades\Broadcast::class,
        'Bus' => Illuminate\Support\Facades\Bus::class,
        'Cache' => Illuminate\Support\Facades\Cache::class,
        
        ]
```
使用cache实际调用的是`Illuminate\Support\Facades\Cache`,这个映射是如何做的？
### public/index.php
```js
$response = $kernel->handle(
$request = Illuminate\Http\Request::capture()
);
```
### bootstarp/app.php
```js
$app->singleton(
    Illuminate\Contracts\Http\Kernel::class,
    App\Http\Kernel::class
);
```
### app/http/kernel.php
```js
use Illuminate\Foundation\Http\Kernel as HttpKernel;

class Kernel extends HttpKernel
{

}
```
### Illuminate/Foundation/Http/Kernel.php
```js
public function handle($request)
{
    try {
        $request->enableHttpMethodParameterOverride();
        $response = $this->sendRequestThroughRouter($request);
    } catch (Exception $e) {
        $this->reportException($e);

        $response = $this->renderException($request, $e);
    } catch (Throwable $e) {
        $this->reportException($e = new FatalThrowableError($e));

        $response = $this->renderException($request, $e);
    }

    $this->app['events']->dispatch(
        new Events\RequestHandled($request, $response)
    );

    return $response;
}
protected function sendRequestThroughRouter($request)
    {
        $this->app->instance('request', $request);

        Facade::clearResolvedInstance('request');

        $this->bootstrap();

        return (new Pipeline($this->app))
                    ->send($request)
                    ->through($this->app->shouldSkipMiddleware() ? [] : $this->middleware)
                    ->then($this->dispatchToRouter());
    }
    public function bootstrap()
    {
        if (! $this->app->hasBeenBootstrapped()) {
            $this->app->bootstrapWith($this->bootstrappers());
        }
    }
```
### Illuminate/Foundation/Application.php
```js
public function bootstrapWith(array $bootstrappers)
    {
        $this->hasBeenBootstrapped = true;

        foreach ($bootstrappers as $bootstrapper) {
            $this['events']->fire('bootstrapping: '.$bootstrapper, [$this]);

            $this->make($bootstrapper)->bootstrap($this);

            $this['events']->fire('bootstrapped: '.$bootstrapper, [$this]);
        }
    }
```
### Illuminate/Foundation/Bootstrap/RegisterFacades.php
```js
public function bootstrap(Application $app)
    {
        Facade::clearResolvedInstances();

        Facade::setFacadeApplication($app);
//将config/app.php 里的aliases数组里面的Facades类设置别名
        AliasLoader::getInstance(array_merge(
            $app->make('config')->get('app.aliases', []),
            $app->make(PackageManifest::class)->aliases()
        ))->register();
    }
```
### Illuminate/Foundation/AliasLoader.php
```js
public function load($alias)
    {
        if (static::$facadeNamespace && strpos($alias, static::$facadeNamespace) === 0) {
            $this->loadFacade($alias);

            return true;
        }

      // $alias来自于config/app.php中aliases数组 
        if (isset($this->aliases[$alias])) {
            //'Route' => Illuminate\Support\Facades\Route::class,
            // class_alias 为一个类创建别名
            return class_alias($this->aliases[$alias], $alias);
        }
    }
```
### Illuminate/Support/Facades/Cache.php
```js
class Cache extends Facade
{
    /**
     * Get the registered name of the component.
     *
     * @return string
     */
    protected static function getFacadeAccessor()
    {
        return 'cache';
    }
}
```
### Illuminate/Support/Facades/Facade.php
这个文件没有get set ，只有__callStatic
```js
public static function __callStatic($method, $args)
    {
        $instance = static::getFacadeRoot();

        if (! $instance) {
            throw new RuntimeException('A facade root has not been set.');
        }

        return $instance->$method(...$args);
    }
   public static function getFacadeRoot()
    {
        return static::resolveFacadeInstance(static::getFacadeAccessor());
    } 
     protected static function resolveFacadeInstance($name)
    {
    //这里$name为cache
        if (is_object($name)) {
            return $name;
        }

        if (isset(static::$resolvedInstance[$name])) {
            return static::$resolvedInstance[$name];
        }
    //$app是容器对象，实现了ArrayAccess接口，最终调用的还是容器的make方法
        return static::$resolvedInstance[$name] = static::$app[$name];
    }
```
### Illuminate\Container\Container.php
```js
public function make($abstract, array $parameters = [])
    {
        return $this->resolve($abstract, $parameters);
    }
    protected function resolve($abstract, $parameters = [])
    {
        $abstract = $this->getAlias($abstract);

        $needsContextualBuild = ! empty($parameters) || ! is_null(
            $this->getContextualConcrete($abstract)
        );

        // If an instance of the type is currently being managed as a singleton we'll
        // just return an existing instance instead of instantiating new instances
        // so the developer can keep using the same objects instance every time.
        if (isset($this->instances[$abstract]) && ! $needsContextualBuild) {
            return $this->instances[$abstract];
        }

        $this->with[] = $parameters;

        $concrete = $this->getConcrete($abstract);

        // We're ready to instantiate an instance of the concrete type registered for
        // the binding. This will instantiate the types, as well as resolve any of
        // its "nested" dependencies recursively until all have gotten resolved.
        if ($this->isBuildable($concrete, $abstract)) {
            $object = $this->build($concrete);
        } else {
            $object = $this->make($concrete);
        }

        // If we defined any extenders for this type, we'll need to spin through them
        // and apply them to the object being built. This allows for the extension
        // of services, such as changing configuration or decorating the object.
        foreach ($this->getExtenders($abstract) as $extender) {
            $object = $extender($object, $this);
        }

        // If the requested type is registered as a singleton we'll want to cache off
        // the instances in "memory" so we can return it later without creating an
        // entirely new instance of an object on each subsequent request for it.
        if ($this->isShared($abstract) && ! $needsContextualBuild) {
            $this->instances[$abstract] = $object;
        }

        $this->fireResolvingCallbacks($abstract, $object);

        // Before returning, we will also set the resolved flag to "true" and pop off
        // the parameter overrides for this build. After those two things are done
        // we will be ready to return back the fully constructed class instance.
        $this->resolved[$abstract] = true;

        array_pop($this->with);

        return $object;
    }
```
### Illuminate/Cache/CacheServiceProvider.php
```js
 public function register()
    {
        $this->app->singleton('cache', function ($app) {
            return new CacheManager($app);
        });

        $this->app->singleton('cache.store', function ($app) {
            return $app['cache']->driver();
        });

        $this->app->singleton('memcached.connector', function () {
            return new MemcachedConnector;
        });
    }
```
### get set
```js
$instance->$method(...$args)

由于 PHP 可以处理 WEB 和 CLI 两种接口请求，所以 Laravel 就得需要设计 HttpKernel 和 ConsoleKernel 来处理这两种。
实际上，Laravel 刚刚启动时先启动容器对象 Application，然后加载配置、通过 ServiceProvider 往容器对象里填充一些对象为接下来处理请求做准备，但是真正干活的是 Kernel(HttpKernel 或 ConsoleKernel)，Application 会把活转给 Kernel 来干。$output = Kernel::handle($input)：对于 WEB 请求，输入时 Request，输出是 Response；对于 CLI，输入是 argument + option 命令行变量构成的 Input 对象，输出则是展示在终端的 Output 对象。
所以，依赖注入(IoC 容器) 是 Laravel 的基石，真正干活的是 Kernel。https://laravel-china.org/articles/20507
```
[Facades 原理 (代码执行流程分析)](https://laravel-china.org/articles/21985)

[Laravel 源码阅读之二：Illuminate\Foundation\Application 类初始化分析](https://laravel-china.org/articles/20802#5db9fd)

[Laravel Queue——消息队列任务与分发源码剖析](https://laravel-china.org/articles/7037/laravel-queue-analysis-of-message-queue-tasks-and-distribution-source-code#9a853c)

 [Laravel Service Provider 概念详解](https://laravel-china.org/articles/6189/laravel-service-provider-detailed-concept)
 
 [Laravel核心代码学习](https://github.com/kevinyan815/Learning_Laravel_Kernel)
 
 [Laravel 启动流程分析 (代码全流程)](https://laravel-china.org/articles/19878)

[生命周期 5 管道流分析](https://laravel-china.org/articles/19785#3170db)

[Laravel 5.7 嵌套集基础教程](https://laravel-china.org/articles/22617?#reply79267)

[laravel-mysql读写分离](https://www.jianshu.com/p/8ea43b1a83df)

[Laravel 框架涉及的各种软件理念和工具](https://github.com/huanghua581/FATA)

[Lumen 进阶之数据库交互](https://blog.gxxsite.com/lumen-advance-database-interaction/)

[Laravel 开发 RESTful API 的心得](https://www.v2ex.com/t/434082)

[深入研究 larvael 源码第三天](https://learnku.com/articles/20528)

[Laravel队列实现原理解决问题记录](https://segmentfault.com/a/1190000010787709)

[LARAVEL 生命周期解析](https://www.0php.net/posts/Laravel-%E7%94%9F%E5%91%BD%E5%91%A8%E6%9C%9F%E8%A7%A3%E6%9E%90.html)

[搭建 Laravel 运行环境线上 LNMP](https://learnku.com/laravel/t/17508)

[Laravel 源码阅读指南 -- PHP 类的反射和依赖注入](https://learnku.com/articles/12555/laravel-source-code-reading-guide-reflection-and-dependency-injection-for-class-php)

[自动化测试：六个值得参考的 Laravel 开源项目](https://learnku.com/laravel/t/24767)

[Laravel 源码阅读指南 -- Contracts 契约](https://learnku.com/articles/17830)

[Laravel 入门指南](https://learnku.com/laravel/wikis/7227)

[Laravel Eloquent 提示和技巧](https://learnku.com/articles/19876)

[laravel Elasticsearch 实现简单搜索](https://learnku.com/articles/25066)