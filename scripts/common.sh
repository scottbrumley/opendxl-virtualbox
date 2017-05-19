#!/bin/bash

installSudo(){
    if ! [ -x "$(command -v sudo)" ]; then
        echo 'Error: sudo is not installed.' >&2
        SUDO=""
        apt-get install -y sudo
    else
        SUDO="sudo "
    fi

}
installDocker(){
    ${SUDO}apt-get remove -y docker-engine
    ${SUDO}apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual
    ${SUDO}apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    # Verify  sudo apt-key fingerprint 0EBFCD88
    ${SUDO}add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    ${SUDO}apt-get update
    ${SUDO}apt-get install -y docker-ce
    ${SUDO}gpasswd -a vagrant docker
    ${SUDO}service docker restart
}

fixHostResolution(){
    echo "127.0.0.1   ubuntu-xenial" | sudo tee -a /etc/hosts
}
aptCleanUp(){
    ${SUDO}apt-get -y autoremove
    ${SUDO}apt-get update
}

installGit(){
    ### Install Git
    ${SUDO}apt-get install -y git
}

installPip(){
    ### Install Pip
    echo "Installing Pip"
    ${SUDO}apt-get install -y python-pip
}

installCommonPython(){
    ### Install Common
    echo "Install Common for Python"
    ${SUDO}pip install common
}
installOpenDXLCLient(){
    ### Install Open DXL Client
    echo "Installing Open DXL Client"
    cd ${ROOT_DIR}
    ${SUDO}git clone https://github.com/opendxl/opendxl-bootstrap-python.git
    cd ${ROOT_DIR}opendxl-bootstrap-python
    ${SUDO}python setup.py install
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
    ${SUDO}mkdir -p ${ROOT_DIR}brokercerts
    ${SUDO}mkdir -p ${ROOT_DIR}certs
    ${SUDO}touch ${ROOT_DIR}dxlclient.config
}

installDos2Unix(){
    ${SUDO}apt-get install -y dos2unix
}

setEnvVariables(){
    /${ROOT_DIR}/scripts/env.sh
}

setupLogin(){
    echo "#!/bin/bash" | sudo tee -a /etc/profile.d/environment.sh
    echo "cd /${ROOT_DIR}" | sudo tee -a /etc/profile.d/environment.sh
    ${SUDO}chmod +x /etc/profile.d/environment.sh
}

shrinkBox(){
    ${SUDO}apt-get clean
    ${SUDO}cat /dev/null > ~/.bash_history && history -c
}

installFlask(){
    ## Setup Flask
    ## Use flask run --host=0.0.0.0 to start Flask
    ${SUDO}pip install Flask
    ${SUDO}echo "export FLASK_APP=${ROOT_DIR}examples/tie_rep_api.py" >> /etc/bash.bashrc
}

upgradePIP(){
    ${SUDO}pip install --upgrade pip
}