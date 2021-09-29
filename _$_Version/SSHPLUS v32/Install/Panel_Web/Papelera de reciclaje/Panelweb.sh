#!/bin/bash
barra="\033[0m\e[34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

fun_bar () {
comando="$1"
 _=$(
$comando > /dev/null 2>&1
) & > /dev/null
pid=$!
while [[ -d /proc/$pid ]]; do
echo -ne " \033[1;33m["
   for((i=0; i<10; i++)); do
   echo -ne "\033[1;31m##"
   sleep 0.2
   done
echo -ne "\033[1;33m]"
sleep 1s
echo
tput cuu1 && tput dl1
done
echo -e " \033[1;33m[\033[1;31m####################\033[1;33m] - \033[1;32m100%\033[0m"
sleep 1s
}

panel_v10 () {
clear
IP=$(wget -qO- ipv4.icanhazip.com)
echo "America/Mexico_City" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Mexico_City /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1
clear
echo -e "\E[44;1;37m           PANEL SSHPLUS WEB v10           \E[0m"
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
mysql -h localhost -u root -p$senha -e "CREATE DATABASE plus"
clear
echo -e "\033[1;36mFINALIZANDO INSTALACION\033[0m"
echo ""
echo -e "\033[1;33mAGUARDE..."
echo ""
mkdir /var/www/html
cd /var/www/html
wget https://github.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/blob/master/Install/Panel_Web/panel_v10/painel10.zip > /dev/null 2>&1
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
wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v10/plus.sql > /dev/null 2>&1
sleep 1
if [[ -e "$HOME/plus.sql" ]]; then
    mysql -h localhost -u root -p$senha --default_character_set utf8 plus < plus.sql
    rm /root/plus.sql
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
chmod 777 /var/www/html/admin/pages/servidor/ovpn
chmod 777 /var/www/html/admin/pages/download
chmod 777 /var/www/html/admin/pages/faturas/comprovantes
service apache2 restart
sleep 1
clear
echo -e "\033[1;32mPANEL INSTALADO CON EXITO!"
echo ""
echo -e "\033[1;36mLINK AREA DE ADMIN:\033[1;37m $IP:81/admin\033[0m"
echo -e "\033[1;36mLINK AREA DE REVENDEDOR: \033[1;37m $IP:81\033[0m"
echo -e "\033[1;36mUSUARIO\033[1;37m admin\033[0m"
echo -e "\033[1;36mCONTRASENA\033[1;37m admin\033[0m"
echo ""

echo -e "\033[1;36mINGRESE ESTE ENLACE EN LA VPS QUE SERA SERVIDOR\033[0m"
echo -e "\033[1;37mwget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v10/revenda/confpainel/inst > /dev/null 2>&1; bash inst\033[0m"


echo -e "\033[1;33mCambie la contrasena una vez entrando al panel\033[0m"
cat /dev/null > ~/.bash_history && history -c
}

