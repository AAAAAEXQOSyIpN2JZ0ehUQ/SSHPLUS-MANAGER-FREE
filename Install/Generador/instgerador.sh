#!/bin/bash

#====================================================
#
#  Modificaciones Al Codigo: illuminati Dev Team
#  https://t.me/AAAAAEXQOSyIpN2JZ0ehUQ
#
#====================================================

[[ "$(whoami)" != "root" ]] && {
echo -e "\033[1;33m[\033[1;31mErro\033[1;33m] \033[1;37m- \033[1;33mvocê precisa executar como root\033[0m"
rm $HOME/instgerador.sh* > /dev/null 2>&1; exit 0
}

cd $HOME
fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 1s
   tput cuu1
   tput dl1
   echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}

fun_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}

fun_attlist () {
    apt-get update -y
    apt-get upgrade -y
}

inst_pct () {
_pacotes=("curl" "screen" "zip" "unzip" "apache2")
for _prog in ${_pacotes[@]}; do
    apt install $_prog -y
done
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 start
service apache2 restart
}

fun_dirconfig () {
    rm -rf /home/list
    rm -rf /home/index.html
    rm -rf /home/_script_$
    rm -rf /home/PlusKeygen-Active
    rm -rf /bin/keyssh
    rm -rf /bin/key
    rm -rf /var/www/html/Index.php
    rm -rf /var/www/html/script
    rm -rf /var/www/html/scripts
    mkdir /home/keyssh
    mkdir /home/_script_$
    mkdir /home/_script_$/crz
    mkdir /var/www/html/script
    mkdir /var/www/html/scripts
    echo "/bin/keyssh" > /bin/key 
}

fun_downser () {
cd
cd /home/_script_$/crz
wget https://github.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/raw/master/Install/Generador/Modulos/sshplus-v38.zip
unzip sshplus-v38.zip
rm -rf sshplus-v38.zip
cd
}

fun_instarq () {
wget -O /home/list https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Generador/Modulos/list
wget -O /home/index.html https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Generador/Modulos/index.html
wget -O /bin/keyssh https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Generador/Modulos/keyssh
wget -O /var/www/html/scripts/Plus https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Generador/Modulos/Plus
wget -O /var/www/html/script/versao https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Generador/Modulos/versao
}

fun_permarq () {
    chmod +x /home/list
    chmod +x /home/index.html
    chmod +x /bin/keyssh
    chmod +x /bin/key
    chmod +x /var/www/html/Plus
    chmod +x /var/www/html/script/versao
    chmod 777 /home/_script_$/crz/*
}

fun_montaip () {
fun_ip
sed -i "s;SEU-IP-AKI;$IP;g" /var/www/html/scripts/Plus
fun_ip
sed -i "s;SEU-IP-AKI;$IP;g" /home/list
sleep 3s
}

fun_index () {
cat /home/index.html >/home/_script_$/index.html
cat /home/index.html >/home/_script_$/crz/index.html
cat /home/index.html >/var/www/html/script/index.html
cat /home/index.html >/var/www/html/scripts/index.html
}

clear
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%40s%s%-12s\n' "BEM VINDO AO SSHPLUS KEYGEN " ; tput sgr0
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo ""
read -p "$(echo -e "\033[1;36mDESEJA CONTINUAR \033[1;31m? \033[1;33m[S/N]:\033[1;37m ")" -e -i s resp
[[ $resp = @(n|N) ]] && rm $HOME/instgerador.sh* && exit 0
echo ""
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo ""
echo -e "\033[1;32m [!] Atualizando sistema \033[0m"
fun_bar 'fun_pct'
echo -e "\033[1;32m [!] Atualizando pacotes \033[0m"
fun_bar 'attlist'
echo -e "\033[1;32m [!] Configurando Directorios \033[0m"
fun_bar 'fun_dirconfig'
echo -e "\033[1;32m [!] Donwload servidor \033[0m"
fun_bar 'fun_downser'
echo -e "\033[1;32m [!] Instalando arquivos \033[0m"
fun_bar 'fun_instarq'
echo -e "\033[1;32m [!] Permiso arquivos \033[0m"
fun_bar 'fun_permarq'
echo -e "\033[1;32m [!] Montando o seu Link-IP \033[0m"
fun_bar 'fun_montaip'
echo -e "\033[1;32m [!] Finalizando configuracion \033[0m"
fun_bar 'fun_index'
echo ""
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e "\033[1;31m\033[1;33mCOMANDO PRINCIPAL: \033[1;32mkeyssh o key \033[0m"
echo -e "\033[1;33mMAIS INFORMACOES \033[1;31m(\033[1;36mTELEGRAM\033[1;31m): \033[0m"
echo -e "                     \033[1;37m@AAAAAEXQOSyIpN2JZ0ehUQ\033[0m"
echo ""

rm $HOME/instgerador* #&& cat /dev/null > ~/.bash_history && history -c
