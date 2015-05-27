# Setup of colours for error codes
#set -e

txtgrn=`tput setaf 2`;
txtred=`tput setaf 1`;
txtcyn=`tput setaf 6`;
txtpur=`tput setaf 5`;
txtrst=`tput sgr0`;

failed=[${txtred}FAILED${txtrst}];
ok=[${txtgrn}OK${txtrst}];
info=[${txtcyn}INFO${txtrst}];
script=[${txtpur}SCRIPT${txtrst}];
warning=[${txtred}WARNING${txtrst}];

if [ $lang == "fr" ];
	then
	failed=[${txtred}ERREUR${txtrst}];
	ok=[${txtgrn}OK${txtrst}];
	info=[${txtcyn}INFO${txtrst}];
	script=[${txtpur}SCRIPT${txtrst}];
	warning=[${txtred}ATTENTION${txtrst}];
fi;
