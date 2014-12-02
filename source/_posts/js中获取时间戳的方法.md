title: js中获取时间戳的方法
date: 2014-12-01 22:38:24
categories: 技术
tags: js
---
最近用时间对象特别多，所以取时间戳就成了经常需要用到的方法了

这里给列出几种我目前知道的关于获取时间戳的方法，应该是不全的

一，getTime()
============

```
var time = new Date().getTime()
```

这个可能是被最多人所熟知的方法了，用时间对象的的`getTime`方法，直接获取时间戳

二，时间对象的隐式类型转换
=============

```
var oDate = new Date()
var time1 = +oDate
var time2 = oDate * 1
```

由于javascript属于弱类型语言，所以在计算时间对象的时候，js会默认把时间对象转化成数字时间戳

三，Date.now()
==============

```
var time = Date.now()
```

时间对象提供的方法，获取当前的时间戳，不需要先去`new`一个对象

四，Date.parse()
=====

```
var time = Date.parse(new Date())
```

用时间对象提供的解析方法来解析新生成的时间对象【(╯‵□′)╯︵┻━┻多此一举啊混蛋

五，valueOf()
====

```
var time = new Date().valueOf()
```

用valueOf来获取时间对象的值，返回的是时间戳