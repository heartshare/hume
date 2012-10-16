#!/bin/sh

for DIR in `cat /opt/work/log.txt`
do
    find $DIR -path "/opt/tms/resin/log/updateusername" -prune -o -ctime +3 -name "*.log.*" -type f -exec rm -f {} \;
done
