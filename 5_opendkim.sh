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
for i in couleurs.sh 5_trad_msg.sh ;
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
source etc/5_trad_msg.sh;

# Make sure only root can run our script
if [[ $EUID -ne 0 ]];
        then   echo -e "\n$failed $(msgNoRoot) \n";
        read -e -p "$(msgHitEnterEnd)";
        exit;
fi;

# msg501 : OpenDKIM is a software which authenticate the emails you send.
#	   This is to avoid your emails to be considered as SPAM.
#	   Don't forget that it requires a line to be added in your DNS Zone.

echo -e "\n$info $(msg501) \n";

# msg502 : Do you want to install opendkim ?
read -e -p "$(msg502) (yn) : " -i "y" dkim;
if ! [ $dkim == 'y' ];
	then echo -e "\n$info $(msgSkip) \n";
        read -p "$(msgHitEnterEnd) ";
	exit;
fi;


# We check the name of the server sending emails
current_host=`cat /etc/yunohost/current_host`
# msg503 : Indicate the domain name sending emails on this server
echo -e "\n"; read -e -p "$(msg503) : " -i "$current_host" domain;
if [ -z $domain ] ;
	then # msg504 : You must indicate a domain name for OpenDKIM to be configuredYou must indicate a domain name for OpenDKIM to be configured
	echo -e "\n$failed $(msg504) \n";
        read -p "$(msgHitEnterEnd) ";
	exit;
fi;

files=conf_opendkim;
dest=/etc/opendkim;

# We check that all necessary files are present
# msg505 : $i not found in folder $files
for i in TrustedHosts etc_default_opendkim etc_postfix_main.cf opendkim.conf;
do
	if ! [ -a "./$files/$i" ];
        then echo -e "\n$failed $(msg505 $i) ";
        echo -e "\n$(msgAbort)\n";
        read -p "$(msgHitEnterEnd) ";
	exit;
        fi;
done;

# msg506 : Domain name specified
echo -e "\n$ok $(msg506) : $domain"

# We start by installing the right software
# msg507 : Installation of OpenDKIM software
echo -e "$ok $(msg507)"
apt-get update -qq > /dev/null 2>&1;
apt-get install -y opendkim opendkim-tools > /dev/null 2>&1;

# Then we configure opendkim
# msg508 : Copy of opendkim.conf in /etc/
echo -e "$ok $(msg508) ";
cp ./$files/opendkim.conf /etc/;

# Connect the milter to Postfix :
# msg509 : Update of /etc/default/opendkim
echo -e "$ok $(msg509)";
# Cleaning before addition of data
sed -i '/SOCKET=\"inet:8891@localhost\"/d' /etc/default/opendkim;
# Addition of milter
cat ./$files/etc_default_opendkim >> /etc/default/opendkim;

# Configure postfix to use this milter :
# msg510 : Update of /etc/postfix/main.cf
echo -e "$ok $(msg510)";
# Removal of the milter in postfix main.cf (unknown at this stage)
sed -i '/# Opendkim milter configuration/d' /etc/postfix/main.cf;
sed -i '/milter_protocol = 2/d' /etc/postfix/main.cf;
sed -i '/milter_default_action = accept/d' /etc/postfix/main.cf;
sed -i '/smtpd_milters = inet:127.0.0.1:8891/d' /etc/postfix/main.cf;
sed -i '/non_smtpd_milters = inet:127.0.0.1:8891/d' /etc/postfix/main.cf;
# Addition of milter after cleaning
cat ./$files/etc_postfix_main.cf >> /etc/postfix/main.cf;

# Create a directory structure that will hold the trusted hosts, key tables, signing tables and crypto keys :
# msg511 : Creation of directory structure for opendkim
echo -e "$ok $(msg511)";
mkdir -p $dest/keys/$domain;

# Specify trusted hosts
# msg512 : Update of TrustedHosts
echo -e "$ok $(msg512)";

if [ ! -f "$dest/TrustedHosts" ];
	then cp ./$files/TrustedHosts $dest/TrustedHosts;
	echo "*.$domain" >> $dest/TrustedHosts;
	else echo "*.$domain" >> $dest/TrustedHosts;
fi;

# Create a key table
# msg513 : Update of KeyTable
echo -e "$ok $(msg513)";
echo "mail._domainkey.$domain $domain:mail:$dest/keys/$domain/mail.private" >> $dest/KeyTable;

# Create a signing table
# msg514 : Update of Signing Table
echo -e "$ok $(msg514)";
echo "*@$domain mail._domainkey.$domain" >> $dest/SigningTable;


# Now we generate the keys ! If keys are existing, they will be used
# msg515 : OpenDKIM keys
echo -e "\n$info $(msg515)\n";
# msg516 : $i found in folder $files/$domain
# msg517 : $i NOT found in folder $files/$domain
key=0;
for i in mail.txt mail.private;
do
	if [ -a "./$files/$domain/$i" ];
        then key=$((key+1))
	echo -e "$ok $(msg516 $i)";
	else echo -e "$info $(msg517 $i)";
        fi;
done;

if [ $key == 2 ];
	then # msg518 : OpenDKIM mail.private and mail.txt have been found in $files/$domain/
	     # 		and will be used instead of generating a new key
	echo -e "\n$info $(msg518) \n";
	cp $files/$domain/mail.{txt,private} $dest/keys/$domain/;
	# msg519 : mail.txt and mail.private have been copied to $dest/keys/$domain/
	echo -e "\n$ok $(msg519)";
	else # msg520 : Generation of OpenDKIM keys for $domain
	echo -e "\n$ok $(msg520) \n";
	opendkim-genkey -D $dest/keys/$domain -s mail -d $domain;
fi;


# Right parameters to the files created
# msg521 : Adjustment of rights
echo -e "\n$ok $(msg521) \n";
chown -R opendkim:opendkim $dest*

# Restart services
echo -e "\n--- $(msgRestart 'OpenDKIM & Postfix') \n";
service opendkim restart
service postfix reload

# msg522 : Here is the DKIM key to add in your server
echo -e "\n$warning $(msg522) :\n";
cat $dest/keys/$domain/mail.txt

# msg523 : DKIM key location : $dest/keys/$domain/mail.txt
echo -e "\n$info $(msg523) \n";

# msg524 : You can also add a SPF key in your DNS zone
echo -e "\n$warning $(msg524) :\n";

echo -e "$domain 300 TXT \"v=spf1 a:$domain ip4:<server's IPv4> ip6:<server's IPv6> mx ?all\"";

# msg525 : Please remember that DNS propagation can take up to 24h...
#	   Don't forget to update your DNS accordingly !
echo -e "\n$info $(msg525) \n";


echo -e "\n$info $(msgAllDone) \n"

