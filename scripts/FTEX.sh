RUNTIME=$(date +%y%m%d%H%M)
LOGFILE=/vagrant/logs/FTEX_$RUNTIME.log

echo Database FTEX creation in progress $(date) | tee $LOGFILE
echo Logfile is $LOGFILE
echo "This part generates a logfile of 20MB. We decided to lead it to /dev/null"
echo "Read the FAQ to know how to change this"
echo "wait for database creation to finish ..."

ORACLE_BASE=/u01/app/oracle
ORACLE_HOME=$ORACLE_BASE/product/12.1.0
ORACLE_SID=FTEX
PATH=$ORACLE_HOME/bin:$PATH; 
export ORACLE_BASE ORACLE_HOME ORACLE_SID PATH

OLD_UMASK=`umask`
umask 0027
sudo -Eu oracle mkdir -p $ORACLE_BASE/admin/FTEX/adump
sudo -Eu oracle mkdir -p $ORACLE_BASE/admin/FTEX/dpdump
sudo -Eu oracle mkdir -p $ORACLE_BASE/cfgtoollogs/dbca/FTEX
sudo -Eu oracle mkdir -p $ORACLE_BASE/oradata/FTEX
sudo -Eu oracle mkdir -p $ORACLE_HOME/dbs
umask ${OLD_UMASK}
PERL5LIB=$ORACLE_HOME/rdbms/admin:$PERL5LIB; export PERL5LIB

sudo cp /vagrant/env/initFTEX.ora $ORACLE_HOME/dbs
sudo chown oracle:oinstall $ORACLE_HOME/dbs/initFTEX.ora
sudo chmod 644 $ORACLE_HOME/dbs/initFTEX.ora
sudo cp /vagrant/env/glogin.sql $ORACLE_HOME/sqlplus/admin/glogin.sql

#sudo -Eu oracle $ORACLE_HOME/bin/sqlplus /nolog @/vagrant/scripts/FTEX.sql >> $LOGFILE
sudo -Eu oracle $ORACLE_HOME/bin/sqlplus /nolog @/vagrant/scripts/FTEX.sql > /dev/null 2>&1
if [[ "$?" != "0" ]]; then exit 1; fi

echo Database FTEX creation finished $(date) | tee -a $LOGFILE





