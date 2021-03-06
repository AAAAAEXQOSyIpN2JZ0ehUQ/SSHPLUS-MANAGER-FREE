#!/bin/bash
barra="\033[0m\e[34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo "/root/Panelweb.sh" > /bin/ipw && chmod +x /bin/ipw > /dev/null 2>&1

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

##PANIL REMOVE
remove_panel () {
clear
echo -e "$barra"
echo -e "\033[1;36mDESINTALAR PANEL WEB"
echo -e "$barra"
echo -ne "\033[1;37mDesinstalar MySQL [N/S]: \033[1;37m"; read x
[[ $x = @(n|N) ]] && exit
sudo apt-get purge mysql-server mysql-client mysql-common mysql-server-core-* mysql-client-core-*
sudo rm -rf /etc/mysql /var/lib/mysql
sudo apt-get autoremove
sudo apt-get autoclean
sudo rm -rf /var/lib/mysql
service apache2 restart
echo -e "$barra"
echo -e "\033[1;36mPANEL ELIMINADO CON EXITO \033[1;32m[!OK]"
echo -e "$barra"
}

##LIMPIA ROOT
fun_limpiarepositorios () {
rm -rf $HOME/install
rm -rf $HOME/install.1
rm -rf $HOME/install.2
rm -rf $HOME/ocspanel
rm -rf $HOME/Painelv11.sh
rm -rf $HOME/install.sh
rm -rf $HOME/Painel.sh
rm -rf $HOME/banco.sql
rm -rf $HOME/BD-Painel-v23.sql
rm -rf $HOME/sshplus.sql
rm -rf $HOME/bd-v15.sql
rm -rf $HOME/ssh.sql
rm -rf $HOME/plus.sql
}

##CLEAN FOLDER
clean_folder () {
echo ""
fun_bar "apt-get update -y"
fun_bar "apt-get upgrade -y"
fun_bar "fun_limpiarepositorios"
rm -rf $HOME/Panelweb.sh; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/Panelweb.sh > /dev/null 2>&1
echo ""
echo -e "\033[1;33m CLEAN FOLDER COM SUCESSO -\033[1;32m OK !\033[1;37m"
sleep 4s
chmod +x Panelweb.sh; ./Panelweb.sh
}

##PAINEL A INSTALAR

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
panel_v23_2 () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v23_2/install > /dev/null 2>&1; chmod +x install; ./install
}
panel_v25 () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v25/install > /dev/null 2>&1; chmod +x install; ./install
}

##UPDATE VIP-VPS v23 a v25

panel_update2325 () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v23_2/atu-v23-p-v25 > /dev/null 2>&1; chmod +x atu-v23-p-v25; ./atu-v23-p-v25
}

##OPCIONES DE SISTEMA

atualizar () {
    rm -rf $HOME/Panelweb.sh; wget wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/Panelweb.sh; chmod +x Panelweb.sh; ./Panelweb.sh
}
remove_multiscripts () {
    rm -rf $HOME/Panelweb.sh && rm -rf /bin/ipw
    exit
    clear
}

##MENU
_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
_usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")

while true $x != "ok"
do
clear
echo -e "$barra"
echo -e "\E[41;1;37mINSTALAR PAINEL WEB SSH/DROP/SSL \033[1;32m[\033[1;37m  VERSAO: r001 \033[1;32m]\E[0m"
echo -e "$barra"
echo -e "\033[1;31m[\033[1;36m01\033[1;31m] \033[1;37m• \033[1;33mPAINEL SSHPLUS WEB V10       \033[1;31m(ANT) 
\033[1;31m[\033[1;36m02\033[1;31m] \033[1;37m• \033[1;33mPAINEL SSHPLUS WEB V10 2     \033[1;32m(DAN) 
\033[1;31m[\033[1;36m03\033[1;31m] \033[1;37m• \033[1;33mPAINEL SSHPLUS WEB V11       \033[1;31m(ANT) 
\033[1;31m[\033[1;36m04\033[1;31m] \033[1;37m• \033[1;33mPAINEL SSHPLUS WEB V11 2     \033[1;32m(NEW) 
\033[1;31m[\033[1;36m05\033[1;31m] \033[1;37m• \033[1;33mPAINEL SSHPLUS WEB V12       \033[1;32m(NEW) 
\033[1;31m[\033[1;36m06\033[1;31m] \033[1;37m• \033[1;33mPAINEL SSHPLUS WEB V15       \033[1;31m(ANT) 
\033[1;31m[\033[1;36m07\033[1;31m] \033[1;37m• \033[1;33mPAINEL SSHPLUS WEB V15 2     \033[1;33m(OCS)
\033[1;31m[\033[1;36m08\033[1;31m] \033[1;37m• \033[1;33mPAINEL SSHPLUS WEB V20       \033[1;32m(NEW) \033[1;37m∆
\033[1;31m[\033[1;36m09\033[1;31m] \033[1;37m• \033[1;33mPAINEL SSHPLUS WEB V20 MOD   \033[1;32m(NEW) 
\033[1;31m[\033[1;36m10\033[1;31m] \033[1;37m• \033[1;33mPAINEL SSHPLUS WEB V23       \033[1;32m(NEW) 
\033[1;31m[\033[1;36m11\033[1;31m] \033[1;37m• \033[1;33mPAINEL VIP-VPS WEB V.23      \033[1;35m(ADE) \033[1;37m∆
\033[1;31m[\033[1;36m12\033[1;31m] \033[1;37m• \033[1;33mPAINEL VIP-VPS WEB V.25      \033[1;35m(ADE) \033[1;37m∆
\033[1;31m[\033[1;36m13\033[1;31m] \033[1;37m• \033[1;33mUPDATE VIP-VPS V.23 PARA V25 \033[1;35m(ADE) \033[1;37m∆
\033[1;31m[\033[1;36m14\033[1;31m] \033[1;37m• \033[1;33mCLEAN FOLDER                 \033[1;33m(\033[1;37mINESTABLE\033[1;33m) \033[1;36m•
\033[1;31m[\033[1;36m15\033[1;31m] \033[1;37m• \033[1;33mPANEL REMOVE                 \033[1;33m(\033[1;37mINESTABLE\033[1;33m) \033[1;36m•
\033[0m\e[34m--------------------------------------------------
\033[1;31m[\033[1;36m16\033[1;31m] \033[1;35m[!] \033[1;32mACTUALIZAR                \033[1;31mRam:\033[1;37m $_usor
\033[1;31m[\033[1;36m17\033[1;31m] \033[1;35m[!] \033[1;31mDESINSTALAR \033[1;35m[\033[1;37m IPW \033[1;35m]       \033[1;31mNucleo:\033[1;37m $_usop
\033[1;31m[\033[1;36m00\033[1;31m] \033[1;37mSALIR \033[1;32m<\033[1;33m<\033[1;31m<                     \033[1;37m@admmanagerfree\033[0m \033[0m"
echo -e "$barra"
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
   panel_v23_2
   exit;
   ;;
   12)
   clear
   panel_v25
   exit;
   ;;     
   13)
   clear
   panel_update2325
   exit;
   ;;
   14)
   clear
   clean_folder
   exit;
   ;;
   15)
   clear
   remove_panel
   exit;
   ;;
   16)
   clear
   atualizar
   exit;
   ;;
   17)
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
   ./Panelweb.sh
esac
done
}
#fim