#!/bin/sh
echo "###host load###"
AVER=`cat /proc/loadavg |awk '{print $1,$2,$3}'`
KER=`uname -a|grep xen`
if [ -z "$KER" ];then
	IP=`ifconfig -a|grep 'inet addr'|awk '{print $2;}'|cut -d: -f2|egrep -v '(127|192|10|172|169)\.'|head -n 1`
	if [ -z "$IP" ];then
        	IP="NULL"
	fi
	MODEL=`cat /proc/cpuinfo | egrep "model name"|awk -F: '{print $2}'|sort|uniq|awk '$1=$1'`
        if [ -z "$MODEL" ];then
	        MODEL="NULL"
     	fi
        KVM=`echo "$MODEL"|egrep 'QEMU'`
        if [ ! -z "$KVM" ];then
                echo "|""$IP""|""$AVER""|""kvm guest|kvm guest|kvm guest|kvm guest|kvm guest|kvm guest|kvm guest|kvm guest|kvm guest"
                exit
        fi
	PCPU=`cat /proc/cpuinfo | grep "physical id"| sort | uniq | wc -l`
       	if [ "$PCPU" -eq "0" ];then
                PCPU="1"
        fi
	CORE=`cat /proc/cpuinfo | grep "cpu cores" |head -n 1|awk '{print $4}'`
	if [ -z "$CORE" ];then
		CORE="1"
	fi
	HT=`cat /proc/cpuinfo | grep "siblings"|head -n 1|awk '{print $3}'`
	if [ -z "$HT" ];then
               HT="1"
        fi
	if [ "$CORE" -eq "$HT" ];then
                HT="N"
	else 
		HT="Y"
       	fi
	LCPU=`cat /proc/cpuinfo | grep "processor" | wc -l`
       	if [ -z "$LCPU" ];then
               	LCPU="NULL"
       	fi
	MEM=`cat /proc/meminfo|egrep "^MemTotal"|awk '{printf ("%d\n",$(NF-1)/1000)}'`
	DISK_TOTAL1=`df -Pk|egrep -v '^(Filesys|none|devfs|tmpfs)' |awk '{sum=$2+sum;}END{print sum}'`
	DISK_TOTAL=$(($DISK_TOTAL1/1000))
	DISK_USED1=`df -Pk|egrep -v '^(Filesys|none|devfs|tmpfs)' |awk '{sum=$3+sum;}END{print sum}'`
	DISK_USED=$(($DISK_USED1/1000))
	echo "|""$IP""|""$AVER""|""$MODEL""|""$PCPU""|""$CORE""|""$HT""|""$LCPU""|""$MEM""M|""$DISK_TOTAL""M|""$DISK_USED""M|""$(($DISK_USED*100/$DISK_TOTAL))""%" 
else 
	IP=`ifconfig -a|grep 'inet addr'|awk '{print $2;}'|cut -d: -f2|egrep -v '(127|192|10|172)\.|head -n 1'`
        if [ -z "$IP" ];then
                IP="NULL"
        fi
	XEN_GUEST=`egrep xvc /proc/devices`
	if [ -z "$XEN_GUEST" ];then
		echo "|""$IP""|""$AVER""|""xen guest|xen guest|xen guest|xen guest|xen guest|xen guest|xen guest|xen guest|xen guest"	
		exit
	fi
        ERR=`xm info 2>&1`
        ERR=`echo "$ERR"|egrep '^Error'`
        if [ ! -z "$ERR" ];then
		echo "|""$IP""|""$AVER""|""xend error|xend error|xend error|xend error|xend error|xend error|xend error|xend error|xend error" 
		exit
        fi

        MODEL=`cat /proc/cpuinfo | egrep "model name"|awk -F: '{print $2}'|sort|uniq|awk '$1=$1'`
        if [ -z "$MODEL" ];then
                MODEL="NULL"
        fi      

        PCPU=`xm info|grep sockets_per_node|awk '{print $NF}'`
        CORE=`xm info|grep cores_per_socket|awk '{print $NF}'`
        HT=`xm info|grep threads_per_core|awk '{print $NF}'`
        if [ "$HT" -eq "2" ];then
                HT="Y"
        else    
                HT="N"
        fi      
	LCPU=`xm info|grep nr_cpus|awk '{print $NF}'`
        MEM=`cat /proc/meminfo|egrep "^MemTotal"|awk '{printf ("%d\n",$(NF-1)/1000)}'`
        DISK_TOTAL1=`df -kP|egrep -v '^(Filesys|none|devfs|tmpfs)' |awk '{sum=$2+sum;}END{print sum}'`
        DISK_TOTAL=$(($DISK_TOTAL1/1000))
        DISK_USED1=`df -kP|egrep -v '^(Filesys|none|devfs|tmpfs)' |awk '{sum=$3+sum;}END{print sum}'`
        DISK_USED=$(($DISK_USED1/1000))
	echo "|""$IP""|""$AVER""|""$MODEL""|""$PCPU""|""$CORE""|""$HT""|""$LCPU""|""$MEM""M|""$DISK_TOTAL""M|""$DISK_USED""M|""$(($DISK_USED*100/$DISK_TOTAL))""%"
fi

