#!/bin/bash
#
# This script aims to configure apticron and fail2ban automatically so that emails would be sent
#
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
	then   echo -e "\n$failed This script must be run as root\n";
  	exit;
fi

# We check that the email_apti_s argument is given for apticron
if [ -z $1 ] ;
        then echo -e "\n" ; read -e -p "apticron sender's email address : " email_apti_s;
        else email_apti_s=$1;
fi; if [ -z $email_apti_s ] ;
	then echo -e "\n$failed You must specifiy a sende's email address for apticron as first argument";
        echo -e "\nAborting before doing anything"
        exit;
fi;


# We check that the email_apti_r argument is given for apticron
if [ -z $2 ] ;
        then echo -e "\n" ; read -e -p "apticron reports receiving email address : " email_apti_r;
        else email_apti_r=$2;
fi; if [ -z $email_apti_r ] ;
	then echo -e "\n$failed You must specifiy a receving email address for apticron reports as second argument";
        echo -e "\nAborting before doing anything"
        exit;
fi;

# We check that the email_fail2ban argument is given for fail2ban
if [ -z $3 ] ;
        then echo -e "\n" ; read -e -p "fail2ban destination email : " email_fail2ban;
        else email_apti_r=$3;
fi; if [ -z $email_fail2ban ] ;
	then echo -e "\n$failed You must specifiy a receving email address for fail2ban reports as third argument";
        echo -e "\nAborting before doing anything"
        exit;
fi;

apti=/etc/apticron/apticron.conf
cron=/etc/cron.d/apticron
jail=/etc/fail2ban/jail.conf

echo -e "$ok apticron Sender's email : $email_apti_s"
echo -e "$ok apticron Receiver's email : $email_apti_r"
echo -e "$ok fail2ban Receiver's email : $email_fail2ban"

# We start by installing the right software
echo -e "$ok Installation of apticron software"
apt-get update
apt-get install apticron

# Then we configure apticron
echo -e "$ok Configuring apticron to send emails to $email_apti_r "
sed -i "s/EMAIL=\"root\"/EMAIL=\"$email_apti_s\"/g" $apti
sed -i "s/# NOTIFY_NO_UPDATES=\"0\"/NOTIFY_NO_UPDATES=\"1\"/g" $apti
sed -i "s/# CUSTOM_FROM=\"\"/CUSTOM_FROM=\"$email_apti_r\"/g" $apti

# We adjust the cron
echo -e "$ok Adjustment of $cron"
sed -i "s/8 \*/8 4/g" $cron

# We edit jail.conf
echo -e "$ok Configuring fail2ban to send emails to $email_fail2ban"
sed -i "s/destemail = root@localhost/destemail = $email_fail2ban/g" $jail
sed -i "s/action = %(action_)s/action = %(action_mwl)s/g" $jail

echo -e "\n--- Restarting service fail2ban\n"
service fail2ban restart

echo -e "\n$info Hopefully, all done Well ! :) \n"
