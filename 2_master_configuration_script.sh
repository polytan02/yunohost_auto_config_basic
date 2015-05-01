#!/bin/bash
#
# This script aims to run in one go scripts 4, 5 and 6
#
#
# polytan02@mcgva.org
# 14/04/2015
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
        read -e -p "Hit ENTER to end this script...  ";
        exit;
fi;

# We check that all necessary files are present
for i in 3_conf_base.sh 4_adjust_ssl_conf.sh 5_opendkim.sh 6_apticron_email_reports.sh 7_jail2ban_email_reports.sh 8_cleaning.sh ;
do
        if ! [ -a "$i" ];
	then echo -e "\n$failed $i not found in current folder";
        echo -e "\nAborting before doing anything\n";
	read -e -p "Hit ENTER to end this script...  ";
	exit;
	else chmod +x $i;
        fi;
done;

# We run script 3_conf_base.sh
echo -e "\n$script 3_BASE SYSTEM CONFIGURATION\n";
read -e -p "Do you want to pursue with this part of the script ? (yn) : " -i "y" s3;
if [ $s3 == 'y' ];
	then ./3_conf_base.sh;
	else echo -e "\nSkipping base system configuration\n";
	read -e -p "Hit ENTER to end this script...  ";
fi;

# We run script 4_install_certssl.sh
echo -e "\n$script 4_CONFIGURATION OF NGINX and YUNOHOST SSL\n";
read -e -p "Do you want to pursue with this part of the script ? (yn) : " -i "y" s4;
if [ $s4 == 'y' ];
	then ./4_adjust_ssl_conf.sh;
	else echo -e "\nSkipping SSL configuration\n";
	read -e -p "Hit ENTER to end this script...  ";
fi;

# We run script 5_opendkim.sh
echo -e "\n$script 5_CONFIGURATION OF OpenDKIM\n";
read -e -p "Do you want to pursue with this part of the script ? (yn) : " -i "y" s5;
if [ $s5 == 'y' ];
	then ./5_opendkim.sh;
	else echo -e "\nSkipping OpendDKIM configuration\n";
	read -e -p "Hit ENTER to end this script...  ";
fi;

# We run script 6_apticron_email_reports.sh
echo -e "\n$script 6_INSTALLATION and CONFIGURATION OF APTICRON\n";
read -e -p "Do you want to pursue with this part of the script ? (yn) : " -i "y" s6;
if [ $s6 == 'y' ];
	then ./6_apticron_email_reports.sh;
	else echo -e "\nSkipping Apticron and Jail2ban configuration\n";
	read -e -p "Hit ENTER to end this script...  ";
fi;

# We run script 7_jail2ban_email_reports.sh
echo -e "\n$script 7_CONFIGURATION OF FAIL2BAN\n";
read -e -p "Do you want to pursue with this part of the script ? (yn) : " -i "y" s7;
if [ $s7 == 'y' ];
	then ./7_jail2ban_email_reports.sh;
	else echo -e "\nSkipping Apticron and Jail2ban configuration\n";
	read -e -p "Hit ENTER to end this script...  ";
fi;

# We run script 8_cleaning.sh
echo -e "\n$script 8_APT-GET CLEANING\n";
read -e -p "Do you want to pursue with this part of the script ? (yn) : " -i "y" s8;
if [ $s8 == 'y' ];
	then ./8_cleaning.sh;
	else echo -e "\nSkipping Apticron and Jail2ban configuration\n";
	read -e -p "Hit ENTER to end this script...  ";
fi;

echo -e "\n$script END OF YUNOHOST CONFIGURATION SCRIPT\n";
echo -e "\n$info Thank you for using this !\n";
