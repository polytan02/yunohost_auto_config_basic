#!/bin/bash
#
# This file contains the traductions for script 1
#
# polytan02@mcgva.org
# 01/05/2015
#
#

msgNoRoot () { if [ $lang == 'fr' ]
        then echo "Vous devez etre ROOT pour executer ce programme";
        else echo "This script must be run as ROOT";
        fi; }

msgHitEnterNext () { if [ $lang == 'fr' ]
        then echo "Presser ENTREE pour continuer";
        else echo "Hit ENTER to pursue...  ";
        fi; }

msgHitEnterEnd () { if [ $lang == 'fr' ]
        then echo "Presser ENTREE pour terminer ce script";
        else echo "Hit ENTER to end this script...  ";
        fi; }

msg100 () { if [ $lang == 'fr' ]
        then echo "INSTALLATION de YUNOHOST";
        else echo "INSTALLATION of YUNOHOST";
        fi; }

msg101 () { if [ $lang == 'fr' ]
        then echo "Nom d'hote (hostname) actuel";
        else echo "Current hostname";
        fi; }

msg102 () { if [ $lang == 'fr' ]
        then echo "Voulez vous changer le nom d'hote de ce serveur ?";
        else echo "Do you want to change the hostname of this server ?";
        fi; }

msg103 () { if [ $lang == 'fr' ]
        then echo "Indiquer le nouveau nom d'hote";
        else echo "Indicate the new hostname";
        fi; }

msg104 () { if [ $lang == 'fr' ]
        then echo "Nom d'hote mis a jour en $new_hostname";
        else echo "Hostname updated to $new_hostname";
        fi; }

msg105 () { if [ $lang == 'fr' ]
        then echo "Le nom d'hote semble vide, pas de changement !";
        else echo "The hostname seems empty, we don't change it !";
        fi; }

msg106 () { if [ $lang == 'fr' ]
        then echo "D'accord, on ne change pas le nom d'hote";
        else echo "Ok, we don't change the hostname";
        fi; }

msg1071 () { if [ $lang == 'fr' ]
        then echo "Attention, option incompatible avec Raspbian (la plupart des raspberry pi l'utilise)";
		echo -e "$info Ne pas utiliser les miroirs OVH dans ce cas !";
        else echo "Be careful, this option is not compatible with Raspbien (most of raspberry pi use it)";
		echo -e "$info Don't use OVH mirrors in this case !";
        fi; }

msg1072 () { if [ $lang == 'fr' ]
        then echo "Utiliser les miroirs Debian fournis par OVH ?";
        else echo "Do you want to use OVH Debian mirrors ?";
        fi; }

msg108 () { if [ $lang == 'fr' ]
        then echo "Copie d'apt sources.list pour utiliser les serveurs d'OVH";
        else echo "Copy apt sources.list to use OVH servers";
        fi; }

msg109 () { if [ $lang == 'fr' ]
        then echo "D'accord, on ne change pas /etc/apt/sources.list";
        else echo "Ok, we don't change /etc/apt/sources.list";
        fi; }

msg110 () { if [ $lang == 'fr' ]
        then echo "Fuseau Horaire (timezone) actuel";
        else echo "Current timezone";
        fi; }

msg111 () { if [ $lang == 'fr' ]
        then echo "Changer le fuseau horaire ?";
        else echo "Do you want to change your timezone ?";
        fi; }

msg112 () { if [ $lang == 'fr' ]
        then echo "Fuseau horaire mis à jour";
        else echo "Timezone updated";
        fi; }

msg113 () { if [ $lang == 'fr' ]
        then echo "D'accord, on ne change pas le fuseau horaire";
        else echo "Ok, we don't change the timezone";
        fi; }

msg114 () { if [ $lang == 'fr' ]
        then echo "Changer la langue du systeme ?";
        else echo "Do you want to change your locale ?";
        fi; }

msg115 () { if [ $lang == 'fr' ]
        then echo "Langue du systeme mise à jour";
        else echo "Locales updated";
        fi; }

msg116 () { if [ $lang == 'fr' ]
        then echo "D'accord, on ne change pas la langue systeme";
        else echo "Ok, we don't change the locale";
        fi; }

msg117 () { if [ $lang == 'fr' ]
        then echo "Presser ENTREE pour continuer vers apt-get update et l'installation de YnH ...";
        else echo "Hit ENTER to pursue to apt-get update and YnH Installation...  ";
        fi; }

msg118 () { if [ $lang == 'fr' ]
        then echo "Mise a jour de la liste des paquets systeme";
        else echo "Update of system packages list";
        fi; }

msg119 () { if [ $lang == 'fr' ]
        then echo "Installation de YunoHost v2 depuis les sources git";
        else echo "Installation of Yunohost v2 from git sources";
        fi; }
