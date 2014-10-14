title: 关于在Meteor中写自定义登录需要注意的地方
date: 2014-10-13 22:19:06
categories: 技术
tags: Meteor
---

上一篇博文翻译了Meteorhack的一篇关于如何编写自定义登录方式之后，对`Meteor`的'Accounts'模块有了一定的认识，为在实际工作中提供了理论知识

通过这几天在编写自定义登录模块的摸爬滚打之后，也逐渐开始遇到了一些问题

问题一-------第三方登录和原有登录系统冲突
==========================
我在编写登录模块的时候，由于系统本身已经添加了`accounts-password`包，在编写我自己的`registerLoginHandler`之后，会优先去执行`accounts-password`包里面的函数，导致每次我调用登录模块，换来的都是`Match failed`的错误

我通过查看`accounts-password`包的[源码](https://github.com/meteor/meteor/blob/devel/packages%2Faccounts-password%2Fpassword_server.js#L140)之后，我发现，`accounts-password`的登录逻辑里，会判断传入的`loginRequest`中是否含有`password`和`srp`，在0.8.1之前你只能用密码登录，所以提供了一种登录方法，在0.8.1之后，你还可以使用`srp`来登录，所以`Meteor`又写了另外一种登录方法

通过查看发现，是否调用`accounts-password`的关键在于，你是否传递了`password`和`srp`，通过改进后，我把`loginRequest`传入的key从`password`更改成了`ldap_password`，更改之后，就能绕过`accounts-password`包的登录机制了

问题二---------关于调用Accounts.callLoginMethod方法中的methodName
=======================
这个问题一直困扰我，我在`registerLoginHandler`的时候，给我的method声明了名称，但是在实际调用中，我给`Accounts.callLoginMethod`传递了`methodName`却提示我`method not found`的错误，这问题有待解决



先只写这么多，等我第三方登录模块写完之后，应该会写一个介绍`ldapjs`的博文