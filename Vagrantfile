# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "raring64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.network :private_network, ip: "192.168.33.10"

  # config.vm.network :public_network
  config.ssh.forward_agent = true

  config.vm.synced_folder "roots/", "/srv/"

  config.vm.provision :salt do |salt|
    salt.minion_config = "minion.conf"
    salt.run_highstate = true
  end
end
