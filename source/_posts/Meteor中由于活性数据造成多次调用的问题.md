title: Meteor中由于活性数据造成多次调用的问题
date: 2014-11-20 00:24:06
categories:
tags:
---
在`meteor`的开发中，我们经常会遇到一个模板的`helper`中的某一个变量的计算过程中，使用了活性数据，例如`Collection.find`、`Session.get('key')`之类的。由于这些值默认为活性数据，也就是说当这些值发生改变的时候，引用了活性数据的变量就会重新计算一次，如若这个变量逻辑很复杂，则是一件十分耗性能的事情。

举个例子，我在开发过程中遇到过这种情况。我前台算好了一个数据，然后去后台订阅数据回来，我在某一个模板的`helper`中使用了`find`去查询取回来的数据，但是我的订阅是动态订阅的，所以我这个`helper`就会不停的重复调用，甚至是在我数据还没订阅回来，在订阅过程中就在不停的调用，这显然是不太好的地方。

例如这样的代码

client/subscribe.js
```javascript
var day = new Date().getDay()
Meteor.subscribe('comment', {
	day: day
})
```

client/view/index.html
```html
<template name="index">
	{% raw %}{{#each comments}}{% endraw %}
		{% raw %}<p>{{content}}</p>{% endraw %}
	{% raw %}{{/each}}{% endraw %}
</template>
```

client/view/index.js
```javascript
Template.index.helper({
	'comments': function() {
		return Comment.find()
	}
})
```

如果这个时候很不巧，正好刚刚过了零点，那么订阅的数据就会发生更改，导致`Comment.find`的值在不停的更改，就会不断触发`comments`这个`helper`在**订阅数据还未完成**的情况下重复计算，为了解决这样的情况，我使用了以下方法：

client/subscribe.js
```javascript
var day = new Date().getDay()
Meteor.isReady = Meteor.subscribe('comment', {
	day: day
})
```

client/view/index.js
```javascript
Template.index.helper({
	'comments': function() {
		// 用订阅的ready状态来判断是否返回，避免正在订阅的时候也继续计算
		if(Meteor.isReady.ready()) {
			return Comment.find()
		}
	}
})
```

这个例子太简单，而且也没有很形象的重现出遇到的问题，在实际开发过程中，代码远比这要复杂的多，而且我在使用中会出现`Meteor.isReady.ready()`状态值不是实时更新，或没有活性跟踪的情况，不知道这是因为bug还是我的代码写的有问题，在不得已的情况下，我把上述例子改成了

client/subscribe.js
```javascript
var day = new Date().getDay()
Meteor.isReady = Meteor.subscribe('comment', {
	day: day
})
Session.set('isReady',Meteor.isReady.ready())
```

client/view/index.js
```javascript
Template.index.helper({
	'comments': function() {
		// 用订阅的ready状态来判断是否返回，避免正在订阅的时候也继续计算
		if(Session.get('isReady')) {
			return Comment.find()
		}
	}
})
```

Meteor在实际开发中还是有很多问题，有无数的坑等着去填(╯‵□′)╯︵┻━┻

