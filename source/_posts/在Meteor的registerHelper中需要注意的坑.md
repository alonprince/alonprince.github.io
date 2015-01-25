title: 在Meteor的Template.helper中需要注意的坑
date: 2014-12-02 11:15:57
categories: 技术
tags: Meteor
---
问题详情
======
在`Meteor`中，由于某些特性，会使`{% raw %}{{foo bar}}{% endraw /%}`配合`registerHelper`变得很便捷，用起来很舒服

但是这东西会有些小坑，这些小坑是API中未曾提到的（可能是我没看到）

从`Meteor 0.6`起，`registerHelper`这个方法已经换了好几个绑定的对象了，从最开始的`Handerbars.registerHelper`到`UI.registerHelper`再到`Blaze.registerHelper`最后到现在的`Template.registerHelper`，整个人都凌乱了好吗！

`registerHelper`的用法是`Template.registerHelper(name, function)`，`function`中传递的参数就是调用时`{% raw %}{{ foo bar}}{% endraw /%}`传递的参数，我在开发的时候遇到过这种问题，当我将`{% raw %}{{foo bar}}{% endraw /%}`中传递进来的参数取名叫`kind`的时候，即`{% raw %}{{foo kind}}{% endraw /%}`，就会发生意想不到的事情

定义：
```javascript
Template.registerHelper('foo', function(bar) {
	console.log(bar)
})
```

调用：

```html
<template name="index">
	{% raw %}{{#with obj}}{% endraw %}
		<p>{% raw %}{{foo kind}}{% endraw %}</p>
	{% raw %}{{/with}}{% endraw %}
</template>
```
```javascript
Template.index.obj = {
	kind: 'bar'
}
```
结果`bar`打印出来的结果不是`'bar'`，而是`'Template_index'`，也就是说，当`{% raw %}{{foo kind}}{% endraw %}`的形参起名叫`'kind'`的时候，实参传递到这个形参上的值，不是实参的值，而是`'Template_' + 模板的名字`

解决办法
=====
把`kind`换成其他名字(❁´▽`❁)