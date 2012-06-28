#!/bin/sh
###restart all nginx#####
###rsync to nginx#####
src="/opt/nginx/conf/extra/*"
for ip in `cat nginx.txt`
   do rsync -avzq  --progress $src $ip:/opt/nginx/conf/extra/ ;ssh $ip  '/root/bin/nginx.sh restart'
done
