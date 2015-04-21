#!/bin/bash
# setup.sh controls the process of 
# preinstall 
# install Oracle SW
# creating databases
# postinstall
# the scripts log into /vagrant/logs/

# preinstall
/vagrant/scripts/preinstall.sh

# Oracle12 install
/vagrant/scripts/oracle12c-install.sh

# create Oracle12c Containerdatabase + pluggable database
/vagrant/scripts/create12cdb.sh

# Oracle11g install
/vagrant/scripts/oracle11g-install.sh

# create Oracle11g database
/vagrant/scripts/create11gdb.sh

# postinstall
/vagrant/scripts/postinstall.sh
