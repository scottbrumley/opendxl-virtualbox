#!/bin/bash

source /vagrant/scripts/vars.sh
source /vagrant/scripts/common.sh

fixHostResolution
installDos2Unix
installDocker
setupLogin
cd /vagrant
/vagrant/scripts/bootstrap.sh

## Only Install Docker if this is a vagrant VM
#if [[ "${ROOT_DIR}" == "/vagrant/" ]]; then
#    installDocker
#fi

shrinkBox
#echo "Run sudo dd if=/dev/zero of=/EMPTY bs=1M && sudo rm -f /EMPTY to shrink VM"
#echo "Type exit to leave VM.  Then ..."
#echo "Type vagrant package --output opendxl.box to build the box"