#!/bin/bash
#
# This file contains the traductions for script 3
#
# polytan02@mcgva.org
# 14/08/2015
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

msg301 () { if [ $lang == 'fr' ]
        then echo "Le dossier $files ne contient pas $1";
        else echo "$1 not found in folder $files";
        fi; }

msg302 () { if [ $lang == 'fr' ]
        then echo "Nom d'hote (hostname) actuel";
        else echo "Current hostname";
        fi; }

msg303 () { if [ $lang == 'fr' ]
        then echo "Voulez vous changer le nom d'hote de ce serveur ?";
        else echo "Do you want to change the hostname of this server ?";
        fi; }

msg304 () { if [ $lang == 'fr' ]
        then echo "Indiquer le nouveau nom d'hote";
        else echo "Indicate the new hostname";
        fi; }

msg305 () { if [ $lang == 'fr' ]
        then echo "Nom d'hote mis a jour en $1";
        else echo "Hostname updated to $1";
        fi; }

msg306 () { if [ $lang == 'fr' ]
        then echo "Le nom d'hote semble vide, pas de changement !";
        else echo "The hostname seems empty, we don't change it !";
        fi; }

msg307 () { if [ $lang == 'fr' ]
        then echo "D'accord, on ne change pas le nom d'hote";
        else echo "Ok, we don't change the hostname";
        fi; }

msg3081 () { if [ $lang == 'fr' ]
	then echo "Attention, option incompatible avec Raspbian (la plupart des raspberry pi l'utilise)";
                echo -e "$info Ne pas utiliser les miroirs OVH dans ce cas !";
        else echo "Be careful, this option is not compatible with Raspbien (most of raspberry pi use it)";
                echo -e "$info Don't use OVH mirrors in this case !";
        fi; }

msg3082 () { if [ $lang == 'fr' ]
        then echo "Utiliser les miroirs Debian fournis par OVH ?";
        else echo "Do you want to use OVH Debian mirrors ?";
        fi; }

msg309 () { if [ $lang == 'fr' ]
        then echo "Copie d'apt sources.list pour utiliser les serveurs d'OVH";
        else echo "Copy apt sources.list to use OVH servers";
        fi; }

msg310 () { if [ $lang == 'fr' ]
        then echo "D'accord, on ne change pas /etc/apt/sources.list";
        else echo "Ok, we don't change /etc/apt/sources.list";
        fi; }

msg311 () { if [ $lang == 'fr' ]
        then echo "Fuseau Horaire (timezone) actuel";
        else echo "Current timezone";
        fi; }

msg312 () { if [ $lang == 'fr' ]
        then echo "Changer le fuseau horaire ?";
        else echo "Do you want to change your timezone ?";
        fi; }

msg313 () { if [ $lang == 'fr' ]
        then echo "Fuseau horaire mis à jour";
        else echo "Timezone updated";
        fi; }

msg314 () { if [ $lang == 'fr' ]
        then echo "D'accord, on ne change pas le fuseau horaire";
        else echo "Ok, we don't change the timezone";
        fi; }

msg315 () { if [ $lang == 'fr' ]
        then echo "Changer la langue du systeme ?";
        else echo "Do you want to change your locale ?";
        fi; }

msg316 () { if [ $lang == 'fr' ]
        then echo "Langue du systeme mise à jour";
        else echo "Locales updated";
        fi; }

msg317 () { if [ $lang == 'fr' ]
        then echo "D'accord, on ne change pas la langue systeme";
        else echo "Ok, we don't change the locale";
        fi; }

msg3181 () { if [ $lang == 'fr' ]
        then echo "Copie d'un sshd_config basique dans /etc/ssh ?";
        else echo "Copy of a basic sshd_config in /etc/ssh ?";
        fi; }

msg3182 () { if [ $lang == 'fr' ]
        then echo "sshd_config basique copié dans /etc/ssh";
        else echo "basic sshd_config copied in /etc/ssh";
        fi; }

