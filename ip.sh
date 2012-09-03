#!/bin/bash
#Purpose: 查找ip地址所在地
ipp (){
        exec < $1
        while read a
        do
                sring=`curl -s "http://ip138.com/ips138.asp?ip=${a}&action=2"| iconv -f gb2312 -t utf-8|grep '<ul class="ul1"><li>' | awk -F '[<> ]+' '{print substr($7
                ,7)}'`
                echo $a $sring
        done
}

case $1 in
        -f)
                shift
                ipp $1
                ;;
        -i)
                shift
                sring=`curl -s "http://ip138.com/ips138.asp?ip=${1}&action=2"| iconv -f gb2312 -t utf-8 |grep '<ul class="ul1"><li>' | awk -F '[<> ]+' '{print substr($7,7)}'`
                echo $1 $sring
                ;;
        *)
                echo "[Help]
                $0 need -f or -i
                -f ------- argument is a file
                -i ------- argument is a IP
                [For example]:
                $0 -f filename
                $0 -i ipadress
                "
                ;;
esac
