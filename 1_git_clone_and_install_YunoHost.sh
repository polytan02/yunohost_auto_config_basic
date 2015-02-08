#!/bin/bash
#
# This script aims to install yunohost v2 from git
#
# polytan02@mcgva.org
# 03/02/2015
#

# Setup of colours for error codes
set -e
txtgrn=$(tput setaf 2)    # Green
txtred=$(tput setaf 1)    # Red
txtcyn=$(tput setaf 6)    # Cyan
txtpur=$(tput setaf 5)    # Purple
txtrst=$(tput sgr0)       # Text reset
failed=[${txtred}FAILED${txtrst}]
ok=[${txtgrn}OK${txtrst}]
info=[${txtcyn}INFO${txtrst}]
script=[${txtpur}SCRIPT${txtrst}]


# Make sure only root can run our script
if [[ $EUID -ne 0 ]];
        then   echo -e "\n$failed This script must be run as root\n";
	read -p "Hit ENTER to end this script...  ";
        exit;
fi;

echo -e "\n$script INSTALLTION OF YUNOHOST\n";

# Update of sources.list
sources=conf_base/sources.list
if [ -a "$sources" ];
	then read -e -p "Do you want to use OVH Debian mirrors ? (yn) : " -i "y" ovh;
	if [ $ovh == 'y' ]
        	then echo -e "\n$ok Copy apt sources.list to use ovh servers";
		cp ./$sources /etc/apt/;
	        else echo -e "\n$info Ok, we don't change apt/sources.list\n";
        	read -e -p "Hit ENTER to pursue...  ";
	fi;
fi;

# Update of timezone
zone=`cat /etc/timezone`
echo -e "\n$info Current timezone : $zone\n"
read -e -p "Do you want to change your timezone ? (yn) : " -i "y" zone
if [ $zone == 'y' ]
        then dpkg-reconfigure tzdata
	echo -e "\n$ok timezone updated\n";
        else echo -e "\n$info Ok, we don't change the timezone\n";
        read -e -p "Hit ENTER to pursue to apt-get update and YnH Installation...  ";
fi;

# Update of locales
read -e -p "Do you want to change your locale ? (yn) : " -i "y" locales
if [ $locales == 'y' ]
        then dpkg-reconfigure locales
	echo -e "\n$ok timezone updated\n";
        else echo -e "\n$info Ok, we don't change the locale\n";
        read -e -p "Hit ENTER to pursue to apt-get update and YnH Installation...  ";
fi;


# Update of packages list
echo -e "$info Update of packages list\n";
apt-get update;
apt-get upgrade;
apt-get dist-upgrade;
apt-get install git;

# Installation of Yunohost from git
echo -e "\n$start Installation of Yunohost v2 from git sources\n"

git clone https://github.com/YunoHost/install_script /tmp/install;
/tmp/install/install_yunohostv2;


