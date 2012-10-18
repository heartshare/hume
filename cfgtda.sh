#!/bin/sh
#
# Name: cfgtda.sh
#
# Purpose:
#	Modify some network setting by changing some control files
#
# Notes:
#	cfgtda.sh
#	cfgtda.sh -t timer.chinaren.com
#	cfgtda.sh -d "61.135.132.1 192.168.131.1"
#	cfgtda.sh -a http://61.135.132.201
#
# Author:
#	yangming(yangming@sohu-inc.com)
#
# Version:
#	0.99
#
# Date:
#	2004.02.23

ver=`head -1 /etc/issue | awk '{print $5}'`

# ----------------------------
# Subroutine to echo the usage
# ----------------------------

usage()
{
 echo "USAGE: $CALLER [-t address] [-d address] [-a address]"
 echo "WHERE: -t = modify the timer server's address"
 echo "       -d = modify the dns server's address"
 echo "       -a = modify the apt server's address"
 exit 1
}

# ----------------------------------
# Subroutine to terminate abnormally
# ----------------------------------

terminate()
{
 echo "The execution of $CALLER was not successful."
 echo "$CALLER terminated, exiting now with rc=1."
 dateTest=`date`
 echo "End of testing at: $dateTest"
 echo ""
 exit 1
}

# ------------------------------
# Subroutine to check ip address
# ------------------------------

isip()
{
#	if LANG=C echo $i | egrep -L "^[0-9]*.[0-9]*.[0-9]*.[0-9]*" > /dev/null; then
	if [ -z `echo $1 | grep "^[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}$"` ]; then
		return 1
	else
		return 0
	fi
}

# -------------------------------------
# Subroutine to modify the timer server
# -------------------------------------

do_mts()
{
	echo "`crontab -l | grep -v rdate`
`date '+%M %H'` * * * rdate -s $newts;clock -w" | crontab -
}

# -----------------------------------
# Subroutine to modify the dns server
# -----------------------------------

do_mds()
{
	tr=`mktemp /tmp/resolv.XXXXXX`
	echo "tr:$tr"
	echo `grep -v nameserver /etc/resolv.conf` >> $tr
	for ns in $1; do
		if isip "$ns"; then
			echo "nameserver $ns"
			echo "nameserver $ns" >> $tr
		else
			echo "$ns is not a available ip address."
		fi
	done
	cat $tr > /etc/resolv.conf
	rm -f $tr
}

# -----------------------------------
# Subroutine to modify the apt server
# -----------------------------------

do_mas()
{
	proto=`echo $1 | awk -F: '{print $1}'`
	if [ $proto != "http" -a $proto != "ftp" -a $proto != "nfs" ]; then
		echo "the argument \"$1\" is not suitable."
		echo "example: http://192.168.1.201"
		exit
	fi
	echo "rpm $1 pub/os/Linux/RedHat/$ver os updates" > /etc/apt/sources.list
}

CALLER=`basename $0`

mts=0
mds=0
mas=0
while getopts ht:d:a: opt
do
  case "$opt" in
   t)
	mts=1
	newts=$OPTARG
   ;;
   d)
	mds=1
	newds=$OPTARG
   ;;
   a)
	mas=1
	newas=$OPTARG
   ;;
   \?) usage ; exit 1 ;;
  esac
done

[ $mts -eq 1 ] && do_mts "$newts"
[ $mds -eq 1 ] && do_mds "$newds"
[ $mas -eq 1 ] && do_mas "$newas"
[ $mts -eq 1 -o $mds -eq 1 -o $mas -eq 1 ] && exit

CON_DIR="/etc/sysconfig/network-scripts"
CWD=`pwd`
cd $CON_DIR

interfaces=`ls ifcfg* | LANG=C egrep -v '(ifcfg-lo|:|rpmsave|rpmorig|rpmnew)' | \
            LANG=C egrep -v '(~|\.bak)$' | \
            LANG=C egrep 'ifcfg-[A-Za-z0-9_-]+$' | \
            sed 's/^ifcfg-//g'`
