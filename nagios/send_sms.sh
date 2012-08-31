#!/bin/bash
function sendsms()
{
        echo "sms start";
        con="$1";
        mo="$2";
        con=`echo $con |perl -pi -e 's|%|%25|g'`;
        #echo "con="$con;
        #echo "m="$m;
        v="ce78aad68515a946f2de404fa5229db9";
        sp="1069006016";
        for m in $mo
        do
                curl -d "con=$con&m=$m&v=$v&sp=$sp"  'http://192.168.105.174/smssend.do';
        done
        echo "sms over";

}
#con="/statuses/friends_timeline.*";
#m="13600001111";
sendsms "$1" "$2";

