#!/usr/bin/env bash

#set -e

REQ_SSL_VER="1.0.1"

if [[ -d "/vagrant" ]]; then
    ROOT_DIR="/vagrant/"
else
    ROOT_DIR="$(pwd)/"
fi

installDocker(){
    sudo apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    # Verify  sudo apt-key fingerprint 0EBFCD88
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce
    sudo gpasswd -a vagrant docker
    sudo service docker restart
}

fixHostResolution(){
    echo "127.0.0.1   ubuntu-xenial" | sudo tee -a /etc/hosts
}
aptCleanUp(){
    sudo apt-get -y autoremove
    sudo apt-get update
}

installGit(){
    ### Install Git
    sudo apt-get install -y git
}

installPip(){
    ### Install Pip
    echo "Installing Pip"
    sudo apt-get install -y python-pip
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
    /${ROOT_DIR}/scripts/env.sh
}

setupLogin(){
    echo "#!/bin/bash" | sudo tee -a /etc/profile.d/environment.sh
    echo "cd /${ROOT_DIR}" | sudo tee -a /etc/profile.d/environment.sh
    sudo chmod +x /etc/profile.d/environment.sh
}

shrinkBox(){
    sudo apt-get clean
    sudo cat /dev/null > ~/.bash_history && history -c
}

installFlask(){
    ## Setup Flask
    ## Use flask run --host=0.0.0.0 to start Flask
    sudo pip install Flask
    sudo echo "export FLASK_APP=${ROOT_DIR}examples/tie_rep_api.py" >> /etc/bash.bashrc
}

upgradePIP(){
    sudo pip install --upgrade pip
}


fixHostResolution
aptCleanUp
installGit
installPip
upgradePIP
installCommonPython
installFlask
installOpenDXLCLient
checkOpenSSL
installDos2Unix
setupLogin

## Only Install Docker if this is a vagrant VM
#if [[ "${ROOT_DIR}" == "/vagrant/" ]]; then
#    installDocker
#fi

shrinkBox
#echo "Run sudo dd if=/dev/zero of=/EMPTY bs=1M && sudo rm -f /EMPTY to shrink VM"
#echo "Type exit to leave VM.  Then ..."
#echo "Type vagrant package --output opendxl.box to build the box"