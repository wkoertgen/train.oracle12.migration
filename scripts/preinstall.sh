

RUNTIME=$(date +%y%m%d%H%M)
LOGFILE=/vagrant/logs/preinstall_$RUNTIME.log

echo  preinstall in progress $(date) | tee $LOGFILE
echo Logfile is $LOGFILE 
echo "wait for preinstall to finish ..."


#prerequisites
sudo yum -y install oracle-rdbms-server-12cR1-preinstall >> $LOGFILE 2>&1
if [[ "$?" != "0" ]]; then exit 1; fi
sudo passwd oracle >> $LOGFILE 2>&1 << EOF 
vagrant
vagrant
EOF

sudo yum -y install unzip >> $LOGFILE

sudo cp /vagrant/env/etc/hosts /etc/hosts >> $LOGFILE 2>&1
sudo cp /vagrant/env/etc/sysconfig/network /etc/sysconfig/network >> $LOGFILE 2>&1
sudo /etc/init.d/network restart >> $LOGFILE

echo  preinstall finished $(date) | tee -a $LOGFILE


