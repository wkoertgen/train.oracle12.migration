

RUNTIME=$(date +%y%m%d%H%M)
LOGFILE=/vagrant/logs/create12cdb.log$RUNTIME
echo database cdb12c creation in progress $(date) | tee $LOGFILE
echo wait for the message database installation finished
echo check /vagrant/logs for possible errors

export ORACLE_HOSTNAME=oracle12c.localdomain
export ORACLE_UNQNAME=orcl
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/12.1.0/db_1
export ORACLE_SID=cdb12c

#configure listener

#SRC=/vagrant/env/listener.ora
DEST=$ORACLE_HOME/network/admin/listener.ora
#sudo cp $SRC $DEST
#sudo chown oracle:oinstall $DEST
#sudo chmod 0644 $DEST
sudo rm $DEST

#start listener

sudo -Eu oracle $ORACLE_HOME/bin/lsnrctl start >> $LOGFILE

#install oracle service
SRC=/vagrant/env/etc/init.d/oracle
DEST=/etc/init.d/oracle
sudo cp $SRC $DEST
sudo chmod 0755 $DEST

#set oracle service to start at boot
sudo chkconfig oracle on >> $LOGFILE

#sqlplus startup config file
SRC=/vagrant/env/glogin.sql
DEST=$ORACLE_HOME/sqlplus/admin/glogin.sql
sudo cp $SRC $DEST
sudo chown oracle:oinstall $DEST
sudo chmod 0644 $DEST

echo create the container and a pluggable database | tee $LOGFILE append

sudo -Eu oracle $ORACLE_HOME/bin/dbca -silent \
-createDatabase \
-templateName General_Purpose.dbc \
-gdbName CDB1 \
-sid CDB1 \
-createAsContainerDatabase true \
-numberOfPdbs 1 \
-pdbName pdb1 \
-pdbadminUsername vagrant \
-pdbadminPassword vagrant \
-SysPassword vagrant \
-SystemPassword vagrant \
-emConfiguration NONE \
-datafileDestination /u01/oradata \
-storageType FS \
-characterSet AL32UTF8 \
-memoryPercentage 40 \
-listeners LISTENER >> $LOGFILE

echo database installation finished $(date) | tee $LOGFILE
