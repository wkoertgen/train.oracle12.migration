# hello.docker.oracle12c

An experiment trying to get oracle 12c up and running in 5 minutes using vagrant, docker et al.

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

you should be able to connect to the database.
- Default password for `sys`, `system` is `vagrant`
- Port 1521
- service `cdb12c` (for container), `pdb` (for pluggable database)


## Links

We heavily bought from
- [dbehnke/oracle12c-vagrant (GitHub)](https://github.com/dbehnke/oracle12c-vagrant)
- [Starting From Windows with Linux VM as Docker Host (AMIS Technology Blog)](https://technology.amis.nl/2015/03/15/docker-take-two-starting-from-windows-with-linux-vm-as-docker-host/)
- [rhopman/docker-oracle-12c (GitHub)](https://github.com/rhopman/docker-oracle-12c)
- [wscherphof/oracle-12c (GitHub)](https://github.com/wscherphof/oracle-12c)
- [phusion/open-vagrant-boxes (GitHub)](https://github.com/phusion/open-vagrant-boxes)
