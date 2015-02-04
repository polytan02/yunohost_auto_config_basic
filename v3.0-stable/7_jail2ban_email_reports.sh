#!/bin/bash
#
# This script aims to configure fail2ban so that emails would be sent
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
jail=/etc/fail2ban/jail.conf

# We check that jail2ban needs is to be tuned
echo -e "\n$info jail2ban can also send you emails as soon as an IP is blocked or a service is stopped/started.";
echo -e "\n$info It is installed by default in Yunohost, this only activates emails.\n";
read -e -p "Do you want to activate jail2ban emails ? (yn) : " -i "y" inst_jail;
if ! [ $inst_jail == 'y' ];
	then   echo -e "\n$info Ok, we skip this part then\n";
        read -p "Hit ENTER to end this script...  \n";
fi;
echo -e "\n$ok Proceeding with configuration then\n";

read -e -p "Define fail2ban destination email address : " -i "$email_default" email_fail2ban;

echo -e "\n$ok fail2ban Receiver's email : $email_fail2ban";

# We edit jail.conf
echo -e "\n$ok Configuring fail2ban to send emails to $email_fail2ban";
sed -i "s/destemail = root@localhost/destemail = $email_fail2ban/g" $jail;
sed -i "s/action = %(action_)s/action = %(action_mwl)s/g" $jail;

echo -e "\n--- Restarting service fail2ban\n";
service fail2ban restart

echo -e "\n$info Hopefully, all done Well ! :) \n";
