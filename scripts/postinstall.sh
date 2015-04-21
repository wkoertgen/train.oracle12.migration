#!/bin/sh

RUNTIME=$(date +%y%m%d%H%M)
LOGFILE=/vagrant/logs/postinstall.log$RUNTIME

echo postinstall $(date) | tee $LOGFILE
echo check for errors in /vagrant/logs

#oratab
echo Installing /etc/oratab >> $LOGFILE
sudo cp /vagrant/env/etc/oratab /etc/oratab
sudo chown oracle:oinstall /etc/oratab
sudo chmod 0644 /etc/oratab

# /usr/local/bin
echo Installing in /usr/local/bin >> $LOGFILE
sudo cp /vagrant/env/upgr /usr/local/bin
sudo cp /vagrant/env/cdb12 /usr/local/bin

echo Installing in /var/opt/oracle >> $LOGFILE
sudo mkdir -p /var/opt/oracle
sudo chown oracle:oinstall /var/opt/oracle
sudo chmod 766 /var/opt/oracle
sudo cp /vagrant/env/listener.ora /var/opt/oracle
sudo cp /vagrant/env/tnsnames.ora /var/opt/oracle
sudo chown oracle:oinstall /var/opt/oracle/listener.ora
sudo chown oracle:oinstall /var/opt/oracle/tnsnames.ora

echo starting listener
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db_1
export TNS_ADMIN=/var/opt/oracle
export ORACLE_HOSTNAME=oracle12c.localdomain
sudo -Eu oracle $ORACLE_HOME/bin/lsnrctl start listener >> $LOGFILE

echo setup connectivity finished $(date) | tee -a $LOGFILE
