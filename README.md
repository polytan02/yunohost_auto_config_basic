# Basic auto config files for Yunohost single domain


To copy these files on your server, simply do :<br\>
apt-get update<br/>
apt-get install git<br/>
git clone https://github.com/polytan02/yunohost_auto_config_basic <br/>
cd yunohost_auto_config_basic<br/>
<br/>
And run the scripts in order from this folder.<br\>


If you choose to run 3_install_certssl.sh, note the following : <br\>
Place your ssl private key in PEM format <br\>
in folder "./conf_ssl"  <br\>
and name it ==> key.pem <br\>

Also, place your combined crt file in PEM format   <br\>
in folder "./conf_ssl"  <br\>
and name it ==> crt.pem

