#!/bin/bash
#====================================================
#	SCRIPT: MULTI SCRIPTS MANAGER
#   DATA ATT:   01 de Feb 2021
#	DESENVOLVIDO POR:	TEAM ILLUMINATI
#	COLABORADOR:	        JONY RIVERA
#	CONTATO TELEGRAM:	NO DISPONIBLE
#	CANAL TELEGRAM:	https://t.me/admmanagerfree
#====================================================
barra="\033[0m\e[34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo "/root/vipvps.sh" > /bin/vipvps && chmod +x /bin/vipvps > /dev/null 2>&1


##MANAGER SCRIPTS

sshplusvipvps () {
    apt-get update -y; apt-get upgrade -y; wget -O $HOME/Plus http://painelweb.tk/vipssh/sshplus.sh; chmod 777 Plus; ./Plus
}

##PAINEL WEB SCRIPTS

panel_v15 () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v11/Painelv11.sh > /dev/null 2>&1; chmod +x Painelv11.sh; ./Painelv11.sh
}
panel_v23 () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v11_2/install > /dev/null 2>&1; chmod +x install; ./install
}
panel_v25 () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v12/install > /dev/null 2>&1; chmod +x install; ./install
}

##OPCIONES DE SISTEMA

atualizar () {
    rm -rf $HOME/sshplus.sh; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Multi-Instalador/sshplus.sh; chmod +x sshplus.sh; ./sshplus.sh
}
remove_multiscripts () {
    rm -rf $HOME/vipvps.sh && rm -rf /bin/vipvps
}

##MENU
_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
_usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")

while true $x != "ok"
do
clear
echo -e "$barra"
echo -e "\E[41;1;37mMULTI-INTALADOR VIP-VPS           \033[1;32m[\033[1;37m VERSAO: r000 \033[1;32m]\E[0m"
echo -e "$barra"
echo -e "
\033[1;31m[\033[1;36m03\033[1;31m] \033[1;33mVIP-VPS MANAGER                \033[1;32m(FREE) 
\033[1;31m[\033[1;36m06\033[1;31m] \033[1;33mPAINEL VIP-VPS V.15            \033[1;32m(FREE) 
\033[1;31m[\033[1;36m08\033[1;31m] \033[1;33mPAINEL VIP-VPS V.23            \033[1;32m(FREE) 
\033[1;31m[\033[1;36m09\033[1;31m] \033[1;33mPAINEL VIP-VPS V.25            \033[1;32m(FREE) 
\033[0m\e[34m--------------------------------------------------
\033[1;31m[\033[1;36m11\033[1;31m] \033[1;35m[!] \033[1;32mACTUALIZAR                \033[1;31mRam:\033[1;37m $_usor
\033[1;31m[\033[1;36m12\033[1;31m] \033[1;35m[!] \033[1;31mDESINSTALAR \033[1;35m[\033[1;37m VIP-VPS \033[1;35m]   \033[1;31mNucleo:\033[1;37m $_usop
\033[1;31m[\033[1;36m00\033[1;31m] \033[1;37mSALIR \033[1;32m<\033[1;33m<\033[1;31m<                     \033[1;37m@admmanagerfree\033[0m \033[0m"
echo -e "$barra"
echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;31m?\033[1;37m : "; read x

case "$x" in 
   1 | 01)
   clear
   sshplusvipvps
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
   0 | 00)
   echo -e "\033[1;31mSaindo...\033[0m"
   sleep 2
   clear
   exit;
   ;;
   *)
   echo -e "\n\033[1;31mOpcao invalida !\033[0m"
   ./vipvps.sh
esac
done
}
#fim