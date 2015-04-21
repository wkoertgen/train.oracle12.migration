#!/bin/bash

#export ORACLE_HOSTNAME=oracle12c.localdomain
export ORACLE_UNQNAME=orcl
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db_1
export ORACLE_SID=orcl

#prerequisites
#sudo yum -y install oracle-rdbms-server-12cR1-preinstall
#sudo cp /vagrant/env/etc/hosts /etc/hosts
#sudo cp /vagrant/env/etc/sysconfig/network /etc/sysconfig/network
#sudo /etc/init.d/network restart

#sudo hostname -b oracle12c.localdomain

cd /vagrant/oracle11g_installer

#sudo yum -y install unzip
unzip linux.x64_11gR2_database_1of2.zip
unzip linux.x64_11gR2_database_2of2.zip

#cd /home/oracle

#copy in oracle .bash_profile

#sudo -Eu oracle cp /vagrant/env/bash_profile /home/oracle/.bash_profile

#create /u01 directory

#sudo rm -r -f /u01
#sudo mkdir /u01
#sudo chown oracle:oinstall /u01

#run oracle installer

cd /vagrant/oracle11g_installer/database

sudo -Eu oracle ./runInstaller -showProgress -silent -waitforcompletion -ignoreSysPrereqs \
-responseFile /vagrant/scripts/oracle11g.rsp

errorlevel=$?

if [ "$errorlevel" != "0" ] && [ "$errorlevel" != "6" ]; then
  echo "There was an error preventing script from continuing"
  exit 1
fi

#install patches before creating databases
#sudo su - oracle /vagrant/patches/installpatch.sh

cd

#clean up database_installer directory
rm -r -f /vagrant/oracle1g_installer/database

#run the root scripts

sudo /u01/app/oraInventory/orainstRoot.sh

sudo /u01/app/oracle/product/11.2.0/db_1/root.sh

