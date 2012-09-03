#! /bin/sh
#
# db2 database server start/stop script


PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
NAME=db2
DESC="database manager"
DB2DIR="/opt/ibm/db2/V9.7/"

set -e

case "$1" in
  start)
	echo -n "Starting $DESC: "
	if [ -x ${DB2DIR?}/instance/db2istrt ]; then
    		${DB2DIR?}/instance/db2istrt
	fi
	echo "$NAME."
	echo
	;;
  stop)
	echo -n "Stopping $DESC: "
	su - db2inst1 -c "sh ~/stopall_inst" > /dev/null
	echo -n "$NAME "
	su - dasusr1 -c "sh ~/stopall_das" > /dev/null
	echo "das."
	echo
	;;
  restart|force-reload)
	$0 stop
	sleep 2
	$0 start
	;;
  *)
	N=/etc/init.d/$NAME
	echo "Usage: $N {start|stop|restart}" >&2
	exit 1
	;;
esac

exit 0
