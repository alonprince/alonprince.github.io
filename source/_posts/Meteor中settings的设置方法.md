title: Meteor中settings的设置方法
date: 2014-10-09 14:30:57
categories: 技术
tags: Meteor
---

在Meteor的实际开发中，可能会针对不同的服务器做相关的设置，但如果每次都是改源代码会显得很麻烦，也容易出错，于是Meteor.settings就横空出世了

Meteor.settings的设置很简单

首先在更目录下新建一个`settings.json`文件

在文件中写入

```json
{
	"foo": "bar"
}
```

然后在命令行中输入`meteor --settings settings.json`来启动项目，或者通过`meteor deploy --settings settings.json`来部署项目

这样在Meteor的server端中键入`console.log(Meteor.settings.foo)`就会返回'bar'

需要注意的就是，在`settings.json`中，一定要用严格的json格式，不能使用单引号，不然会出现`parse error reading settings file`的错误

例如我正在写一个关于ldap的配置，具体信息如下
```json
{
	"ldap": {
	    "url": "ldap://my.ldapserver.com",
	    "base": "ou=people,dc=mydomain",
	    "timeout": 10000,
	    "bindDn": "cn=admin,dc=mydomain",
	    "bindSecret": "thesecret",
	    "filter": "(&(uid=%uid)(objectClass=inetOrgPerson))",
	    "scope": "one",
	    "nameAttribute": "displayName",
	    "mailAttribute": "mail",
	    "forceUsername": true,
	    "throwError": true,
	    "supportedServices": ["cas"]
  	}
}
```

这样写之后，你用`meteor --settings settings.json`来运行，打印你的`Meteor.settings`就能看见相关设置的信息了

