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
for i in couleurs.sh 8_trad_msg.sh ;
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
source etc/8_trad_msg.sh;

# Make sure only root can run our script
if [[ $EUID -ne 0 ]];
        then   echo -e "\n$failed $(msgNoRoot) \n";
        read -e -p "$(msgHitEnterEnd)";
        exit;
fi;

# msg801 : Cleaning with apt-get autoremove and autoclean
echo -e "\n$info $(msg801) \n";
# msg802 : Should we make some cleaning ?
read -e -p "$(msg802) (yn) : " -i "y" clean;
if [ $clean == 'y' ];
	then # msg803 : Ok, here we clean
	echo -e "\n$info $(msg803) \n";
	apt-get autoremove -qq;
	# msg804 : apt-get autoremove : Done
	echo -e "\n$ok $(msg804)";
	apt-get autoclean -qq;
	# msg805 : apt-get autoclean : Done
	echo -e "\n$ok $(msg805)";
	else # msg806 : Ok, we don't clean today...
	echo -e "\n$info $(msg806) ";
	exit;
fi;

echo -e "\n$info $(msgAllDone) \n";
