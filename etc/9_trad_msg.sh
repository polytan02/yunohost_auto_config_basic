#!/bin/bash
#
# This file contains the traductions for script 8
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

msgAllDone () { if [ $lang == 'fr' ]
        then echo "Normalement, tout s'est bien passé ! :)";
        else echo "Hopefully, all done Well ! :)";
        fi; }

msg901 () { if [ $lang == 'fr' ]
        then echo "Nettoyage avec apt-get autoremove et autoclean";
        else echo "Cleaning with apt-get autoremove and autoclean";
        fi; }

msg902 () { if [ $lang == 'fr' ]
        then echo "Est-il temps de faire le menage ?";
        else echo "Should we make some cleaning ?";
        fi; }

msg903 () { if [ $lang == 'fr' ]
        then echo "Ok, on nettoie !";
        else echo "Ok, here we clean !";
        fi; }

msg904 () { if [ $lang == 'fr' ]
        then echo "apt-get autoremove : Fait";
        else echo "apt-get autoremove : Done";
        fi; }

msg905 () { if [ $lang == 'fr' ]
        then echo "apt-get autoclean : Fait";
        else echo "apt-get autoclean : Done";
        fi; }

msg906 () { if [ $lang == 'fr' ]
        then echo "Tres bien, pas de menage aujourd'hui.... ";
        else echo "Ok, we don't clean today... ";
        fi; }


