#!/bin/bash
#====================================================
#	SCRIPT: CONEXAO SSHPLUS MANAGER
#	DESENVOLVIDO POR:	CRAZY_VPN
#	CONTATO TELEGRAM:	http://t.me/crazy_vpn
#	CANAL TELEGRAM:	http://t.me/sshplus
#====================================================
[[ $(awk -F" " '{print $2}' /usr/lib/licence) == "@crazy_vpn" ]] && {
	ram1=$(free -h | grep -i mem | awk {'print $2'})
	ram2=$(free -h | grep -i mem | awk {'print $4'})
	ram3=$(free -h | grep -i mem | awk {'print $3'})
	uso=$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')
	system=$(cat /etc/issue.net)
	fun_bar() {
		comando[0]="$1"
		comando[1]="$2"
		(
			[[ -e $HOME/fim ]] && rm $HOME/fim
			[[ ! -d /etc/SSHPlus ]] && rm -rf /bin/menu
			${comando[0]} >/dev/null 2>&1
			${comando[1]} >/dev/null 2>&1
			touch $HOME/fim
		) >/dev/null 2>&1 &
		tput civis
		echo -ne "\033[1;33mAGUARDE \033[1;37m- \033[1;33m["
		while true; do
			for ((i = 0; i < 18; i++)); do
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

	verif_ptrs() {
		porta=$1
		PT=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" | grep -v "COMMAND" | grep "LISTEN")
		for pton in $(echo -e "$PT" | cut -d: -f2 | cut -d' ' -f1 | uniq); do
			svcs=$(echo -e "$PT" | grep -w "$pton" | awk '{print $1}' | uniq)
			[[ "$porta" = "$pton" ]] && {
				echo -e "\n\033[1;31mPORTA \033[1;33m$porta \033[1;31mEM USO PELO \033[1;37m$svcs\033[0m"
				sleep 3
				fun_conexao
			}
		done
	}

	inst_sqd() {
		if netstat -nltp | grep 'squid' 1>/dev/null 2>/dev/null; then
			echo -e "\E[41;1;37m            REMOVER SQUID PROXY              \E[0m"
			echo ""
			echo -ne "\033[1;32mREALMENTE DESEJA REMOVER O SQUID \033[1;31m? \033[1;33m[s/n]:\033[1;37m "
			read resp
			[[ "$resp" = 's' ]] && {
				echo -e "\n\033[1;32mREMOVENDO O SQUID PROXY !\033[0m"
				echo ""
				rem_sqd() {
					[[ -d "/etc/squid" ]] && {
						apt-get remove squid -y >/dev/null 2>&1
						apt-get purge squid -y >/dev/null 2>&1
						rm -rf /etc/squid >/dev/null 2>&1
					}
					[[ -d "/etc/squid3" ]] && {
						apt-get remove squid3 -y >/dev/null 2>&1
						apt-get purge squid3 -y >/dev/null 2>&1
						rm -rf /etc/squid3 >/dev/null 2>&1
					}
				}
				fun_bar 'rem_sqd'
				echo -e "\n\033[1;32mSQUID REMOVIDO COM SUCESSO !\033[0m"
				sleep 2
				clear
				fun_conexao
			} || {
				echo -e "\n\033[1;31mRetornando...\033[0m"
				sleep 2
				clear
				fun_conexao
			}
		else
			clear
			echo -e "\E[44;1;37m              INSTALADOR SQUID                \E[0m"
			echo ""
			IP=$(wget -qO- ipv4.icanhazip.com)
			echo -ne "\033[1;32mPARA CONTINUAR CONFIRME SEU IP: \033[1;37m"
			read -e -i $IP ipdovps
			[[ -z "$ipdovps" ]] && {
				echo -e "\n\033[1;31mIP invalido\033[1;32m"
				echo ""
				read -p "Digite seu IP: " IP
			}
			echo -e "\n\033[1;33mQUAIS PORTAS DESEJA ULTILIZAR NO SQUID \033[1;31m?"
			echo -e "\n\033[1;33m[\033[1;31m!\033[1;33m] \033[1;32mDEFINA AS PORTAS EM SEQUENCIA \033[1;33mEX: \033[1;37m80 8080 8799"
			echo ""
			echo -ne "\033[1;32mINFORME AS PORTAS\033[1;37m: "
			read portass
			[[ -z "$portass" ]] && {
				echo -e "\n\033[1;31mPorta invalida!"
				sleep 3
				fun_conexao
			}
			for porta in $(echo -e $portass); do
				verif_ptrs $porta
			done
			echo -e "\n\033[1;32mINSTALANDO SQUID PROXY\033[0m"
			echo ""
			fun_bar 'apt-get update -y' 'apt-get install squid3 -y'
			sleep 1
			[[ -d "/etc/squid/" ]] && {
				var_sqd="/etc/squid/squid.conf"
				var_pay="/etc/squid/payload.txt"
			} || {
				[[ -d "/etc/squid3/" ]] && {
					var_sqd="/etc/squid3/squid.conf"
					var_pay="/etc/squid3/payload.txt"
				}
			}
			echo ".claro.com.br/
.claro.com.sv/
.facebook.net/
.netclaro.com.br/
.speedtest.net/
.tim.com.br/
.vivo.com.br/
.oi.com.br/" >$var_pay
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
 
#Portas" >$var_sqd
			for Pts in $(echo -e $portass); do
				echo -e "http_port $Pts" >>$var_sqd
				[[ -f "/usr/sbin/ufw" ]] && ufw allow $Pts/tcp
			done
			echo -e "
#Nome squid
visible_hostname SSHPLUS 
via off
forwarded_for off
pipeline_prefetch off" >>$var_sqd
			sqd_conf() {
				[[ -d "/etc/squid/" ]] && {
					squid -k reconfigure
					service ssh restart
					service squid restart
				} || {
					[[ -d "/etc/squid3/" ]] && {
						squid3 -k reconfigure
						service ssh restart
						service squid3 restart
					}
				}
			}
			echo -e "\n\033[1;32mCONFIGURANDO SQUID PROXY\033[0m"
			echo ""
			fun_bar 'sqd_conf'
			echo -e "\n\033[1;32mSQUID INSTALADO COM SUCESSO!\033[0m"
			sleep 3.5s
			fun_conexao
		fi
	}

	addpt_sqd() {
		echo -e "\E[44;1;37m         ADICIONAR PORTA AO SQUID         \E[0m"
		echo -e "\n\033[1;33mPORTAS EM USO: \033[1;32m$sqdp\n"
		if [[ -f "/etc/squid/squid.conf" ]]; then
			var_sqd="/etc/squid/squid.conf"
		elif [[ -f "/etc/squid3/squid.conf" ]]; then
			var_sqd="/etc/squid3/squid.conf"
		else
			echo -e "\n\033[1;31mSQUID NAO ESTA INSTALADO!\033[0m"
			echo -e "\n\033[1;31mRetornando...\033[0m"
			sleep 2
			clear
			fun_squid
		fi
		echo -ne "\033[1;32mQUAL PORTA DESEJA ADICIONAR \033[1;33m?\033[1;37m "
		read pt
		[[ -z "$pt" ]] && {
			echo -e "\n\033[1;31mPorta invalida!"
			sleep 2
			clear
			fun_conexao
		}
		verif_ptrs $pt
		echo -e "\n\033[1;32mADICIONANDO PORTA AO SQUID!"
		echo ""
		sed -i "s/#Portas/#Portas\nhttp_port $pt/g" $var_sqd
		fun_bar 'sleep 2'
		echo -e "\n\033[1;32mREINICIANDO O SQUID!"
		echo ""
		fun_bar 'service squid restart' 'service squid3 restart'
		echo -e "\n\033[1;32mPORTA ADICIONADA COM SUCESSO!"
		sleep 3
		clear
		fun_squid
	}

	rempt_sqd() {
		echo -e "\E[41;1;37m        REMOVER PORTA DO SQUID        \E[0m"
		echo -e "\n\033[1;33mPORTAS EM USO: \033[1;32m$sqdp\n"
		if [[ -f "/etc/squid/squid.conf" ]]; then
			var_sqd="/etc/squid/squid.conf"
		elif [[ -f "/etc/squid3/squid.conf" ]]; then
			var_sqd="/etc/squid3/squid.conf"
		else
			echo -e "\n\033[1;31mSQUID NAO ESTA INSTALADO!\033[0m"
			echo -e "\n\033[1;31mRetornando...\033[0m"
			sleep 2
			clear
			fun_squid
		fi
		echo -ne "\033[1;32mQUAL PORTA DESEJA REMOVER \033[1;33m?\033[1;37m "
		read pt
		[[ -z "$pt" ]] && {
			echo -e "\n\033[1;31mPorta invalida!"
			sleep 2
			clear
			fun_conexao
		}
		if grep -E "$pt" $var_sqd >/dev/null 2>&1; then
			echo -e "\n\033[1;32mREMOVENDO PORTA DO SQUID!"
			echo ""
			sed -i "/http_port $pt/d" $var_sqd
			fun_bar 'sleep 3'
			echo -e "\n\033[1;32mREINICIANDO O SQUID!"
			echo ""
			fun_bar 'service squid restart' 'service squid3 restart'
			echo -e "\n\033[1;32mPORTA REMOVIDA COM SUCESSO!"
			sleep 3.5s
			clear
			fun_squid
		else
			echo -e "\n\033[1;31mPORTA \033[1;32m$pt \033[1;31mNAO ENCONTRADA!"
			sleep 3.5s
			clear
			fun_squid
		fi
	}

	fun_squid() {
		[[ "$(netstat -nplt | grep -c 'squid')" = "0" ]] && inst_sqd
		echo -e "\E[44;1;37m          GERENCIAR SQUID PROXY           \E[0m"
		[[ "$(netstat -nplt | grep -c 'squid')" != "0" ]] && {
			sqdp=$(netstat -nplt | grep 'squid' | awk -F ":" {'print $4'} | xargs)
			echo -e "\n\033[1;33mPORTAS\033[1;37m: \033[1;32m$sqdp"
			VarSqdOn="REMOVER SQUID PROXY"
		} || {
			VarSqdOn="INSTALAR SQUID PROXY"
		}
		echo -e "\n\033[1;31m[\033[1;36m1\033[1;31m] \033[1;37m• \033[1;33m$VarSqdOn \033[1;31m
[\033[1;36m2\033[1;31m] \033[1;37m• \033[1;33mADICIONAR PORTA \033[1;31m
[\033[1;36m3\033[1;31m] \033[1;37m• \033[1;33mREMOVER PORTA\033[1;31m
[\033[1;36m0\033[1;31m] \033[1;37m• \033[1;33mVOLTAR\033[0m"
		echo ""
		echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;31m?\033[1;37m "
		read x
		clear
		case $x in
		1 | 01)
			inst_sqd
			;;
		2 | 02)
			addpt_sqd
			;;
		3 | 03)
			rempt_sqd
			;;
		0 | 00)
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

	fun_drop() {
		if netstat -nltp | grep 'dropbear' 1>/dev/null 2>/dev/null; then
			clear
			[[ $(netstat -nltp | grep -c 'dropbear') != '0' ]] && dpbr=$(netstat -nplt | grep 'dropbear' | awk -F ":" {'print $4'} | xargs) || sqdp="\033[1;31mINDISPONIVEL"
			if ps x | grep "limiter" | grep -v grep 1>/dev/null 2>/dev/null; then
				stats='\033[1;32m◉ '
			else
				stats='\033[1;31m○ '
			fi
			echo -e "\E[44;1;37m              GERENCIAR DROPBEAR               \E[0m"
			echo -e "\n\033[1;33mPORTAS\033[1;37m: \033[1;32m$dpbr"
			echo ""
			echo -e "\033[1;31m[\033[1;36m1\033[1;31m] \033[1;37m• \033[1;33mLIMITER DROPBEAR $stats\033[0m"
			echo -e "\033[1;31m[\033[1;36m2\033[1;31m] \033[1;37m• \033[1;33mALTERAR PORTA DROPBEAR\033[0m"
			echo -e "\033[1;31m[\033[1;36m3\033[1;31m] \033[1;37m• \033[1;33mREMOVER DROPBEAR\033[0m"
			echo -e "\033[1;31m[\033[1;36m0\033[1;31m] \033[1;37m• \033[1;33mVOLTAR\033[0m"
			echo ""
			echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;37m "
			read resposta
			if [[ "$resposta" = '1' ]]; then
				clear
				if ps x | grep "limiter" | grep -v grep 1>/dev/null 2>/dev/null; then
					echo -e "\033[1;32mParando o limiter... \033[0m"
					echo ""
					fun_stplimiter() {
						pidlimiter=$(ps x | grep "limiter" | awk -F "pts" {'print $1'})
						kill -9 $pidlimiter
						screen -wipe
					}
					fun_bar 'fun_stplimiter' 'sleep 2'
					echo -e "\n\033[1;31m LIMITER DESATIVADO \033[0m"
					sleep 3
					fun_drop
				else
					echo -e "\n\033[1;32mIniciando o limiter... \033[0m"
					echo ""
					fun_bar 'screen -d -m -t limiter droplimiter' 'sleep 3'
					echo -e "\n\033[1;32m  LIMITER ATIVADO \033[0m"
					sleep 3
					fun_drop
				fi
			elif [[ "$resposta" = '2' ]]; then
				echo ""
				echo -ne "\033[1;32mQUAL PORTA DESEJA ULTILIZAR \033[1;33m?\033[1;37m "
				read pt
				echo ""
				verif_ptrs $pt
				var1=$(grep 'DROPBEAR_PORT=' /etc/default/dropbear | cut -d'=' -f2)
				echo -e "\033[1;32mALTERANDO PORTA DROPBEAR!"
				sed -i "s/\b$var1\b/$pt/g" /etc/default/dropbear >/dev/null 2>&1
				echo ""
				fun_bar 'sleep 2'
				echo -e "\n\033[1;32mREINICIANDO DROPBEAR!"
				echo ""
				fun_bar 'service dropbear restart' '/etc/init.d/dropbear restart'
				echo -e "\n\033[1;32mPORTA ALTERADA COM SUCESSO!"
				sleep 3
				clear
				fun_conexao
			elif [[ "$resposta" = '3' ]]; then
				echo -e "\n\033[1;32mREMOVENDO O DROPBEAR !\033[0m"
				echo ""
				fun_dropunistall() {
					service dropbear stop && /etc/init.d/dropbear stop
					apt-get autoremove dropbear -y
					apt-get remove dropbear-run -y
					apt-get remove dropbear -y
					apt-get purge dropbear -y
					rm -rf /etc/default/dropbear
				}
				fun_bar 'fun_dropunistall'
				echo -e "\n\033[1;32mDROPBEAR REMOVIDO COM SUCESSO !\033[0m"
				sleep 3
				clear
				fun_conexao
			elif [[ "$resposta" = '0' ]]; then
				echo -e "\n\033[1;31mRetornando...\033[0m"
				sleep 2
				fun_conexao
			else
				echo -e "\n\033[1;31mOpcao invalida...\033[0m"
				sleep 2
				fun_conexao
			fi
		else
			clear
			echo -e "\E[44;1;37m           INSTALADOR DROPBEAR              \E[0m"
			echo -e "\n\033[1;33mVC ESTA PRESTES A INSTALAR O DROPBEAR !\033[0m\n"
			echo -ne "\033[1;32mDESEJA CONTINUAR \033[1;31m? \033[1;33m[s/n]:\033[1;37m "
			read resposta
			[[ "$resposta" = 's' ]] && {
				echo -e "\n\033[1;33mDEFINA UMA PORTA PARA O DROPBEAR !\033[0m\n"
				echo -ne "\033[1;32mQUAL A PORTA \033[1;33m?\033[1;37m "
				read porta
				[[ -z "$porta" ]] && {
					echo -e "\n\033[1;31mPorta invalida!"
					sleep 3
					clear
					fun_conexao
				}
				verif_ptrs $porta
				echo -e "\n\033[1;32mINSTALANDO O DROPBEAR ! \033[0m"
				echo ""
				fun_instdrop() {
					apt-get update -y
					apt-get install dropbear -y
				}
				fun_bar 'fun_instdrop'
				fun_ports() {
					sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear >/dev/null 2>&1
					sed -i "s/DROPBEAR_PORT=22/DROPBEAR_PORT=$porta/g" /etc/default/dropbear >/dev/null 2>&1
					sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 110"/g' /etc/default/dropbear >/dev/null 2>&1
				}
				echo ""
				echo -e "\033[1;32mCONFIGURANDO PORTA DROPBEAR !\033[0m"
				echo ""
				fun_bar 'fun_ports'
				grep -v "^PasswordAuthentication yes" /etc/ssh/sshd_config >/tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
				echo "PasswordAuthentication yes" >>/etc/ssh/sshd_config
				grep -v "^PermitTunnel yes" /etc/ssh/sshd_config >/tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
				echo "PermitTunnel yes" >>/etc/ssh/sshd_config
				echo ""
				echo -e "\033[1;32mFINALIZANDO INSTALACAO !\033[0m"
				echo ""
				fun_ondrop() {
					service dropbear start
					/etc/init.d/dropbear restart
				}
				fun_bar 'fun_ondrop' 'sleep 1'
				echo -e "\n\033[1;32mINSTALACAO CONCLUIDA \033[1;33mPORTA: \033[1;37m$porta\033[0m"
				[[ $(grep -c "/bin/false" /etc/shells) = '0' ]] && echo "/bin/false" >>/etc/shells
				sleep 2
				clear
				fun_conexao
			} || {
				echo""
				echo -e "\033[1;31mRetornando...\033[0m"
				sleep 3
				clear
				fun_conexao
			}
		fi
	}

	inst_ssl() {
		if netstat -nltp | grep 'stunnel4' 1>/dev/null 2>/dev/null; then
			[[ $(netstat -nltp | grep 'stunnel4' | wc -l) != '0' ]] && sslt=$(netstat -nplt | grep stunnel4 | awk {'print $4'} | awk -F ":" {'print $2'} | xargs) || sslt="\033[1;31mINDISPONIVEL"
			echo -e "\E[44;1;37m              GERENCIAR SSL TUNNEL               \E[0m"
			echo -e "\n\033[1;33mPORTAS\033[1;37m: \033[1;32m$sslt"
			echo ""
			echo -e "\033[1;31m[\033[1;36m1\033[1;31m] \033[1;37m• \033[1;33mALTERAR PORTA SSL TUNNEL\033[0m"
			echo -e "\033[1;31m[\033[1;36m2\033[1;31m] \033[1;37m• \033[1;33mREMOVER SSL TUNNEL\033[0m"
			echo -e "\033[1;31m[\033[1;36m0\033[1;31m] \033[1;37m• \033[1;33mVOLTAR\033[0m"
			echo ""
			echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;37m "
			read resposta
			echo ""
			[[ "$resposta" = '1' ]] && {
				echo -ne "\033[1;32mQUAL PORTA DESEJA ULTILIZAR \033[1;33m?\033[1;37m "
				read porta
				echo ""
				[[ -z "$porta" ]] && {
					echo ""
					echo -e "\033[1;31mPorta invalida!"
					sleep 2
					clear
					fun_conexao
				}
				verif_ptrs $porta
				echo -e "\033[1;32mALTERANDO PORTA SSL TUNNEL!"
				var2=$(grep 'accept' /etc/stunnel/stunnel.conf | awk '{print $NF}')
				sed -i "s/\b$var2\b/$porta/g" /etc/stunnel/stunnel.conf >/dev/null 2>&1
				echo ""
				fun_bar 'sleep 2'
				echo ""
				echo -e "\033[1;32mREINICIANDO SSL TUNNEL!\n"
				fun_bar 'service stunnel4 restart' '/etc/init.d/stunnel4 restart'
				echo ""
				netstat -nltp | grep 'stunnel4' >/dev/null && echo -e "\033[1;32mPORTA ALTERADA COM SUCESSO !" || echo -e "\033[1;31mERRO INESPERADO!"
				sleep 3.5s
				clear
				fun_conexao
			}
			[[ "$resposta" = '2' ]] && {
				echo -e "\033[1;32mREMOVENDO O  SSL TUNNEL !\033[0m"
				del_ssl() {
					service stunnel4 stop
					apt-get remove stunnel4 -y
					apt-get autoremove stunnel4 -y
					apt-get purge stunnel4 -y
					rm -rf /etc/stunnel/stunnel.conf
					rm -rf /etc/default/stunnel4
					rm -rf /etc/stunnel/stunnel.pem
				}
				echo ""
				fun_bar 'del_ssl'
				echo ""
				echo -e "\033[1;32mSSL TUNNEL REMOVIDO COM SUCESSO!\033[0m"
				sleep 3
				fun_conexao
			} || {
				echo -e "\033[1;31mRetornando...\033[0m"
				sleep 3
				fun_conexao
			}
		else
			clear
			echo -e "\E[44;1;37m           INSTALADOR SSL TUNNEL             \E[0m"
			echo -e "\n\033[1;33mVC ESTA PRESTES A INSTALAR O SSL TUNNEL !\033[0m"
			echo ""
			echo -ne "\033[1;32mDESEJA CONTINUAR \033[1;31m? \033[1;33m[s/n]:\033[1;37m "
			read resposta
			[[ "$resposta" = 's' ]] && {
				echo -e "\n\033[1;33mDEFINA UMA PORTA PARA O SSL TUNNEL !\033[0m"
				echo ""
				read -p "$(echo -e "\033[1;32mQUAL PORTA DESEJA UTILIZAR? \033[1;37m")" -e -i 3128 porta
				[[ -z "$porta" ]] && {
					echo ""
					echo -e "\033[1;31mPorta invalida!"
					sleep 3
					clear
					fun_conexao
				}
				verif_ptrs $porta
				echo -e "\n\033[1;32mINSTALANDO O SSL TUNNEL !\033[1;33m"
				echo ""
				fun_bar 'apt-get update -y' 'apt-get install stunnel4 -y'
				echo -e "\n\033[1;32mCONFIGURANDO O SSL TUNNEL !\033[0m"
				echo ""
				ssl_conf() {
					echo -e "cert = /etc/stunnel/stunnel.pem\nclient = no\nsocket = a:SO_REUSEADDR=1\nsocket = l:TCP_NODELAY=1\nsocket = r:TCP_NODELAY=1\n\n[stunnel]\nconnect = 127.0.0.1:22\naccept = ${porta}" >/etc/stunnel/stunnel.conf
				}
				fun_bar 'ssl_conf'
				echo -e "\n\033[1;32mCRIANDO CERTIFICADO !\033[0m"
				echo ""
				ssl_certif() {
					crt='EC'
					openssl genrsa -out key.pem 2048 >/dev/null 2>&1
					(
						echo $crt
						echo $crt
						echo $crt
						echo $crt
						echo $crt
						echo $crt
						echo $crt
					) | openssl req -new -x509 -key key.pem -out cert.pem -days 1050 >/dev/null 2>&1
					cat cert.pem key.pem >>/etc/stunnel/stunnel.pem
					rm key.pem cert.pem >/dev/null 2>&1
					sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
				}
				fun_bar 'ssl_certif'
				echo -e "\n\033[1;32mINICIANDO O SSL TUNNEL !\033[0m"
				echo ""
				fun_finssl() {
					service stunnel4 restart
					service ssh restart
					/etc/init.d/stunnel4 restart
				}
				fun_bar 'fun_finssl' 'service stunnel4 restart'
				echo -e "\n\033[1;32mSSL TUNNEL INSTALADO COM SUCESSO !\033[1;31m PORTA: \033[1;33m$porta\033[0m"
				sleep 3
				clear
				fun_conexao
			} || {
				echo -e "\n\033[1;31mRetornando...\033[0m"
				sleep 2
				clear
				fun_conexao
			}
		fi
	}

	fun_openvpn() {
		if readlink /proc/$$/exe | grep -qs "dash"; then
			echo "Este script precisa ser executado com bash, não sh"
			exit 1
		fi
		[[ "$EUID" -ne 0 ]] && {
			clear
			echo "Execulte como root"
			exit 2
		}
		[[ ! -e /dev/net/tun ]] && {
			echo -e "\033[1;31mTUN TAP NAO DISPONIVEL\033[0m"
			sleep 2
			exit 3
		}
		if grep -qs "CentOS release 5" "/etc/redhat-release"; then
			echo "O CentOS 5 é muito antigo e não é suportado"
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
		newclient() {
			# gerar client.ovpn
			cp /etc/openvpn/client-common.txt ~/$1.ovpn
			echo "<ca>" >>~/$1.ovpn
			cat /etc/openvpn/easy-rsa/pki/ca.crt >>~/$1.ovpn
			echo "</ca>" >>~/$1.ovpn
			echo "<cert>" >>~/$1.ovpn
			cat /etc/openvpn/easy-rsa/pki/issued/$1.crt >>~/$1.ovpn
			echo "</cert>" >>~/$1.ovpn
			echo "<key>" >>~/$1.ovpn
			cat /etc/openvpn/easy-rsa/pki/private/$1.key >>~/$1.ovpn
			echo "</key>" >>~/$1.ovpn
			echo "<tls-auth>" >>~/$1.ovpn
			cat /etc/openvpn/ta.key >>~/$1.ovpn
			echo "</tls-auth>" >>~/$1.ovpn
		}
		IP1=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
		IP2=$(wget -4qO- "http://whatismyip.akamai.com/")
		[[ "$IP1" = "" ]] && {
			IP1=$(hostname -I | cut -d' ' -f1)
		}
		[[ "$IP1" != "$IP2" ]] && {
			IP="$IP1"
		} || {
			IP="$IP2"
		}
		[[ $(netstat -nplt | grep -wc 'openvpn') != '0' ]] && {
			while :; do
				clear

				opnp=$(cat /etc/openvpn/server.conf | grep "port" | awk {'print $2'})
				[[ -d /var/www/html/openvpn ]] && {
					ovpnweb=$(echo -e "\033[1;32m◉ ")
				} || {
					ovpnweb=$(echo -e "\033[1;31m○ ")
				}
				if grep "duplicate-cn" /etc/openvpn/server.conf >/dev/null; then
					mult=$(echo -e "\033[1;32m◉ ")
				else
					mult=$(echo -e "\033[1;31m○ ")
				fi
				echo -e "\E[44;1;37m          GERENCIAR OPENVPN           \E[0m"
				echo ""
				echo -e "\033[1;33mPORTA\033[1;37m: \033[1;32m$opnp"
				echo ""
				echo -e "\033[1;31m[\033[1;36m1\033[1;31m] \033[1;37m• \033[1;33mALTERAR PORTA"
				echo -e "\033[1;31m[\033[1;36m2\033[1;31m] \033[1;37m• \033[1;33mREMOVER OPENVPN"
				echo -e "\033[1;31m[\033[1;36m3\033[1;31m] \033[1;37m• \033[1;33mOVPN VIA LINK $ovpnweb"
				echo -e "\033[1;31m[\033[1;36m4\033[1;31m] \033[1;37m• \033[1;33mMULTILOGIN OVPN $mult"
				echo -e "\033[1;31m[\033[1;36m5\033[1;31m] \033[1;37m• \033[1;33mALTERAR HOST DNS"
				echo -e "\033[1;31m[\033[1;36m0\033[1;31m] \033[1;37m• \033[1;33mVOLTAR"
				echo ""
				echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;31m?\033[1;37m "
				read option
				case $option in
				1)
					clear
					echo -e "\E[44;1;37m         ALTERAR PORTA OPENVPN         \E[0m"
					echo ""
					echo -e "\033[1;33mPORTA EM USO: \033[1;32m$opnp"
					echo ""
					echo -ne "\033[1;32mQUAL PORTA DESEJA UTILIZAR \033[1;33m?\033[1;37m "
					read porta
					[[ -z "$porta" ]] && {
						echo ""
						echo -e "\033[1;31mPorta invalida!"
						sleep 3
						fun_conexao
					}
					verif_ptrs
					echo ""
					echo -e "\033[1;32mALTERANDO A PORTA OPENVPN!\033[1;33m"
					echo ""
					fun_opn() {
						var_ptovpn=$(sed -n '1 p' /etc/openvpn/server.conf)
						sed -i "s/\b$var_ptovpn\b/port $porta/g" /etc/openvpn/server.conf
						sleep 1
						var_ptovpn2=$(sed -n '7 p' /etc/openvpn/client-common.txt | awk {'print $NF'})
						sed -i "s/\b$var_ptovpn2/\b$porta/g" /etc/openvpn/client-common.txt
						sleep 1
						service openvpn restart
					}
					fun_bar 'fun_opn'
					echo ""
					echo -e "\033[1;32mPORTA ALTERADA COM SUCESSO!\033[1;33m"
					sleep 2
					fun_conexao
					;;
				2)
					echo ""
					echo -ne "\033[1;32mDESEJA REMOVER O OPENVPN \033[1;31m? \033[1;33m[s/n]:\033[1;37m "
					read REMOVE
					[[ "$REMOVE" = 's' ]] && {
						rmv_open() {
							PORT=$(grep '^port ' /etc/openvpn/server.conf | cut -d " " -f 2)
							PROTOCOL=$(grep '^proto ' /etc/openvpn/server.conf | cut -d " " -f 2)
							IP=$(grep 'iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -j SNAT --to ' $RCLOCAL | cut -d " " -f 11)
							if pgrep firewalld; then
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
							[[ "$OS" = 'debian' ]] && {
								apt-get remove --purge -y openvpn openvpn-blacklist
								apt-get autoremove openvpn -y
								apt-get autoremove -y
							} || {
								yum remove openvpn -y
							}
							rm -rf /etc/openvpn
							rm -rf /usr/share/doc/openvpn*
						}
						echo ""
						echo -e "\033[1;32mREMOVENDO O OPENVPN!\033[0m"
						echo ""
						fun_bar 'rmv_open'
						echo ""
						echo -e "\033[1;32mOPENVPN REMOVIDO COM SUCESSO!\033[0m"
						sleep 2
						fun_conexao
					} || {
						echo ""
						echo -e "\033[1;31mRetornando...\033[0m"
						sleep 2
						fun_conexao
					}
					;;
				3)
					[[ -d /var/www/html/openvpn ]] && {
						clear
						fun_spcr() {
							apt-get remove apache2 -y
							apt-get autoremove -y
							rm -rf /var/www/html/openvpn
						}
						function aguarde() {
							helice() {
								fun_spcr >/dev/null 2>&1 &
								tput civis
								while [ -d /proc/$! ]; do
									for i in / - \\ \|; do
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
					} || {
						clear
						fun_apchon() {
							apt-get install apache2 zip -y
							sed -i "s/Listen 80/Listen 81/g" /etc/apache2/ports.conf
							service apache2 restart
							[[ ! -d /var/www/html ]] && {
								mkdir /var/www/html
							}
							[[ ! -d /var/www/html/openvpn ]] && {
								mkdir /var/www/html/openvpn
							}
							touch /var/www/html/openvpn/index.html
							chmod -R 755 /var/www
							/etc/init.d/apache2 restart
						}
						function aguarde2() {
							helice() {
								fun_apchon >/dev/null 2>&1 &
								tput civis
								while [ -d /proc/$! ]; do
									for i in / - \\ \|; do
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
						fun_openvpn
					}
					;;
				4)
					if grep "duplicate-cn" /etc/openvpn/server.conf >/dev/null; then
						clear
						fun_multon() {
							sed -i '/duplicate-cn/d' /etc/openvpn/server.conf
							sleep 1.5s
							service openvpn restart >/dev/null
							sleep 2
						}
						fun_spinmult() {
							helice() {
								fun_multon >/dev/null 2>&1 &
								tput civis
								while [ -d /proc/$! ]; do
									for i in / - \\ \|; do
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
						sleep 1
						fun_openvpn
					else
						clear
						fun_multoff() {
							grep -v "^duplicate-cn" /etc/openvpn/server.conf >/tmp/tmpass && mv /tmp/tmpass /etc/openvpn/server.conf
							echo "duplicate-cn" >>/etc/openvpn/server.conf
							sleep 1.5s
							service openvpn restart >/dev/null
						}
						fun_spinmult2() {
							helice() {
								fun_multoff >/dev/null 2>&1 &
								tput civis
								while [ -d /proc/$! ]; do
									for i in / - \\ \|; do
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
						sleep 1
						fun_openvpn
					fi
					;;
				5)
					clear
					echo -e "\E[44;1;37m         ALTERAR HOST DNS           \E[0m"
					echo ""
					echo -e "\033[1;31m[\033[1;36m1\033[1;31m] \033[1;37m• \033[1;33mADICIONAR HOST DNS"
					echo -e "\033[1;31m[\033[1;36m2\033[1;31m] \033[1;37m• \033[1;33mREMOVER HOST DNS"
					echo -e "\033[1;31m[\033[1;36m3\033[1;31m] \033[1;37m• \033[1;33mEDITAR MANUALMENTE"
					echo -e "\033[1;31m[\033[1;36m0\033[1;31m] \033[1;37m• \033[1;33mVOLTAR"
					echo ""
					echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;31m?\033[1;37m "
					read resp
					[[ -z "$resp" ]] && {
						echo ""
						echo -e "\033[1;31mOpcao invalida!"
						sleep 3
						fun_openvpn
					}
					if [[ "$resp" = '1' ]]; then
						clear
						echo -e "\E[44;1;37m            Adicionar Host DNS            \E[0m"
						echo ""
						echo -e "\033[1;33mLista dos hosts atuais:\033[0m "
						echo ""
						i=0
						for _host in $(grep -w "127.0.0.1" /etc/hosts | grep -v "localhost" | cut -d' ' -f2); do
							echo -e "\033[1;32m$_host"
						done
						echo ""
						echo -ne "\033[1;33mDigite o host a ser adicionado\033[1;37m : "
						read host
						if [[ -z $host ]]; then
							echo ""
							echo -e "\E[41;1;37m        Campo Vazio ou invalido !       \E[0m"
							sleep 2
							fun_openvpn
						fi
						if [[ "$(grep -w "$host" /etc/hosts | wc -l)" -gt "0" ]]; then
							echo -e "\E[41;1;37m    Esse host ja está adicionado  !    \E[0m"
							sleep 2
							fun_openvpn
						fi
						sed -i "3i\127.0.0.1 $host" /etc/hosts
						echo ""
						echo -e "\E[44;1;37m      Host adicionado com sucesso !      \E[0m"
						sleep 2
						fun_openvpn
					elif [[ "$resp" = '2' ]]; then
						clear
						echo -e "\E[44;1;37m            Remover Host DNS            \E[0m"
						echo ""
						echo -e "\033[1;33mLista dos hosts atuais:\033[0m "
						echo ""
						i=0
						for _host in $(grep -w "127.0.0.1" /etc/hosts | grep -v "localhost" | cut -d' ' -f2); do
							i=$(expr $i + 1)
							oP+=$i
							[[ $i == [1-9] ]] && oP+=" 0$i" && i=0$i
							oP+=":$_host\n"
							echo -e "\033[1;33m[\033[1;31m$i\033[1;33m] \033[1;37m- \033[1;32m$_host\033[0m"
						done
						echo ""
						echo -ne "\033[1;32mSelecione o host a ser removido \033[1;33m[\033[1;37m1\033[1;31m-\033[1;37m$i\033[1;33m]\033[1;37m: "
						read option
						if [[ -z $option ]]; then
							echo ""
							echo -e "\E[41;1;37m          Opcao invalida  !        \E[0m"
							sleep 2
							fun_openvpn
						fi
						host=$(echo -e "$oP" | grep -E "\b$option\b" | cut -d: -f2)
						hst=$(grep -v "127.0.0.1 $host" /etc/hosts)
						echo "$hst" >/etc/hosts
						echo ""
						echo -e "\E[41;1;37m      Host removido com sucesso !      \E[0m"
						sleep 2
						fun_openvpn
					elif [[ "$resp" = '3' ]]; then
						echo -e "\n\033[1;32mALTERANDO ARQUIVO \033[1;37m/etc/hosts\033[0m"
						echo -e "\n\033[1;31mATENCAO!\033[0m"
						echo -e "\n\033[1;33mPARA SALVAR USE AS TECLAS \033[1;32mctrl x y\033[0m"
						sleep 4
						clear
						nano /etc/hosts
						echo -e "\n\033[1;32mALTERADO COM SUCESSO!\033[0m"
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
					;;
				esac
			done
		} || {
			clear
			echo -e "\E[44;1;37m              INSTALADOR OPENVPN               \E[0m"
			echo ""
			# OpenVPN instalador e criação do primeiro usuario
			echo -e "\033[1;33mRESPONDA AS QUESTOES PARA INICIAR A INSTALACAO"
			echo ""
			echo -ne "\033[1;32mPARA CONTINUAR CONFIRME SEU IP: \033[1;37m"
			read -e -i $IP IP
			[[ -z "$IP" ]] && {
				echo ""
				echo -e "\033[1;31mIP invalido!"
				sleep 3
				fun_conexao
			}
			echo ""
			read -p "$(echo -e "\033[1;32mQUAL PORTA DESEJA UTILIZAR? \033[1;37m")" -e -i 1194 porta
			[[ -z "$porta" ]] && {
				echo ""
				echo -e "\033[1;31mPorta invalida!"
				sleep 2
				fun_conexao
			}
			echo ""
			echo -e "\033[1;33mVERIFICANDO PORTA..."
			verif_ptrs $porta
			echo ""
			echo -e "\033[1;31m[\033[1;36m1\033[1;31m] \033[1;33mSistema"
			echo -e "\033[1;31m[\033[1;36m2\033[1;31m] \033[1;33mGoogle (\033[1;32mRecomendado\033[1;33m)"
			echo -e "\033[1;31m[\033[1;36m3\033[1;31m] \033[1;33mOpenDNS"
			echo -e "\033[1;31m[\033[1;36m4\033[1;31m] \033[1;33mCloudflare"
			echo -e "\033[1;31m[\033[1;36m5\033[1;31m] \033[1;33mHurricane Electric"
			echo -e "\033[1;31m[\033[1;36m6\033[1;31m] \033[1;33mVerisign"
			echo -e "\033[1;31m[\033[1;36m7\033[1;31m] \033[1;33mDNS Performace\033[0m"
			echo ""
			read -p "$(echo -e "\033[1;32mQUAL DNS DESEJA UTILIZAR? \033[1;37m")" -e -i 2 DNS
			echo ""
			echo -e "\033[1;31m[\033[1;36m1\033[1;31m] \033[1;33mUDP"
			echo -e "\033[1;31m[\033[1;36m2\033[1;31m] \033[1;33mTCP (\033[1;32mRecomendado\033[1;33m)"
			echo ""
			read -p "$(echo -e "\033[1;32mQUAL PROTOCOLO DESEJA UTILIZAR NO OPENVPN? \033[1;37m")" -e -i 2 resp
			if [[ "$resp" = '1' ]]; then
				PROTOCOL=udp
			elif [[ "$resp" = '2' ]]; then
				PROTOCOL=tcp
			else
				PROTOCOL=tcp
			fi
			echo ""
			[[ "$OS" = 'debian' ]] && {
				echo -e "\033[1;32mATUALIZANDO O SISTEMA"
				echo ""
				fun_attos() {
					apt-get update-y
					apt-get upgrade -y
				}
				fun_bar 'fun_attos'
				echo ""
				echo -e "\033[1;32mINSTALANDO DEPENDENCIAS"
				echo ""
				fun_instdep() {
					apt-get install openvpn iptables openssl ca-certificates -y
					apt-get install zip -y
				}
				fun_bar 'fun_instdep'
			} || {
				fun_bar 'yum install epel-release -y'
				fun_bar 'yum install openvpn iptables openssl wget ca-certificates -y'
			}
			[[ -d /etc/openvpn/easy-rsa/ ]] && {
				rm -rf /etc/openvpn/easy-rsa/
			}
			# Adquirindo easy-rsa
			echo ""
			fun_dep() {
				wget -O ~/EasyRSA-3.0.1.tgz "https://github.com/OpenVPN/easy-rsa/releases/download/3.0.1/EasyRSA-3.0.1.tgz"
				tar xzf ~/EasyRSA-3.0.1.tgz -C ~/
				mv ~/EasyRSA-3.0.1/ /etc/openvpn/
				mv /etc/openvpn/EasyRSA-3.0.1/ /etc/openvpn/easy-rsa/
				chown -R root:root /etc/openvpn/easy-rsa/
				rm -rf ~/EasyRSA-3.0.1.tgz
				cd /etc/openvpn/easy-rsa/
				./easyrsa init-pki
				./easyrsa --batch build-ca nopass
				./easyrsa gen-dh
				./easyrsa build-server-full server nopass
				./easyrsa build-client-full SSHPLUS nopass
				./easyrsa gen-crl
				cp pki/ca.crt pki/private/ca.key pki/dh.pem pki/issued/server.crt pki/private/server.key /etc/openvpn/easy-rsa/pki/crl.pem /etc/openvpn
				chown nobody:$GROUPNAME /etc/openvpn/crl.pem
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
ifconfig-pool-persist ipp.txt" >/etc/openvpn/server.conf
				echo 'push "redirect-gateway def1 bypass-dhcp"' >>/etc/openvpn/server.conf
				# DNS
				case $DNS in
				1)
					# Obtain the resolvers from resolv.conf and use them for OpenVPN
					grep -v '#' /etc/resolv.conf | grep 'nameserver' | grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | while read line; do
						echo "push \"dhcp-option DNS $line\"" >>/etc/openvpn/server.conf
					done
					;;
				2)
					echo 'push "dhcp-option DNS 8.8.8.8"' >>/etc/openvpn/server.conf
					echo 'push "dhcp-option DNS 8.8.4.4"' >>/etc/openvpn/server.conf
					;;
				3)
					echo 'push "dhcp-option DNS 208.67.222.222"' >>/etc/openvpn/server.conf
					echo 'push "dhcp-option DNS 208.67.220.220"' >>/etc/openvpn/server.conf
					;;
				4)
					echo 'push "dhcp-option DNS 1.1.1.1"' >>/etc/openvpn/server.conf
					echo 'push "dhcp-option DNS 1.0.0.1"' >>/etc/openvpn/server.conf
					;;
				5)
					echo 'push "dhcp-option DNS 74.82.42.42"' >>/etc/openvpn/server.conf
					;;
				6)
					echo 'push "dhcp-option DNS 64.6.64.6"' >>/etc/openvpn/server.conf
					echo 'push "dhcp-option DNS 64.6.65.6"' >>/etc/openvpn/server.conf
					;;
				7)
					echo 'push "dhcp-option DNS 189.38.95.95"' >>/etc/openvpn/server.conf
					echo 'push "dhcp-option DNS 216.146.36.36"' >>/etc/openvpn/server.conf
					;;
				esac
				echo "keepalive 10 120
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
plugin $(find /usr -type f -name 'openvpn-plugin-auth-pam.so') login
duplicate-cn" >>/etc/openvpn/server.conf
				sed -i '/\<net.ipv4.ip_forward\>/c\net.ipv4.ip_forward=1' /etc/sysctl.conf
				if ! grep -q "\<net.ipv4.ip_forward\>" /etc/sysctl.conf; then
					echo 'net.ipv4.ip_forward=1' >>/etc/sysctl.conf
				fi
				echo 1 >/proc/sys/net/ipv4/ip_forward
				if [[ "$OS" = 'debian' && ! -e $RCLOCAL ]]; then
					echo '#!/bin/sh -e
exit 0' >$RCLOCAL
				fi
				chmod +x $RCLOCAL
				iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -j SNAT --to $IP
				sed -i "1 a\iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -j SNAT --to $IP" $RCLOCAL
				if pgrep firewalld; then
					firewall-cmd --zone=public --add-port=$porta/$PROTOCOL
					firewall-cmd --zone=trusted --add-source=10.8.0.0/24
					firewall-cmd --permanent --zone=public --add-port=$porta/$PROTOCOL
					firewall-cmd --permanent --zone=trusted --add-source=10.8.0.0/24
				fi
				if iptables -L -n | grep -qE 'REJECT|DROP'; then
					iptables -I INPUT -p $PROTOCOL --dport $porta -j ACCEPT
					iptables -I FORWARD -s 10.8.0.0/24 -j ACCEPT
					iptables -F
					iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
					sed -i "1 a\iptables -I INPUT -p $PROTOCOL --dport $porta -j ACCEPT" $RCLOCAL
					sed -i "1 a\iptables -I FORWARD -s 10.8.0.0/24 -j ACCEPT" $RCLOCAL
					sed -i "1 a\iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT" $RCLOCAL
				fi
				if hash sestatus 2>/dev/null; then
					if sestatus | grep "Current mode" | grep -qs "enforcing"; then
						if [[ "$porta" != '1194' || "$PROTOCOL" = 'tcp' ]]; then
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
			fun_bar 'fun_dep > /dev/null 2>&1'
			fun_ropen() {
				[[ "$OS" = 'debian' ]] && {
					if pgrep systemd-journal; then
						systemctl restart openvpn@server.service
					else
						/etc/init.d/openvpn restart
					fi
				} || {
					if pgrep systemd-journal; then
						systemctl restart openvpn@server.service
						systemctl enable openvpn@server.service
					else
						service openvpn restart
						chkconfig openvpn on
					fi
				}
			}
			echo ""
			echo -e "\033[1;32mREINICIANDO O OPENVPN"
			echo ""
			fun_bar 'fun_ropen'
			IP2=$(wget -4qO- "http://whatismyip.akamai.com/")
			if [[ "$IP" != "$IP2" ]]; then
				IP="$IP2"
			fi
			cat <<-EOF >/etc/openvpn/client-common.txt
				# OVPN_ACCESS_SERVER_PROFILE=[SSHPLUS]
				client
				dev tun
				proto $PROTOCOL
				sndbuf 0
				rcvbuf 0
				remote /SSHPLUS? $porta
				#payload "HTTP/1.0 [crlf]Host: m.youtube.com[crlf]CONNECT HTTP/1.0[crlf][crlf]|[crlf]"
				http-proxy $IP 8080
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
				keepalive 10 120
				float
			EOF
			# gerar client.ovpn
			newclient "SSHPLUS"
			[[ "$(netstat -nplt | grep -wc 'openvpn')" != '0' ]] && echo -e "\n\033[1;32mOPENVPN INSTALADO COM SUCESSO\033[0m" || echo -e "\n\033[1;31mERRO ! A INSTALACAO CORROMPEU\033[0m"
		}
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

	fun_socks() {
		clear
		echo -e "\E[44;1;37m            GERENCIAR PROXY SOCKS             \E[0m"
		echo ""
		[[ $(netstat -nplt | grep -wc 'python') != '0' ]] && {
			sks='\033[1;32mON'
			echo -e "\033[1;33mPORTAS\033[1;37m: \033[1;32m$(netstat -nplt | grep 'python' | awk {'print $4'} | cut -d: -f2 | xargs)"
		} || {
			sks='\033[1;31mOFF'
		}
		[[ $(screen -list | grep -wc 'proxy') != '0' ]] && var_sks1="\033[1;32m◉" || var_sks1="\033[1;31m○"
		[[ $(screen -list | grep -wc 'openpy') != '0' ]] && sksop="\033[1;32m◉" || sksop="\033[1;31m○"
		echo ""
		echo -e "\033[1;31m[\033[1;36m1\033[1;31m] \033[1;37m• \033[1;33mSOCKS SSH $var_sks1 \033[0m"
		echo -e "\033[1;31m[\033[1;36m2\033[1;31m] \033[1;37m• \033[1;33mSOCKS OEPNVPN $sksop \033[0m"
		echo -e "\033[1;31m[\033[1;36m3\033[1;31m] \033[1;37m• \033[1;33mABRIR PORTA\033[0m"
		echo -e "\033[1;31m[\033[1;36m4\033[1;31m] \033[1;37m• \033[1;33mALTERAR STATUS\033[0m"
		echo -e "\033[1;31m[\033[1;36m0\033[1;31m] \033[1;37m• \033[1;33mVOLTAR\033[0m"
		echo ""
		echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;37m "
		read resposta
		if [[ "$resposta" = '1' ]]; then
			if ps x | grep -w proxy.py | grep -v grep 1>/dev/null 2>/dev/null; then
				clear
				echo -e "\E[41;1;37m             PROXY SOCKS              \E[0m"
				echo ""
				fun_socksoff() {
					for pidproxy in $(screen -ls | grep ".proxy" | awk {'print $1'}); do
						screen -r -S "$pidproxy" -X quit
					done
					[[ $(grep -wc "proxy.py" /etc/autostart) != '0' ]] && {
						sed -i '/proxy.py/d' /etc/autostart
					}
					sleep 1
					screen -wipe >/dev/null
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
				echo -ne "\033[1;32mQUAL PORTA DESEJA ULTILIZAR \033[1;33m?\033[1;37m: "
				read porta
				[[ -z "$porta" ]] && {
					echo ""
					echo -e "\033[1;31mPorta invalida!"
					sleep 3
					clear
					fun_conexao
				}
				verif_ptrs $porta
				fun_inisocks() {
					sleep 1
					screen -dmS proxy python /etc/SSHPlus/proxy.py $porta
					[[ $(grep -wc "proxy.py" /etc/autostart) = '0' ]] && {
						echo -e "netstat -tlpn | grep -w $porta > /dev/null || screen -dmS proxy python /etc/SSHPlus/proxy.py $porta" >>/etc/autostart
					} || {
						sed -i '/proxy.py/d' /etc/autostart
						echo -e "netstat -tlpn | grep -w $porta > /dev/null || screen -dmS proxy python /etc/SSHPlus/proxy.py $porta" >>/etc/autostart
					}
				}
				echo ""
				echo -e "\033[1;32mINICIANDO O PROXY SOCKS\033[1;33m"
				echo ""
				fun_bar 'fun_inisocks'
				echo ""
				echo -e "\033[1;32mSOCKS ATIVADO COM SUCESSO\033[1;33m"
				sleep 3
				fun_socks
			fi
		elif [[ "$resposta" = '2' ]]; then
			if ps x | grep -w open.py | grep -v grep 1>/dev/null 2>/dev/null; then
				clear
				echo -e "\E[41;1;37m            SOCKS OPENVPN             \E[0m"
				echo ""
				fun_socksopenoff() {
					for pidproxy in $(screen -list | grep -w "openpy" | awk {'print $1'}); do
						screen -r -S "$pidproxy" -X quit
					done
					[[ $(grep -wc "open.py" /etc/autostart) != '0' ]] && {
						sed -i '/open.py/d' /etc/autostart
					}
					sleep 1
					screen -wipe >/dev/null
				}
				echo -e "\033[1;32mDESATIVANDO O SOCKS OPEN\033[1;33m"
				echo ""
				fun_bar 'fun_socksopenoff'
				echo ""
				echo -e "\033[1;32mSOCKS DESATIVADO COM SUCESSO!\033[1;33m"
				sleep 2
				fun_socks
			else
				clear
				echo -e "\E[41;1;37m            SOCKS OPENVPN             \E[0m"
				echo ""
				echo -ne "\033[1;32mQUAL PORTA DESEJA ULTILIZAR \033[1;33m?\033[1;37m: "
				read porta
				[[ -z "$porta" ]] && {
					echo ""
					echo -e "\033[1;31mPorta invalida!"
					sleep 2
					clear
					fun_conexao
				}
				verif_ptrs $porta
				fun_inisocksop() {
					[[ "$(netstat -tlpn | grep 'openvpn' | wc -l)" != '0' ]] && {
						listoldop=$(grep -w 'DEFAULT_HOST =' /etc/SSHPlus/open.py | cut -d"'" -f2 | cut -d: -f2)
						listopen=$(netstat -tlpn | grep -w openvpn | grep -v 127.0.0.1 | awk {'print $4'} | cut -d: -f2)
						sed -i "s/$listoldop/$listopen/" /etc/SSHPlus/open.py
					}
					sleep 1
					screen -dmS openpy python /etc/SSHPlus/open.py $porta
					[[ $(grep -wc "open.py" /etc/autostart) = '0' ]] && {
						echo -e "netstat -tlpn | grep -w $porta > /dev/null || screen -dmS openpy python /etc/SSHPlus/open.py $porta" >>/etc/autostart
					} || {
						sed -i '/open.py/d' /etc/autostart
						echo -e "netstat -tlpn | grep -w $porta > /dev/null || screen -dmS openpy python /etc/SSHPlus/open.py $porta" >>/etc/autostart
					}
				}
				echo ""
				echo -e "\033[1;32mINICIANDO O SOCKS OPENVPN\033[1;33m"
				echo ""
				fun_bar 'fun_inisocksop'
				echo ""
				echo -e "\033[1;32mSOCKS OPENVPN ATIVADO COM SUCESSO\033[1;33m"
				sleep 3
				fun_socks
			fi
		elif [[ "$resposta" = '3' ]]; then
			if ps x | grep proxy.py | grep -v grep 1>/dev/null 2>/dev/null; then
				sockspt=$(netstat -nplt | grep 'python' | awk {'print $4'} | cut -d: -f2 | xargs)
				clear
				echo -e "\E[44;1;37m            PROXY SOCKS             \E[0m"
				echo ""
				echo -e "\033[1;33mPORTAS EM USO: \033[1;32m$sockspt"
				echo ""
				echo -ne "\033[1;32mQUAL PORTA DESEJA ULTILIZAR \033[1;33m?\033[1;37m: "
				read porta
				[[ -z "$porta" ]] && {
					echo ""
					echo -e "\033[1;31mPorta invalida!"
					sleep 2
					clear
					fun_conexao
				}
				verif_ptrs $porta
				echo ""
				echo -e "\033[1;32mINICIANDO O PROXY SOCKS NA PORTA \033[1;31m$porta\033[1;33m"
				echo ""
				abrirptsks() {
					sleep 1
					screen -dmS proxy python /etc/SSHPlus/proxy.py $porta
					sleep 1
				}
				fun_bar 'abrirptsks'
				echo ""
				echo -e "\033[1;32mPROXY SOCKS ATIVADO COM SUCESSO\033[1;33m"
				sleep 2
				fun_socks
			else
				clear
				echo -e "\033[1;31mFUNCAO INDISPONIVEL\n\n\033[1;33mATIVE O SOCKS PRIMEIRO !\033[1;33m"
				sleep 2
				fun_socks
			fi
		elif [[ "$resposta" = '4' ]]; then
			if ps x | grep -w proxy.py | grep -v grep 1>/dev/null 2>/dev/null; then
				clear
				msgsocks=$(cat /etc/SSHPlus/proxy.py | grep -E "MSG =" | awk -F = '{print $2}' | cut -d "'" -f 2)
				echo -e "\E[44;1;37m             PROXY SOCKS              \E[0m"
				echo ""
				echo -e "\033[1;33mSTATUS: \033[1;32m$msgsocks"
				echo""
				echo -ne "\033[1;32mINFORME SEU STATUS\033[1;31m:\033[1;37m "
				read msgg
				[[ -z "$msgg" ]] && {
					echo -e "\n\033[1;31mStatus invalido!"
					sleep 2
					fun_conexao
				}
				[[ ${msgg} != ?(+|-)+([a-zA-Z0-9-. ]) ]] && {
					echo -e "\n\033[1;31m[\033[1;33m!\033[1;31m]\033[1;33m EVITE CARACTERES ESPECIAIS\033[0m"
					sleep 2
					fun_socks
				}
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
				echo -ne "\033[1;32mQUAL A COR\033[1;31m ?\033[1;37m : "
				read sts_cor
				if [[ "$sts_cor" = "1" ]] || [[ "$sts_cor" = "01" ]]; then
					cor_sts='blue'
				elif [[ "$sts_cor" = "2" ]] || [[ "$sts_cor" = "02" ]]; then
					cor_sts='green'
				elif [[ "$sts_cor" = "3" ]] || [[ "$sts_cor" = "03" ]]; then
					cor_sts='red'
				elif [[ "$sts_cor" = "4" ]] || [[ "$sts_cor" = "04" ]]; then
					cor_sts='yellow'
				elif [[ "$sts_cor" = "5" ]] || [[ "$sts_cor" = "05" ]]; then
					cor_sts='#F535AA'
				elif [[ "$sts_cor" = "6" ]] || [[ "$sts_cor" = "06" ]]; then
					cor_sts='cyan'
				elif [[ "$sts_cor" = "7" ]] || [[ "$sts_cor" = "07" ]]; then
					cor_sts='#FF7F00'
				elif [[ "$sts_cor" = "8" ]] || [[ "$sts_cor" = "08" ]]; then
					cor_sts='#9932CD'
				elif [[ "$sts_cor" = "9" ]] || [[ "$sts_cor" = "09" ]]; then
					cor_sts='black'
				elif [[ "$sts_cor" = "10" ]]; then
					cor_sts='null'
				else
					echo -e "\n\033[1;33mOPCAO INVALIDA !"
					cor_sts='null'
				fi
				fun_msgsocks() {
					msgsocks2=$(cat /etc/SSHPlus/proxy.py | grep "MSG =" | awk -F = '{print $2}')
					sed -i "s/$msgsocks2/ '$msgg'/g" /etc/SSHPlus/proxy.py
					sleep 1
					cor_old=$(grep 'color=' /etc/SSHPlus/proxy.py | cut -d '"' -f2)
					sed -i "s/\b$cor_old\b/$cor_sts/g" /etc/SSHPlus/proxy.py

				}
				echo ""
				echo -e "\033[1;32mALTERANDO STATUS!"
				echo ""
				fun_bar 'fun_msgsocks'
				restartsocks() {
					if ps x | grep proxy.py | grep -v grep 1>/dev/null 2>/dev/null; then
						echo -e "$(netstat -nplt | grep 'python' | awk {'print $4'} | cut -d: -f2 | xargs)" >/tmp/Pt_sks
						for pidproxy in $(screen -ls | grep ".proxy" | awk {'print $1'}); do
							screen -r -S "$pidproxy" -X quit
						done
						screen -wipe >/dev/null
						_Ptsks="$(cat /tmp/Pt_sks)"
						sleep 1
						screen -dmS proxy python /etc/SSHPlus/proxy.py $_Ptsks
						rm /tmp/Pt_sks
					fi
				}
				echo ""
				echo -e "\033[1;32mREINICIANDO PROXY SOCKS!"
				echo ""
				fun_bar 'restartsocks'
				echo ""
				echo -e "\033[1;32mSTATUS ALTERADO COM SUCESSO!"
				sleep 2
				fun_socks
			else
				clear
				echo -e "\033[1;31mFUNCAO INDISPONIVEL\n\n\033[1;33mATIVE O SOCKS SSH PRIMEIRO !\033[1;33m"
				sleep 2
				fun_socks
			fi
		elif [[ "$resposta" = '0' ]]; then
			echo ""
			echo -e "\033[1;31mRetornando...\033[0m"
			sleep 1
			fun_conexao
		else
			echo ""
			echo -e "\033[1;31mOpcao invalida !\033[0m"
			sleep 1
			fun_socks
		fi

	}

	fun_openssh() {
		clear
		echo -e "\E[44;1;37m            OPENSSH             \E[0m\n"
		echo -e "\033[1;31m[\033[1;36m1\033[1;31m] \033[1;37m• \033[1;33mADICIONAR PORTA\033[1;31m
[\033[1;36m2\033[1;31m] \033[1;37m• \033[1;33mREMOVER PORTA\033[1;31m
[\033[1;36m3\033[1;31m] \033[1;37m• \033[1;33mVOLTAR\033[0m"
		echo ""
		echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;37m "
		read resp
		if [[ "$resp" = '1' ]]; then
			clear
			echo -e "\E[44;1;37m         ADICIONAR PORTA AO SSH         \E[0m\n"
			echo -ne "\033[1;32mQUAL PORTA DESEJA ADICIONAR \033[1;33m?\033[1;37m "
			read pt
			[[ -z "$pt" ]] && {
				echo -e "\n\033[1;31mPorta invalida!"
				sleep 3
				fun_conexao
			}
			verif_ptrs $pt
			echo -e "\n\033[1;32mADICIONANDO PORTA AO SSH\033[0m"
			echo ""
			fun_addpssh() {
				echo "Port $pt" >>/etc/ssh/sshd_config
				service ssh restart
			}
			fun_bar 'fun_addpssh'
			echo -e "\n\033[1;32mPORTA ADICIONADA COM SUCESSO\033[0m"
			sleep 3
			fun_conexao
		elif [[ "$resp" = '2' ]]; then
			clear
			echo -e "\E[41;1;37m         REMOVER PORTA DO SSH         \E[0m"
			echo -e "\n\033[1;33m[\033[1;31m!\033[1;33m] \033[1;32mPORTA PADRAO \033[1;37m22 \033[1;33mCUIDADO !\033[0m"
			echo -e "\n\033[1;33mPORTAS EM USO: \033[1;37m$(grep 'Port' /etc/ssh/sshd_config | cut -d' ' -f2 | grep -v 'no' | xargs)\n"
			echo -ne "\033[1;32mQUAL PORTA DESEJA REMOVER \033[1;33m?\033[1;37m "
			read pt
			[[ -z "$pt" ]] && {
				echo -e "\n\033[1;31mPorta invalida!"
				sleep 2
				fun_conexao
			}
			[[ $(grep -wc "$pt" '/etc/ssh/sshd_config') != '0' ]] && {
				echo -e "\n\033[1;32mREMOVENDO PORTA DO SSH\033[0m"
				echo ""
				fun_delpssh() {
					sed -i "/Port $pt/d" /etc/ssh/sshd_config
					service ssh restart
				}
				fun_bar 'fun_delpssh'
				echo -e "\n\033[1;32mPORTA REMOVIDA COM SUCESSO\033[0m"
				sleep 2
				fun_conexao
			} || {
				echo -e "\n\033[1;31mPorta invalida!"
				sleep 2
				fun_conexao
			}
		elif [[ "$resp" = '3' ]]; then
			echo -e "\n\033[1;31mRetornando.."
			sleep 2
			fun_conexao
		else
			echo -e "\n\033[1;31mOpcao invalida!"
			sleep 2
			fun_conexao
		fi
	}

	fun_sslh() {
		[[ "$(netstat -nltp | grep 'sslh' | wc -l)" = '0' ]] && {
			clear
			echo -e "\E[44;1;37m             INSTALADOR SSLH               \E[0m\n"
			echo -e "\n\033[1;33m[\033[1;31m!\033[1;33m] \033[1;32mA PORTA \033[1;37m443 \033[1;32mSERA USADA POR PADRAO\033[0m\n"
			echo -ne "\033[1;32mREALMENTE DESEJA INSTALAR O SSLH \033[1;31m? \033[1;33m[s/n]:\033[1;37m "
			read resp
			[[ "$resp" = 's' ]] && {
				verif_ptrs 443
				fun_instsslh() {
					[[ -e "/etc/stunnel/stunnel.conf" ]] && ptssl="$(netstat -nplt | grep 'stunnel' | awk {'print $4'} | cut -d: -f2 | xargs)" || ptssl='3128'
					[[ -e "/etc/openvpn/server.conf" ]] && ptvpn="$(netstat -nplt | grep 'openvpn' | awk {'print $4'} | cut -d: -f2 | xargs)" || ptvpn='1194'
					DEBIAN_FRONTEND=noninteractive apt-get -y install sslh
					echo -e "#Modo autónomo\n\nRUN=yes\n\nDAEMON=/usr/sbin/sslh\n\nDAEMON_OPTS='--user sslh --listen 0.0.0.0:443 --ssh 127.0.0.1:22 --ssl 127.0.0.1:$ptssl --http 127.0.0.1:80 --openvpn 127.0.0.1:$ptvpn --pidfile /var/run/sslh/sslh.pid'" >/etc/default/sslh
					/etc/init.d/sslh start && service sslh start
				}
				echo -e "\n\033[1;32mINSTALANDO O SSLH !\033[0m\n"
				fun_bar 'fun_instsslh'
				echo -e "\n\033[1;32mINICIANDO O SSLH !\033[0m\n"
				fun_bar '/etc/init.d/sslh restart && service sslh restart'
				[[ $(netstat -nplt | grep -w 'sslh' | wc -l) != '0' ]] && echo -e "\n\033[1;32mINSTALADO COM SUCESSO !\033[0m" || echo -e "\n\033[1;31mERRO INESPERADO !\033[0m"
				sleep 3
				fun_conexao
			} || {
				echo -e "\n\033[1;31mRetornando.."
				sleep 2
				fun_conexao
			}
		} || {
			clear
			echo -e "\E[41;1;37m             REMOVER O SSLH               \E[0m\n"
			echo -ne "\033[1;32mREALMENTE DESEJA REMOVER O SSLH \033[1;31m? \033[1;33m[s/n]:\033[1;37m "
			read respo
			[[ "$respo" = "s" ]] && {
				fun_delsslh() {
					/etc/init.d/sslh stop && service sslh stop
					apt-get remove sslh -y
					apt-get purge sslh -y
				}
				echo -e "\n\033[1;32mREMOVENDO O SSLH !\033[0m\n"
				fun_bar 'fun_delsslh'
				echo -e "\n\033[1;32mREMOVIDO COM SUCESSO !\033[0m\n"
				sleep 2
				fun_conexao
			} || {
				echo -e "\n\033[1;31mRetornando.."
				sleep 2
				fun_conexao
			}
		}
	}

	x="ok"
	fun_conexao() {
		while true $x != "ok"; do
			[[ ! -e '/home/sshplus' ]] && exit 0
			clear
			echo -e "\E[44;1;37m                MODO DE CONEXAO                 \E[0m\n"
			echo -e "\033[1;32mSERVICO: \033[1;33mOPENSSH \033[1;32mPORTA: \033[1;37m$(grep 'Port' /etc/ssh/sshd_config | cut -d' ' -f2 | grep -v 'no' | xargs)" && sts6="\033[1;32m◉ "

			[[ "$(netstat -tlpn | grep 'sslh' | wc -l)" != '0' ]] && {
				echo -e "\033[1;32mSERVICO: \033[1;33mSSLH: \033[1;32mPORTA: \033[1;37m$(netstat -nplt | grep 'sslh' | awk {'print $4'} | cut -d: -f2 | xargs)"
				sts7="\033[1;32m◉ "
			} || {
				sts7="\033[1;31m○ "
			}

			[[ "$(netstat -tlpn | grep 'openvpn' | wc -l)" != '0' ]] && {
				echo -e "\033[1;32mSERVICO: \033[1;33mOPENVPN: \033[1;32mPORTA: \033[1;37m$(netstat -nplt | grep 'openvpn' | awk {'print $4'} | cut -d: -f2 | xargs)"
				sts5="\033[1;32m◉ "
			} || {
				sts5="\033[1;31m○ "
			}

			[[ "$(netstat -tlpn | grep 'python' | wc -l)" != '0' ]] && {
				echo -e "\033[1;32mSERVICO: \033[1;33mPROXY SOCKS \033[1;32mPORTA: \033[1;37m$(netstat -nplt | grep 'python' | awk {'print $4'} | cut -d: -f2 | xargs)"
				sts4="\033[1;32m◉ "
			} || {
				sts4="\033[1;31m○ "
			}
			[[ -e "/etc/stunnel/stunnel.conf" ]] && {
				echo -e "\033[1;32mSERVICO: \033[1;33mSSL TUNNEL \033[1;32mPORTA: \033[1;37m$(netstat -nplt | grep 'stunnel' | awk {'print $4'} | cut -d: -f2 | xargs)"
				sts3="\033[1;32m◉ "
			} || {
				sts3="\033[1;31m○ "
			}
			[[ "$(netstat -tlpn | grep 'dropbear' | wc -l)" != '0' ]] && {
				echo -e "\033[1;32mSERVICO: \033[1;33mDROPBEAR \033[1;32mPORTA: \033[1;37m$(netstat -nplt | grep 'dropbear' | awk -F ":" {'print $4'} | xargs)"
				sts2="\033[1;32m◉ "
			} || {
				sts2="\033[1;31m○ "
			}
			[[ "$(netstat -tlpn | grep 'squid' | wc -l)" != '0' ]] && {
				echo -e "\033[1;32mSERVICO: \033[1;33mSQUID \033[1;32mPORTA: \033[1;37m$(netstat -nplt | grep 'squid' | awk -F ":" {'print $4'} | xargs)"
				sts1="\033[1;32m◉ "
			} || {
				sts1="\033[1;31m○ "
			}
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			echo ""
			echo -e "\033[1;31m[\033[1;36m01\033[1;31m] \033[1;37m• \033[1;33mOPENSSH $sts6\033[1;31m
[\033[1;36m02\033[1;31m] \033[1;37m• \033[1;33mSQUID PROXY $sts1\033[1;31m
[\033[1;36m03\033[1;31m] \033[1;37m• \033[1;33mDROPBEAR $sts2\033[1;31m
[\033[1;36m04\033[1;31m] \033[1;37m• \033[1;33mOPENVPN $sts5\033[1;31m
[\033[1;36m05\033[1;31m] \033[1;37m• \033[1;33mPROXY SOCKS $sts4\033[1;31m
[\033[1;36m06\033[1;31m] \033[1;37m• \033[1;33mSSL TUNNEL $sts3\033[1;31m
[\033[1;36m07\033[1;31m] \033[1;37m• \033[1;33mSSLH MULTIPLEX $sts7\033[1;31m
[\033[1;36m08\033[1;31m] \033[1;37m• \033[1;33mVOLTAR \033[1;32m<\033[1;33m<\033[1;31m< \033[1;31m
[\033[1;36m00\033[1;31m] \033[1;37m• \033[1;33mSAIR \033[1;32m<\033[1;33m<\033[1;31m< \033[0m"
			echo ""
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			echo ""
			tput civis
			echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;31m?\033[1;37m "
			read x
			tput cnorm
			clear
			case $x in
			1 | 01)
				fun_openssh
				;;
			2 | 02)
				fun_squid
				;;
			3 | 03)
				fun_drop
				;;
			4 | 04)
				fun_openvpn
				;;
			5 | 05)
				fun_socks
				;;
			6 | 06)
				inst_ssl
				;;
			7 | 07)
				fun_sslh
				;;
			8 | 08)
				menu
				;;
			0 | 00)
				echo -e "\033[1;31mSaindo...\033[0m"
				sleep 2
				clear
				exit
				;;
			*)
				echo -e "\033[1;31mOpcao invalida !\033[0m"
				sleep 2
				;;
			esac
		done
	}
	fun_conexao
}
