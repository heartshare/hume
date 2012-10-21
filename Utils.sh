#!/bin/bash

usage(){
        echo "Usage: `basename $0` [-i invoke_time_limit | -w waringcount | -c criticalcount | -m minutes_to_read] log_file"
        exit 3
}

while getopts "i:w:c:m:h" flag
do
        case $flag in
        h) usage ;;
        i) invoke_limit=$OPTARG ;;
        w) warning_count=$OPTARG ;;
        c) critical_count=$OPTARG ;;
        m) minu_read=$OPTARG ;;
        esac
done
 

OPTIND The index of the next argument to be processed by the getopts builtin command  (see SHELL BUILTIN COMMANDS below).

shift $((OPTIND-1))
scallop_log=$1
if [ -z "$scallop_log" ] || [ ! -f $scallop_log ]
then
        usage
fi


tac $scallop_log |grep 'method process stat'|\
        awk '{print $1, $2, $6, $8}'|\
        awk -F '[-: ]' -vcur_year=$year -vinvoke_limit=$invoke_limit -vwarning_count=$warning_count -vcritical_count=$critical_count -vminu_read=$minu_read '
        function report(){
                if(count > critical_count){
                        printf("CRITICAL - ")
                        exit_status=2;
                }else if(count > warning_count){
                        printf("WARNING - ")
                        exit_status=1;
                }else{
                        printf("INVOKE OK - ");
                        exit_status=0;
                }
                printf("total(slow_count:%d);", count);
                if(exit_status > 0){
                        # get top3 invoke
                        n = asort(sum, ssum)
                        thirdcount = ssum[n - 1]
                        for(m in sum){
                                if(sum[m] >= thirdcount){
                                printf("%s(slow_count:%d);", m, sum[m]);
                                }
                        }
                }
                printf("|t=%s\n", count);
                exit(exit_status);
        }
        BEGIN {
                # print now, cur_year, invoke_limit, warning_count, critical_count, minu_read;
                now=systime();
                count=0;
                exit_status=3;

        }
        {
                # convert date string to senconds in order to compare
                t=mktime(cur_year" "$1" "$2" "$3" "$4" "$5);
                method=$6
                invoket=$7

                # check invoke time is exceed limit
                if(invoket >= invoket_limit){
                        count=count+1;
                        sum[method]=sum[method] + 1;
                }

                # avoid too mush record to process
                if(NR > 5000){
                        report();
                }
                # if record reach time interval, stop process it
                if(now - t > minu_read*60){
                        report();
                }

        }
        END {
                if(exit_status < 0 || exit_status > 2) {
                        report();
                }
        }
        '




servicelist="/usr/local/nagios/libexec/service.cfg";

while read line
do
    xxx

done<$servicelist



if [[ $file_count -eq 0 ]];then

fi


if [ $tmptopic -ge 30 ];then
    let "crit=$crit+2"
    st="${st} tmptopic is $tmptopic"
elif [ $warn -ge 10 ];then
    let "warn=$warn+1"
    st="${st} tmptopic is $tmptopic"
fi




# check proc by name

#!/bin/sh

check_time_line=`ps -ef|grep $1|grep -v grep|grep -v $0`

if [ -z  "$check_time_line" ];then
    echo "process die!"
    exit 2
else
    echo " $1 run ok"
    exit 0
fi


dig archlinux.org | grep "Query time"
