#!/bin/sh
for ip in `cat $2|grep -v '^#'|grep -v '^$'`
do
	if [ ! -z "$ip" ]; then
		echo $ip;
		#scp $1 root@$ip:/opt/check_float_cacti.pl
		#ssh $ip "chmod +x /opt/check_float_cacti.pl"
		#ssh $ip "/etc/init.d/snmpd restart";
		ssh $ip "mkdir -p /opt/work/";
		scp $1 root@$ip:/opt/work/;
		#ssh $ip "sed -i '/check_float/d' /var/spool/cron/root";
		#scp $2 root@$ip:/opt/work;
		ssh $ip "perl /opt/work/$1";
		#ssh $ip "cd /opt/work; tar zxvf $1; cd File-ReadBackwards-1.05;perl Makefile.PL; make; make install";
		#ssh $ip crontab -l |  perl -e 'while (<STDIN>){ print $_;} print ls;' | ssh $ip crontab;
		#ssh $ip crontab -l |  perl -e 'while (<STDIN>){ print $_;} print "*/3 * * * * perl /opt/work/check_float_cacti.pl\n";' | ssh $ip crontab;
	fi
done
