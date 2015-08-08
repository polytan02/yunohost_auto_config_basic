#!/bin/bash
#
# This script aims to :
#	activate dhparam for nginx
#	install the ssl certificate in the correct folder subfolder such as conf_ssl/$domain/
#
#	This script can be rerunned to adjust the ssl configuration for other domains created by yunohost
#
# polytan02@mcgva.org
# 03/05/2015
#

# We setup $lang if parameter not given at startup
if [ -z $1 ];
        then echo -e "\nVeuillez choisir la langue (en/fr) :";
        read -e -p "Please choose the language (en/fr) : " -i "fr" lang;
        if [ $lang != "en" ];
                then if [ $lang != "fr" ];
                        then echo -e "\nLanguage not recognised, reverting to English";
                        lang="en"
                fi;
        fi;
        else lang="$1";
fi;

# We check that all necessary files are present
for i in couleurs.sh 4_trad_msg.sh ;
do
        if ! [ -a "etc/$i" ];
        then if [ $lang == "fr" ];
                then echo -e "\n $i n'est pas present dans le sous dossier etc";
                echo -e "\nOn arrete avant d'aller plus loin\n";
                read -e -p "Presser ENTREE pour arreter ce script...  ";
                else
                echo -e "\n $i not found in subfolder etc ";
                echo -e "\nAborting before doing anything\n";
                read -e -p "Hit ENTER to end this script...  ";
                fi;
        exit;
        fi;
done;

source etc/couleurs.sh
source etc/4_trad_msg.sh;

# Make sure only root can run our script
if [[ $EUID -ne 0 ]];
        then   echo -e "\n$failed $(msgNoRoot) \n";
        read -e -p "$(msgHitEnterEnd)";
        exit;
fi;

work=/etc/yunohost/certs
self=yunohost_self_signed
files=conf_ssl
current_host=`cat /etc/yunohost/current_host`
currentdate=`date +%Y%m%d-%H%M-%S`

# Installation of ssl certificates
# msg401 : Do you want to adjust ssl parameters for nginx and yunohost ?
echo -e "\n" ; read -e -p "$(msg401) (yn) : " -i "y" ssl;
if ! [ $ssl == 'y' ]; then exit; fi;

# We grab the domain name on which the file needs to be installed
# msg402 : Indicate the domain name to work on
echo -e "\n" ; read -e -p "$(msg402) : " -i "$current_host" domain;
if [ -z $domain ] ;
	then domain=$current_host;
        if [ -z $domain ];
        	then # msg403 : You must specifiy a domain name
		echo -e "\n$failed $(msg403)";
                echo -e "\n$(msgAbort) \n";
                exit;
       	fi;
fi;

# We validate that the domain name indicated has been created by yunohost and exists
destination_exists=$work/$domain
if [ ! -d "$destination_exists" ];
	then # msg404 : The domain name is not recognised in the yunohost system
	echo -e "\n$failed $(msg404)"
        echo -e "\n$(msgAbort) \n";
	read -p "$(msgHitEnterEnd) ";
        exit;
	else # msg405 : Domain name
	echo -e "\n$ok $(msg405) : $domain";
fi

# Activate dhparam for nginx
# msg406 : Activation of DHPARAM
echo -e "\n\n$script $(msg406)";
# msg407 : Depending on your server's CPU, this can take some time !
echo -e "\n$info $(msg407) \n";
# msg408 : Do you want to activate dhparam for nginx ?
read -e -p "$(msg408) (yn) : " -i "y" nginx;
if [ $nginx == 'y' ];
        then # msg409 : Indicate dhparam value (2048 or 4096)
	echo -e "\n" ; read -e -p "$(msg409) : " -i "2048" param;
		# Test if it is integer : if [[ $param =~ ^[-+]?[0-9]+$ ]];
		if [ $param == '2048' -o $param == '4096' ];
			then dhdom=dh$param.$domain.pem;
			echo -e "\n" ; openssl dhparam -out /etc/ssl/private/$dhdom -outform PEM -2 $param;
		        # msg410 : $dhdom generated
			echo -e "\n$ok $(msg410)";
			# Adjustment of ngingx.conf for domain
			dom_nginx=/etc/nginx/conf.d/$domain.conf;
			sed -i "s|^.*\bssl_dhparam\b.*$|    ssl_dhparam /etc/ssl/private/$dhdom;|" $dom_nginx;
			# msg411 : NGINX configured to use $dhdom
			echo -e "\n$ok $(msg411)";
			else
			# msg412 : Value must be 2048 or 4096
			echo -e "\n$failed $(msg412) \n";
			echo -e "\n$(msgAbort) \n";
		fi;
	else echo -e "\n$info $(msgAbort)\n";
