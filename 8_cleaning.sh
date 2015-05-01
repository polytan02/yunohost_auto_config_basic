#!/bin/bash
#
# This script aims to configure fail2ban so that emails would be sent
#
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
info=[${txtcyn}INFO${txtrst}]


# Make sure only root can run our script
if [[ $EUID -ne 0 ]];
        then   echo -e "\n$failed This script must be run as root\n";
        read -p "Hit ENTER to end this script...  \n";
        exit;
fi;

echo -e "\n$info Cleaning with apt-get autoremove and autoclean\n";
read -e -p "Should we make some cleaning ? (yn) : " -i "y" clean;
if [ $clean == 'y' ];
	then   echo -e "\n$info Ok, here we clean\n";
	apt-get autoremove -qq;
	echo -e "\n$ok apt-get autoremove done";
	apt-get autoclean -qq;
	echo -e "\n$ok apt-get autoclean done";
	else
	echo -e "\n$info Ok, we don't clean today...";
	exit;
fi;

echo -e "\n$info Hopefully, all done Well ! :) \n";
