#!/bin/bash
#
# This script aims to configure the base system for ssh (checking that the port is available),
# creates a user and simple bashrc with great colours
# It also specifies to use ovh mirrors, locale, timezone and hostname
#
# polytan02@mcgva.org
# 13/04/2015
#

# Setup of colours for error codes
set -e
txtgrn=$(tput setaf 2)    # Green
txtred=$(tput setaf 1)    # Red
txtcyn=$(tput setaf 6)    # Cyan
txtrst=$(tput sgr0)       # Text reset
failed=[${txtred}FAILED${txtrst}]
warning=[${txtred}WARNING${txtrst}]
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
for i in root.bashrc user.bashrc sshd_config sources.list;
do
	if ! [ -a "./$files/$i" ];
        then echo -e "\n$failed $i not found in folder $files";
        echo -e "\nAborting before doing anything\n";
        read -p "Hit ENTER to end this script...  ";
	exit;
        fi;
done;

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
fi;

# Update of sources.list
sources=conf_base/sources.list;
echo -e "\n" ; read -e -p "Do you want to use OVH Debian mirrors ? (yn) : " -i "y" ovh;
if [ $ovh == 'y' ];
	then echo -e "\n$ok Copy apt sources.list to use ovh servers";
	cp ./$sources /etc/apt/;
	echo "deb http://repo.yunohost.org/ megusta main" >> /etc/apt/sources.list;
	else echo -e "\n$info Ok, we don't change apt/sources.list\n";
fi;

# Update of timezone
zone=`cat /etc/timezone`;
echo -e "\n\n$info Current timezone : $zone\n";
read -e -p "Do you want to change your timezone ? (yn) : " -i "y" zone;
if [ $zone == 'y' ];
        then dpkg-reconfigure tzdata;
        echo -e "\n$ok timezone updated\n";
        else echo -e "\n$info Ok, we don't change the timezone\n";
fi;


# Update of locales
echo -e "\n"; read -e -p "Do you want to change your locale ? (yn) : " -i "y" locales
if [ $locales == 'y' ]
        then dpkg-reconfigure locales
        echo -e "\n$ok timezone updated\n";
        else echo -e "\n$info Ok, we don't change the locales\n";
fi;


# SSH configuration with standard Yunohost file with root allowed to connect
echo -e "\n\n$ok Copy of sshd config in /etc ";
cp ./$files/sshd_config /etc/ssh/sshd_config;

# Creation of a SSH user instead of admin
user=admin
echo -e "\n$info Default SSH user : $user\n";
echo -e "$info Please note that the user MUST be DIFFERENT from one created by yunohost itself";
echo -e "$info You will not be able to create a user with the same name later on with yunohost";
echo -e "$info I don't like using admin, hence the creation of a dedicated ssh user\n";
read -e -p "Do you want to create a new user to connect via ssh ? (yn) : " -i "y" create_user;
if [ $create_user == 'y' ];
	then echo -e "\n" ; read -e -p "Indicate new username to connect via ssh : " new_user;
	if getent passwd $new_user > /dev/null 2>&1;
		then echo -e "\n$info The user $new_user already exists";
		echo -e "\n$info We don't create it and skip this part then\n";
		else adduser $new_user;
		echo -e "\n$ok User $new_user created\n";
		user=$new_user;
		read -e -p "Add user $user to sudo group ? (yn) : " -i "y" sudo_user;
		if [ $sudo_user == 'y' ];
				then echo -e "\n" ; adduser $user sudo;
				echo -e "\n$ok User \" $user \" added to sudo group\n";
			        else echo -e "\n$ok We skip this part then\n";
		fi;

	fi;
fi;


# Change of standard SSH port
echo -e "\n$info Default SSH port : 22\n";
read -e -p "Do you want to change the default port ? (yn) : " -i "y" port;
if [ $port == 'y' ];
	then read -e -p "Indicate new SSH port : " -i "4242" port;
	# Check port availability
	echo -e "\n" ; yunohost app checkport $port;
	if [[ ! $? -eq 0 ]];
		then echo -e "\n$failed The port $port is already used";
		echo -e "\n$info We don't change the default SSH port and skip this part then\n";
	        read -e -p "Hit ENTER to pursue...  ";
		else
		# Open port in firewall
		echo -e "\n" ; yunohost firewall allow TCP $port;
		sed -i "s/Port 22/Port $port/g" /etc/ssh/sshd_config;
		echo -e "\n$ok SSH port changed to $port in sshd_config\n";
	fi;
	else echo -e "\n$info We skip this part then\n";
fi;


# We limit the connection to a single user
echo -e "\n$info Limit connections to a single user\n";
read -e -p "Do you want SSH to ONLY accept connections from user \" $user \" on port $port ? (yn) : " -i "y" allow_user;
if [ $allow_user == 'y' ];
        then echo -e "\n$ok Only allow user \" $user \" to connect remotely from port $port";
	echo -e "AllowUsers $user" >> /etc/ssh/sshd_config;
        sed -i "s/PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config;
	else echo -e "\n$info We skip this part then\n";
	echo -e "$warning As you said NO to previous question, SSH is configured to allow root to connect on port $port";
	echo -e "$warning This should NOT be the case and you will have to manually correct this !\n";
fi;

# We restart SSH service
echo -e "\n--- Restarting service ssh\n";
service ssh restart;
echo -e "\n";

# Special .bashrc files for $user
echo -e "\n$info Special bashrc configuration\n";
read -e -p "Do you want GREAT colours in bash for user $user ? (yn) : " -i "y" bash;
if [ $bash == 'y' ];
	then if [ $user == 'admin' ];
		then echo -e "\n$failed Not possible for admin, it has to be for a different name\n";
		else echo -e "$ok Copy of .bashrc to $user";
		cp ./$files/user.bashrc /home/$user/.bashrc;
		chown $user:$user /home/$user/.bashrc;
	fi;
        else echo -e "\n$info We skip this part then\n";
fi;

# Special .bashrc for root
echo -e "\n"; read -e -p "Do you want GREAT bash colours for ROOT ? (yn) : " -i "y" bash_root;
if [ $bash_root == 'y' ];
	then echo -e "$ok Copy of .bashrc to root";
	cp ./$files/root.bashrc /root/.bashrc;
	else echo -e "\n$info We skip this part then\n";
fi;

# Activation of bash-completion
echo -e "\n"; read -e -p "Do you want to activate bash-completion ? (yn) : " -i "y" bash_comp;
if [ $bash_comp == 'y' ];
	then apt-get update -qq > /dev/null 2>&1;
	apt-get install bash-completion -y > /dev/null 2>&1;
	echo -e "$ok bash-completion installed\n";
	else echo -e "\n$info We skip this part then\n";
fi;



echo -e "\n$info Ok, hopefully all done Well ! \n";

