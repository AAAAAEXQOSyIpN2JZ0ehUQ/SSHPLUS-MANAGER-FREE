#!/bin/bash
clear
database="$HOME/usuarios.db"
fun_drop () {
port_dropbear=`ps aux | grep dropbear | awk NR==1 | awk '{print $17;}'`
log=/var/log/auth.log
loginsukses='Password auth succeeded'
clear
pids=`ps ax |grep dropbear |grep  " $port_dropbear" |awk -F" " '{print $1}'`
for pid in $pids
do
    pidlogs=`grep $pid $log |grep "$loginsukses" |awk -F" " '{print $3}'`
    i=0
    for pidend in $pidlogs
    do
      let i=i+1
    done
    if [ $pidend ];then
       login=`grep $pid $log |grep "$pidend" |grep "$loginsukses"`
       PID=$pid
       user=`echo $login |awk -F" " '{print $10}' | sed -r "s/'/ /g"`
       waktu=`echo $login |awk -F" " '{print $2"-"$1,$3}'`
       while [ ${#waktu} -lt 13 ]; do
           waktu=$waktu" "
       done
       while [ ${#user} -lt 16 ]; do
           user=$user" "
       done
       while [ ${#PID} -lt 8 ]; do
           PID=$PID" "
       done
       echo "$user $PID $waktu"
    fi
done
}
echo -e "\E[44;1;37m Usuario         Senha       limite      validade \E[0m"
echo ""
[[ -e /tmp/online.txt ]] && rm /tmp/online.txt > /dev/null
[[ ! -e /bin/versao ]] && rm -rf /bin/menu /bin/conexao > /dev/null
for users in `awk -F : '$3 > 900 { print $1 }' /etc/passwd |sort |grep -v "nobody" |grep -vi polkitd |grep -vi system-`
do
sqd="$(ps -u $users | grep sshd | wc -l)"
if [[ -e /etc/openvpn/openvpn-status.log ]]; then
   ovp="$(cat /etc/openvpn/openvpn-status.log | grep -E ,"$users", | wc -l)"
else
ovp=0
fi
if netstat -nltp|grep 'dropbear' > /dev/null;then
   drop="$(fun_drop | grep "$users" | wc -l)"
else
   drop=0
fi
cnx=$(($sqd + $drop))
conex=$(($cnx + $ovp))
echo "$conex" >> /tmp/online.txt
if grep -w "$users" $database > /dev/null 2>&1
then
lim=$(grep -w "$users" $database | cut -d ' ' -f2)
else
lim="Null"
fi
if cat /etc/SSHPlus/senha/$users > /dev/null 2>&1
then
senha=$(cat /etc/SSHPlus/senha/$users)
else
senha="Null"
fi
datauser=$(chage -l $users |grep -i co |awk -F : '{print $2}')
if [ $datauser = never ] 2> /dev/null
then
data="\033[1;33mNunca\033[0m"
else
    databr="$(date -d "$datauser" +"%Y%m%d")"
    hoje="$(date -d today +"%Y%m%d")"
    if [ $hoje -ge $databr ]
    then
    cont=$(( $cont + 1 ))
    data="\033[1;31mVenceu\033[0m"
    else
    dat="$(date -d"$datauser" '+%Y-%m-%d')"
    data=$(echo -e "$((($(date -ud $dat +%s)-$(date -ud $(date +%Y-%m-%d) +%s))/86400)) \033[1;37mDias\033[0m")
    fi
fi
Usuario=$(printf ' %-15s' "$users")
Senha=$(printf '%-13s' "$senha")
Limite=$(printf '%-10s' "$lim")
Data=$(printf '%-1s' "$data")
echo -e "\033[1;33m$Usuario \033[1;37m$Senha \033[1;37m$Limite \033[1;32m$Data\033[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
done
if [[ $(paste -s -d + /tmp/online.txt | bc) -eq 0 ]]; then
    on='00'
    else
    on="$(paste -s -d + /tmp/online.txt | bc)"
fi
[[ "$cont" = "" ]] && cont="00"
echo ""
tuser=$(cat $database | wc -l)
echo -e "\033[1;33m• \033[1;36mTOTAL USUARIOS\033[1;37m: $tuser \033[1;33m• \033[1;32mONLINES\033[1;37m: $on \033[1;33m• \033[1;31mVENCIDOS\033[1;37m: $cont\033[0m"