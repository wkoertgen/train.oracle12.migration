RUNTIME=$(date +%y%m%d%H%M)
LOGFILE=/vagrant/logs/postinstall_$RUNTIME.log

echo postinstall $(date) | tee $LOGFILE
echo check for errors in /vagrant/logs

#oratab
echo Installing /etc/oratab >> $LOGFILE 
sudo cp /vagrant/env/etc/oratab /etc/oratab >> $LOGFILE 2>&1 
sudo chown oracle:oinstall /etc/oratab  >> $LOGFILE 2>&1
sudo chmod 0644 /etc/oratab  >> $LOGFILE 2>&1

# /usr/local/bin
echo Installing in /usr/local/bin >> $LOGFILE
sudo cp /vagrant/env/upgr /usr/local/bin >> $LOGFILE 2>&1
#sudo chmod 00755 /usr/local/bin/upgr
sudo cp /vagrant/env/cdb1 /usr/local/bin >> $LOGFILE 2>&1
#sudo chmod 00755 /usr/local/bin/cdb1

echo Installing in /var/opt/oracle >> $LOGFILE
sudo mkdir -p /var/opt/oracle >> $LOGFILE 2>&1
sudo chown oracle:oinstall /var/opt/oracle >> $LOGFILE 2>&1
sudo chmod 766 /var/opt/oracle >> $LOGFILE 2>&1
sudo cp /vagrant/env/listener.ora /var/opt/oracle >> $LOGFILE 2>&1
sudo cp /vagrant/env/tnsnames.ora /var/opt/oracle >> $LOGFILE 2>&1
sudo chown oracle:oinstall /var/opt/oracle/listener.ora >> $LOGFILE 2>&1
sudo chown oracle:oinstall /var/opt/oracle/tnsnames.ora >> $LOGFILE 2>&1

echo starting listener >> $LOGFILE
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/12.1.0
export TNS_ADMIN=/var/opt/oracle
export ORACLE_HOSTNAME=oracle12c.localdomain
sudo -Eu oracle $ORACLE_HOME/bin/lsnrctl start listener >> $LOGFILE 2>&1

echo setup connectivity finished $(date) | tee -a $LOGFILE
