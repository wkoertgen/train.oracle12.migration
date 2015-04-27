Hans Werner Körtgen, OCP
dblab koertgen
Cologne, Germany

#FAQ - Oracle12 / Oracle11 under Vagrant

####What is the difference between your solution and Oracle's solution  ?

The Oracle Upgrade Team did a great job, especially the Hand-on-Labs is marvelous.

http://www.oracle.com/technetwork/community/developer-vm/index.html
 
I was inspired by the idea of traing **Installing and Upgrading** in a VirtualBox. This is what I missed all the time working as DBA.

But  working with that Virtualbox I saw the technical limitations, eg. tiny fontsize, slow mouse pointer because of the mouse capture, difficult mounting of shared folders, the itegrated SqlDeveloper unreadable with it's very tiny fontsizes and more slower as usually, etc. 

What brought me to write my own solution was finally the circumstance, that people could learn Upgrading but not Installing.

In this solution one can study the different installation scripts of Oracle SW and creating databases.

####How long takes the setup of this VirtualBox ?

When you have Vagrant and a compatible Guest Addition - see the **README.md** - the setup is started wiht the command **vagrant up** and will finish in an hour, provided that you have a modern machine with 2 CPUs and enough memory.

####Can there be problems with the setup ?

The only problem I have experienced were the missing zip-files in the expected place - see the **README.md**

You can download these files from the indicated Oraclepages when you have Developer License, which comes with a free Oracle Account.

####How can I control the setup process ?

In your working directory there is a **Vagrantfile** with a line

**config.vm.provision "shell", path: "scripts/setup.sh"**

This refers to this script

	
	# preinstall
	/vagrant/scripts/preinstall.sh
	if [[ $? != "0" ]]; then echo "ERROR in preinstall.sh - aborting setup"; exit; fi
	
	# Oracle12 install
	/vagrant/scripts/oracle12c-install.sh
	if [[ $? != "0" ]]; then echo "ERROR in oracle12c-install.sh - aborting setup"; exit; fi
	
	# create Oracle12c Containerdatabase + pluggable database
	/vagrant/scripts/create12cdb.sh
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




By commenting / uncommenting the steps you may run a controled setup. The first time **Vagrant** runs the so called **provision**.  Next time you must say **vagrant provision.
Setting up step by step my be a good experience.

####Is Vagrant able to take snapshots ?

Of course - you may take a snapshot eg. after the preinstall to experiment with different installaltion scripts.  The you should say **vagrant snapshot take Initial**





