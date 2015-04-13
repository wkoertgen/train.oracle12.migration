# as user oracle
# set the environment
# vi .bashrc
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/12.1
export ORACLE_SID=orcl
OLD_PATH=$PATH
export PATH=$ORACLE_HOME/bin:$ORACLE_BASE/sqldeveloper:$PATH
alias s+="sqlplus / as sysdba"
alias ll="ls -ltr"
alias dbs="cd $ORACLE_HOME/dbs"
alias tns="cd $ORACLE_HOME/network/admin"
alias data="cd $ORACLE_BASE/oradata"
alias mon="cd ~/InhouseDev/mon"
alias vfalert="tail -100f $ORACLE_BASE/diag/rdbms/$ORACLE_SID/$ORACLE_SID/trace/alert_$ORACLE_SID.log"
#
# execute . .bashrc
cd $ORACLE_HOME/Opatch
./opatcxh lsinventory

# this is opatch output
[oracle@localhost OPatch]$ ./opatch lsinventory
Oracle Interim Patch Installer version 12.1.0.1.3
Copyright (c) 2015, Oracle Corporation.  All rights reserved.


Oracle Home       : /u01/app/oracle/product/12.1
Central Inventory : /u01/app/oraInventory
   from           : /u01/app/oracle/product/12.1/oraInst.loc
OPatch version    : 12.1.0.1.3
OUI version       : 12.1.0.2.0
Log file location : /u01/app/oracle/product/12.1/cfgtoollogs/opatch/opatch2015-04-13_18-21-24PM_1.log

Lsinventory Output file location : /u01/app/oracle/product/12.1/cfgtoollogs/opatch/lsinv/lsinventory2015-04-13_18-21-24PM.txt

--------------------------------------------------------------------------------
Installed Top-level Products (1): 

Oracle Database 12c                                                  12.1.0.2.0
There are 1 products installed in this Oracle Home.


There are no Interim patches installed in this Oracle Home.


--------------------------------------------------------------------------------

OPatch succeeded.

