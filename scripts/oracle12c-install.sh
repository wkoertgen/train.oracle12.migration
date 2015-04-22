

RUNTIME=$(date +%y%m%d%H%M)
LOGFILE=/vagrant/logs/oracle12c-install.log$RUNTIME
echo Oracle12c installation in progress $(date) | tee $LOGFILE
echo wait for the message Oracle12c installation finished
echo check $LOGFILE for possible errors

export ORACLE_HOSTNAME=oracle12c.localdomain
export ORACLE_UNQNAME=orcl
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/12.1.0/db_1
export ORACLE_SID=cdb12c

sudo hostname -b oracle12c.localdomain 

cd /vagrant/12c_installer

unzip linuxamd64_12102_database_1of2.zip >> $LOGFILE 2>&1
unzip linuxamd64_12102_database_2of2.zip  >> $LOGFILE 2>&1

cd /home/oracle

#copy in oracle .bash_profile

sudo -Eu oracle cp /vagrant/env/bash_profile /home/oracle/.bash_profile 

#create /u01 directory

sudo rm -r -f /u01
sudo mkdir /u01
sudo chown oracle:oinstall /u01

#run oracle installer

cd /vagrant/12c_installer/database

sudo -Eu oracle ./runInstaller -showProgress -silent -waitforcompletion -ignoreSysPrereqs \
-responseFile /vagrant/scripts/oracle12c.rsp | tee $LOGFILE 2>&1

errorlevel=$?

if [ "$errorlevel" != "0" ] && [ "$errorlevel" != "6" ]; then
  echo "There was an error preventing script from continuing"
  exit 1
fi

cd

#clean up database_installer directory
rm -r -f /vagrant/database_installer/database

#run the root scripts

sudo /u01/app/oraInventory/orainstRoot.sh >> $LOGFILE 2>&1

sudo /u01/app/oracle/product/12.1.0/db_1/root.sh >> $LOGFILE 2>&1

echo Oracle12c installation finished $(date) | tee $LOGFILE
