title: 扩展Meteor的用户系统
date: 2014-10-11 14:14:29
categories: 技术
tags: Meteor
---

简要说明
=======================
本文是翻译MeteorHacks的一篇关于Meteor中Accounts的文章,原文见[这里](https://meteorhacks.com/extending-meteor-accounts.html)

正文
======================
Meteor有一个非常好的用户认证系统，称之为[Accounts](http://docs.meteor.com/#accounts_api)。这个认证系统不仅仅为用密码、facebook、twitter和其他平台提供了强大的方法，还因为其与Meteor的核心服务相关联，从而提供高级别的安全。

好的，但是如果你想添加一个自定义的验证方法呢？Meteor没有给你足够的信息让你这么做。所以我(原作者)开始研究[Meteor Accounts system](http://goo.gl/PfIvj)的源代码。我发现作者的代码写的十分优雅，同时实现一个自定义的认证方式也非常简单。接下来我们就来说说这个。

在这个教程里，我将会为我们的Meteor App来创建一个用于管理的自定义认证系统。但这个系统不是一个正式的实现方式，仅仅可以用来演示如何添加自定义认证。

首先，创建一个简单的应用
=======================
* 用`meteor create admin`来创建一个Meteor应用
* 用`meteor add accounts-ui`来添加`accounts-ui`包
* 用下面的代码来替换掉`admin.html`中的代码
添加`loginButtons`来调用`accounts-ui`包
```html
<head>
  <title>admin</title>
</head>
<body>
  <!-- 第一处 -->
</body>
<template name="hello">
  <h1>Hello World!</h1>
  <!-- 第二处 -->
  <!-- 第三处 -->
  <input type="button" value="Click" />
</template>
```
现在，当你启动你的应用的时候，你将会看到如下的信息。（不要在意红色的字）

**译者注：因为hexo的markdown解析问题，所以请用以下的代码分别替换3处注释内容,请手动去掉两个大括号之间的空格**
* 第一处{ {> hello} }
* 第二处{ {greeting} }
* 第三处{ {> loginButtons} }
![初始界面](http://phishingw.qiniudn.com/GNOR8BK.png)

添加登录的处理方式
====================
现在，我们需要为我们的管理认证系统注册一个登录的方法。下面是一个创建在`server/admin.js`的服务端函数。
```javascript
Accounts.registerLoginHandler(function(loginRequest) {
  //Meteor中有多个登录模块 
  //一个登录的请求需要通过所有的这些登录模块来寻找它所需要的模块
  //所以，在我们这个登录模块中，我们只需要考虑登录的请求中含有admin字段请求
  if(!loginRequest.admin) {
  	//如果不含有admin字段，则return出去
    return undefined;
  }

  //这里是我们的认证逻辑
  if(loginRequest.password != 'admin-password') {
    return null;
  }
  
  //如果不存在管理帐号，则创建一个，并获取到userId
  var userId = null;
  var user = Meteor.users.findOne({username: 'admin'});
  if(!user) {
    userId = Meteor.users.insert({username: 'admin'});
  } else {
    userId = user._id;
  }

  //发送登录者的userId
  return {
    id: userId
  }
});
```

现在简单的登录函数已经写完了

添加客户端的登录函数
=================
新建`client/admin.js`文件，将以下代码写入其中：
```javascript
Meteor.loginAsAdmin = function(password, callback) {
  //新建一个带有admin:true的请求，从而让我们的登录模块来处理这个请求
  var loginRequest = {admin: true, password: password};

  //发送登录的请求
  Accounts.callLoginMethod({
    methodArguments: [loginRequest],
    userCallback: callback
  });
};
```
现在我们就能添加我们的管理员登录系统。在浏览器的console界面中调用`loginAsAdmin`方法，然后你会看到你已经登录进去了
```javascript
//在浏览器的console中调用
Meteor.loginAsAdmin('admin-password');
```
![登录成功](http://phishingw.qiniudn.com/jEa7ZJW.png)

刷新浏览器
================
当你刷新你的浏览器的时候，你会发现你并没有继续处于登录状态。那是因为你没有在登录的时候没有添加一个记录token的功能。
用以下的代码来更新`server/admin.js`
```javascript
Accounts.registerLoginHandler(function(loginRequest) {
  if(!loginRequest.admin) {
    return undefined;
  }

  if(loginRequest.password != 'admin-password') {
    return null;
  }
  
  var userId = null;
  var user = Meteor.users.findOne({username: 'admin'});
  if(!user) {
    userId = Meteor.users.insert({username: 'admin'});
  } else {
    userId = user._id;
  }
  //以上代码无变化

  //创建一个token并记录在user中
  var stampedToken = Accounts._generateStampedLoginToken();
  //在Meteor 0.7.x中就已经添加了对hash算法的支持 
  //在Meteor 0.7.x之前的版本你就不需要做这样的处理
  var hashStampedToken = Accounts._hashStampedToken(stampedToken);
  
  Meteor.users.update(userId, 
    {$push: {'services.resume.loginTokens': hashStampedToken}}
  );

  //把token和userId一并返回
  return {
    id: userId,
    token: stampedToken.token
  }
});
```
这段代码就能解决刷新后自动退出登录状态的问题了

总结
===========================
现在我们来总结一下我们已经做的事情
* 我们尝试着为我们的应用做了一个管理登录系统
* 为其添加了登录模块
* 添加了一个客户端的登录方法
* 添加了刷新token

你可以从Github上来下载[源代码](https://github.com/arunoda/meteor-custom-authentication-system)
这样是不是很简单的就能为Meteor应用添加一个新的认证系统货方法了？：）













