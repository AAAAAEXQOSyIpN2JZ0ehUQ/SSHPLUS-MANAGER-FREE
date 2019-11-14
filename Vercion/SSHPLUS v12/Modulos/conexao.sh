#!/bin/bash
if [[ -e /usr/lib/licence ]]; then
ram1=$(free -h | grep -i mem | awk {'print $2'})
ram2=$(free -h | grep -i mem | awk {'print $4'})
ram3=$(free -h | grep -i mem | awk {'print $3'})
uso=$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')
system=$(cat /etc/issue.net)
fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
[[ ! -d /etc/SSHPlus ]] && rm -rf /bin/menu
${comando[0]} > /dev/null 2>&1
${comando[1]} > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
echo -ne "\033[1;33mAGUARDE \033[1;37m- \033[1;33m["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 1s
   tput cuu1
   tput dl1
   echo -ne "\033[1;33mAGUARDE \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}

verif_ptrs () {
	if [ -d "/etc/squid/" ]; then
		var_sqd="/etc/squid/squid.conf"
	elif [ -d "/etc/squid3/" ]; then
		var_sqd="/etc/squid3/squid.conf"
    else
        var_sqd="/dev/null"
	fi
	if grep -w "$porta" /etc/ssh/sshd_config > /dev/null 2>&1
		then
		echo ""
		echo -e "\033[1;31mPORTA EM USO PELO SSH!"
		sleep 2
		echo ""
		echo -ne "\033[1;32mDESEJA REMOVER A PORTA \033[1;31m$porta \033[1;32mDO SSH \033[1;33m? \033[1;37m[s/n]: "; read resp
		echo ""
		if [[ "$resp" = 's' ]]; then
			echo -e "\033[1;32mREMOVENDO PORTA!"
			echo ""
			sed -i '/Port 443/d' /etc/ssh/sshd_config
			sleep 1.5
			fun_bar 'service ssh restart' 'sleep 3'
			sleep 3
		else
			echo -e "\033[1;31mRetornando...\033[0m"
			sleep 3
			clear
			fun_conexao
		fi
	fi
	if grep -w "$porta" $var_sqd > /dev/null 2>&1
		then
		echo ""
		echo -e "\033[1;31mPORTA EM USO PELO SQUID"
		sleep 3
		echo ""
		echo -ne "\033[1;32mDESEJA REMOVER A PORTA \033[1;31m$porta \033[1;32mDO SQUID ? \033[1;37m[s/n]: "; read resp
		echo ""
		if [[ "$resp" = 's' ]]; then
			echo -e "\033[1;32mREMOVENDO PORTA!"
			echo ""
			sed -i "/http_port $porta/d" $var_sqd
			fun_bar 'sleep 3'
			echo ""
			echo -e "\033[1;32mREINICIANDO SQUID!"
			echo ""
			fun_bar 'service squid3 restart' 'service squid restart'
			sleep 1
		else
			echo -e "\033[1;31mRetornando...\033[0m"
			sleep 3
			fun_conexao
		fi
	fi
	if grep -E "$porta" /etc/default/dropbear > /dev/null 2>&1; then
		echo ""
		echo -e "\033[1;31mPORTA EM USO PELO DROPBEAR!"
		sleep 3
		fun_conexao
	fi
	sockspt=$(netstat -nplt |grep 'python' | awk -F ":" {'print $2'} | cut -d " " -f 1 | xargs)
	if [[ $sockspt = $porta ]]; then
		echo ""
		echo -e "\033[1;31mPORTA EM USO PELO SOCKS!"
		sleep 3
		fun_conexao
	fi
}

inst_sqd (){
if netstat -nltp|grep 'squid' 1>/dev/null 2>/dev/null;then
	echo -e "\E[41;1;37m            REMOVER SQUID PROXY              \E[0m"
	echo ""
	echo -ne "\033[1;32mREALMENTE DESEJA REMOVER O SQUID \033[1;31m? \033[1;33m[s/n]:\033[1;37m "; read resp
	if [[ "$resp" = 's' ]]; then
		echo ""
		echo -e "\033[1;32mREMOVENDO O SQUID PROXY !\033[0m"
		echo ""
		rem_sqd () 
		{
		if [ -d "/etc/squid/" ]
			then
			apt-get remove squid -y
			apt-get purge squid -y
			rm -rf /etc/squid
		fi
		if [ -d "/etc/squid3/" ]
			then
			apt-get remove squid3 -y
			apt-get purge squid3 -y
			rm -rf /etc/squid3
		fi
	    }
	    fun_bar 'rem_sqd'
	    echo ""
		echo -e "\033[1;32mSQUID REMOVIDO COM SUCESSO !\033[0m"
		sleep 3.5s
		clear
		fun_conexao
	else
		echo ""
		echo -e "\033[1;31mRetornando...\033[0m"
		sleep 3
		clear
		fun_conexao
	fi
else
clear
echo -e "\E[44;1;37m              INSTALADOR SQUID                \E[0m"
echo ""
echo -e "\033[1;33mINSTALANDO SQUID NAS PORTAS \033[1;32m80\033[1;37m/\033[1;32m8080\033[1;37m/\033[1;32m3128\033[1;37m/\033[1;32m8799\033[0m" 
echo ""
IP=$(wget -qO- ipv4.icanhazip.com)
echo -ne "\033[1;32mPARA CONTINUAR CONFIRME SEU IP: \033[1;37m"; read -e -i $IP ipdovps
if [[ -z "$ipdovps" ]];then
echo ""
echo -e "\033[1;31mIP invalido\033[1;32m"
sleep 1
echo ""
read -p "Digite seu IP: " IP
fi
echo ""
echo -e "\033[1;32mINSTALANDO SQUID PROXY\033[0m"
echo ""
fun_bar 'apt-get update -y' 'apt-get install squid3 -y'
sleep 1
if [ -d "/etc/squid/" ]; then
var_sqd="/etc/squid/squid.conf"
var_pay="/etc/squid/payload.txt"
elif [ -d "/etc/squid3/" ]; then
var_sqd="/etc/squid3/squid.conf"
var_pay="/etc/squid3/payload.txt"
fi
sleep 1
echo ".claro.com.br/
.claro.com.sv/
.facebook.net/
.netclaro.com.br/
.speedtest.net/
.tim.com.br/
.vivo.com.br/
.oi.com.br/" > $var_pay
echo "acl url1 dstdomain -i 127.0.0.1
acl url2 dstdomain -i localhost
acl url3 dstdomain -i $ipdovps
acl url4 dstdomain -i /SSHPLUS?
acl payload url_regex -i "$var_pay"
acl all src 0.0.0.0/0

http_access allow url1
http_access allow url2
http_access allow url3
http_access allow url4
http_access allow payload
http_access deny all
 
#Portas
http_port 80
http_port 8080
http_port 3128
http_port 8799

visible_hostname SSHPLUS
 
via off
forwarded_for off
pipeline_prefetch off" > $var_sqd
if [ -f "/usr/sbin/ufw" ] ; then
	ufw allow 443/tcp ; ufw allow 80/tcp ; ufw allow 3128/tcp ; ufw allow 8799/tcp ; ufw allow 8080/tcp
fi
grep -v "^Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
echo "Port 443" >> /etc/ssh/sshd_config
grep -v "^PasswordAuthentication yes" /etc/ssh/sshd_config > /tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
sqd_conf () {
if [ -d "/etc/squid/" ]; then
squid -k reconfigure
service ssh restart
service squid restart
elif [ -d "/etc/squid3/" ]; then
squid3 -k reconfigure
service ssh restart
service squid3 restart
fi
}
echo ""
echo -e "\033[1;32mCONFIGURANDO SQUID PROXY\033[0m"
echo ""
fun_bar 'sqd_conf'
echo ""
echo -e "\033[1;32mSQUID INSTALADO COM SUCESSO!\033[0m"
sleep 3.5s
fun_conexao
fi
}

addpt_sqd () {
	echo -e "\E[44;1;37m         ADICIONAR PORTA AO SQUID         \E[0m"
	echo ""
	echo -e "\033[1;33mPORTAS EM USO: \033[1;32m$sqdp"
	echo ""
	if [ -f "/etc/squid/squid.conf" ]; then
		var_sqd="/etc/squid/squid.conf"
	elif [ -f "/etc/squid3/squid.conf" ]; then
		var_sqd="/etc/squid3/squid.conf"
	else
		echo -e "\033[1;31mSQUID NAO ESTA INSTALADO!\033[0m"
		echo ""
		echo -e "\033[1;31mRetornando...\033[0m"
		sleep 2
		clear
		fun_squid
	fi
	echo -ne "\033[1;32mQUAL PORTA DESEJA ADICIONAR \033[1;33m?\033[1;37m "; read pt
	if [[ -z "$pt" ]]; then
		echo ""
		echo -e "\033[1;31mPorta invalida!"
		sleep 3
		clear
		fun_conexao		
	fi
	if grep -E "$pt" /etc/default/dropbear > /dev/null 2>&1; then
		echo ""
		echo -e "\033[1;31mPORTA EM USO PELO DROPBEAR!"
		sleep 3
		fun_squid
	elif grep -E "$pt" $var_sqd > /dev/null 2>&1; then
		echo ""
		echo -e "\033[1;31mA PORTA \033[1;32m$pt \033[1;31mJA ESTA NO SQUID!"
		sleep 3
		clear
		fun_squid
		sockspt=$(netstat -nplt |grep 'python' | awk -F ":" {'print $2'} | cut -d " " -f 1 | xargs)
	elif [[ $sockspt = $pt ]]; then
		echo ""
		echo -e "\033[1;31mPORTA EM USO PELO SOCKS!"
		sleep 3
		fun_squid
	else
		echo ""
		echo -e "\033[1;32mADICIONANDO PORTA AO SQUID!"
		echo ""
		sed -i "s/#Portas/#Portas\nhttp_port $pt/g" $var_sqd
		fun_bar 'sleep 3'
		echo ""
		echo -e "\033[1;32mREINICIANDO O SQUID!"
		echo ""
		fun_bar 'service squid restart' 'service squid3 restart'
		echo ""
		echo -e "\033[1;32mPORTA ADICIONADA COM SUCESSO!"
		sleep 3.5s
		clear
		fun_squid
	fi
}

