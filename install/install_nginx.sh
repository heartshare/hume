#!/bin/bash
#author hongwei
#install nginx

#ssh $1 "yum -y install gcc gcc-c++ autoconf libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel openldap openldap-devel nss_ldap openldap-clients openldap-servers"

ssh $1 "mkdir /opt/soft/;cd /opt/soft;wget -O passport_2010.tar.gz 'http://192.168.12.155/software/passport_2010.tar.gz';tar xvfz passport_2010.tar.gz"

ssh $1 "cd /opt/soft;wget -O pcre-8.10.tar.gz 'http://192.168.12.155/software/nginx/pcre-8.10.tar.gz';tar xvfz pcre-8.10.tar.gz;cd pcre-8.10;./configure ;make;make install"

ssh $1 "useradd -s /sbin/nologin www;cd /opt/soft;wget -O nginx-1.0.0.tar.gz 'http://192.168.12.155/software/nginx/nginx-1.0.0.tar.gz';tar xvfz nginx-1.0.0.tar.gz;cd nginx-1.0.0;./configure --user=www --group=www --prefix=/opt/nginx --with-http_ssl_module --with-http_stub_status_module --add-module=/opt/soft/passport_2010/nginx;make;make install;"

ssh $1 "mkdir /opt/nginx/conf/extra ;cd /opt/soft/passport_2010;cp passport_tw.conf passport_20100819.pub sohu_passport_rsa1024.pub /opt/nginx/conf/extra/"

ssh $1 "sed -i '117s/^/&    include     extra\/passport_tw.conf;\n/' /opt/nginx/conf/nginx.conf"

#ssh $1 "/opt/nginx/sbin/nginx"

echo "####all finish###"
#ssh $1 "ps aux |grep nginx"
