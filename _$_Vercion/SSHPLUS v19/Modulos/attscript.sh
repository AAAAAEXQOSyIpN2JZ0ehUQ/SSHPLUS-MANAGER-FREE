#!/bin/bash
clear
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
echo ""
vrs1=$(cat /bin/versao)
vrs2=$(wget -qO- https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/versao | sed -n '1 p')
[[ ! -e /bin/versao ]] && rm -rf /bin/menu
echo -e "                              \033[1;31mBy Crazy\033[1;36m"
echo -e "   SSHPlus" | figlet
echo ""
echo -e "\033[1;32mVERIFICANDO SE HA ATUALIZACOES DISPONIVEIS\033[0m"
echo ""
fun_bar 'sleep 4'
sleep 2
echo ""
if [ "$vrs1" = "$vrs2" ]; then
    echo ""
    echo -e " \033[1;36m     O SCRIPT JA ESTA ATUALIZADO!\033[1;32m"
    echo ""
    echo -ne "\n\033[1;31mENTER \033[1;33mpara retornar ao \033[1;32mMENU!\033[0m"; read
    menu
else
    echo -e "\033[1;36mEXISTE UMA ATUALIZACAO DISPONIVEL!\033[1;33m"
    echo ""
    read -p "Deseja Atualizar? [s/n] " res
    if [[ "$res" = s || "$res" = S ]];then
    echo ""
    echo -e "\033[1;32mAtualizando script..."
    sleep 3
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/sshplus.sh 2>/dev/null
    chmod +x sshplus.sh
    ./sshplus.sh
    clear
    echo -e "\033[1;32mSCRIPT ATUALIZADO COM SUCESSO\033[0m"
    sleep 3
    menu
    fi
fi