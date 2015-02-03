#!/bin/bash
#
# This script aims to install yunohost v2 from git
#
# polytan02@mcgva.org
# 02/02/2015
#

# Setup of colours for error codes
set -e
txtgrn=$(tput setaf 2)    # Green
txtred=$(tput setaf 1)    # Red
txtcyn=$(tput setaf 6)    # Cyan
txtrst=$(tput sgr0)       # Text reset
failed=[${txtred}FAILED${txtrst}]
ok=[${txtgrn}OK${txtrst}]
start=[${txtgrn}starting${txtrst}]
info=[${txtcyn}INFO${txtrst}]


# Make sure only root can run our script
if [[ $EUID -ne 0 ]];
        then   echo -e "\n$failed This script must be run as root\n";
        exit;
fi


# Installation of Yunohost from git
echo -e "$start Installation of Yunohost v2 from git sources "

apt-get update
apt-get upgrade
apt-get dist-upgrade
apt-get install git
git clone https://github.com/YunoHost/install_script /tmp/install
/tmp/install/install_yunohostv2;
apt-get autoremove


echo -e "\n$info Hopefully, all done Well ! :) \n"

