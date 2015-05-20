connect / as sysdba
whenever sqlerror exit failure
set verify off
-- host /u01/app/oracle/product/12.1.0/bin/orapwd file=/u01/app/oracle/product/12.1.0/dbs/orapwCDB1 force=y format=12
set echo on
startup nomount pfile="/vagrant/env/initCDB1.ora";
CREATE DATABASE "CDB1"
MAXINSTANCES 8
MAXLOGHISTORY 1
MAXLOGFILES 16
MAXLOGMEMBERS 3
MAXDATAFILES 100
DATAFILE '/u01/app/oracle/oradata/CDB1/system01.dbf' SIZE 300M REUSE AUTOEXTEND ON NEXT  10240K MAXSIZE UNLIMITED
EXTENT MANAGEMENT LOCAL
SYSAUX DATAFILE '/u01/app/oracle/oradata/CDB1/sysaux01.dbf' SIZE 300M REUSE AUTOEXTEND ON NEXT  10240K MAXSIZE UNLIMITED
SMALLFILE DEFAULT TEMPORARY TABLESPACE TEMP TEMPFILE '/u01/app/oracle/oradata/CDB1/temp01.dbf' SIZE 5M REUSE AUTOEXTEND ON NEXT  640K MAXSIZE UNLIMITED
SMALLFILE UNDO TABLESPACE "UNDOTBS1" DATAFILE  '/u01/app/oracle/oradata/CDB1/undotbs01.dbf' SIZE 5M REUSE AUTOEXTEND ON NEXT  5120K MAXSIZE UNLIMITED
CHARACTER SET AL32UTF8
NATIONAL CHARACTER SET AL16UTF16
LOGFILE GROUP 1 ('/u01/app/oracle/oradata/CDB1/redo01.log') SIZE 50M,
GROUP 2 ('/u01/app/oracle/oradata/CDB1/redo02.log') SIZE 50M,
GROUP 3 ('/u01/app/oracle/oradata/CDB1/redo03.log') SIZE 50M
USER SYS IDENTIFIED BY "vagrant" USER SYSTEM IDENTIFIED BY "vagrant"
enable pluggable database
seed file_name_convert=('/u01/app/oracle/oradata/CDB1/system01.dbf','/u01/app/oracle/oradata/CDB1/pdbseed/system01.dbf','/u01/app/oracle/oradata/CDB1/sysaux01.dbf','/u01/app/oracle/oradata/CDB1/pdbseed/sysaux01.dbf','/u01/app/oracle/oradata/CDB1/temp01.dbf','/u01/app/oracle/oradata/CDB1/pdbseed/temp01.dbf','/u01/app/oracle/oradata/CDB1/undotbs01.dbf','/u01/app/oracle/oradata/CDB1/pdbseed/undotbs01.dbf');


CREATE SMALLFILE TABLESPACE "USERS" LOGGING  DATAFILE  '/u01/app/oracle/oradata/CDB1/users01.dbf' SIZE 5M REUSE AUTOEXTEND ON NEXT  1280K MAXSIZE UNLIMITED  EXTENT MANAGEMENT LOCAL  SEGMENT SPACE MANAGEMENT  AUTO;
ALTER DATABASE DEFAULT TABLESPACE "USERS";

@?/rdbms/admin/catalog.sql;
@?/rdbms/admin/catproc.sql;
@?/rdbms/admin/catoctk.sql;
@?/rdbms/admin/owminst.plb;

connect system/vagrant
@?/sqlplus/admin/pupbld.sql;
connect system/vagrant
set echo on
@?/sqlplus/admin/help/hlpbld.sql helpus.sql;
-- connect / as sysdba
BEGIN 
 FOR item IN ( SELECT USERNAME FROM DBA_USERS WHERE ACCOUNT_STATUS IN ('OPEN', 'LOCKED', 'EXPIRED') AND USERNAME NOT IN ( 
'SYS','SYSTEM') ) 
 LOOP 
  dbms_output.put_line('Locking and Expiring: ' || item.USERNAME); 
  execute immediate 'alter user ' ||
 	 sys.dbms_assert.enquote_name(
 	 sys.dbms_assert.schema_name(
 	 item.USERNAME),false) || ' password expire account lock' ;
 END LOOP;
END;
/

conn / as sysdba
@?/rdbms/admin/catbundleapply.sql;
set echo on
create spfile='/u01/app/oracle/product/12.1.0/dbs/spfileCDB1.ora' FROM pfile='/vagrant/env/initCDB1.ora';
select 'utlrp_begin: ' || to_char(sysdate, 'HH:MI:SS') from dual;
@?/rdbms/admin/utlrp.sql;
select 'utlrp_end: ' || to_char(sysdate, 'HH:MI:SS') from dual;
select comp_id, status from dba_registry;
shutdown immediate;
startup ;
exec dbms_xdb_config.sethttpsport(5500);
exit;

REM @/develop/CDB1scripts/CreateDB.sql
REM @/develop/CDB1scripts/CreateDBFiles.sql
REM @/develop/CDB1scripts/CreateDBCatalog.sql
REM @/develop/CDB1scripts/apex.sql
REM @/develop/CDB1scripts/lockAccount.sql
REM @/develop/CDB1scripts/postDBCreation.sql
