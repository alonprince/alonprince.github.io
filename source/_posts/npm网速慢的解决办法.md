title: npm网速慢的解决办法
date: 2014-09-28 23:22:31
categories: 技术
tags: [npm, nodejs]
---

国内经常会遇到npm特别慢的情况，可以通过下面的方式，更改npm的镜像

###通过下面命令设置镜像
``npm config set registry http://r.cnpmjs.org``

国内镜像：
>http://r.cnpmjs.org
>http://registry.cnpmjs.org 
>http://registry.npm.taobao.org

官方镜像：
>https://registry.npmjs.org

###常用的npm的命令
``npm install -g``全局安装包
``npm ls -g``   查看全局已安装的包
``npm install <package>@<version>``安装指定版本的包


###附上常用的库的地址

JQuery地址
>http://code.jquery.com/jquery-1.11.0.min.js

bootstrapev2地址
>http://cdn.bootcss.com/twitter-bootstrap/2.3.2/css/bootstrap.min.css
>http://cdn.bootcss.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js


