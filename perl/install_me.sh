#!/bin/sh
for ip in `cat $1|grep -v '^#'|grep -v '^$'`
do
	if [ ! -z "$ip" ]; then
		echo $ip;
		ssh $ip "echo $ip > /opt/work/me.ip";
	fi
done
