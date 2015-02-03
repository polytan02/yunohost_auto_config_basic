#!/bin/bash
#
# This script aims to run in one go scripts 4, 5 and 6
#
#
# polytan02@mcgva.org
# 03/02/2015
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
        then   echo -e "\n$failed This script must be run as root\n";
        exit;
fi

# We check that all necessary files are present
for i in 4_install_certssl.sh 5_opendkim.sh 6_apticron_jail2ban_email_reports.sh
do
        if ! [ -a "$i" ]
        then echo -e "\n$failed $i not found in folder $files ";
        echo -e "\nAborting before doing anything";
        exit;
	else chmod +x $i;
        fi
done

# We run script 4_install_certssl.sh
echo -e "\n$info CONFIGURATION OF SSL\n"
./4_install_certssl.sh

# We run script 5_opendkim.sh
echo -e "\n$info CONFIGURATION OF OpenDKIM\n"
./5_opendkim.sh

# We run script 6_apticron_jail2ban_email_reports.sh
echo -e "\n$info CONFIGURATION OF APTICRON and FAIL2BAN\n"
./6_apticron_jail2ban_email_reports.sh


