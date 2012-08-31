#!/bin/bash

# test network width

function usage

{

	echo "Usage: $0  "

	echo "    e.g. $0 eth0 2"

	exit 65

}


if [ $# -lt 2 ];then
usage
fi
typeset in in_old dif_in
typeset out out_old dif_out
typeset timer
typeset eth

eth=$1
timer=$2

in_old=$(cat /proc/net/dev | grep $eth | sed -e "s/\(.*\)\:\(.*\)/\2/g" | awk ' { print $1 }' )
out_old=$(cat /proc/net/dev | grep $eth | sed -e "s/\(.*\)\:\(.*\)/\2/g" | awk ' { print $9 }' )

#while true
#do
sleep ${timer}
in=$(cat /proc/net/dev | grep $eth | sed -e "s/\(.*\)\:\(.*\)/\2/g" | awk ' { print $1 }' )
out=$(cat /proc/net/dev | grep $eth | sed -e "s/\(.*\)\:\(.*\)/\2/g" | awk ' { print $9 }' )
dif_in=$(((in-in_old)/timer))
dif_out=$(((out-out_old)/timer))
echo "IN: ${dif_in} Byte/s OUT: ${dif_out} Byte/s "
in_old=${in}
out_old=${out}
#done

exit 0
