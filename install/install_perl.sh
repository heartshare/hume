#!/bin/sh

if [ ! $# -eq 2 ]; then
    echo "need 2 args";
    exit 0;
fi

host=$1
package=$2

if [ -f "$package.tar.gz" ]; then
    scp $package.tar.gz $host:~/;
    ssh $host "tar zxvf $package.tar.gz; cd $package; perl Makefile.PL; make; make install"
fi
