#!/bin/bash
#
# This script aims to configure apticron so that emails would be sent
#
#
# polytan02@mcgva.org
# 02/05/2015
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
for i in couleurs.sh 6_trad_msg.sh ;
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
source etc/6_trad_msg.sh;

# Make sure only root can run our script
if [[ $EUID -ne 0 ]];
        then   echo -e "\n$failed $(msgNoRoot) \n";
        read -e -p "$(msgHitEnterEnd)";
        exit;
fi;


current_host=`cat /etc/yunohost/current_host`;
email_default=admin@$current_host;

# We check if apticron is to be installed
# msg601 : APTicron is a simple cron job which send you a daily email to let you know of any system update
echo -e "\n$info $(msg601) \n";
# msg602 : Do you want to install apticron ?
read -e -p "$(msg602) (yn) : " -i "y" inst_apti;
if ! [ $inst_apti == 'y' ];
	then echo -e "\n$info $(msgSkip) \n";
        read -p "$(msgHitEnterEnd)  \n";
	exit;
fi;

# We defnie sender's and receiver's email address
# msg603 : Define apticron sender's email address
echo -e "\n" ; read -e -p "$(msg603) : " -i "$email_default" email_apti_s;
# msg604 : Define receiving email address of apticron's reports
read -e -p "$(msg604) : " -i "$email_apti_s" email_apti_r;

apti=/etc/apticron/apticron.conf;
cron=/etc/cron.d/apticron;

# msg605 : apticron Sender's email
echo -e "\n$ok $(msg605) : $email_apti_s";
# msg606 : apticron Receiver's email
echo -e "$ok $(msg606) : $email_apti_r\n";

# We start by installing the right software;
# msg607 : Installation of apticron software
echo -e "$info $(msg607) ...";
apt-get update -qq > /dev/null 2>&1;
apt-get install -qq -y apticron > /dev/null 2>&1;

# Then we configure apticron
# msg608 : Configuring apticron to send emails from $email_apti_s
echo -e "$ok $(msg608) ";
sed -i "s/EMAIL=\"root\"/EMAIL=\"$email_apti_s\"/g" $apti;
sed -i "s/# NOTIFY_NO_UPDATES=\"0\"/NOTIFY_NO_UPDATES=\"1\"/g" $apti;
# msg609 : Configuring apticron to receive emails to $email_apti_r
echo -e "$ok $(msg609) ";
sed -i "s/# CUSTOM_FROM=\"\"/CUSTOM_FROM=\"$email_apti_r\"/g" $apti;

# We adjust the cron
# msg610 : Adjustment of $cron
echo -e "$ok $(msg610)";
sed -i "s/\* \* \* \*/4 \* \* \*/g" $cron;

echo -e "\n$info $(msgAllDone) \n";
