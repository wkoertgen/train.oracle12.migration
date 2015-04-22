#!/bin/sh

ORACLE_BASE=/u01/app/oracle
#ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db_1
ORACLE_HOME=$ORACLE_BASE/product/11.2.0/
ORACLE_SID=UPGR
PATH=$ORACLE_HOME/bin:$PATH; 
export ORACLE_BASE ORACLE_HOME ORACLE_SID PATH
echo Database UPGR creation in progress $(date) 
echo check $LOGFILE for possible errors 
echo "wait for the message Database creation finished ..."

#sudo -Eu oracle umask 0027
sudo -Eu oracle mkdir -p $ORACLE_BASE/admin/UPGR/adump
sudo -Eu oracle mkdir -p $ORACLE_BASE/admin/UPGR/dpdump
sudo -Eu oracle mkdir -p $ORACLE_BASE/cfgtoollogs/dbca/UPGR
sudo -Eu oracle mkdir -p $ORACLE_BASE/oradata/UPGR
sudo -Eu oracle mkdir -p $ORACLE_HOME/dbs
#sudo -Eu oracle umask ${OLD_UMASK}

RUNTIME=$(date +%y%m%d%H%M)
LOGFILE=/vagrant/logs/create11gdb.log$RUNTIME

sudo -Eu oracle $ORACLE_HOME/bin/sqlplus /nolog @/vagrant/scripts/create11gdb.sql > $LOGFILE
sudo cp /vagrant/env/initUPGR.ora $ORACLE_HOME/dbs
sudo chown oracle:oinstall $ORACLE_HOME/dbs/initUPGR.ora
sudo chmod 644 $ORACLE_HOME/dbs/initUPGR.ora
sudo cp /vagrant/env/glogin.sql $ORACLE_HOME/sqlplus/admin/glogin.sql

echo Database UPGR creation finished $(date)