rempt_sqd () {
	echo -e "\E[41;1;37m        REMOVER PORTA DO SQUID        \E[0m"
	echo ""
	echo -e "\033[1;33mPORTAS EM USO: \033[1;32m$sqdp"
	echo ""
	if [ -f "/etc/squid/squid.conf" ]; then
		var_sqd="/etc/squid/squid.conf"
	elif [ -f "/etc/squid3/squid.conf" ]; then
		var_sqd="/etc/squid3/squid.conf"
	else
		echo -e "\033[1;31mSQUID NAO ESTA INSTALADO!\033[0m"
		echo ""
		echo -e "\033[1;31mRetornando...\033[0m"
		sleep 2
		clear
		fun_squid
	fi
	echo -ne "\033[1;32mQUAL PORTA DESEJA REMOVER \033[1;33m?\033[1;37m "; read pt
	if [[ -z "$pt" ]]; then
		echo ""
		echo -e "\033[1;31mPorta invalida!"
		sleep 3
		clear
		fun_conexao
	fi
	echo ""
	if grep -E "$pt" $var_sqd > /dev/null 2>&1; then
		echo -e "\033[1;32mREMOVENDO PORTA DO SQUID!"
		echo ""
		sed -i "/http_port $pt/d" $var_sqd
		fun_bar 'sleep 3'
		echo ""
		echo -e "\033[1;32mREINICIANDO O SQUID!"
		echo ""
		fun_bar 'service squid restart' 'service squid3 restart'
		echo ""
		echo -e "\033[1;32mPORTA REMOVIDA COM SUCESSO!"
		sleep 3.5s
		clear
		fun_squid
		
		sleep 3
		fun_squid
	else
		echo -e "\033[1;31mPORTA \033[1;32m$pt \033[1;31mNAO ENCONTRADA!"
		sleep 3.5s
		clear
		fun_squid
	fi
}

fun_drop () {
	if [ -d "/etc/squid/" ]; then
		var_sqd="/etc/squid/squid.conf"
	elif [ -d "/etc/squid3/" ]; then
		var_sqd="/etc/squid3/squid.conf"
    else
     var_sqd="/dev/null"
	fi
	if netstat -nltp|grep 'dropbear' 1>/dev/null 2>/dev/null;then
		clear
		if netstat -nltp|grep 'dropbear' > /dev/null; then
        dpbr=$(netstat -nplt |grep 'dropbear' | awk -F ":" {'print $4'} | xargs)
        else
        sqdp="\033[1;31mINDISPONIVEL"
        fi
        if ps x | grep "limiter"|grep -v grep 1>/dev/null 2>/dev/null; then
        	stats='\033[1;32mON'
        else
        	stats='\033[1;31mOFF'
        fi
		echo -e "\E[44;1;37m              GERENCIAR DROPBEAR               \E[0m"
		echo ""
		echo -e "\033[1;33mPORTAS\033[1;37m: \033[1;32m$dpbr"
		echo ""
		echo -e "\033[1;33m[\033[1;31m1\033[1;33m] \033[1;33mLIMITER DROPBEAR $stats\033[0m"
		echo -e "\033[1;33m[\033[1;31m2\033[1;33m] \033[1;33mALTERAR PORTA DROPBEAR\033[0m"
		echo -e "\033[1;33m[\033[1;31m3\033[1;33m] \033[1;33mREMOVER DROPBEAR\033[0m"
		echo -e "\033[1;33m[\033[1;31m0\033[1;33m] \033[1;33mVOLTAR\033[0m"
		echo ""
		echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;37m "; read resposta
		if [[ "$resposta" = '1' ]]; then
			clear
			if ps x | grep "limiter"|grep -v grep 1>/dev/null 2>/dev/null; then
				echo -e "\033[1;32mParando o limiter... \033[0m"
				echo ""
				fun_stplimiter () {
					pidlimiter=$(ps x|grep "limiter"|awk -F "pts" {'print $1'})
					kill -9 $pidlimiter
					screen -wipe
				}
				fun_bar 'fun_stplimiter' 'sleep 3'
				echo ""
				echo -e "\033[1;31m LIMITER DESATIVADO \033[0m"
				sleep 3
				fun_drop
			else
				echo ""
				echo -e "\033[1;32mIniciando o limiter... \033[0m"
				echo ""
				fun_bar 'screen -d -m -t limiter droplimiter' 'sleep 3'
				echo ""
				echo -e "\033[1;32m  LIMITER ATIVADO \033[0m"
				sleep 3
				fun_drop
			fi
		elif [[ "$resposta" = '2' ]]; then
			echo ""
			echo -ne "\033[1;32mQUAL PORTA DESEJA ULTILIZAR \033[1;33m?\033[1;37m "; read pt
			echo ""
			if grep -w "$pt" $var_sqd > /dev/null 2>&1
				then
				echo -e "\033[1;31mPORTA EM USO PELO SQUID!"
				echo ""
				echo -e "\033[1;31mRetornando...\033[0m"
				sleep 3
				clear
				fun_conexao
			else
				var1=$(sed -n '6 p' /etc/default/dropbear)
				echo -e "\033[1;32mALTERANDO PORTA DROPBEAR!"
				sed -i "s/$var1/DROPBEAR_PORT=$pt/g" /etc/default/dropbear > /dev/null 2>&1
				echo ""
				fun_bar 'sleep 3'
				echo ""
				echo -e "\033[1;32mREINICIANDO DROPBEAR!"
				echo ""
				fun_bar 'service dropbear restart' 'service ssh restart'
				echo ""
				echo -e "\033[1;32mPORTA ALTERADA COM SUCESSO!"
				sleep 3.5s
				clear
				fun_conexao
			fi
		elif [[ "$resposta" = '3' ]]; then
			echo ""
			echo -e "\033[1;32mREMOVENDO O DROPBEAR !\033[0m"
			echo ""
			fun_dropunistall () {
				service dropbear stop
				apt-get remove dropbear -y
				apt-get purge dropbear -y
				rm -rf /etc/default/dropbear
			}
			fun_bar 'fun_dropunistall'
			echo ""
			echo -e "\033[1;32mDROPBEAR REMOVIDO COM SUCESSO !\033[0m"
			sleep 3
			clear
			fun_conexao
		elif [[ "$resposta" = '0' ]]; then
			echo ""
			echo -e "\033[1;31mRetornando...\033[0m"
			sleep 2
			fun_conexao
		else
			echo ""
			echo -e "\033[1;31mOpcao invalida...\033[0m"
			sleep 3
			fun_conexao
		fi
	else
		clear
		echo -e "\E[44;1;37m           INSTALADOR DROPBEAR              \E[0m"
		echo ""
		echo -e "\033[1;33mVC ESTA PRESTES A INSTALAR O DROPBEAR !\033[0m"
		echo ""
		echo -ne "\033[1;32mDESEJA CONTINUAR \033[1;31m? \033[1;33m[s/n]:\033[1;37m "; read resposta
		if [[ "$resposta" = 's' ]]; then
			echo ""
			echo -e "\033[1;33mDEFINA UMA PORTA PARA O DROPBEAR !\033[0m"
			echo""
			echo -ne "\033[1;32mQUAL A PORTA \033[1;33m?\033[1;37m "; read porta
			if [[ -z "$porta" ]]; then
				echo ""
				echo -e "\033[1;31mPorta invalida!"
				sleep 3
				clear
				fun_conexao
			fi  
			sockspt=$(netstat -nplt |grep 'python' | awk -F ":" {'print $2'} | cut -d " " -f 1 | xargs)
			if [[ $sockspt = $porta ]]; then
				echo ""
				echo -e "\033[1;31mPORTA EM USO PELO SOCKS!"
				sleep 3
				fun_drop
			fi
				if grep -w "$porta" $var_sqd > /dev/null 2>&1
					then
					echo ""
					echo -e "\033[1;31mPORTA EM USO PELO SQUID!"
					sleep 3
					echo ""
					echo -e "\033[1;33m[\033[1;31m1\033[1;33m] \033[1;33mREMOVER A PORTA \033[1;32m$porta \033[1;33mDO SQUID\033[0m"
					echo -e "\033[1;33m[\033[1;31m2\033[1;33m] \033[1;33mREMOVER SQUID\033[0m"
					echo -e "\033[1;33m[\033[1;31m3\033[1;33m] \033[1;33mVOLTAR\033[0m"
					echo ""
					echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;37m "; read resp
					if [[ "$resp" = '1' ]]; then
						sleep 1
                        sed -i "/http_port $porta/d" $var_sqd > /dev/null 2>&1
                        sleep 2
				        echo ""
				        echo -e "\033[1;32mREMOVENDO PORTA !\033[0m"
				        echo ''
						fun_bar 'service squid3 restart' 'service squid restart'
						sleep 3
					elif [[ "$resp" = '2' ]]; then
						echo ""
						echo -e "\033[1;32mREMOVENDO SQUID !\033[0m"
						echo ""
						fun_delsquid () {
							if [ -d "/etc/squid/" ]
								then
								apt-get purge squid -y
								apt-get remove squid -y
								rm -rf /etc/squid
							fi
							if [ -d "/etc/squid3/" ]
								then
								apt-get purge squid3 -y
								apt-get remove squid3 -y
								rm -rf /etc/squid3
							fi
						}
						echo ""
						fun_bar 'fun_delsquid'
					elif [[ "$resp" = '3' ]]; then
					    echo ""
					    echo -e "\033[1;31mRetornando...\033[0m"
					    sleep 3
					    clear
					    fun_conexao
					else
						clear
						echo -e "\033[1;31mOPCAO INVALIDA!\033[0m"
						sleep 2
						echo ""
						echo -e "\033[1;31mRetornando...\033[0m"
						sleep 3
						fun_conexao
					fi
				fi
	        echo ""
			echo -e "\033[1;32mINSTALANDO O DROPBEAR ! \033[0m"
			echo ""
			fun_instdrop () {
				dpkg --configure -a
				apt-get update -y
				DEBIAN_FRONTEND=noninteractive apt-get install keyboard-configuration
				apt-get install dropbear -y
			}
			fun_bar 'fun_instdrop'
			fun_ports () {
				sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear > /dev/null 2>&1
				sed -i "s/DROPBEAR_PORT=22/DROPBEAR_PORT=$porta/g" /etc/default/dropbear > /dev/null 2>&1
				sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 110"/g' /etc/default/dropbear > /dev/null 2>&1
			}
			echo ""
			echo -e "\033[1;32mCONFIGURANDO PORTA DROPBEAR !\033[0m"
			echo ""
			fun_bar 'fun_ports' 'sleep 3'
			grep -v "^PasswordAuthentication yes" /etc/ssh/sshd_config > /tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
			echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
			grep -v "^PermitTunnel yes" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
			echo "PermitTunnel yes" >> /etc/ssh/sshd_config
			echo ""
			echo -e "\033[1;32mFINALIZANDO INSTALACAO !\033[0m"
			echo ""
			fun_ondrop () {
				/etc/init.d/dropbear dropbear start
				service dropbear start
				/etc/init.d/dropbear restart
				service dropbear restart
			}
			fun_bar 'fun_ondrop' 'sleep 3'
			echo ""
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			echo -e "         \033[1;33m● \033[1;32mINSTALACAO CONCLUIDA \033[1;33m●\033[0m"
			echo ""
			echo -e "\033[1;31m● \033[1;33mDropBear instalado e configurado com sucesso\033[0m"
			echo -e "\033[1;31m● \033[1;33mDropBear em execucao na porta \033[1;32m$porta\033[0m"
			echo -e "\033[1;31m● \033[1;33mMonitor dropbear disponivel opcao 4 do menu\033[0m"
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			if grep "/bin/false" /etc/shells >/dev/null; then
				echo -n
			else
				echo "/bin/false" >> /etc/shells
			fi
			sleep 4
			clear
			fun_conexao
		else
			echo""
			echo -e "\033[1;31mRetornando...\033[0m"
			sleep 3
			clear
			fun_conexao
		fi
	fi
}

