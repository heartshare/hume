#!/bin/sh
for ip in `cat nagios_host`
do
	if [ ! -z "$ip" ]; then
		echo $ip;
		scp $1 root@$ip:/opt/check_float_cacti.pl
		ssh $ip "chmod +x /opt/check_float_cacti.pl"
		ssh $ip "sed -i '/float_cacti/d' /var/spool/cron/root";
		#ssh $ip crontab -l |  perl -e 'while (<STDIN>){ print $_;} print ls;' | ssh $ip crontab;
		ssh $ip crontab -l |  perl -e 'while (<STDIN>){ print $_;} print "*/1 * * * * perl /opt/check_float_cacti.pl\n";' | ssh $ip crontab;
	fi
done
