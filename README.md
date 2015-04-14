# hello.docker.oracle12c

An experiment trying to get oracle 12c up and running in 5 minutes using vagrant, docker et al.
We want to evaluate the lowest possible entry barrier for getting started with Oracle 12C, e.g. for easy 
and scalable setup of training sessions, webinars, etc. 

## Prerequisites

You should have installed

- [VirtualBox](https://www.virtualbox.org/) (v4.3.26)
- [vagrant](https://www.vagrantup.com/) (v1.7.2)

### Oracle 12cR1

- Download [Database Install files (1 and 2)](http://www.oracle.com/technetwork/database/enterprise-edition/downloads/database12c-linux-download-1959253.html)
    - `linuxamd64_12102_database_1of2.zip` (1.5G)
    - `linuxamd64_12102_database_2of2.zip` (967.5M)
- Place the zip archives in `database_installer/`

## Connect to Database

After running

    vagrant up

you should be able to connect to the database using *TODO: Port forwarding?*

- Default password for `sys` and `system` is `vagrant`
- Service `cdb12c` for container
- Service `pdb` for pluggable database


## Links

We considered gratefully the following links

- [dbehnke/oracle12c-vagrant (GitHub)](https://github.com/dbehnke/oracle12c-vagrant)
- [Starting From Windows with Linux VM as Docker Host (AMIS Technology Blog)](https://technology.amis.nl/2015/03/15/docker-take-two-starting-from-windows-with-linux-vm-as-docker-host/)
- [rhopman/docker-oracle-12c (GitHub)](https://github.com/rhopman/docker-oracle-12c)
- [wscherphof/oracle-12c (GitHub)](https://github.com/wscherphof/oracle-12c)
- [phusion/open-vagrant-boxes (GitHub)](https://github.com/phusion/open-vagrant-boxes)

## TODO

	1. change resource, kernel parameters, shared memory config, etc. to run several databases
	2. create first CDB as of Oracle12
	3. install Oracle11g (Release 11.2.0.4)
	4. create first Non-CDB database
