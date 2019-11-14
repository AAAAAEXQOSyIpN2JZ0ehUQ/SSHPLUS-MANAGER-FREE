#!/bin/bash
clear
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
echo -ne "\033[1;33m["
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
   echo -ne "\033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}
if [ -e "/bin/badvpn-udpgw" ]; then
echo ""
x="ok"
badvpn ()
{
while true $x != "ok"
do

function udp2 () {
if ps x | grep "udpvpn"|grep -v grep 1>/dev/null 2>/dev/null; then
   echo ""
   echo -e "\033[1;32mO BADVPN JA ESTA ATIVO !\033[0m"
   sleep 3
   badvpn
 else
   echo ""
   echo -e "\033[1;32mINICIANDO O BADVPN... \033[0m"
   fun_udpon () {
      screen -dmS udpvpn /bin/badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 10
      sleep 1
   }
   echo ""
   fun_bar 'fun_udpon'
   echo ""
   echo -e "   \033[1;32mBADVPN ATIVO !\033[0m"
   sleep 3
   badvpn
fi
}
function udp3 () {
clear
echo ""
 if ps x | grep "udpvpn"|grep -v grep 1>/dev/null 2>/dev/null; then
   echo -e "\033[1;32mPARANDO O BADVPN... \033[0m"
   echo ""
   fun_stopbad () {
   sleep 1
   screen -r -S "udpvpn" -X quit
   screen -wipe 1>/dev/null 2>/dev/null
   sleep 1
   }
   fun_bar 'fun_stopbad'
   echo ""
   echo -e "   \033[1;31mBADVPN PARADO !\033[0m"
   sleep 3
   badvpn
 else
   echo ""
   echo -e " \033[1;32mO BADVPN JA ESTA DESATIVADO!\033[0m"
   sleep 3
   badvpn
 fi
}
ram1=$(free -h | grep -i mem | awk {'print $2'})
ram2=$(free -h | grep -i mem | awk {'print $4'})
ram3=$(free -h | grep -i mem | awk {'print $3'})
uso=$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')
system=$(cat /etc/issue.net)
if ps x | grep "udpvpn"|grep -v grep 1>/dev/null 2>/dev/null; then
statusudp="\033[1;32mATIVADO"
else
statusudp="\033[1;31mDESATIVADO"
fi
clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[41;1;37m               ❖ SSHPLUS MANAGER ❖                \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
if [ "$system" ]
then
echo -e "\033[1;31mSistema\033[1;37m: \033[1;32m$system     \033[1;31mUso da CPU \033[1;37m[\033[1;32m$uso\033[1;37m]"
else
echo -e "\033[1;32mSistema: \033[1;33m[ \033[1;31mNao disponivel \033[1;33m]"
fi
echo ""
echo -e "\033[1;31mMemoria Ram\033[1;37m total: \033[1;32m$ram1  \033[1;37mUsado: \033[1;32m$ram3  \033[1;37mLivre: \033[1;32m$ram2"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
echo -e "                   \033[1;33m● \033[1;36mBADVPN \033[1;33m●\033[0m"
echo ""
echo -e "\033[1;33mSTATUS\033[1;37m: $statusudp \033[0m"
echo ""
echo -e "\033[1;33m[\033[1;31m1\033[1;33m] INICIAR O BADVPN \033[1;33m
[\033[1;31m2\033[1;33m] PARAR O BADVPN\033[1;33m
[\033[1;31m3\033[1;33m] VOLTAR \033[1;32m<\033[1;33m<\033[1;31m< \033[1;33m
[\033[1;31m0\033[1;33m] SAIR \033[1;32m<\033[1;33m<\033[1;31m< \033[0m"
echo ""
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
tput civis
echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;31m?\033[1;37m "; read x
tput cnorm

case "$x" in 

1)
clear
udp2
echo ""
echo -e "\033[1;33mPressione \033[1;31mENTER \033[1;33mpara retornar\033[0m"
read
;;
2)
clear
udp3
echo ""
echo -e "\033[1;33mPressione \033[1;31mENTER \033[1;33mpara retornar\033[0m"
read
;;
3)
menu
;;
0)
echo -e "\033[1;31mSaindo...\033[0m"
sleep 2
clear
exit;
;;
*)
echo -e "\033[1;31mOpcao invalida !\033[0m"
sleep 2
esac
done

}
badvpn
else
clear
echo -e "\E[44;1;37m               Instalador BADVPN                  \E[0m"
echo ""
echo -e "                 \033[1;33m● \033[1;31mATENCAO \033[1;33m●\033[0m"
echo ""
echo -e "\033[1;31m●\033[1;33m Essa funcao compila e instala automaticamente o \033[0m"
echo -e "\033[1;33mBADVPN, Possibilitando a Ultilizacao do Protocolo\033[0m"
echo -e "\033[1;33mUDP Para Jogos Online, Chamadas tipo VoIP em Apps\033[0m"
echo -e "\033[1;33mComo whatsapp, mensseger e muito mais..\033[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[1;33m"
echo ""
read -p "Deseja continuar? [s/n]: " -e -i n resposta
if [[ "$resposta" = 's' ]]; then
	clear
	echo -e "\033[1;32mINSTALANDO O BADVPN... \033[1;37m"
	echo ""
	inst_udp () {
	cd $HOME
   wget https://www.dropbox.com/s/tgkxdwb03r7w59r/badvpn-udpgw -o /dev/null
   mv -f $HOME/badvpn-udpgw /bin/badvpn-udpgw
   chmod 777 /bin/badvpn-udpgw
	}
	fun_bar 'inst_udp'
	echo ""
	echo -e "\033[1;32mBADVPN INSTALADO COM SUCESSO."
	sleep 3
	badvpn
else 
   echo ""
	echo -e "\033[1;31mInstalacao abortada\033[0m"
	sleep 2
	menu
fi
fi