panel_v11 () {
clear
IP=$(wget -qO- ipv4.icanhazip.com)
echo "America/Mexico_City" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Mexico_City /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1
clear
echo -e "\E[44;1;37m           PANEL SSHPLUS WEB v11          \E[0m"
echo ""
echo ""
echo -e "                \033[1;31mATENCION"
echo ""
echo -e "\033[1;32mINTRODUZCA LA MISMA PASS CADA QUE SE LE SOLICITE"
echo -e "\033[1;32mSIEMPRE CONFIRME LAS PREGUNTAS CON \033[1;37m Y"
echo ""
echo -e "\033[1;36mINICIANDO INSTALACION"
echo ""
echo -e "\033[1;33mESPERE..."
apt-get update > /dev/null 2>&1
echo ""
echo -e "\033[1;36mINSTALANDO O APACHE2\033[0m"
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
echo -e "\033[1;36mINSTALANDO O MySQL\033[0m"
echo ""
sleep 1
apt-get install mysql-server -y 
echo ""
clear
echo -e "                \033[1;31mATENCION"
echo ""
echo -e "\033[1;32mINTRODUZCA LA MISMA CONTRASENA CADA QUE SE LE SOLICITE"
echo -e "\033[1;32mSIEMPRE CONFIRME LAS PREGUNTAS CON \033[1;37m Y"
echo ""
echo -ne "\033[1;33mEnter, Para Continuiar!\033[1;37m"; read
mysql_install_db
mysql_secure_installation
clear
echo -e "\033[1;36mINSTALANDO PHPMYADMIN\033[0m"
echo ""
echo -e "\033[1;31mATENCION \033[1;33m!!!"
echo ""
echo -e "\033[1;32mSELECIONE LA OPCION \033[1;31mAPACHE2 \033[1;32mCON A TECLA '\033[1;33mENTER\033[1;32m'"
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
echo -e "\033[1;31mATENĂ‡ION \033[1;33m!!!"
echo ""
echo -ne "\033[1;32mINFORME LA MISMA CONTRASENA\033[1;37m: "; read senha
echo -e "\033[1;32mOK\033[1;37m"
sleep 1
mysql -h localhost -u root -p$senha -e "CREATE DATABASE sshplus"
clear
echo -e "\033[1;36mFINALIZANDO INSTALACION\033[0m"
echo ""
echo -e "\033[1;33mESPERE..."
echo ""
mkdir /var/www/html
cd /var/www/html
wget https://github.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/blob/master/Install/Panel_Web/panel_v11/PAINELWEB1.zip > /dev/null 2>&1
sleep 1
unzip PAINELWEB1.zip > /dev/null 2>&1
rm -rf PAINELWEB1.zip index.html > /dev/null 2>&1
service apache2 restart
sleep 1
if [[ -e "/var/www/html/pages/system/pass.php" ]]; then
sed -i "s;suasenha;$senha;g" /var/www/html/pages/system/pass.php > /dev/null 2>&1
fi
sleep 1
cd
wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v11/sshplus.sql > /dev/null 2>&1
sleep 1
if [[ -e "$HOME/sshplus.sql" ]]; then
    mysql -h localhost -u root -p$senha --default_character_set utf8 sshplus < sshplus.sql
    #rm /root/sshplus.sql
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
chmod 777 /var/www/html/admin/pages/servidor/ovpn
chmod 777 /var/www/html/admin/pages/download
chmod 777 /var/www/html/admin/pages/faturas/comprovantes
service apache2 restart
sleep 1
clear
echo -e "\033[1;32mPAINEL INSTALADO CON EXITO!"
echo ""
echo -e "\033[1;36mLINK AREA ADMIN:\033[1;37m $IP:81/admin\033[0m"
echo -e "\033[1;36mLINK AREA REVENDA: \033[1;37m $IP:81\033[0m"
echo -e "\033[1;36mUSUARIO\033[1;37m admin\033[0m"
echo -e "\033[1;36mCONTRASENA\033[1;37m admin\033[0m"
echo -e "\033[1;33mCambie la contrasena cuando logre entrar al panel\033[0m"
cat /dev/null > ~/.bash_history && history -c
}

