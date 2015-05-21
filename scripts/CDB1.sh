RUNTIME=$(date +%y%m%d%H%M)
LOGFILE=/vagrant/logs/CDB1_$RUNTIME.log

echo Database CDB1 creation in progress $(date) | tee $LOGFILE
echo Logfile is $LOGFILE
echo "This part generates a logfile of 20MB. We decided to lead it to /dev/null"
echo "Read the FAQ to know how to change this"
echo "wait for database creation to finish ..."

ORACLE_BASE=/u01/app/oracle
ORACLE_HOME=$ORACLE_BASE/product/12.1.0
ORACLE_SID=CDB1
PATH=$ORACLE_HOME/bin:$ORACLE_HOME/perl/bin:$PATH;
export ORACLE_BASE ORACLE_HOME ORACLE_SID PATH


OLD_UMASK=`umask`
umask 0027
sudo -Eu oracle mkdir -p $ORACLE_BASE/admin/CDB1/adump
sudo -Eu oracle mkdir -p $ORACLE_BASE/admin/CDB1/dpdump
sudo -Eu oracle mkdir -p $ORACLE_BASE/cfgtoollogs/dbca/CDB1
sudo -Eu oracle mkdir -p $ORACLE_BASE/oradata/CDB1/pdbseed
sudo -Eu oracle mkdir -p $ORACLE_BASE/oradata/CDB1/PDB
sudo -Eu oracle mkdir -p $ORACLE_HOME/dbs

sudo -Eu oracle $ORACLE_HOME/bin/dbca -silent \
-createDatabase \
-templateName General_Purpose.dbc \
-gdbName CDB1 \
-sid CDB1 \
-createAsContainerDatabase true \
-numberOfPdbs 1 \
-pdbName PDB1 \
-pdbadminUsername vagrant \
-pdbadminPassword vagrant \
-SysPassword vagrant \
-SystemPassword vagrant \
-emConfiguration NONE \
-datafileDestination /u01/app/oracle/oradata \
-storageType FS \
-characterSet AL32UTF8 \
-memoryPercentage 40 \
-listeners LISTENER >> $LOGFILE 2>&1
if [[ "$?" != "0" ]]; then exit 1; fi

sudo cp /vagrant/env/initCDB1.ora $ORACLE_HOME/dbs
sudo chown oracle:oinstall $ORACLE_HOME/dbs/initCDB1.ora
sudo chmod 644 $ORACLE_HOME/dbs/initCDB1.ora
sudo cp /vagrant/env/glogin.sql $ORACLE_HOME/sqlplus/admin/glogin.sql

echo Database CDB1 creation finished $(date) | tee -a $LOGFILE

