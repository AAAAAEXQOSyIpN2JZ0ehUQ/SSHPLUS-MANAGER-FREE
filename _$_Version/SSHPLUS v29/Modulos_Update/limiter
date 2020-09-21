#!/bin/bash
#====================================================
#	SCRIPT: LIMITER SSHPLUS MANAGER
#	DESENVOLVIDO POR:	CRAZY_VPN
#	CONTATO TELEGRAM:	http://t.me/crazy_vpn
#	CANAL TELEGRAM:	http://t.me/sshplus
#====================================================
clear
database="/root/usuarios.db"
fun_multilogin() {
	(
		while read user; do
		    echo $user
			[[ $(grep -wc "$user" $database) != '0' ]] && limit="$(grep -w $user $database | cut -d' ' -f2)" || limit='1'
			conssh="$(ps -u $user | grep sshd | wc -l)"
			[[ "$conssh" -gt "$limit" ]] && {
				pidkill=$(($limite - $conssh))
				for pidssh in $( (ps x | grep [[:space:]]$user[[:space:]] | grep -v grep | grep -v pts | awk '{print $1}' | tail -n $pidkill)); do
					kill -9 "$pidssh"
				done
			}
			[[ -e /etc/openvpn/openvpn-status.log ]] && {
				ovp="$(grep -E ,"$user", /etc/openvpn/openvpn-status.log | wc -l)"
				[[ "$ovp" -gt "$limit" ]] && {
					pidokill=$(($limit - $ovp))
					listpid=$(grep -E ,"$user", /etc/openvpn/openvpn-status.log | cut -d "," -f3 | head -n $pidokill)
					while read ovpids; do
						(
							telnet localhost 7505 <<-EOF
								kill $ovpids
							EOF
						) &>/dev/null &
					done <<<"$listpid"
				}
			}
		done <<<"$(awk -F : '$3 > 900 { print $1 }' /etc/passwd | grep -v "nobody" | grep -vi polkitd | grep -vi system-)"
	) &
}
while true; do
	fun_multilogin > /dev/null 2>&1
	sleep 15s
done
