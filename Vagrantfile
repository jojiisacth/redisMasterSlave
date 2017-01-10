# -*- mode: ruby -*-
# vi: set ft=ruby :



Vagrant.configure(2) do |config|

  config.vm.box = "bento/centos-7.1"
   config.vm.provision "shell" , path: "install.sh", privileged:false
      config.vm.define "RedisImageBuilderv1" do |server|
      server.vm.hostname = "RedisImageBuilderv1"
      server.vm.provider "virtualbox" do |vb|
       vb.memory = "2048"
       vb.cpus = 2
      end
	end
      
  
end