fi;

# msg413 : Installation of SSL key signed crt
echo -e "\n\n$script $(msg413)";
# msg414 : Don't forget to place key.pem and crt.pem in subfolder conf_ssl/$domain/
echo -e "\n$info $(msg414) \n";
read -e -p "$(msgGoNext)" -i "y" ssl;
if ! [ $ssl == 'y' ]; then exit; fi;

# We check that all necessary files are present
for i in key.pem crt.pem ;
	do if ! [ -a "./$files/$domain/$i" ];
		then # msg415 : $i not found in folder $files/$domain/
		echo -e "$failed $(msg415) ";
		echo -e "\n$(msgAbort) \n";
		read -p "$(msgHitEnterEnd) ";
		exit;
	fi;
done;
# msg416 : key.pem and crt.pem are present in $files/$domain/
echo -e "$ok $(msg416)";

# Creation of sslcert group if it doesn't exists
# msg417 : Creating group sslcert
echo -e "$ok $(msg417)"
getent group sslcert  || groupadd sslcert
# msg418 : Added to sslcert group : $1
for g in amavis dovecot mail metronome mysql openldap postfix postgrey root vmail www-data
do
	usermod -G sslcert $g
	echo -e "$(msg418 $g)"
done

# Local backup of yunohost self generated ssl certificates
# msg419 : Backup of folder $work in current location in folder backup_ssl_certs
echo -e "$ok $(msg419 $currentdate)"
mkdir -p backup_ssl_certs/$currentdate
cp -a $work/* ./backup_ssl_certs/$currentdate/

# Backup of self generated files as per Yunohost documentation
# msg420 : Backup of files as per Yunohost documentation in $work/$domain/$self
echo -e "$ok $(msg420)";
mkdir -p $work/$domain/$self
mv $work/$domain/*.{pem,cnf} $work/$domain/$self/ || true;
# We keep ca.pem in the folder
cp -a $work/yunohost.org/ca.pem $work/$domain/

# Copy of private key and crt
# msg421 : Copy of ssl key and crt in folder $work/$domain/
echo -e "$ok $(msg421) "
cp ./$files/$domain/{key,crt}.pem $work/$domain/


# Idem with yunohost.org subfolder
# msg422 : Backup of files as per Yunohost documentation in $work/yunohost.org/$self
echo -e "$ok $(msg422) ";
mkdir -p $work/yunohost.org/$self
mv $work/yunohost.org/{key,crt}.pem $work/yunohost.org/$self/ || true;
# msg423 : Copy of ssl key and crt in folder $work/yunohost.org/
echo -e "$ok $(msg423) "
cp ./$files/$domain/{key,crt}.pem $work/yunohost.org/



# Adjustement of rights
# msg424 : Adjustment of access right for key.pem and crt.pem files
echo -e "$ok $(msg424)"
chown www-data:sslcert $work/$domain/*.pem
chmod 640 $work/$domain/*.pem
chown www-data:sslcert $work/yunohost.org/*.pem
chmod 640 $work/yunohost.org/*.pem


echo -e "\n--- $(msgRestart 'NGINX & PHP5-FPM') \n"
service nginx restart
service php5-fpm restart

echo -e "\n$info $(msgAllDone) \n"

