#!/bin/bash
#
# This script lets adjust bash, gnu-screen and tmux
# It configures with GREAT colours and stuff
# tmux has also its controls remapped
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
for i in couleurs.sh 8_trad_msg.sh ;
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
source etc/8_trad_msg.sh;

# Make sure only root can run our script
if [[ $EUID -ne 0 ]];
        then   echo -e "\n$failed $(msgNoRoot) \n";
        read -e -p "$(msgHitEnterEnd)";
        exit;
fi;

files=conf_colours;
# We check that all necessary files are present
# msg801 : $i not found in folder $files
for i in root.bashrc user.bashrc tmux.conf screenrc;
do
	if ! [ -a "./$files/$i" ];
        then echo -e "\n$failed $(msg801 $i)";
        echo -e "\n$(msgAbort) \n";
        read -p "$(msgHitEnterEnd)";
	exit;
        fi;
done;


user=admin

# msg802 : Indicate shell username to adjust parameters
echo -e "\n" ; read -e -p "$(msg802) : " new_user;
if getent passwd $new_user > /dev/null 2>&1;
	then # msg803 : The user $new_user exists, we will use this name
	echo -e "\n$ok $(msg803 $new_user)";
	user=$new_user;
	else # msg804 The shell user $new_user doesn't exist, do you want to create it ?
	echo -e "\n"; read -e -p "$(msg804 $new_user) (yn) " -i "n" create_user;
	if [ $create_user == 'y' ]
		then adduser $new_user;
		# msg805 : User $new_user created
		echo -e "\n$ok $(msg805 $new_user) \n";
		user=$new_user;
		# msg806 : Add user $user to sudo group ?
		read -e -p "$(msg806 $user) (yn) : " -i "y" sudo_user;
		if [ $sudo_user == 'y' ];
				then echo -e "\n" ; adduser $user sudo;
				# msg807 : User $user added to sudo group
				echo -e "\n$ok $(msg807 $user) \n";
			        else echo -e "\n$ok $(msgSkip) \n";
		fi;
		else # msg808 You haven't created $new_user";
		     # This script will only be able to adjust bash, screen and tmux for root";
		     # We will use the genetric "\admin"\ name but the script will not do anything for it"
		echo -e "\n$warning $(msg808 $new_user)";
	fi;
fi;


################## bashrc ######################
#
# msg809 : Special bashrc configuration
echo -e "\n\n$info $(msg809 'bash')";

# Activation of bash-completion
# msg810 : Do you want to install bash-completion ?
echo -e "\n"; read -e -p "$(msg810 'bash-completion') (yn) : " -i "y" bash_comp;
if [ $bash_comp == 'y' ];
	then apt-get update -qq > /dev/null 2>&1;
	apt-get install bash-completion -y > /dev/null 2>&1;
	# msg811 : bash-completion installed
	echo -e "$ok $(msg811 'bash-completion') \n";
	else echo -e "\n$info $(msgSkip) \n";
fi;

# Special .bashrc files for $user
# msg812 : Do you want GREAT colours in bash for user $user ?
read -e -p "$(msg812 'bash' $user) (yn) : " -i "y" coluser;
if [ $coluser == 'y' ];
	then if [ $user == 'admin' ];
		then # msg813 : Not possible for admin, it has to be for a different name
		echo -e "\n$failed $(msg813) \n";
		else # msg814 : Copy of .bashrc to $user
		echo -e "$ok $(msg814 '.bashrc' $user)";
		cp ./$files/user.bashrc /home/$user/.bashrc;
		chown $user:$user /home/$user/.bashrc;
		source ~/.bashrc;
	fi;
        else echo -e "\n$info $(msgSkip) \n";
fi;

# Special .bashrc for root
# msg812 : Do you want GREAT bash colours for ROOT ?
echo -e "\n"; read -e -p "$(msg812 'bash' 'ROOT') (yn) : " -i "y" colroot;
if [ $colroot == 'y' ];
	then # msg814 : Copy of .bashrc to root
	echo -e "$ok $(msg814 '.bashrc' 'ROOT')";
	cp ./$files/root.bashrc /root/.bashrc;
	else echo -e "\n$info $(msgSkip) \n";
