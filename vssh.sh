#!/usr/bin/env bash

if [[ "{$OS}" =~ "Windows" ]]; then
    cmd //C del %userprofile%\\.vagrant.d\\insecure_private_key
fi

vagrant up --provider=virtualbox && vagrant ssh  ## Build the Box and SSH to it
vagrant package --output opendxl.box             ## Create a box to deploy on atlas