msg319 () { if [ $lang == 'fr' ]
        then echo -e "Utilisateur SSH par defaut : $user\n";
		echo -e "$info Veuillez noter que cet utilisateur doit avoir un login DIFFERENT des utilisateurs YunoHost";
		echo -e "$info Vous ne pourrez pas creer un utilisateur avec le meme nom via l'interface web";
		echo -e "$info Je n'aime pas utiliser admin, d'ou la creation d'un utilisateur ssh dedie";
        else echo -e "Default SSH user : $user\n";
		echo -e "$info Please note that the user MUST be DIFFERENT from one created by yunohost itself";
		echo -e "$info You will not be able to create a user with the same name later on with yunohost";
		echo -e "$info I don't like using admin, hence the creation of a dedicated ssh user";
        fi; }

msg320 () { if [ $lang == 'fr' ]
        then echo "Voulez vous creer un nouvel utilisateur dedie a SSH ?";
        else echo "Do you want to create a new user to connect via SSH ?";
        fi; }

msg321 () { if [ $lang == 'fr' ]
        then echo "Renseignez le nouveau nom de connexion via SSH";
        else echo "Indicate new username to connect via SSH";
        fi; }

msg322 () { if [ $lang == 'fr' ]
        then echo "L'utilisateur $new_user existe deja";
        else echo "The user $new_user already exists";
        fi; }

msg323 () { if [ $lang == 'fr' ]
        then echo "On ne le cree pas et on passe a l'etape suivante";
        else echo "We don't create it and skip this part then";
        fi; }

msg324 () { if [ $lang == 'fr' ]
        then echo "Utilisateur $new_user cree";
        else echo "User $new_user created";
        fi; }

msg325 () { if [ $lang == 'fr' ]
        then echo "Ajouter l'utilisateur $user au groupe sudo ?";
        else echo "Add user $user to sudo group ?";
        fi; }

msg326 () { if [ $lang == 'fr' ]
        then echo "Utilisateur $user ajoute au groupe sudo";
        else echo "User $user added to sudo group";
        fi; }

msg327 () { if [ $lang == 'fr' ]
        then echo "Port SSH par defaut : 22";
        else echo "Default SSH port : 22";
        fi; }

msg328 () { if [ $lang == 'fr' ]
        then echo "Changer le port de connexion SSH ?";
        else echo "Do you want to change the SSH port ?";
        fi; }

msg329 () { if [ $lang == 'fr' ]
        then echo "Renseignez le nouveau port SSH";
        else echo "Indicate new SSH port";
        fi; }

msg330 () { if [ $lang == 'fr' ]
        then echo "Le port $port est deja utilise";
        else echo "The port $port is already used";
        fi; }

msg331 () { if [ $lang == 'fr' ]
        then echo "On ne change pas le port SSH et on passe a l'etape suivante";
        else echo "We don't change the SSH port and skip this part then";
        fi; }

msg332 () { if [ $lang == 'fr' ]
        then echo "Le port de connexion SSH est maintenant $port dans sshd_config";
        else echo "SSH port changed to $port in sshd_config";
        fi; }

msg333 () { if [ $lang == 'fr' ]
        then echo "Ameliorer la securite de SSH en limitant les utilisateurs actifs";
        else echo "Improve SSH security by limiting available users";
        fi; }

msg334 () { if [ $lang == 'fr' ]
        then echo "Configurer SSH pour n'autoriser QUE les connexions de $user sur le port $port";
        else echo "Do you want SSH to ONLY accept connections from user $user on port $port ?";
        fi; }

msg335 () { if [ $lang == 'fr' ]
        then echo "Seul l'utilisateur $user est maintenant autorise a se connecter sur le port $port";
        else echo "Only user $user is now allowed to connect remotely from port $port";
        fi; }

msg336 () { if [ $lang == 'fr' ]
        then echo "Comme vous avez repondu NON a la question precedente, ";
		echo -e "$warning SSH est configure pour autorise ROOT a se connecter sur $port";
	        echo -e "$warning Ceci ne devrait pas etre le cas et vous devez editer ";
		echo -e "$warning /etc/ssh/sshd_config manuellement pour corriger cela";
        else echo "As you said NO to previous question, SSH is configured to ";
		echo -e "$warning allow ROOT to connect on port $port";
	        echo -e "$warning This should NOT be the case and you will have to manually correct this !";
        fi; }