panel_v15 () {
clear
IP=$(wget -qO- ipv4.icanhazip.com)
echo "America/Sao_Paulo" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1

cd
clear
echo -e "\E[44;1;37m    INSTALAR O PAINEL SSH/DROP/SSL V.15    \E[0m"
echo ""
echo -e "                \033[1;31mATENCAO"
echo ""
echo -e "\033[1;32m INFORME SEMPRE A MESMA SENHA"
echo -e "\033[1;32m SEMPRE COMFIME AS QUESTOES COM\033[1;37m Y"
echo ""
echo -e "\033[1;36m INICIANDO INSTALACAO"
echo ""
echo -e "\033[1;33m AGUARDE..."
apt-get update > /dev/null 2>&1
echo ""
echo -e "\033[1;36m INSTALANDO O APACHE2\033[0m"
echo ""
echo -e "\033[1;33m AGUARDE..."
apt-get install apache2 -y > /dev/null 2>&1
apt-get install cron curl zip unzip -y > /dev/null 2>&1
echo ""
echo -e "\033[1;36m INSTALANDO DEPENDENCIAS\033[0m"
echo ""
echo -e "\033[1;33m AGUARDE..."
apt-get install php5 libapache2-mod-php5 php5-mcrypt -y > /dev/null 2>&1 php5_invoke
service apache2 restart 
echo ""
echo -e "\033[1;36m INSTALANDO O MySQL\033[0m"
echo ""
sleep 1
apt-get install mariadb-server mariadb-client -y
echo ""
clear

echo -e "                \033[1;31m ATENCAO"
echo ""
echo -e "\033[1;32m INFORME SEMPRE A MESMA SENHA QUANDO PEDIR"
echo ""
echo -e "\033[1;32m NESTE ,Enter current password for root (enter for none): colaca\033[1;37m a senha que vc criou"
echo ""
echo -e "\033[1;32m NESTE AKI ,Set root password? [Y/n] colaca\033[1;37m n"
echo ""
echo -e "\033[1;32m NAS DEMAIS COMFIME AS QUESTOES COM\033[1;37m Y"
echo ""
echo -ne "\033[1;33m Enter, Para Prosseguir!\033[1;37m"; read
mysql_secure_installation
clear
echo -e "\033[1;36m INSTALANDO O PHPMYADMIN\033[0m"
echo ""
echo -e "\033[1;31m ATENCAO \033[1;33m!!!"
echo ""
echo -e "\033[1;32m SELECIONE A OPCAO \033[1;31mAPACHE2 \033[1;32mCOM A TECLA '\033[1;33mESPACO\033[1;32m'"
echo ""
echo -e "\033[1;32m SELECIONE \033[1;31mYES\033[1;32m NA OPCAO A SEGUIR (\033[1;36mdbconfig-common\033[1;32m)"
echo -e "PARA CONFIGURAR O BANCO DE DADOS"
echo ""
echo -e "\033[1;32m LEMBRE-SE INFORME A MESMA SENHA QUANDO SOLICITADO"
echo ""
echo -ne "\033[1;33m Enter, Para Prosseguir!\033[1;37m"; read
apt-get install phpmyadmin -y
php5enmod mcrypt
service apache2 restart
ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
apt-get install libssh2-1-dev libssh2-php -y > /dev/null 2>&1
if [ "$(php -m |grep ssh2)" = "ssh2" ]; then
  true
else
  clear
  echo -e "\033[1;31m ERRO CRITICO\033[0m"
  rm $HOME/inst
  exit
fi
apt-get install php5-curl > /dev/null 2>&1
service apache2 restart
clear
echo ""
echo -e "\033[1;31m ATENCAO \033[1;33m!!!"
echo ""
echo -ne "\033[1;32m INFORME A MESMA SENHA\033[1;37m: "; read senha
echo -e "\033[1;32mOK\033[1;37m"
sleep 1
mysql -h localhost -u root -p$senha -e "CREATE DATABASE sshplus"
clear
echo -e "\033[1;36m FINALIZANDO INSTALACAO\033[0m"
echo ""
echo -e "\033[1;33m AGUARDE..."
echo ""
cd /var/www/html
wget https://www.dropbox.com/s/ob4vsk0ds2ugt3u/painel15.zip > /dev/null 2>&1
sleep 1
unzip painel15.zip > /dev/null 2>&1
rm -rf painel15.zip index.html > /dev/null 2>&1
service apache2 restart
sleep 1
if [[ -e "/var/www/html/pages/system/pass.php" ]]; then
sed -i "s;sua_senha;$senha;g" /var/www/html/pages/system/pass.php > /dev/null 2>&1
fi
sleep 1
cd
wget https://www.dropbox.com/s/gsspnct1y815ugm/bd-v15.sql > /dev/null 2>&1
sleep 1
if [[ -e "$HOME/bd-v15.sql" ]]; then
    mysql -h localhost -u root -p$senha --default_character_set utf8 sshplus < bd-v15.sql
    rm /root/bd-v15.sql
else
    clear
    echo -e "\033[1;31m ERRO AO IMPORTAR BANCO DE DADOS\033[0m"
    sleep 2
    rm /root/inst > /dev/null 2>&1
    exit
fi
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.php' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.ssh.php ' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.sms.php' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.online.ssh.php' >> /etc/crontab
echo '10 * * * * root /usr/bin/php /var/www/html/pages/system/cron.servidor.php' >> /etc/crontab
echo '*/30 * * * * root /usr/bin/php /var/www/html/pages/system/cron.limpeza.php' >> /etc/crontab
echo '0 */12 * * * root cd /var/www/html/pages/system/ && bash cron.backup.sh && cd /root' >> /etc/crontab
echo '5 */12 * * * root cd /var/www/html/pages/system/ && /usr/bin/php cron.backup.php && cd /root' >> /etc/crontab
/etc/init.d/cron reload > /dev/null 2>&1
/etc/init.d/cron restart > /dev/null 2>&1
chmod 777 /var/www/html/admin/pages/servidor/ovpn
chmod 777 /var/www/html/admin/pages/download
chmod 777 /var/www/html/admin/pages/faturas/comprovantes
service apache2 restart
sleep 1
service apache2 restart
clear
echo -e "\033[1;32m PAINEL INSTALADO COM SUCESSO!"
echo ""
echo -e "\033[1;36m SEU PAINEL\033[1;37m http://$IP/admin\033[0m"
echo -e "\033[1;36m USUARIO\033[1;37m admin\033[0m"
echo -e "\033[1;36m SENHA\033[1;37m admin\033[0m"
echo ""
echo -e "\033[1;33m Altere a senha quando logar no painel!\033[0m"
cat /dev/null > ~/.bash_history && history -c
rm /root/inst > /dev/null 2>&1
service apache2 restart
}

