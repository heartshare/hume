#!/bin/sh
for ip in `cat iplist.bak`
do
	if [ ! -z "$ip" ]; then
		echo $ip;
		scp $1 root@$ip:~/check_float_cacti.pl
		ssh $ip "chmod +x /root/check_float_cacti.pl"
		ssh $ip "sed -i '/float_cacti/d' /var/spool/cron/root";
		#ssh $ip crontab -l |  perl -e 'while (<STDIN>){ print $_;} print ls;' | ssh $ip crontab;
		ssh $ip crontab -l |  perl -e 'while (<STDIN>){ print $_;} print "*/1 * * * * perl /root/check_float_cacti.pl\n";' | ssh $ip crontab;
	fi
done
