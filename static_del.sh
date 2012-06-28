#!/bin/bash
/bin/cat /root/static_41500000.txt | while read oneline
do 
	dir2=`expr $oneline % 100`
	q=`expr $oneline / 100`
	dir1=`expr $q % 100`
	f=/alumni/htdocs/club/$dir2/$dir1/$oneline"*.html"
	echo $f
	rm -f $f
done
df -k
