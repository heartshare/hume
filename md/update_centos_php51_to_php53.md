[升级CentOS 5.x中的PHP 5.1到5.3](http://zengrong.net/post/1595.htm)

<span style="color:red">2012-04-19 更新：</span>后来发现直接使用`yum install php53`，也能安装php，而且处于官方源中。所以可以先试试这个，不行再试下面的方法。

服务器版本为CentOS 5.8，自带的php为5.1.6。在配置phpMyAdmin的时候，发现必须要PHP 5.2才可以支持，但yum的源中并没有PHP 5.2，无法使用yum来升级。

首先按照[官方wiki](http://wiki.centos.org/HowTos/PHP_5.1_To_5.2)的说明进行了修改，结果没用，yum始终报告5.1.6是最新版，无法升级。

找到一篇介绍文章[服务器配置之-在CentOS中安装php5.3](http://dev.yidianhulian.com/2011/01/19/how-to-install-php53-on-centos/)，但发现文章中提供的download.fedora.redhat.com网站已经无法访问。google了一下，原来是<http://download.fedora.redhat.com>下载地址已经改为<http://dl.fedoraproject.org>。下面是更新后的方法（**针对64bit CentOS 5.x**）：<!--more-->

<pre lang="BASH">
# 删除原来的PHP版本，请自行备份php.ini
yum remove php-cli php-common php
# 安装新的源
rpm -Uvh http://dl.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm
rpm -Uvh http://dl.iuscommunity.org/pub/ius/stable/Redhat/5/x86_64/ius-release-1.0-10.ius.el5.noarch.rpm
# 安装新版php
yum install php53u
</pre>

**如果你使用CentOS 32bit版本，则需要将上面的x86_64改为i386。**

如果在安装php53u的过程中出现这样的错误：

<blockquote>file /usr/bin/php from install of php53u-cli-5.3.4-3.ius.el5.x86_64 conflicts with file from package php-cli-5.1.6-27.el5_5.3.x86_64
file /usr/bin/php-cgi from install of php53u-cli-5.3.4-3.ius.el5.x86_64 conflicts with file from package php-cli-5.1.6-27.el5_5.3.x86_64
file /usr/share/man/man1/php.1.gz from install of php53u-cli-5.3.4-3.ius.el5.x86_64 conflicts with file from package php-cli-5.1.6-27.el5_5.3.x86_64
file /etc/php.ini from install of php53u-common-5.3.4-3.ius.el5.x86_64 conflicts with file from package php-common-5.1.6-27.el5_5.3.x86_64</blockquote>

这多半是由于没有删除原来的php版本造成的，执行下面的命令即可清除：

<pre lang="BASH">
yum remove php-cli php-common php
</pre>


**参考资料：**

* <http://dev.yidianhulian.com/2011/01/19/how-to-install-php53-on-centos/>
* <http://en.ispdoc.com/index.php/Updating_PHP_in_CentOS_Linux>
* <http://www.andresmontalban.com/update-centos-5-php-5-1-to-php-5-3/>
* <http://blog.lilujun.com/post/1208/>
* <http://www.webtatic.com/packages/php53/>
* <http://serverfault.com/questions/221251/how-do-i-install-php-5-3-on-centos>

