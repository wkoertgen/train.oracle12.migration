connect / as SYSDBA
whenever sqlerror exit failure
set echo on
startup nomount pfile="/vagrant/env/initUPGR.ora";
CREATE DATABASE "UPGR"
MAXINSTANCES 8
MAXLOGHISTORY 1
MAXLOGFILES 16
MAXLOGMEMBERS 3
MAXDATAFILES 100
DATAFILE '/u01/app/oracle/oradata/UPGR/system01.dbf' SIZE 255M 
REUSE AUTOEXTEND ON NEXT  10240K MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL
SYSAUX DATAFILE '/u01/app/oracle/oradata/UPGR/sysaux01.dbf' SIZE 80M
REUSE AUTOEXTEND ON NEXT  10240K MAXSIZE UNLIMITED
SMALLFILE DEFAULT TEMPORARY TABLESPACE TEMP 
TEMPFILE '/u01/app/oracle/oradata/UPGR/temp01.dbf' SIZE 5M REUSE AUTOEXTEND ON NEXT  640K MAXSIZE UNLIMITED
SMALLFILE UNDO TABLESPACE "UNDOTBS1" DATAFILE '/u01/app/oracle/oradata/UPGR/undotbs01.dbf' SIZE 5M 
REUSE AUTOEXTEND ON NEXT  5120K MAXSIZE UNLIMITED
CHARACTER SET AL32UTF8
NATIONAL CHARACTER SET AL16UTF16
LOGFILE GROUP 1 ('/u01/app/oracle/oradata/UPGR/redo01.log') SIZE 51200K,
GROUP 2 ('/u01/app/oracle/oradata/UPGR/redo02.log') SIZE 51200K,
GROUP 3 ('/u01/app/oracle/oradata/UPGR/redo03.log') SIZE 51200K
USER SYS IDENTIFIED BY vagrant USER SYSTEM IDENTIFIED BY vagrant;
@?/rdbms/admin/catalog.sql;
@?/rdbms/dmin/catblock.sql;
@?/rdbms/admin/catproc.sql;
@?/rdbms/admin/catoctk.sql;
@?/rdbms/admin/owminst.plb;
connect SYSTEM/vagrant
@?/sqlplus/admin/pupbld.sql;
connect SYSTEM/vagrant
@?/sqlplus/admin/help/hlpbld.sql helpus.sql;
connect / as SYSDBA
create spfile from pfile;
CREATE SMALLFILE TABLESPACE "USERS"
DATAFILE '/u01/app/oracle/oradata/UPGR/users01.dbf' SIZE 5M LOGGING
EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;
shutdown immediate;
startup;
exit
