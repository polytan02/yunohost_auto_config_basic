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

# Make sure only root can run our script
if [[ $EUID -ne 0 ]];
        then   echo "[${txtred}FAILED${txtrst}] This script must be run as root";
        exit;
fi

# We check that the user argument is given
if [ -z $1 ] ;
        then echo -e "[${txtred}FAILED${txtrst}] You must specifiy a username as first argument";
        echo -e "\nAborting before doing anything"
        exit;
fi;

# We check that the ssh port is given as a second argument
if [ -z $2 ] ;
        then echo -e "[${txtred}FAILED${txtrst}] You must specifiy a ssh port number as second argument";
        echo -e "\nAborting before doing anything"
        exit;
fi;

user=$1
port=$2
files=conf_base

# We check that all necessary files are present
for i in root.bashrc user.bashrc sshd_config sources.list
do
        if ! [ -a "./$files/$i" ]
        then echo -e "[${txtred}FAILED${txtrst}] $i not found in folder $files "
        echo -e "\nAborting before doing anything"
        exit
        fi
done

# Base user for ssh connection
echo -e "[${txtcyn}INFO${txtrst}] Username specified : $user"
adduser $user
echo -e "[${txtgrn}OK${txtrst}] User $user created"

# We add bash-completion, required for bashrc
apt-get update
apt-get upgrade
apt-get dist-upgrade
apt-get install bash-completion

echo -e "[${txtgrn}OK${txtrst}] Copy of root .bashrc"
cp ./$files/root.bashrc /root/.bashrc

echo -e "[${txtgrn}OK${txtrst}] Copy of $user .bashrc"
cp ./$files/user.bashrc /home/$user/.bashrc
chown $user:$user /home/$user/.bashrc

echo -e "[${txtgrn}OK${txtrst}] Copy of sshd config in /etc "
cp ./$files/sshd_config /etc/ssh/sshd_config
echo -e "[${txtcyn}INFO${txtrst}] SSH port specified : $port "
sed -i "s/Port 22/Port $port/g" /etc/ssh/sshd_config
echo -e "[${txtgrn}OK${txtrst}] Only allow $user to connect remotely from port $port "
echo -e "AllowUsers $user" >> /etc/ssh/sshd_config
service ssh restart

echo -e "[${txtgrn}OK${txtrst}] Copy apt sources.list to use ovh servers"
cp ./$files/sources.list /etc/apt/

echo -e "[${txtcyn}INFO${txtrst}] Ok, hopefully all done Well ! "
