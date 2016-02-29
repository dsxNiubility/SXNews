# SXNews
模仿网易新闻做的新闻软件<br />
图片较多但是为了清晰就采用了些大图和gif，加载耽误你时间请见谅，如果你的网速较慢请耐心等待。
###2月29日更新
#####说编译不能通过的看这里⬇️<br />
1.现在已经将工程分为三个分支，old分支即之前代码的保存，master分支将会进行后续框架性的修改，lightToDown分支剔除了字体资源图等文件包体积较小用于给网速不好的人下载。 如果你网速还好建议下载master分支包含所有功能19M左右。<br />
2.现在项目中的拖入的第三方库都改为Cocoapods支持了。包体积减小，但是拿到手后不能直接RUN需要先进行`pod install` 。如果你觉得麻烦 那就下载old分支的代码吧，下来直接能RUN。<br />

---
###2月4日更新

前两周接入了一个性能观测SDK做调研，虽然对比后公司项目最终还是用了自己的库（因为他们不能观察页面FPS和内存CPU指数），但是小型app接这个第三方的性能SDK还是挺直观的，接入简单并且项目的侵入性也不大。<br />
######1.先贴个SXNews的总览
总评分还好哈，统计的维度也是蛮多的，响应时间有的见红了，而且流量也挺大。
<img src="https://github.com/dsxNiubility/SXNews/raw/master/screenshots/generate.png" alt="Drawing" width="850px" />
######2.页面打开速度
本工程采用了storyboard，xib，手码，frame，autolayout等多种混合开发模式，单结果看来还没有太影响页面初始化和布局速度的地方。
<img src="https://github.com/dsxNiubility/SXNews/raw/master/screenshots/launch.png" alt="Drawing" width="850px" />
######3.用户量
用户量其实比我想象中的要多，我开始以为全国也就能够零星的亮几个省。可结果表明还是挺受欢迎的，虽然这个项目跨度有点长，虽然有页面也都是采用投机取巧写法写的都能做“反面教材”了，但是有一些点点滴滴的地方还是有点学习价值的。 除了西北，也就贵州和黑龙江没人上github了😂（开玩笑的）？
<img src="https://github.com/dsxNiubility/SXNews/raw/master/screenshots/active_china.png" alt="Drawing" width="850px" />
######4.世界地图
这个地域统计里可以看中国也可以看世界，美国和西班牙的友人也有玩过这个app的。（虽然可能是vpn...）
<img src="https://github.com/dsxNiubility/SXNews/raw/master/screenshots/active_world.png" alt="Drawing" width="850px" />
#####5.接口
接口响应速度感觉不太准，还有500万秒的导致把我的平均时长都拉高了，毕竟接口全是抓的网易的不怪我了。
<img src="https://github.com/dsxNiubility/SXNews/raw/master/screenshots/error.png" alt="Drawing" width="850px" />

---
###2月2日更新
这次主要是做了三点，上划返回——新闻搜索页——新闻详情页的丰富。
######1.上划返回
`在一个页面翻到最下面看完了之后直接上划，划到一定高度就可以返回上一页面了`
######2.新闻搜索
`网易新闻新增的新闻搜索功能。 你也许看过哪个非常精彩的新闻但是忘了收藏，仅仅记得大概名字就可以搜到了，这个功能非常实用。 因为之前右上角是天气的网易把它撤了改成搜索了，所以我只好把搜索放在左边了。`
######3.详情页丰富
`还有一点就是增加了，新闻详情页下面的部分。 现在网易支持在新闻详情页就可以进行回复了，所以在详情页下面就会展示热门评价，并且还有相关新闻，和相关关键字，点击会跳到搜索页搜索，并且更多评论相关新闻，还有新闻搜索都是可以点进去的`<br /><br />
<img src="https://github.com/dsxNiubility/SXNews/raw/master/screenshots/89.gif" alt="Drawing" width="200px" />x
<img src="https://github.com/dsxNiubility/SXNews/raw/master/screenshots/88.gif" alt="Drawing" width="200px" />x
<img src="https://github.com/dsxNiubility/SXNews/raw/master/screenshots/90.gif" alt="Drawing" width="200px" />