fi;

################## gnu-screen ######################
#
# msg809 : Special screen configuration
echo -e "\n\n$info $(msg809 'gnu-screen')";

# Installation of gnu-screen
# msg810 : Do you want to install gnu-screen ?
echo -e "\n"; read -e -p "$(msg810 'gnu-screen') (yn) : " -i "y" inst;
if [ $inst == 'y' ];
	then apt-get update -qq > /dev/null 2>&1;
	apt-get install screen -y > /dev/null 2>&1;
	# msg811 : screen installed
	echo -e "$ok $(msg811 'gnu-screen') \n";
	else echo -e "\n$info $(msgSkip) \n";
fi;

# Special .screenrc files for $user
# msg812 : Do you want GREAT colours in screen for user $user ?
read -e -p "$(msg812 'gnu-screen' $user) (yn) : " -i "y" coluser;
if [ $coluser == 'y' ];
	then if [ $user == 'admin' ];
		then # msg813 : Not possible for admin, it has to be for a different name
		echo -e "\n$failed $(msg813) \n";
		else # msg814 : Copy of .screenrc to $user
		echo -e "$ok $(msg814 '.screenrc' $user)";
		cp ./$files/screenrc /home/$user/.screenrc;
		chown $user:$user /home/$user/.screenrc;
	fi;
        else echo -e "\n$info $(msgSkip) \n";
fi;

# Special .screenrc for root
# msg812 : Do you want GREAT screen colours for ROOT ?
echo -e "\n"; read -e -p "$(msg812 'screen' 'ROOT') (yn) : " -i "y" colroot;
if [ $colroot == 'y' ];
	then # msg814 : Copy of .screenrc to root
	echo -e "$ok $(msg814 '.screenrc' 'ROOT')";
	cp ./$files/screenrc /root/.screenrc;
	else echo -e "\n$info $(msgSkip) \n";
fi;

################## tmux ######################
#
# msg809 : Special tmux configuration
echo -e "\n\n$info $(msg809 'tmux')";

# Installation of tmux
# msg810 : Do you want to install tmux ?
echo -e "\n"; read -e -p "$(msg810 'tmux') (yn) : " -i "y" inst;
if [ $inst == 'y' ];
	then apt-get update -qq > /dev/null 2>&1;
	apt-get install tmux -y > /dev/null 2>&1;
	# msg811 : tmux installed
	echo -e "$ok $(msg811 'tmux') \n";
	else echo -e "\n$info $(msgSkip) \n";
fi;

# Special .tmux.conf files for $user
# msg815 : warning for tmux
echo -e "\n$warning $(msg815)\n";
# msg812 : Do you want GREAT colours in tmux for user $user ?
read -e -p "$(msg812 'tmux' $user) (yn) : " -i "y" coluser;
if [ $coluser == 'y' ];
	then if [ $user == 'admin' ];
		then # msg813 : Not possible for admin, it has to be for a different name
		echo -e "\n$failed $(msg813) \n";
		else # msg814 : Copy of .tmux.conf to $user
		echo -e "$ok $(msg814 '.tmux.conf' $user)";
		cp ./$files/tmux.conf /home/$user/.tmux.conf;
		chown $user:$user /home/$user/.tmux.conf;
	fi;
        else echo -e "\n$info $(msgSkip) \n";
fi;

# Special .tmux.conf for root
# msg812 : Do you want GREAT tmux colours for ROOT ?
echo -e "\n"; read -e -p "$(msg812 'tmux' 'ROOT') (yn) : " -i "y" colroot;
if [ $colroot == 'y' ];
	then # msg814 : Copy of .tmux.conf to root
	echo -e "$ok $(msg814 '.tmux.conf' 'ROOT')";
	cp ./$files/tmux.conf /root/.tmux.conf;
	else echo -e "\n$info $(msgSkip) \n";
fi;



echo -e "\n$info $(msgAllDone) \n";

