#!/bin/bash

REQ_SSL_VER="1.0.1"
SWARM_MASTER=192.168.193.80
LOCAL_BUILD="mcafee:opendxl"
REMOTE_BUILD="sbrumley/opendxl"

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