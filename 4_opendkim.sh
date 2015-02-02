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

# We check that the user argument is given
if [ -z $1 ] ;
	then echo -e "\n$failed You must specifiy a domain name from which you send emails on this server as first argument";
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
        then echo -e "\n$failed $i not found in folder $files "
        echo -e "\nAborting before doing anything"
	exit
        fi
done

echo -e "$ok Domain name specified : $domain"

# We start by installing the right software
echo -e "$ok Installation of OpenDKIM software"
apt-get update
apt-get install opendkim opendkim-tools

# Then we configure opendkim
echo -e "$ok Copy of opendkim.conf in /etc/ "
cp -v ./$files/opendkim.conf /etc/

# Connect the milter to Postfix :
echo -e "$ok Update of /etc/default/opendkim "
cat ./$files/etc_default_opendkim >> /etc/default/opendkim

# Configure postfix to use this milter :
echo -e "$ok Update of /etc/postfix/main.cf "
cat ./$files/etc_postfix_main.cf >> /etc/postfix/main.cf

# Create a directory structure that will hold the trusted hosts, key tables, signing tables and crypto keys :
echo -e "$ok Creation of directory structure for opendkim "
mkdir -pv $dest/keys/$domain

# Specify trusted hosts
echo -e "$ok Update of TrustedHosts  "
cp -v ./$files/TrustedHosts $dest/TrustedHosts
echo "*.$domain" >> $dest/TrustedHosts

# Create a key table
echo -e "$ok Update of KeyTable "
echo "mail._domainkey.$domain $domain:mail:$dest/keys/$domain/mail.private" >> $dest/KeyTable

# Create a signing table
echo -e "$ok Update of Signing Table "
echo "*@$domain mail._domainkey.$domain" >> $dest/SigningTable


# Now we generate the keys !
echo -e "$ok Generation of OpenDKIM keys "
opendkim-genkey -D $dest/keys/$domain -s mail -d $domain


# Right parameters to the files created
echo -e "$ok Adjustment of rights "
chown -Rv opendkim:opendkim $dest*

# Restart services
echo -e "\n--- Restarting services \n"
service opendkim restart
service postfix reload
yunohost app ssowatconf

echo -e "\n$info Hopefully, all done Well ! :) "

echo -e "\n$info Here is the DKIM key to add in your server :\n"

cat $dest/keys/$domain/mail.txt

echo -e "\n$info You can also add a SPF key in your DNS zone :\n"

echo -e "$domain 300 TXT \"v=spf1 a:$domain mx ?all\""

echo -e "\n$info Please remember that DNS propagation can take up to 24h...\n"