---
###9月28日更新
_适配了iOS9_<br />
_(如果模拟器仍有问题请使用真机调试)_<br />
_新增了广告功能_<br />
_(和网易广告一样，都是这次启动下载广告图片，下一次启动时展示）_<br />
_(请求里带了时间戳每天的广告都会不同)_<br />
<img src="https://github.com/dsxNiubility/SXNews/raw/master/screenshots/68.gif" alt="Drawing" width="200px" />

---
###8月24日更新
_加载gif动图可能较慢请耐心等待_<br />
<img src="https://github.com/dsxNiubility/SXNews/raw/master/screenshots/66.gif" alt="Drawing" width="200px" />xxxxx
<img src="https://github.com/dsxNiubility/SXNews/raw/master/screenshots/65.gif" alt="Drawing" width="200px" />

>1.这次更新的亮点是添加了天气效果以后也可以用网易新闻看天气预报了，各种轻微的动画效果也没有放过。<br />
<img src="https://github.com/dsxNiubility/SXNews/raw/master/screenshots/015.png" alt="Drawing" width="375px" />
<img src="https://github.com/dsxNiubility/SXNews/raw/master/screenshots/016.png" alt="Drawing" width="375px" />


>2.新版的网易新闻，整改了首页UI，在底部加上了tabbar，因此多了很多页面这里也都编了，但是无法交互。毕竟东西太多了，我觉得能点击看到效果就算不能进一步深入，就一个壳子也比全空没有强是吧。。<br />
![image](https://github.com/dsxNiubility/SXNews/raw/master/screenshots/309.png)<br /><br />


>3.主页-主页的下方加了tabbar，nav的两个按钮做了改变<br />
<img src="https://github.com/dsxNiubility/SXNews/raw/master/screenshots/011.png" alt="Drawing" width="375px" /><br /><br />
>4.详情页-详情页对细节的处理更加注意，如以前有人反馈的评论数不对问题已修复，并且以前会出现某条新闻点进去没评论，这个问题也找到了原因，并彻底修复。<br />
<img src="https://github.com/dsxNiubility/SXNews/raw/master/screenshots/012.png" alt="Drawing" width="375px" /><br /><br />
>5.图集页-图集页无大改，现在图集的评论用的还是假数据，但是后面会陆续完善<br />
<img src="https://github.com/dsxNiubility/SXNews/raw/master/screenshots/014.png" alt="Drawing" width="375px" /><br /><br />
>6.评论页-评论页对细节修改很多，如果以前玩过本项目的会发现现在评论页已经没有较乱得细节了都改了。<br />
<img src="https://github.com/dsxNiubility/SXNews/raw/master/screenshots/013.png" alt="Drawing" width="375px" /><br /><br />



---
###旧版回顾

精仿的网易新闻。笔者工作之余，对着网易UI，扒网易图片素材，抓取网易接口等做的。里面完成了主导航页，新闻详情页，图片浏览页，评论页。效果不错，比网上流传的各种和网易新闻UI架构有关的代码都要完整，都要好。

>1.主导航页面主要功能点是在顶部的标题栏可以滑动，scrowView和collectionView的循环利(之前版本)用并且在点击标题栏或是，手势滑动的时候，下面的页面都会滑到当前的页面。 并且新闻模块是懒加载的，你要看哪几个页面他才会加载。这是通过控制scrowView的两个手势停止的代理方法来实现的。 下面的新闻模块提供了4种自定义的cell，通过对数据的解析，来判断改加载到哪种自定义cell中。 结果让主页显得很丰富。<br /><br />

>2.关于新闻详情页，网易原本的接口在上一个页面返回的数据中既有一个url地址，也有一个xml的字符串，url地址展示后不美观，所以做法是将xml格式的字符串解析并在webView中展示，这其中做到了图文混排并设置了css样式。本页面主要的亮点是JS代码与OC代码间的传值。在webview中点击图片后下面弹出可以保存的式样，这是控制一个页面重定向方法拦截发出的请求来实现的。<br /><br />

>3.评论页相对较为简单，就是普通的自定义cell。控制好自定义的行高就没有问题了。关于用户介绍的那个label可以用正则过滤下的，不过写这玩意主要精力都在核心功能上这里就没仔细弄了。<br /><br />

>4.图片查看器页面也是基本达到了模仿的效果，下面的文字和9/16等样式都是通过scrowView的偏移量动态计算的，并且和首页一样也是懒加载图片的方式，在图片下载中还未显示时会有一个网易的占位图片。<br /><br />

* 本项目还用到了上拉加载下拉刷新和一些关于父子控制器嵌套和自定义导航栏等技术知识，这些对平时的开发也是有一定帮助的。

`不定时更新 欢迎点星。`

