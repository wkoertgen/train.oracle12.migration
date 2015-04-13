# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # use oraclelinux 7.1 from vagrant cloud
  config.vm.box = "boxcutter/oel71"

  # change memory size
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
  end

  # Oracle port forwarding
  config.vm.network "forwarded_port", guest: 11521, host: 21521

  # run setup.sh
  config.vm.provision "shell", path: "scripts/oracle12c-install.sh"

  # proxy
  #config.proxy.http     = "http://proxy:port"
  #config.proxy.https    = "http://proxy.port"
  #config.proxy.no_proxy = "localhost,127.0.0.1"
end
