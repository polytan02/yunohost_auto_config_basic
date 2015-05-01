#!/bin/bash
#
# This script aims to configure apticron so that emails would be sent
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
        read -p "Hit ENTER to end this script...  \n";
  	exit;
fi;


current_host=`cat /etc/yunohost/current_host`;
email_default=admin@$current_host;

# We check if apticron is to be installed
echo -e "\n$info APTicron is a simple cron job which send you a daily email to let you know of any system update\n";
read -e -p "Do you want to install apticron ? (yn) : " -i "y" inst_apti;
if ! [ $inst_apti == 'y' ];
	then echo -e "\n$info Ok, we skip this script then\n";
        read -p "Hit ENTER to end this script...  \n";
	exit;
fi;
echo -e "\n$ok Proceeding with installation and configuration ... \n";

# We defnie sender's and receiver's email address
echo -e "\n" ; read -e -p "Define apticron sender's email address : " -i "$email_default" email_apti_s;
read -e -p "Define receiving email address of apticron's reports : " -i "$email_apti_s" email_apti_r;

apti=/etc/apticron/apticron.conf;
cron=/etc/cron.d/apticron;

echo -e "\n$ok apticron Sender's email : $email_apti_s";
echo -e "$ok apticron Receiver's email : $email_apti_r\n";

# We start by installing the right software;
echo -e "$ok Installation of apticron software\n";
apt-get update -qq > /dev/null 2>&1;
apt-get install -qq -y apticron > /dev/null 2>&1;

# Then we configure apticron
echo -e "$ok Configuring apticron to send emails from $email_apti_s ";
sed -i "s/EMAIL=\"root\"/EMAIL=\"$email_apti_s\"/g" $apti;
sed -i "s/# NOTIFY_NO_UPDATES=\"0\"/NOTIFY_NO_UPDATES=\"1\"/g" $apti;
echo -e "$ok Configuring apticron to receive emails to $email_apti_r ";
sed -i "s/# CUSTOM_FROM=\"\"/CUSTOM_FROM=\"$email_apti_r\"/g" $apti;

# We adjust the cron
echo -e "$ok Adjustment of $cron";
sed -i "s/\* \* \* \*/4 \* \* \*/g" $cron;

echo -e "\n$info Hopefully, all done Well ! :) \n";
