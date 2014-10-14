title: Makefile的简单应用
date: 2014-10-03 22:52:38
categories: 技术
tags: [nodejs, npm, linux]
---

需求分析
================
在编写nodejs的过程中，我们经常会遇到clone一个项目后，先要键入``npm install``来安装依赖，然后运行``gulp``(因为我觉得gulp的语法很简单，所以我只会gulp，还没研究过grunt)来生成相关编译后的静态文件，再使用``node app``来运行项目

这种情况如果只是一次还好，但由于nodejs在每次项目文件更改过之后，需要中断进程，然后重启进程，这个过程如果循环很多遍，相信很多人都会疯掉，虽然后类似``supervisor``之类的小工具能解决问题，``grunt``也有相应的插件能解决这个问题，例如文件改动，页面自动刷新等等，但是我这里提供了一种另外的解决方案

Makefile简介
================

第一次看到``Makefile``是在别人的项目中，发现很好用，主要是能少打好多个字，看了下，发现里面内容也很简单

下面这个是我写的一个Makefile文件里面的内容
```
install : all

all :
	npm install
	gulp scripts
	node app
```

用法很简单吧，你只需要把你要运行的命令写在all下面就好了
