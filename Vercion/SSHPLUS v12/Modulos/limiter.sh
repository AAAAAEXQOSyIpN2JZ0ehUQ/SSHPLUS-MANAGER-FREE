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
if [[ ! -f "$database" ]]; then
	echo -e "Arquivo usuarios.db nao encontrado"
	sleep 2
	exit 1
fi
while : ; do
    while read usline
    do
      user="$(echo $usline | cut -d' ' -f1)"
      limit="$(echo $usline | cut -d' ' -f2)"
      conssh="$(ps -u $user | grep sshd | wc -l)"
      [[ -e /etc/openvpn/openvpn-status.log ]] && ovp="$(grep -E ,"$user", /etc/openvpn/openvpn-status.log | wc -l)" || ovp=0
     if netstat -nltp|grep 'dropbear' > /dev/null; then
         dropon="ON"
         condrop="$(fun_drop | grep -E "$user" | wc -l)"
         piddrop="$(fun_drop | grep -E "$user" | tail -1 | awk '{print $ NF}')"
     else
         dropon="OFF"
         condrop=0
         piddrop=0
     fi
      cxx=$(($condop + $ovp))
      cnx=$(($cxx + $conssh))
      if [[ $cnx -gt $limit ]]; then
          (
              pidkill=$(($cnx - $limit))
              [[ "$dropon" = "ON" ]] && kill -9 $piddrop
		      for pidssh in `(ps -u $user |grep sshd| head -n $pidkill |awk '{print $1}')`; do
		          kill -9 $pidssh
		      done
          ) &>/dev/null &
	   fi
    done < "$database"
    sleep 12
done
