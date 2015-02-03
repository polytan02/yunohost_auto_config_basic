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
  	exit;
fi

# We check that the user argument is given
if [ -z $1 ] ;
	then echo -e "\n" ; read -e -p "Indicate new username to connect via ssh : " user;
	else user=$1;
fi; if [ -z $user ] ;
        then echo -e "\n$failed You must specifiy a username as first argument";
       	echo -e "\nAborting before doing anything";
        exit;
fi;

# We check if the user already exists
if getent passwd $user > /dev/null 2>&1; then
        echo -e "\n$failed The user $user already exists "
        echo -e "\nAborting before doing anything"
        exit;
fi


# We check that the ssh port is given as a second argument
if [ -z $2 ] ;
	then echo -e "\n" ; read -e -p "Indicate new ssh port :" port;
	else port=$2;
fi; if [ -z $port ] ;
	then echo -e "$failed You must specifiy a ssh port number as second argument";
        echo -e "\nAborting before doing anything";
       	exit;
fi;

files=conf_base

# We check that all necessary files are present
for i in root.bashrc user.bashrc sshd_config sources.list
do
	if ! [ -a "./$files/$i" ]
        then echo -e "\n$failed $i not found in folder $files "
        echo -e "\nAborting before doing anything"
	exit
        fi
done

# Base user for ssh connection
echo -e "$info Username specified : $user"
adduser $user
echo -e "$ok User $user created"

echo -e "$ok Copy of root .bashrc"
cp ./$files/root.bashrc /root/.bashrc

echo -e "$ok Copy of $user .bashrc"
cp ./$files/user.bashrc /home/$user/.bashrc
chown $user:$user /home/$user/.bashrc


# Update of apt/sources.list to use ovh servers
echo -e "$ok Copy apt sources.list to use ovh servers"
cp ./$files/sources.list /etc/apt/

# We add bash-completion, required for bashrc
apt-get update
apt-get upgrade
apt-get dist-upgrade
apt-get install bash-completion


echo -e "$ok Copy of sshd config in /etc "
cp ./$files/sshd_config /etc/ssh/sshd_config
echo -e "$info SSH port specified : $port "
sed -i "s/Port 22/Port $port/g" /etc/ssh/sshd_config
echo -e "$ok Only allow $user to connect remotely from port $port"
echo -e "AllowUsers $user" >> /etc/ssh/sshd_config
echo -e "\n--- Restarting service ssh\n"
service ssh restart
echo -e "\n$info Ok, hopefully all done Well ! \n"
