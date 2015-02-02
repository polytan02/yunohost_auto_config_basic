#!/bin/bash
#
# This script aims to configure the base system for ssh, create a user and simple bashrc with great colours
# It also specifies to use ovh mirrors
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

# We check that the email_send argument is given
if [ -z $1 ] ;
	then echo -e "\n$failed You must specifiy a sende's email address for apticron as first argument";
        echo -e "\nAborting before doing anything"
	exit;
fi;

# We check that the email_receive argument is given
if [ -z $2 ] ;
	then echo -e "\n$failed You must specifiy a receving email address for apticron reports as second argument";
        echo -e "\nAborting before doing anything"
	exit;
fi;

email_send=$1
email_receive=$2
dest=/etc/apticron/apticron.conf
cron=/etc/cron.d/apticron

echo -e "$ok Sender's email : $email_send"
echo -e "$ok Receiver's email : $email_receive"

# We start by installing the right software
echo -e "$ok Installation of apticron software"
apt-get update &
apt-get install apticron &

# Then we configure apticron
echo -e "$ok Configuration of apticron.conf "
sed -i "s/EMAIL=\"root\"/EMAIL=\"$email_send\"/g" $dest
sed -i "s/# NOTIFY_NO_UPDATES=\"0\"/NOTIFY_NO_UPDATES=\"1\"/g" $dest
sed -i "s/# CUSTOM_FROM=\"\"/CUSTOM_FROM=\"$email_receive\"/g" $dest

# We adjust the cron
echo -e "$ok Adjustment of $cron"
sed -i "s/8 \*/8 4/g" $cron

echo -e "\n You can also edit /etc/fail2ban/jail.conf to receive emails from fail2ban too"
echo -e "\n$info Hopefully, all done Well ! :) \n"
