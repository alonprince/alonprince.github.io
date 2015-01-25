title: Ionic中使用emulate android报错的问题
categories: 技术
date: 2015-01-24 23:18:42
tags: [hybird app, ionic]
---

我在预览Android应用的时候，发现不能正常预览，弹出错误，提示类似让我创建一个Android服务之类的错误，提示我使用`android create avd --name <yourname> --target <targetId>`来创建

在百度了之后，发现创建方法如下：

```
$ Android list targets
```

会列出如下列表：

```
----------
id: 1 or "android-8"
     Name: Android 2.2
     Type: Platform
     API level: 8
     Revision: 3
     Skins: HVGA, QVGA, WQVGA400, WQVGA432, WVGA800 (default), WVGA854
 Tag/ABIs : default/armeabi
----------
id: 2 or "android-19"
     Name: Android 4.4.2
     Type: Platform
     API level: 19
     Revision: 3
     Skins: HVGA, QVGA, WQVGA400, WQVGA432, WSVGA, WVGA800 (default), WVGA854, WXGA720, WXGA800, WXGA800-7in
 Tag/ABIs : default/armeabi-v7a
----------
id: 3 or "Google Inc.:Google APIs:8"
     Name: Google APIs
     Type: Add-On
     Vendor: Google Inc.
     Revision: 2
     Description: Android + Google APIs
     Based on Android 2.2 (API level 8)
     Libraries:
      * com.google.android.maps (maps.jar)
          API for Google Maps
     Skins: HVGA, WQVGA400, QVGA, WVGA800 (default), WQVGA432, WVGA854
 Tag/ABIs : default/armeabi
```

然后选好你需要的Android平台版本，记住id，创建即可，我使用的是平台版本为4.4.2的，即targetid为2

```
$ android create avd --name test --target 2
```

创建好后，再使用

```
$ ionic emulate android
```
即可成功预览咯
PS:安卓虚拟机可真是卡顿的没话说啊。。。