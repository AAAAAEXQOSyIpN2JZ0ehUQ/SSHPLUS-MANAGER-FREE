#!/bin/bash
database="/root/usuarios.db"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%20s%s\n' "   Alterar limite de conexões simultâneas   " ; tput sgr0
if [ ! -f "$database" ]
then
	tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "Arquivo $database não encontrado" ; echo "" ; tput sgr0
	exit 1
else
	tput setaf 3 ; tput bold ; echo ""; echo "Limite de conexões simultâneas dos usuários:" ; tput sgr0
	echo ""
	i=0
    while read users
       do
           user="$(echo $users | cut -d' ' -f1)"
           limit="$(echo $users | cut -d' ' -f2)"
           i=$(expr $i + 1)
           oP+=$i
           [[ $i == [1-9] ]] && oP+=" 0$i" && i=0$i
           oP+=":$user\n"
           _user=$(echo -e "\033[1;33m[\033[1;31m$i\033[1;33m] \033[1;37m- \033[1;32m$user\033[0m")
           lim=$(echo -e "\033[1;33mLimite\033[1;37m: $limit")
           printf '%-60s%s\n' "$_user" "$lim"
       done < "$database"
       echo ""
    num_user=$(cat $database | wc -l)
    echo -ne "\033[1;32mSelecione um usuario \033[1;33m[\033[1;37m1\033[1;31m-\033[1;37m$num_user\033[1;33m]\033[1;37m: " ; read option
    if [[ -z $option ]]; then
        tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "Usuário vazio ou não existente" ; echo "" ; tput sgr0
		exit
	fi
    usuario=$(echo -e "$oP" | grep -E "\b$option\b" | cut -d: -f2)
	if [[ -z $usuario ]]
	then
		tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "Usuário vazio ou não existente" ; echo "" ; tput sgr0
		exit 1
	else
		if [[ `grep -c "^$usuario " $database` -gt 0 ]]
		then
			echo -ne "\n\033[1;32mNovo limite para o usuario \033[1;33m$usuario\033[1;37m: "; read sshnum
			if [[ -z $sshnum ]]
			then
				tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "Você digitou um número inválido!" ; echo "" ; tput sgr0
				exit 1
			else
				if (echo $sshnum | egrep [^0-9] &> /dev/null)
				then
					tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "Você digitou um número inválido!" ; echo "" ; tput sgr0
					exit 1
				else
					if [[ $sshnum -lt 1 ]]
					then
						tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "Você deve digitar um número maior que zero!" ; echo "" ; tput sgr0
						exit 1
					else
						grep -v ^$usuario[[:space:]] /root/usuarios.db > /tmp/a
						sleep 1
						mv /tmp/a /root/usuarios.db
						echo $usuario $sshnum >> /root/usuarios.db
						tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Limite aplicado para o usuário $usuario foi $sshnum " ; tput sgr0
						sleep 2
						exit
					fi
				fi
			fi			
		else
			tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "O usuário $usuario não foi encontrado" ; echo "" ; tput sgr0
			exit 1
		fi
	fi
fi