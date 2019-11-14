#!/bin/bash
clear
chk=$(cat /etc/ssh/sshd_config | grep Banner)
if netstat -nltp|grep 'dropbear' > /dev/null;then
	echo 'DROPBEAR_BANNER="/etc/default/banner"' >>  /etc/default/dropbear
	local="/etc/dropbear/banner"
elif [ "$(echo "$chk" | grep -v "#Banner" | grep Banner)" != "" ]; then
	local=$(echo "$chk" |grep -v "#Banner" | grep Banner | awk '{print $2}')
else
	echo "Banner /etc/bannerssh" >> /etc/ssh/sshd_config
	local="/etc/bannerssh"
fi
echo -e "\E[44;1;37m             BANNER             \E[0m"
echo ""
echo -e "\033[1;33m[\033[1;31m1\033[1;33m]\033[1;33m ADICIONAR BANNER"
echo -e "\033[1;33m[\033[1;31m2\033[1;33m]\033[1;33m REMOVER BANNER"
echo -e "\033[1;33m[\033[1;31m3\033[1;33m]\033[1;33m VOLTAR"
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
echo ""
echo -e "\033[1;33m[\033[1;31m01\033[1;33m]\033[1;33m AZUL"
echo -e "\033[1;33m[\033[1;31m02\033[1;33m]\033[1;33m VERDE"
echo -e "\033[1;33m[\033[1;31m03\033[1;33m]\033[1;33m VERMELHO"
echo -e "\033[1;33m[\033[1;31m04\033[1;33m]\033[1;33m AMARELO"
echo -e "\033[1;33m[\033[1;31m05\033[1;33m]\033[1;33m ROSA"
echo -e "\033[1;33m[\033[1;31m06\033[1;33m]\033[1;33m CYANO"
echo -e "\033[1;33m[\033[1;31m07\033[1;33m]\033[1;33m LARANJA"
echo -e "\033[1;33m[\033[1;31m08\033[1;33m]\033[1;33m ROXO"
echo -e "\033[1;33m[\033[1;31m09\033[1;33m]\033[1;33m PRETO"
echo -e "\033[1;33m[\033[1;31m10\033[1;33m]\033[1;33m SEM COR"
echo ""
echo -ne "\033[1;32mQUAL A COR\033[1;31m ?\033[1;37m : "; read ban_cor
if [[ "$ban_cor" = "1" ]] || [[ "$ban_cor" = "01" ]]; then
echo "<h5><font color='blue'>$msg1" >> $local
elif [[ "$ban_cor" = "2" ]] || [[ "$ban_cor" = "02" ]]; then
echo "<h5><font color='green'>$msg1" >> $local
elif [[ "$ban_cor" = "3" ]] || [[ "$ban_cor" = "03" ]]; then
echo "<h5><font color='red'>$msg1" >> $local
elif [[ "$ban_cor" = "4" ]] || [[ "$ban_cor" = "04" ]]; then
echo "<h5><font color='yellow'>$msg1" >> $local
elif [[ "$ban_cor" = "5" ]] || [[ "$ban_cor" = "05" ]]; then
echo "<h5><font color='#F535AA'>$msg1" >> $local
elif [[ "$ban_cor" = "6" ]] || [[ "$ban_cor" = "06" ]]; then
echo "<h5><font color='cyan'>$msg1" >> $local
elif [[ "$ban_cor" = "7" ]] || [[ "$ban_cor" = "07" ]]; then
echo "<h5><font color='#FF7F00'>$msg1" >> $local
elif [[ "$ban_cor" = "8" ]] || [[ "$ban_cor" = "08" ]]; then
echo "<h5><font color='#9932CD'>$msg1" >> $local
elif [[ "$ban_cor" = "9" ]] || [[ "$ban_cor" = "09" ]]; then
echo "<h5><font color='black'>$msg1" >> $local
elif [[ "$ban_cor" = "10" ]]; then
echo "<h5>$msg1</h5>" >> $local
service ssh restart > /dev/null 2>&1
echo -e "\n\033[1;32mBANNER DEFINIDO !\033[0m"
sleep 2
menu
else
echo -e "\n\033[1;31mOpcao invalida !\033[0m"
	sleep 2
	banner
fi
echo '</font></h5>' >> $local
service ssh restart > /dev/null 2>&1
echo -e "\n\033[1;32mBANNER DEFINIDO !\033[0m"
unset ban_cor
elif [[ "$resp" = "2" ]]; then
	echo " " > $local
	echo -e "\n\033[1;32mBANNER EXCLUIDO !\033[0m"
	service ssh restart > /dev/null 2>&1
	sleep 2
	menu
elif [[ "$resp" = "3" ]]; then
	menu
else
	echo -e "\n\033[1;31mOpcao invalida !\033[0m"
	sleep 2
	banner
fi