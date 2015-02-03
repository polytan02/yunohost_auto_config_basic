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
        read -p "Hit ENTER to end this script...  \n"
  	exit;
fi

# We check that the email_apti_s argument is given for apticron
current_host=`cat /etc/yunohost/current_host`
email_default=admin@$current_host
if [ -z $1 ] ;
        then echo -e "\n"; read -e -p "apticron sender's email address : " -i "$email_default" email_apti_s;
        if [ -z $email_apti_s ] ;
                then email_apti_s=$email_default;
                if [ -z $email_apti_s ] ;
                        then echo -e "\n$failed You must specifiy a sender's email address for apticron as first argument or when requested";
                        echo -e "\nAborting before doing anything\n"
		        read -p "Hit ENTER to end this script...  "
                        exit;
                fi;
        fi;
        else email_apti_s=$1;
fi;

# We check that the email_apti_r argument is given for apticron
if [ -z $2 ] ;
        then echo -e "\n"; read -e -p "apticron reports receiving email address : " -i "$email_apti_s" email_apti_r;
	if [ -z $email_apti_r ] ;
		then email_apti_r=$email_apti_s;
		if [ -z $email_apti_r ] ;
			then echo -e "\n$failed You must specifiy a receiver's email address for apticron as second argument or when requested";
        		echo -e "\nAborting before doing anything\n"
		        read -p "Hit ENTER to end this script...  "
        		exit;
		fi;
	fi;
       	else email_apti_r=$2;
fi;

# We check that the email_fail2ban argument is given for fail2ban
if [ -z $3 ] ;
        then echo -e "\n"; read -e -p "fail2ban destination email address : " -i "$email_apti_s" email_fail2ban;
	if [ -z $email_fail2ban ] ;
		then email_fail2ban=$email_apti_s;
		if [ -z $email_fail2ban ] ;
			then echo -e "\n$failed You must specifiy a jail2ban email address as third argument or when requested\n";
        		echo -e "\nAborting before doing anything"
		        read -p "Hit ENTER to end this script...  "
        		exit;
		fi;
	fi;
       	else email_jail2ban=$3;
fi;

apti=/etc/apticron/apticron.conf
cron=/etc/cron.d/apticron
jail=/etc/fail2ban/jail.conf

# We start by installing the right software
echo -e "$ok Installation of apticron software"
apt-get update
apt-get install apticron

echo -e "$ok apticron Sender's email : $email_apti_s"
echo -e "$ok apticron Receiver's email : $email_apti_r"
echo -e "$ok fail2ban Receiver's email : $email_fail2ban"



# Then we configure apticron
echo -e "$ok Configuring apticron to send emails from $email_apti_s "
sed -i "s/EMAIL=\"root\"/EMAIL=\"$email_apti_s\"/g" $apti
sed -i "s/# NOTIFY_NO_UPDATES=\"0\"/NOTIFY_NO_UPDATES=\"1\"/g" $apti
echo -e "$ok Configuring apticron to receive emails to $email_apti_r "
sed -i "s/# CUSTOM_FROM=\"\"/CUSTOM_FROM=\"$email_apti_r\"/g" $apti

# We adjust the cron
echo -e "$ok Adjustment of $cron"
sed -i "s/\* \* \* \*/4 \* \* \*/g" $cron

# We edit jail.conf
echo -e "$ok Configuring fail2ban to send emails to $email_fail2ban"
sed -i "s/destemail = root@localhost/destemail = $email_fail2ban/g" $jail
sed -i "s/action = %(action_)s/action = %(action_mwl)s/g" $jail

echo -e "\n--- Restarting service fail2ban\n"
service fail2ban restart

echo -e "\n$info Hopefully, all done Well ! :) \n"
