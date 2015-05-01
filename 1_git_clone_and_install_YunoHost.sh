#!/bin/bash
#
# This script aims to install yunohost v2 from git
#
# polytan02@mcgva.org
# 10/04/2015
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

# Update of hostname
hostname=`cat /etc/hostname`;
echo -e "\n$info Current hostname : $hostname \n";
read -e -p "Do you want to change the hostname of this server ? (yn) : " -i "y" change_hostname;
if [ $change_hostname == 'y' ];
        then echo -e "\n" ; read -e -p "Indicate the new hostname : " new_hostname;
        if [ ! -z $new_hostname ];
                then echo $new_hostname > /etc/hostname
                echo -e "\n$ok hostname updated to $new_hostname \n";
                else echo -e "\n$failed The hostname seems empty, we don't change it !";
                echo -e "\n$info current hostname : $hostname \n";
                read -e -p "Hit ENTER to pursue...  ";
        fi;
        else echo -e "\n$info Ok, we don't change the hostname\n";
#        read -e -p "Hit ENTER to pursue to Debian mirrors configuration...  ";
fi;

# Update of sources.list
sources=conf_base/sources.list
if [ -a "$sources" ];
	then echo -e "\n" ; read -e -p "Do you want to use OVH Debian mirrors ? (yn) : " -i "y" ovh;
	if [ $ovh == 'y' ]
        	then echo -e "\n$ok Copy apt sources.list to use ovh servers\n";
		cp ./$sources /etc/apt/;
	        else echo -e "\n$info Ok, we don't change apt/sources.list\n";
#        	read -e -p "Hit ENTER to pursue...  ";
	fi;
fi;

# Update of timezone
timezone=$(cat /etc/timezone)
echo -e "\n$info Current timezone : $timezone\n"
read -e -p "Do you want to change your timezone ? (yn) : " -i "y" change_timezone
if [ $change_timezone == 'y' ]
        then dpkg-reconfigure tzdata
	echo -e "\n$ok timezone updated\n";
        else echo -e "\n$info Ok, we don't change the timezone\n";
#        read -e -p "Hit ENTER to pursue...  ";
fi;

# Update of locales
echo -e "\n" ; read -e -p "Do you want to change your locale ? (yn) : " -i "y" locales
if [ $locales == 'y' ]
        then dpkg-reconfigure locales
	echo -e "\n$ok locales updated\n";
        else echo -e "\n$info Ok, we don't change the locale\n\n";
        read -e -p "Hit ENTER to pursue to apt-get update and YnH Installation...  ";
fi;


# Update of packages list and installation of git
echo -e "\n$info Update of packages list\n";
apt-get update -qq > /dev/null 2>&1;
apt-get dist-upgrade -qq > /dev/null 2>&1;
apt-get install git -y > /dev/null 2>&1;

# Installation of Yunohost from git
echo -e "\n$script Installation of Yunohost v2 from git sources\n"

git clone https://github.com/YunoHost/install_script /tmp/install;
/tmp/install/install_yunohostv2;


