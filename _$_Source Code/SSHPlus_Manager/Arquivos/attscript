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

echo -ne "   \033[1;33mAGUARDE \033[1;37m- \033[1;33m["

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

   echo -ne "   \033[1;33mAGUARDE \033[1;37m- \033[1;33m["

done

echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"

tput cnorm

}

echo " "

fun_atts () {

  [[ -e /home/versao ]] && rm /home/versao

  [[ -e /tmp/att ]] && rm /tmp/att

	wget -c -P /home http://sshplus.xyz/script/versao

	[[ -f "/home/versao" ]] && mv /home/versao /tmp/att

	[[ ! -e /bin/versao ]] && rm -rf /bin/menu

} > /dev/null 2>&1

echo -e "                              \033[1;31mBy Crazy\033[1;36m"

echo -e "   SSHPlus" | figlet

echo " "

echo -e "   \033[1;32mVERIFICANDO ATUALIZACOES DISPONIVEIS\033[0m\n"

fun_bar 'fun_atts'

[[ ! -f "/tmp/att" ]] && {

	echo -e "\n\033[1;31m ERRO AO CONECTAR AO SERVIDOR\n"

	echo -ne "\033[1;31m ENTER \033[1;33mpara retornar ao \033[1;32mMENU!\033[0m"; read

	menu

}

echo " "

vrs1=$(sed -n '1 p' /bin/versao| sed -e 's/[^0-9]//ig')

vrs2=$(sed -n '1 p' /tmp/att | sed -e 's/[^0-9]//ig')

[[ "$vrs1" == "$vrs2" ]] && {

  echo -e " \033[1;36m     O SCRIPT JA ESTA ATUALIZADO!\033[1;32m\n"

  rm /tmp/att > /dev/null 2>&1

  echo -e " \033[1;33m MAIS INFORMACOES \033[1;31m(\033[1;36mTELEGRAM\033[1;31m): \033[1;37m@crazy_vpn\n"

  echo -ne " \033[1;31m ENTER \033[1;33mpara retornar ao \033[1;32mMENU!\033[0m"; read

  menu

} || {

  echo -e "  \033[1;36mEXISTE UMA NOVA ATUALIZACAO DISPONIVEL!\033[1;33m\n"

  echo -e "  \033[1;33mMAIS INFORMACOES \033[1;31m(\033[1;36mTELEGRAM\033[1;31m): \033[1;37m@crazy_vpn\n"

  echo -e "  \033[1;32mDETALHES DA ATUALIZACAO:\033[0m\n"

  while read linha; do

    echo -e "  \033[1;37m- \033[1;33m$linha"

  done < "/tmp/att"

  echo " "

  echo -ne "  \033[1;32mDESEJA ATUALIZAR \033[1;31m? \033[1;33m[s/n]:\033[1;37m "; read res

  if [[ "$res" = s || "$res" = S ]];then

    echo -e "\n\033[1;32m  INICIANDO ATUALIZACAO..."

    sleep 3

    wget http://sshplus.xyz/script/Plus > /dev/null 2>&1

    chmod +x Plus

    ./Plus

    clear

    echo -e "\033[1;32mSCRIPT ATUALIZADO COM SUCESSO\033[0m\n"

    rm /tmp/att > /dev/null 2>&1

    echo -ne "\033[1;31mENTER \033[1;33mpara retornar ao \033[1;32mMENU!\033[0m"; read

    menu

  else

    menu

  fi

}

