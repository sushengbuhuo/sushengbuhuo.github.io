---
title: ppt 神器 reveal
date: 2019-05-22 11:47:22
tags:
- ppt
- 公众号
---

ppt相信大家都用过，不过程序员使用的PPT是可以在网页上用的，比如 reveal
## 安装
先安装好node 
```js
npm install -g reveal-md
λ reveal-md -h
Puppeteer unavailable, unable to create featured slide image for OpenGraph metadata.
Puppeteer unavailable, unable to generate PDF file.
Usage: cli <slides.md> [options]

See https://github.com/webpro/reveal-md for more details.

Options:
  -V, --version                               output the version number
      --title <title>                         Title of the presentation
  -s, --separator <separator>                 Slide separator [default: 3 dashes (---) surrounded by two blank lines]
  -S, --vertical-separator <separator>        Vertical slide separator [default: 4 dashes (----) surrounded by two blank lines]
  -t, --theme <theme>                         Theme [default: black]
      --highlight-theme <theme>               Highlight theme [default: zenburn]
      --css <files>                           CSS files to inject into the page
      --scripts <files>                       Scripts to inject into the page
      --assets-dir <dirname>                  Defines assets directory name [default: _assets]
      --preprocessor <script>                 Markdown preprocessor script
      --template <filename>                   Template file for reveal.js
      --listing-template <filename>           Template file for listing
      --print [filename]                      Print to PDF file
      --static [dir]                          Export static html to directory [_static]. Incompatible with --print.
```
 ## 使用
vi test.md
reveal-md test.md
reveal-md slides.md --port 8888
浏览器打开localhost:8888 即可在网页上演示PPT了。
## 资源
 [reveal-md](https://github.com/webpro/reveal-md#usage)
[使用 Jupyter python markdown 制作分享 ppt](https://github.com/PegasusWang/notebooks)
[nodeppt ](https://github.com/ksky521/nodeppt)
## 公众号：苏生不惑
 ![扫描二维码关注](https://upload-images.jianshu.io/upload_images/17817191-6e0079f95d4c0338.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)