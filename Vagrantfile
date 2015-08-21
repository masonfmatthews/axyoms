# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  # Configurate the virtual machine to use 2GB of RAM
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  config.vm.define "rails_psql_neo4j" do |vm|
  end

  # Forward the Rails server default port to the host
  # BUT, in Rails 4.2, you'll have to start the server with `rails s -b 0.0.0.0`
  # See this link for permanent solution: http://stackoverflow.com/questions/27627286/cant-connect-localhost3000-ruby-on-rails-in-vagrant
  config.vm.network :forwarded_port, guest: 3000, host: 3000 #WEBrick
  config.vm.network :forwarded_port, guest: 7474, host: 7474 #Neo4J

  # Use Chef Solo to provision our virtual machine
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks", "site-cookbooks"]

    chef.add_recipe "apt"
    chef.add_recipe "nodejs"
    chef.add_recipe "ruby_build"
    chef.add_recipe "java"
    chef.add_recipe "rbenv::user"
    chef.add_recipe "rbenv::vagrant"
    chef.add_recipe "postgresql::server"
    chef.add_recipe "postgresql::client"
    chef.add_recipe "neo4j-server::tarball"

    # Install Ruby and Bundler
    # Set an empty root password for MySQL to make things simple
    chef.json = {
      rbenv: {
        user_installs: [{
          user: 'vagrant',
          rubies: ["2.2.2"],
          global: "2.2.2"#,
          # gems: {
          #   "2.2.2" => [
          #     { name: "bundler" }
          #   ]
          # }
        }]
      },
      postgresql: {
        password: {
          # md5 hash of "password", BUT THIS NEVER WORKED.
          # echo -n 'password''postgres' | openssl md5 | sed -e 's/.* /md5/'
          postgres: '32e12f215ba27cb750c9e093ce4b5127'

          # Instead, follow all instructions here:
          # http://suite.opengeo.org/4.1/dataadmin/pgGettingStarted/firstconnect.html
          # Then:
          # CREATE USER rails PASSWORD 'password' CREATEDB;
        }
      },
      java: {
        jdk_version: "7"
      }
    }
  end
end
