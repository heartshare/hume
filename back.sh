#!/bin/sh

#########################################################
# this script is used for svn repository backup
# written: carywu
# date: 2008/11/21
#########################################################

###################################
# mail address for status updates
#  - This is used to email you a status report
###################################
MAILADDR=xiahoufeng@chinatsp.com

###################################
# backup directory,please change it
# - This is the path to the backup directory
###################################
BACKUPCONFDIR=/svn/repo
BACKUPDIR=/pool/repo

###################################
# svn repository directory, please change it.
# - This is the path to the directory you want to archive
###################################
SVNDIR=/var/svn

###################################
# HOSTNAME and project list
#  - This is also used for reporting
###################################
ProjectLst=$BACKUPCONFDIR/list.txt

###################################
# svn backup log path and date
#  - This is used to log result
###################################
LogFile=$BACKUPCONFDIR/svnback2.log
DATE=`date +%F`
###################################
# svn command path
# - This is the path to the directory you want to archive
###################################
export PATH=$PATH:/bin:/usr/bin:/usr/local/bin

# our actual rsyncing function
do_accounting()
{
        echo " " >> $LogFile
        echo " " >> $LogFile
        echo "###########################" >> $LogFile
        echo "$DATE" >> $LogFile
        echo "###########################" >> $LogFile
        cd $BackDir
}

do_svndump()
{
   PROJECTLIST=`cat $ProjectLst`
   cd $SVNDIR
   for project in $PROJECTLIST
          do
          echo "begin to dump $project databases" >> $LogFile
                if [ ! -f $BACKUPDIR/$project.dump ]
                then
                YOUNGEST=`svnlook youngest $project`
                svnadmin dump $project > $BACKUPDIR/$project.dump
                echo "OK,dump file successfully!!"
                echo "$YOUNGEST" > $BACKUPDIR/$project.youngest
                echo `date +%F_%T` >> $BACKUPDIR/$project.log
                else
                        echo "$project.dump existed,will do increatment job" >> $LogFile
                        if [ ! -f $BACKUPDIR/$project.youngest ]
                        then
                        echo "error, no youngest check!" >> $LogFile
                        else
                                PREVYOUNGEST=`cat $BACKUPDIR/$project.youngest`
                                NEWYOUNGEST=`svnlook youngest $project`
                                if [ $PREVYOUNGEST -eq $NEWYOUNGEST ]
                                then
                                        echo " no database updated!" >> $LogFile
                                else
                                        LASTYOUNGEST=`expr $PREVYOUNGEST + 1`
                                        echo "last youngest is $LASTYOUNGEST" >> $LogFile
                                        svnadmin dump $project --revision $LASTYOUNGEST:$NEWYOUNGEST --incremental > $BACKUPDIR/$project-$LASTYOUNGET-$NEWYOUNGEST.$DATE
                                        echo "$NEWYOUNGEST" > $BACKUPDIR/$project.youngest
                			echo `date +%F_%T` >> $BACKUPDIR/$project.log
                                fi
                        fi
  fi
        done
}

# our post rsync accounting function
do_mail()
{
   mail $MAILADDR -s svn-back_log < $LogFile
}
# some error handling and/or run our backup and accounting
#do_accounting && do_svndump && do_mail
do_accounting && do_svndump

#cd $BACKUPDIR
#tar zcvf rj.`date +%F`.tar.gz app/ doc/ sdk/ mcu* intel* sys* tcc*
