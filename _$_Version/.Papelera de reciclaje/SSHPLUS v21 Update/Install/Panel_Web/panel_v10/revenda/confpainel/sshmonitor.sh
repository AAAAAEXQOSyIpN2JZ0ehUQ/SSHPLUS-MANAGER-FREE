#!/bin/bash
database="/root/usuarios.db"
echo $$ > /tmp/kids
while true
do

	while read usline
	do
		user="$(echo $usline | cut -d' ' -f1)"
		s2ssh="$(echo $usline | cut -d' ' -f2)"
		if [[ -e /etc/openvpn/openvpn-status.log ]]; then
        ovp="$(cat /etc/openvpn/openvpn-status.log | grep -E ,"$user", | wc -l)"
        else
        ovp=0
        fi
		if [ -z "$user" ] ; then
			echo "" > /dev/null
		else
			ps x | grep [[:space:]]$user[[:space:]] | grep -v grep | grep -v pts > /tmp/tmp8
			s1ssh="$(cat /tmp/tmp8 | wc -l)"
			conex=$(($s1ssh + $ovp))
			tput setaf 3 ; tput bold ; printf '  %-35s%s\n' $user,$conex,; tput sgr0
		fi
	done < "$database"
	echo ""
	exit 1
done
