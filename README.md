# Basic auto config files for Yunohost single domain


This is v9.1<br>
<br>
<br> Now available in french ! Maintenant aussi disponible en français ! 
<br> Indiquez simplement fr lors de la demande de la langue
<br>
<br> 



To copy these files on your server, simply do :<br\>
apt-get update<br>
apt-get install git<br>
git clone https://github.com/polytan02/yunohost_auto_config_basic <br>
cd yunohost_auto_config_basic/<br>
<br>
<br>
If you want to install Yunohost on a fresh Debian 7, start from script 1 and then run script 2.
<br><br>
If you already installed a fresh Yunohost on a fresh Debian 7 then you can start from the master script (number 2)<br>
<br><br>

If you choose to run the SSL script, note the following : <br\>
Place your ssl private key in PEM format in subfolder "conf_ssl/DOMAIN.TLD/"  <br\>
and name it ==> key.pem <br\>

Also, place your combined crt file in PEM format in subfolder "conf_ssl/DOMAIN.TLD/"  <br>
and name it ==> crt.pem <br>
<br>
<br>
Please note that the ssl script can also let you enable dhparam for nginx (and generates the pem file, which can take some time depending on your CPU)<br>
<br>
<br>
Lastly, if you already have your OpenDKIM key (mail.txt and mail.private) for DOMAIN.TLD, simply place them in folder ./conf_opendkim/DOMAIN.TLD/ <br>
DOMAIN.TLD has to be an existing domain configured by yunohost.<br>
<br>
<br>
Deatils of the scripts :
<br>
<br>
<br>1 Installation of Yunohost with a few extra goodies such as
<br>Use of OVH mirror servers
<br>Change timezone
<br>Update hostname of the server
<br>Grab the latest git rep of yunohost
<br>Automatically launch install_yunohost_v2
<br><br>
<br>2 master
<br>One script to run them all in one go ! yeah
<br><br>
<br>3 base system
<br>Update hostname of the server
<br>Use of OVH mirror servers
<br>Adjust your timezone
<br>Add a user named to your choice to connect via ssh which is not admin
<br>Don't forget that this user name will not be able to be used by yunohost in the web interface
<br>Add of bash-completion
<br>Add a specific bashrc for root and the user created to have great colours
<br>Update sshd_config to have a specific port (to your liking)
<br>Only allow the user to connect from ssh
<br><br>
<br>4 installation of your ssl certificates
<br>activate dhparam for nginx
<br>You HAVE TO copy the ssl key and crt into the folder conf_ssl so that they would be automatically installed in /etc/yunohost/certs
<br>Give the right permissions
<br>Please note that the files MUST be in PEM format
<br>Please note that the files MUST be name key.pem and crt.pem and placed in the folder conf_ssl
<br><br> ==> This script can be re-runned multiple times to add other domains
<br><br>
<br>5 opendkim
<br>Install opendkim
<br>Configure opendkim with your domain name
<br>Indicate the DKIM key to put in your DNS
<br>Indicate the SPF key to put in your DNS
<br><br> ==> This script can be re-runned multiple times to add other domains
<br><br>
<br>6 Apticron.sh
<br>Install apticron
<br>Configure sender and receiver email
<br>Adjust cron job to receive messages only once a day (instead of once every hour by default !)
<br><br>
<br>7 Jail2Ban
<br>We simply activate emails to be sent once an IP has been blocked
<br>
<br>8 Cleaning
<br>Simple script to launch apt-get autoremove and apt-get autoclean 
<br>
<br>
