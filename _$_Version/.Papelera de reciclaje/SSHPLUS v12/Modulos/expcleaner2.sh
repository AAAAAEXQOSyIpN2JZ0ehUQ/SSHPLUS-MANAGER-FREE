#!/bin/bash
datenow=$(date +%s)
echo -e "\E[44;1;37m Usuario          Data         Estado         Ação   \E[0m"
echo ""
for user in $(awk -F: '{print $1}' /etc/passwd); do
	expdate=$(chage -l $user|awk -F: '/Account expires/{print $2}')
	echo $expdate|grep -q never && continue
	datanormal=$(date -d"$expdate" '+%d/%m/%Y')
	tput setaf 3 ; tput bold ; printf '%-15s%-17s%s' $user $datanormal ; tput sgr0
	expsec=$(date +%s --date="$expdate")
	diff=$(echo $datenow - $expsec|bc -l)
	tput setaf 2 ; tput bold
	echo $diff|grep -q ^\- && echo "Ativo    Não removido" && continue
	tput setaf 1 ; tput bold
	echo "Expirado    Removido"
	pkill -f $user
	userdel --force $user > /dev/null 2>&1
	grep -v ^$user[[:space:]] /root/usuarios.db > /tmp/ph ; cat /tmp/ph > /root/usuarios.db
done
tput sgr0 
echo ""