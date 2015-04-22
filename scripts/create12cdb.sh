

RUNTIME=$(date +%y%m%d%H%M)
LOGFILE=/vagrant/logs/create12cdb.log$RUNTIME
echo database CDB1 creation in progress $(date) | tee $LOGFILE
echo check $LOGFILE for possible errors
echo wait for the message database installation finished

export ORACLE_HOSTNAME=oracle12c.localdomain
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/12.1.0

# netconfiguration in postinstall.sh

echo create the container and a pluggable database | tee -a $LOGFILE

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
-datafileDestination /u01/oradata \
-storageType FS \
-characterSet AL32UTF8 \
-memoryPercentage 40 \
-listeners LISTENER >> $LOGFILE 2>&1

sudo -Eu oracle $ORACLE_HOME/bin/sqlplus / as sysdba << EOF
shutdown immediate
EOF

sudo cp /vagrant/env/glogin.sql $ORACLE_HOME/sqlplus/admin/glogin.sql
echo database installation finished $(date) | tee $LOGFILE
