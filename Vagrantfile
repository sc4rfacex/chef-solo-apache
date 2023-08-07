Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.network "private_network", ip: "192.168.2.10"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end

  ## install chef
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "chef-repo/cookbooks"

    chef.add_recipe "apache"
    chef.arguments = "--chef-license accept"
  end
end