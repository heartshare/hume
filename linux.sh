#!/bin/sh
# modified 20060725, shenhong
# modified 20080114, jianhua qin
# modified 20090610, feng xue song
# for init our redhat/fedora linux.
set -x

PATH=/bin:/usr/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin
export PATH

cd /root
HOSTNAME=`hostname`
SYSCONF="/etc/sysconfig"
server="192.168.1.201"
rootPasd="$1"

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
        echo "What your linux box's version is unknown"
        echo "Warning This script only effect on Redhat 4AS/5AS/" 
        exit
fi

echo "Please under /root to do the things below"

echo "make file /etc/resolv.conf"
cat > /etc/resolv.conf <<EOF
nameserver 10.11.20.188
nameserver 10.10.72.188
nameserver 192.168.132.1
nameserver 192.168.131.1
EOF

echo "update crontab and sys_time"
if crontab -l | grep -q rdate; then
        echo
else    
        echo "`crontab -l`
`date '+%M %H'` * * * /usr/sbin/ntpdate ntp.sohu.com > /dev/null 2>&1;/sbin/clock -w" | crontab -
fi
        
[ -x /usr/sbin/ntpdate ] && echo "date" >> /path
[ -x /usr/bin/rdate ] && echo "/usr/bin/rdate" >> /path
[ -x /sbin/clock ] && echo "/sbin/clock" >> /path
ntpdate itimer.chinaren.com >> /path || ntpdate 192.168.131.132 >> /path
rdate -s itimer.chinaren.com >> /path || rdate -s 192.168.131.132 >> /path
clock -w  

sleep 1
echo -e "Now disable useless services.\r\n"

/sbin/chkconfig --level 2345 anacron off
/sbin/chkconfig --level 2345 apmd off
/sbin/chkconfig --level 2345 atd off
/sbin/chkconfig --level 2345 audit off
/sbin/chkconfig --level 2345 auth off
/sbin/chkconfig --level 2345 autofs off
/sbin/chkconfig --level 2345 gpm off
/sbin/chkconfig --level 2345 httpd off
/sbin/chkconfig --level 2345 identd off
/sbin/chkconfig --level 2345 ipchains off
/sbin/chkconfig --level 2345 iptables off
/sbin/chkconfig --level 2345 isdn off
/sbin/chkconfig --level 2345 keytable off
/sbin/chkconfig --level 2345 kudzu off
/sbin/chkconfig --level 2345 linuxconf off
/sbin/chkconfig --level 2345 lpd off
/sbin/chkconfig --level 2345 netfs off
/sbin/chkconfig --level 2345 nfslock off
/sbin/chkconfig --level 2345 openibd off
/sbin/chkconfig --level 2345 pcmcia off
/sbin/chkconfig --level 2345 portmap off
/sbin/chkconfig --level 2345 random off
/sbin/chkconfig --level 2345 rawdevices off
/sbin/chkconfig --level 2345 rhnsd off
/sbin/chkconfig --level 2345 sgi_fam off
/sbin/chkconfig --level 2345 xfs off
/sbin/chkconfig --level 2345 xinetd off

# for fedora
/sbin/chkconfig --level 2345 haldaemon off
/sbin/chkconfig --level 2345 iiim off
/sbin/chkconfig --level 2345 lm_sensors off
/sbin/chkconfig --level 2345 mDNSResponder off
/sbin/chkconfig --level 2345 nifd off

# for redhat as 3
/sbin/chkconfig --level 2345 arptables_jf off
/sbin/chkconfig --level 2345 cups off
/sbin/chkconfig --level 2345 firstboot off
/sbin/chkconfig --level 2345 hpoj off
/sbin/chkconfig --level 2345 ip6tables off
/sbin/chkconfig --level 2345 mdmonitor off
/sbin/chkconfig --level 2345 mdmpd off

# for redhat as 4
/sbin/chkconfig --level 2345 acpid off
/sbin/chkconfig --level 2345 cpuspeed off
/sbin/chkconfig --level 2345 messagebus off
/sbin/chkconfig --level 2345 rpcgssd off
/sbin/chkconfig --level 2345 rpcidmapd off
/sbin/chkconfig --level 2345 rpcsvcgssd  off
/sbin/chkconfig --level 2345 smartd off
/sbin/chkconfig --level 2345 sysstat off

