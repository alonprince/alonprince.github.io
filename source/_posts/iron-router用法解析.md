title: iron-router用法解析
categories: 技术
date: 2015-02-08 16:14:09
tags: [Meteor, 路由]
---

有一段时间没写BLOG了，也有好久没有关注Meteor生态圈了，这次来写一下Meteor中的`Iron-router`。下面写的例子是为了方便自己记忆的，所以写的不够完善，想了解详细的情况还是得看官方的[Guide](https://github.com/EventedMind/iron-router/blob/devel/Guide.md)


以下是几个官方例子，我会尽可能的讲明白。。

[基本操作](https://github.com/EventedMind/iron-router/blob/devel/examples%2Fbasic%2Fbasic.js)
=======================

官方代码:
```javascript
Router.route('/', function () {
  // 用{data: {title: 'My Title'}}去渲染Home模板
  this.render('Home', {data: {title: 'My Title'}});
});

// 当你访问路由"/one"的时候将会自动加载名为one的模板。
Router.route('/one');

// 当你访问路由"/two"的时候将会自动加载名为two的模板。
Router.route('/two');
```

上面的例子是`Router`的基本用法，用`Router.route`来定义一个路由，这个方法传递两个参数，第一个参数是*路径地址*，第二个参数是一个匿名函数，主要是配置该路由的。例如以上代码中，`this.render('Home', {data: {title: 'My Title'}});`代表的意思是用{data: {title: 'My Title'}}去渲染Home模板。

