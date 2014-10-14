title: git命令小记
date: 2014-10-03 12:28:25
categories: 技术
tags: git
---

###简要说明

刚刚接触git，一直都不会用git，因为之前用的都是svn，目前正在学习nodejs，所以想把写的练习同步到github上，就查了下用法

###初始化
git的初始化是
```
$ git init
```
这样系统就在当前目录生成了一个``.git``目录

首次使用``git``你可能还需要配置一下``git``

你可以使用以下命令来配置你``git``的常用昵称和邮箱
```
$ git config --global user.name "Phishing"
$ git config --global user.email "yourname@xxx.com"
```

###添加文件

初始化以后，就需要开始添加你想要添加的文件进入git仓库了

你可以使用``git add``这个命令来添加
例如
```
$ git add *.js
$ git add *.html
$ git add package.json
$ git add README.md
```

这样你就把以上文件加入到了git监控的目录里面了

当然在实际工作中，有些文件是不需要提交到git的

你可以在当前目录中新建一个``.gitignore``文件

在里面添加你不需要监控的文件
```
node_modules/           //node的包，不需要传上去，文件夹后面加一个/，代表该文件夹被忽略
/test					//代表根目录下的test文件被忽略
.DS_store 				//代表.DS_store被忽略
```
查看当前git的状态可以使用``git status``

如果你没有添加上面的.gitignore的话，输入``git status``，git就会用红色高亮告诉你这几个文件是没有被加入git的监控中的，如果需要就使用``git add <filename>``来添加
加了.gitignore后，就不会再提示

###提交代码

文件添加成功后，就可以开始提交代码了

可以使用``git commit``来提交代码到git仓库中

如果之间键入``git commit``会提示你没有添加提交massage，你可以在弹出的文件中键入提交信息，然后退出编辑器，即自动提交

当然这样可能会有点麻烦，所以你可以利用``git commit -m 'your massage'``来在命令行中直接写入提交的信息

输入完后，git就会告诉你你当前git仓库里面的状态了

刚刚开始接触git的时候，我每改动一个文件，然后用``git status``来查看过后发现，我需要再键入一遍``git add <filename>``才能提交，这让我感觉非常麻烦

后来我终于知道有个快捷方式了，就是``git commit -a -m 'your massage'``，这样就能跳过``git add``这个步骤了，当然这样有好有坏，我就不细说了

###提交代码到远程仓库

提交代码到远程仓库时，你首先得新建一个``ssh key``，[具体方法在这里](https://help.github.com/articles/generating-ssh-keys/)

弄好ssh key之后，就可以使用

```
$ git remote origin git://your_github_address/your_repositores_name.git
```

来定义远程仓库的地址了

定义好之后就能使用
```
$ git push
```
来提交代码到远程仓库了

如果你是第一次提交代码，系统会提示你使用
```
$ git push --set-upstream origin master
```
来提交代码

以后你就可以修改代码然后使用
```
$ git commit -a -m 'your massage'
$ git push
```
来提交你的代码了：）

###最后

以上就是我这刚刚接触git的小白了解到的一些git的基本操作了，如有错误，还请指出

谢谢观看【捂脸下台






