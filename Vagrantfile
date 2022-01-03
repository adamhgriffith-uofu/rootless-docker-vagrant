# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure("2") do |config|

  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Avoid updating the guest additions if the user has the plugin installed:
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
  end

  ##############################################################
  # Create the centos7 vm.                                     #
  ##############################################################
  config.vm.define "centos7" do |centos7|
    centos7.vm.box = "centos/7"
    centos7.vm.hostname = "centos7"
    centos7.vm.network "forwarded_port", guest: 2368, host: 2368
    centos7.vm.network "forwarded_port", guest: 8080, host: 8080

    centos7.vm.provider "virtualbox" do |vb|
      # Customize the number of CPUs on the VM:
      vb.cpus = 4

      # Display the VirtualBox GUI when booting the machine:
      vb.gui = false

      # Customize the amount of memory on the VM:
      vb.memory = 8192

      # Customize the name that appears in the VirtualBox GUI
      vb.name = "centos7"
    end

    centos7.vm.provision "shell", path: "./scripts/bootstrap.sh"

    # Display a note when running the machine.
    centos7.vm.post_up_message = "Rootless docker is now running. Enjoy!"

  end

end