#!/bin/sh

logs_path="/opt/nginx/logs/"
old_logs_access=$(date --date="10 day ago" +"%Y/%m/access.%Y.%m.%d.log")
old_logs_error=$(date --date="10 day ago" +"%Y/%m/error.%Y.%m.%d.log")

mkdir -p ${logs_path}$(date -d "yesterday" +"%Y")/$(date -d "yesterday" +"%m")/

mv ${logs_path}access.log ${logs_path}$(date -d "yesterday" +"%Y")/$(date -d "yesterday" +"%m")/access.$(date -d "yesterday" +"%Y.%m.%d").log

mv ${logs_path}error.log ${logs_path}$(date -d "yesterday" +"%Y")/$(date -d "yesterday" +"%m")/error.$(date -d "yesterday" +"%Y.%m.%d").log

/opt/nginx/nginx.sh restart

rm -rf $logs_path$old_logs_access
rm -rf $logs_path$old_logs_error

gzip ${logs_path}$(date -d "yesterday" +"%Y")/$(date -d "yesterday" +"%m")/access.$(date -d "yesterday" +"%Y.%m.%d").log

gzip ${logs_path}$(date -d "yesterday" +"%Y")/$(date -d "yesterday" +"%m")/error.$(date -d "yesterday" +"%Y.%m.%d").log
