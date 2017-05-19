#!/usr/bin/env bash

#set -e

source ./scripts/vars.sh
source ./scripts/common.sh

installSudo
setRootDir
aptCleanUp
installGit
installPip
upgradePIP
installCommonPython
installFlask
installOpenDXLCLient
checkOpenSSL
