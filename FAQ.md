# FAQ on Oracle12 / Oracle11 on Vagrant

## 1. What is the difference between your solution and Oracle's solution  ?
The Oracle Upgrade Team did a great job, especially the Hand-on-Labs is excellent.

http://www.oracle.com/technetwork/community/developer-vm/index.html

I was inspired by the idea of training **Installing and Upgrading** in a VirtualBox. Such things is,  what I missed all the time working as DBA.

But  working with that Virtualbox, I saw the technical limitations, eg. tiny fontsize, slow mouse pointer because of the mouse capture, difficult mounting of shared folders, the integrated SqlDeveloper unreadable with it's very tiny fontsizes and slower as usually, etc.
What brought me to write my own solution was finally the circumstance, that people could learn Upgrading, but not Installing.

In this solution you can do much more: 
- study the **different installation scripts** of Oracle SW and creating databases 
- **experiment on** the scripts and find your way of doing things
- train the different methods of **Upgrading**.

Additionally you may explore and take exercises on whatever you want, eg. compare the different **Optimizers**, which is crucial for Migrations.

Or you may  explore the exciting **In-Memory Database** und compare the result with both Optimizers.

There are many **more benefits** using Vagrant, but this would take too long to put down here.

## 2. How long does the setup of this VirtualBox take ?
When you have Vagrant and a compatible Guest Addition - see the **README** - the setup is started by the command **vagrant up** and will finish in 40 - 45 minutes, provided that you have a modern machine with 2 CPUs and enough memory.

Once the setup is done, the next `vagrant up` takes less than a minute. You may even work offline. Stop the engine by `vagrant halt`. 

By the way, there is a complete help system: `vagrant -h`

## 3. Can there be problems with the setup ?
The only problem I have experienced were the missing zip-files in the expected place - see the **README**. You can download these files from the indicated links.

You should have / create a free Oracle account to get a **Developer License**. Please read the text of the license. 

## 4a. How can I control the setup process?
In the `Vagrantfile` there is a line 

	config.vm.provision "shell", path: "scripts/setup.sh"

which refers to the script below. You can control the process by uncommenting / commenting the lines of your choice.
	
	# setup.sh controls the process of 
	# preinstall 
	# install Oracle SW 
	# creating databases 
	# postinstall 
	# the scripts log into /vagrant/logs/ 
	
	# preinstall 
	#/vagrant/scripts/preinstall.sh 
	#if [[ "$?" != "0" ]]; then echo "ERROR in preinstall.sh - aborting setup.; exit; fi 
	
	# Oraclel2 install 
	#/vagrant/scripts/oraclel2c-install.sh 
	#if [[ "$?" != "0" ]]; then echo "ERROR in oraclel2c-install.sh - aborting setup.; exit; fi 
	
	# create Oraclel2c Containerdatabase + pluggable database 
	#/vagrant/scripts/createl2cdb. sh 
	#if [[ "$?" != "0" ]]; then echo "ERRORincreatel2cdb.sh - aborting setup.; exit; fi 
	
	# Oraclellg install 
	#/vagrant/scripts/oraclellg-install.sh 
	#if [[ "$0" != "0" ]]; then echo "ERROR in oraclellg-install.sh - aborting setup.; exit; fi 
	
	# create Oraclellg database 
	#/vagrant/scripts/createllgdb. sh 
	#if [[ "$?" != "0" ]]; then echo "ERROR in createllgdb.sh - aborting setup.; exit; fi 
	
	# postinstall 
	#/vagrant/scripts/postinstall.sh 
	#if [[ "$?" != "0" ]]; then echo "ERROR in postinstall.sh - aborting setup.; exit; fi  

**Note:** I have commented all lines for demonstration only.

## 4b. I do not see the logfiles completely. Why is that so ? 
Some people have complained, that logfiles grow up to 20 MB. Hence we directed the logging of the **create11gdb.sql** to /dev/null. 
If you would like the follow the output for educational purposes, you may  change 2 lines in **create11gdb.sh**

`#sudo -Eu oracle $ORACLE_HOME/bin/sqlplus /nolog @/vagrant/scripts/create11gdb.sql >> $LOGFILE`
`sudo -Eu oracle $ORACLE_HOME/bin/sqlplus /nolog @/vagrant/scripts/create11gdb.sql /dev/null`

