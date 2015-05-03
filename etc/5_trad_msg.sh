#!/bin/bash
#
# This file contains the traductions for script 5
#
# polytan02@mcgva.org
# 03/05/2015
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

msg501 () { if [ $lang == 'fr' ]
        then echo "OpenDKIM est un logiciel qui authentifie les emails que vous envoyez";
		echo -e "$info Le but est d'eviter que vos courriels soient consideres comme des POURIELS";
		echo -e "$info N'oubliez pas que cela necessite d'ajouter un champ dans votre Zone DNS.";
        else echo "OpenDKIM is a software which authenticate the emails you send.";
		echo -e "$info This is to avoid your emails to be considered as SPAM.";
		echo -e "$info Don't forget that it requires a line to be added in your DNS Zone.";
        fi; }

msg502 () { if [ $lang == 'fr' ]
        then echo "Installer OpenDKIM ?";
        else echo "Do you want to install opendkim ?";
        fi; }

msg503 () { if [ $lang == 'fr' ]
        then echo "Indiquer le nom de domaine qui envoie les emails sur ce serveur";
        else echo "Indicate the domain name sending emails on this server";
        fi; }

msg504 () { if [ $lang == 'fr' ]
        then echo "Vous DEVEZ renseigner un nom de domaine pour qu'OpenDKIM soit configure";
        else echo "You must indicate a domain name for OpenDKIM to be configured";
        fi; }

msg505 () { if [ $lang == 'fr' ]
        then echo "Le dossier $files ne contient pas $1";
        else echo "$1 not found in folder $files";
        fi; }

msg506 () { if [ $lang == 'fr' ]
        then echo "Nom de domaine renseigne";
        else echo "Domain name specified";
        fi; }

msg507 () { if [ $lang == 'fr' ]
        then echo "Installation du logiciel OpenDKIM";
        else echo "Installation of OpenDKIM software";
        fi; }

msg508 () { if [ $lang == 'fr' ]
        then echo "Copie de opendkim.conf dans /etc/";
        else echo "Copy of opendkim.conf in /etc/ ";
        fi; }

msg509 () { if [ $lang == 'fr' ]
        then echo "Mise a jour de /etc/default/opendkim";
        else echo "Update of /etc/default/opendkim";
        fi; }

msg510 () { if [ $lang == 'fr' ]
        then echo "Mise a jour de /etc/postfix/main.cf";
        else echo "Update of /etc/postfix/main.cf";
        fi; }

msg511 () { if [ $lang == 'fr' ]
        then echo "Creation de la structure des dossiers pour OpenDKIM";
        else echo "Creation of directory structure for OpenDKIM";
        fi; }

msg512 () { if [ $lang == 'fr' ]
        then echo "Mise a jour de TrustedHosts";
        else echo "Update of TrustedHosts";
        fi; }

msg513 () { if [ $lang == 'fr' ]
        then echo "Mise a jour de KeyTable";
        else echo "Update of KeyTable";
        fi; }

msg514 () { if [ $lang == 'fr' ]
        then echo "Mise a jour de SigningTable";
        else echo "Update of SigningTable";
        fi; }

msg515 () { if [ $lang == 'fr' ]
        then echo "Cles OpenDKIM";
        else echo "OpenDKIM keys";
        fi; }

msg516 () { if [ $lang == 'fr' ]
        then echo "Le dossier $files/$domain contient $1";
        else echo "$1 found in folder $files/$domain";
        fi; }

msg517 () { if [ $lang == 'fr' ]
        then echo "Le dossier $files/$domain NE contient PAS $1";
        else echo "$1 NOT found in folder $files/$domain";
        fi; }

msg518 () { if [ $lang == 'fr' ]
        then echo "OpenDKIM mail.private et mail.txt ont ete trouves dans le dossier $files/$domain/";
		echo -e "$info et seront re-utilises au lieu de genere une nouvelle cle";
        else echo "OpenDKIM mail.private and mail.txt have been found in $files/$domain/";
		echo -e "$info and will be used instead of generating a new key";
        fi; }

msg519 () { if [ $lang == 'fr' ]
        then echo "mail.txt et mail.private ont ete copies dans $dest/keys/$domain/";
        else echo "mail.txt and mail.private have been copied to $dest/keys/$domain/";
        fi; }

msg520 () { if [ $lang == 'fr' ]
        then echo "Generation de cles OpenDKIM pour $domain";
        else echo "Generation of OpenDKIM keys for $domain";
        fi; }

msg521 () { if [ $lang == 'fr' ]
        then echo "Ajustements des droits d'acces";
        else echo "Adjustment of rights";
        fi; }

msg522 () { if [ $lang == 'fr' ]
        then echo "Voici la cle DKIM a ajouter dans votre Zone DNS";
        else echo "Here is the DKIM key to add in your DNS Zone";
        fi; }

msg523 () { if [ $lang == 'fr' ]
        then echo "Emplacement de la cle DKIM : $dest/keys/$domain/mail.txt";
        else echo "DKIM key location : $dest/keys/$domain/mail.txt";
        fi; }

msg524 () { if [ $lang == 'fr' ]
        then echo "Vous pouvez aussi ajouter un champ SPF dans votre Zone DNS";
        else echo "You can also add a SPF key in your DNS zone";
        fi; }

msg525 () { if [ $lang == 'fr' ]
        then echo "Souvenez-vous que la propagation DNS peut prendre jusqu'à 24h...";
		echo -e "\n$info N'oubliez pas de mettre à jour vos DNS !";
        else echo "Please remember that DNS propagation can take up to 24h...";
		echo -e "\n$info Don't forget to update your DNS accordingly !";
        fi; }


