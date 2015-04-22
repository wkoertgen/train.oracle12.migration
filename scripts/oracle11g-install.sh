
RUNTIME=$(date +%y%m%d%H%M)
LOGFILE=/vagrant/logs/oracle11g-install.log$RUNTIME

echo Installing Oracle11g in progress $(date) | tee $LOGFILE
echo this Oracle Release does not output the progress of installation
echo "go to $LOGFILE and tail -f the logfile inside the VM"
echo "wait for the message Oracle11g install finished ..."


export ORACLE_HOSTNAME=oracle12c.localdomain
export ORACLE_UNQNAME=UPGR
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0
export ORACLE_SID=UPGR


cd /vagrant/11g_installer

unzip linux.x64_11gR2_database_1of2.zip >> $LOGFILE 2>&1
unzip linux.x64_11gR2_database_2of2.zip >> $LOGFILE 2>&1

#run oracle installer
cd /vagrant/11g_installer/database

sudo -Eu oracle ./runInstaller -silent -waitforcompletion -ignorePrereq \
-responseFile /vagrant/scripts/Oracle1121.rsp >> $LOGFILE 2>&1

errorlevel=$?

if [ "$errorlevel" != "0" ] && [ "$errorlevel" != "6" ]; then
  echo "There was an error preventing script from continuing"
  exit 1
fi

cd

#clean up database_installer directory
rm -r -f /vagrant/11g_installer/database

#run the root scripts

sudo /u01/app/oraInventory/orainstRoot.sh >> $LOGFILE 2>&1

sudo /u01/app/oracle/product/11.2.0/db_1/root.sh >> $LOGFILE 2>&1

echo Oracle11g install finished $(date) | tee -a $LOGFILE
