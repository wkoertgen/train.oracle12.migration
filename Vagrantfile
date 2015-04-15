# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # use oraclelinux 7.1 from vagrant cloud
  config.vm.box = "boxcutter/oel71"

  # auto-update guest additions so we can ssh into the box
  #config.vbguest.auto_update = true

  # additonal folders
  config.vm.synced_folder "./monitor", "/monitor",
  owner: "oracle", group: "oinstall"

  # change memory size, cpu#
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 2
  end
  
  # Oracle port forwarding
  config.vm.network "forwarded_port", guest: 11521, host: 21521

  # run setup.sh
  config.vm.provision "shell", path: "scripts/oracle12c-install.sh"
  #config.vm.provision "shell", path: "scripts/oracle11g-install.sh"
end
