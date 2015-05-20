
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

# Oracle11g install
/vagrant/scripts/oracle11g-install.sh
if [[ $? != "0" ]]; then echo "ERROR in oracle11g-install.sh - aborting setup"; exit; fi

# create Oracle11g database
/vagrant/scripts/UPGR.sh
if [[ $? != "0" ]]; then echo "ERROR in UPGR.sh - aborting setup"; exit; fi

# create Oracle12c Containerdatabase + pluggable database
/vagrant/scripts/CDB1.sh
if [[ $? != "0" ]]; then echo "ERROR in CDB1.sh - aborting setup"; exit; fi


# postinstall
/vagrant/scripts/postinstall.sh
if [[ $? != "0" ]]; then echo "ERROR in postinstall.sh - aborting setup"; exit; fi

#### optional: create FTEX database for Full Transport Export #####
#### shutdown UPGR in this use case ####
#/vagrant/scripts/FTEX.sh
#if [[ $? != "0" ]]; then echo "ERROR in FTEX.sh - aborting setup"; exit; fi

