这个问题得问那些CPAN上的名人，那些人更能准确知道这些信息，咱们能关注一下他们的言论，及时掌握一些技术信息就已经不错了
我最近关注Tatsuhiko Miyagawa也比较多，必须承认，Perl在膏药国异常流行。我觉得前沿的Perl WEB技术盯着点Tatsuhiko就不会走错方向，他拥护AnyEvent，又掌握着很多重要技术的发展，所以就有了Twiggy这样优秀的PSGI模块。

我有一部分工作是web相关的，dancer很好用，但很多时候需要基于事件的控制来实现一些和服务器交互的功能，这个dancer本身不支持异步，我就这么找到了Twiggy，Twiggy+AnyEvent，真是想干嘛干嘛。

我的另一部分工作是数据挖据和日志处理相关的，这部分我也是事件框架来做，并且Coro也发挥了作用，Coro和AnyEvent是一个作者写的，两者融合的会更好。

我还有一部分工作是网络通信，XML/SOAP之类，多线程发送和接受请求，这部分我也是AnyEvent+Coro来做。

综上所述，我最终选择了AnyEvent。

PS。感谢楼上的扶凯，你的博客给了我很多启发。另外，不认为这帖子会火，Perl在国内太小众，基于事件编程就更小众了，没什么人关心AnyEvent到底干什么的。。。





有一个trick ， 就是xml 的解析，如果只是需要一个xml 的某些标签的content ，可以不用xml 解析器去把整个xml 解析出来，而是直接用正则把需要的字段抽出来即可，效率相差数量级啊！！还有一个就是memcache 的使用经验，我也曾经犯过这个错，就是分配给memcache 的内存，并不是都可以用于存储的，例如100k data block 会分配一定数目的桶，200k 300k 亦然，当大量小object 占满了100k 的桶子时，memcache 就会根据算法置换一些旧object 出去，也就会出现，分配的512M 内存都没有用完，但就经常miss cache 的情况了。他们说了一点：优化重视细节，但切忌过早过度优化，一开始设计很大，但其实最先出现问题的往往没有考虑过的地方。我也曾经一度陷入这个怪圈，但其实真的没有必要一开始考虑得太多，有时候船到桥头自然直。我现在多数关注的是瓶颈的方面了。
