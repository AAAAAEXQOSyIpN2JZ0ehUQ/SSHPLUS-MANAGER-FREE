#!/bin/bash
clear
IP=$(wget -qO- ipv4.icanhazip.com)
echo "America/Mexico_City" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Mexico_City /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1
clear
echo -e "\E[44;1;37m           PAINEL SSHPLUS v10           \E[0m"
echo ""
echo -e "                \033[1;31mATENCION"
echo ""
echo -e "\033[1;32mINFORME SIEMPRE LA MISMA CONTRASENA"
echo -e "\033[1;32mSIEMPRE CONFIRME LAS PREGUNTAS CON \033[1;37m Y"
echo ""
echo -e "\033[1;36mINICIANDO INSTALACION"
echo ""
echo -e "\033[1;33mESPERE..."
apt-get update > /dev/null 2>&1
echo ""
echo -e "\033[1;36mINSTALANDO APACHE2\033[0m"
echo ""
echo -e "\033[1;33mESPERE..."
apt-get install apache2 -y > /dev/null 2>&1
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart > /dev/null 2>&1
apt-get install cron curl unzip -y > /dev/null 2>&1
echo ""
echo -e "\033[1;36mINSTALANDO DEPENDENCIAS\033[0m"
echo ""
echo -e "\033[1;33mESPERE..."
apt-get install php5 libapache2-mod-php5 php5-mcrypt -y > /dev/null 2>&1
service apache2 restart 
echo ""
echo -e "\033[1;36mINSTALANDO MySQL\033[0m"
echo ""
sleep 1
apt-get install mysql-server -y 
echo ""
clear
echo -e "                \033[1;31mATENCION"
echo ""
echo -e "\033[1;32mINFORME SIEMPRE LA MISMA PASS CADA QUE SE LE SOLICITE"
echo -e "\033[1;32mSIEMPRE CONFIRME LAS PREGUNTAS CON  \033[1;37m Y"
echo ""
echo -ne "\033[1;33mEnter, Para Continuar!\033[1;37m"; read
mysql_install_db
mysql_secure_installation
clear
echo -e "\033[1;36mINSTALANDO PHPMYADMIN\033[0m"
echo ""
echo -e "\033[1;31mATENCION \033[1;33m!!!"
echo ""
echo -e "\033[1;32mSELECIONE LA OPCION \033[1;31mAPACHE2 \033[1;32mCON LA TECLA '\033[1;33mENTER\033[1;32m'"
echo ""
echo -e "\033[1;32mSELECIONE \033[1;31mYES\033[1;32m EN LA SIGUIENTE OPCION (\033[1;36mdbconfig-common\033[1;32m)"
echo -e "PARA CONFIGURAR LA BASE DE DATOS"
echo ""
echo -e "\033[1;32mSIEMPRE INTRODUZCA LA MISMA CONTRASENA"
echo ""
echo -ne "\033[1;33mEnter, Para Continuar!\033[1;37m"; read
apt-get install phpmyadmin -y
php5enmod mcrypt
service apache2 restart
ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
apt-get install libssh2-1-dev libssh2-php -y > /dev/null 2>&1
apt-get install php5-curl > /dev/null 2>&1
service apache2 restart
clear
echo ""
echo -e "\033[1;31mATENCION \033[1;33m!!!"
echo ""
echo -ne "\033[1;32mINTRODUZCA LA MISMA CONTRASENA\033[1;37m: "; read senha
echo -e "\033[1;32mOK\033[1;37m"
sleep 1
mysql -h localhost -u root -p$senha -e "CREATE DATABASE ssh"
clear
echo -e "\033[1;36mFINALIZANDO INSTALACION\033[0m"
echo ""
echo -e "\033[1;33mAGUARDE..."
echo ""
mkdir /var/www/html
cd /var/www/html
wget https://www.dropbox.com/s/2qp3zc5ec5mwv1m/painel10.zip > /dev/null 2>&1
sleep 1
unzip painel10.zip > /dev/null 2>&1
rm -rf painel10.zip index.html > /dev/null 2>&1
service apache2 restart
sleep 1
if [[ -e "/var/www/html/pages/system/pass.php" ]]; then
sed -i "s;suasenha;$senha;g" /var/www/html/pages/system/pass.php > /dev/null 2>&1
fi
sleep 1
cd
wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v10_2/ssh.sql > /dev/null 2>&1
sleep 1
if [[ -e "$HOME/plus.sql" ]]; then
    mysql -h localhost -u root -p$senha --default_character_set utf8 ssh < .sql
    rm /root/.sql
else
    clear
    echo -e "\033[1;31mERROR AL IMPORTAR BASE DE DATOS\033[0m"
    sleep 2
    exit
fi
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.php' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.ssh.php ' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.sms.php' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.online.ssh.php' >> /etc/crontab
echo '10 * * * * root /usr/bin/php /var/www/html/pages/system/cron.servidor.php' >> /etc/crontab
/etc/init.d/cron reload > /dev/null 2>&1
/etc/init.d/cron restart > /dev/null 2>&1
service apache2 restart
sleep 1
clear
echo -e "\033[1;32mPANEL INSTALADO CON EXITO!"
echo ""
echo -e "\033[1;36mLINK AREA DE ADMIN:\033[1;37m $IP:81/html/admin\033[0m"
echo -e "\033[1;36mLINK AREA DE REVENDEDOR: \033[1;37m $IP:81/html\033[0m"
echo -e "\033[1;36mUSUARIO\033[1;37m admin\033[0m"
echo -e "\033[1;36mCONTRASENA\033[1;37m admin\033[0m"
echo ""
echo -e "\033[1;36mINGRESE ESTE ENLACE EN LA VPS QUE SERA SERVIDOR\033[0m"
echo -e "\033[1;37mwget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v10/revenda/confpainel/inst && bash inst\033[0m"
echo -e "\033[1;33mCambie la contrasena una vez entrando al panel\033[0m"
cat /dev/null > ~/.bash_history && history -c