#!/bin/bash
#
# This script aims to :
#	activate dhparam for nginx
#	install the ssl certificate in the correct folder subfolder such as conf_ssl/$domain/
#
#	This script can be rerunned to adjust the ssl configuration for other domains created by yunohost
#
# polytan02@mcgva.org
# 14/04/2015
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
echo -e "\n" ; read -e -p "Do you want to adjust ssl parameters for nginx and yunohost ? (yn) : " -i "y" ssl;
if ! [ $ssl == 'y' ]; then exit; fi;

# We grab the domain name on which the file needs to be installed
echo -e "\n" ; read -e -p "Indicate the domain name to work on : " -i "$current_host" domain;
if [ -z $domain ] ;
	then domain=$current_host;
        if [ -z $domain ];
        	then echo -e "\n$failed You must specifiy a domain name";
                echo -e "\nAborting before doing anything\n";
                exit;
       	fi;
fi;

# We validate that the domain name indicated has been created by yunohost and exists
destination_exists=$work/$domain
if [ ! -d "$destination_exists" ];
	then echo -e "\n$failed the domain name is not recognised in the yunohost system"
        echo -e "\nAborting before doing anything\n";
	read -p "Hit ENTER to end this script...  ";
        exit;
	else echo -e "\n$ok Domain name : $domain";
fi

# Activate dhparam for nginx
echo -e "\n\n$info Activation of DHPARAM";
echo -e "$info Depending on your server's CPU, this can take some time !\n";
read -e -p "Do you want to activate dhparam for nginx ? (yn) : " -i "y" nginx;
if [ $nginx == 'y' ];
        then echo -e "\n" ; read -e -p "Indicate dhparam value (2048 or 4096) : " -i "2048" param;
		# Test if it is integer : if [[ $param =~ ^[-+]?[0-9]+$ ]];
		if [ $param == '2048' -o $param == '4096' ];
			then dhdom=dh$param.$domain.pem;
			openssl dhparam -out /etc/ssl/private/$dhdom -outform PEM -2 $param;
		        echo -e "\n$ok $dhdom generated";
			# Adjustment of ngingx.conf for domain
			dom_nginx=/etc/nginx/conf.d/$domain.conf;
			sed -i "s|^.*\bssl_dhparam\b.*$|    ssl_dhparam /etc/ssl/private/$dhdom;|" $dom_nginx;
			echo -e "\n$ok NGINX configured to use $dhdom";
			else
			echo -e "\n$failed Value must be 2048 or 4096 \n";
			echo -e "\nAborting before doing anything\n";
		fi;
	else echo -e "\n$info Aborting before doing anything\n";
fi;

echo -e "\n\n$info Installation of SSL key signed crt";
echo -e "\n$info Don't forget to place key.pem and crt.pem in subfolder conf_ssl/$domain/ \n";
read -e -p "Should we pursue ? (yn) : " -i "y" ssl;
if ! [ $ssl == 'y' ]; then exit; fi;

# We check that all necessary files are present
for i in key.pem crt.pem ;
	do if ! [ -a "./$files/$domain/$i" ];
		then echo -e "$failed $i not found in folder $files/$domain/ ";
		echo -e "\nAborting before doing anything\n";
		read -p "Hit ENTER to end this script...  ";
		exit;
	fi;
done;
echo -e "$ok key.pem and crt.pem are present in $files/$domain/";

# Creation of sslcert group if it doesn't exists
echo -e "$ok Creating group sslcert"
getent group sslcert  || groupadd sslcert
for g in amavis dovecot mail metronome mysql openldap postfix postgrey root vmail www-data
do
	usermod -G sslcert $g
	echo -e "Added to sslcert group : $g"
done

# Local backup of yunohost self generated ssl certificates
echo -e "$ok Backup of folder $work in current location in folder backup_ssl_certs"
mkdir -p backup_ssl_certs
cp -a $work/* ./backup_ssl_certs/

# Backup of self generated files as per Yunohost documentation
echo -e "$ok Backup of files as per Yunohost documentation in $work/$domain/$self ";
mkdir -p $work/$domain/$self
mv $work/$domain/*.{pem,cnf} $work/$domain/$self/ || true;
# We keep ca.pem in the folder
cp -a $work/yunohost.org/ca.pem $work/$domain/

# Copy of private key and crt
echo -e "$ok Copy of ssl key and crt in folder $work/$domain/ "
cp ./$files/$domain/{key,crt}.pem $work/$domain/


# Idem with yunohost.org subfolder
echo -e "$ok Backup of files as per Yunohost documentation in $work/yunohost.org/$self ";
mkdir -p $work/yunohost.org/$self
mv $work/yunohost.org/{key,crt}.pem $work/yunohost.org/$self/ || true;
echo -e "$ok Copy of ssl key and crt in folder $work/yunohost.org/ "
cp ./$files/$domain/{key,crt}.pem $work/yunohost.org/



# Adjustement of rights
echo -e "$ok Adjustment of access right for key.pem and crt.pem files"
chown www-data:sslcert $work/$domain/*.pem
chmod 640 $work/$domain/*.pem
chown www-data:sslcert $work/yunohost.org/*.pem
chmod 640 $work/yunohost.org/*.pem


echo -e "\n--- Restarting services\n"
service nginx restart
service php5-fpm restart

echo -e "\n$info Hopefully, all done Well ! :) \n"

