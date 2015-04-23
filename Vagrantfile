# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # use oraclelinux 7.1 from vagrant cloud
  config.vm.box = "boxcutter/oel71"

  # auto-update guest additions so we can ssh into the box
  #config.vbguest.auto_update = true

  # additonal folders
  #config.vm.synced_folder "./develop", "/develop", owner: "oracle", group: "oinstall"

  # change memory size, cpu#
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 2
  end
  
  # Oracle port forwarding
  config.vm.network "forwarded_port", guest: 1521, host: 11521

  # run setup.sh
  config.vm.provision "shell", path: "scripts/setup.sh"
end
