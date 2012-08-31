#!/bin/sh

#source /root/.bashrc

#echo `date +%T` >>/root/test.log
#echo "hello" >>/root/test.log


EXITS=`ps aux | grep inotifywait | grep -v grep`
if [ ! -z "$EXITS" ]; then
	echo "===" >>/root/test.log
	echo `date +%T` >>/root/test.log
	echo "inotifywait process exists, exiting..." >>/root/test.log
	echo "===">>/root/test.log
	exit 0;
fi
#
##if [ -f /root/xiahou/nagios-check.lock ]; then
##	exit 0
##fi
#
##touch /root/xiahou/nagios-check.lock
#
#-mrq --timefmt '%d/%m/%y %H:%M' --format  '%T %w%f %e' \
/usr/bin/inotifywait \
-e modify -r /usr/local/nagios/etc | while read file event
#-e modify,create,move /usr/local/nagios/etc/objects/*.cfg | while read date time file event
#/usr/local/bin/inotifywait -e modify  -t 60 /usr/local/nagios/etc/objects/*.cfg | while read files t2 t3
do
	#echo "hello, world" >>/root/test.log
	/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg >> /root/nagios_check.log & 2>1
	#| dialog --msgbox 40 80
	echo $file
	echo $event
done
echo "===========================================================================">>/root/test.log
#echo `date +%T` >>/root/test.log
#echo "hello, world 2" >>/root/test.log

#rm /root/xiahou/nagios-check.lock

#exit 0
