# SXNews
模仿网易新闻做的新闻软件

###9月28日更新
_适配了iOS9_<br />
_(如果模拟器仍有问题请使用真机调试)_<br />
_新增了广告功能_<br />
_(和网易广告一样，都是这次启动下载广告图片，下一次启动时展示）_<br />
_(请求里带了时间戳每天的广告都会不同)_<br />
![image](https://github.com/dsxNiubility/SXNews/raw/master/screenshots/68.gif)<br />

###8月24日更新
_加载gif动图可能较慢请耐心等待_<br />
![image](https://github.com/dsxNiubility/SXNews/raw/master/screenshots/66.gif)
&nbsp![image](https://github.com/dsxNiubility/SXNews/raw/master/screenshots/65.gif)<br />

>1.这次更新的亮点是添加了天气效果以后也可以用网易新闻看天气预报了，各种轻微的动画效果也没有放过。

![image](https://github.com/dsxNiubility/SXNews/raw/master/screenshots/015.png)<br />
![image](https://github.com/dsxNiubility/SXNews/raw/master/screenshots/016.png)<br />



>2.新版的网易新闻，整改了首页UI，在底部加上了tabbar，因此多了很多页面这里也都编了，但是无法交互。毕竟东西太多了，我觉得能点击看到效果就算不能进一步深入，就一个壳子也比全空没有强是吧。。<br />
![image](https://github.com/dsxNiubility/SXNews/raw/master/screenshots/309.png)<br /><br />


>3.主页-主页的下方加了tabbar，nav的两个按钮做了改变<br />
![image](https://github.com/dsxNiubility/SXNews/raw/master/screenshots/011.png)<br /><br />
>4.详情页-详情页对细节的处理更加注意，如以前有人反馈的评论数不对问题已修复，并且以前会出现某条新闻点进去没评论，这个问题也找到了原因，并彻底修复。<br />
![image](https://github.com/dsxNiubility/SXNews/raw/master/screenshots/012.png)<br /><br />
>5.图集页-图集页无大改，现在图集的评论用的还是假数据，但是后面会陆续完善<br />
![image](https://github.com/dsxNiubility/SXNews/raw/master/screenshots/014.png)<br /><br />
>6.评论页-评论页对细节修改很多，如果以前玩过本项目的会发现现在评论页已经没有较乱得细节了都改了。<br />
![image](https://github.com/dsxNiubility/SXNews/raw/master/screenshots/013.png)<br /><br />



---
###旧版回顾

精仿的网易新闻。笔者工作之余，对着网易UI，扒网易图片素材，抓取网易接口等做的。里面完成了主导航页，新闻详情页，图片浏览页，评论页。效果不错，比网上流传的各种和网易新闻UI架构有关的代码都要完整，都要好。

>1.主导航页面主要功能点是在顶部的标题栏可以滑动，scrowView和collectionView的循环利(之前版本)用并且在点击标题栏或是，手势滑动的时候，下面的页面都会滑到当前的页面。 并且新闻模块是懒加载的，你要看哪几个页面他才会加载。这是通过控制scrowView的两个手势停止的代理方法来实现的。 下面的新闻模块提供了4种自定义的cell，通过对数据的解析，来判断改加载到哪种自定义cell中。 结果让主页显得很丰富。<br /><br />

>2.关于新闻详情页，网易原本的接口在上一个页面返回的数据中既有一个url地址，也有一个xml的字符串，url地址展示后不美观，所以做法是将xml格式的字符串解析并在webView中展示，这其中做到了图文混排并设置了css样式。本页面主要的亮点是JS代码与OC代码间的传值。在webview中点击图片后下面弹出可以保存的式样，这是控制一个页面重定向方法拦截发出的请求来实现的。<br /><br />

>3.评论页相对较为简单，就是普通的自定义cell。控制好自定义的行高就没有问题了。关于用户介绍的那个label可以用正则过滤下的，不过写这玩意主要精力都在核心功能上这里就没仔细弄了。<br /><br />

>4.图片查看器页面也是基本达到了模仿的效果，下面的文字和9/16等样式都是通过scrowView的偏移量动态计算的，并且和首页一样也是懒加载图片的方式，在图片下载中还未显示时会有一个网易的占位图片。<br /><br />

* 本项目还用到了上拉加载下拉刷新和一些关于父子控制器嵌套和自定义导航栏等技术知识，这些对平时的开发也是有一定帮助的。

`不定时更新 欢迎点星。`

