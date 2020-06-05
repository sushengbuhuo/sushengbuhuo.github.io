---
title: php Elasticsearch记录
date: 2020-06-05 15:11:33
tags:
---

### 安装
```javascript
composer require "elasticsearch/elasticsearch:~5.0"
根据安装的版本来安装 https://packagist.org/packages/elasticsearch/elasticsearch
use Elasticsearch\ClientBuilder;
$host = xxx;
        $port = xxx;
        $hosts  = [$host.':'.$port];
        $client = ClientBuilder::create()           // 实例化 ClientBuilder
        ->setHosts($hosts)      // 设置主机信息
        ->build();
$params = [
            'index' => xxx,
            'type' => xxx,
            'body' => [
                'query' => [
                    'bool' => [
                        'must' => [
                            //['match'=>['id'=>274100]],
                        ],
                    ]
                ],
                'sort'=> ['time' => 'desc'],
            ],

            'size'=>100
        ];
查询所有
$response = $client->search($params);
took: 2,
timed_out: false,
_shards:- {
total: 6,
successful: 6,
failed: 0
},
hits:- {
total: 280015,
max_score: null,
hits:- [
-{
_index: "weibo",
_type: "wb",
_id: "2800",
_score: null,
_source:- {
id: 2800,
mid: "451247565335367",
is_top: 0,
tags:[],
time: "2020-06-05 15:18:16"
},
sort:- [
1591370296000
]
}
$match = [];
        $not = [];
        if ($params['is_top']){
            $match[] = ['term'=>['is_top'=>$params['is_top']]];
        }
        if ($params['tag'] == 1){
                    $match[] = ['exists'=>['field'=>'tags']];//tags不为空
                }
        if ($params['start_time'] && $params['end_time'] && $params['end_time'] > $params['start_time']){
                    $match[] = ['range'=>['wb_time' => ['gte'=>$params['start_time'], 'lte'=> $params['end_time']]]];
                }
if ($params['tag'] == 0){
            $not[] = ['exists'=>['field'=>'tags']];//tags为空
        }
 $must = [['terms'=>['is_top'=>1]]];
         if ($match){
             $must = array_merge($must,$match);
         }
         if ($params['tags']){
             $must[] = ['query_string'=>['fields'=>['tags'],'query'=>'*微博*']];//like
         }
         $search = [
             'index' => xxx,
             'type' => xxx,
             'body' => [
                 'query' => [
                     'bool' => [
                        'must' => $must,
                         'must_not'=>$not,
                     ],
                 ],
                 'sort'=> ['time' => 'desc']
             ],
             'from'                          => 1,
             'size'                          => 10,
         ];
         $response = $client->search($search);       
        
        
```

[笔记二十：Query & Filtering 与 多字符串多字段查询](https://learnku.com/articles/36224)

[中文文档](http://doc.codingdict.com/elasticsearch/)

[PHP DSL 查修构造器扩展](https://flc.io/elasticsearch/simple/builder/#script)


[Elasticsearch: 权威指南](https://www.elastic.co/guide/cn/elasticsearch/guide/current/bulk.html)



