RUNTIME=$(date +%y%m%d%H%M)
LOGFILE=/vagrant/logs/preinstall_$RUNTIME.log

echo  Prerequisites installation in progress $(date) | tee $LOGFILE
echo wait for the message Prerequisites installation finished

#prerequisites
sudo yum -y install oracle-rdbms-server-12cR1-preinstall >> $LOGFILE 2>&1
sudo yum -y install unzip >> $LOGFILE

sudo cp /vagrant/env/etc/hosts /etc/hosts >> $LOGFILE 2>&1
sudo cp /vagrant/env/etc/sysconfig/network /etc/sysconfig/network >> $LOGFILE 2>&1
sudo /etc/init.d/network restart >> $LOGFILE

echo  Prerequisites installation finished $(date) | tee -a $LOGFILE
