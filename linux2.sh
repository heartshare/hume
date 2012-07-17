#!/bin/sh
# modified 20060725, shenhong
# modified 20080114, jianhua qin
# for init our redhat/fedora linux.

PATH=/bin:/usr/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin
export PATH

HOSTNAME=`hostname`
SYSCONF="/etc/sysconfig"
name="$1"
key="$2"
id="$3"
if [ -z $name ]; then
echo "what's your name please?"
read name
if test -z $name
then
        echo "You must input your name!"
        exit
fi
fi
echo $name > /etc/installer
echo "Please under /root to do the things below!"
echo "Warning! This script only effect on Redhat 6.2/7.2/7.3/8.0/9/3AS/4AS/5AS/Fedora2~6!" #add 5AS
#echo "Warning! This script only effect on Redhat 6.2/7.2/7.3/8.0/9/3AS/4AS/Fedora2~6!" #add FC6
#echo "Warning! This script only effect on Redhat 6.2/7.2/7.3/8.0/9/3AS/4AS/Fedora2/Fedora3/Fedora4/Fedora5!" #add FC5
sleep 1
echo -e "Now disable useless services.\r\n"
/sbin/chkconfig --level 345 anacron off
/sbin/chkconfig --level 345 apmd off
/sbin/chkconfig --level 345 atd off
/sbin/chkconfig --level 345 autofs off
/sbin/chkconfig --level 345 gpm off
/sbin/chkconfig --level 345 httpd off
/sbin/chkconfig --level 345 identd off
/sbin/chkconfig --level 345 ipchains off
/sbin/chkconfig --level 345 iptables off
/sbin/chkconfig --level 345 isdn off
/sbin/chkconfig --level 345 keytable off
/sbin/chkconfig --level 345 kudzu off
/sbin/chkconfig --level 345 linuxconf off
/sbin/chkconfig --level 345 lpd off
/sbin/chkconfig --level 345 netfs off
/sbin/chkconfig --level 345 nfslock off
/sbin/chkconfig --level 345 pcmcia off
/sbin/chkconfig --level 345 portmap off
/sbin/chkconfig --level 345 random off
/sbin/chkconfig --level 345 rawdevices off
/sbin/chkconfig --level 345 rhnsd off
#/sbin/chkconfig --level 345 sendmail off
/sbin/chkconfig --level 345 sgi_fam off
/sbin/chkconfig --level 345 xfs off
/sbin/chkconfig --level 345 xinetd off
/sbin/chkconfig --level 345 cups off
/sbin/chkconfig --level 345 audit off
/sbin/chkconfig --level 345 auth off
/sbin/chkconfig --level 345 hpoj off
/sbin/chkconfig --level 345 ip6tables off
/sbin/chkconfig --level 345 mdmonitor off
/sbin/chkconfig --level 345 openibd off
# for fedora
/sbin/chkconfig --level 2345 lm_sensors off
/sbin/chkconfig --level 2345 nifd off
/sbin/chkconfig --level 2345 mDNSResponder off
/sbin/chkconfig --level 2345 haldaemon off
/sbin/chkconfig --level 2345 iiim off
# for fc3
/sbin/chkconfig --level 2345 messagebus off
/sbin/chkconfig --level 2345 rpcgssd off
/sbin/chkconfig --level 2345 rpcidmapd off
/sbin/chkconfig --level 2345 rpcsvcgssd off
/sbin/chkconfig --level 2345 sysstat off
# for as5
/sbin/chkconfig --level 2345 auditd off
/sbin/chkconfig --level 2345 avahi-daemon off
/sbin/chkconfig --level 2345 avahi-dnsconfd off
/sbin/chkconfig --level 2345 bluetooth off
/sbin/chkconfig --level 2345 hidd off
/sbin/chkconfig --level 2345 libvirtd off
/sbin/chkconfig --level 2345 mcstrans off
/sbin/chkconfig --level 2345 pcscd off
/sbin/chkconfig --level 2345 xend off
/sbin/chkconfig --level 2345 xendomains off
/sbin/chkconfig --level 2345 yum-updatesd off

/sbin/chkconfig --level 2345 psacct on
/sbin/chkconfig --level 345 sshd on

echo "Setting Remote Serial Console..."
if grep -q ttyS0 /etc/inittab; then
        echo "/etc/inittab is up2date!"
else
        echo "s1:2345:respawn:/sbin/agetty -L 9600 ttyS0 vt100" >> /etc/inittab
fi
if grep -q ttyS0 /etc/securetty; then
        echo "/etc/securetty is up2date!"
else
        echo "ttyS0" >> /etc/securetty
fi
if grep -q 'export PS1="' /etc/profile; then
        echo "the PS1 Environment Variable is seted!"
else
        echo 'export PS1="[@\\H \\W]\\\$ "' >> /etc/profile
fi

if [ -z $key ]; then
echo  "Does this server will be a nfs client? (y/n)"
read key
fi
case $key in
y|Y)
        echo "Nice"
        ;;
n|N)
        echo "disabling nfs..."
        /sbin/chkconfig --level 23456 portmap off
        /sbin/chkconfig --level 23456 nfslock off
        ;;
*)
        echo "Answer must be y or n"
        exit 1
        ;;
esac

echo ""
echo "Now getting patch packages....."

