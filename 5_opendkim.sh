#!/bin/bash
#
# This script aims to configure opendkim automatically
# It can be rerunned independantly to configure opendkim for other domains created via yunohost
#
# If you want to reuse existing keys, the files mail.txt and mail.private needs to
# be placed in a correct subfolder such as conf_opendkim/$domain/
#
# polytan02@mcgva.org
# 12/02/2015
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
warning=[${txtred}WARNING${txtrst}]


# Make sure only root can run our script
if [[ $EUID -ne 0 ]];
	then   echo -e "\n$failed This script must be run as root\n";
        read -p "Hit ENTER to end this script...  "
  	exit;
fi;

echo -e "\n$info OpenDKIM is a software which authenticate the emails you send.";
echo -e "$info This is to avoid your emails to be considered as SPAM.";
echo -e "$info Don't forget that it requires a line to be added in your DNS Zone.\n";

read -e -p "Do you want to install opendkim ? (yn) : " -i "y" dkim;
if ! [ $dkim == 'y' ];
	then echo -e "\n$info Ok, we skip this part\n";
        read -p "Hit ENTER to end this script...  ";
	exit;
fi;


# We check the name of the server sending emails
current_host=`cat /etc/yunohost/current_host`
echo -e "\n"; read -e -p "Indicate the domain name sending emails on this server : " -i "$current_host" domain;
if [ -z $domain ] ;
	then echo -e "\n$failed You must indicate a domain name for OpenDKIM to be configured\n";
        read -p "Hit ENTER to end this script...  ";
	exit;
fi;

files=conf_opendkim;
dest=/etc/opendkim;

# We check that all necessary files are present
for i in TrustedHosts etc_default_opendkim etc_postfix_main.cf opendkim.conf;
do
	if ! [ -a "./$files/$i" ];
        then echo -e "\n$failed $i not found in folder $files ";
        echo -e "\nAborting before doing anything wrong\n";
        read -p "Hit ENTER to end this script...  ";
	exit;
        fi;
done;

echo -e "\n$ok Domain name specified : $domain"

# We start by installing the right software
echo -e "$ok Installation of OpenDKIM software"
apt-get update
apt-get install opendkim opendkim-tools

# Then we configure opendkim
echo -e "$ok Copy of opendkim.conf in /etc/ "
cp -v ./$files/opendkim.conf /etc/

# Connect the milter to Postfix :
echo -e "$ok Update of /etc/default/opendkim "
# Cleaning before addition of data
sed -i '/SOCKET=\"inet:8891@localhost\"/d' /etc/default/opendkim
# Addition of milter
cat ./$files/etc_default_opendkim >> /etc/default/opendkim

# Configure postfix to use this milter :
echo -e "$ok Update of /etc/postfix/main.cf "
# Removal of the milter in postfix main.cf (unknown at this stage)
sed -i '/# Opendkim milter configuration/d' /etc/postfix/main.cf
sed -i '/milter_protocol = 2/d' /etc/postfix/main.cf
sed -i '/milter_default_action = accept/d' /etc/postfix/main.cf
sed -i '/smtpd_milters = inet:127.0.0.1:8891/d' /etc/postfix/main.cf
sed -i '/non_smtpd_milters = inet:127.0.0.1:8891/d' /etc/postfix/main.cf
# Addition of milter after cleaning
cat ./$files/etc_postfix_main.cf >> /etc/postfix/main.cf

# Create a directory structure that will hold the trusted hosts, key tables, signing tables and crypto keys :
echo -e "$ok Creation of directory structure for opendkim "
mkdir -pv $dest/keys/$domain

# Specify trusted hosts
echo -e "$ok Update of TrustedHosts  "

if [ -z $dest/TrustedHosts ];
	then cp -v ./$files/TrustedHosts >> $dest/TrustedHosts;
	echo "*.$domain" >> $dest/TrustedHosts;
	else echo "*.$domain" >> $dest/TrustedHosts;
fi;

# Create a key table
echo -e "$ok Update of KeyTable "
echo "mail._domainkey.$domain $domain:mail:$dest/keys/$domain/mail.private" >> $dest/KeyTable

# Create a signing table
echo -e "$ok Update of Signing Table "
echo "*@$domain mail._domainkey.$domain" >> $dest/SigningTable


# Now we generate the keys ! If keys are existing, they will be used
echo -e "\n$info OpenDKIM keys\n";
key=0;
for i in mail.txt mail.private;
do
	if [ -a "./$files/$domain/$i" ];
        then key=$((key+1))
	echo -e "$ok $i found in folder $files/$domain";
	else echo -e "$info $i not found in $files/$domain";
        fi;
done;

if [ $key == 2 ];
	then echo -e "\n$info OpenDKIM mail.private and mail.txt have been found in $files/$domain/ and will be used instead of generating a new key\n";
	cp $files/$domain/mail.{txt,private} $dest/keys/$domain/;
	echo -e "\n$ok mail.txt and mail.private have been copied to $dest/keys/$domain/";
	else echo -e "\n$ok Generation of OpenDKIM keys\n";
	opendkim-genkey -D $dest/keys/$domain -s mail -d $domain;
fi;


# Right parameters to the files created
echo -e "\n$ok Adjustment of rights\n"
chown -Rv opendkim:opendkim $dest*

# Restart services
echo -e "\n--- Restarting services \n"
service opendkim restart
service postfix reload

echo -e "\n$warning Here is the DKIM key to add in your server :\n"

cat $dest/keys/$domain/mail.txt
echo -e "\n$info DKIM key location : $dest/keys/$domain/mail.txt\n"

echo -e "\n$warning You can also add a SPF key in your DNS zone :\n"

echo -e "$domain 300 TXT \"v=spf1 a:$domain mx ?all\""

echo -e "\n$info Please remember that DNS propagation can take up to 24h..."
echo -e "\n$info Don't forget to update your DNS accordingly ! \n"


read -p "Hit ENTER to end this script...";
