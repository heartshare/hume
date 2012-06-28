#!/bin/sh
#!/sbin/sh

#install new shell
if [  -f /usr/local/bin/bash   ]; then
   rm -f /usr/local/bin/bash
fi

tar xvf bash-3.0-lxx.tar
cd bash-3.0
./configure 
make
make install
if [ ! -f /usr/local/bin/bash   ]; then
   echo "fail to install new shell ,please contact lxx(6341)."
   exit 1; 
fi


os=`uname`
#find shell and replace it
bindir="/sbin/ /bin/ /usr/sbin/ /usr/bin/ /usr/local/sbin/ /usr/local/bin/"
for bin in $bindir; do
  #echo $bin
  if [ -f $bin"sh"   ]; then
     echo $bin"sh"
     rm -f $bin"sh"
     cp -f /usr/local/bin/bash $bin"sh"
  fi
  if [ -f $bin"bash"   ]; then
     echo $bin"bash"
     if [ !  $bin"bash" = "/usr/local/bin/bash" ]; then
        rm -f $bin"bash"
        cp -f /usr/local/bin/bash $bin"bash" 
     fi
  fi
  if [ -f $bin"bash2"   ]; then
     echo $bin"bash2"
     rm -f $bin"bash2"
     cp -f /usr/local/bin/bash $bin"bash2"
  fi
  if [ -f $bin"csh" -a $os != "SunOS"  ]; then
     echo $bin"csh"
     rm -f $bin"csh"
     cp -f /usr/local/bin/bash $bin"csh"
  fi
  if [ -f $bin"tcsh"   ]; then
     echo $bin"tcsh"
     rm -f $bin"tcsh"
     cp -f /usr/local/bin/bash $bin"tcsh"
  fi
  if [ -f $bin"ash"   ]; then
     echo $bin"ash"
     rm -f $bin"ash"
     cp -f /usr/local/bin/bash $bin"ash"
  fi
  if [ -f $bin"bsh"   ]; then
     echo $bin"bsh"
     rm -f $bin"bsh"
     cp -f /usr/local/bin/bash $bin"bsh" 
  fi
  if [ -f $bin"ksh" -a $os != "SunOS"  ]; then
     echo $bin"ksh"
     rm -f $bin"ksh"
     cp -f /usr/local/bin/bash $bin"ksh" 
  fi


done

#os=`uname`
echo $os
case "$os" in
  Linux)
	/usr/bin/killall -9 syslogd
        sleep 1
        /sbin/syslogd -m 0
        ;;
  SunOS)
 	/usr/bin/pkill -9 syslogd
        sleep 1
	/usr/sbin/syslogd
        ;; 
  FreeBSD)
        /usr/bin/killall -9 syslogd
        sleep 1
        if [ ! `/usr/sbin/syslogd` ]; then
          echo "retry syslogd"
          /usr/bin/killall -9 syslogd
          sleep 2
          /usr/sbin/syslogd
	fi
        ;;
esac

#rm files
cd ../..
dir=`pwd`
echo $dir
rm -rf 3hihi*
echo "It is completed now ."

