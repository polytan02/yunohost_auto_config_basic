# Basic auto config files for Yunohost single domain


This is v5.1<br>
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
Place your ssl private key in PEM format in subfolder "conf_ssl"  <br\>
and name it ==> key.pem <br\>

Also, place your combined crt file in PEM format in subfolder "conf_ssl"  <br>
and name it ==> crt.pem <br>
<br>
<br>
Lastly, if you already have your OpenDKIM key (mail.txt and mail.private) for DOMAIN.TLD, simply place them in folder ./conf_opendkim/ <br>
DOMAIN.TLD has to be an existing domain configured by yunohost.<br>
<br>
<br>
Deatils of the scripts :
<br>
1. Installation of Yunohost with a few extra goodies such as
- Use of OVH mirror servers
- Change timezone
- Update hostname of the server
- Grab the latest git rep of yunohost
- Automatically launch install_yunohost_v2
2. master
- One script to run them all in one go ! yeah
3. base system
- Update hostname of the server
- Use of OVH mirror servers
- Adjust your timezone
- Add a user named to your choice to connect via ssh which is not admin
- Don't forget that this user name will not be able to be used by yunohost in the web interface
- Add of bash-completion
- Add a specific bashrc for root and the user created to have great colours
- Update sshd_config to have a specific port (to your liking)
- Only allow the user to connect from ssh
4. installation of your ssl certificates
- You HAVE TO copy the ssl key and crt into the folder conf_ssl so that they would be automatically installed in /etc/yunohost/certs
- Give the right permissions
- Please note that the files MUST be in PEM format
- Please note that the files MUST be name key.pem and crt.pem and placed in the folder conf_ssl
5 opendkim
- Install opendkim
- Configure opendkim with your domain name
- Indicate the DKIM key to put in your DNS
- Indicate the SPF key to put in your DNS
6. Apticron.sh
- Install apticron
- Configure sender and receiver email
- Adjust cron job to receive messages only once a day (instead of once every hour by default !)
7. Jail2Ban
- We simply activate emails to be sent once an IP has been blocked