if [ -z $id ]; then
echo "which interface of the ftp server U can connect? (1/2)"
#echo "1,10.1.34.39"
echo "2,192.168.1.201"
echo "3,61.135.132.201"
echo "4,10.10.66.231"
read id
fi
case $id in
#1)
#        server="10.1.34.39"
#        ;;
2)
        server="192.168.1.201"
        ;;
3)
        server="61.135.132.201"
        ;;
4)
        server="10.10.66.231"
        ;;
*)
        echo "Answer must be  2, 3 or 4"
        exit 1
        ;;
esac

if ifconfig eth0 | grep "192\.168\."; then
        i_net="192.168.`ifconfig eth0 | grep inet | cut -d: -f2 | cut -d' ' -f1 | cut -d. -f3`.254"
        i_device="eth0"
elif ifconfig eth0 | grep "10\."; then
        i_net="`ifconfig eth0 | grep "inet addr" | cut -d: -f2 | cut -d' ' -f1 | awk -F. '{OFS="."}{print $1,$2,$3}'`.254"
        i_device="eth0"
elif ifconfig eth0 | grep "172\.16\."; then
        i_net="`ifconfig eth0 | grep "inet addr" | cut -d: -f2 | cut -d' ' -f1 | awk -F. '{OFS="."}{print $1,$2,$3}'`.254"
        i_device="eth0"
elif ifconfig eth1 | grep "192\.168\."; then
        i_net="192.168.`ifconfig eth1 | grep inet | cut -d: -f2 | cut -d' ' -f1 | cut -d. -f3`.254"
        i_device="eth1"
elif ifconfig eth1 | grep "10\."; then
        i_net="`ifconfig eth1 | grep "inet addr" | cut -d: -f2 | cut -d' ' -f1 | awk -F. '{OFS="."}{print $1,$2,$3}'`.254"
        i_device="eth1"
elif ifconfig eth1 | grep "172\.16\."; then
        i_net="`ifconfig eth1 | grep "inet addr" | cut -d: -f2 | cut -d' ' -f1 | awk -F. '{OFS="."}{print $1,$2,$3}'`.254"
        i_device="eth1"
else
        echo "U have an interface on private network."
fi
# fxs default route inset ethx.route
i_net="`route | grep ^default | awk '{print $2}' | awk -F. '{OFS="."}{print $1,$2,$3,$4}'`"

#if rpm -q redhat-release > /dev/null 2>&1 ; then
#       OS="redhat"
#       ver="`rpm -q redhat-release | cut -d'-' -f3`"
#elif rpm -q fedora-release > /dev/null 2>&1 ; then
#       OS="fedora"
#       ver="Fedora`rpm -q fedora-release | cut -d'-' -f3`"
#else
#       echo "What your linux box's version is unknow!"
#       exit
#fi
arch="$(uname -m)"
if [ $arch = "i686" ]; then
        arch="i386"
fi

ver=`head -1 /etc/issue | awk '{print $5}'`   #version check open now
if [ $ver = "6.2" -o $ver = "7.2" -o $ver = "7.3" -o $ver = "8.0" -o $ver = "9" ]; then
        echo "Your linux box is RedHat$ver"
elif [ $ver = "AS" ]; then
        ver=`head -1 /etc/issue | awk '{print $7$5}'`
        echo "Your linux box is RedHat $ver"
elif [ $ver = "Server" ]; then
        ver=`head -1 /etc/issue | awk '{print $7}' | awk -F'.' '{print $1"AS"}'`
        echo "Your linux box is RedHat $ver"
elif [ $ver = "(Tettnang)" ]; then                      # Fedora2
        ver=`head -1 /etc/issue | awk '{print $1$4}'`
        echo "Your linux box is $ver"
elif [ $ver = "(Heidelberg)" ]; then                    # Fedora3
        ver=`head -1 /etc/issue | awk '{print $1$4}'`
        echo "Your linux box is $ver"
elif [ $ver = "(Stentz)" ]; then                        # Fedora4
        ver=`head -1 /etc/issue | awk '{print $1$4}'`
        echo "Your linux box is $ver"
elif [ $ver = "(Bordeaux)" ]; then                      # Fedora5
        ver=`head -1 /etc/issue | awk '{print $1$4}'`
        echo "Your linux box is $ver"
elif [ $ver = "(Zod)" ]; then                           # Fedora6
        ver=`head -1 /etc/issue | awk '{print $1$4}'`
        echo "Your linux box is $ver"
else
        echo "What your linux box's version is unknown!"
        exit
fi

if [ $ver = "6.2" -o $ver = "7.0" -o $ver = "7.1" -o $ver = "7.2" -o $ver = "7.3" ]; then
        if [ -f /etc/sysconfig/static-routes ]; then
                if [ "`grep ^eth /etc/sysconfig/static-routes`" = "" ]; then
                        if [ "$i_device" != "" ]; then
                                echo "$i_device net 192.168.0.0 netmask 255.255.0.0 gw $i_net" >> /etc/sysconfig/static-routes
                                echo "$i_device net 10.0.0.0 netmask 255.128.0.0 gw $i_net" >> /etc/sysconfig/static-routes
                        else
                                echo ""
                        fi
                else
                        echo "gateway exist"
                fi
        else
                if [ "$i_device" != "" ]; then
                        echo "$i_device net 192.168.0.0 netmask 255.255.0.0 gw $i_net" > /etc/sysconfig/static-routes
                        echo "$i_device net 10.0.0.0 netmask 255.128.0.0 gw $i_net" >> /etc/sysconfig/static-routes
                else
                        echo ""
                fi
        fi
