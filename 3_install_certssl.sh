#!/bin/bash
#
# This script aims to install the ssl certificate in the correct folder
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



# We check that a domain name is given
if [ -z $1 ] ;
	then echo -e "\n$failed You must specify a domain name as first argument";
        echo -e "\nAborting before doing anything"
	exit;
fi;

domain=$1
work=/etc/yunohost/certs
self=self_generated
files=conf_ssl

echo -e "$ok Domain name : $domain "

# We check that all necessary files are present
for i in key.pem crt.pem
do
        if ! [ -a "./$files/$i" ]
        then echo -e "$failed $i not found in folder $files "
        echo -e "\nAborting before doing anything"
        exit
        fi
done
echo -e "$ok key.pem and crt.pem are present"

# Creation of sslcert group
echo -e "$ok Creating group sslcert"
addgroup sslcert &
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

# Idem with yunohost.org subfolder
mkdir $work/yunohost.org/$self
mv $work/yunohost.org/*.pem $work/yunohost.org/$self/
echo -e "$ok Copy of ssl key and crt in folder $work/yunohost.org/ "
cp ./$files/*.pem $work/yunohost.org/

echo -e "$ok Adjustment of access right for key.pem and crt.pem files"
chown www-data:sslcert $work/$domain/*.pem
chmod 640 $work/$domain/*.pem
chown www-data:sslcert $work/yunohost.org/*.pem
chmod 640 $work/yunohost.org/*.pem

echo -e "\n--- Restarting services\n"
service nginx restart
service php5-fpm restart

echo -e "\n$info Hopefully, all done Well ! :) \n"

