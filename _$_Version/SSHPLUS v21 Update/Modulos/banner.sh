#!/bin/bash
clear
chk=$(cat /etc/ssh/sshd_config | grep Banner)
[[ $(netstat -nltp|grep 'dropbear' | wc -l) != '0' ]] && {
    local="/etc/bannerssh"
	[[ $(grep -wc $local /etc/default/dropbear) = '0' ]] && echo 'DROPBEAR_BANNER="/etc/bannerssh"' >>  /etc/default/dropbear
}
[[ "$(echo "$chk" | grep -v '#Banner' | grep Banner)" != "" ]] && {
	local=$(echo "$chk" |grep -v "#Banner" | grep Banner | awk '{print $2}')
} || {
    local="/etc/bannerssh"
    [[ $(grep -wc $local /etc/ssh/sshd_config) = '0' ]] && echo "Banner /etc/bannerssh" >> /etc/ssh/sshd_config
}
echo -e "\E[44;1;37m             BANNER             \E[0m"
echo ""
echo -e "\033[1;31m[\033[1;36m1\033[1;31m]\033[1;37m • \033[1;33mADICIONAR BANNER"
echo -e "\033[1;31m[\033[1;36m2\033[1;31m]\033[1;37m • \033[1;33mREMOVER BANNER"
echo -e "\033[1;31m[\033[1;36m3\033[1;31m]\033[1;37m • \033[1;33mVOLTAR"
echo ""
echo -ne "\033[1;32mOQUE DESEJA FAZER\033[1;31m ?\033[1;37m : "; read resp
if [[ "$resp" = "1" ]]; then
echo ""
echo -ne "\033[1;32mQUAL MENSAGEM DESEJA EXIBIR\033[1;31m ?\033[1;37m : "; read msg1
if [[ -z "$msg1" ]]; then
	echo -e "\n\033[1;31mCampo vazio ou invalido !\033[0m"
	sleep 2
	banner
fi
echo -e "\n\033[1;31m[\033[1;36m01\033[1;31m]\033[1;33m FONTE PEQUENA"
echo -e "\033[1;31m[\033[1;36m02\033[1;31m]\033[1;33m FONTE MEDIA"
echo -e "\033[1;31m[\033[1;36m03\033[1;31m]\033[1;33m FONTE GRANDE"
echo -e "\033[1;31m[\033[1;36m04\033[1;31m]\033[1;33m FONTE GIGANTE"
echo ""
echo -ne "\033[1;32mQUAL O TAMANHO DA FONTE\033[1;31m ?\033[1;37m : "; read opc
if [[ "$opc" = "1" ]] || [[ "$opc" = "01" ]]; then
_size='6'
elif [[ "$opc" = "2" ]] || [[ "$opc" = "02" ]]; then
_size='4'
elif [[ "$opc" = "3" ]] || [[ "$opc" = "03" ]]; then
_size='3'
elif [[ "$opc" = "4" ]] || [[ "$opc" = "04" ]]; then
_size='1'
fi

echo -e "\n\033[1;31m[\033[1;36m01\033[1;31m]\033[1;33m AZUL"
echo -e "\033[1;31m[\033[1;36m02\033[1;31m]\033[1;33m VERDE"
echo -e "\033[1;31m[\033[1;36m03\033[1;31m]\033[1;33m VERMELHO"
echo -e "\033[1;31m[\033[1;36m04\033[1;31m]\033[1;33m AMARELO"
echo -e "\033[1;31m[\033[1;36m05\033[1;31m]\033[1;33m ROSA"
echo -e "\033[1;31m[\033[1;36m06\033[1;31m]\033[1;33m CYANO"
echo -e "\033[1;31m[\033[1;36m07\033[1;31m]\033[1;33m LARANJA"
echo -e "\033[1;31m[\033[1;36m08\033[1;31m]\033[1;33m ROXO"
echo -e "\033[1;31m[\033[1;36m09\033[1;31m]\033[1;33m PRETO"
echo -e "\033[1;31m[\033[1;36m10\033[1;31m]\033[1;33m SEM COR"
echo ""
echo -ne "\033[1;32mQUAL A COR\033[1;31m ?\033[1;37m : "; read ban_cor
if [[ "$ban_cor" = "1" ]] || [[ "$ban_cor" = "01" ]]; then
echo "<h$_size><font color='blue'>$msg1" >> $local
elif [[ "$ban_cor" = "2" ]] || [[ "$ban_cor" = "02" ]]; then
echo "<h$_size><font color='green'>$msg1" >> $local
elif [[ "$ban_cor" = "3" ]] || [[ "$ban_cor" = "03" ]]; then
echo "<h$_size><font color='red'>$msg1" >> $local
elif [[ "$ban_cor" = "4" ]] || [[ "$ban_cor" = "04" ]]; then
echo "<h$_size><font color='yellow'>$msg1" >> $local
elif [[ "$ban_cor" = "5" ]] || [[ "$ban_cor" = "05" ]]; then
echo "<h$_size><font color='#F535AA'>$msg1" >> $local
elif [[ "$ban_cor" = "6" ]] || [[ "$ban_cor" = "06" ]]; then
echo "<h$_size><font color='cyan'>$msg1" >> $local
elif [[ "$ban_cor" = "7" ]] || [[ "$ban_cor" = "07" ]]; then
echo "<h$_size><font color='#FF7F00'>$msg1" >> $local
elif [[ "$ban_cor" = "8" ]] || [[ "$ban_cor" = "08" ]]; then
echo "<h$_size><font color='#9932CD'>$msg1" >> $local
elif [[ "$ban_cor" = "9" ]] || [[ "$ban_cor" = "09" ]]; then
echo "<h$_size><font color='black'>$msg1" >> $local
elif [[ "$ban_cor" = "10" ]]; then
echo "<h$_size>$msg1</h$_size>" >> $local
/etc/init.d/ssh restart > /dev/null 2>&1
echo -e "\n\033[1;32mBANNER DEFINIDO !\033[0m"
sleep 2
menu
else
echo -e "\n\033[1;31mOpcao invalida !\033[0m"
	sleep 2
	banner
fi
echo "</font></h$_size>" >> $local
service ssh restart > /dev/null 2>&1 && service dropbear restart > /dev/null 2>&1
echo -e "\n\033[1;32mBANNER DEFINIDO !\033[0m"
unset ban_cor
elif [[ "$resp" = "2" ]]; then
	echo " " > $local
	echo -e "\n\033[1;32mBANNER EXCLUIDO !\033[0m"
	service ssh restart > /dev/null 2>&1 && service dropbear restart > /dev/null 2>&1
	sleep 2
	menu
elif [[ "$resp" = "3" ]]; then
	menu
else
	echo -e "\n\033[1;31mOpcao invalida !\033[0m"
	sleep 2
	banner
fi