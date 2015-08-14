#!/bin/bash
#
# This script aims to configure fail2ban so that emails would be sent
#
#
# polytan02@mcgva.org
# 02/02/2015
#

# We setup $lang if parameter not given at startup
if [ -z $1 ];
	then echo -e "\nVeuillez choisir la langue (en/fr) :";
	read -e -p "Please choose the language (en/fr) : " -i "fr" lang;
	if [ $lang != "en" ];
        	then if [ $lang != "fr" ];
                	then echo -e "\nLanguage not recognised, reverting to English";
	                lang="en"
        	fi;
	fi;
        else lang="$1";
fi;

# We check that all necessary files are present
for i in couleurs.sh 9_trad_msg.sh ;
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
source etc/9_trad_msg.sh;

# Make sure only root can run our script
if [[ $EUID -ne 0 ]];
        then   echo -e "\n$failed $(msgNoRoot) \n";
        read -e -p "$(msgHitEnterEnd)";
        exit;
fi;

# msg901 : Cleaning with apt-get autoremove and autoclean
echo -e "\n$info $(msg901) \n";
# msg902 : Should we make some cleaning ?
read -e -p "$(msg902) (yn) : " -i "y" clean;
if [ $clean == 'y' ];
	then # msg903 : Ok, here we clean
	echo -e "\n$info $(msg903) \n";
	apt-get autoremove -qq;
	# msg904 : apt-get autoremove : Done
	echo -e "\n$ok $(msg904)";
	apt-get autoclean -qq;
	# msg905 : apt-get autoclean : Done
	echo -e "\n$ok $(msg905)";
	else # msg906 : Ok, we don't clean today...
	echo -e "\n$info $(msg906) ";
	exit;
fi;

echo -e "\n$info $(msgAllDone) \n";
