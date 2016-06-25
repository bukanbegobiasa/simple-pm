# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu_server"
  config.vm.box_url = "file:///home/satrio/Workspace/vagrant-box/ubuntu-server.box"

  config.vm.hostname = "satrio"

  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 3000, host: 3100

  config.vm.network :private_network, ip: "10.10.10.27"

  config.ssh.forward_agent = true

  config.vm.synced_folder ".", "/dee"

  config.vm.provider "virtualbox" do |vb|
     vb.customize ["modifyvm", :id, "--memory", "2048"]
     vb.customize ["modifyvm", :id, "--acpi",   "on"]
     vb.customize ["modifyvm", :id, "--ioapic", "on"]
     vb.customize ["modifyvm", :id, "--cpus",   "2"]
  end
end