inst_ssl () {	
if netstat -nltp|grep 'stunnel4' 1>/dev/null 2>/dev/null;then
	if [ -d "/etc/squid/" ]; then
		var_sqd="/etc/squid/squid.conf"
	elif [ -d "/etc/squid3/" ]; then
		var_sqd="/etc/squid3/squid.conf"
	fi
	if netstat -nltp|grep 'stunnel4' > /dev/null; then
		sslt=$(netstat -nplt |grep stunnel4 |awk {'print $4'} |awk -F ":" {'print $2'} |xargs)
	else
        sslt="\033[1;31mINDISPONIVEL"
    fi
    echo -e "\E[44;1;37m              GERENCIAR SSL TUNNEL               \E[0m"
    echo ""
    echo -e "\033[1;33mPORTAS\033[1;37m: \033[1;32m$sslt"
    echo ""
    echo -e "\033[1;33m[\033[1;31m1\033[1;33m] \033[1;33mALTERAR PORTA SSL TUNNEL\033[0m"
    echo -e "\033[1;33m[\033[1;31m2\033[1;33m] \033[1;33mREMOVER SSL TUNNEL\033[0m"
    echo -e "\033[1;33m[\033[1;31m0\033[1;33m] \033[1;33mVOLTAR\033[0m"
    echo ""
    echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;37m "; read resposta
    echo ""
    if [[ "$resposta" = '1' ]]; then
    echo -ne "\033[1;32mQUAL PORTA DESEJA ULTILIZAR \033[1;33m?\033[1;37m "; read porta
    echo ""
	if [[ -z "$porta" ]]; then
		echo ""
		echo -e "\033[1;31mPorta invalida!"
		sleep 3
		clear
		fun_conexao		
	fi
	if grep -w "$porta" $var_sqd > /dev/null 2>&1; then
		echo -e "\033[1;31mPORTA EM USO PELO SQUID!"
		echo ""
		echo -e "\033[1;31mRetornando...\033[0m"
		sleep 3
		clear
		fun_conexao
	elif [[ "$porta" = '22' ]]; then
		echo -e "\033[1;31mPORTA EM USO PELO SSH!"
		echo ""
		echo -e "\033[1;31mRetornando...\033[0m"
		sleep 3
		clear
		fun_conexao
	elif grep -E "$porta" /etc/ssh/sshd_config > /dev/null 2>&1; then
		echo -e "\033[1;31mPORTA EM USO PELO SSH!"
		echo ""
		echo -ne "\033[1;32mDESEJA REMOVER A PORTA \033[1;31m$porta \033[1;32mDO SSH \033[1;33m? \033[1;37m[s/n]: "; read resp
		echo ""
		if [[ "$resp" = 's' ]]; then
			echo -e "\033[1;32mREMOVENDO PORTA!"
			echo ""
			sed -i '/Port 443/d' /etc/ssh/sshd_config
			sleep 1.5
			fun_bar 'service ssh restart' 'sleep 3'
			echo ""
			sleep 3
		else
			echo -e "\033[1;31mRetornando...\033[0m"
			sleep 3
			clear
			fun_conexao
		fi
	fi
	echo -e "\033[1;32mALTERANDO PORTA SSL TUNNEL!"
	var2=$(sed -n '4 p' /etc/stunnel/stunnel.conf)
	sed -i "s/$var2/accept = $porta/g" /etc/stunnel/stunnel.conf > /dev/null 2>&1
	echo ""
	fun_bar 'sleep 3'
	echo ""
	echo -e "\033[1;32mREINICIANDO SSL TUNNEL!"
	echo ""
	fun_bar 'service stunnel4 restart' 'service ssh restart'
	echo ""
	netstat -nltp|grep 'stunnel4' > /dev/null && echo -e "\033[1;32mPORTA ALTERADA COM SUCESSO !" || echo -e "\033[1;31mERRO INESPERADO!"
	sleep 3.5s
	clear
	fun_conexao
	fi
	if [[ "$resposta" = '2' ]]; then
		echo -e "\033[1;32mREMOVENDO O  SSL TUNNEL !\033[0m"
		del_ssl () {
		service stunnel4 stop
		apt-get remove stunnel4 -y
		apt-get purge stunnel4 -y
		rm -rf /etc/stunnel/stunnel.conf
		rm -rf /etc/default/stunnel4
		rm -rf /etc/stunnel/stunnel.pem
		}
		echo ""
		fun_bar 'del_ssl' 'sleep3'
		echo ""
		echo -e "\033[1;32mSSL TUNNEL REMOVIDO COM SUCESSO!\033[0m"
		sleep 4
		fun_conexao
	else
		echo -e "\033[1;31mRetornando...\033[0m"
		sleep 3
		fun_conexao
	fi
else
	clear
	echo -e "\E[44;1;37m           INSTALADOR SSL TUNNEL             \E[0m"
	echo ""
	echo -e "\033[1;33mVC ESTA PRESTES A INSTALAR O SSL TUNNEL !\033[0m"
	echo ""
	echo -ne "\033[1;32mDESEJA CONTINUAR \033[1;31m? \033[1;33m[s/n]:\033[1;37m "; read resposta
	if [[ "$resposta" = 's' ]]; then
	echo ""
	echo -e "\033[1;33mDEFINA UMA PORTA PARA O SSL TUNNEL !\033[0m"
	echo ""
	echo -ne "\033[1;32mQUAL A PORTA \033[1;33m?\033[1;37m "; read porta
	if [[ -z "$porta" ]]; then
		echo ""
		echo -e "\033[1;31mPorta invalida!"
		sleep 3
		clear
		fun_conexao
	fi
	verif_ptrs
	echo ""
	echo -e "\033[1;32mINSTALANDO O SSL TUNNEL !\033[1;33m"
	echo ""
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/stunnel4 > /dev/null 2>&1
	fun_bar 'apt-get update -y' 'apt-get install stunnel4 -y'
	echo ""
	echo -e "\033[1;32mCONFIGURANDO O SSL TUNNEL !\033[0m"
	echo ""
	if netstat -nltp|grep 'dropbear'> /dev/null; then
		var3="dropbear"
	else
		var3="ssh"
	fi
	ssl_conf () {
echo -e "client = no
[$var3]
cert = /etc/stunnel/stunnel.pem
accept = $porta
connect = 127.0.0.1:22" > /etc/stunnel/stunnel.conf
    }
    fun_bar 'ssl_conf' 'sleep 3'
    cat stunnel4 > /etc/default/stunnel4
    rm stunnel4
    echo ""
    echo -e "\033[1;32mCRIANDO CERTIFICADO !\033[0m"
    echo ""
    echo -e "\033[1;33mRESPONDA AS QUESTOES ABAIXO !\033[1;37m"
    sleep 3
    echo ""
    openssl genrsa -out key.pem 2048
    openssl req -new -x509 -key key.pem -out cert.pem -days 1095
    cat key.pem cert.pem >> /etc/stunnel/stunnel.pem
    rm key.pem cert.pem
    clear
    echo -e "\033[1;32mREINICIANDO O SSL TUNNEL !\033[0m"
    echo ""
    fun_finssl () {
    service stunnel4 restart
    service squid3 restart
    service squid restart
    service dropbear restart
    service ssh restart
    }
    fun_bar 'fun_finssl'
    echo ""
    netstat -nltp|grep 'stunnel4' > /dev/null && echo -e "\033[1;32mSSL TUNNEL INSTALADO COM SUCESSO !\033[1;31m PORTA: \033[1;33m$porta" || echo -e "\033[1;31mERRO INESPERADO!"
    sleep 4
    clear
    fun_conexao
    else
    echo ""
    echo -e "\033[1;31mRetornando...\033[0m"
    sleep 3
    clear
    fun_conexao
    fi
fi
}
    
