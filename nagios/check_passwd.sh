for ip in `cat iplist.bak`
do
	if [ ! -z "$ip" ]; then
		#echo $ip;
		ssh $ip "grep -E 'twitter|newtw|sohutw' /etc/passwd" && echo $ip
	fi
done
