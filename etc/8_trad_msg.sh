#!/bin/bash
#
# This file contains the traductions for script 3
#
# polytan02@mcgva.org
# 02/05/2015
#
#

msgNoRoot () { if [ $lang == 'fr' ]
        then echo "Vous devez etre ROOT pour executer ce programme";
        else echo "This script must be run as ROOT";
        fi; }

msgAbort () { if [ $lang == 'fr' ]
        then echo "Arret avant de faire quoique ce soit";
        else echo "Aborting before doing anything";
        fi; }

msgHitEnterNext () { if [ $lang == 'fr' ]
        then echo "Presser ENTREE pour continuer";
        else echo "Hit ENTER to pursue...  ";
        fi; }

msgHitEnterEnd () { if [ $lang == 'fr' ]
        then echo "Presser ENTREE pour terminer ce script";
        else echo "Hit ENTER to end this script...  ";
        fi; }

msgGoNext () { if [ $lang == 'fr' ]
        then echo "Voulez-vous lancer cette partie du script ? (yn) : ";
        else echo "Do you want to pursue with this part of the script ? (yn) : ";
        fi; }

msgSkip () { if [ $lang == 'fr' ]
        then echo "D'accord, on ignore cette section";
        else echo "Ok, we skip this part then";
        fi; }

msgRestart () { if [ $lang == 'fr' ]
        then echo "Redemarrage du service $1";
        else echo "Restarting service $1";
        fi; }

msgAllDone () { if [ $lang == 'fr' ]
        then echo "Normalement, tout s'est bien passé ! :)";
        else echo "Hopefully, all done Well ! :)";
        fi; }

msg801 () { if [ $lang == 'fr' ]
        then echo "Le dossier $files ne contient pas $1";
        else echo "$1 not found in folder $files";
        fi; }

msg802 () { if [ $lang == 'fr' ]
        then echo "Renseignez le nom d'utilisateur shell à ajuster";
        else echo "Indicate shell username to adjust parameters";
        fi; }

msg803 () { if [ $lang == 'fr' ]
        then echo "L'utilisateur $1 existe, nous l'utiliserons";
        else echo "The user $1 exists, we will use this name";
        fi; }

msg804 () { if [ $lang == 'fr' ]
        then echo "L'utilisateur shell $1 n'existe pas, voulez-vous le créer ?";
        else echo "The shell user $1 doesn't exist, do you want to create it ?";
        fi; }

msg805 () { if [ $lang == 'fr' ]
        then echo "Utilisateur $1 créé";
        else echo "User $1 created";
        fi; }

msg806 () { if [ $lang == 'fr' ]
        then echo "Ajouter l'utilisateur $1 au groupe sudo ?";
        else echo "Add user $1 to sudo group ?";
        fi; }

msg807 () { if [ $lang == 'fr' ]
        then echo "Utilisateur $1 ajouté au groupe sudo";
        else echo "User $1 added to sudo group";
        fi; }

msg808 () { if [ $lang == 'fr' ]
        then echo "Vous n'avez pas créé l'utilisateur $1";
		echo -e "$warning Ce script ne pourra ajuster bash, screen et tmux que pour ROOT";
		echo -e "$warning Nous utiliserons le nom standard ADMIN à la place de l'utilisateur standard";
		echo -e "$warning Mais the script n'ajustera rien pour cet utilisateur";
		echo -e "$info Les changements validés pour ROOT seront appliqués";
        else echo "You have not created $1";
		echo -e "$warning This script will only be able to adjust bash, screen and tmux for ROOT";
	        echo -e "$warning We will use the genetric ADMIN name for the standard user";
		echo -e "$warning But the script will not do anything for this user";
		echo -e "$info The changes for ROOT will be applied";
        fi; }

msg809 () { if [ $lang == 'fr' ]
        then echo "Configuration speciale de $1";
        else echo "Special $1 configuration";
        fi; }

msg810 () { if [ $lang == 'fr' ]
        then echo "Voulez-vous installer $1 ?";
        else echo "Do you want to install $1 ?";
        fi; }

msg811 () { if [ $lang == 'fr' ]
        then echo "$1 installé";
        else echo "$1 installed";
        fi; }

msg812 () { if [ $lang == 'fr' ]
        then echo "Voulez vous de SUPERBES couleurs dans $1 pour $2 ?";
        else echo "Do you want GREAT colours in $1 for user $2 ?";
        fi; }

msg813 () { if [ $lang == 'fr' ]
        then echo "Pas possible pour admin, cela doit etre un nom different";
        else echo "Not possible for admin, it has to be for a different name";
        fi; }

msg814 () { if [ $lang == 'fr' ]
        then echo "Copie de $1 pour $2";
        else echo "Copy of $1 for $2";
        fi; }

msg815 () { if [ $lang == 'fr' ]
        then echo "tmux est configuré par défaut pour utiliser le raccourcis C-a";
		echo -e "$warning au lieu du standard de tmux C-b";
		echo -e "$warning Ce choix est fait pour être similaire à screen\n";
		echo -e "$warning N'hésitez pas à éditer ~/.tmux.conf au besoin";
		echo -e "$warning D'autres raccourcis ont été changés tel que le split \n";
        else echo "tmux is configured by default to use C-a";
		echo -e "$warning instead of the standard C-b bindkey";
		echo -e "$warning This choice has been made to be in line with screen\n";
		echo -e "$warning Don't hesitate to edit ~/.tmux.conf if needed";
		echo -e "$warning Others shortcuts have been modified too such as the split\n";
        fi; }
