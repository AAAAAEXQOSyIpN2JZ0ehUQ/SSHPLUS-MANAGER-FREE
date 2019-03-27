#!/bin/bash
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-10s\n' "Alterar Senha de Usuário" ; tput sgr0
tput setaf 3 ; tput bold ; echo ""; echo "Lista de usuarios:" ; tput sgr0
echo ""
database="/root/usuarios.db"
i=0
while read users
   do
       userr="$(echo $users | cut -d' ' -f1)"
       i=$(expr $i + 1)
       oP+=$i
       [[ $i == [1-9] ]] && oP+=" 0$i" && i=0$i
       oP+=":$userr\n"
       echo -e "\033[1;33m[\033[1;31m$i\033[1;33m] \033[1;37m- \033[1;32m$userr\033[0m"
   done < "$database"
   echo ""
num_user=$(cat $database | wc -l)
echo -ne "\033[1;32mSelecione um usuario \033[1;33m[\033[1;37m1\033[1;31m-\033[1;37m$num_user\033[1;33m]\033[1;37m: " ; read option
if [[ -z $option ]]
then
	tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "Você digitou um nome vazio ou inválido!" ; echo "" ; tput sgr0
	exit 1
fi
user=$(echo -e "$oP" | grep -E "\b$option\b" | cut -d: -f2)
if [[ -z $user ]]
then
	tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "Nome vazio ou inválido!" ; echo "" ; tput sgr0
	exit 1
else
	if [[ `grep -c /$user: /etc/passwd` -ne 0 ]]
	then
		echo -ne "\n\033[1;32mNova senha para o usuario \033[1;33m$user\033[1;37m: "; read password
		sizepass=$(echo ${#password})
		if [[ $sizepass -lt 4 ]]
		then
			tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "Senha vazio ou inválida! use no minimo 4 caracteres" ; echo "" ; tput sgr0
			exit 1
		else
			ps x | grep $user | grep -v grep | grep -v pt > /tmp/rem
			if [[ `grep -c $user /tmp/rem` -eq 0 ]]
			then
				echo "$user:$password" | chpasswd
				tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "A senha do usuário $user foi alterada para: $password" ; echo "" ; tput sgr0
				echo "$password" > /etc/SSHPlus/senha/$user
				exit 1
			else
				echo ""
				tput setaf 7 ; tput setab 4 ; tput bold ; echo "Usuário conectado. Desconectando..." ; tput sgr0
				pkill -f $user
				echo "$user:$password" | chpasswd
				tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "A senha do usuário $user foi alterada para: $password" ; echo "" ; tput sgr0
				echo "$password" > /etc/SSHPlus/senha/$user
				exit 1
			fi
		fi
	else
		tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "O usuário $user não existe!" ; echo "" ; tput sgr0
	fi
fi