title: Meteor中的hot push实现方式
categories: 技术
tags: Meteor
---

`Meteor`有很多特性，其中实现的热部署应该就是很多人很感兴趣的地方，通过研究代码之后发现，其实实现起来也不是很复杂。

代码在`github`上，热部署由[autoupdate](https://github.com/meteor/meteor/tree/devel/packages/autoupdate)包和[reload](https://github.com/meteor/meteor/tree/devel/packages/reload)包来完成

reload模块
==================
`reload`模块是运行在`client`端，依赖`sessionStorage`的模块，主要的工作流程就是，通过从`sessionStorage`中获取`Meteor_reload`的信息，然后前台执行`window.location.reload()`来实现。