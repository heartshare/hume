这个问题得问那些CPAN上的名人，那些人更能准确知道这些信息，咱们能关注一下他们的言论，及时掌握一些技术信息就已经不错了
我最近关注Tatsuhiko Miyagawa也比较多，必须承认，Perl在膏药国异常流行。我觉得前沿的Perl WEB技术盯着点Tatsuhiko就不会走错方向，他拥护AnyEvent，又掌握着很多重要技术的发展，所以就有了Twiggy这样优秀的PSGI模块。

我有一部分工作是web相关的，dancer很好用，但很多时候需要基于事件的控制来实现一些和服务器交互的功能，这个dancer本身不支持异步，我就这么找到了Twiggy，Twiggy+AnyEvent，真是想干嘛干嘛。

我的另一部分工作是数据挖据和日志处理相关的，这部分我也是事件框架来做，并且Coro也发挥了作用，Coro和AnyEvent是一个作者写的，两者融合的会更好。

我还有一部分工作是网络通信，XML/SOAP之类，多线程发送和接受请求，这部分我也是AnyEvent+Coro来做。

综上所述，我最终选择了AnyEvent。

PS。感谢楼上的扶凯，你的博客给了我很多启发。另外，不认为这帖子会火，Perl在国内太小众，基于事件编程就更小众了，没什么人关心AnyEvent到底干什么的。。。
