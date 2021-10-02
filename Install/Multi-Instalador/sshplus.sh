#!/bin/bash
barra="\033[0m\e[34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
[[ ! -e /bin/mip ]] && echo "/root/sshplus.sh" > /bin/mip && chmod +x /bin/mip #ACCESO RAPIDO
fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} > /dev/null 2>&1
${comando[1]} > /dev/null 2>&1
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
IP=$(cat /etc/IP)
x="ok"
menu ()
{
#MANAGER SCRIPTS
sshplusfree () {
apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Plus; chmod 777 Plus; ./Plus
}
sshplusDEV () {
apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/SSHPlus-Dev/Plus; chmod 777 Plus; ./Plus
}
sshpluskey () {
apt-get update -y; apt-get upgrade -y; wget sshplus.xyz/script/Plus; chmod 777 Plus; ./Plus
}

#PAINEL WEB SCRIPTS
panel_v20 () {
wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v20/install > /dev/null 2>&1; chmod 777 install* && ./install*
}
panel_v23 () {
wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v23/install > /dev/null 2>&1; chmod +x install; ./install
}
panel_v23_2 () {
wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v23_2/install > /dev/null 2>&1; chmod +x install; ./install
}
panel_v25 () {
wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v25/install > /dev/null 2>&1; chmod +x install; ./install
}

#UPDATE VIP-VPS v23 a v25
panel_update2325 () {
wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v23_2/atu-v23-p-v25 > /dev/null 2>&1; chmod +x atu-v23-p-v25; ./atu-v23-p-v25
}

#PANEL WEB VERSIONES
panelwebversiones () {
apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/Panelweb.sh; chmod +x Panelweb.sh; ./Panelweb.sh
}

#GEYGEN SSHPLUS MANAGER
keyssh () {
apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Generador/instala_server; chmod 777 instala_server* && ./instala_server*
}

#TCP-SPEED
fun_tcpspeed () {
rm -rf $HOME/tcptweaker.sh* > /dev/null 2>&1; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/TCP-Speed/tcptweaker.sh > /dev/null 2>&1; chmod +x tcptweaker.sh; ./tcptweaker.sh
}

#OPCIONES DE SISTEMA
atualizar () {
echo ""
fun_bar "apt-get update -y"
fun_bar "apt-get upgrade -y"
fun_bar "service ssh restart"
rm -rf $HOME/sshplus.sh* > /dev/null 2>&1; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Multi-Instalador/sshplus.sh > /dev/null 2>&1
echo ""
echo -e "\033[1;33m UPDATE COM SUCESSO -\033[1;32m OK !\033[1;37m"
sleep 4s
chmod +x sshplus.sh; ./sshplus.sh
}
remove_multiscripts () {
rm -rf $HOME/sshplus.sh* && rm -rf /bin/mis
}

while true $x != "ok"
do
_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
_usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
clear
echo -e "$barra"
echo -e "\E[41;1;37mMULTI-INTALADOR PLUS              \033[1;32m[\033[1;37m VERSAO: r021 \033[1;32m]\E[0m"
echo -e "$barra"
echo -e "\033[1;31m[\033[1;36m01\033[1;31m] \033[1;33mSSHPLUS MANAGER FREE           \033[1;32m(FREE) \033[37m∆ "
echo -e "\033[1;31m[\033[1;36m02\033[1;31m] \033[1;33mSSHPLUS MANAGER OFICIAL-DEV    \033[1;32m(FREE) "
echo -e "\033[1;31m[\033[1;36m03\033[1;31m] \033[1;33mSSHPLUS MANAGER OFICIAL        \033[1;31m(KEYS) "
echo -e "$barra"
echo -e "\033[1;31m[\033[1;36m04\033[1;31m] \033[1;33mPAINEL SSHPLUS WEB V.20        \033[1;32m(FREE) \033[37m∆ "
echo -e "\033[1;31m[\033[1;36m05\033[1;31m] \033[1;33mPAINEL VIP-VPS WEB V.23        \033[1;32m(FREE) \033[37m∆ "
echo -e "\033[1;31m[\033[1;36m06\033[1;31m] \033[1;33mPAINEL VIP-VPS WEB V.25        \033[1;32m(FREE) \033[37m∆ "
echo -e "$barra"
echo -e "\033[1;31m[\033[1;36m07\033[1;31m] \033[1;33mUPDATE VIP-VPS V.23 PARA V25   \033[1;32m(FREE) "
echo -e "\033[1;31m[\033[1;36m08\033[1;31m] \033[1;33mPAINEL SSHPLUS WEB (VERSIONES) \033[1;32m(FREE) "
echo -e "\033[1;31m[\033[1;36m09\033[1;31m] \033[1;33mGENERADOR KEY SSHPLUS MANAGER  \033[1;32m(FREE) "
echo -e "\033[1;31m[\033[1;36m10\033[1;31m] \033[1;33mTCP-TWEAKER-1.0 (TCP-SPEED)    \033[1;32m(FREE) " 
echo -e "$barra"
echo -e "\033[1;31m[\033[1;36m11\033[1;31m] \033[1;35m[!] \033[1;32mACTUALIZAR                \033[1;31mRam:\033[1;37m $_usor "
echo -e "\033[1;31m[\033[1;36m12\033[1;31m] \033[1;35m[!] \033[1;31mDESINSTALAR \033[1;35m[\033[1;37m MIP \033[1;35m]       \033[1;31mNucleo:\033[1;37m $_usop "
echo -e "\033[1;31m[\033[1;36m00\033[1;31m] \033[1;37mSALIR \033[1;32m<\033[1;33m<\033[1;31m<                     \033[1;37m@admmanagerfree\033[0m \033[0m"
echo -e "$barra"
echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;31m?\033[1;37m : "; read x

case "$x" in 
1 | 01)
clear
sshplusfree
exit;
;;
2 | 02)
clear
sshplusDEV
exit;
;;
3 | 03)
clear
sshpluskey
exit;
;;
4 | 04)
clear
panel_v20
exit;
;;
5 | 05)
clear
panel_v23_2
exit;
;;     
6 | 06)
clear
panel_v25
exit;
;;     
7 | 07)
clear
panel_update2325
exit;
;;
8 | 08)
clear
panelwebversiones
exit;
;;
9 | 09)
clear
keyssh
exit;
;;
10)
clear
fun_tcpspeed
exit;
;;
11)
clear
atualizar
exit;
;;
12)
clear
remove_multiscripts
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
esac
done
}
menu
#fim