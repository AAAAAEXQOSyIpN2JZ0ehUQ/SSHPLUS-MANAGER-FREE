#!/bin/bash
if [ -d "/etc/squid/" ]; then
    payload="/etc/squid/payload.txt"
elif [ -d "/etc/squid3/" ]; then
	payload="/etc/squid3/payload.txt"
fi
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-10s\n' "Remover Host do Squid Proxy" ; tput sgr0
if [ ! -f "$payload" ]
then
	tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Arquivo $payload não encontrado" ; tput sgr0
	exit 1
else
	tput setaf 2 ; tput bold ; echo ""; echo "Domínios atuais no arquivo $payload:" ; tput sgr0
	tput setaf 3 ; tput bold ; echo "" ; cat $payload ; echo "" ; tput sgr0
	read -p "Digite o domínio que deseja remover da lista: " host
	if [[ -z $host ]]
		then
			tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você digitou um domínio vazio ou não existente!" ; echo "" ; tput sgr0
			exit 1
		else
		if [[ `grep -c "^$host" $payload` -ne 1 ]]
		then
			tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "O domínio $host não foi encontrado no arquivo $payload" ; echo "" ; tput sgr0
			exit 1
		else
			grep -v "^$host" $payload > /tmp/a && mv /tmp/a $payload
			tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "Arquivo $payload atualizado, o domínio foi removido com sucesso:" ; tput sgr0
			tput setaf 3 ; tput bold ; echo "" ; cat $payload ; echo "" ; tput sgr0
			if [ ! -f "/etc/init.d/squid3" ]
			then
				service squid3 reload
			elif [ ! -f "/etc/init.d/squid" ]
			then
				service squid reload
			fi	
			tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "O Proxy Squid Proxy foi recarregado com sucesso!" ; echo "" ; tput sgr0
			exit 1
		fi
	fi
fi