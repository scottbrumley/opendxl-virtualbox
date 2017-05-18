#!/bin/bash

SWARM_MASTER=192.168.193.80

testVARSet() {
    if [[ -v SWARM_MASTER ]]; then
        echo SWARM Master is Here: ${SWARM_MASTER}
    fi
}

testVARSet