elif [ $ver = "8.0" -o $ver = "9" ]; then
        if [ "$i_device" != "" ]; then
                confile4proute="/etc/sysconfig/networking/devices/$i_device.route"
                if [ -f "$confile4proute" ]; then
                        if [ "`grep ^ADDRESS0 $confile4proute`" != "" ]; then
                                echo ""
                        else
                                echo "ADDRESS0=192.168.0.0" >> $confile4proute
                                echo "NETMASK0=255.255.0.0" >> $confile4proute
                                echo "GATEWAY0=$i_net" >> $confile4proute
                        fi
                        if [ "`grep ^ADDRESS1 $confile4proute`" != "" ]; then
                                echo ""
                        else
                                echo "ADDRESS1=10.0.0.0" >> $confile4proute
                                echo "NETMASK1=255.128.0.0" >> $confile4proute
                                echo "GATEWAY1=$i_net" >> $confile4proute
                        fi
                else
                        echo "ADDRESS0=192.168.0.0" > $confile4proute
                        echo "NETMASK0=255.255.0.0" >> $confile4proute
                        echo "GATEWAY0=$i_net" >> $confile4proute
                        echo "ADDRESS1=10.0.0.0" >> $confile4proute
                        echo "NETMASK1=255.128.0.0" >> $confile4proute
                        echo "GATEWAY1=$i_net" >> $confile4proute

                fi
        fi
elif [ "$ver" = "3AS" -o "$ver" = "4AS" -o "$ver" = "5AS" ]; then
        if [ "$i_device" != "" ]; then
                confile4proute="/etc/sysconfig/network-scripts/$i_device.route"
                if [ -f "$confile4proute" ]; then
                        if [ "`grep ^ADDRESS0 $confile4proute`" != "" ]; then
                                echo ""
                        else
                                echo "ADDRESS0=192.168.0.0" >> $confile4proute
                                echo "NETMASK0=255.255.0.0" >> $confile4proute
                                echo "GATEWAY0=$i_net" >> $confile4proute
                        fi
                        if [ "`grep ^ADDRESS1 $confile4proute`" != "" ]; then
                                echo ""
                        else
                                echo "ADDRESS1=10.0.0.0" >> $confile4proute
                                echo "NETMASK1=255.128.0.0" >> $confile4proute
                                echo "GATEWAY1=$i_net" >> $confile4proute
                        fi
                else
                        echo "ADDRESS0=192.168.0.0" > $confile4proute
                        echo "NETMASK0=255.255.0.0" >> $confile4proute
                        echo "GATEWAY0=$i_net" >> $confile4proute
                        echo "ADDRESS1=10.0.0.0" >> $confile4proute
                        echo "NETMASK1=255.128.0.0" >> $confile4proute
                        echo "GATEWAY1=$i_net" >> $confile4proute
                fi
                confile4lang="/etc/sysconfig/i18n"
                tmpfile4lang="/tmp/i18n.tmp"
                if [ "`grep LANG=\\"en_US.UTF-8\\" $confile4lang`" = "" ]; then
                        echo "file $confile4lang is up2date!"
                else
                        sed 's/LANG=\"en_US.UTF-8\"/LANG=\"en_US\"/' $confile4lang > $tmpfile4lang
                        mv -f $tmpfile4lang $confile4lang
                fi
        fi
elif [ "$ver" = "Fedora2" -o "$ver" = "Fedora3" -o "$ver" = "Fedora4" -o "$ver" = "Fedora5" -o "$ver" = "Fedora6" ]; then   #add FC6
        if [ "$i_device" != "" ]; then
                confile4proute="/etc/sysconfig/network-scripts/$i_device.route"
                if [ -f "$confile4proute" ]; then
                        if [ "`grep ^ADDRESS0 $confile4proute`" != "" ]; then
                                echo ""
                        else
                                echo "ADDRESS0=192.168.0.0" >> $confile4proute
                                echo "NETMASK0=255.255.0.0" >> $confile4proute
                                echo "GATEWAY0=$i_net" >> $confile4proute
                        fi
                        if [ "`grep ^ADDRESS1 $confile4proute`" != "" ]; then
                                echo ""
                        else
                                echo "ADDRESS1=10.0.0.0" >> $confile4proute
                                echo "NETMASK1=255.128.0.0" >> $confile4proute
                                echo "GATEWAY1=$i_net" >> $confile4proute
                        fi
                else
                        echo "ADDRESS0=192.168.0.0" > $confile4proute
                        echo "NETMASK0=255.255.0.0" >> $confile4proute
                        echo "GATEWAY0=$i_net" >> $confile4proute
                        echo "ADDRESS1=10.0.0.0" >> $confile4proute
                        echo "NETMASK1=255.128.0.0" >> $confile4proute
                        echo "GATEWAY1=$i_net" >> $confile4proute
                fi
                confile4lang="/etc/sysconfig/i18n"
                tmpfile4lang="/tmp/i18n.tmp"
                if [ "`grep LANG=\\"en_US.UTF-8\\" $confile4lang`" = "" ]; then
                        echo "file $confile4lang is up2date!"
                else
                        sed 's/LANG=\"en_US.UTF-8\"/LANG=\"en_US\"/' $confile4lang > $tmpfile4lang
                        mv -f $tmpfile4lang $confile4lang
                fi
        fi