# for redhat as 5
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

/sbin/chkconfig --level 2345 irqbalance on
/sbin/chkconfig --level 2345 psacct on
/sbin/chkconfig --level 2345 sshd on

echo ""
echo "Now getting patch packages....."

rpm --import http://$server/pub/install/RPM-GPG-KEY-itc
case $ver in
4AS)
        rpm --import /usr/share/rhn/RPM-GPG-KEY
        rpm --import http://$server/pub/os/Linux/RedHat/enterprise/$arch/$ver/dvd/RPM-GPG-KEY
        ;;
5AS)
        rpm --import http://$server/pub/os/Linux/RedHat/enterprise/$arch/$ver/dvd/RPM-GPG-KEY-redhat-release
        rpm --import http://$server/pub/os/Linux/RedHat/enterprise/$arch/$ver/dvd/RPM-GPG-KEY-redhat-beta
        ;;
*)
        echo "What your linux box's version is? (4AS/5AS)"
        echo "Answer must be 4AS/5AS"
        exit 1
        ;;
esac

echo "install apt(Advanced Package Tool)......"
rpm -i http://$server/pub/software/unix/bin/rpm/redhat/enterprise/$ver/$arch/apt.rpm
rm -rf /etc/apt/sources.list.d/*
rm -rf /etc/yum.repos.d/*

[ -f /etc/apt/sources.list ] && cp -p /etc/apt/sources.list /etc/apt/sources.list.ori
if [ -f /etc/sysconfig/rhn/sources ]; then
	[ -f /etc/sysconfig/rhn/sources.ori ] || cp /etc/sysconfig/rhn/sources /etc/sysconfig/rhn/sources.ori
fi

if [ "$ver" = "4AS" ]; then
	echo "rpm http://$server pub/os/Linux/RedHat/enterprise/$arch/$ver os updates itc Debuginfo sohu" >/etc/apt/sources.list
	echo "apt rpm http://$server pub/os/Linux/RedHat/enterprise/$arch/$ver os updates itc sohu" >/etc/sysconfig/rhn/sources
	# make HP cpq_cciss
	cd /root
	wget http://$server/pub/software/unix/hp/cpq_cciss/6.20-16/sohu_cpq_cciss_tool.sh
#	wget http://$server/pub/install/updates/HP-set.sh  -O /root/HP-set.sh
	sh ./sohu_cpq_cciss_tool.sh
elif [ "$ver" = "5AS" ]; then
	echo "rpm http://$server pub/os/Linux/RedHat/enterprise/$arch/$ver os updates itc cluster clusterstorage vt sohu" >/etc/apt/sources.list
	echo "apt rpm http://$server pub/os/Linux/RedHat/enterprise/$arch/$ver os updates itc cluster clusterstorage vt sohu" >/etc/sysconfig/rhn/sources
else
	echo "rpm http://$server pub/os/Linux/RedHat/$ver os updates itc sohu" >/etc/apt/sources.list
	echo "apt rpm http://$server pub/os/Linux/RedHat/$ver os updates itc sohu" >/etc/sysconfig/rhn/sources
fi
echo "update file /etc/apt/sources.list"
cat >> /etc/apt/sources.list <<EOF

#if you want, you can add the more component and source 
#rpm-src http://server pub/os/LinuxedHat/enterprise/$arch/$ver os updates
#rpm http://ftp1.no.sohu.com pub/os/Linux/RedHat/enterprise/i386/4AS os updates itc sohu extras rhdn rhaps
#more see http://ftp.no.sohu.com/pub/

EOF

if [ -f /etc/yum.conf ]; then
	cp -p /etc/yum.conf /etc/yum.conf.ori
	case "$ver" in
		4AS)
			;;
		5AS)
			wget -N -P /etc/yum.repos.d/ http://$server/pub/install/updates/{5AS-Base.repo,5AS-dvd.repo}
			;;
		*)
			;;
	esac
fi

echo "update,check the packages list & package dependence......"
apt-get update
apt-get check
apt-get -y upgrade
echo "upgrade packages done."

apt-get -y remove ksh
apt-get -y remove tcsh
apt-get -y remove zsh
apt-get -y install bash
apt-get -y install net-snmp-host-sohu
/usr/bin/chattr +i /bin/sh
/usr/bin/chattr +i /bin/bash

# make /forcefsck
touch /forcefsck
/usr/bin/chattr +i /forcefsck

# change /etc/syslog.conf
sed -i '/[[:digit:]]\{1,3\}\(\.[[:digit:]]\{1,3\}\)\{3\}[[:digit:]]\{1,3\}$/d' /etc/syslog.conf
echo -e "*.notice\t\t\t\t\t\t@10.125.125.17" >> /etc/syslog.conf
/usr/bin/chattr +i /etc/syslog.conf

# change /etc/inittab
#decrease the tty.add console login prompt log hostname.Setting Remote Serial Console.
sed -i '/tty[4-6]/s/^/#/g' /etc/inittab
sed -i '/^[1-6]:2345/s/mingetty/mingetty --long-hostname/' /etc/inittab
# Setting Remote Serial Console...
if grep -q ttyS0 /etc/inittab; then  
	echo "/etc/inittab is up2date"
else
	echo "s1:2345:respawn:/sbin/agetty -L 9600 ttyS0 vt100" >> /etc/inittab
fi
if grep -q ttyS0 /etc/securetty; then
	echo "/etc/securetty is up2date"
else
	echo "ttyS0" >> /etc/securetty
fi
# change /etc/profile
if grep -q 'export PS1="' /etc/profile; then
	echo "the PS1 Environment Variable is seted"
else
	echo 'export PS1="[@\\H \\W]\\\$ "' >> /etc/profile
fi
# change /etc/sysconfig/i18n
confile4lang="/etc/sysconfig/i18n"
tmpfile4lang="/tmp/i18n.tmp"
if [ "`grep LANG=\\"en_US.UTF-8\\" $confile4lang`" = "" ]; then
	echo "file $confile4lang is up2date"
else
	sed 's/LANG=\"en_US.UTF-8\"/LANG=\"en_US\"/' $confile4lang > $tmpfile4lang
	mv -f $tmpfile4lang $confile4lang
fi

echo "make file /etc/rc.d/rc.tune"
cat > /etc/rc.d/rc.tune <<EOF
# increase Linux TCP buffer limits
echo 8388608 > /proc/sys/net/core/rmem_max
echo 8388608 > /proc/sys/net/core/wmem_max
# increase Linux autotuning TCP buffer limits
echo "4096 87380 8388608" > /proc/sys/net/ipv4/tcp_rmem
echo "4096 65536 8388608" > /proc/sys/net/ipv4/tcp_wmem
echo "1024  65000" > /proc/sys/net/ipv4/ip_local_port_range
echo 1 > /proc/sys/net/ipv4/tcp_syncookies
echo 8192 > /proc/sys/net/ipv4/tcp_max_syn_backlog
# Turn off tcp_window_scaling
echo 0  >/proc/sys/net/ipv4/tcp_window_scaling
# Turn off the tcp_sack
echo 0  >/proc/sys/net/ipv4/tcp_sack # This disables RFC2018 TCP Selective Acknowledgements
#Turn off tcp_timestamps
echo 0  >/proc/sys/net/ipv4/tcp_timestamps # This disables RFC1323 TCP timestamps
echo 5 > /proc/sys/kernel/panic # reboot 5 minutes later then kernel panic
EOF
[ -f /etc/rc.d/rc.tune ] && chmod +x /etc/rc.d/rc.tune        #origin has a wrong spell

touch /etc/rc.d/rc.local
[ -f /etc/rc.d/rc.tune ] && echo ". /etc/rc.d/rc.tune" >> /etc/rc.d/rc.local
echo "update file /etc/rc.d/rc.local"
cat >> /etc/rc.d/rc.local <<EOF
ulimit -n 65535
ulimit -u 16384
EOF

echo "update file /etc/security/limits.conf"
cat >> /etc/security/limits.conf <<EOF
*                soft   nofile          65535
*                hard   nofile          65535
*                soft   nproc           16384
*                hard   nproc           32768
EOF

echo "make file /etc/sysconfig/iptables"
cat > /etc/sysconfig/iptables <<EOF
*filter
:INPUT ACCEPT [10276:1578052]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [13784:16761487]
-A INPUT -s 10.0.0.0/255.0.0.0 -i eth1 -j DROP 
-A INPUT -s 172.16.0.0/255.240.0.0 -j DROP 
-A INPUT -s 192.168.0.0/255.255.0.0 -i eth1 -j DROP 
# anti Sync Flood
-A FORWARD -p tcp -m tcp --tcp-flags SYN,RST,ACK SYN -m limit --limit 1/sec -j ACCEPT 
# anti some port scan
-A FORWARD -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK RST -m limit --limit 1/sec -j ACCEPT 
# anti ping of death
-A FORWARD -p icmp -m icmp --icmp-type 8 -m limit --limit 1/sec -j ACCEPT 
COMMIT
EOF

# make /etc/sysconfig/bash-prompt-xterm
[ -f /etc/sysconfig/bash-prompt-xterm ] && cp -p /etc/sysconfig/bash-prompt-xterm /etc/sysconfig/bash-prompt-xterm.ori
echo "make file /etc/sysconfig/bash-prompt-xterm"
cat > /etc/sysconfig/bash-prompt-xterm <<EOF
echo -ne "\e]2;\$(/sbin/ip -4 -o addr show | awk '{print \$4}' | awk -F/ '{print \$1}' | grep -v "^127\." | sed -e :a -e '\$!N;s/\n/\//g;ta')\a"
EOF
chmod +x /etc/sysconfig/bash-prompt-xterm

echo "update file /etc/fstab,mount /tmp and /var/tmp as tmpfs......"
[ -z "`grep -v '^#' /etc/fstab | awk '{print $2}' | grep '^/tmp'`" ] && echo "/dev/shm                /tmp                    none    rw,bind         0 0" >> /etc/fstab
# change fstab opt's fsck fs_freq,fs_passno
sed  -i   '/opt/s/1 2/0 0/' /etc/fstab
sed  -i   '/opt/s@defaults@defaults,noatime,nodiratime@' /etc/fstab

rm -rf /var/tmp
ln -s /tmp /var/tmp
# Disable selinux if AS4 
[ -f /etc/selinux/config ] && sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

echo "setting ACL for ssh......"
DATE=`date "+%Y%m%d%H%M%S"`
if grep -i "^sshd:" /etc/hosts.deny > /dev/null 2>&1; then
	cp -f /etc/hosts.deny /etc/hosts.deny.$DATE
	cp -f /etc/hosts.deny /etc/hosts.deny.bak
	sed -e 's/^sshd:/#sshd:/g' /etc/hosts.deny.bak > /etc/hosts.deny
fi
echo "sshd: ALL" >> /etc/hosts.deny

if grep -i "^sshd:" /etc/hosts.allow > /dev/null 2>&1; then
	cp -f /etc/hosts.allow /etc/hosts.allow.$DATE
	cp -f /etc/hosts.allow /etc/hosts.allow.bak
	sed -e 's/^sshd:/#sshd:/g' /etc/hosts.allow.bak > /etc/hosts.allow
fi
echo "ALL: 10. 192.168. 61.135.131. 61.135.132. 61.135.133. 61.135.150. 61.135.151. 61.135.178. 61.135.179. 61.135.180. 220.181.19. 220.181.20. 220.181.26. 202.106.180." >> /etc/hosts.allow

sed -i 's/#Protocol 2,1/Protocol 2/g' /etc/ssh/sshd_config 

echo "change password of root..."
wget http://$server/pub/install/setup/MakePasswd.pl
chmod +x MakePasswd.pl
newPasd="`./MakePasswd.pl`"
if [[ -n $rootPasd ]]; then newPasd=$rootPasd && echo -e "p: $newPasd\n";fi
echo "$newPasd" | passwd --stdin root
/usr/bin/curl -d "p=$newPasd" -d "label=${arch}-${ver}${release}-${type}" -d "note=`sed 's/&/%26/g' /proc//cmdline`" http://$server/sysadmin/haha.php


sed -i "sl${newPasd}lnewpasswdlg" /postlog

echo "to disable ipv6"
if [ -f /etc/modprobe.conf ]; then
	if grep -i "^alias net-pf-10 off$" /etc/modprobe.conf > /dev/null 2>&1; then
		echo "ipv6 is already disabled"
	else
		cp -f /etc/modprobe.conf /etc/modprobe.conf.$DATE
		echo "alias ipv6 off" >> /etc/modprobe.conf
		echo "alias net-pf-10 off" >> /etc/modprobe.conf
		echo "file /etc/modprobe.conf backup to /etc/modprobe.conf.$DATE"       
		if [ "$ver" = "5AS" ]; then
			/bin/sed -i '/NETWORKING_IPV6/d' /etc/sysconfig/network
		fi
	fi
fi

if ifconfig eth0 | grep "192\.168\."; then
	i_device="eth0"
elif ifconfig eth0 | grep "10\."; then
	i_device="eth0"
elif ifconfig eth0 | grep "172\.16\."; then
	i_device="eth0"
elif ifconfig eth1 | grep "192\.168\."; then
	i_device="eth1"
elif ifconfig eth1 | grep "10\."; then
	i_device="eth1"
elif ifconfig eth1 | grep "172\.16\."; then
	i_device="eth1"
else
	echo "U have an interface on private network."
fi
# fxs default route inset ethx.route
i_net="`route | grep ^default | awk '{print $2}' | awk -F. '{OFS="."}{print $1,$2,$3,$4}'`"

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
fi

#### add for dell by jianhuaqin@sohu-inc.com ####
/sbin/service network stop

if [ ! -f /etc/sysconfig/network-scripts/eth0.route ]; then
   if [ -f /etc/sysconfig/network-scripts/ifcfg-eth0 -a -f /etc/sysconfig/network-scripts/ifcfg-eth1 ]; then
        if [ -f /etc/sysconfig/network-scripts/eth1.route ]; then
            /bin/mv -f /etc/sysconfig/network-scripts/eth1.route /etc/sysconfig/network-scripts/eth0.route
        fi

        /bin/mv -f /etc/sysconfig/network-scripts/ifcfg-eth0 /etc/sysconfig/network-scripts/ifcfg-eth0-bak
        /bin/mv -f /etc/sysconfig/network-scripts/ifcfg-eth1 /etc/sysconfig/network-scripts/ifcfg-eth0
        /bin/mv -f /etc/sysconfig/network-scripts/ifcfg-eth0-bak /etc/sysconfig/network-scripts/ifcfg-eth1

        /bin/sed -i 's/eth[0-9]/eth0/g' /etc/sysconfig/network-scripts/ifcfg-eth0
        /bin/sed -i 's/eth[0-9]/eth1/g' /etc/sysconfig/network-scripts/ifcfg-eth1

        MAC_ADDRESS0=`/bin/grep '^HWADDR' /etc/sysconfig/network-scripts/ifcfg-eth0 | /usr/bin/awk -F= '{print $2}'`
        MAC_ADDRESS1=`/bin/grep '^HWADDR' /etc/sysconfig/network-scripts/ifcfg-eth1 | /usr/bin/awk -F= '{print $2}'`

        if [ -z "${MAC_ADDRESS0}" ] ; then
            MAC_ADDRESS0=`/sbin/ifconfig -a | /bin/grep eth1 | /usr/bin/awk '{print $5}'`
        fi

        if [ -z "${MAC_ADDRESS1}" ] ; then
            MAC_ADDRESS1=`/sbin/ifconfig -a | /bin/grep eth0 | /usr/bin/awk '{print $5}'`
        fi

        /bin/echo "eth0 ${MAC_ADDRESS0}" > /etc/mactab
        /bin/echo "eth1 ${MAC_ADDRESS1}" >> /etc/mactab
   fi
fi

/sbin/service network start
#### end for dell ####

exit

