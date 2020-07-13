#!/bin/bash
barra="\033[0m\e[34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

fun_prog ()
{
	comando[0]="$1" 
    ${comando[0]}  > /dev/null 2>&1 & 
	tput civis
	echo -ne "\033[1;32m.\033[1;33m.\033[1;31m. \033[1;32m"
    while [ -d /proc/$! ]
	do
		for i in / - \\ \|
		do
			sleep .1
			echo -ne "\e[1D$i"
		done
	done
	tput cnorm
	echo -e "\e[1DOK"
}

fun_update () {
    sudo apt-get update -y
}

fun_upgrade () {
    sudo apt-get upgrade -y
}

##PANIL A INSTALAR
panel_v10 () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v10/Painel.sh > /dev/null 2>&1; chmod +x Painel.sh; ./Painel.sh
}
panel_v10_2 () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v10_2/install.sh > /dev/null 2>&1; chmod +x install.sh; ./install.sh
}
panel_v11 () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v11/Painelv11.sh > /dev/null 2>&1; chmod +x Painelv11.sh; ./Painelv11.sh
}
panel_v11_2 () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v11_2/install > /dev/null 2>&1; chmod +x install; ./install
}
panel_v12 () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v12/install > /dev/null 2>&1; chmod +x install; ./install
}
panel_v15 () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v15/install > /dev/null 2>&1; chmod +x install; ./install
}
panel_v15_2 () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v15_2/ocspanel > /dev/null 2>&1; chmod +x ocspanel; ./ocspanel
}
panel_v20 () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v20/install > /dev/null 2>&1; chmod +x install; ./install
}
panel_v20_mod () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v20_mod/install > /dev/null 2>&1; chmod +x install; ./install
}
panel_v23 () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v23/install > /dev/null 2>&1; chmod +x install; ./install
}
panel_v25 () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v25/install > /dev/null 2>&1; chmod +x install; install
}

##PANIL REMOVE
remove_panel () {
clear
echo -e "$barra"
echo -e "\033[1;32m SIEMPRE CONFIRME LAS PREGUNTAS CON LA LETRA \033[1;37mY"
echo -e "\033[1;32m CUANDO SE REQUIERA SOLO PROSIGA CON \033[1;37mENTER"
echo -e "$barra"
sleep 7
sudo service apache2 stop
sudo apt-get purge mysql-server mysql-client mysql-common mysql-server-core-* mysql-client-core-*
sudo rm -rf /etc/mysql /var/lib/mysql
sudo rm -rf /var/www/html
sudo apt-get autoremove
sudo apt-get autoclean
apt-get install apache2 -y &>/dev/null
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart > /dev/null 2>&1
sudo service apache2 stop
[[ ! -d /var/www ]] && mkdir /var/www
[[ ! -d /var/www/html ]] && mkdir /var/www/html
echo -e "$barra"
echo -e "\033[1;36mPANEL SSHPLUS ELIMINADO CON EXITO \033[1;32m[!OK]"
echo -e "$barra"
}

while true $x != "ok"
do
clear
[[ ! -d /var/www ]] && mkdir /var/www
[[ ! -d /var/www/html ]] && mkdir /var/www/html
echo -e "$barra"
echo -e "\E[41;1;37m        ⇱ INSTALAR O PAINEL SSH/DROP/SSL ⇲        \E[0m"
echo -e "$barra"
echo -e "\033[1;32mATUALIZANDO SISTEMA \033[0m"
echo -ne "\033[1;33m[\033[1;31m ! \033[1;33m] \033[1;31mapt-get update "; fun_prog 'fun_update'
echo -ne "\033[1;33m[\033[1;31m ! \033[1;33m] \033[1;31mapt-get upgrade "; fun_prog 'fun_upgrade'
echo -e "$barra"
echo -e "\033[1;31m[\033[1;36m01\033[1;31m] \033[1;37m• \033[1;33mPANEL SSHPLUS WEB V10      \033[1;31m(ANT) 
\033[1;31m[\033[1;36m02\033[1;31m] \033[1;37m• \033[1;33mPANEL SSHPLUS WEB V10 2    \033[1;32m(DAN) 
\033[1;31m[\033[1;36m03\033[1;31m] \033[1;37m• \033[1;33mPANEL SSHPLUS WEB V11      \033[1;31m(ANT) 
\033[1;31m[\033[1;36m04\033[1;31m] \033[1;37m• \033[1;33mPANEL SSHPLUS WEB V11 2    \033[1;32m(NEW) 
\033[1;31m[\033[1;36m05\033[1;31m] \033[1;37m• \033[1;33mPANEL SSHPLUS WEB V12      \033[1;32m(NEW) 
\033[1;31m[\033[1;36m06\033[1;31m] \033[1;37m• \033[1;33mPANEL SSHPLUS WEB V15      \033[1;31m(ANT) 
\033[1;31m[\033[1;36m07\033[1;31m] \033[1;37m• \033[1;33mPANEL SSHPLUS WEB V15 2    \033[1;33m(OCS)
\033[1;31m[\033[1;36m08\033[1;31m] \033[1;37m• \033[1;33mPANEL SSHPLUS WEB V20      \033[1;32m(NEW)
\033[1;31m[\033[1;36m09\033[1;31m] \033[1;37m• \033[1;33mPANEL SSHPLUS WEB V20 MOD  \033[1;32m(NEW) \033[1;36m•
\033[1;31m[\033[1;36m10\033[1;31m] \033[1;37m• \033[1;33mPANEL SSHPLUS WEB V23      \033[1;32m(NEW) 
\033[1;31m[\033[1;36m11\033[1;31m] \033[1;37m• \033[1;33mPANEL SSHPLUS WEB V25      \033[1;35m(ADE) 
\033[1;31m[\033[1;36m12\033[1;31m] \033[1;37m• \033[1;33mPANEL REMOVE 
\033[1;31m[\033[1;36m00\033[1;31m] \033[1;37m• \033[1;33mSALIR \033[1;32m<\033[1;33m<\033[1;31m<\033[0m \033[0m"
echo -e "$barra"
echo ""
echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;31m?\033[1;37m : "; read x

case "$x" in 
   1 | 01)
   clear
   panel_v10
   exit;
   ;;
   2 | 02)
   clear
   panel_v10_2
   exit;
   ;;
   3 | 03)
   clear
   panel_v11
   exit;
   ;;
   4 | 04)
   clear
   panel_v11_2
   exit;
   ;;      
   5 | 05)
   clear
   panel_v12
   exit;
   ;;
   6 | 06)
   clear
   panel_v15
   exit;
   ;; 
   7 | 07)
   clear
   panel_v15_2
   exit;
   ;;
   8 | 08)
   clear
   panel_v20
   exit;
   ;;     
   9 | 09)
   clear
   panel_v20_mod
   exit;
   ;;
   10)
   clear
   panel_v23
   exit;
   ;;
   11)
   clear
   panel_v25
   exit;
   ;;
   12)
   clear
   remove_panel
   exit;
   ;;
   0 | 00)
   echo -e "\033[1;31mSaindo...\033[0m"
   sleep 2
   clear
   exit;
   ;;
   *)
   echo -e "\n\033[1;31mOpcao invalida !\033[0m"
   sleep 2
esac
done
}
#fim