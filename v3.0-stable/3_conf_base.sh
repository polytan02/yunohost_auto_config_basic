#!/bin/bash
#
# This script aims to configure the base system for ssh, create a user and simple bashrc with great colours
# It also specifies to use ovh mirrors
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
	then   echo -e "\n$failed his script must be run as root\n";
        read -p "Hit ENTER to end this script...  ";
  	exit;
fi;

files=conf_base;
# We check that all necessary files are present
for i in root.bashrc user.bashrc sshd_config sources.list_yuno;
do
	if ! [ -a "./$files/$i" ];
        then echo -e "\n$failed $i not found in folder $files";
        echo -e "\nAborting before doing anything\n";
	exit;
        fi;
done;

# Update of sources.list
sources=conf_base/sources.list_yuno;
read -e -p "Do you want to use OVH Debian mirrors ? (yn) : " -i "y" ovh;
if [ $ovh == 'y' ];
	then echo -e "\n$ok Copy apt sources.list to use ovh servers";
	cp ./$sources /etc/apt/;
	else echo -e "\n$info Ok, we don't change apt/sources.list\n";
        read -e -p "Hit ENTER to pursue...  ";
fi;

# Update of timezone
zone=`cat /etc/timezone`;
echo -e "\n$info Current timezone : $zone\n";
read -e -p "Do you want to change your timezone ? (yn) : " -i "y" zone;
if [ $zone == 'y' ];
        then dpkg-reconfigure tzdata;
        echo -e "\n$ok timezone updated\n";
        else echo -e "\n$info Ok, we don't change the timezone\n";
        read -e -p "Hit ENTER to pursue... ";
fi;

echo -e "\n$ok Copy of sshd config in /etc ";
cp -v ./$files/sshd_config /etc/ssh/sshd_config;

# Creation of a SSH user instead of admin
user=admin
echo -e "\n$info Default SSH user : $user\n";
echo -e "$info Please note that the user MUST be DIFFERENT from one created by yunohost itself";
echo -e "$info You will not be able to create a user with the same name later on with yunohost\n";
read -e -p "Do you want to create a new user to connect via ssh ? (yn) : " -i "y" create_user;
if [ $create_user == 'y' ];
	then echo -e "\n" ; read -e -p "Indicate new username to connect via ssh : " user;
	if getent passwd $user > /dev/null 2>&1;
		then echo -e "\n$info The user $user already exists";
		echo -e "\n$info We don't create it and skip this part then\n";
	        read -e -p "Hit ENTER to pursue...  ";
		else adduser $user;
		echo -e "$ok User $user created\n";
	fi;
fi;

# Change of standard SSH port
echo -e "\n$info Default SSH port : 22\n";
read -e -p "Do you want to change the default port ? (yn) : " -i "y" port;
if [ $port == 'y' ];
	then echo -e "\n" ; read -e -p "Indicate new SSH port : " -i "4242" port;
	sed -i "s/Port 22/Port $port/g" /etc/ssh/sshd_config;
	echo -e "\n$ok SSH port changed to $port\n";
	else echo -e "\n$info We skip this part then";
	read -e -p "Hit ENTER to pursue...  ";
fi;



read -e -p "Do you want SSH to ONLY accept connections from $user ? (yn) : " -i "y" allow_user;
if [ $allow_user == 'y' ];
	then echo -e "$ok Only allow $user to connect remotely from port $port";
	echo -e "AllowUsers $user" >> /etc/ssh/sshd_config;
	else echo -e "\n$info We skip this part then";
	read -e -p "Hit ENTER to pursue...  ";
fi;

# We restart SSH service
echo -e "\n--- Restarting service ssh\n";
service ssh restart;
echo -e "\n";

# Speccial .bashrc files
read -e -p "Do you want GREAT colours in bash for user $user ? (yn) : " -i "y" bash;
if [ $bash == 'y' ];
	then echo -e "$ok Copy of .bashrc to $user";
	cp -v ./$files/user.bashrc /home/$user/.bashrc;
	chown -v $user:$user /home/$user/.bashrc;
	echo -e "\n"; read -e -p "Do you want to activate bash-completion ? (yn) : " -i "y" bash_comp;
	if [ $bash_comp == 'y' ];
		then apt-get update;
		apt-get install bash-completion;
		echo -e "\n$ok bash-completion installed\n";
		else echo -e "\n$info We skip this part then";
		read -e -p "Hit ENTER to pursue...  ";
	fi;
	read -e -p "Do you want GREAT colours for ROOT as well ? (yn) : " -i "y" bash_root;
	if [ $bash_root == 'y' ];
		then echo -e "$ok Copy of .bashrc to root";
		cp -v ./$files/root.bashrc /root/.bashrc;
		else echo -e "\n$info We skip this part then";
		read -e -p "Hit ENTER to pursue...  ";
	fi;
	else echo -e "\n$info We skip this part then";
	read -e -p "Hit ENTER to pursue...  ";
fi;

echo -e "\n$info Ok, hopefully all done Well ! \n";

