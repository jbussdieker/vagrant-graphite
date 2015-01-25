# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.network "private_network", type: "dhcp"

  config.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true
  config.vm.network "forwarded_port", guest: 2003, host: 2003, auto_correct: true
  config.vm.network "forwarded_port", guest: 2004, host: 2004, auto_correct: true
  config.vm.network "forwarded_port", guest: 7002, host: 7002, auto_correct: true

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path = "modules"
    puppet.manifest_file  = "site.pp"
    puppet.hiera_config_path = "hiera.yaml"
    puppet.options = "--show_diff"
  end

  Dir[File.join("hieradata/nodes", "*.yaml")].sort.each do |node_yaml|
    require 'yaml'
    node = YAML.load_file(node_yaml)
    name = File.basename(node_yaml).split(".").first

    config.vm.define name do |box|
      box.vm.hostname = name
    end
  end
end
