

RUNTIME=$(date +%y%m%d%H%M)
LOGFILE=/vagrant/logs/create12cdb_$RUNTIME.log
echo database CDB1 creation in progress $(date) | tee $LOGFILE
echo Logfile is $LOGFILE
echo "wait for database creation to finish ..."

export ORACLE_HOSTNAME=oracle12c
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/12.1.0

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
$ORACLE_HOME/bin sqlplus / as sysdba << EOT
alter pluggable database pdb1 open;
EOT

sudo cp /vagrant/env/glogin.sql $ORACLE_HOME/sqlplus/admin/glogin.sql 
echo database creation finished $(date) | tee -a $LOGFILE
