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
<br>
If you already installed a fresh Yunohost on a fresh Debian 7 then you can start from the master script (number 2)<br>
<br>


If you choose to run the SSL script, note the following : <br\>
Place your ssl private key in PEM format <br\>
in subfolder "conf_ssl"  <br\>
and name it ==> key.pem <br\>

Also, place your combined crt file in PEM format   <br\>
in subfolder "conf_ssl"  <br>
and name it ==> crt.pem <br>
<br>
<br>
Lastly, if you already have your OpenDKIM key (mail.txt and mail.private) for DOMAIN.TLD, simply place them in folder ./conf_opendkim/ <br>
DOMAIN.TLD has to be an existing domain configured by yunohost.<br>
