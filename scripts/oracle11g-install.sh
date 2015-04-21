#!/bin/bash
RUNTIME=$(date +%y%m%d%H%M)
LOGFILE=/vagrant/logs/oracle11g-install.log$RUNTIME

echo Installing Oracle11g in progress $(date) 
echo check /vagrant/logs for possible errors 
echo "wait for the message Oracle11g install finished ..."


export ORACLE_HOSTNAME=oracle12c.localdomain
export ORACLE_UNQNAME=UPGR
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db_1
export ORACLE_SID=UPGR


cd /vagrant/11g_installer

unzip p10404530_112030_Linux-x86-64_1of7.zip > $LOGFILE
unzip p10404530_112030_Linux-x86-64_2of7.zip >> $LOGFILE

#run oracle installer
cd /vagrant/11g_installer/database

sudo -Eu oracle ./runInstaller -showProgress -silent -waitforcompletion -ignoreSysPrereqs \
-responseFile /vagrant/scripts/oracle11g.rsp >> $LOGFILE

errorlevel=$?

if [ "$errorlevel" != "0" ] && [ "$errorlevel" != "6" ]; then
  echo "There was an error preventing script from continuing"
  exit 1
fi

cd

#clean up database_installer directory
rm -r -f /vagrant/11g_installer/database

#run the root scripts

sudo /u01/app/oraInventory/orainstRoot.sh >> $LOGFILE

sudo /u01/app/oracle/product/11.2.0/db_1/root.sh >> $LOGFILE

echo Oracle11g install finished $(date)
