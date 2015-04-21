#!/bin/bash

RUNTIME=$(date +%y%m%d%H%M)
LOGFILE=/vagrant/logs/prerequisites.log$RUNTIME

echo  Prerequisites installation in progress $(date) | tee $LOGFILE
echo check /vagrant/logs for possible errors
echo wait for the message Prerequisites installation finished


#prerequisites
sudo yum -y install oracle-rdbms-server-12cR1-preinstall
sudo yum -y install unzip

sudo cp /vagrant/env/etc/hosts /etc/hosts >> $LOGFILE
sudo cp /vagrant/env/etc/sysconfig/network /etc/sysconfig/network >> $LOGFILE
sudo /etc/init.d/network restart >> $LOGFILE


