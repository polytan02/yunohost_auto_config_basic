#!/bin/bash
#
# This script aims to install yunohost v2 from git
#
# polytan02@mcgva.org
# 01/05/2015
#

echo -e "\nVeuillez choisir la langue (en/fr) :";
read -e -p "Please choose the language (en/fr) : " -i "fr" lang;
if [ $lang != "en" ];
        then if [ $lang != "fr" ];
                then echo -e "\nLanguage not recognised, reverting to English";
                lang="en"
        fi;
fi;

# We make sure the user launch the script from the bundle, or at least one folder up
if [[ ! -e 1_git_clone_and_install_YunoHost.sh ]];
	then if [[ -d yunohost_auto_config_basic ]];
        	then cd yunohost_auto_config_basic || {
		if [ $lang == "fr" ];
			then echo -e >&2 "\n Le repertoire du bundle existe mais je ne peux pas cd dedans.\n"; exit 1;
			else echo -e >&2 "\n Bundle directory exists but I can't cd there.\n"; exit 1;
		fi; }
        else if [ $lang == "fr" ];
		then echo -e "\n Veuillez rentrer dans le repertoire avant de lancer le script.\n"; exit 1;
		else echo -e "\n Please cd into the bundle before running this script.\n"; exit 1;
	     fi;
        fi;
fi;

# We check that all necessary files are present
for i in couleurs.sh 1_trad_msg.sh ;
do
        if ! [ -a "etc/$i" ];
        then if [ $lang == "fr" ];
		then echo -e "\n $i n'est pas present dans le sous dossier etc";
	        echo -e "\nOn arrete avant d'aller plus loin\n";
        	read -e -p "Presser ENTREE pour arreter ce script...  ";
		else
		echo -e "\n $i not found in subfolder etc ";
	        echo -e "\nAborting before doing anything\n";
        	read -e -p "Hit ENTER to end this script...  ";
		fi;
        exit;
        fi;
done;


source etc/couleurs.sh
source etc/1_trad_msg.sh;

# Make sure only root can run our script
if [[ $EUID -ne 0 ]];
        then   echo -e "\n$failed $(msgNoRoot) \n";
        read -e -p "$(msgHitEnterEnd)";
        exit;
fi;


# Installation of Yunohost
echo -e "\n$script $(msg100) \n";

# Update of hostname
hostname=`cat /etc/hostname`;
# msg101 : Current hostname
echo -e "\n$info $(msg101) : $hostname \n";

# msg102 : Do you want to change the hostname of this server ?
read -e -p "$(msg102) (yn) : " -i "y" change_hostname;
if [ $change_hostname == 'y' ];
        then # msg103 : Indicate the new hostname
		echo -e "\n" ; read -e -p "$(msg103) : " new_hostname;
        if [ ! -z $new_hostname ];
                then echo $new_hostname > /etc/hostname
                # msg104 : hostname updated to
		echo -e "\n$ok $(msg104) $new_hostname \n";
                else # msg105 The hostname seems empty, we don't change it !
		echo -e "\n$failed $(msg105)";
		# msg101 : current hostname
                echo -e "\n$info $(msg101) : $hostname \n";
                read -e -p "$(msgHitEnterNext) ";
        fi;
        else # msg106 : Ok, we don't change the hostname
	echo -e "\n$info $(msg106) \n";
fi;

# Update of sources.list
sources=conf_base/sources.list
if [ -a "$sources" ];
	# msg107 : Do you want to use OVH Debian mirrors ?
	then echo -e "\n" ; read -e -p "$(msg107) (yn) : " -i "y" ovh;
	if [ $ovh == 'y' ]
		# msg108 : Copy apt sources.list to use ovh servers\
        	then echo -e "\n$ok $(msg108) \n";
		cp ./$sources /etc/apt/;
	        else # msg109 : Ok, we don't change apt/sources.list
		echo -e "\n$info $(msg109) \n";
	fi;
fi;

# Update of timezone
timezone=$(cat /etc/timezone)
# msg100 : Current timezone
echo -e "\n$info $(msg110) : $timezone \n"
# msg111 : Do you want to change your timezone ?
read -e -p "$(msg111) (yn) : " -i "y" change_timezone
if [ $change_timezone == 'y' ]
        then dpkg-reconfigure tzdata
	# msg112 : timezone updated
	echo -e "\n$ok $(msg112) \n";
        else # msg113 : Ok, we don't change the timezone
	echo -e "\n$info $(msg113) \n";
fi;

# Update of locales
# msg114 : Do you want to change your locale ?
echo -e "\n" ; read -e -p "$(msg114) (yn) : " -i "y" locales
if [ $locales == 'y' ]
        then dpkg-reconfigure locales
	# msg115 : locales updated
	echo -e "\n$ok $(msg115) \n";
        else # msg116 : Ok, we don't change the locale
	echo -e "\n$info $(msg116) \n\n";
	# msg117 : Hit ENTER to pursue to apt-get update and YnH Installation...
        read -e -p "$(msg117)";
fi;


# Update of packages list and installation of git
# msg118 : Update of packages list
echo -e "\n$info $(msg118) \n";
apt-get update -qq > /dev/null 2>&1;
apt-get dist-upgrade -qq > /dev/null 2>&1;
apt-get install git -y > /dev/null 2>&1;

# Installation of Yunohost from git
# msg119 : Installation of Yunohost v2 from git sources
echo -e "\n$script $(msg119) \n"

git clone https://github.com/YunoHost/install_script /tmp/install;
/tmp/install/install_yunohostv2;


