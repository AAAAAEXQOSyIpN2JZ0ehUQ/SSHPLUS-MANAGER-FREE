#!/bin/bash
remove_ovp () {
if [[ -e /etc/debian_version ]]; then
	GROUPNAME=nogroup
fi
user="$1"
cd /etc/openvpn/easy-rsa/
./easyrsa --batch revoke $user
./easyrsa gen-crl
rm -rf pki/reqs/$user.req
rm -rf pki/private/$user.key
rm -rf pki/issued/$user.crt
rm -rf /etc/openvpn/crl.pem
cp /etc/openvpn/easy-rsa/pki/crl.pem /etc/openvpn/crl.pem
chown nobody:$GROUPNAME /etc/openvpn/crl.pem
} > /dev/null 2>&1
[[ ! -d /etc/SSHPlus ]] && rm -rf /bin/ > /dev/null 2>&1
database="/root/usuarios.db"
clear
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%32s%s%-13s\n' "Remover Usuário SSH" ; tput sgr0
echo ""
echo -e "\033[1;33m[\033[1;31m1\033[1;33m]\033[1;33m REMOVER UM USUARIO"
echo -e "\033[1;33m[\033[1;31m2\033[1;33m]\033[1;33m REMOVER TODOS USUARIOS"
echo -e "\033[1;33m[\033[1;31m3\033[1;33m]\033[1;33m VOLTAR"
echo ""
read -p "$(echo -e "\033[1;32mOQUE DESEJA FAZER\033[1;31m ?\033[1;37m : ")" -e -i 1 resp
if [[ "$resp" = "1" ]]; then
clear
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%32s%s%-13s\n' "Remover Usuário SSH" ; tput sgr0
echo ""
echo -e "\033[1;33mLISTA DE USUARIOS: \033[0m"
echo""
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
	tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "  Usuario vazio ou inválido!   " ; echo "" ; tput sgr0
	exit 1
fi
user=$(echo -e "$oP" | grep -E "\b$option\b" | cut -d: -f2)
if [[ -z $user ]]
then
	tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo " Usuário vazio ou inválido! " ; echo "" ; tput sgr0
	exit 1
else
	if [ "$(cat "$database"| grep -w $user| wc -l)" -ne "0" ]
		then
		ps x | grep $user | grep -v grep | grep -v pt > /tmp/rem
		if [[ `grep -c $user /tmp/rem` -eq 0 ]]
			then
			deluser --force $user > /dev/null 2>&1
			echo ""
			echo -e "\E[41;1;37m Usuario $user removido com sucesso! \E[0m"
			grep -v ^$user[[:space:]] /root/usuarios.db > /tmp/ph ; cat /tmp/ph > /root/usuarios.db
			rm /etc/SSHPlus/senha/$user 1>/dev/null 2>/dev/null
			if [[ -e /etc/openvpn/server.conf ]]; then
				remove_ovp $user
		    fi
			exit 1
		else
		    echo ""
			tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Usuário conectado. Desconectando..." ; tput sgr0
			pkill -f "$user" > /dev/null 2>&1
			deluser --force $user > /dev/null 2>&1
			echo -e "\E[41;1;37m Usuario $user removido com sucesso! \E[0m"
			grep -v ^$user[[:space:]] /root/usuarios.db > /tmp/ph ; cat /tmp/ph > /root/usuarios.db
			rm /etc/SSHPlus/senha/$user 1>/dev/null 2>/dev/null
			if [[ -e /etc/openvpn/server.conf ]]; then
				remove_ovp $user
		    fi
			exit 1
		fi
	elif cat /etc/passwd |grep $user: |grep -vi [a-z]$user |grep -v [0-9]$user > /dev/null
		then
		echo ""
		pkill -f "$user" > /dev/null 2>&1
		deluser --force $user > /dev/null 2>&1
		echo -e "\E[41;1;37m Usuario $user removido com sucesso! \E[0m"
		grep -v ^$user[[:space:]] /root/usuarios.db > /tmp/ph ; cat /tmp/ph > /root/usuarios.db
		rm /etc/SSHPlus/senha/$user 1>/dev/null 2>/dev/null
		if [[ -e /etc/openvpn/server.conf ]]; then
			remove_ovp $user
		fi
		exit 1
	else
		tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "O usuário $user não existe!" ; echo "" ; tput sgr0
	fi
fi
elif [[ "$resp" = "2" ]]; then
	clear
	tput setaf 7 ; tput setab 4 ; tput bold ; printf '%32s%s%-13s\n' "Remover Usuário SSH" ; tput sgr0
	echo ""
	echo -ne "\033[1;33mREALMENTE DESEJA REMOVER TODOS USUARIOS \033[1;37m[s/n]: "; read opc	
	if [[ "$opc" = "s" ]]; then
	echo -e "\n\033[1;33mAguarde\033[1;32m.\033[1;31m.\033[1;33m.\033[0m"
		for user in $(cat /etc/passwd |awk -F : '$3 > 900 {print $1}' |grep -vi "nobody"); do
			pkill -f $user > /dev/null 2>&1
			deluser --force $user > /dev/null 2>&1
        if [[ -e /etc/openvpn/server.conf ]]; then
		   remove_ovp $user
		fi
		done
		rm $HOME/usuarios.db && touch $HOME/usuarios.db
        rm *.zip > /dev/null 2>&1
		echo -e "\n\033[1;32mUSUARIOS REMOVIDOS COM SUCESSO!\033[0m"
		sleep 2
		menu
	else
		echo -e "\n\033[1;31mRetornando ao menu...\033[0m"
		sleep 2
		menu
	fi
elif [[ "$resp" = "3" ]]; then
	menu
else
	echo -e "\n\033[1;31mOpcao invalida !\033[0m"
	sleep 1.5s
	menu
fi