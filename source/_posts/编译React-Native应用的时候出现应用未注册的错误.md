title: 编译React Native应用的时候出现应用未注册的错误
categories: 技术
date: 2015-04-09 15:17:48
tags: React Native
---

我在模仿网上的代码教程的过程中，总是出现编译报错的问题，提示`Application 'xxx' is not been registed`的错误，经过查询后发现，是因为我在程序末尾的`React.AppRegistry.registerComponent('yourAppName', () => yourAppName );`中的名字没有和`package.json`里面的`name`字段保持一致的原因，更改过来之后，就不会报这个错误了