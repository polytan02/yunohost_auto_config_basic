# Basic auto config files for Yunohost single domain


This is v3.0 stable<br/>
<br/>


To copy these files on your server, simply do :<br\>
apt-get update<br/>
apt-get install git<br/>
git clone https://github.com/polytan02/yunohost_auto_config_basic <br/>
cd yunohost_auto_config_basic/v3.0-stable<br/>
<br/>
<br/>
<br/>
We can assume that you already just installed a fresh Yunohost on a fresh Debian<br/>
If yes, then you can start from the master script (number 2)<br/>
<br/>
<br/>
Otherwise, you can also use these scripts to install yunohost first on a fresh Debian<br/>
and then proceed with the master script<br/>


If you choose to run the SSL script, note the following : <br\>
Place your ssl private key in PEM format <br\>
in subfolder "conf_ssl"  <br\>
and name it ==> key.pem <br\>

Also, place your combined crt file in PEM format   <br\>
in subfolder "conf_ssl"  <br\>
and name it ==> crt.pem

