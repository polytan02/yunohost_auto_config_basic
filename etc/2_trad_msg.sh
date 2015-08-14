#!/bin/bash
#
# This file contains the traductions for script 2
#
# polytan02@mcgva.org
# 01/05/2015
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

msg201 () { if [ $lang == 'fr' ]
        then echo "Le repertoire courant ne contient pas $1";
        else echo "$1 not found in current folder";
        fi; }

msg202 () { if [ $lang == 'fr' ]
        then echo "3_CONFIGURATION de BASE du SYSTEME";
        else echo "3_BASE SYSTEM CONFIGURATION";
        fi; }

msg203 () { if [ $lang == 'fr' ]
        then echo "Ok, On ne lance pas la configuration de base du systeme";
        else echo "Ok, Skipping base system configuration";
        fi; }

msg204 () { if [ $lang == 'fr' ]
        then echo "4_CONFIGURATION de SSL pour NGINX et YUNOHOST";
        else echo "4_CONFIGURATION of NGINX and YUNOHOST SSL";
        fi; }

msg205 () { if [ $lang == 'fr' ]
        then echo "Ok, On ne lance pas la configuration de SSL";
        else echo "Ok, Skipping SSL configuration";
        fi; }

msg206 () { if [ $lang == 'fr' ]
        then echo "5_CONFIGURATION d'OpenDKIM";
        else echo "5_CONFIGURATION of OpenDKIM";
        fi; }

msg207 () { if [ $lang == 'fr' ]
        then echo "Ok, on ne lance pas la configuration d'OpenDKIM";
        else echo "Ok, Skipping OpendDKIM configuration";
        fi; }

msg208 () { if [ $lang == 'fr' ]
        then echo "6_INSTALLATION et CONFIGURATION d'APTICRON";
        else echo "6_INSTALLATION and CONFIGURATION OF APTICRON";
        fi; }

msg209 () { if [ $lang == 'fr' ]
        then echo "Ok, on ne lance pas la configuration d'apticron";
        else echo "Ok, Skipping Apticron configuration";
        fi; }

msg210 () { if [ $lang == 'fr' ]
        then echo "7_CONFIGURATION de FAIL2BAN";
        else echo "7_CONFIGURATION of FAIL2BAN";
        fi; }

msg211 () { if [ $lang == 'fr' ]
        then echo "Ok, on ne lance pas la configuration de Jail2Ban";
        else echo "Ok, Skipping Jail2Ban configuration";
        fi; }

msg212 () { if [ $lang == 'fr' ]
        then echo "8_SUPERBES COULEURS dans BASH SCREEN TMUX";
        else echo "8_GREAT COLOURS in BASH SCREEN TMUX";
        fi; }

msg213 () { if [ $lang == 'fr' ]
        then echo "Ok, on n'ajoute pas de SUPERBES couleurs shell";
        else echo "Ok, We don't add GREAT shell colours";
        fi; }

msg214 () { if [ $lang == 'fr' ]
        then echo "9_NETTOYAGE APT-GET";
        else echo "9_APT-GET CLEANING";
        fi; }

msg215 () { if [ $lang == 'fr' ]
        then echo "Ok, Pas de nettoyage apt-get";
        else echo "Ok, Skipping apt-get cleaning";
        fi; }

