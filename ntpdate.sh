for ip in `cat iplist.bak`
do
	if [ ! -z "$ip" ]; then
		echo $ip;
		ssh $ip crontab -l |  perl -e 'while (<STDIN>){ if ($_ =~ /ntpdate/){ print "#", $_;} else {print $_;}}' | ssh $ip crontab;
	fi
done