The other logfile from **oracle11g-install** is directed  to `/u01/app/oraInventory/logs` inside the guest VM by the **runInstaller** of Oracle11g itself. This installer has no feature like `show_progress` as we have it in Oracle12c. You mail follow the process by `tail -f <logfile>`.

 
## 5. Is Vagrant able to take snapshots?
Using snapshots with virtualization can be a huge time saver. If you use vagrant with VirtualBox you can install the snapshot plugin [vagrant-vbox-snapshot](https://github.com/dergachev/vagrant-vbox-snapshot) via

	vagrant plugin install vagrant-vbox-snapshot

When experimenting with your oracle sandbox VM it makes sense to take snapshots, e.g. after the `preinstall`:

	 vagrant snapshot take Initial

which should give an output similar to this:

	==> default: Machine booted and ready! 
	GuestAdditions 4.3.26 running --- OK. 
	==> default: Checking for guest additions in VM... 
	==> default: Mounting shared folders... 
	==> default: /vagrant a> /home/oracle/git/train.oraclel2c.migration 
	==> default: Running provisioner: shell... 
	==> default: Running: Amp/vagrant-she1120150422-13630-19czwml.sh 
	==> default: Prerequisites installation in progress Wed Apr 22 08:55:42 UTC 2015 
	==> default: check /vagrant/logs for possible errors 
	==> default: wait for the message Prerequisites installation finished 
	==> default: Prerequisites installation finished Wed Apr 22 08:56:57 UTC 2015 
	
	oracle@thinkpad3:—/git/train.oraclel2c.migration$ vagrant snapshot take Initial 
	Taking snapshot Initial 
	0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
	
	oracle@thinkpad3:—/git/train.oraclel2c.migration$ vagrant snapshot list 
	Listing snapshots for 'default':
	    Name: Initial (UUID: b0931b4b-6c57-4df4-b1b2-41e7ebl4e6bb) *
	
	oracle@thinkpad3:—/git/train.oraclel2c.migration$ 

When you want to start the next step, just enter 

	vagrant provision.

## 6. Which shared folders do exist? 
In the work directory where you execute `vagrant up`, there are 2 directories `./logs` and `./scripts`. The provisioning scripts log into `./logs`. In the `./develop` you may store your own SQL-scripts. For **details see topic 15**.


## 7. How do I connect to the guest VM ?
To connect to the guest VM type

	vagrant ssh

which will log you in as superuser vagrant. You are bound to work as user `oracle`. We have set the password to `vagrant`. Either you do `sudo su - oracle` oder better

	vagrant ssh -p

which prompts you for the password.

## 8. Best practice to get started ?
Usually the first step on an unknown oracle machine is 

	cat /etc/oratab.  

This informs you that we have two Oracle environments and two databases `CDB1` and `UPGR`. Choose your environment by using little scripts in `/usr/local/bin`

 - `cdb1` sets up the Oracle12g environment and 
 - `upgr` sets up the Oracle11g environment. 
 
Both provide practical aliases as 

- `s` for `sqlplus / as sysdba` or 
- `oh` to go to your current `ORACLE_HOME`. 
 
Feel free to add your own shortcuts.

**NOTE:** We have installed the Oracle11g patchlevel 11.2.0.1 which is known as buggy. Later patches of this Oracle11g up to 11.2.0.7, are unfortunately not available for people with the standard Developer License. As we aim to this target group, we decided to install the early 11.2.0.1 version.

## 9. How can I see which database is running?

	[oracle@localhost ~]$ ps -ef | grep pmon | grep -v grep
	oracle    2884     1  0 10:03 ?        00:00:00 ora_pmon_CDB1
	oracle    3112     1  0 10:04 ?        00:00:00 ora_pmon_UPGR
	[oracle@localhost ~]$ 
	 
The databases and the listeners are started after the setup and at boot-time. It is worth to study thouroughly this sophisticated mechanisms in the `postinstall.sh`.

To see, which listeners are running do

	[oracle@localhost ~]$ ps -ef | grep -i listener | grep -v grep
	oracle    1990     1  0 10:03 ?        00:00:00 /u01/app/oracle/product/12.1.0/bin/tnslsnr LISTENER -inherit
	[oracle@localhost ~]$ 


## 10. How can I handle the listener(s)?

One ORACLE_HOME/bin must be in the PATH. Best do `. cdb1` and type

	$ lsnrctl
	
	LSNRCTL for Linux: Version 12.1.0.2.0 - Production on 27-APR-2015 10:16:28
	
	Copyright (c) 1991, 2014, Oracle.  All rights reserved.
	
	Welcome to LSNRCTL, type "help" for information.
	
	LSNRCTL> 

The help shows you the most common commands e.g.

	LSNRCTL> status
	Connecting to (DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521)))
	STATUS of the LISTENER
	------------------------
	Alias                     LISTENER
	Version                   TNSLSNR for Linux: Version 12.1.0.2.0 - Production
	Start Date                27-APR-2015 10:03:45
	Uptime                    0 days 0 hr. 17 min. 21 sec
	Trace Level               off
	Security                  ON: Local OS Authentication
	SNMP                      OFF
	Listener Log File         /u01/app/oracle/diag/tnslsnr/localhost/listener/alert/log.xml
	Listening Endpoints Summary...
	  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=localhost)(PORT=1521)))
	Services Summary...
	Service "CDB1" has 1 instance(s).
	  Instance "CDB1", status READY, has 1 handler(s) for this service...
	Service "CDB1XDB" has 1 instance(s).
	  Instance "CDB1", status READY, has 1 handler(s) for this service...
	Service "UPGR.localhost.localdomain" has 1 instance(s).
	  Instance "UPGR", status READY, has 1 handler(s) for this service...
	Service "UPGRXDB.localhost.localdomain" has 1 instance(s).
	  Instance "UPGR", status READY, has 1 handler(s) for this service...
	Service "pdb1" has 1 instance(s).
	  Instance "CDB1", status READY, has 1 handler(s) for this service...
	The command completed successfully
	LSNRCTL> 


	