fun_squid () {
sqdsts=$(netstat -nltp|grep 'squid' > /dev/nell && echo -e "\033[1;32mON" || echo -e "\033[1;31mOFF")
if netstat -nltp|grep 'squid' > /dev/null; then
sqdp=$(netstat -nplt |grep 'squid' | awk -F ":" {'print $4'} | xargs)
else
sqdp="\033[1;31mINDISPONIVEL"
fi
var_sqdopc=$(netstat -nltp|grep 'squid'> /dev/null && echo -ne "REMOVER SQUID PROXY" || echo -ne "INSTALAR SQUID PROXY")
echo -e "\E[44;1;37m          GERENCIAR SQUID PROXY           \E[0m"
echo ""
echo -e "\033[1;33mPORTAS\033[1;37m: \033[1;32m$sqdp"
echo ""
echo -e "\033[1;33m[\033[1;31m1\033[1;33m] $var_sqdopc \033[1;33m
[\033[1;31m2\033[1;33m] ADICIONAR PORTA \033[1;33m
[\033[1;31m3\033[1;33m] REMOVER PORTA\033[1;33m
[\033[1;31m0\033[1;33m] VOLTAR\033[0m"
echo ""
echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;31m?\033[1;37m "; read x
clear
case $x in
	1|01)
	inst_sqd
	;;
	2|02)
	addpt_sqd
	;;
	3|03)
	rempt_sqd
	;;
	0|00)
	echo -e "\033[1;31mRetornando...\033[0m"
	sleep 1
	fun_conexao
	;;
	*)
	echo -e "\033[1;31mOpcao Invalida...\033[0m"
	sleep 2
	fun_conexao
	;;
	esac
}

fun_openvpn () {

if readlink /proc/$$/exe | grep -qs "dash"; then
	echo "This script needs to be run with bash, not sh"
	exit 1
fi

if [[ "$EUID" -ne 0 ]]; then
	echo "Sorry, you need to run this as root"
	exit 2
fi

if [[ ! -e /dev/net/tun ]]; then
	echo -e "\033[1;31mTUN TAP NAO DISPONIVEL\033[0m"
	sleep 3
	exit 3
fi

if grep -qs "CentOS release 5" "/etc/redhat-release"; then
	echo "CentOS 5 is too old and not supported"
	exit 4
fi
if [[ -e /etc/debian_version ]]; then
	OS=debian
	GROUPNAME=nogroup
	RCLOCAL='/etc/rc.local'
elif [[ -e /etc/centos-release || -e /etc/redhat-release ]]; then
	OS=centos
	GROUPNAME=nobody
	RCLOCAL='/etc/rc.d/rc.local'
else
	echo -e "SISTEMA NAO SUPORTADO"
	exit 5
fi

newclient () {
	# Generates the custom client.ovpn
	cp /etc/openvpn/client-common.txt ~/$1.ovpn
	echo "<ca>" >> ~/$1.ovpn
	cat /etc/openvpn/easy-rsa/pki/ca.crt >> ~/$1.ovpn
	echo "</ca>" >> ~/$1.ovpn
	echo "<cert>" >> ~/$1.ovpn
	cat /etc/openvpn/easy-rsa/pki/issued/$1.crt >> ~/$1.ovpn
	echo "</cert>" >> ~/$1.ovpn
	echo "<key>" >> ~/$1.ovpn
	cat /etc/openvpn/easy-rsa/pki/private/$1.key >> ~/$1.ovpn
	echo "</key>" >> ~/$1.ovpn
	echo "<tls-auth>" >> ~/$1.ovpn
	cat /etc/openvpn/ta.key >> ~/$1.ovpn
	echo "</tls-auth>" >> ~/$1.ovpn
}

# Try to get our IP from the system and fallback to the Internet.
# I do this to make the script compatible with NATed servers (lowendspirit.com)
# and to avoid getting an IPv6.
IP1=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
IP2=$(wget -4qO- "http://whatismyip.akamai.com/")
if [[ "$IP1" = "" ]]; then
	IP1=$(hostname -I |cut -d' ' -f1)
fi
if [[ "$IP1" != "$IP2" ]]; then
	IP="$IP1"
else
	IP="$IP2"
fi

if [[ -e /etc/openvpn/server.conf ]]; then
	while :
	do
		clear
	    opnp=$(cat /etc/openvpn/server.conf |grep "port" |awk {'print $2'})
	    if [ -d /var/www/html/openvpn ] > /dev/nell; then
	    	ovpnweb=$(echo -e "\033[1;32mON")
	    else
	    	ovpnweb=$(echo -e "\033[1;31mOFF")
	    fi
	    if grep "duplicate-cn" /etc/openvpn/server.conf > /dev/null; then
	    	mult=$(echo -e "\033[1;32mON")
	    else
	    	mult=$(echo -e "\033[1;31mOFF")
	    fi
		echo -e "\E[44;1;37m          GERENCIAR OPENVPN           \E[0m"
		echo ""
		echo -e "\033[1;33mPORTA\033[1;37m: \033[1;32m$opnp"
		echo ""
		echo -e "\033[1;33m[\033[1;31m1\033[1;33m] \033[1;33mALTERAR PORTA"
		echo -e "\033[1;33m[\033[1;31m2\033[1;33m] \033[1;33mREMOVER OPENVPN"
		echo -e "\033[1;33m[\033[1;31m3\033[1;33m] \033[1;33mOVPN VIA LINK $ovpnweb"
		echo -e "\033[1;33m[\033[1;31m4\033[1;33m] \033[1;33mMULTILOGIN OVPN $mult"
		echo -e "\033[1;33m[\033[1;31m5\033[1;33m] \033[1;33mALTERAR HOST DNS"
		echo -e "\033[1;33m[\033[1;31m0\033[1;33m] \033[1;33mVOLTAR"
		echo ""
		echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;31m?\033[1;37m "; read option
		case $option in
			1) 
			clear
			echo -e "\E[44;1;37m         ALTERAR PORTA OPENVPN         \E[0m"
			echo ""
			echo -e "\033[1;33mPORTA EM USO: \033[1;32m$opnp"
			echo ""
			echo -ne "\033[1;32mQUAL PORTA DESEJA UTILIZAR \033[1;33m?\033[1;37m "; read porta
			if [[ -z "$porta" ]]; then
				echo ""
				echo -e "\033[1;31mPorta invalida!"
				sleep 3
				fun_conexao
			fi
			verif_ptrs
			echo ""
			echo -e "\033[1;32mALTERANDO A PORTA OPENVPN!\033[1;33m"
			echo ""
			fun_opn () {
			var_ptovpn=$(sed -n '1 p' /etc/openvpn/server.conf)
			sed -i "s/$var_ptovpn/port $porta/g" /etc/openvpn/server.conf
			sleep 1 
			var_ptovpn2=$(sed -n '7 p' /etc/openvpn/client-common.txt | awk {'print $NF'})
			sed -i "s/$var_ptovpn2/ $porta/g" /etc/openvpn/client-common.txt
			sleep 1
			service openvpn restart
		    }
		    fun_bar 'fun_opn'
		    echo ""
		    echo -e "\033[1;32mPORTA ALTERADA COM SUCESSO!\033[1;33m"
		    sleep 3
		    fun_conexao
			;;
			2) 
			echo ""
			echo -ne "\033[1;32mDESEJA REMOVER O OPENVPN \033[1;31m? \033[1;33m[s/n]:\033[1;37m "; read REMOVE
			if [[ "$REMOVE" = 's' ]]; then
				rmv_open () {
				PORT=$(grep '^port ' /etc/openvpn/server.conf | cut -d " " -f 2)
				PROTOCOL=$(grep '^proto ' /etc/openvpn/server.conf | cut -d " " -f 2)
				IP=$(grep 'iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -j SNAT --to ' $RCLOCAL | cut -d " " -f 11)
				if pgrep firewalld; then
					# Using both permanent and not permanent rules to avoid a firewalld reload.
					firewall-cmd --zone=public --remove-port=$PORT/$PROTOCOL
					firewall-cmd --zone=trusted --remove-source=10.8.0.0/24
					firewall-cmd --permanent --zone=public --remove-port=$PORT/$PROTOCOL
					firewall-cmd --permanent --zone=trusted --remove-source=10.8.0.0/24
				fi
				if iptables -L -n | grep -qE 'REJECT|DROP|ACCEPT'; then
					iptables -D INPUT -p $PROTOCOL --dport $PORT -j ACCEPT
					iptables -D FORWARD -s 10.8.0.0/24 -j ACCEPT
					iptables -D FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
					sed -i "/iptables -I INPUT -p $PROTOCOL --dport $PORT -j ACCEPT/d" $RCLOCAL
					sed -i "/iptables -I FORWARD -s 10.8.0.0\/24 -j ACCEPT/d" $RCLOCAL
					sed -i "/iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT/d" $RCLOCAL
				fi
				iptables -t nat -D POSTROUTING -s 10.8.0.0/24 -j SNAT --to $IP
				sed -i '/iptables -t nat -A POSTROUTING -s 10.8.0.0\/24 -j SNAT --to /d' $RCLOCAL
				if hash sestatus 2>/dev/null; then
					if sestatus | grep "Current mode" | grep -qs "enforcing"; then
						if [[ "$PORT" != '1194' || "$PROTOCOL" = 'tcp' ]]; then
							semanage port -d -t openvpn_port_t -p $PROTOCOL $PORT
						fi
					fi
				fi
				if [[ "$OS" = 'debian' ]]; then
					apt-get remove --purge -y openvpn openvpn-blacklist
					apt-get autoremove -y
				else
					yum remove openvpn -y
				fi
				rm -rf /etc/openvpn
				rm -rf /usr/share/doc/openvpn*
			    }
			    echo ""
			    echo -e "\033[1;32mREMOVENDO O OPENVPN!\033[0m"
			    echo ""
			    fun_bar 'rmv_open'
				echo ""
				echo -e "\033[1;32mOPENVPN REMOVIDO COM SUCESSO!\033[0m"
				sleep 3
				fun_conexao
			else
				echo ""
				echo -e "\033[1;31mRetornando...\033[0m"
				sleep 2
				fun_conexao
			fi
			;;
			3)
            if [ -d /var/www/html/openvpn ] > /dev/nell; then
            	clear
            	fun_spcr () {
            	apt-get remove apache2 -y
            	apt-get autoremove -y
            	rm -rf /var/www/html/openvpn
                }
                function aguarde {
                	helice () {
                		fun_spcr > /dev/null 2>&1 & 
                		tput civis
                		while [ -d /proc/$! ]
                		do
                			for i in / - \\ \|
                			do
                				sleep .1
                				echo -ne "\e[1D$i"
                			done
                		done
                		tput cnorm
                	}
                	echo -ne "\033[1;31mDESATIVANDO\033[1;32m.\033[1;33m.\033[1;31m. \033[1;33m"
                	helice
                	echo -e "\e[1DOk"
                }
                aguarde
                sleep 2
                fun_openvpn
            else
            	clear
            	fun_apchon () {
            		apt-get install apache2 zip -y
            		sed -i "s/Listen 80/Listen 81/g" /etc/apache2/ports.conf
            		service apache2 restart
            		if [ ! -d /var/www/html ]; then
            			mkdir /var/www/html
            		fi
            		if [ ! -d /var/www/html/openvpn ]; then
            			mkdir /var/www/html/openvpn
            		fi
            		touch /var/www/html/openvpn/index.html
            		chmod -R 755 /var/www
            		/etc/init.d/apache2 restart
            	}
            	function aguarde2 {
                	helice () {
                		fun_apchon > /dev/null 2>&1 & 
                		tput civis
                		while [ -d /proc/$! ]
                		do
                			for i in / - \\ \|
                			do
                				sleep .1
                				echo -ne "\e[1D$i"
                			done
                		done
                		tput cnorm
                	}
                	echo -ne "\033[1;32mATIVANDO\033[1;32m.\033[1;33m.\033[1;31m. \033[1;33m"
                	helice
                	echo -e "\e[1DOk"
                }
                aguarde2
            	sleep 2
                fun_openvpn
            fi
            ;;
			4)
            if grep "duplicate-cn" /etc/openvpn/server.conf > /dev/null; then
            	clear
            	fun_multon () {
            	sed -i '/duplicate-cn/d' /etc/openvpn/server.conf
            	sleep 1.5s
            	service openvpn restart > /dev/null
            	sleep 2
                }
                fun_spinmult () {
                	helice () {
                		fun_multon > /dev/null 2>&1 & 
                		tput civis
                		while [ -d /proc/$! ]
                		do
                			for i in / - \\ \|
                			do
                				sleep .1
                				echo -ne "\e[1D$i"
                			done
                		done
                		tput cnorm
                	}
                	echo ""
                	echo -ne "\033[1;31mBLOQUEANDO MULTILOGIN\033[1;32m.\033[1;33m.\033[1;31m. \033[1;33m"
                	helice
                	echo -e "\e[1DOk"
                }
                fun_spinmult
            	sleep 2
                fun_openvpn
            else
            	clear
            	fun_multoff () {
            	grep -v "^duplicate-cn" /etc/openvpn/server.conf > /tmp/tmpass && mv /tmp/tmpass /etc/openvpn/server.conf
            	echo "duplicate-cn" >> /etc/openvpn/server.conf
            	sleep 1.5s
            	service openvpn restart > /dev/null
            	sleep 2
                }
                fun_spinmult2 () {
                	helice () {
                		fun_multoff > /dev/null 2>&1 & 
                		tput civis
                		while [ -d /proc/$! ]
                		do
                			for i in / - \\ \|
                			do
                				sleep .1
                				echo -ne "\e[1D$i"
                			done
                		done
                		tput cnorm
                	}
                	echo ""
                	echo -ne "\033[1;32mPERMITINDO MULTILOGIN\033[1;32m.\033[1;33m.\033[1;31m. \033[1;33m"
                	helice
                	echo -e "\e[1DOk"
                }
                fun_spinmult2
            	sleep 2
                fun_openvpn
            fi
            ;;
            5)
            clear
            echo -e "\E[44;1;37m         ALTERAR HOST DNS           \E[0m"
			echo ""
			echo -e "\033[1;33m[\033[1;31m1\033[1;33m] \033[1;33mADICIONAR HOST DNS"
			echo -e "\033[1;33m[\033[1;31m2\033[1;33m] \033[1;33mREMOVER HOST DNS"
			echo -e "\033[1;33m[\033[1;31m3\033[1;33m] \033[1;33mEDITAR MANUALMENTE"
			echo -e "\033[1;33m[\033[1;31m0\033[1;33m] \033[1;33mVOLTAR"
			echo ""
			echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;31m?\033[1;37m "; read resp
			if [[ -z "$resp" ]]; then
				echo ""
				echo -e "\033[1;31mOpcao invalida!"
				sleep 3
				fun_openvpn
			fi
			if [[ "$resp" = '1' ]]; then
				clear
				echo -e "\E[44;1;37m            Adicionar Host DNS            \E[0m"
				echo ""
				echo -e "\033[1;33mLista dos hosts atuais:\033[0m "
				echo ""
				i=0
				for _host in `grep -w "127.0.0.1" /etc/hosts | grep -v "localhost" | cut -d' ' -f2`; do
					echo -e "\033[1;32m$_host"
				done
				echo ""
				echo -ne "\033[1;33mDigite o host a ser adicionado\033[1;37m : " ; read host
				if [[ -z $host ]]; then
					echo ""
					echo -e "\E[41;1;37m        Campo Vazio ou invalido !       \E[0m"
					sleep 2
					fun_openvpn
				fi
				if [[ "$(grep -w "$host" /etc/hosts | wc -l)" -gt "0" ]] ; then
					echo -e "\E[41;1;37m    Esse host ja está adicionado  !    \E[0m"
					sleep 2
					fun_openvpn
				fi
				sed -i "3i\127.0.0.1 $host" /etc/hosts
				echo ""
				echo -e "\E[44;1;37m      Host adicionado com sucesso !      \E[0m"
			    sleep 2
			    exit 1
			elif [[ "$resp" = '2' ]]; then
				clear
				echo -e "\E[44;1;37m            Remover Host DNS            \E[0m"
				echo ""
				echo -e "\033[1;33mLista dos hosts atuais:\033[0m "
				echo ""
				i=0
				for _host in `grep -w "127.0.0.1" /etc/hosts | grep -v "localhost" | cut -d' ' -f2`; do
					i=$(expr $i + 1)
					oP+=$i
					[[ $i == [1-9] ]] && oP+=" 0$i" && i=0$i
					oP+=":$_host\n"
					echo -e "\033[1;33m[\033[1;31m$i\033[1;33m] \033[1;37m- \033[1;32m$_host\033[0m"
				done
				echo ""
				echo -ne "\033[1;32mSelecione o host a ser removido \033[1;33m[\033[1;37m1\033[1;31m-\033[1;37m$i\033[1;33m]\033[1;37m: " ; read option
				if [[ -z $option ]]; then
					echo ""
					echo -e "\E[41;1;37m          Opcao invalida  !        \E[0m"
					sleep 2
					fun_openvpn
				fi
				host=$(echo -e "$oP" | grep -E "\b$option\b" | cut -d: -f2)
				hst=$(grep -v "127.0.0.1 $host" /etc/hosts)
				echo "$hst" > /etc/hosts
				echo ""
				echo -e "\E[41;1;37m      Host removido com sucesso !      \E[0m"
			    sleep 2
			    fun_openvpn
			elif [[ "$resp" = '3' ]]; then
				echo ""
			    echo -e "\033[1;32mALTERANDO ARQUIVO \033[1;37m/etc/hosts\033[0m"
			    echo ""
			    echo -e "\033[1;31mATENCAO!\033[0m"
			    echo ""
			    echo -e "\033[1;33mPARA SALVAR USE AS TECLAS \033[1;32mctrl x y\033[0m"
			    sleep 4
			    clear
			    nano /etc/hosts
			    echo ""
			    echo -e "\033[1;32mALTERADO COM SUCESSO!\033[0m"
			    sleep 3
			    fun_openvpn
			elif [[ "$resp" = '0' ]]; then
				echo ""
				echo -e "\033[1;31mRetornando...\033[0m"
				sleep 2
				fun_conexao
			else
				echo ""
				echo -e "\033[1;31mOpcao invalida !\033[0m"
				sleep 2
				fun_openvpn
			fi
			;;
			0)
            fun_conexao
            ;;
            *)
            echo ""
            echo -e "\033[1;31mOpcao invalida !\033[0m"
            sleep 2
            fun_openvpn
		esac
	done
else
	clear
	echo -e "\E[44;1;37m              INSTALADOR OPENVPN               \E[0m"
	echo ""
	# OpenVPN instalador e criação do primeiro usuario
	echo -e "\033[1;33mRESPONDA AS QUESTOES PARA INICIAR A INSTALACAO"
	echo ""
	echo -ne "\033[1;32mPARA CONTINUAR CONFIRME SEU IP: \033[1;37m"; read -e -i $IP IP
	if [[ -z "$IP" ]]; then
				echo ""
				echo -e "\033[1;31mIP invalido!"
				sleep 3
				fun_conexao
	fi
	echo ""
	read -p "$(echo -e "\033[1;32mQUAL PORTA DESEJA UTILIZAR? \033[1;37m")" -e -i 1194 porta
	if [[ -z "$porta" ]]; then
				echo ""
				echo -e "\033[1;31mPorta invalida!"
				sleep 3
				fun_conexao
	fi
	echo ""
	echo -e "\033[1;33mVERIFICANDO PORTA..."
	sleep 2
	verif_ptrs
	echo ""
	echo -e "\033[1;33m[\033[1;31m1\033[1;33m] \033[1;33mSistema"
	echo -e "\033[1;33m[\033[1;31m2\033[1;33m] \033[1;33mGoogle (\033[1;32mRecomendado\033[1;33m)"
	echo -e "\033[1;33m[\033[1;31m3\033[1;33m] \033[1;33mOpenDNS"
	echo -e "\033[1;33m[\033[1;31m4\033[1;33m] \033[1;33mNTT"
	echo -e "\033[1;33m[\033[1;31m5\033[1;33m] \033[1;33mHurricane Electric"
	echo -e "\033[1;33m[\033[1;31m6\033[1;33m] \033[1;33mVerisign"
	echo -e "\033[1;33m[\033[1;31m7\033[1;33m] \033[1;33mDNS Performace\033[0m"
	echo ""
	read -p "$(echo -e "\033[1;32mQUAL DNS DESEJA UTILIZAR? \033[1;37m")" -e -i 2 DNS
	echo ""
	echo -e "\033[1;33m[\033[1;31m1\033[1;33m] \033[1;33mUDP"
	echo -e "\033[1;33m[\033[1;31m2\033[1;33m] \033[1;33mTCP (\033[1;32mRecomendado\033[1;33m)"
	echo ""
	read -p "$(echo -e "\033[1;32mQUAL PROTOCOLO DESEJA UTILIZAR NO OPENVPN ? \033[1;37m")" -e -i 2 resp
	if [[ "$resp" = '1' ]]; then
		PROTOCOL=udp
	elif [[ "$resp" = '2' ]]; then
		PROTOCOL=tcp
	else
		PROTOCOL=tcp
	fi
	echo ""
	if [[ "$OS" = 'debian' ]]; then
		echo -e "\033[1;32mATUALIZANDO O SISTEMA"
		echo ""
		fun_attos () {
		apt-get update-y
		apt-get upgrade -y
	    }
	    fun_bar 'fun_attos'
		echo ""
		echo -e "\033[1;32mINSTALANDO DEPENDENCIAS"
		echo ""
		fun_instdep () {
		apt-get install openvpn iptables openssl ca-certificates -y
		apt-get install zip -y
	    }
	    fun_bar 'fun_instdep'
	else
		# Else, the distro is CentOS
		fun_bar 'yum install epel-release -y'
		fun_bar 'yum install openvpn iptables openssl wget ca-certificates -y'
	fi
	# An old version of easy-rsa was available by default in some openvpn packages
	if [[ -d /etc/openvpn/easy-rsa/ ]]; then
		rm -rf /etc/openvpn/easy-rsa/
	fi
	# Adquirindo easy-rsa
	echo ""
	fun_dep () {
	wget -O ~/EasyRSA-3.0.1.tgz "https://github.com/OpenVPN/easy-rsa/releases/download/3.0.1/EasyRSA-3.0.1.tgz"
	tar xzf ~/EasyRSA-3.0.1.tgz -C ~/
	mv ~/EasyRSA-3.0.1/ /etc/openvpn/
	mv /etc/openvpn/EasyRSA-3.0.1/ /etc/openvpn/easy-rsa/
	chown -R root:root /etc/openvpn/easy-rsa/
	rm -rf ~/EasyRSA-3.0.1.tgz
	cd /etc/openvpn/easy-rsa/
	# Create the PKI, set up the CA, the DH params and the server + client certificates
	./easyrsa init-pki
	./easyrsa --batch build-ca nopass
	./easyrsa gen-dh
	./easyrsa build-server-full server nopass
	./easyrsa build-client-full SSHPLUS nopass
	./easyrsa gen-crl
	# Move the stuff we need
	cp pki/ca.crt pki/private/ca.key pki/dh.pem pki/issued/server.crt pki/private/server.key /etc/openvpn/easy-rsa/pki/crl.pem /etc/openvpn
	# CRL is read with each client connection, when OpenVPN is dropped to nobody
	chown nobody:$GROUPNAME /etc/openvpn/crl.pem
	# Generando key for tls-auth
	openvpn --genkey --secret /etc/openvpn/ta.key
	# Generando server.conf
	echo "port $porta
proto $PROTOCOL
dev tun
sndbuf 0
rcvbuf 0
ca ca.crt
cert server.crt
key server.key
dh dh.pem
tls-auth ta.key 0
topology subnet
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt" > /etc/openvpn/server.conf
	echo 'push "redirect-gateway def1 bypass-dhcp"' >> /etc/openvpn/server.conf
	# DNS
	case $DNS in
		1) 
		# Obtain the resolvers from resolv.conf and use them for OpenVPN
		grep -v '#' /etc/resolv.conf | grep 'nameserver' | grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | while read line; do
			echo "push \"dhcp-option DNS $line\"" >> /etc/openvpn/server.conf
		done
		;;
		2) 
		echo 'push "dhcp-option DNS 8.8.8.8"' >> /etc/openvpn/server.conf
		echo 'push "dhcp-option DNS 8.8.4.4"' >> /etc/openvpn/server.conf
		;;
		3)
		echo 'push "dhcp-option DNS 208.67.222.222"' >> /etc/openvpn/server.conf
		echo 'push "dhcp-option DNS 208.67.220.220"' >> /etc/openvpn/server.conf
		;;
		4) 
		echo 'push "dhcp-option DNS 129.250.35.250"' >> /etc/openvpn/server.conf
		echo 'push "dhcp-option DNS 129.250.35.251"' >> /etc/openvpn/server.conf
		;;
		5) 
		echo 'push "dhcp-option DNS 74.82.42.42"' >> /etc/openvpn/server.conf
		;;
		6) 
		echo 'push "dhcp-option DNS 64.6.64.6"' >> /etc/openvpn/server.conf
		echo 'push "dhcp-option DNS 64.6.65.6"' >> /etc/openvpn/server.conf
		;;
		7)
		echo 'push "dhcp-option DNS 189.38.95.95"' >> /etc/openvpn/server.conf
		echo 'push "dhcp-option DNS 216.146.36.36"' >> /etc/openvpn/server.conf
	esac
	echo "keepalive 10 20
float
cipher AES-256-CBC
comp-lzo yes
user nobody
group $GROUPNAME
persist-key
persist-tun
status openvpn-status.log
management localhost 7505
verb 3
crl-verify crl.pem
client-to-client
client-cert-not-required
username-as-common-name
plugin /usr/lib/openvpn/openvpn-plugin-auth-pam.so login" >> /etc/openvpn/server.conf
	# Enable net.ipv4.ip_forward for the system
	sed -i '/\<net.ipv4.ip_forward\>/c\net.ipv4.ip_forward=1' /etc/sysctl.conf
	if ! grep -q "\<net.ipv4.ip_forward\>" /etc/sysctl.conf; then
		echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
	fi
	# Avoid an unneeded reboot
	echo 1 > /proc/sys/net/ipv4/ip_forward
	# Needed to use rc.local with some systemd distros
	if [[ "$OS" = 'debian' && ! -e $RCLOCAL ]]; then
		echo '#!/bin/sh -e
exit 0' > $RCLOCAL
	fi
	chmod +x $RCLOCAL
	# Set NAT for the VPN subnet
	iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -j SNAT --to $IP
	sed -i "1 a\iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -j SNAT --to $IP" $RCLOCAL
	if pgrep firewalld; then
		# We don't use --add-service=openvpn because that would only work with
		# the default port and protocol. Using both permanent and not permanent
		# rules to avoid a firewalld reload.
		firewall-cmd --zone=public --add-port=$porta/$PROTOCOL
		firewall-cmd --zone=trusted --add-source=10.8.0.0/24
		firewall-cmd --permanent --zone=public --add-port=$porta/$PROTOCOL
		firewall-cmd --permanent --zone=trusted --add-source=10.8.0.0/24
	fi
	if iptables -L -n | grep -qE 'REJECT|DROP'; then
		# If iptables has at least one REJECT rule, we asume this is needed.
		# Not the best approach but I can't think of other and this shouldn't
		# cause problems.
		iptables -I INPUT -p $PROTOCOL --dport $porta -j ACCEPT
		iptables -I FORWARD -s 10.8.0.0/24 -j ACCEPT
          iptables -F
		iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
		sed -i "1 a\iptables -I INPUT -p $PROTOCOL --dport $porta -j ACCEPT" $RCLOCAL
		sed -i "1 a\iptables -I FORWARD -s 10.8.0.0/24 -j ACCEPT" $RCLOCAL
		sed -i "1 a\iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT" $RCLOCAL
	fi
	# If SELinux is enabled and a custom port or TCP was selected, we need this
	if hash sestatus 2>/dev/null; then
		if sestatus | grep "Current mode" | grep -qs "enforcing"; then
			if [[ "$porta" != '1194' || "$PROTOCOL" = 'tcp' ]]; then
				# semanage isn't available in CentOS 6 by default
				if ! hash semanage 2>/dev/null; then
					yum install policycoreutils-python -y
				fi
				semanage port -a -t openvpn_port_t -p $PROTOCOL $porta
			fi
		fi
	fi
	}
	echo -e "\033[1;32mINSTALANDO O OPENVPN  \033[1;31m(\033[1;33mPODE DEMORAR!\033[1;31m)"
	echo ""
	fun_bar 'fun_dep'
	# And finally, restart OpenVPN
	fun_ropen () {
	if [[ "$OS" = 'debian' ]]; then
		# Little hack to check for systemd
		if pgrep systemd-journal; then
			systemctl restart openvpn@server.service
		else
			/etc/init.d/openvpn restart
		fi
	else
		if pgrep systemd-journal; then
			systemctl restart openvpn@server.service
			systemctl enable openvpn@server.service
		else
			service openvpn restart
			chkconfig openvpn on
		fi
	fi
	}
	echo ""
	echo -e "\033[1;32mREINICIANDO O OPENVPN"
	echo ""
	fun_bar 'fun_ropen'
	# Try to detect a NATed connection and ask about it to potential LowEndSpirit users
	IP2=$(wget -4qO- "http://whatismyip.akamai.com/")
	if [[ "$IP" != "$IP2" ]]; then
			IP="$IP2"
	fi
	# client-common.txt is created so we have a template to add further users later
	echo "client
