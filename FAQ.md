# FAQ on Oracle12 / Oracle11 on Vagrant

## 1. How can i control the setup process?
In the `Vagrantfile` there is a line 

	config.vm.provision "shell", path: "scripts/setup.sh"

which refers to this script. You can control the process by uncommenting / comment the scripts

## 2. Is Vagrant able to take snapshots?
Using snapshots with virtualization can be a huge time saver. If you use vagrant with VirtualBox you can install the snapshot plugin [vagrant-vbox-snapshot](https://github.com/dergachev/vagrant-vbox-snapshot) via

	vagrant plugin install vagrant-vbox-snapshot

When experimenting with your oracle sandbox VM it makes sense to take snapshots, e.g. after the `preinstall`:

	 vagrant snapshot take Initial

When you want to start the next step, just enter 

	vagrant provision.

## 2. Which shared folders do exist? 
In the work directory where you execute `vagrant up`, there are 2 directories `./logs` and `./scripts`. The provisioning scripts log into `./logs`. In the `./develop` you may store your own SQL-scripts.
Connect to the VM like that – provided that you know / change the password of the user oracle.
Go to your vagrant-root directory /vagrant an walk around.

## 3. What should i do after entering the VM?
To connect to the guest VM type

	vagrant ssh

Usually the first step on an unknown oracle machine is 

	cat /etc/oratab.  

This informs you that we have two Oracle environments and two databases `CDB1` and `UPGR`. Choose your environment by using little scripts in `/usr/local/bin`

 – `cdb1` sets up the Oracle12g environment and 
 - `upgr` sets up the Oracle11g environment. 
 
Both provide practical aliases as 

- `s` for `sqlplus / as sysdba` or 
- `oh` to go to your current `ORACLE_HOME`. 
 
Feel free to add your own shortcuts.

**NOTE:** I have installed the Oracle11g patchlevel 11.2.0.1 which is known as buggy. It was cumbersome to install. Latest patch of this release was Oracle11g 11.2.0.4, which unfortunately is not available for owners of a standard developer license. As we aim to this target group we decided to install the early 11.2.0.1 version.

## 4. How can I see which database is running?

	TODO: paste script?

Another approach is

	TODO: paste script

## 5. How can I handle the listener(s)?

To start / shutdown a listener 

	TODO: paste script

## 6. How can I handle TNS problems? 
I have placed the listener.ora and the tnsnames.ora in $TNS_ADMIN (/var/opt/oracle). 
Even if the tnsping utility shows a database, it does not mean that you can reach the database via then TNS framework. There are a some common pitfalls in the TNS configuration.
Here is a typical TNS problem

	TODO: paste script

Correct the syntax error and the you can connect via then TNS.

## 7. How can I see the options of a database?
It is crucial to know the options of a database, because it decides what I can do with it. Besides, in production, it is a matter of license fees. Write a little script, e.g. `registry.sql`

	TODO: paste script

If you execute it in the `CDB1` database you see this listing

	TODO: paste script

See the difference in the `UPGR` database:

	TODO: paste script

Here I decided to limit the options the minimum, because we need this database only for educational purposes, i.e. for training the different methods of upgrading a database to Oracle12c. Study the scripts [scripts/create11gdb.sh](scripts/create11gdb.sh) and [scripts/create11gdb.sql](scripts/create11gdb.sql) to see the old manual way of creating a database. 

The `CDB1` was created using `dbca` in silent mode. Study the scripts [scripts/create12cdb.sh](scripts/create12cdb.sh). For newcomers all scripts in the subdirectory `./scripts` are a complete workshop on installing.

## 8. Shutdown databases
For new-comers only: there are different ways of shutting down, especially in Oracle12c Container Databases. This would be part of on extra workshop. For now see

## 9. What has Vagrant to do with VirtualBox?
See some good books, e.g. [Vagrant Up and Runnin](http://chimera.labs.oreilly.com/books/1234000001668/) by Mitchell Hashimoto, the author of Vagrant. 

## 10. As user oracle I cannot execute scripts stored in the shared folders. 
As user `vagrant` you have no problem, because the shared folder `/vagrant` is owned by user `vagrant`. If you want full compliance of your scripts .eg. in the folder `/vagrant/develop` you could do the following:

In `Vagrantfile` uncomment the line 

		#config.vm.synced_folder "./develop", "/develop", owner: "oracle", group: "oinstall" 

then execute

	vagrant reload

Before setup there is no user `oracle`. There we cannot leave this line uncommented.
See the difference of a mounted shared folder.

	TODO: paste script

Here is one of my scripts, developed during 15 years working as DBA.
It would surpass this handout to demonstrate this tool. Writing one's own DBA – scripts can be taught in a special workshop e.g. on 

- Performance Tuning or 
- New Features in PL/SQL or 
- working with In-Memory Database. 
 
In any case it would be a good idea to take a snapshot before you begin to work with the databases. If there are questions, contact [me](mailto:it@koertgen.de) or [my son](mailto:marcel.koertgen@gmail.com).