## 11. How can I handle TNS problems? 
I have placed the listener.ora and the tnsnames.ora in $TNS_ADMIN (/var/opt/oracle). 
Even if the tnsping utility shows a database, it does not mean that you can reach the database via then TNS framework. 

You should test it eg. by `sqlplus system/vagrant@cdb1`

I have produced deliberately an error - see the outcome

	[CDB1] oracle@localhost:~
	$ sqlplus system/vagrant@cdb1
	
	SQL*Plus: Release 12.1.0.2.0 Production on Mon Apr 27 10:25:39 2015
	
	Copyright (c) 1982, 2014, Oracle.  All rights reserved.
	
	ERROR:
	ORA-12533: TNS:illegal ADDRESS parameters

Experienced DBAs do this

	$ oerr ora 12533
	12533, 00000, "TNS:illegal ADDRESS parameters"
	// *Cause: An illegal set of protocol adapter parameters was specified. In
	// some cases, this error is returned when a connection cannot be made to the
	// protocol transport.
	// *Action: Verify that the destination can be reached using the specified
	// protocol. Check the parameters within the ADDRESS section of
	// TNSNAMES.ORA.  Legal ADDRESS parameter formats may be found in the
	// Oracle operating system specific documentation for your platform.
	// Protocols that resolve names at the transport layer (such as DECnet object
	// names) are vulnerable to this error if not properly configured or names are
	// misspelled.

Correct the syntax error and the you can connect via then TNS.

There are a some common pitfalls in the TNS configuration. Oracle's Online Documentation is very good, often hard to study, but it is worth the effort. Besides, there are meanwhile many very good special sites, blogs etc.

## 12a. How can I see the options of a database?
It is crucial to know the options of a database, because it decides what I can do with it. Besides, in production, it is a matter of license fees. Write a little script, e.g. `registry.sql`
	
	set lines 120 pages 66
	set feedback off
	col comp_name for a41
	col status for a10
	col version for a11
	col modified for a20
	select comp_name, status, version, modified from dba_registry;
	

