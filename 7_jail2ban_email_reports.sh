#!/bin/bash
#
# This script aims to configure fail2ban so that emails would be sent
#
#
# polytan02@mcgva.org
# 02/02/2015
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
for i in couleurs.sh 7_trad_msg.sh ;
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
source etc/7_trad_msg.sh;

# Make sure only root can run our script
if [[ $EUID -ne 0 ]];
        then   echo -e "\n$failed $(msgNoRoot) \n";
        read -e -p "$(msgHitEnterEnd)";
        exit;
fi;

current_host=`cat /etc/yunohost/current_host`;
email_default=admin@$current_host;
jail=/etc/fail2ban/jail.conf;

# We check that jail2ban needs is to be tuned
# msg701 : jail2ban can also send you emails as soon as an IP is blocked or a service is stopped/started.
echo -e "\n$info $(msg701)";
# msg702 : It is installed by default in Yunohost, this only activates emails.
echo -e "$info $(msg702) \n";
# msg703 : Do you want to activate jail2ban emails ?
read -e -p "$(msg703) (yn) : " -i "y" inst_jail;
if ! [ $inst_jail == 'y' ];
	then   echo -e "\n$info $(msgSkip) \n";
        read -p "$(msgHitEnterEnd) \n";
	exit;
fi;

# msg704 : Define fail2ban destination email address :
echo -e "\n" ; read -e -p "$(msg704) : " -i "$email_default" email_fail2ban;
# msg705 : fail2ban Receiver's email
echo -e "\n$ok $(msg705) : $email_fail2ban";

# We edit jail.conf
# msg706 : Configuring jail.conf to send emails to $email_fail2ban
echo -e "$ok $(msg706)";
sed -i "s/destemail = root@localhost/destemail = $email_fail2ban/g" $jail;
sed -i "s/action = %(action_)s/action = %(action_mwl)s/g" $jail;

# msg707 : Restarting service fail2ban
echo -e "\n--- $(msgRestart 'Fail2Ban') \n";
service fail2ban restart;

echo -e "\n$info $(msgAllDone) \n";