else
        echo ""
fi

rpm --import http://192.168.1.201/pub/install/RPM-GPG-KEY-itc
case $ver in
6.2)
        cp rc.tune2rh62 /etc/rc.d/rc.tune
        cp ipchains $SYSCONF/ipchains
        fnofapt="apt.rpm"
#       ftp -in < "6.2@$server"
#       echo "Now installing patch....."
#       rpm -Fvh *.rpm
        ;;
7.2)
        cp rc.tune2rh72 /etc/rc.d/rc.tune
        cp iptables $SYSCONF/iptables
        fnofapt="apt.rpm"
#       ftp -in < "7.2@$server"
#       echo "Now installing patch....."
#       rpm -Fvh *.rpm
        ;;
7.3)
        cp rc.tune2rh73 /etc/rc.d/rc.tune
        cp iptables $SYSCONF/iptables
        fnofapt="apt.rpm"
#       ftp -in < "7.3@$server"
#       echo "Now installing patch....."
#       rpm -Fvh *.rpm
        ;;
8.0)
        cp rc.tune2rh80 /etc/rc.d/rc.tune
        cp iptables $SYSCONF/iptables
        rpm --import http://$server/pub/os/Linux/RedHat/$ver/install/RPM-GPG-KEY
        fnofapt="apt.rpm"
#       ftp -in < "8.0@$server"
#       echo "Now installing patch....."
#       rpm -Fvh *.rpm
        ;;
9)
        cp rc.tune2rh9 /etc/rc.d/rc.tune
        cp iptables $SYSCONF/iptables
        rpm --import http://$server/pub/os/Linux/RedHat/$ver/install/RPM-GPG-KEY
        fnofapt="apt.rpm"
#       ftp -in < "9@$server"
#       echo "Now installing patch....."
#       rpm -Fvh *.rpm
        ;;
3AS)
        cp rc.tune2as3 /etc/rc.d/rc.tune
        cp iptables $SYSCONF/iptables
#       rpm --import http://$server/pub/os/Linux/RedHat/enterprise/$arch/3AS/install/RPM-GPG-KEY
        rpm --import http://$server/pub/os/Linux/RedHat/enterprise/$arch/3AS/disc1/RPM-GPG-KEY
        rpm --import http://$server/pub/os/Linux/RedHat/enterprise/$arch/3AS/disc1/RPM-GPG-KEY-beta
        fnofapt="apt.rpm"
        ;;
4AS)
        cp rc.tune2as4 /etc/rc.d/rc.tune
        cp iptables $SYSCONF/iptables
#       rpm --import http://$server/pub/os/Linux/RedHat/enterprise/$arch/4AS/install/RPM-GPG-KEY
        rpm --import http://$server/pub/os/Linux/RedHat/enterprise/$arch/4AS/dvd/RPM-GPG-KEY
        fnofapt="apt.rpm"
        ;;
5AS)
        cp rc.tune2as5 /etc/rc.d/rc.tune
        cp iptables $SYSCONF/iptables
        rpm --import http://$server/pub/os/Linux/RedHat/enterprise/$arch/5AS/dvd/RPM-GPG-KEY-redhat-release
        rpm --import http://$server/pub/os/Linux/RedHat/enterprise/$arch/5AS/dvd/RPM-GPG-KEY-redhat-beta
        fnofapt="apt.rpm"
        ;;
Fedora2)
        cp rc.tune2fc2 /etc/rc.d/rc.tune
        cp iptables $SYSCONF/iptables
        rpm --import http://$server/pub/os/Linux/Fedora/$arch/2/install/RPM-GPG-KEY
        fnofapt="apt.rpm"
        ;;
Fedora3)
        cp rc.tune2fc3 /etc/rc.d/rc.tune
        cp iptables $SYSCONF/iptables
        rpm --import http://$server/pub/os/Linux/Fedora/$arch/3/install/RPM-GPG-KEY
        if [ $arch = "x86_64" ]; then
        fnofapt="apt.rpm"
        else
        fnofapt="apt.rpm"
        fi
        ;;
Fedora4)
        cp rc.tune2fc4 /etc/rc.d/rc.tune
        cp iptables $SYSCONF/iptables
        rpm --import http://$server/pub/os/Linux/Fedora/$arch/4/install/RPM-GPG-KEY
        fnofapt="apt.rpm"
        ;;
Fedora5)
        cp rc.tune2fc5 /etc/rc.d/rc.tune
        cp iptables $SYSCONF/iptables
        rpm --import http://$server/pub/os/Linux/Fedora/$arch/5/install/RPM-GPG-KEY
        fnofapt="apt.rpm"
        ;;
Fedora6)
        cp rc.tune2fc6 /etc/rc.d/rc.tune
        cp iptables $SYSCONF/iptables
        rpm --import http://$server/pub/os/Linux/Fedora/$arch/6/install/RPM-GPG-KEY
        fnofapt="apt.rpm"
        ;;
