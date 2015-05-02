# Setup of colours for error codes
set -e
txtgrn=$(tput setaf 2)    # Green
txtred=$(tput setaf 1)    # Red
txtcyn=$(tput setaf 6)    # Cyan
txtpur=$(tput setaf 5)    # Purple
txtrst=$(tput sgr0)       # Text reset

failed=[${txtred}FAILED${txtrst}];
ok=[${txtgrn}OK${txtrst}];
info=[${txtcyn}INFO${txtrst}];
script=[${txtpur}SCRIPT${txtrst}];


if [ $lang == "fr" ];
	then
		failed=[${txtred}ERREUR${txtrst}];
		ok=[${txtgrn}OK${txtrst}];
		info=[${txtcyn}INFO${txtrst}];
		script=[${txtpur}SCRIPT${txtrst}];
fi;
