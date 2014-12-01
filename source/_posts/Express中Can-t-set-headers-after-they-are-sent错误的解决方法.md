title: "Express中Can't set headers after they are sent错误的解决方法"
date: 2014-11-27 23:01:00
categories: 技术
tags: [nodejs, express]
---
我在实际开发中遇到了`express`的如下报错
```
Error: Can't set headers after they are sent.
  at ServerResponse.OutgoingMessage.setHeader (_http_outgoing.js:331:11)
  at ServerResponse.res.setHeader (/Users/phishing/Documents/Phishing/test/drifter/node_modules/express/node_modules/connect/lib/patch.js:134:22)
  at ServerResponse.res.set.res.header (/Users/phishing/Documents/Phishing/test/drifter/node_modules/express/lib/response.js:583:10)
  at ServerResponse.res.send (/Users/phishing/Documents/Phishing/test/drifter/node_modules/express/lib/response.js:144:12)
  at ServerResponse.res.json (/Users/phishing/Documents/Phishing/test/drifter/node_modules/express/lib/response.js:225:15)
  at /Users/phishing/Documents/Phishing/test/drifter/app.coffee:41:16
  at Promise.<anonymous> (/Users/phishing/Documents/Phishing/test/drifter/models/mongodb.coffee:25:3)
  at Promise.<anonymous> (/Users/phishing/Documents/Phishing/test/drifter/node_modules/mongoose/node_modules/mpromise/lib/promise.js:177:8)
  at Promise.EventEmitter.emit (events.js:110:17)
  at Promise.emit (/Users/phishing/Documents/Phishing/test/drifter/node_modules/mongoose/node_modules/mpromise/lib/promise.js:84:38)
  at Promise.fulfill (/Users/phishing/Documents/Phishing/test/drifter/node_modules/mongoose/node_modules/mpromise/lib/promise.js:97:20)
  at handleSave (/Users/phishing/Documents/Phishing/test/drifter/node_modules/mongoose/lib/model.js:133:13)
  at /Users/phishing/Documents/Phishing/test/drifter/node_modules/mongoose/lib/utils.js:408:16
  at /Users/phishing/Documents/Phishing/test/drifter/node_modules/mongoose/node_modules/mongodb/lib/mongodb/collection/core.js:125:9
  at /Users/phishing/Documents/Phishing/test/drifter/node_modules/mongoose/node_modules/mongodb/lib/mongodb/db.js:1157:7
  at /Users/phishing/Documents/Phishing/test/drifter/node_modules/mongoose/node_modules/mongodb/lib/mongodb/db.js:1890:9
  at Server.Base._callHandler (/Users/phishing/Documents/Phishing/test/drifter/node_modules/mongoose/node_modules/mongodb/lib/mongodb/connection/base.js:448:41)
  at /Users/phishing/Documents/Phishing/test/drifter/node_modules/mongoose/node_modules/mongodb/lib/mongodb/connection/server.js:481:18
  at [object Object].MongoReply.parseBody (/Users/phishing/Documents/Phishing/test/drifter/node_modules/mongoose/node_modules/mongodb/lib/mongodb/responses/mongo_reply.js:68:5)
  at [object Object].<anonymous> (/Users/phishing/Documents/Phishing/test/drifter/node_modules/mongoose/node_modules/mongodb/lib/mongodb/connection/server.js:439:20)
  at [object Object].EventEmitter.emit (events.js:107:17)
  at [object Object].<anonymous> (/Users/phishing/Documents/Phishing/test/drifter/node_modules/mongoose/node_modules/mongodb/lib/mongodb/connection/connection_pool.js:201:13)
  at [object Object].EventEmitter.emit (events.js:110:17)
  at Socket.<anonymous> (/Users/phishing/Documents/Phishing/test/drifter/node_modules/mongoose/node_modules/mongodb/lib/mongodb/connection/connection.js:439:22)
  at Socket.EventEmitter.emit (events.js:107:17)
  at readableAddChunk (_stream_readable.js:159:16)
  at Socket.Readable.push (_stream_readable.js:126:10)
  at TCP.onread (net.js:514:20)
```
经查找后发现，是因为我在路由中触发了两次`res.json`

在`nodeJs实战`一书中的132页，在使用mongo储存瓶子之后，原作者只`return`出了`mongodb.save`函数，导致最后的`res.json(callback)`仍然执行，触发了上述错误

解决办法很简单，只需在`mongodb.save`前面加一个'return'即可