*)
        echo "What your linux box's version is? (6.2/7.2/7.3/8.0/9/3AS/4AS/Fedora2/Fedora3/Fedora4/Fedora5)"
        echo "Answer must be 6.2/7.2/7.3/8.0/9/3AS/4AS/Fedora2/Fedora3/Fedora4/Fedora5"
        exit 1
        ;;
esac

[ -f /etc/rc.d/rc.tune ] && chmod +x /etc/rc.d/rc.tune        #origin has a wrong spell

cp cfgrpt.pl /usr/local/bin/cfgrpt.pl
cp cfgtda.sh /usr/local/bin/cfgtda.sh
chmod +x /usr/local/bin/cfgrpt.pl
chmod +x /usr/local/bin/cfgtda.sh
[ -f /etc/sysconfig/bash-prompt-xterm ] && cp -p /etc/sysconfig/bash-prompt-xterm /etc/sysconfig/bash-prompt-xterm.ori
cat bash-prompt-xterm > /etc/sysconfig/bash-prompt-xterm
chmod +x /etc/sysconfig/bash-prompt-xterm
if crontab -l | grep -q cfgrpt; then
        echo
else
        echo "`crontab -l`
#10 7 * * * mv -f /sysinfo /sysinfo.old;/usr/local/bin/cfgrpt.pl > /sysinfo;diff /sysinfo /sysinfo.old;[ \$? -ne 0 ] && mail -s \"server \`/sbin/ip addr show | grep inet | grep -v 127.0.0.1 | awk -F/ '{print \$1}' | awk '{print \$2}' | tr '\n' '/' | sed -e 's/.$//'\` is online or config changed\" sys@sohu-inc.com < /sysinfo" | crontab -
fi

