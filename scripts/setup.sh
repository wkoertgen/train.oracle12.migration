
# setup.sh controls the process of 
# preinstall 
# install Oracle SW
# creating databases
# postinstall
# the scripts log into /vagrant/logs/

# preinstall
/vagrant/scripts/preinstall.sh
if [[ $? != "0" ]]; then echo "ERROR in preinstall.sh - aborting setup"; exit; fi

# Oracle12 install
/vagrant/scripts/oracle12c-install.sh
if [[ $? != "0" ]]; then echo "ERROR in oracle12c-install.sh - aborting setup"; exit; fi

# create Oracle12c Containerdatabase + pluggable database
vagrant/scripts/create12cdb.sh
if [[ $? != "0" ]]; then echo "ERROR in create12cdb.sh - aborting setup"; exit; fi


# Oracle11g install
/vagrant/scripts/oracle11g-install.sh
if [[ $? != "0" ]]; then echo "ERROR in oracle11g-install.sh - aborting setup"; exit; fi

# create Oracle11g database
/vagrant/scripts/create11gdb.sh
if [[ $? != "0" ]]; then echo "ERROR in create11gdb.sh - aborting setup"; exit; fi

# postinstall
/vagrant/scripts/postinstall.sh
if [[ $? != "0" ]]; then echo "ERROR in postinstall.sh - aborting setup"; exit; fi

