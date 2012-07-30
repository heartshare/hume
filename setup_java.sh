#!/bin/sh

echo "---set up ------------"
sh /root/jdk-6u12-linux-x64.bin
mv /root/jdk1.6.0_12/ /usr/local/jdk

echo "JAVA_HOME=/usr/local/jdk" >> /root/.bash_profile
echo "JAVA_BIN=/usr/local/jdk/bin" >> /root/.bash_profile
echo "PATH=\$PATH:\$JAVA_HOME/bin" >> /root/.bash_profile
echo "CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar" >> /root/.bash_profile
echo "export JAVA_HOME PATH CLASSPATH" >> /root/.bash_profile
./root/.bash_profile

echo "--finish--"