pprefix="0"
newargs="0"
for i in $interfaces; do
	eval $(fgrep "DEVICE=" ifcfg-$i)
	if [ -z "$DEVICE" ]; then DEVICE="$i"; fi
	if LANG=C egrep -v "^ONBOOT=\"?[Nn][Oo]\"?" ifcfg-$i > /dev/null; then
		continue
	fi
	. ifcfg-$i
	if [ $BOOTPROTO != "static" ]; then
		continue
	fi
	echo "The ip of interface $i:$IPADDR"
	if [ -z "$NETMASK" ]; then
		eval `/bin/ipcalc --netmask ${IPADDR}`
	fi
	echo "netmask is:$NETMASK"
	if [ -z "$BROADCAST" ]; then
		eval `/bin/ipcalc --broadcast ${IPADDR} ${NETMASK}`
	fi
	echo "broadcast is:$BROADCAST"
	if [ -z "${PREFIX}" ]; then
		eval `/bin/ipcalc --prefix ${IPADDR} ${NETMASK}`
	fi
	if [ -z "${NETWORK}" ]; then
		eval `/bin/ipcalc --network ${IPADDR} ${NETMASK}`
	fi
	if [ `echo "${NETWORK}" | grep "^192.168."` ]; then
		pprefix=${NETWORK}
	fi
	if [ $ver = "6.2" -o $ver = "7.0" -o $ver = "7.1" -o $ver = "7.2" -o $ver = "7.3" ]; then
		if [ -f /etc/sysconfig/static-routes ]; then
			grep "^any" /etc/sysconfig/static-routes | while read ignore args ; do
				echo "Ur current static-routes table is:$args"
			done
		fi
	else
        	if [ $ver = "8.0" -o $ver = "9" ]; then
                	if [ -f /etc/sysconfig/networking/devices/$i.route ]; then
				. /etc/sysconfig/networking/devices/$i.route
				routenum=0
				while [ "x$(eval echo '$'ADDRESS$routenum)x" != "xx" ]; do
					eval `/bin/ipcalc -p $(eval echo '$'ADDRESS$routenum) $(eval echo '$'NETMASK$routenum)`
					line="$(eval echo '$'ADDRESS$routenum)/$PREFIX"
					if [ "x$(eval echo '$'GATEWAY$routenum)x" != "xx" ]; then
						line="$line via $(eval echo '$'GATEWAY$routenum)"
					fi
					line="$line dev $1"
					echo "Ur static-routesusing $i table is:$line"
					routenum=$(($routenum+1))
				done
			fi
		fi
	fi
done

echo -n "Ur current DNS server is:"
nameservers=`grep nameserver /etc/resolv.conf | awk '{print $2}'`
cords="0"
badds="0"
for j in $nameservers
do
	echo -n "$j "
	re=
	re=`echo "$j" | grep "^192.168"`
	if [ "$re" != "" -a "$pprefix" = "0" ]; then
		if [ "$badds" = "0" ]; then
			badds="$j"
		else
			badds="$badds $j"
		fi
	else
		if [ "$cords" = "0" ]; then
			cords="$j"
		else
			cords="${cords} $j"
		fi
	fi
done
echo
if [ $badds != "0" ]; then
	if [ "$cords" = "0" ]; then
		cords="61.135.132.1 61.135.131.1"
	fi
	echo "nameserver $badds is not reachable, pls use $CALLER -d $cords to delete it!"
	newargs=" -d \"$cords\""
fi
apturl="0"
aptserver="0"
apturl=`grep "^rpm" /etc/apt/sources.list | awk '{print $2}'`
aptserver=`echo $apturl | awk -F\/ '{print $3}'`
echo "Ur apt url is:$apturl;apt server is:$aptserver"
re=
re=`echo "$aptserver" | grep "^192.168"`
if [ "$re" != "" -a "$pprefix" = "0" ]; then
	newargs="$newargs -a \"http://61.135.132.201\""
fi
echo "Ur timer server is:`crontab -l | grep rdate | awk '{print $8}' | awk -F\";\" '{print $1}'`"
cd $CWD
echo $CALLER $newargs
