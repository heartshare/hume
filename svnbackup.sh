#!/bin/sh  
#by 崔元荣
#QQ：295749093 
#svn多功能备份脚本！ 
svnbak_remote_dir=/data/192.168.1.7_svn/   

###################################  
BACKUPDIR=/var/svnbackup  

###################################  
SVNDIR=/var/svn  

###################################  
ProjectLst=$BACKUPDIR/projectlist.txt  

###################################  
LogFile=$BACKUPDIR/svnback.log  
History_LogFile=$BACKUPDIR/history_svnback.log  
DATE=`date +%Y%m%d-%T`  

# - This is the path to the directory you want to archive  
###################################  
export PATH=$PATH:/bin:/usr/bin:/usr/local/bin  

# our actual rsyncing function 
do_accounting()  
{  
        echo " " > $LogFile  
        echo " " >> $LogFile  
        echo " " >> $LogFile  
        echo "###########################" >> $LogFile  
        echo "$DATE" >> $LogFile  
        echo "###########################" >> $LogFile  

        echo " " >> $History_LogFile  
        echo " " >> $History_LogFile  
        echo "###########################" >> $History_LogFile  
        echo "$DATE" >> $History_LogFile  
        echo "###########################" >> $History_LogFile  

        cd $BackDir  
}  

do_svndump()  
{  
        PROJECTLIST=`cat $ProjectLst`  
        cd $SVNDIR  
        for project in $PROJECTLIST  
        do  
                echo "begin to dump $project databases" >> $LogFile  
                echo "begin to dump $project databases" >> $History_LogFile  
                if [ ! -f $BACKUPDIR/$project.dump ]  
                then 
                        YOUNGEST=`svnlook youngest $project`  
                        svnadmin dump $project > $BACKUPDIR/$project.dump  
                        if [ $? != 0 ];then 
                                echo "full-backup faild" >> $LogFile  
                                echo "full-backup faild" >> $History_LogFile   
                        else 
                                echo "OK,dump file successfully!!" >> $LogFile  
                                echo "OK,dump file successfully!!" >> $History_LogFile   
                        fi  
                        echo "$YOUNGEST" > $BACKUPDIR/$project.youngest  
                else 
                        echo "$project.dump existed,will do increatment job" >> $LogFile  
                        echo "$project.dump existed,will do increatment job" >> $History_LogFile   
                        if [ ! -f $BACKUPDIR/$project.youngest ]  
                        then 
                                echo "error, no youngest check!" >> $LogFile  
                                echo "error, no youngest check!" >> $History_LogFile  
                        else 
                                PREVYOUNGEST=`cat $BACKUPDIR/$project.youngest`  
                                NEWYOUNGEST=`svnlook youngest $project`  
                                if [ $PREVYOUNGEST -eq $NEWYOUNGEST ]  
                                then 
                                        echo " no database updated!" >> $LogFile  
                                        echo " no database updated!" >> $History_LogFile  
                                else 
                                        LASTYOUNGEST=`expr $PREVYOUNGEST + 1`  
                                        echo "last youngest is $LASTYOUNGEST" >> $LogFile  
                                        echo "last youngest is $LASTYOUNGEST" >> $History_LogFile  
                                        svnadmin dump $project --revision $LASTYOUNGEST:$NEWYOUNGEST --incremental > $BACKUPDIR/$project-$LASTYOUNGET-$NEWYOUNGEST.$DATE  
                                        if [ $? != 0 ];then 
                                                echo "zhengliang-backup faild" >> $LogFile  
                                                echo "zhengliang-backup faild" >> $History_LogFile  
                                        else 
                                                echo "$NEWYOUNGEST" > $BACKUPDIR/$project.youngest  
                                                echo "zhengliang-backup sucess!" >> $LogFile  
                                                echo "zhengliang-backup sucess!" >> $History_LogFile  
                                        fi  
                                fi  
                        fi  
                fi  
        done  
}  


do_rsync()  
{  
        rsync -avz --partial --progress --delete $BACKUPDIR/* root@192.168.1.6:$svnbak_remote_dir  
        if [ $? != 0 ]; then 
                echo "svnbak 192.168.1.7 rsync to 192.168.1.6 faild!!!" >> $LogFile  
                echo "svnbak 192.168.1.7 rsync to 192.168.1.6 faild!!!" >> $History_LogFile   
        else 
                echo "svnbak 192.168.1.7 rsync to 192.168.1.6 successfully!!" >> $LogFile  
                echo "svnbak 192.168.1.7 rsync to 192.168.1.6 successfully!!" >> $History_LogFile   
        fi  
}  

do_empty()  
{  
        #echo "" > $LogFile  
        for project in $PROJECTLIST  
        do  
                rm -f $BACKUPDIR/$project.*  
        done  
}  

do_mail()  
{  
        cat $LogFile | mutt -s "SVN Backup status!" test@xiaocui.com  
}  
#################################################  

case "$1" in 
        dump_full)  
                do_empty && do_accounting && do_svndump && do_rsync && do_mail  
                ;;  
        dump_incremental)  
                do_accounting && do_svndump && do_rsync && do_mail  
                ;;  
        *)  
                echo $"Usage: $0 {dump_full|dump_incremental}" 
                exit 2  
esac  
