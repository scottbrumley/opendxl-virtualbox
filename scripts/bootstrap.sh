#!/usr/bin/env bash

#set -e

REQ_SSL_VER="1.0.1"

if [[ -d "/vagrant" ]]; then
    ROOT_DIR="/vagrant/"
else
    ROOT_DIR="$(pwd)/"
fi

aptCleanUp(){
    sudo apt-get -y autoremove
}

installGit(){
    ### Install Git
    sudo apt-get install -y git
}

installPip(){
    ### Install Pip
    echo "Installing Pip"
    sudo apt-get install -y --upgrade python-pip
}

installCommonPython(){
    ### Install Common
    echo "Install Common for Python"
    sudo pip install common
}
installOpenDXLCLient(){
    ### Install Open DXL Client
    echo "Installing Open DXL Client"
    cd ${ROOT_DIR}
    sudo git clone https://github.com/opendxl/opendxl-bootstrap-python.git
    cd ${ROOT_DIR}opendxl-bootstrap-python
    sudo python setup.py install
}

checkOpenSSL(){
### Check OpenSSL
SSL_VER=$(python -c 'import ssl; print(ssl.OPENSSL_VERSION)')

if [[ "${SSL_VER}" =~ "${REQ_SSL_VER}" ]]; then
    echo "Already Version ${REQ_SSL_VER}"
else
    echo "Need OpenSSL version ${REQ_SSL_VER} or higher"
fi
}

createDXLConfigDirs(){
    ### Create Directories
    sudo mkdir -p ${ROOT_DIR}brokercerts
    sudo mkdir -p ${ROOT_DIR}certs
    sudo touch ${ROOT_DIR}dxlclient.config
}

installDos2Unix(){
    sudo apt-get install -y dos2unix
}

setEnvVariables(){
    /vagrant/scripts/env.sh
}

setupLogin(){
    echo "#!/bin/bash" | sudo tee -a /etc/profile.d/environment.sh
    echo "cd /vagrant" | sudo tee -a /etc/profile.d/environment.sh
    sudo chmod +x /etc/profile.d/environment.sh
}

shrinkBox(){
    sudo apt-get clean
    sudo dd if=/dev/zero of=/EMPTY bs=1M
    sudo rm -f /EMPTY
    cat /dev/null > ~/.bash_history && history -c && exit
}

aptCleanUp
installGit
installPip
installCommonPython
installOpenDXLCLient
checkOpenSSL
installDos2Unix
setupLogin
shrinkBox
