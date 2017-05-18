#!/bin/bash

rm -rf opendxl.box

if [[ "{$OS}" =~ "Windows" ]]; then
    cmd //C del %userprofile%\\.vagrant.d\\insecure_private_key
fi

if [ "${1}" == "vsphere" ]; then
    echo "Setup Vsphere"
    vagrant plugin install vagrant-vsphere
    VAGRANT_VAGRANTFILE=vsphere vagrant up --provider=vsphere && vagrant ssh
else
   echo "Setup Virtualbox"
    vagrant up --provider=virtualbox && vagrant ssh
fi
