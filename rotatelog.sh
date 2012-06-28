#!/bin/sh

export PATH=$PATH:/usr/bin:/sbin

OS_TYPE=`uname -an | awk '{print $1}'`
hostip="10.15.9.18"

if [ -z "$hostip" ]
then
	echo "Couldn't Get IP address"
	exit
fi

default_apache_access_log=/opt/apache2/logs/access_log
default_apache_error_log=/opt/apache2/logs/error_log

if [ -e $default_apache_access_log ]
then
	mv $default_apache_access_log $default_apache_access_log.$hostip
	mv /opt/apache2/logs/classpic/access_log /opt/apache2/logs/classpic/access_log.$hostip
	#echo "$hostip: default access log" >> /tmp/mylog
	/opt/apache2/bin/apachectl graceful
	gzip -f $default_apache_access_log.$hostip
	gzip -f /opt/apache2/logs/classpic/access_log.$hostip
	cat /dev/null > $default_apache_error_log
	cat /dev/null > /opt/apache2/logs/classpic/error_log
fi