dev tun
proto $PROTOCOL
sndbuf 0
rcvbuf 0
setenv opt method GET
remote /SSHPLUS? $porta
http-proxy-option CUSTOM-HEADER Host portalrecarga.vivo.com.br/recarga
http-proxy $IP 80
resolv-retry 5
nobind
persist-key
persist-tun
remote-cert-tls server
cipher AES-256-CBC
comp-lzo yes
setenv opt block-outside-dns
key-direction 1
verb 3
auth-user-pass
keepalive 10 20
float" > /etc/openvpn/client-common.txt
	# Generates the custom client.ovpn
	newclient "SSHPLUS"
	echo ""
	echo -e "\033[1;32mOPENVPN INSTALADO COM SUCESSO\033[0m"
fi
sed -i '$ i\echo 1 > /proc/sys/net/ipv4/ip_forward' /etc/rc.local
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local
sed -i '$ i\iptables -A INPUT -p tcp --dport 25 -j DROP' /etc/rc.local
sed -i '$ i\iptables -A INPUT -p tcp --dport 110 -j DROP' /etc/rc.local
sed -i '$ i\iptables -A OUTPUT -p tcp --dport 25 -j DROP' /etc/rc.local
sed -i '$ i\iptables -A OUTPUT -p tcp --dport 110 -j DROP' /etc/rc.local
sed -i '$ i\iptables -A FORWARD -p tcp --dport 25 -j DROP' /etc/rc.local
sed -i '$ i\iptables -A FORWARD -p tcp --dport 110 -j DROP' /etc/rc.local
sleep 3
fun_conexao
}

