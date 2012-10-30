#!/bin/sh
for ip in `cat $1|grep -v '^#'|grep -v '^$'`
do
    if [ ! -z "$ip" ]; then
        echo $ip;
        ssh $ip "mkdir -p /opt/work/";
        scp $2 $ip:/opt/work;
        ssh $ip "cd /opt/work; tar zxvf Linux-Inotify2-1.22.tar.gz ; cd  Linux-Inotify2-1.22; perl Makefile.PL; make; make install; cd ..; rm -rf  Linux-Inotify2-1.22";
    fi
done
