#!/bin/bash
#
# This script aims to run in one go scripts 4, 5 and 6
#
#
# polytan02@mcgva.org
# 14/08/2015
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
if [[ ! -e 2_master_configuration_script.sh ]];
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
for i in couleurs.sh 2_trad_msg.sh ;
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
source etc/2_trad_msg.sh;

# Make sure only root can run our script
if [[ $EUID -ne 0 ]];
        then   echo -e "\n$failed $(msgNoRoot) \n";
        read -e -p "$(msgHitEnterEnd)";
        exit;
fi;

# We check that all necessary files are present
# msg201 : $i not found in folder $files
for i in 3_conf_base.sh 4_adjust_ssl_conf.sh 5_opendkim.sh 6_apticron_email_reports.sh 7_jail2ban_email_reports.sh 8_great_colours_bash_gnuscreen_tmux.sh 9_cleaning.sh ;
do
        if ! [ -a "$i" ];
	then echo -e "\n$failed $(msg201 $i)";
        echo -e "\n$failed $(msgAbort) \n";
	read -e -p "$(msgHitEnterEnd)";
	exit;
	else chmod +x $i;
        fi;
done;

# We run script 3_conf_base.sh
# msg202 : 3_BASE SYSTEM CONFIGURATION
echo -e "\n$script $(msg202) \n";
# msgGoNext : Do you want to pursue with this part of the script ? (yn) :
read -e -p "$(msgGoNext)" -i "y" s3;
if [ $s3 == 'y' ];
	then ./3_conf_base.sh $lang;
	else # msg203 : Skipping base system configuration
	echo -e "\n$(msg203) \n";
	read -e -p "$(msgHitEnterEnd) ";
fi;

# We run script 4_install_certssl.sh
# msg204 : 4_CONFIGURATION OF NGINX and YUNOHOST SSL
echo -e "\n$script $(msg204) \n";
read -e -p "$(msgGoNext)" -i "y" s4;
if [ $s4 == 'y' ];
	then ./4_adjust_ssl_conf.sh $lang;
	else # msg205 : Skipping SSL configuration
	echo -e "\n$(msg205) \n";
	read -e -p "$(msgHitEnterEnd)";
fi;

# We run script 5_opendkim.sh
# msg206 : 5_CONFIGURATION OF OpenDKIM
echo -e "\n$script $(msg206) \n";
read -e -p "$(msgGoNext)" -i "y" s5;
if [ $s5 == 'y' ];
	then ./5_opendkim.sh $lang;
	else # msg207 : Skipping OpendDKIM configuration
	echo -e "\n$(msg207) \n";
	read -e -p "$(msgHitEnterEnd)";
fi;

# We run script 6_apticron_email_reports.sh
# msg208 : 6_INSTALLATION and CONFIGURATION OF APTICRON
echo -e "\n$script $(msg208) \n";
read -e -p "$(msgGoNext)" -i "y" s6;
if [ $s6 == 'y' ];
	then ./6_apticron_email_reports.sh $lang;
	else # msg209 : Skipping Apticron configuration
	echo -e "\n$(msg209) \n";
	read -e -p "$(msgHitEnterEnd)";
fi;

# We run script 7_jail2ban_email_reports.sh
# msg210 : 7_CONFIGURATION OF FAIL2BAN
echo -e "\n$script $(msg210) \n";
read -e -p "$(msgGoNext)" -i "y" s7;
if [ $s7 == 'y' ];
	then ./7_jail2ban_email_reports.sh $lang;
	else # msg211 : Skipping Jail2Ban configuration
	echo -e "\n$(msg211) \n";
	read -e -p "$(msgHitEnterEnd)";
fi;

# We run script 8_great_colours_bash_gnu-screen_tmux.sh
# msg212 : 8_GREAT COLOURS in BASH SCREEN TMUX
echo -e "\n$script $(msg212) \n";
read -e -p "$(msgGoNext)" -i "y" s8;
if [ $s8 == 'y' ];
	then ./8_great_colours_bash_gnuscreen_tmux.sh $lang;
	else # msg213 : Ok, no GREAT colours in shell
	echo -e "\n$(msg213) \n";
	read -e -p "$(msgHitEnterEnd)";
fi;

# We run script 9_cleaning.sh
# msg214 : 9_APT-GET CLEANING
echo -e "\n$script $(msg214) \n";
read -e -p "$(msgGoNext)" -i "y" s9;
if [ $s9 == 'y' ];
	then ./9_cleaning.sh $lang;
	else # msg215 : Skipping apt-get cleaning
	echo -e "\n$(msg215) \n";
	read -e -p "$(msgHitEnterEnd)";
fi;

