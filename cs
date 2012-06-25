（一） MapReduce以及数据处理

（1） 基本结构和Hadoop的开源实现

（2） Hive: 在Hadoop上的数据仓库

（3） YSmart: 优化Hadoop的数据处理

（二） 大数据在分布式系统上的存储结构

（1） RCFile: 设计与实现

（2） 存储结构中优化问题

（3） RCFile的应用范围

(三） 内存和磁盘管理中的核心技术: 替换算法

（1） LRU算法优点以及难以解决的问题

（2） LIRS算法是如何解决LRU问题的

（3） Clock-pro: LIRS是如何实现在操作系统内核的

（4） BP-wrapper:消除替换算法在系统实现中的同步竟争

（四） 提高操作系统对磁盘的管理功能和效率

（1） 操作系统对磁盘管理的局限性

（2） 扩大操作系统的视野去获得关键的磁盘数据存储地址信息

（3） DULO-Caching和DULO-Prefetchin:感知磁盘数据分布的缓存(Caching)和预取
(Prefetching)方法以及系统实现

（五） 固态闪存系统(Solid State Device Flash Memory)

（1） SSD Flash Memory的结构和性能

（2） SSD的并行性和它在整个存储系统中的作用

（3） Hystor: 一个混合型SSD的存储系统

(六） 在互联网上的数据管理和有效传输

（1） Stretched Exponential Distribution: 为什么P2P在互联网上是传输多媒体和社会
网通讯的一种最有效的方法
