#!/bin/bash
#
# This script aims to configure the base system for ssh (checking that the port is available),
# creates an admin user different than "admin"
# It also specifies to use ovh mirrors, locale, timezone and hostname
#
# polytan02@mcgva.org
# 14/08/2015
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
for i in couleurs.sh 3_trad_msg.sh ;
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

source etc/couleurs.sh;
source etc/3_trad_msg.sh;

# Make sure only root can run our script
if [[ $EUID -ne 0 ]];
        then   echo -e "\n$failed $(msgNoRoot) \n";
        read -e -p "$(msgHitEnterEnd)";
        exit;
fi;

files=conf_base;
# We check that all necessary files are present
# msg301 : $i not found in folder $files
for i in sshd_config sources.list;
do
	if ! [ -a "./$files/$i" ];
        then echo -e "\n$failed $(msg301 $i)";
        echo -e "\n$(msgAbort) \n";
        read -p "$(msgHitEnterEnd)";
	exit;
        fi;
done;

# Update of hostname
hostname=`cat /etc/hostname`;
# msg302 : Current hostname
echo -e "\n$info $(msg302) : $hostname \n";
# msg303 : Do you want to change the hostname of this server ?
read -e -p "$(msg303) (yn) : " -i "y" change_hostname;
if [ $change_hostname == 'y' ];
        then # msg304 : Indicate the new hostname
	echo -e "\n" ; read -e -p "$(msg304) : " new_hostname;
        if [ ! -z $new_hostname ];
                then echo $new_hostname > /etc/hostname
		# msg305 : hostname updated to $new_hostname
                echo -e "\n$ok $(msg305 $new_hostname) \n";
                else # msg306 : The hostname seems empty, we don't change it !
		echo -e "\n$failed $(msg306)";
		# msg302 : Current hostname
                echo -e "\n$info $(msg302) : $hostname \n";
                read -e -p "$(msgHitEnterNext)";
        fi;
        else # msg307 : Ok, we don't change the hostname
	echo -e "\n$info $(msg307) \n";
fi;

# Update of sources.list
sources=conf_base/sources.list;
# msg308 : Do you want to use OVH Debian mirrors ?
echo -e "\n$info $(msg3081) \n";
read -e -p "$(msg3082) (yn) : " -i "y" ovh;
if [ $ovh == 'y' ];
	then # msg309 : Copy apt sources.list to use ovh servers
	echo -e "\n$ok $(msg309)";
	cp ./$sources /etc/apt/;
	# We check Debian version to update the sources.list accordingly
	debver=$(sed 's/\..*//' /etc/debian_version)
	if [ $debver == 8 ];
		then sed -i 's/wheezy/jessie/g' /etc/apt/sources.list
	fi;
	# We add yunohost megusta repository (=stable v2)
	echo "deb http://repo.yunohost.org/ megusta main" >> /etc/apt/sources.list;
	else # msg310 : Ok, we don't change apt/sources.list
	echo -e "\n$info $(msg310) \n";
fi;

# Update of timezone
zone=`cat /etc/timezone`;
# msg311 : Current timezone
echo -e "\n\n$info $(msg311) : $zone\n";
# msg312 : Do you want to change your timezone ?
read -e -p "$(msg312) (yn) : " -i "y" zone;
if [ $zone == 'y' ];
        then dpkg-reconfigure tzdata;
	# msg313 : timezone updated
        echo -e "\n$ok $(msg313) \n";
        else # msg314 : Ok, we don't change the timezone
	echo -e "\n$info $(msg314) \n";
fi;


# Update of locales
# msg315 : Do you want to change your locale ?
echo -e "\n"; read -e -p "$(msg315) (yn) : " -i "y" locales
if [ $locales == 'y' ]
        then dpkg-reconfigure locales
	# msg316 : locale updated
        echo -e "\n$ok $(msg316) \n";
	# msg317 : Ok, we don't change the locales
        else echo -e "\n$info $(msg317) \n";
fi;