fun_socks () {
	clear
    if ps x | grep proxy.py|grep -v grep 1>/dev/null 2>/dev/null; then
    	sks='\033[1;32mON'
    	sockspt=$(netstat -nplt |grep 'python' | awk -F ":" {'print $2'} | cut -d " " -f 1 | xargs)
    	var_sks1="DESATIVAR SOCKS"
    else
    	sks='\033[1;31mOFF'
    	sockspt="\033[1;31mINDISPONIVEL"
    	var_sks1="ATIVAR SOCKS"
    fi
    echo -e "\E[44;1;37m            GERENCIAR PROXY SOCKS             \E[0m"
    echo ""
    echo -e "\033[1;33mPORTAS\033[1;37m: \033[1;32m$sockspt"
    echo ""
	echo -e "\033[1;33m[\033[1;31m1\033[1;33m] \033[1;33m$var_sks1\033[0m"
	echo -e "\033[1;33m[\033[1;31m2\033[1;33m] \033[1;33mABRIR PORTA\033[0m"
	echo -e "\033[1;33m[\033[1;31m3\033[1;33m] \033[1;33mALTERAR STATUS\033[0m"
	echo -e "\033[1;33m[\033[1;31m0\033[1;33m] \033[1;33mVOLTAR\033[0m"
	echo ""
	echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;37m "; read resposta
	if [[ "$resposta" = '1' ]]; then
		if ps x | grep proxy.py|grep -v grep 1>/dev/null 2>/dev/null; then
			clear
			echo -e "\E[41;1;37m             PROXY SOCKS              \E[0m"
			echo ""
			fun_socksoff () {
				for pidproxy in  `screen -ls | grep ".proxy" | awk {'print $1'}`; do
					screen -r -S "$pidproxy" -X quit
				done
				if grep -w "SSHPlus" /etc/rc.local > /dev/null 2>&1; then
					sed -i '/proxy.py/d' /etc/rc.local
				fi
				sleep 1
				screen -wipe > /dev/null
			}
			echo -e "\033[1;32mDESATIVANDO O PROXY SOCKS\033[1;33m"
			echo ""
			fun_bar 'fun_socksoff'
			echo ""
			echo -e "\033[1;32mPROXY SOCKS DESATIVADO COM SUCESSO!\033[1;33m"
			sleep 3
			fun_socks
		else
			clear
			echo -e "\E[44;1;37m             PROXY SOCKS              \E[0m"
		    echo ""
		    echo -ne "\033[1;32mQUAL PORTA DESEJA ULTILIZAR \033[1;33m?\033[1;37m: "; read porta
		    if [[ -z "$porta" ]]; then
		    	echo ""
		    	echo -e "\033[1;31mPorta invalida!"
		    	sleep 3
		    	clear
		    	fun_conexao
		    fi
		    verif_ptrs
		    fun_inisocks () {
		    	sleep 1
		    	var_ptsks2=$(sed -n "12 p" /etc/SSHPlus/proxy.py | awk -F = '{print $2}')
		    	sed -i "s/$var_ptsks2/ $porta/g" /etc/SSHPlus/proxy.py
		    	sleep 1
		    	screen -dmS proxy python /etc/SSHPlus/proxy.py
		    	if grep -w "SSHPlus" /etc/rc.local > /dev/null 2>&1; then
		    		echo ""
		    	else
		    		sed -i '$ iscreen -dmS proxy python /etc/SSHPlus/proxy.py' /etc/rc.local
			    fi
		    }
		    echo ""
		    echo -e "\033[1;32mINICIANDO O PROXY SOCKS\033[1;33m"
		    echo ""
		    fun_bar 'fun_inisocks'
		    echo ""
		    echo -e "\033[1;32mPROXY SOCKS ATIVADO COM SUCESSO\033[1;33m"
		    sleep 3
		    fun_socks
		fi
	elif [[ "$resposta" = '2' ]]; then
		if ps x | grep proxy.py|grep -v grep 1>/dev/null 2>/dev/null; then
			clear
			echo -e "\E[44;1;37m            PROXY SOCKS             \E[0m"
			echo ""
			echo -e "\033[1;33mPORTAS EM USO: \033[1;32m$sockspt"
			echo ""
			echo -ne "\033[1;32mQUAL PORTA DESEJA ULTILIZAR \033[1;33m?\033[1;37m: "; read porta
			if [[ -z "$porta" ]]; then
				echo ""
				echo -e "\033[1;31mPorta invalida!"
				sleep 3
				clear
				fun_conexao
			fi
			verif_ptrs
			echo ""
			echo -e "\033[1;32mINICIANDO O PROXY SOCKS NA PORTA \033[1;31m$porta\033[1;33m"
			echo ""
			abrirptsks () {
				sleep 1
				screen -dmS proxy python /etc/SSHPlus/proxy.py $porta
				sleep 1
			}
			fun_bar 'abrirptsks'
			echo ""
			echo -e "\033[1;32mPROXY SOCKS ATIVADO COM SUCESSO\033[1;33m"
			sleep 3
			fun_socks
		else
			clear
			echo -e "\033[1;31mFUNCAO INDISPONIVEL\033[1;33m"
			sleep 2
			fun_socks
		fi
	elif [[ "$resposta" = '3' ]]; then
		if ps x | grep proxy.py|grep -v grep 1>/dev/null 2>/dev/null; then
			clear
			msgsocks=$(cat /etc/SSHPlus/proxy.py |grep -E "MSG =" | awk -F = '{print $2}' |cut -d "'" -f 2)
			echo -e "\E[44;1;37m             PROXY SOCKS              \E[0m"
			echo ""
			echo -e "\033[1;33mSTATUS: \033[1;32m$msgsocks"
			echo""
			echo -ne "\033[1;32mINFORME SEU STATUS\033[1;31m:\033[1;37m "; read msgg
			if [[ -z "$msgg" ]]; then
				echo ""
				echo -e "\033[1;31mStatus invalido!"
				sleep 3
				fun_conexao
			fi
			fun_msgsocks () {
				msgsocks2=$(cat /etc/SSHPlus/proxy.py |grep "MSG =" | awk -F = '{print $2}')
				sed -i "s/$msgsocks2/ '$msgg'/g" /etc/SSHPlus/proxy.py
				sleep 1
			}
			echo ""
			echo -e "\033[1;32mALTERANDO STATUS!"
			echo ""
			fun_bar 'fun_msgsocks'
			restartsocks () {
				if ps x | grep proxy.py|grep -v grep 1>/dev/null 2>/dev/null; then
					for pidproxy in  `screen -ls | grep ".proxy" | awk {'print $1'}`; do
						screen -r -S "$pidproxy" -X quit
					done
					screen -wipe > /dev/null
					sleep 1
					screen -dmS proxy python /etc/SSHPlus/proxy.py
				fi
			}
			echo ""
			echo -e "\033[1;32mREINICIANDO PROXY SOCKS!"
			echo ""
			fun_bar 'restartsocks'
			echo ""
			echo -e "\033[1;32mSTATUS ALTERADO COM SUCESSO!"
			sleep 3
			fun_socks
		else
			clear
			echo -e "\033[1;31mFUNCAO INDISPONIVEL\033[1;33m"
			sleep 2
			fun_socks
		fi
	elif [[ "$resposta" = '0' ]]; then
		echo ""
		echo -e "\033[1;31mRetornando...\033[0m"
		sleep 2
		fun_conexao
	else
		echo ""
		echo -e "\033[1;31mOpcao invalida !\033[0m"
		sleep 2
		fun_socks
	fi

}

