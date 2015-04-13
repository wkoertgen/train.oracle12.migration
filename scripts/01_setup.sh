# as root - in vagrant all passworwd for root is vargant
### create groups and users
groupadd dba
addgroup oinstall
useradd oracle -G dba -g oinstall
grep oracle /etc/passwd
oracle:x:1001:1002::/home/oracle:/bin/bash
chown oracle:oinstall /home/oracle
# for sake of simplicity for other people we chose oracle as password
passwd oracle
Changing password for user oracle.
New password: 
BAD PASSWORD: The password is shorter than 8 characters
Retype new password: 
passwd: all authentication tokens updated successfully.
# test it
su - oracle
Last login: Mo Apr 13 16:01:20 UTC 2015 on pts/0
[oracle@localhost ~]$ id
uid=1001(oracle) gid=1002(oinstall) groups=1002(oinstall),1001(dba)
touch foo
[oracle@localhost ~]$ ll
total 0
-rw-r--r-- 1 oracle oinstall 0 Apr 13 16:09 foo

# meaning is clear: oracle with group oinstall will be owner of the Oracle Software

# create the directories for Oracle Software

mkdir -p /u01/app/oracle /u01/app/oraInventory # inventory should be outside ORACLE_BASE
chown -R oracle:oinstall /u01

# we will change shared memory, /etc/sysctl.conf, /etc/security/limits.conf after
the installation of Oracle software 
