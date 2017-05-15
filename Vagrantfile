
Vagrant.configure(2) do |config|
  config.vm.box = "minimal/xenial64"

  config.vm.synced_folder "./", "/vagrant"

  config.vm.provision "shell", path: "scripts/bootstrap.sh"
end
