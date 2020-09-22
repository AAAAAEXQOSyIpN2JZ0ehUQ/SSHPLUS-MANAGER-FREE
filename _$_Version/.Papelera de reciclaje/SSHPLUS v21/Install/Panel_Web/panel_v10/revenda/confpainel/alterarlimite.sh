#!/bin/bash
database="/root/usuarios.db"
usuario=$1
sshnum=$2
if [ ! -f "$database" ]
then
	tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "0" ; echo "" ; tput sgr0
	exit 1
else
	
	
	if [[ -z $usuario ]]
	then
		tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "1" ; echo "" ; tput sgr0
		exit 1
	else
		if [[ `grep -c "^$usuario " $database` -gt 0 ]]
		then
			
			if [[ -z $sshnum ]]
			then
				tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "2" ; echo "" ; tput sgr0
				exit 1
			else
				if (echo $sshnum | egrep [^0-9] &> /dev/null)
				then
					tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "2" ; echo "" ; tput sgr0
					exit 1
				else
					if [[ $sshnum -lt 1 ]]
					then
						tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "3" ; echo "" ; tput sgr0
						exit 1
					else
						grep -v ^$usuario[[:space:]] /root/usuarios.db > /tmp/a
						sleep 1
						mv /tmp/a /root/usuarios.db
						echo $usuario $sshnum >> /root/usuarios.db
						tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "4" ; tput sgr0
						tput setaf 3 ; tput bold ; echo "" ; cat $database ; echo "" ; tput sgr0
						exit
					fi
				fi
			fi			
		else
			tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "5" ; echo "" ; tput sgr0
			exit 1
		fi
	fi
fi