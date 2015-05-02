#!/bin/bash
#
# This file contains the traductions for script 7
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
        then echo "Ok, on ignore cette section";
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

msg701 () { if [ $lang == 'fr' ]
        then echo "Jail2Ban peut vous envoyer un email";
		echo -e "$info des qu'une IP est bannie ou qu'un service systeme est relance";
        else echo "Jail2Ban can send you emails as soon as";
		echo -e "$info an IP is blocked or a service is stopped/started.";
        fi; }

msg702 () { if [ $lang == 'fr' ]
        then echo "Fail2Ban est installe par defaut dans Yunohost.";
		echo -e "$info Ce script active uniquement l'envoi des courriels";
        else echo "Fail2Ban is installed by default in Yunohost.":
		echo -e "$info This script only activates emails.";
        fi; }

msg703 () { if [ $lang == 'fr' ]
        then echo "Voulez-vous activer les courriels Jail2Ban ?";
        else echo "Do you want to activate Jail2Ban emails ?";
        fi; }

msg704 () { if [ $lang == 'fr' ]
        then echo "Indiquer le courriel destinataire des messages de Fail2Ban";
        else echo "Define fail2ban's destination email address";
        fi; }

msg705 () { if [ $lang == 'fr' ]
        then echo "Destinataire des emails de Fail2Ban";
        else echo "Fail2Ban Receiver's email";
        fi; }

msg706 () { if [ $lang == 'fr' ]
        then echo "Configuration de fail.conf pour que $email_fail2ban recoive les courriels";
        else echo "Configuring jail.conf to send emails to $email_fail2ban";
        fi; }
