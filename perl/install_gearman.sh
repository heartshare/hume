#!/bin/sh
for ip in `cat $1|grep -v '^#'|grep -v '^$'`
do
    if [ ! -z "$ip" ]; then
        echo $ip;
        ssh $ip "mkdir -p /opt/work/";
        scp $2/* $ip:/opt/work;
        ssh $ip "cd /opt/work; tar zxvf String-CRC32-1.4.tar.gz; cd String-CRC32-1.4; perl Makefile.PL; make; make install; cd ..; rm -rf String-CRC32-1.4";
        ssh $ip "cd /opt/work; tar zxvf Sys-Syscall-0.23.tar.gz; cd Sys-Syscall-0.23; perl Makefile.PL; make; make install; cd ..; rm -rf Sys-Syscall-0.23"; 
        ssh $ip "cd /opt/work; tar zxvf Danga-Socket-1.61.tar.gz; cd Danga-Socket-1.61; perl Makefile.PL; make; make install; cd ..; rm -rf Danga-Socket-1.61";
        ssh $ip "cd /opt/work; tar zxvf Gearman-1.11.tar.gz; cd Gearman-1.11; perl Makefile.PL; make; make install; cd ..; rm -rf Gearman-1.11";
        ssh $ip "cd /opt/work; tar zxvf Gearman-Server-1.11.tar.gz; cd Gearman-Server-1.11; perl Makefile.PL; make; make install; cd ..; rm -rf Gearman-Server-1.11";
        #ssh $ip "cd /opt/work; tar zxvf $1; cd File-ReadBackwards-1.05;perl Makefile.PL; make; make install; cd ..; rm -rf File-ReadBackwards-1.05; rm -rf $1";
        #ssh $ip "cd /opt/work; tar zxvf $1; cd $srcdir;perl Makefile.PL; make; make install; cd ..; rm -rf $srcdir; rm -rf $1";
    fi
done
