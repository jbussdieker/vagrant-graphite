# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  require 'yaml'
  ec2_config = YAML.load(File.read("ec2.yaml"))

  config.vm.provider :aws do |aws, override|
    config.vm.box = "dummy"
    aws.access_key_id = ec2_config[:access_key_id]
    aws.secret_access_key = ec2_config[:secret_access_key]
    aws.ami = ec2_config[:ami]
    aws.instance_type = ec2_config[:instance_type]
    aws.region = ec2_config[:region]
    aws.keypair_name = ec2_config[:keypair_name]
    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = "/Users/jbussdieker/.ssh/id_rsa"
  end

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

    config.vm.provider :aws do |aws, override|
      aws.user_data = <<EOS
#cloud-config
hostname: #{name}
packages:
- puppet
EOS
    end
  end
end
