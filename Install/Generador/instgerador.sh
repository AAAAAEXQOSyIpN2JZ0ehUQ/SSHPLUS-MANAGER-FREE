#!/bin/bash
#====================================================
#
#  Modificaciones Al Codigo: illuminati Dev Team
#  https://t.me/AAAAAEXQOSyIpN2JZ0ehUQ
#
#====================================================
clear
[[ "$(whoami)" != "root" ]] && {
echo -e "\033[1;33m[\033[1;31mErro\033[1;33m] \033[1;37m- \033[1;33mvocê precisa executar como root\033[0m"
rm $HOME/instgerador.sh* > /dev/null 2>&1; exit 0
}
barra="\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

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

fun_attrepo () {
    apt-get update -y
    apt-get upgrade -y
}

fun_instrec () {
    apt-get install curl -y
    apt-get install zip -y
    apt-get install unzip -y
    apt-get install apache2 -y
}

fun_apalist () {
    sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
    service apache2 start
    service apache2 restart
    ## cp /var/www/html/index.html /var/www/html/index_back.html
}

fun_preparasis () {
    rm -rf /home/list
    rm -rf /home/index.html
    rm -rf /home/_script_$
    rm -rf /bin/keyssh
    rm -rf /bin/key
    rm -rf /bin/otimizar
    rm -rf /var/www/html/Index.php
    rm -rf /var/www/html/script
    rm -rf /var/www/html/scripts
    rm -rf /var/www/html/1:8%7o.2sg3-q:5
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
wget https://github.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/raw/master/Install/Generador/Install/sshplus-v38.zip
unzip sshplus-v38.zip
rm -rf sshplus-v38.zip
cd
}

fun_instsis () {
wget -O /home/list https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Generador/Modulos/list
wget -O /home/index.html https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Generador/Modulos/index.html
wget -O /bin/keyssh https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Generador/Modulos/keyssh
wget -O /bin/otimizar https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Generador/Modulos/otimizar
wget -O /var/www/html/scripts/Plus https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Generador/Modulos/Plus
wget -O /var/www/html/script/versao https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Generador/Modulos/versao
}

fun_permisoarq () {
    chmod +x  /home/list
    chmod +x  /home/index.html
    chmod +x  /bin/keyssh
    chmod +x  /bin/otimizar
    chmod +x /bin/key
    chmod +x  /var/www/html/Plus
    chmod +x  /var/www/html/script/versao
    chmod 777 /home/_script_$/crz/*
}

fun_montaip () {
fun_ip
sed -i "s;SEU-IP-AKI;$IP;g" /var/www/html/scripts/Plus
fun_ip
sed -i "s;SEU-IP-AKI;$IP;g" /home/list
fun_ip
sed -i "s;SEU-IP-AKI;$IP;g" /home/index.html
sleep 3s
}

fun_finconf () {
cat /home/index.html >/home/_script_$/index.html
cat /home/index.html >/home/_script_$/crz/index.html
cat /home/index.html >/var/www/html/script/index.html
cat /home/index.html >/var/www/html/scripts/index.html
}

clear
echo -e "$barra"
echo -e "       \033[1;33mINSTALADOR KEY SSHPLUS MANAGER !\033[0m"
echo -e "$barra"
echo ""
read -p "$(echo -e "\033[1;36mDESEJA CONTINUAR \033[1;31m? \033[1;33m[S/N]:\033[1;37m ")" -e -i s resp
[[ $resp = @(n|N) ]] && rm $HOME/instgerador.sh* && exit 0
echo
tput cuu1 && tput dl1
tput cuu1 && tput dl1
echo -e "\033[1;36mATUALIZANDO REPOSITÓRIOS..... \033[1;32mAGUARDE"
fun_bar 'fun_attrepo'
echo -e "\033[1;36mINSTALANDO RECURSOS.......... \033[1;32mAGUARDE"
fun_bar 'fun_instrec'
echo -e "\033[1;36mCONFIGURANDO APACHE.......... \033[1;32mAGUARDE"
fun_bar 'fun_apalist'
echo -e "\033[1;36mPREPARANDO SISTEMA........... \033[1;32mAGUARDE"
fun_bar 'fun_preparasis'
echo -e "\033[1;36mDONWLOAD SERVER.............. \033[1;32mAGUARDE"
fun_bar 'fun_downser'
echo -e "\033[1;36mINSTALANDO SISTEMA........... \033[1;32mAGUARDE"
fun_bar 'fun_instsis'
echo -e "\033[1;36mPERMISOS ARQUIVOS............ \033[1;32mAGUARDE"
fun_bar 'fun_permisoarq'
echo -e "\033[1;36mMONTANDO O SEU LINK-IP....... \033[1;32mAGUARDE"
fun_bar 'fun_montaip'
echo -e "\033[1;36mFINALIZANDO CONFIGURACION.... \033[1;32mAGUARDE"
fun_bar 'fun_finconf'
echo -e "$barra"
## echo -e " \033[1;36m> \033[1;37mPerfeito, Use o Comando \033[1;31mkeyssh / key "
## echo -e " \033[1;36m> \033[1;37mPara Gerenciar as Suas Keys e "
## echo -e " \033[1;36m> \033[1;37mAtualizar a Base do Servidor "
echo -e "\033[1;31m\033[1;33mCOMANDO PRINCIPAL: \033[1;32mkeyssh o key \033[0m"
echo -e "\033[1;33mMAIS INFORMACOES \033[1;31m(\033[1;36mTELEGRAM\033[1;31m): \033[0m"
echo -e "                     \033[1;37m@AAAAAEXQOSyIpN2JZ0ehUQ\033[0m"
echo -e "$barra"
rm $HOME/instgerador.sh* && cat /dev/null > ~/.bash_history && history -c
