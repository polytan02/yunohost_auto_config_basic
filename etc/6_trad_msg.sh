#!/bin/bash
#
# This file contains the traductions for script 6
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

msgAllDone () { if [ $lang == 'fr' ]
        then echo "Normalement, tout s'est bien passé ! :)";
        else echo "Hopefully, all done Well ! :)";
        fi; }

msg601 () { if [ $lang == 'fr' ]
        then echo "APTicron est une tache cron toute simple qui vous envoie";
		echo -e "$info un courriel hebdomadaire indiquant ";
		echo -e "$info s'il y a une mise a jour systeme de disponible";
        else echo "APTicron is a simple cron job which sends you ";
		echo -e "$info a daily email to let you know of any system update";
        fi; }

msg602 () { if [ $lang == 'fr' ]
        then echo "Voulez-vous installer APTicron ?";
        else echo "Do you want to install apticron ?";
        fi; }

msg603 () { if [ $lang == 'fr' ]
        then echo "Indiquer le courriel d'expedition utilise par apticron";
        else echo "Define apticron sender's email address";
        fi; }

msg604 () { if [ $lang == 'fr' ]
        then echo "Indiquer le courriel de reception des rapports d'apticron";
        else echo "Define receiving email address of apticron's reports";
        fi; }

msg605 () { if [ $lang == 'fr' ]
        then echo "Courrriel d'expedition d'apticron";
        else echo "apticron Sender's email";
        fi; }

msg606 () { if [ $lang == 'fr' ]
        then echo "Courriel de reception des rapports d'apticron";
        else echo "apticron Receiver's email";
        fi; }

msg607 () { if [ $lang == 'fr' ]
        then echo "Installation du logiciel apticron";
        else echo "Installation of apticron software";
        fi; }

msg608 () { if [ $lang == 'fr' ]
        then echo "Configuration d'apticron pour que $email_apti_s envoie les courriels";
        else echo "Configuring apticron to send emails from $email_apti_s";
        fi; }

msg609 () { if [ $lang == 'fr' ]
        then echo "Configuration d'apticron pour que $email_apti_r recoive les courriels";
        else echo "Configuring apticron for $email_apti_r to receive emails";
        fi; }

msg610 () { if [ $lang == 'fr' ]
        then echo "Ajustement de $cron";
        else echo "Adjustment of $cron";
        fi; }

