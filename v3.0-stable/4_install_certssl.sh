#!/bin/bash
#
# This script aims to install the ssl certificate in the correct folder
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
        read -p "Hit ENTER to end this script...  "
        exit;
fi

work=/etc/yunohost/certs
self=self_generated
files=conf_ssl
current_host=`cat /etc/yunohost/current_host`


# Installation of ssl certificates
read -e -p "Do you want to use your own ssl certificate instead of a self generated one ? (yn) : " -i "y" ssl;
if ! [ $ssl == 'y' ]; then exit; fi;

echo -e "\n$info Don't forget to place key.pem and crt.pem in subfolder conf_ssl\n";
read -e -p "Should we pursue ? (yn) : " -i "y" ssl;
if ! [ $ssl == 'y' ]; then exit; fi;

# We check that all necessary files are present
for i in key.pem crt.pem ;
	do if ! [ -a "./$files/$i" ];
		then echo -e "$failed $i not found in folder $files ";
		echo -e "\nAborting before doing anything\n";
		read -p "Hit ENTER to end this script...  ";
		exit;
	fi;
done;
echo -e "$ok key.pem and crt.pem are present";

echo -e "\n" ; read -e -p "Indicate the domain name of the ssl certificates to install : " -i "$current_host" domain;
if [ -z $domain ] ;
	then domain=$current_host;
        if [ -z $domain ];
        	then echo -e "\n$failed You must specifiy a domain name";
                echo -e "\nAborting before doing anything\n";
		read -p "Hit ENTER to end this script...  ";
                exit;
       	fi;
fi;

echo -e "$ok Domain name : $domain";

# Creation of sslcert group
echo -e "$ok Creating group sslcert"
addgroup sslcert
for g in amavis dovecot mail metronome mysql openldap postfix postgrey root vmail www-data
do
	usermod -G sslcert $g
	echo -e "Added to sslcert group : $g"
done

# Backup of yunohost self generated ssl certificates
echo -e "$ok Backup of folder $work"
mkdir backup_certs_$domain
cp -a $work/* ./backup_certs_$domain/

# local backup of slef generated files as per Yunohost documentation
mkdir $work/$domain/$self
mv $work/$domain/{*.pem,*.cnf} $work/$domain/$self/

# Copy of private key and crt
echo -e "$ok Copy of ssl key and crt in folder $work/$domain/ "
cp ./$files/*.pem $work/$domain/

echo -e "$ok Adjustment of access right for key.pem and crt.pem files"
chown www-data:sslcert $work/$domain/*.pem
chmod 640 $work/$domain/*.pem
chown www-data:sslcert $work/yunohost.org/*.pem
chmod 640 $work/yunohost.org/*.pem

echo -e "\n--- Restarting services\n"
service nginx restart
service php5-fpm restart

echo -e "\n$info Hopefully, all done Well ! :) \n"

