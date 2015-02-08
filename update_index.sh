#!/bin/bash

# Setup of colours for error codes
set -e;
txtgrn=$(tput setaf 2);    # Green
txtred=$(tput setaf 1);    # Red
txtcyn=$(tput setaf 6);    # Cyan
txtpur=$(tput setaf 5);    # Purple
txtrst=$(tput sgr0);       # Text reset
failed=[${txtred}FAILED${txtrst}];
ok=[${txtgrn}OK${txtrst}];
info=[${txtcyn}INFO${txtrst}];
script=[${txtpur}SCRIPT${txtrst}];

user=$(whoami)
sources=/home/$user/git/twitter-bootstrap-test/bootstrap;
dest=/var/www/webapp_maxtest/site;

echo -e "$ok Dossier sources : $sources";
echo -e "$ok Dossier destination : $dest";

echo -e "\n$script Copie des fichiers vers www/site \n";
read -e -p "On continue ? ? (yn) : " -i "y" s1;
if [ $s1 == 'y' ];
        then rm -rf $dest/*;
	cp -av $sources/* $dest/;
	chown -vR maxtest:www-data $dest;
	echo -e "\n$ok Copie terminée...";
        else echo -e "\nOk, on ne fait rien\n";
        read -e -p "Presser \" entrée \"...  ";
fi;

