#!/bin/bash
#
# This file contains the traductions for script 4
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

msg401 () { if [ $lang == 'fr' ]
        then echo "Voulez-vous ajuster les parametres SSL de NGINX et YUNOHOST";
        else echo "Do you want to adjust ssl parameters for nginx and yunohost ?";
        fi; }

msg402 () { if [ $lang == 'fr' ]
        then echo "Renseignez le nom de domaine de travail";
        else echo "Indicate the domain name to work on";
        fi; }

msg403 () { if [ $lang == 'fr' ]
        then echo "Vous devez renseigner un nom de domaine";
        else echo "You must specifiy a domain name";
        fi; }

msg404 () { if [ $lang == 'fr' ]
        then echo "Le nom de domaine n'est pas disponible dans le systeme YunoHost";
        else echo "The domain name is not recognised in the YunoHost system";
        fi; }

msg405 () { if [ $lang == 'fr' ]
        then echo "Nom de domaine";
        else echo "Domain name";
        fi; }

msg406 () { if [ $lang == 'fr' ]
        then echo "Activation de DHPARAM";
        else echo "Activation of DHPARAM";
        fi; }

msg407 () { if [ $lang == 'fr' ]
        then echo "En fonction du processeur de votre serveur, ceci peut prendre longtemps !";
        else echo "Depending on your server's CPU, this can take some time !";
        fi; }

msg408 () { if [ $lang == 'fr' ]
        then echo "Activer DHPARAM pour NGINX";
        else echo "Do you want to activate DHPARAM for NGINX ?";
        fi; }

msg409 () { if [ $lang == 'fr' ]
        then echo "Renseigner une valeur pour DHPARAM (2048 ou 4096)";
        else echo "Indicate dhparam value (2048 or 4096)";
        fi; }

msg410 () { if [ $lang == 'fr' ]
        then echo "$dhdom genere";
        else echo "$dhdom generated";
        fi; }

msg411 () { if [ $lang == 'fr' ]
        then echo "NGINX configure pour utiliser $dhdom";
        else echo "NGINX configured to use $dhdom";
        fi; }

msg412 () { if [ $lang == 'fr' ]
        then echo "La valeur DOIT etre 2048 ou 4096";
        else echo "Value MUST be 2048 or 4096";
        fi; }

msg413 () { if [ $lang == 'fr' ]
        then echo "Installation de la cle SSL et du certificat crt signe";
        else echo "Installation of SSL key and signed crt certificate";
        fi; }

msg414 () { if [ $lang == 'fr' ]
        then echo "N'oubliez pas de placer les fichiers key.pem et crt.pem ";
		echo -e "$info dans le sous-dossier conf_ssl/$domain";
        else echo "Don't forget to place files key.pem and crt.pem ";
		echo -e "$info in subfolder conf_ssl/$domain/";
        fi; }

msg415 () { if [ $lang == 'fr' ]
        then echo "Le dossier $files/$domain/ ne contient pas $i";
        else echo "$i not found in folder $files/$domain/";
        fi; }

msg416 () { if [ $lang == 'fr' ]
        then echo "Le dossier $files/$domain/ contient key.pem et crt.pem";
        else echo "key.pem and crt.pem are present in $files/$domain/";
        fi; }

msg417 () { if [ $lang == 'fr' ]
        then echo "Creation du groupe sslcert";
        else echo "Creating group sslcert";
        fi; }

msg418 () { if [ $lang == 'fr' ]
        then echo "Ajoute au groupe sslcert : $1";
        else echo "Added to sslcert group : $1";
        fi; }

msg419 () { if [ $lang == 'fr' ]
        then echo "Sauvegarde du dossier $work dans le sous-dossier backup_ssl_certs/$1";
        else echo "Backup of folder $work in subfolder backup_ssl_certs/$1";
        fi; }

msg420 () { if [ $lang == 'fr' ]
        then echo "Sauvegarde des fichiers en accord avec la doc YunoHost dans $work/$domain/$self";
        else echo "Backup of files as per Yunohost documentation in $work/$domain/$self";
        fi; }

msg421 () { if [ $lang == 'fr' ]
        then echo "Copie de la cle SSL et du certificat dans le dossier $work/$domain/";
        else echo "Copy of SSL key and certificate in folder $work/$domain/";
        fi; }

msg422 () { if [ $lang == 'fr' ]
        then echo "Sauvegarde des fichiers en accord avec la doc YunoHost dans $work/yunohost.org/$self";
        else echo "Backup of files as per Yunohost documentation in $work/yunohost.org/$self";
        fi; }

msg423 () { if [ $lang == 'fr' ]
        then echo "Copie de la cle SSL et du certificat dans le dossier $work/yunohost.org/";
        else echo "Copy of SSL key and certificate in folder $work/yunohost.org/";
        fi; }

msg424 () { if [ $lang == 'fr' ]
        then echo "Ajustement des droits d'acces aux fichiers key.pem et crt.pem";
        else echo "Adjustment of access right for key.pem and crt.pem files";
        fi; }

