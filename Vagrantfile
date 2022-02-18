# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "apopa/focal64"
  config.vm.hostname = "pcap"
  config.vm.provision "shell", path: "boot/pkg.sh"
  config.vm.network "public_network", ip: "192.168.178.69", bridge: "en8: USB 10/100/1000 LAN" # this will have to be changed
end