x="ok"
fun_conexao () {
while true $x != "ok"
do
sts1=$(netstat -nltp|grep 'squid' > /dev/null && echo -ne "\033[1;32mON" || echo -ne "\033[1;31mOFF")
sts2=$(netstat -nltp|grep 'dropbear' > /dev/null && echo -ne "\033[1;32mON" || echo -ne "\033[1;31mOFF")
sts3=$(netstat -nltp|grep 'stunnel4' > /dev/null && echo -ne "\033[1;32mON" || echo -ne "\033[1;31mOFF")
sts4=$(ps x | grep proxy.py|grep -v grep 1>/dev/null 2>/dev/null && echo -ne "\033[1;32mON" || echo -ne "\033[1;31mOFF")
if [[ -e /etc/openvpn/server.conf ]]; then 
sts5=$(echo -ne "\033[1;32mON")
else
sts5=$(echo -ne "\033[1;31mOFF")
fi
if ps x | grep "limiter"|grep -v grep 1>/dev/null 2>/dev/null; then
statuslimit="\033[1;32mATIVADO"
else
statuslimit="\033[1;31mDESATIVADO"
fi
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
_ram=$(printf ' %-9s' "$(free -h | grep -i mem | awk {'print $2'})")
_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
_usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
_core=$(printf '%-1s' "$(grep -c cpu[0-9] /proc/stat)")
_system=$(printf '%-14s' "$system")
_hora=$(printf '%(%H:%M:%S)T')
clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[41;1;37m               ❖ SSHPLUS MANAGER ❖                \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;32mSISTEMA            MEMÓRIA RAM      PROCESSADOR "
echo -e "\033[1;31mOS: \033[1;37m$_system \033[1;31mTotal:\033[1;37m$_ram \033[1;31mNucleos: \033[1;37m$_core\033[0m"
echo -e "\033[1;31mHora:\033[1;37m $_hora     \033[1;31mEm uso: \033[1;37m$_usor \033[1;31mEm uso: \033[1;37m$_usop\033[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
echo -e "                \033[1;33m● \033[1;36mMODO DE CONEXAO \033[1;33m●\033[0m"
echo ""
echo -e "\033[1;33m[\033[1;31m1\033[1;33m] SQUID PROXY\033[1;33m $sts1\033[1;33m
[\033[1;31m2\033[1;33m] DROPBEAR\033[1;33m $sts2\033[1;33m
[\033[1;31m3\033[1;33m] OPENVPN\033[1;33m $sts5\033[1;33m
[\033[1;31m4\033[1;33m] PROXY SOCKS\033[1;33m $sts4\033[1;33m
[\033[1;31m5\033[1;33m] SSL TUNNEL\033[1;33m $sts3\033[1;33m
[\033[1;31m6\033[1;33m] VOLTAR \033[1;32m<\033[1;33m<\033[1;31m< \033[1;33m
[\033[1;31m0\033[1;33m] SAIR \033[1;32m<\033[1;33m<\033[1;31m< \033[0m"
echo ""
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
tput civis
echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;31m?\033[1;37m "; read x
tput cnorm
clear
case $x in
	1|01)
	fun_squid
	;;
	2|02)
	fun_drop
	;;
	3|03)
	fun_openvpn
	;;
	4|04)
	fun_socks
	;;
	5|05)
	inst_ssl
	;;
	6|06)
	menu
	;;
	0|00)
	echo -e "\033[1;31mSaindo...\033[0m"
	sleep 2
	clear
	exit;
	;;
	*)
	echo -e "\033[1;31mOpcao invalida !\033[0m"
	sleep 2
esac
done
}
fun_conexao
else
	rm -rf /bin/criarusuario /bin/expcleaner /bin/sshlimiter /bin/addhost /bin/listar /bin/sshmonitor /bin/ajuda /bin/menu /bin/OpenVPN /bin/userbackup /bin/tcpspeed /bin/badvpn /bin/otimizar /bin/speedtest /bin/trafego /bin/banner /bin/limit /bin/Usercreate /bin/senharoot /bin/reiniciarservicos /bin/reiniciarsistema /bin/attscript /bin/criarteste /bin/socks  /bin/DropBear /bin/alterarlimite /bin/alterarsenha /bin/remover /bin/detalhes /bin/mudardata /bin/botssh /bin/versao > /dev/null 2>&1
    rm -rf /etc/SSHPlus > /dev/null 2>&1
    clear
    exit 0
fi