################## SSH ######################
#
# SSH configuration with standard Yunohost file with root allowed to connect
# msg3181 : Copy of a basic sshd config in /etc/ssh ?
echo -e "\n"; read -e -p "$(msg3181) (yn) : " -i "n" copysshd;
if [ $copysshd == 'y' ];
	then # msg3182 : Copy of sshd_config to /etc/ssh
	echo -e "$ok $(msg3182)";
	cp ./$files/sshd_config /etc/ssh/sshd_config;
	else echo -e "\n$info $(msgSkip) \n";
fi;


# Creation of a SSH user instead of admin
user=admin
# msg319 : Default SSH user : $user\n";
#	   Please note that the user MUST be DIFFERENT from one created by yunohost itself";
#	   You will not be able to create a user with the same name later on with yunohost";
#	   I don't like using admin, hence the creation of a dedicated ssh user\n";
echo -e "\n$info $(msg319) \n";
# msg320 : Do you want to create a new user to connect via ssh ?
read -e -p "$(msg320) (yn) : " -i "y" create_user;
if [ $create_user == 'y' ];
	then # Indicate new username to connect via ssh
	echo -e "\n" ; read -e -p "$(msg321) : " new_user;
	if getent passwd $new_user > /dev/null 2>&1;
		then # msg322 : The user $new_user already exists
		echo -e "\n$info $(msg322)";
		# msg323 : We don't create it and skip this part then
		echo -e "\n$info $(msg323) \n";
		else adduser $new_user;
		# msg324 : User $new_user created
		echo -e "\n$ok $(msg324) \n";
		user=$new_user;
		# msg325 : Add user $user to sudo group ?
		read -e -p "$(msg325) (yn) : " -i "y" sudo_user;
		if [ $sudo_user == 'y' ];
				then echo -e "\n" ; adduser $user sudo;
				# msg326 : User $user added to sudo group
				echo -e "\n$ok $(msg326) \n";
			        else echo -e "\n$ok $(msgSkip) \n";
		fi;

	fi;
fi;


# Change of standard SSH port
# msg327 : Default SSH port : 22
echo -e "\n$info $(msg327) \n";
# msg328 : Do you want to change the default port ?
read -e -p "$(msg328) (yn) : " -i "y" port;
if [ $port == 'y' ];
	then # msg329 : Indicate new SSH port
	echo -e "\n"; read -e -p "$(msg329) : " -i "22" port;
	# Check port availability
	echo -e "\n" ; yunohost app checkport $port;
	if [[ ! $? -eq 0 ]];
		then # msg330 : The port $port is already used
		echo -e "\n$failed $(msg330)";
		# msg331 : We don't change the default SSH port and skip this part then
		echo -e "\n$info $(msg331) \n";
	        read -e -p "$(msgHitEnterNext) ";
		else
		# Open port in firewall
		echo -e "\n" ; yunohost firewall allow TCP $port;
		#sed -i "s/Port 22/Port $port/g" /etc/ssh/sshd_config;
		sed -i "s|^.*\bPort \b.*$|Port $port|" /etc/ssh/sshd_config;
		# msg 332 : SSH port changed to $port in sshd_config
		echo -e "\n$ok $(msg332) \n";
	fi;
	else echo -e "\n$info $(msgSkip) \n";
fi;


# We limit the connection to a single user
# msg333 : Limit connections to a single user
echo -e "\n$info $(msg333) \n";
#  msg334 : Do you want SSH to ONLY accept connections from user $user on port $port ?
read -e -p "$(msg334) (yn) : " -i "y" allow_user;
if [ $allow_user == 'y' ];
        then # msg335 : Only user $user is now allowed to connect remotely from port $port
	echo -e "\n$ok $(msg335)";
	echo -e "AllowUsers $user" >> /etc/ssh/sshd_config;
        sed -i "s/PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config;
	else echo -e "\n$info $(msgSkip) \n";
	# msg336 : As you said NO to previous question, SSH is configured to allow root to connect on port $port";
	#        echo -e "$warning This should NOT be the case and you will have to manually correct this !
	echo -e "$warning $(msg336) \n";
fi;

# We restart SSH service
echo -e "\n--- $(msgRestart 'SSH') \n";
service ssh restart;
echo -e "\n";

echo -e "\n$info $(msgAllDone) \n";

