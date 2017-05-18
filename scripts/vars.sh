#!/bin/bash

REQ_SSL_VER="1.0.1"
SWARM_MASTER=192.168.193.80

setRootDir(){
    if [[ -d "/vagrant" ]]; then
        ROOT_DIR="/vagrant/"
    else
        ROOT_DIR="$(pwd)/"
    fi
}

testVARSet() {
    if [[ -v SWARM_MASTER ]]; then
        echo SWARM Master is Here: ${SWARM_MASTER}
    fi
}

testVARSet