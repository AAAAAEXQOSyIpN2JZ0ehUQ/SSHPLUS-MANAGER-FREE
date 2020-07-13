#!/bin/bash
database="/root/usuarios.db"
echo $$ > /tmp/kids
while true
do

	while read usline
	do
		user="$(echo $usline | cut -d' ' -f1)"
		s2ssh="$(echo $usline | cut -d' ' -f2)"
		if [ -z "$user" ] ; then
			echo "" > /dev/null
		else
			ps x | grep [[:space:]]$user[[:space:]] | grep -v grep | grep -v pts > /tmp/tmp8
			s1ssh="$(cat /tmp/tmp8 | wc -l)"
			tput setaf 3 ; tput bold ; printf '  %-35s%s\n' $user,$s1ssh,; tput sgr0
		fi
	done < "$database"
	echo ""
	exit 1
done