remove_panel () {
clear
echo -e "$barra"
echo -e "\033[1;32m SIEMPRE CONFIRME LAS PREGUNTAS CON LA LETRA \033[1;37mY"
echo -e "\033[1;32m CUANDO SE REQUIERA SOLO PROSIGA CON \033[1;37mENTER"
echo -e "$barra"
sleep 7
sudo apt-get purge mysql-server mysql-client mysql-common mysql-server-core-* mysql-client-core-*
sudo rm -rf /etc/mysql /var/lib/mysql
sudo apt-get autoremove
sudo apt-get autoclean
sudo rm -rf /var/www/html
mkdir /var/www/html
touch /var/www/html/index.html
apt-get install apache2  > /dev/null 2>&1
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart > /dev/null 2>&1
echo -e "$barra"
echo -e "\033[1;36mPANEL SSHPLUS ELIMINADO CON EXITO \033[1;32m[!OK]"
echo -e "$barra"
}

clear
echo -e "$barra"
echo -e "\E[41;1;37m        ⇱ INSTALAR O PAINEL SSH/DROP/SSL ⇲        \E[0m"
echo -e "$barra"
echo -e "\033[1;32mACTUALIZANDO PAQUETES"
echo -e ""
fun_bar "sudo apt-get update -y"
fun_bar "sudo apt-get upgrade -y"
echo -e "$barra"
while true; do
echo -e "\033[1;31m[\033[1;36m1\033[1;31m] \033[1;37m• \033[1;33mPANEL SSHPLUS WEB V10 \033[1;31m"
echo -e "\033[1;31m[\033[1;36m2\033[1;31m] \033[1;37m• \033[1;33mPANEL SSHPLUS WEB V11 \033[1;31m"
echo -e "\033[1;31m[\033[1;36m3\033[1;31m] \033[1;37m• \033[1;33mPANEL SSHPLUS WEB V15 \033[1;31m"
echo -e "\033[1;31m[\033[1;36m4\033[1;31m] \033[1;37m• \033[1;33mELIMINAR PANEL SSHPLUS \033[1;31m"
echo -e "\033[1;31m[\033[1;36m0\033[1;31m] \033[1;37m• \033[1;32mVOLTAR \n${barra}"
while [[ ${opx} != @(0|[1-4]) ]]; do
echo -ne "\033[1;32mQUE QUIERES HACER\033[1;33m?\033[1;31m?\033[1;37m : " && read opx
tput cuu1 && tput dl1
done
case $opx in
	0)
	return;;
	1)
	panel_v10
	break;;
	2)
	panel_v11
	break;;
	3)
	panel_v15
	break;;
	4)
	remove_panel
	break;;
esac
done
}
#fim