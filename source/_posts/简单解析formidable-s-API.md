title: 简单解析formidable's API
date: 2014-10-16 12:01:05
categories: 技术
tags: nodejs
---

本文翻译自`github`上的[Formidable的官方页面](https://github.com/felixge/node-formidable#events)

介绍
=================
一个用来解析数据，特别是上传数据的nodejs模块

安装
=========
这是一个底层的包，如果你使用的是一个高级的类似`Express`的框架，你可以通过阅读[这里](http://stackoverflow.com/questions/11295554/how-to-disable-express-bodyparser-for-file-uploads-node-js)来了解如何在`Express`来使用`Formidable`。

你可以使用`npm`来安装:
```
npm install formidable@latest
```

或者手动安装：
```
git clone git://github.com/felixge/node-formidable.git formidable
vim my.js
# var formidable = require('./formidable');
```

注意：Formidable应用了[gently](http://github.com/felixge/node-gently)来运行单元测试，但是你没必要使用它

例子
===========
解析一个文件上传
```
var formidable = require('formidable'),
    http = require('http'),
    util = require('util');

http.createServer(function(req, res) {
  if (req.url == '/upload' && req.method.toLowerCase() == 'post') {
    // 解析文件上传
    var form = new formidable.IncomingForm();

    form.parse(req, function(err, fields, files) {
      res.writeHead(200, {'content-type': 'text/plain'});
      res.write('received upload:\n\n');
      res.end(util.inspect({fields: fields, files: files}));
    });

    return;
  }

  // 展示一个文件上传表单
  res.writeHead(200, {'content-type': 'text/html'});
  res.end(
    '<form action="/upload" enctype="multipart/form-data" method="post">'+
    '<input type="text" name="title"><br>'+
    '<input type="file" name="upload" multiple="multiple"><br>'+
    '<input type="submit" value="Upload">'+
    '</form>'
  );
}).listen(8080);
```

API
==============
### Formidable.IncomingForm

```
var form = new formidable.IncomingForm()
```
新建一个传入表单的对象

```
form.encoding = 'utf-8'
```
设置上传表单域的编码

```
form.uploadDir = '/my/dir'
```
设置文件上传的目录，稍后你可以使用`fs.rename()`来更改它。默认值为`os.tmpDir()`。

```
form.keepExtensions = false
```
如果你想上传的文件保留扩展名，把这一项设置为`true`

```
form.type
```
根据请求来判断的编码类型

```
form.maxFieldsSize = 2 * 1024 * 1024
```
限制分配给处理域的内存大小，如果分配的值超过这个数值，则`error`时间将会被触发，默认值为2MB。

```
form.maxFields = 1000
```
限制域中解码查询语句的个数。默认值为1000

```
form.hash = false
```
如果你想对传入的文件进行校验，请设置该属性为`sha1`或者`md5`

```
form.multiples = false
```
开启这个选项后，你就能使用HTML5的多文件上传功能了，调用`form.parse`时传入的就是一个文件的数组

```
form.bytesReceived
```
从表单获取到的字节数

```
form.bytesExpected
```
预计还剩的字节数

```
form.parse(request, [cb])
```
从一个node.js上传请求数据中解析内容。如果有`cb`传入，所有的文件和请求将会传递到这个callback,例如:
```
form.parse(req, function(err, fields, files) {
	// ...
});

form.onPart(part);
```
如果你想直接访问`multipart stream`，你可以覆盖掉这个方法。但是这么做之后会禁用掉`field`/`file`事件处理。

如果你想用Formidable来处理某些文件，你可以这么做：
```
form.onPart = function(part) {
  if (!part.filename) {
    // let formidable handle all non-file parts
    form.handlePart(part);
  }
}
```

###Formidable.File
```
file.size = 0
```
上传文件的大小，单位是bytes，如果文件还在上传中（如在`fileBegin`事件中）,这个数值将会告诉你有多少字节被写入了硬盘

```
file.path = null
```
当前文件的被写入的路径。如果你不想把你的文件放入设置的公共路径，你可以在`fileBegin`事件中更改这个值

```
file.name = null
```
根据客户端获取到的文件上传后的名字

```
file.type = null
```
根据客户端获取到的文件上传后的`mine`类型
```
file.lastModifiedDate = null
```
文件最后被更改的时间对象

```
file.hash = null
```
得到经过hash计算后的十六进制值

####Formidable.File#toJSON()
这个方法返回一个表示文件的JSON数据，可以使用`JSON.stringify()`来使用它去记录日志或者响应请求

事件
===========
####'progress'
```
form.on('progress', function(bytesReceived, bytesExpected) {
});
```
发生在每一个数据传入的块被解析之后，可以用来实现进度条
####'field'
```
form.on('field', function(name, value) {
});
```
####'fileBegin'
每当一个域或者键值对被接受到的时候
```
form.on('fileBegin', function(name, file) {
});
```

####'file'
当一个新的文件在上传流中被检测到的时候触发。 Use this even if you want to stream the file to somewhere else while buffering the upload on the file system.(没理解T_T)

每当一个文件被接收的时候触发，`file`是`File`的实例
```
form.on('file', function(name, file) {
});
```
####'error'
当有表单处理错误的时候触发，请求会自动暂停，如果你需要继续触发`data`事件，你需要手动调用`request.resume()`
```
form.on('error', function(err) {
});
```
####'aborted'
当用户使请求终止的时候触发，现在这个事件是由`socket`的`close`和`timeout`共同触发的，将来会把`timeout`给独立出来(这需要更改node的核心)。
```
form.on('aborted', function(){
});
```
####'end'
```
form.on('end',function() {
});
```
当整个请求被接收完并写入磁盘后触发。这里就是你返回数据的一个好地方。

译者注
======
小白前端一枚，对该模块不了解的情况下翻译，本意是为了辅助自己更好的理解该模块，如有错误，请指出，谢谢。



















