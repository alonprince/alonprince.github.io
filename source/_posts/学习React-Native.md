title: 学习React Native(Guide部分)
categories: 技术
tags:
  - React Native
  - iOS
date: 2015-04-08 23:13:01
---

本文为学习`React Native`的笔记整理而成，仅做个人备忘使用

样式
================

声明样式
-----------

在`React Native`中声明样式的方法如下：

```javascript
var styles = StyleSheet.create({
  base: {
    width: 38,
    height: 38,
  },
  background: {
    backgroundColor: '#222222',
  },
  active: {
    borderWidth: 2,
    borderColor: '#00ff00',
  },
});
```

使用`StyleSheet.create`来构造样式，传入对象作为参数。要确保值是定值且把模糊的类型转换成明确的数字类型。写完之后要保证每个只定义过一次。

使用样式
--------------

主要的使用方法即是给style属性赋值

```html
<Text style={styles.base} />
<View style={styles.background} />
```

也可以给style用数组赋值
```html
<View style={[styles.base, styles.background]} />
```

你可以在其间做一些判断

```
<View style={[style.base, this.state.active && styles.active]} />
```

如果非到不得已的情况，你还可以在style中添加对象，但这特别容易混淆，不建议你这么做

```
<View style={[styles.base, {
    width: this.state.width,
    height: this.state.width * this.state.aspectRatio
}]} />
```

传递style
--------------

为了使你指定的样式在你的组件中使用，你需要传递style，使用`View.propTypes.style`和`Text.propTypes.style`来传递，注意，你需要确认传递的仅可能是样式

```
var List = React.createClass({
  propTypes: {
    style: View.propTypes.style,
    elementStyle: View.propTypes.style,
  },
  render: function() {
    return (
      <View style={this.props.style}>
        {elements.map((element) =>
          <View style={[styles.element, this.props.elementStyle]} />
        )}
      </View>
    );
  }
});

// ... in another file ...
<List style={styles.list} elementStyle={styles.listElement} />
```

手势响应系统
===========

在手机上，手势响应比web上要复杂的多。一个触控可能经历好几个阶段才能定义出用于的意图。例如，app需要判定这个操作是在控件上上下滑动还是左右侧滑或是触碰。并且这些操作可能在操作的过程中更改，甚至存在多点触控的情况。

触摸响应系统使组件去判定这些触摸共同作用，并且不考虑附加的情况，例如父或子组件。
这个系统被定义在`ResponderEventPlugin.js`中。

最佳实践
------------