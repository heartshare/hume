博客地址：[pacman升级到4.0之后的错误处理](http://zengrong.net/post/1564.htm)

今天升级ArchLinux的时候碰到这个错误：

>error: failed to prepare transaction (could not satisfy dependencies)
>:: package-query: requires pacman<3.6

网上查了一下资料，是ArchLinux的源中pacman均更新到4.0所致，解决办法如下：

## 一、更新pacman，修改pacman.conf

* 若安装过yaourt，则删除yaourt和package-query；
* 也可以安装package-query-git，安装的过程中会自动更新pacman到4.0；
* pacman安装完成后，备份原来的/etc/pacman.conf，使用/etc/pacman.conf.pacnew替换；
* 修改/etc/pacman.conf，修改的内容如下：
    1. 加入原来的archlinuxfr的源；
    2. 去掉 SigLevel = Optional TrustAll 的注释；
    3. 将原来的 SigLevel = Never 注释；
* 重新安装yaourt。

## 二、关于密钥

生成本地加密密钥的步骤比较复杂，具体如下；

执行`pacman-key --init`；

提示如下：

>gpg: Generating pacman keychain master key...
>Not enough random bytes available. Please do some other work to give the OS a chance to collect more entropy!(Need 284 more bytes)

**桌面环境下：**

在终端输入`cat /udev/urandom`，然后移动鼠标或者随意按键，获取生成密钥需要的随机数，稍等一会儿密钥就会自动生成。

**非桌面环境下：**

如果是通过SSH连接，或者没有桌面环境，上面的方法可能会不起作用。需要这样处理：

<pre lang="bash">
#使用yaourt从AUR安装rng-tools包
yaourt -S rng-tools
#将随机数超时改为10
sed -i 's/0/10/' /etc/conf.d/rngd
#生成密钥
rngd -f -r /dev/urandom & pacman-key --init
#生成成功之后，杀死rngd进程
killall rngd
#删除rng-tools包
pacman -Rns rng-tools
</pre>


## 三、更新系统

1. 修改gpg服务器地址，这是为了导入密钥能够速度更快；

修改 /etc/pacman.d/gnupg/gpg.conf，将 keyserver hkp://keys.gnupg.net 改为 keyserver hkp://pgp.mit.edu。如果后面导入密钥失败，再改为 hkp://pgp.mit.edu:11371；

2. 执行`pacman -Syu`更新系统，若出现下面的错误：

>error: failed to commit transaction (conflicting files)
>filesystem: /etc/mtab exists in filesystem
>Errors occurred, no packages were upgraded.

则安装下面的包：

<pre lang="bash">
pacman -S filesystem --force
</pre>

然后重新更新系统。

## 四、参考链接

* <https://bbs.archlinux.org/viewtopic.php?id=132225>
* <https://bbs.archlinux.org/viewtopic.php?id=128340>
* <https://bbs.archlinux.org/viewtopic.php?pid=1003855>
* <http://www.archlinux.org/news/filesystem-upgrade-manual-intervention-required/>
* <http://bbs.archlinuxcn.org/viewtopic.php?id=533>

