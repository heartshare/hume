#/bin/sh

pt-fifo-split infile.txt --fifo /tmp/my-fifo --lines 1000000
while [ -e /tmp/my-fifo ]; do
   mysql -e "set foreign_key_checks=0; set sql_log_bin=0; set unique_checks=0; load data local infile '/tmp/my-fifo' into table load_test fields terminated by '\t' lines terminated by '\n' (col1, col2);"
   sleep 1;
done


#pt-fifo-split --lines 1000000 hugefile.txt
#while [ -e /tmp/pt-fifo-split ];
#do
#    cat /tmp/pt-fifo-split;
#done
