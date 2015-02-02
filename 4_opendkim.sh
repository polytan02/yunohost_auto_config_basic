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


# Make sure only root can run our script
if [[ $EUID -ne 0 ]];
	then   echo "\n[${txtred}FAILED${txtrst}] This script must be run as root";
  	exit;
fi

# We check that the user argument is given
if [ -z $1 ] ;
	then echo -e "\n[${txtred}FAILED${txtrst}] You must specifiy a domain name from which you send emails on this server as first argument";
        echo -e "\nAborting before doing anything"
	exit;
fi;

domain=$1
files=conf_opendkim
dest=/etc/opendkim

# We check that all necessary files are present
for i in TrustedHosts etc_default_opendkim etc_postfix_main.cf opendkim.conf
do
	if ! [ -a "./$files/$i" ]
        then echo -e "\n[${txtred}FAILED${txtrst}] $i not found in folder $files "
        echo -e "\nAborting before doing anything"
	exit
        fi
done

echo -e "[${txtgrn}OK${txtrst}] Domain name specified : $domain"

# We start by installing the right software
echo -e "[${txtgrn}OK${txtrst}] Installation of OpenDKIM software"
apt-get update
apt-get install opendkim opendkim-tools

# Then we configure opendkim
echo -e "[${txtgrn}OK${txtrst}] Copy of opendkim.conf in /etc/ "
cp -v ./$files/opendkim.conf /etc/

# Connect the milter to Postfix :
echo -e "[${txtgrn}OK${txtrst}] Update of /etc/default/opendkim "
cat ./$files/etc_default_opendkim >> /etc/default/opendkim

# Configure postfix to use this milter :
echo -e "[${txtgrn}OK${txtrst}] Update of /etc/postfix/main.cf "
cat ./$files/etc_postfix_main.cf >> /etc/postfix/main.cf

# Create a directory structure that will hold the trusted hosts, key tables, signing tables and crypto keys :
echo -e "[${txtgrn}OK${txtrst}] Creation of directory structure for opendkim "
mkdir -pv $dest/keys/$domain

# Specify trusted hosts
echo -e "[${txtgrn}OK${txtrst}] Update of TrustedHosts  "
cp -v ./$files/TrustedHosts $dest/TrustedHosts
echo "*.$domain" >> $dest/TrustedHosts

# Create a key table
echo -e "[${txtgrn}OK${txtrst}] Update of KeyTable "
echo "mail._domainkey.$domain $domain:mail:$dest/keys/$domain/mail.private" >> $dest/KeyTable

# Create a signing table
echo -e "[${txtgrn}OK${txtrst}] Update of Signing Table "
echo "*@$domain mail._domainkey.$domain" >> $dest/SigningTable


# Now we generate the keys !
echo -e "[${txtgrn}OK${txtrst}] Generation of OpenDKIM keys "
opendkim-genkey -D $dest/keys/$domain -s mail -d $domain


# Right parameters to the files created
echo -e "[${txtgrn}OK${txtrst}] Adjustment of rights "
chown -Rv opendkim:opendkim $dest*

# Restart services
echo -e "[${txtgrn}OK${txtrst}] Restart of services  "
echo -e "\n"
service opendkim restart
service postfix reload
yunohost app ssowatconf
echo -e "\n"

echo -e "\n[${txtcyn}INFO${txtrst}] Hopefully, all done Well ! :) "

echo -e "\n[${txtcyn}INFO${txtrst}] Here is the DKIM key to add in your server :\n"

cat $dest/keys/$domain/mail.txt

echo -e "\n[${txtcyn}INFO${txtrst}] Please remember that DNS propagation can take up to 24h...\n"


