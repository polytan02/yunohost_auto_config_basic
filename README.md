# Basic auto config files for Yunohost


This is v12.0

## Latest news 
* Now available in french ! Disponible en français ! 
* Indiquez simplement fr lors de la demande de la langue
 
* Maintenant compatible Debian Jessie ! (en plus de Wheezy)
* Now compatible with Debian Jessie ! (on top of Wheezy)


## Installation
To copy these files on your server, simply do:

``apt-get update``

``apt-get install git``

``git clone https://github.com/polytan02/yunohost_auto_config_basic``

``cd yunohost_auto_config_basic/``
 
## What script to use ?
* If you want to install Yunohost on a fresh Debian, start from script 1 and then run script 2 :

``./1_git_clone_and_install_YunoHost.sh``
then
``./2_master_configuration_script.sh``

* If you already installed a fresh Yunohost on a fresh then you can start from the master script (number 2) :

``./2_master_configuration_script.sh``

* This being said, each script is independant, so feel free to just run the one you want, for example :

``./8_great_colours_bash_gnuscreen_tmux.sh``

## SSL and HDparam
If you choose to run the SSL script (number 4), note the following : 
* Place your ssl private key in PEM format in subfolder "conf_ssl/DOMAIN.TLD/"  
and name it ==> key.pem 

* Also, place your combined crt file in PEM format in subfolder "conf_ssl/DOMAIN.TLD/"   
and name it ==> crt.pem  
 
 
* Please note that the ssl script can also let you enable dhparam for nginx (and generates the pem file, which can take some time depending on your CPU) 
 
## OpenDKIM
Lastly, if you already have your OpenDKIM key (mail.txt and mail.private) for DOMAIN.TLD, simply place them in folder ./conf_opendkim/DOMAIN.TLD/  
DOMAIN.TLD has to be an existing domain configured by yunohost. 
 
 
## Deatils of the scripts

1 - Installation of Yunohost with a few extra goodies such as
* Uses of OVH mirror servers (Don't use if you use Raspian!)
* Changes timezone
* Updates hostname of the server
* Grabs the latest git rep of yunohost
* Automatically launches install_yunohost_v2
  
2 - master
* One script to run them all in one go ! yeah
  
3 - base system
* Updates hostname of the server
* Uses of OVH mirror servers (Don't use if you use Raspbian)
* Adjusts your timezone
* Adds a user named to your choice to connect via ssh which is not admin

  ==> Don't forget that this user name will not be able to be used by yunohost in the web interface

* Updates sshd_config to have a specific port (to your liking)
* Only allows the user to connect from ssh
  
4 - installation of your ssl certificates
* activates dhparam for nginx
* You HAVE TO copy the ssl key and crt into the folder conf_ssl so that they would be automatically installed in /etc/yunohost/certs
* Gives the right permissions
* Please note that the files MUST be in PEM format
* Please note that the files MUST be name key.pem and crt.pem and placed in the folder conf_ssl

   ==> This script can be re-runned multiple times to add other domains

   ==> A backup of the previous ssl keys is made each time and can be found in backup_ssl. This folder is located where the scripts are placed.
  
5 - opendkim
* Installs opendkim
* Configures opendkim with your domain name
* Indicates the DKIM key to put in your DNS
* Indicates the SPF key to put in your DNS

   ==> This script can be re-runned multiple times to add other domains
  
6 - Apticron.sh
* Installs apticron
* Configures sender and receiver email
* Adjusts cron job to receive messages only once a day (instead of once every hour by default !)
  
7 - Jail2Ban
* We simply activate emails to be sent once an IP has been blocked
 
8 - Great colours in bash, screen and tmux
* Adds of bash-completion
* Adds a specific bashrc for root and the user created to have great colours
* Installs screen
* Configures screen for the new user and root
* Installs tmux
* Configures tmux for the new user and root

9 - Cleaning
* Simple script to launch apt-get autoremove and apt-get autoclean 