If you execute it in the `CDB1` database you see  this listing

	SYS@CDB1>@registry.sql
	
		COMP_NAME				  STATUS     VERSION	 MODIFIED
		----------------------------------------- ---------- ----------- --------------------
		Oracle Database Vault			  VALID      12.1.0.2.0  26-APR-2015 07:39:24
		Oracle Application Express		  VALID      4.2.5.00.08 26-APR-2015 07:39:24
		Oracle Label Security			  VALID      12.1.0.2.0  26-APR-2015 07:39:24
		Spatial 				  VALID      12.1.0.2.0  26-APR-2015 07:39:23
		Oracle Multimedia			  VALID      12.1.0.2.0  26-APR-2015 07:39:19
		Oracle Text				  VALID      12.1.0.2.0  26-APR-2015 07:39:19
		Oracle Workspace Manager		  VALID      12.1.0.2.0  26-APR-2015 07:39:13
		Oracle XML Database			  VALID      12.1.0.2.0  26-APR-2015 07:39:10
		Oracle Database Catalog Views		  VALID      12.1.0.2.0  26-APR-2015 07:39:06
		Oracle Database Packages and Types	  VALID      12.1.0.2.0  26-APR-2015 07:39:08
		JServer JAVA Virtual Machine		  VALID      12.1.0.2.0  26-APR-2015 07:39:17
		Oracle XDK				  VALID      12.1.0.2.0  26-APR-2015 07:39:18
		Oracle Database Java Packages		  VALID      12.1.0.2.0  26-APR-2015 07:39:18
		OLAP Analytic Workspace 		  VALID      12.1.0.2.0  26-APR-2015 07:39:20
		Oracle OLAP API 			  VALID      12.1.0.2.0  26-APR-2015 07:39:22
		Oracle Real Application Clusters	  OPTION OFF 12.1.0.2.0  07-JUL-2014 06:52:28
		SYS@CDB1>


See the difference, if you run it in the `UPGR` database:

	SYS@UPGR>@registry
	
	COMP_NAME				  STATUS     VERSION	 MODIFIED
	----------------------------------------- ---------- ----------- --------------------
	Oracle Workspace Manager		  VALID      11.2.0.1.0  26-APR-2015 08:09:17
	Oracle Database Catalog Views		  VALID      11.2.0.1.0  26-APR-2015 08:08:39
	Oracle Database Packages and Types	  VALID      11.2.0.1.0  26-APR-2015 08:08:39


Here I decided to limit the options to the minimum, because we need this database only for educational purposes, i.e. for training the different methods of upgrading a database to Oracle12c. Study the scripts [scripts/create11gdb.sh](scripts/create11gdb.sh) and [scripts/create11gdb.sql](scripts/create11gdb.sql) to see the old manual way of creating a database. 

The `CDB1` was created using `dbca` in silent mode. Study the scripts [scripts/create12cdb.sh](scripts/create12cdb.sh). For newcomers all scripts in the subdirectory `./scripts` are a complete workshop on installing.

## 12b. Components and Options
I have used the term *options* quite deliberatelly for the *registered components* of a database. Do not mix up  **dba_registry** with the more detailed **v$option** as `Compression`, `Block Change Tracking`, `Automatic Storage Management`, `Spatial`, etc. It bis a bit confusing. In Oracle11.2 there are 65 options, in Oracle12c R1 there are 86.

Write a little script, eg. `options.sql`

	set pages 66
	set verify off
	set echo on
	col parameter for a40
	col value for a8
	select * from v$option where parameter like '%&1%';
	
and call it in the database `CDB1` like this:

	SYS@CDB1>@options Compress
	
	PARAMETER				 VALUE	      CON_ID
	---------------------------------------- -------- ----------
	Basic Compression			 TRUE		   0
	Unused Block Compression		 TRUE		   0
	Advanced Compression			 TRUE		   0
	Advanced Index Compression		 TRUE		   0
	
compare it with the output in `UPGR`:

	SYS@UPGR>@options Compress
	
	PARAMETER				 VALUE
	---------------------------------------- --------
	Basic Compression			 TRUE
	Unused Block Compression		 TRUE
	Advanced Compression			 TRUE

