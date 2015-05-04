

RUNTIME=$(date +%y%m%d%H%M)
LOGFILE=/vagrant/logs/postinstall_$RUNTIME.log

echo postinstall in process $(date) | tee $LOGFILE
echo Logfile is $LOGFILE
echo "wait for postinstall to finish ..."

#oratab
echo Installing /etc/oratab >> $LOGFILE 
sudo cp /vagrant/env/etc/oratab /etc/oratab >> $LOGFILE 2>&1 
sudo chown oracle:oinstall /etc/oratab  >> $LOGFILE 2>&1
sudo chmod 0644 /etc/oratab  >> $LOGFILE 2>&1

# /usr/local/bin
echo Installing in /usr/local/bin >> $LOGFILE
sudo cp /vagrant/env/upgr /usr/local/bin >> $LOGFILE 2>&1
sudo cp /vagrant/env/cdb1 /usr/local/bin >> $LOGFILE 2>&1

# bash_profile
echo Installing bash_profile >> $LOGFILE 2>&1
sudo -Eu oracle cp /vagrant/env/bash_profile /home/oracle/.bash_profile >> $LOGFILE 2>&1

# listener.ora & tnsnames.ora
echo Installing listener.ora and tnsnames.ora >> $LOGFILE 2>&1
sudo mkdir -p /var/opt/oracle >> $LOGFILE 2>&1
sudo chown oracle:oinstall /var/opt/oracle >> $LOGFILE 2>&1
sudo chmod 766 /var/opt/oracle >> $LOGFILE 2>&1
sudo cp /vagrant/env/listener.ora /var/opt/oracle >> $LOGFILE 2>&1
sudo cp /vagrant/env/tnsnames.ora /var/opt/oracle >> $LOGFILE 2>&1
sudo chown oracle:oinstall /var/opt/oracle/listener.ora >> $LOGFILE 2>&1
sudo chown oracle:oinstall /var/opt/oracle/tnsnames.ora >> $LOGFILE 2>&1

# start listener
echo Starting listener >> $LOGFILE 2>&1
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/12.1.0
export TNS_ADMIN=/var/opt/oracle
export ORACLE_HOSTNAME=oracle12c.localdomain
sudo -Eu oracle $ORACLE_HOME/bin/lsnrctl start listener >> $LOGFILE 2>&1

# implement oracle at boot time
SRC=/vagrant/env/etc/init.d/oracle
DEST=/etc/init.d/oracle
sudo cp $SRC $DEST
sudo chmod 0755 $DEST

sudo chkconfig oracle on

sudo cp /vagrant/env/etc/hosts /etc/hosts
sudo hostname -b oracle12c
sudo cp /vagrant/env/etc/sysconfig/network /etc/sysconfig/network
sudo /etc/init.d/network restart >> $LOGFILE 2>&1

# set httpsports on CDB1
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/12.1.0
export ORACLE_SID=CDB1

sudo -Eu oracle $ORACLE_HOME/bin/sqlplus -S / as sysdba >> $LOGFILE 2>&1 << EOF
exec dbms_xdb_config.sethttpsport(5500);
EOF


echo postinstall finished $(date) | tee -a $LOGFILE
