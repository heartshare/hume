#!/bin/sh
PIDF="/opt/nginx/nginx.pid"
PID=0
if test -e $PIDF
then
	PID=`cat $PIDF`
	NUM=`ps aux | grep -c $PID`
	if [ $NUM -lt 2 ]
	then
		rm -rf $PIDF
		PID=0
	fi
fi

if [ $# -lt 1 ]
then
	echo "Usage:sh $0 {start|stop|reload}"
	exit
fi
case "$1" in
     reload)
	if [ $PID -lt 1 ]
	then
		echo "no nginx run"
		exit
	fi
	/opt/nginx/sbin/nginx -s reload
	echo "nginx was reload"
     ;;
     start)
	if [ $PID -gt 0 ]
	then
		echo "nginx is running"
		exit
	fi
	/opt/nginx/sbin/nginx	
	echo "nginx was started"
     ;;
     stop)
	if [ $PID -lt 1 ]
	then
		echo "no nginx run"
		exit
	fi
	/opt/nginx/sbin/nginx -s stop
	echo "nginx was stoped"
     ;;
     restart)
	sh $0 stop	
	sleep 3
	sh $0 start	
     ;;
esac