echo "install apt(Advanced Package Tool)......"
if [ $ver = "3AS" ]; then
        rpm -i http://$server/pub/software/unix/bin/rpm/redhat/enterprise/3AS/$arch/$fnofapt
        rm -rf /etc/apt/sources.list.d/*
elif [ $ver = "4AS" ]; then
        rpm -i http://$server/pub/software/unix/bin/rpm/redhat/enterprise/4AS/$arch/$fnofapt
        rm -rf /etc/apt/sources.list.d/*
elif [ $ver = "5AS" ]; then
        rpm -i http://$server/pub/software/unix/bin/rpm/redhat/enterprise/5AS/$arch/$fnofapt
        rm -rf /etc/apt/sources.list.d/*
        rm -rf /etc/yum.repos.d/*
elif [ $ver = "Fedora2" ]; then
        rpm -i http://$server/pub/software/unix/bin/rpm/fedora/$arch/2/$fnofapt
        rm -rf /etc/apt/sources.list.d/*
        rm -rf /etc/yum.repos.d/*
elif [ $ver = "Fedora3" ]; then
        rpm -i http://$server/pub/software/unix/bin/rpm/fedora/$arch/3/$fnofapt
        rm -rf /etc/apt/sources.list.d/*
        rm -rf /etc/yum.repos.d/*
elif [ $ver = "Fedora4" ]; then
        rpm -i http://$server/pub/software/unix/bin/rpm/fedora/$arch/4/$fnofapt
        rm -rf /etc/apt/sources.list.d/*
        rm -rf /etc/yum.repos.d/*
elif [ $ver = "Fedora5" ]; then
        rpm -i http://192.168.1.201/pub/software/unix/bin/rpm/fedora/$arch/5/$fnofapt      #removed the REM, tmp use 1.201
        rm -rf /etc/apt/sources.list.d/*
        rm -rf /etc/yum.repos.d/*
elif [ $ver = "Fedora6" ]; then
        rpm -i http://192.168.1.201/pub/software/unix/bin/rpm/fedora/$arch/6/$fnofapt      #removed the REM, tmp use 1.201
        rm -rf /etc/apt/sources.list.d/*
        rm -rf /etc/yum.repos.d/*
else
        rpm -i http://$server/pub/software/unix/bin/rpm/redhat/$ver/$fnofapt
        rm -rf /etc/apt/sources.list.d/*
fi

[ -f /etc/apt/sources.list ] && cp -p /etc/apt/sources.list /etc/apt/sources.list.ori

if [ "$ver" = "3AS" ]; then
        echo "rpm http://$server pub/os/Linux/RedHat/enterprise/$arch/3AS os updates itc" >/etc/apt/sources.list
elif [ "$ver" = "4AS" ]; then
        echo "rpm http://$server pub/os/Linux/RedHat/enterprise/$arch/4AS os updates itc Debuginfo" >/etc/apt/sources.list
elif [ "$ver" = "5AS" ]; then
        echo "rpm http://$server pub/os/Linux/RedHat/enterprise/$arch/5AS os updates itc cluster clusterstorage vt" >/etc/apt/sources.list
elif [ "$ver" = "Fedora2" ]; then
        echo "rpm http://$server pub/os/Linux/Fedora/$arch/2 os updates itc" > /etc/apt/sources.list
elif [ "$ver" = "Fedora3" ]; then
        echo "rpm http://$server pub/os/Linux/Fedora/$arch/3 os updates itc" > /etc/apt/sources.list
elif [ "$ver" = "Fedora4" ]; then
        echo "rpm http://$server pub/os/Linux/Fedora/$arch/4 os updates itc" > /etc/apt/sources.list
elif [ "$ver" = "Fedora5" ]; then
        echo "rpm http://$server pub/os/Linux/Fedora/$arch/5 os updates itc" > /etc/apt/sources.list  # All add "itc"
elif [ "$ver" = "Fedora6" ]; then
        echo "rpm http://192.168.1.201 pub/os/Linux/Fedora/$arch/6 os updates itc" > /etc/apt/sources.list  # All add "itc"
else
        echo "rpm http://$server pub/os/Linux/RedHat/$ver os updates itc" >/etc/apt/sources.list
fi
cat >> /etc/apt/sources.list <<EOF

#if you want, you can add the more component and source
#rpm-src http://server pub/os/LinuxedHat/enterprise/$arch/4AS os updates
#rpm http://ftp1.no.sohu.com pub/os/Linux/RedHat/enterprise/i386/4AS os updates itc extras rhdn rhaps
#more see http://ftp.no.sohu.com/pub/

EOF

if [ -f /etc/yum.conf ]; then
        cp -p /etc/yum.conf /etc/yum.conf.ori
        case "$ver" in
                3AS)
                        ;;
                4AS)
                        ;;
                5AS)
                        echo -e "[base]\nname=5AS - \$basearch - base" >> /etc/yum.repos.d/AS5-Base.repo
                        echo "baseurl=http://192.168.1.201/pub/os/Linux/RedHat/enterprise/\$basearch/5AS/yum.base" >> /etc/yum.repos.d/AS5-Base.repo
                        echo -e "[updates]\nname=5AS - \$basearch - updates" >> /etc/yum.repos.d/AS5-Base.repo
                        echo "baseurl=http://192.168.1.201/pub/os/Linux/RedHat/enterprise/\$basearch/5AS/yum.updates" >> /etc/yum.repos.d/AS5-Base.repo
                        ;;
                Fedora2|Fedora3|Fedora4|Fedora5|Fedora6)
                        echo -e "[base]\nname=Fedora Core \$releasever - \$basearch - base" >> /etc/yum.conf
                        echo "baseurl=http://$server/pub/os/Linux/Fedora/\$basearch/\$releasever/yum.base/" >> /etc/yum.conf
                        echo -e "[updates]\nname=Fedora Core \$releasever - \$basearch - updates" >> /etc/yum.conf
                        echo "baseurl=http://$server/pub/os/Linux/Fedora/\$basearch/\$releasever/yum.updates/" >> /etc/yum.conf
                        echo -e "[itc]\nname=Fedora Core \$releasever - \$basearch for itc" >> /etc/yum.conf
                        echo "baseurl=http://$server/pub/os/Linux/Fedora/\$basearch/\$releasever/yum.itc/" >> /etc/yum.conf
                        ;;
                *)
                        ;;
        esac
fi

if [ -f /etc/sysconfig/rhn/sources ]; then
        [ -f /etc/sysconfig/rhn/sources.ori ] || cp /etc/sysconfig/rhn/sources /etc/sysconfig/rhn/sources.ori
fi

if [ "$ver" = "3AS" ]; then
        echo "apt rpm http://192.168.1.201 pub/os/Linux/RedHat/enterprise/$arch/3AS os updates itc" >/etc/sysconfig/rhn/sources
elif [ "$ver" = "4AS" ]; then
        echo "apt rpm http://192.168.1.201 pub/os/Linux/RedHat/enterprise/$arch/4AS os updates itc" >/etc/sysconfig/rhn/sources
elif [ "$ver" = "5AS" ]; then
        echo "apt rpm http://192.168.1.201 pub/os/Linux/RedHat/enterprise/$arch/5AS os updates itc cluster clusterstorage vt" >/etc/sysconfig/rhn/sources
elif [ "$ver" = "Fedora2" ]; then
        echo "yum base http://192.168.1.201/pub/os/Linux/Fedora/\$ARCH/2/yum.base/" > /etc/sysconfig/rhn/sources
        echo "yum updates http://192.168.1.201/pub/os/Linux/Fedora/\$ARCH/2/yum.updates/" >> /etc/sysconfig/rhn/sources
        echo "yum itc http://192.168.1.201/pub/os/Linux/Fedora/\$ARCH/2/yum.itc/" >> /etc/sysconfig/rhn/sources
elif [ "$ver" = "Fedora3" ]; then
        echo "yum base http://192.168.1.201/pub/os/Linux/Fedora/\$ARCH/3/yum.base/" > /etc/sysconfig/rhn/sources
        echo "yum updates http://192.168.1.201/pub/os/Linux/Fedora/\$ARCH/3/yum.updates/" >> /etc/sysconfig/rhn/sources
        echo "yum itc http://192.168.1.201/pub/os/Linux/Fedora/\$ARCH/3/yum.itc/" >> /etc/sysconfig/rhn/sources
elif [ "$ver" = "Fedora4" ]; then
        echo "yum base http://192.168.1.201/pub/os/Linux/Fedora/\$ARCH/4/yum.base/" > /etc/sysconfig/rhn/sources
        echo "yum updates http://192.168.1.201/pub/os/Linux/Fedora/\$ARCH/4/yum.updates/" >> /etc/sysconfig/rhn/sources
        echo "yum itc http://192.168.1.201/pub/os/Linux/Fedora/\$ARCH/4/yum.itc/" >> /etc/sysconfig/rhn/sources
elif [ "$ver" = "Fedora5" ]; then
        echo "yum base http://192.168.1.201/pub/os/Linux/Fedora/\$ARCH/5/yum.base/" > /etc/sysconfig/rhn/sources
        echo "yum updates http://192.168.1.201/pub/os/Linux/Fedora/\$ARCH/5/yum.updates/" >> /etc/sysconfig/rhn/sources
        echo "yum itc http://192.168.1.201/pub/os/Linux/Fedora/\$ARCH/5/yum.itc/" >> /etc/sysconfig/rhn/sources
elif [ "$ver" = "Fedora6" ]; then
        echo "yum base http://192.168.1.201/pub/os/Linux/Fedora/\$ARCH/6/yum.base/" > /etc/sysconfig/rhn/sources
        echo "yum updates http://192.168.1.201/pub/os/Linux/Fedora/\$ARCH/6/yum.updates/" >> /etc/sysconfig/rhn/sources
        echo "yum itc http://192.168.1.201/pub/os/Linux/Fedora/\$ARCH/6/yum.itc/" >> /etc/sysconfig/rhn/sources
else
        echo "apt rpm http://$server pub/os/Linux/RedHat/$ver os updates itc" >/etc/sysconfig/rhn/sources
fi

echo "update the packages list & package dependence......"
/usr/bin/apt-get update
echo "check the packages list & package dependence......"
/usr/bin/apt-get check
echo "U can use 'apt-get update;apt-get check;apt-get upgrade' to upgrade all of your packages in the your linux box to be uptodate"

if crontab -l | grep -q rdate; then
        echo
else
        if [ $server = "61.135.132.201" ]; then
                echo "`crontab -l`
`date '+%M %H'` * * * /usr/bin/rdate -s itimer.chinaren.com > /dev/null 2>&1;/sbin/clock -w" | crontab -
        else
                echo "`crontab -l`
`date '+%M %H'` * * * /usr/sbin/ntpdate ntp.sohu.com > /dev/null 2>&1;/sbin/clock -w" | crontab -
        fi
fi

[ -x /usr/sbin/ntpdate ] && echo "/usr/sbin/date" > /path
[ -x /usr/bin/rdate ] && echo "/usr/bin/rdate" > /path
[ -x /sbin/clock ] && echo "/sbin/clock" >> /path
ntpdate  192.168.131.132 >> /path
rdate -s itimer.chinaren.com >> /path
clock -w

#[ -z "`grep 192.168.8.252 /etc/hosts`" ] && echo "192.168.8.252                corp" >> /etc/hosts

echo "Now enable system tuning script"
echo ""
touch /etc/rc.d/rc.local
[ -f /etc/rc.d/rc.tune ] && echo ". /etc/rc.d/rc.tune" >> /etc/rc.d/rc.local
echo "ulimit -n 65535" >> /etc/rc.d/rc.local
echo "ulimit -u 16384" >> /etc/rc.d/rc.local
echo "*                soft   nofile          65535" >>/etc/security/limits.conf
echo "*                hard   nofile          65535" >>/etc/security/limits.conf
echo "*                soft   nproc           16384" >>/etc/security/limits.conf
echo "*                hard   nproc           32768" >>/etc/security/limits.conf

[ "$ver" = "6.2" -o "$ver" = "7.2" -o "$ver" = "7.3" -o "$ver" = "8.0" -o "$ver" = "9" -o "$ver" = "3AS" ] && echo "-y" > /fsckoptions
#[ "$ver" = "Fedora2" -o "$ver" = "Fedora3" -o "$ver" = "4AS" -o "$ver" = "Fedora4" ] || echo "-y" > /fsckoptions
touch /forcefsck
#rm -f /usr/sbin/in.telnetd
#rm -f /usr/sbin/in.rexecd
#rm -f /usr/sbin/in.rshd
/usr/bin/chattr +i /fsckoptions
/usr/bin/chattr +i /forcefsck


if [ $ver = "9" ]; then
        if [ "`grep Architecture /etc/apt/apt.conf`" = "" ]; then
        cat /etc/apt/apt.conf | sed '/Clean-Installed "false";$/a\
    Architecture i686;
' > /tmp/apt.tmp
        mv -f /tmp/apt.tmp /etc/apt/apt.conf
        else
                echo "haha"
        fi
fi

echo "setting ACL for ssh......"
DATE=`date "+%Y%m%d%H%M%S"`
if grep -i "^sshd:" /etc/hosts.deny > /dev/null 2>&1; then
        cp -f /etc/hosts.deny /etc/hosts.deny.$DATE
        cp -f /etc/hosts.deny /etc/hosts.deny.bak
        sed -e 's/^sshd:/#sshd:/g' /etc/hosts.deny.bak > /etc/hosts.deny
        echo "file /etc/hosts.deny backup to /etc/hosts.deny.$DATE"
fi
echo "sshd: ALL" >> /etc/hosts.deny
echo "file /etc/hosts.deny is modified"
if grep -i "^sshd:" /etc/hosts.allow > /dev/null 2>&1; then
        cp -f /etc/hosts.allow /etc/hosts.allow.$DATE
        cp -f /etc/hosts.allow /etc/hosts.allow.bak
        sed -e 's/^sshd:/#sshd:/g' /etc/hosts.allow.bak > /etc/hosts.allow
        echo "file /etc/hosts.allow backup to /etc/hosts.allow.$DATE"
fi
#echo "sshd: 192.168.0.0/255.255.0.0 10.0.0.0/255.128.0.0 61.135.132.0/255.255.255.0" > /etc/hosts.allow
#echo "ALL: 192.168.0.0/255.255.0.0 10.0.0.0/255.128.0.0 61.135.130.0/255.255.254.0 61.135.132.0/255.255.254.0 61.135.134.0/255.255.255.0 61.135.145.0/255.255.255.192 61.135.150.0/255.255.254.0 61.135.178.0/255.255.254.0 61.135.179.0/255.255.255.0 61.135.180.0/255.255.255.0 220.181.19.0/255.255.255.0 220.181.20.0/255.255.255.0 220.181.26.0/255.255.255.0 202.106.180.0/255.255.255.0 219.142.100.0/255.255.255.0" > /etc/hosts.allow

echo "ALL: 10. 192.168. 61.135.131. 61.135.132. 61.135.133. 61.135.150. 61.135.151. 61.135.178. 61.135.179. 61.135.180. 220.181.19. 220.181.20. 220.181.26. 202.106.180." > /etc/hosts.allow
sed -i 's/#Protocol 2,1/Protocol 2/g' /etc/ssh/sshd_config
echo "file /etc/hosts.allow is modified"

echo "to disable ipv6"
if [ -f /etc/modprobe.conf ]; then
        if grep -i "^alias net-pf-10 off$" /etc/modprobe.conf > /dev/null 2>&1; then
                echo "ipv6 is already disabled"
        else
                cp -f /etc/modprobe.conf /etc/modprobe.conf.$DATE
                echo "alias net-pf-10 off" >> /etc/modprobe.conf
                echo "file /etc/modprobe.conf backup to /etc/modprobe.conf.$DATE"
                if [ "$ver" = "5AS" ]; then
                        /bin/sed -i '/NETWORKING_IPV6/d' /etc/sysconfig/network
                fi
        fi
fi

echo "upgrade packages up to date......"
apt-get update
apt-get check

#if [ "$ver" = "Fedora2" -o "$ver" = "Fedora3" -o "$ver" = "Fedora4" -o "$ver" = "Fedora5" ]; then
if [ "$ver" = "Fedora2" -o "$ver" = "Fedora3" -o "$ver" = "Fedora4" -o "$ver" = "Fedora5" -o "$ver" = "Fedora6" ]; then
        if [ "$arch" = "x86_64" ]; then
                echo "U should run yum -y update manually";
        else
                yum -y update
        fi
else
# do NOT upgrade the system , asked by somebody!!!
        echo "u should apt upgrade manually!"
        apt-get -y upgrade
fi
echo "upgrade packages done."

echo "update file /etc/resolv.conf"
if [ $server = "61.135.132.201" ]; then
        echo "nameserver 61.135.131.1" > /etc/resolv.conf
        echo "nameserver 61.135.132.1" >> /etc/resolv.conf
        echo "nameserver 192.168.131.186" >> /etc/resolv.conf
else
        echo "nameserver 192.168.131.1" > /etc/resolv.conf
        echo "nameserver 192.168.132.1" >> /etc/resolv.conf
        echo "nameserver 61.135.131.186" >> /etc/resolv.conf
fi
echo "change password of root..."
newPasd="`./MakePasswd.pl`"
if [[ -n $4 ]]; then newPasd=$4 && echo -e "p: $newPasd\n";fi
echo "$newPasd" | passwd --stdin root
/usr/bin/curl -d "p=$newPasd" http://192.168.1.201/sysadmin/haha.php
#/usr/bin/wget -O - --post-data "p=$newPasd" http://192.168.1.201/sysadmin/haha.php

echo "update file /etc/fstab,mount /tmp and /var/tmp as tmpfs......"
#[ -z "`grep -v '^#' /etc/fstab | awk '{print $2}' | grep '^/var/tmp'`" ] && echo "/dev/shm                /var/tmp                none    rw,bind         0 0" >> /etc/fstab
[ -z "`grep -v '^#' /etc/fstab | awk '{print $2}' | grep '^/tmp'`" ] && echo "/dev/shm                /tmp                    none    rw,bind         0 0" >> /etc/fstab
rm -rf /var/tmp
ln -s /tmp /var/tmp
echo "Disable selinux if AS4."
[ -f /etc/selinux/config ] && sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
echo "decrease the tty."
sed -i '/tty[4-6]/s/^/#/g' /etc/inittab
echo "add console login prompt log hostname."
sed -i '/^[1-6]:2345/s/mingetty/mingetty --long-hostname/' /etc/inittab
echo "change fstab opt's fsck fs_freq,fs_passno"
sed  -i   '/opt/s/1 2/0 0/' /etc/fstab
# change by Fengsuesong
sed  -i   '/opt/s@defaults@defaults,noatime,nodiratime@' /etc/fstab
/usr/bin/chattr +i /bin/sh
/usr/bin/chattr +i /bin/bash
exit

