#!/bin/bash
clear
database="/root/usuarios.db"
fun_drop () {
	_portaD=$(ps x | grep dropbear | grep -v grep | awk -F'-p ' '{print $2}' | sed 's/ .*//g' | uniq)
	_log='/var/log/auth.log'
	_loginS='Password auth succeeded'
	for _pid in `ps ax |grep dropbear |grep  "$_portaD" |awk '{print $1}'`; do
		for _pidLog in `grep $_pid $_log |grep "$_loginS" |awk -F" " '{print $3}'`; do
			_login=`grep $_pid $_log |grep "$_pidLog" |grep "$_loginS"`
			_user=`echo $_login |awk -F" " '{print $10}' | sed -r "s/'/ /g"`
			echo -e "$_user" "$_pid"
		done
	done
}

fun_killopen () {
(	
_pidsovp=$1
telnet localhost 7505 <<EOF
kill $_pidsovp
EOF
) &>/dev/null &
}

fun_multilogin () {
	(
		while read _users; do
			user="$(echo $_users | cut -d' ' -f1)"
			limit="$(echo $_users | cut -d' ' -f2)"
			conssh="$(ps -u $user | grep sshd | wc -l)"
			[[ -e /etc/default/dropbear ]] && {
				condrop="$(fun_drop | grep -E "$user" | wc -l)"
				piddrop="$(fun_drop | grep -E "$user" | tail -1 | awk '{print $ NF}')"
				[[ "$condrop" -gt "$limit" ]] && kill -9 $piddrop
			}
			[[ -e /etc/openvpn/openvpn-status.log ]] && {
				ovp="$(grep -E ,"$user", /etc/openvpn/openvpn-status.log | wc -l)"
				[[ "$ovp" -gt "$limit" ]] && {
					pidokill=$(($ovp - $limit))
					listpid=$(grep -E ,"$user", /etc/openvpn/openvpn-status.log | cut -d "," -f3 |head -n $pidokill)
					while read ovpids; do
						(
							telnet localhost 7505 <<- EOF
							kill $ovpids
							EOF
							) &>/dev/null &
					done <<< "$listpid"
				}
			}
			[[ "$conssh" -gt "$limit" ]] && {
				pidkill=$(($conssh - $limit))
				for pidssh in `(ps -u $user |grep sshd| tail -n $pidkill |awk '{print $1}')`; do
					kill -9 "$pidssh"
				done
	        }
	    done < "$database"
	    ) &
}
while true; do
	fun_multilogin
	sleep 10
done