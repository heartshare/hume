#!/bin/sh
for ip in `cat test.txt`
do
	if [ ! -z "$ip" ]; then
		echo $ip;
		#scp $1 root@$ip:/opt/check_float_cacti.pl
		#ssh $ip "chmod +x /opt/check_float_cacti.pl"
		#ssh $ip "sed -i 's/-Lsd//' /etc/init.d/snmpd";
		#ssh $ip "/etc/init.d/snmpd restart";
		#scp $1 root@$ip:/opt/work;
		rsync -avzq --progress $1 root@$ip:/opt/soft/$1/;
		ssh $ip "cd /opt/soft/nginx-1.0.0; ./configure --user=www --group=www --prefix=/opt/nginx --with-http_ssl_module --with-http_stub_status_module --add-module=/opt/soft/passport_2010/nginx; sed -i 's/-Werror//g' objs/Makefile";
		#ssh $ip "cd /opt/work; tar zxvf $1; cd File-ReadBackwards-1.05;perl Makefile.PL; make; make install";
		#ssh $ip crontab -l |  perl -e 'while (<STDIN>){ print $_;} print ls;' | ssh $ip crontab;
		#ssh $ip crontab -l |  perl -e 'while (<STDIN>){ print $_;} print "*/1 * * * * perl /opt/check_float_cacti.pl\n";' | ssh $ip crontab;
	fi
done
