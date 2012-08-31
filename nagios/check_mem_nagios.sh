#!/bin/sh
for ip in `cat nagios_host`
do
	echo $ip
	scp /root/xiahou/check_mem.sh $ip:/usr/local/nagios/libexec/check_mem.sh
done