and note the new features of Oracle12c `Advanced Index Compression` and the new column `CON_ID` in every view. `CON_ID = 0` means `Container ID of the `CDB$ROOT`.

There are roundabout 500 new features. You cannot learn all this in a single workshop or a single book. 

## 13. Startup / Shutdown databases
For new-comers only: there are different ways of shutting down and starting up, especially in Oracle12c Container Databases. Find details in Oracle Documentation. For now see

	SYS@UPGR>shutdown immediate
	Database closed.
	Database dismounted.
	ORACLE instance shut down.
	SYS@UPGR>startup
	ORACLE instance started.
	
	Total System Global Area  939495424 bytes
	Fixed Size		    2218952 bytes
	Variable Size		  251659320 bytes
	Database Buffers	  679477248 bytes
	Redo Buffers		    6139904 bytes
	Database mounted.
	Database opened.
	


## 14. What has Vagrant to do with VirtualBox?
See some good books, e.g. [Vagrant Up and Runnin](http://chimera.labs.oreilly.com/books/1234000001668/) by Mitchell Hashimoto, the author of Vagrant. 

## 15. As user oracle I cannot execute scripts stored in the shared folders. 
As user `vagrant` you have no problem, because the shared folder `/vagrant` is owned by user `vagrant`. If you want full compliance of your scripts eg. in the folder `/vagrant/develop` you could do the following:

In `Vagrantfile` uncomment the line 

		#config.vm.synced_folder "./develop", "/develop", owner: "oracle", group: "oinstall" 

then execute

	vagrant reload

Before the preinstall there is no user `oracle`. Therefor we cannot leave this line uncommented.

See a not mounted folder.

	[oracle@localhost ~]$ pwd
	/home/oracle
	[oracle@localhost ~]$ cd /vagrant
	[oracle@localhost vagrant]$ ll develop
	total 460
	-rw-r--r-- 1 vagrant vagrant      0 27. Apr 10:34 placeholder
	-rw-r--r-- 1 vagrant vagrant    186 27. Apr 12:54 registry.sql
	-rw-r--r-- 1 vagrant vagrant 460800 27. Apr 10:36 Smon3.56.tar
	-rwx------ 1 vagrant vagrant   3651 23. Okt 2014  smonitor.ksh
	[oracle@localhost vagrant]$ 
	
The subdirectory /vagrant/develop belongs to the user vagrant. That is your problem. See the difference to a mounted shared folder

	[oracle@localhost vagrant]$ cd /develop
	[oracle@localhost develop]$ ll
	total 460
	-rw-r--r-- 1 oracle oinstall      0 27. Apr 10:34 placeholder
	-rw-r--r-- 1 oracle oinstall    186 27. Apr 12:54 registry.sql
	-rw-r--r-- 1 oracle oinstall 460800 27. Apr 10:36 Smon3.56.tar
	-rwx------ 1 oracle oinstall   3651 23. Okt 2014  smonitor.ksh
	[oracle@localhost develop]$ 

Here is one of my scripts, developed during 15 years working as Oracle DBA. It would surpass this handout to demonstrate this tool. There will be a github - project for the further development of this framework for profi DBA - scripts.

Writing one's own DBA – scripts can be trained in special workshops e.g. on 

- Performance Tuning or 
- New Features in PL/SQL or 
- working with In-Memory Database. 
 
In any case it would be a good idea to take a snapshot before you begin to work with the databases. 

## 16. Is it possible to use tools like SqlDeveloper and EM ?
One of Vagrant's features is Port Forwarding. On the host you start the SqlDeveloper and open a connection to the databases in the guest VM.

You can make use of the Port Forwarding, too, with EM, but I would not recommend to use the gigantic EM Cloudcontrol, but rather the smaller standalone EM Express. You must choose appriopate httpsports for the VM databases and forward them to the host.

If there are problems, you will find short tutorials on [wkoertgen.blogspot.de](http://wkoertgen.blogspot.de) 

Monitoring does not make much sense on an idle database, you will need a sort of **stresstest**
or **generate workload**. Every DBA has hopefully his own sripts for this. 

All this is quite tricky. Find some special workshop on Monitoring.



***


## For questions or feedback 
 contact [me](mailto:it@koertgen.de) or [my son](mailto:marcel.koertgen@gmail.com).
