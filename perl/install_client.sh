#!/bin/sh
for ip in `cat $1|grep -v '^#'|grep -v '^$'`
do
    if [ ! -z "$ip" ]; then
        echo $ip;
		ssh $ip "mkdir -p /opt/work/worker";
        scp $2 $ip:/opt/work/worker/;
        ssh $ip "perl /opt/work/worker/$2";
        #ssh $ip "/opt/work/clean_worker.sh";
        #ssh $ip "cd /opt/work; tar zxvf $1; cd File-ReadBackwards-1.05;perl Makefile.PL; make; make install; cd ..; rm -rf File-ReadBackwards-1.05; rm -rf $1";
        #ssh $ip "cd /opt/work; tar zxvf $1; cd $srcdir;perl Makefile.PL; make; make install; cd ..; rm -rf $srcdir; rm -rf $1";
    fi
done
