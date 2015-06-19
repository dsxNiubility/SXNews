# SXNews
模仿网易新闻做的新闻软件

---

精仿的网易新闻。笔者工作之余，对着网易UI，扒网易图片素材，抓取网易接口等做的。里面完成了主导航页，新闻详情页，图片浏览页，评论页。效果不错，比网上流传的各种和网易新闻UI架构有关的代码都要完整，都要好。

![image](https://github.com/dsxNiubility/SXNews/raw/master/screenshots/news1.png)

>主导航页面主要功能点是在顶部的标题栏可以滑动，scrowView和collectionView的循环利用并且在点击标题栏或是，手势滑动的时候，下面的页面都会滑到当前的页面。 并且新闻模块是懒加载的，你要看哪几个页面他才会加载。这是通过控制scrowView的两个手势停止的代理方法来实现的。 下面的新闻模块提供了4种自定义的cell，通过对数据的解析，来判断改加载到哪种自定义cell中。 结果让主页显得很丰富。

![image](https://github.com/dsxNiubility/SXNews/raw/master/screenshots/news2.png)

>关于新闻详情页，网易原本的接口在上一个页面返回的数据中既有一个url地址，也有一个xml的字符串，url地址展示后不美观，所以做法是将xml格式的字符串解析并在webView中展示，这其中做到了图文混排并设置了css样式。本页面主要的亮点是JS代码与OC代码间的传值。在webview中点击图片后下面弹出可以保存的式样，这是控制一个页面重定向方法拦截发出的请求来实现的。

![image](https://github.com/dsxNiubility/SXNews/raw/master/screenshots/news3.png)

>评论页相对较为简单，就是普通的自定义cell。控制好自定义的行高就没有问题了。关于用户介绍的那个label可以用正则过滤下的，不过写这玩意主要精力都在核心功能上这里就没仔细弄了。

![image](https://github.com/dsxNiubility/SXNews/raw/master/screenshots/news4.png)

>图片查看器页面也是基本达到了模仿的效果，下面的文字和9/16等样式都是通过scrowView的偏移量动态计算的，并且和首页一样也是懒加载图片的方式，在图片下载中还未显示时会有一个网易的占位图片。

* 本项目还用到了上拉加载下拉刷新和一些关于父子控制器嵌套和自定义导航栏等技术知识，这些对平时的开发也是有一定帮助的。

`不定时更新 欢迎点星。`

