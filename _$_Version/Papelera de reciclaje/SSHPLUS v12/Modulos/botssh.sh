#!/bin/bash
clear
x="ok"
function bot_telegram ()
{
clear
while true $x != "ok"
do

function bot_on () {
if ps x | grep "bot_plus"|grep -v grep 1>/dev/null 2>/dev/null; then
   clear
   echo -e "\033[1;32mO BOT SSHPLUS JA ESTA ATIVO !\033[0m"
   sleep 3
   bot_telegram
 else
   clear
   echo -e "\033[1;32mINICIANDO BOT SSHPLUS... \033[0m"
   sleep 3
   cd /etc/SSHPlus
   screen -dmS bot_plus bash bot > /dev/null 2>&1
   cd $HOME
   echo ""
   echo -e "\033[1;31m[\033[1;32m BOT SSHPLUS ATIVADO \033[1;31m]\033[0m"
   sleep 3
   bot_telegram
fi
}
function bot_off () {
clear
echo ""
 if ps x | grep "bot_plus"|grep -v grep 1>/dev/null 2>/dev/null; then
   clear
   echo -e "\033[1;32mPARANDO BOT SSHPLUS... \033[0m"
   sleep 3
   pidbot_plus=$(ps x|grep "bot_plus"|awk -F "pts" {'print $1'})
   kill -9 $pidbot_plus 1>/dev/null 2>/dev/null
   screen -wipe 1>/dev/null 2>/dev/null
   echo ""
   echo -e "\033[1;32m[ \033[1;31mBOT SSHPLUS PARADO! \033[1;32m]\033[0m"
   sleep 3
   bot_telegram
 else
   echo ""
   echo -e "\033[1;32mO BOT SSHPLUS JA ESTA DESATIVADO!\033[0m"
   sleep 3
   bot_telegram
 fi
}
function token_edit () {
  echo -ne "\033[1;36mINFORME SEU NOVO TOKEN:\033[1;37m "; read tokenbot
  if [[ -z $tokenbot ]]; then
  	echo""
  	echo -e "\033[1;31mToken invalido ou vazio!"
  	sleep 2
  	bot_telegram
  fi
  token2=$(cat /etc/SSHPlus/bot|grep "api_bot=" | awk -F = '{print $2}')
  sed -i "s/api_bot=$token2/api_bot='$tokenbot'/" /etc/SSHPlus/bot
  if ps x | grep "bot_plus"|grep -v grep 1>/dev/null 2>/dev/null; then
    pidbot_plus=$(ps x|grep "bot_plus"|awk -F "pts" {'print $1'})
    kill -9 $pidbot_plus 1>/dev/null 2>/dev/null
    screen -wipe 1>/dev/null 2>/dev/null
    sleep 2
  fi
  cd /etc/SSHPlus
  screen -dmS bot_plus bash bot > /dev/null 2>&1
  cd $HOME
  clear
  echo -ne "\033[1;32mTOKEN ALTERADO COM SUCESSO !\033[0m"
  sleep 3
  bot_telegram
}
function att_api () {
  echo -e "\033[1;31mAGUARDE \033[1;32m.\033[1;33m.\033[1;31m. \033[1;33m"
  if ps x | grep "bot_plus"|grep -v grep 1>/dev/null 2>/dev/null; then
    pidbot_plus=$(ps x|grep "bot_plus"|awk -F "pts" {'print $1'})
    kill -9 $pidbot_plus 1>/dev/null 2>/dev/null
    screen -wipe 1>/dev/null 2>/dev/null
    sleep 2
    rm /etc/SSHPlus/ShellBot.sh
    wget https://raw.githubusercontent.com/shellscriptx/shellbot/master/ShellBot.sh -O /etc/SSHPlus/ShellBot.sh > /dev/null 2>&1
  fi
  cd /etc/SSHPlus
  screen -dmS bot_plus bash bot > /dev/null 2>&1
  cd $HOME
  echo ""
  echo -e "\033[1;36mAPI ATUALIZADA COM SUCESSO !\033[1;37m"
  sleep 2
  bot_telegram
}
reset_bot () {
	echo -e "\033[1;32mRESETANDO BOT SSHPLUS... \033[0m"
	if ps x | grep "bot_plus"|grep -v grep 1>/dev/null 2>/dev/null; then
		pidbot_plus=$(ps x|grep "bot_plus"|awk -F "pts" {'print $1'})
	 	kill -9 $pidbot_plus 1>/dev/null 2>/dev/null
	 	screen -wipe 1>/dev/null 2>/dev/null
	fi
	sleep 1
	rm /etc/SSHPlus/ShellBot.sh
	echo ""
	echo -e "\033[1;31m[ \033[1;32mDEFINICOES RESETADAS! \033[1;31m]\033[0m"
	sleep 1
	echo ""
	echo -e "\033[1;31mRetornando ao Menu... \033[0m"
	sleep 3
	menu
}
if ps x | grep "bot_plus"|grep -v grep 1>/dev/null 2>/dev/null; then
statusbot="\033[1;32mATIVADO"
else
statusbot="\033[1;31mDESATIVADO"
fi
echo -e "\E[44;1;37m          BOT TELEGRAM SSHPLUS            \E[0m"
echo ""
echo -e "\033[1;33mSTATUS\033[1;37m: $statusbot \033[0m"
echo ""
echo -e "\033[1;33m[\033[1;31m1\033[1;33m] ATIVAR BOT \033[1;33m
[\033[1;31m2\033[1;33m] DESATIVAR BOT\033[1;33m
[\033[1;31m3\033[1;33m] ALTERAR TOKEN\033[1;33m
[\033[1;31m4\033[1;33m] ATUALIZAR API\033[1;33m
[\033[1;31m5\033[1;33m] RESETAR BOT\033[1;33m
[\033[1;31m0\033[1;33m] VOLTAR \033[1;32m<\033[1;33m<\033[1;31m< \033[0m"
echo ""
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
tput civis
echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;31m?\033[1;37m "; read x
tput cnorm

clear
case $x in

1|01)
bot_on
;;
2|02)
bot_off
;;
3|03)
token_edit
;;
4|04)
att_api
;;
5|05)
reset_bot
;;
0|00)
menu
;;
*)
echo -e "\033[1;31mOpcao Invalida...\033[0m"
sleep 2
clear
bot_telegram
;;
esac
done
}
function install_bot ()
{
echo -e "\E[44;1;37m               INSTALADOR BOT SSHPLUS                 \E[0m"
echo ""
echo -e "                 \033[1;33m● \033[1;31mATENCAO \033[1;33m●\033[0m"
echo ""
echo -e "\033[1;32m●\033[1;33m Saiba que o BOT SSHPLUS ainda possui opcoes um pouco\033[0m"
echo -e "\033[1;33mlimitadas mais serao bem uteis\033[0m"
echo ""
echo -e "\033[1;32m●\033[1;33m Antes de tudo acesse este bot \033[1;31m@BotFather \033[1;33mno telegram \033[0m"
echo -e "\033[1;33me crie o seu BOT para obter o TOKEN\033[0m"
echo ""
echo -e "\033[1;32m●\033[1;33m Acesse esse outro bot \033[1;31m@EdRobot \033[1;33mpara obter o seu ID\033[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[1;32m"
echo ""
read -p "DESEJA CONTINUAR ? [s/n]: " -e -i n resposta
if [[ "$resposta" = 's' ]]; then
	echo ""
  	echo -ne "\033[1;36mINFORME SEU TOKEN:\033[1;37m "; read tokenbot
  	echo ""
  	echo -ne "\033[1;36mINFORME SEU ID:\033[1;37m "; read iduser
  	echo ""
      clear
      echo -e "\033[1;32mINICIANDO BOT SSHPLUS \033[0m"
      echo ""
      sleep 1
  	token2=$(cat /etc/SSHPlus/bot|grep "api_bot=" | awk -F = '{print $2}')
  	sed -i "s/api_bot=$token2/api_bot='$tokenbot'/" /etc/SSHPlus/bot
  	id2=$(cat /etc/SSHPlus/bot|grep "id_admin=" | awk -F = '{print $2}')
  	sed -i "s/id_admin=$id2/id_admin=$iduser/" /etc/SSHPlus/bot
  	wget -qO- https://raw.githubusercontent.com/shellscriptx/shellbot/master/ShellBot.sh > /etc/SSHPlus/ShellBot.sh
      sleep 1
  	cd /etc/SSHPlus
  	screen -dmS bot_plus bash bot > /dev/null 2>&1
  	cd $HOME
      echo ""
      echo -e "\033[1;31m[\033[1;32m BOT SSHPLUS ATIVADO \033[1;31m]\033[0m"
      sleep 2
      clear
  	bot_telegram
  else
  	echo -e "\033[1;31mInstalacao abortada\033[0m"
  	sleep 3
  	menu
fi
}
if [ -f "/etc/SSHPlus/ShellBot.sh" ]; then
	bot_telegram
else
	install_bot
fi
#fim