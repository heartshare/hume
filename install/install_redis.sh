#!/bin/sh
ip=$1
scp -r redis $ip:/root
ssh $1 "cd /root/redis; \
        tar zxvf redis-2.4.7.tar.gz; \
        cd redis-2.4.7;\
        make;\
        mkdir -p /opt/redis/bin;\
        mkdir /opt/redis/log/;\
        cd /root/redis/redis-2.4.7/src; \
        cp redis-server redis-benchmark redis-cli /opt/redis/bin/.; \
        cp -r /root/redis/conf /opt/redis/; \
        cp /root/redis/st*.sh /opt/redis/bin/;\
        sed -i "s#10.10.81.19#$1#g" /opt/redis/conf/redis.conf"

