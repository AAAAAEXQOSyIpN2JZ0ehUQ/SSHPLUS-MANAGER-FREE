#!/bin/sh
ipdovps=$1
sitearquivos=$2
echo "Aguarde a configuração automática"
sleep 3
apt-get update -y
apt-get upgrade -y
apt-get install squid3 bc screen nano unzip wget -y
killall apache2
apt-get purge apache2 -y
if [ -f "/usr/sbin/ufw" ] ; then
	ufw allow 443/tcp ; ufw allow 80/tcp ; ufw allow 3128/tcp ; ufw allow 8799/tcp ; ufw allow 8080/tcp
fi
if [ -d "/etc/squid3/" ]
then
	wget http://$sitearquivos/scripts/vpsmanager/squid1.txt -O /tmp/sqd1
	echo "acl url3 dstdomain -i $ipdovps" > /tmp/sqd2
	wget http://$sitearquivos/scripts/vpsmanager/squid2.txt -O /tmp/sqd3
	cat /tmp/sqd1 /tmp/sqd2 /tmp/sqd3 > /etc/squid3/squid.conf
	wget http://$sitearquivos/scripts/vpsmanager/payload.txt -O /etc/squid3/payload.txt
	echo " " >> /etc/squid3/payload.txt
	grep -v "^Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
	echo "Port 443" >> /etc/ssh/sshd_config
	grep -v "^PasswordAuthentication yes" /etc/ssh/sshd_config > /tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
	echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
	wget http://$sitearquivos/scripts/vpsmanager/scripts/addhost.sh -O /bin/addhost
	chmod +x /bin/addhost
	wget http://$sitearquivos/scripts/vpsmanager/scripts/alterarsenha.sh -O /bin/alterarsenha
	wget http://$sitearquivos/scripts/update/AlterarSenha.sh
	chmod 777 AlterarSenha.sh
	chmod +x /bin/alterarsenha
	wget http://$sitearquivos/scripts/vpsmanager/scripts/criarusuario2.sh -O /bin/criarusuario
	wget http://$sitearquivos/scripts/update/criarusuario.sh
	chmod 777 criarusuario.sh
	chmod +x /bin/criarusuario
	wget http://$sitearquivos/scripts/vpsmanager/scripts/delhost.sh -O /bin/delhost
	chmod +x /bin/delhost
	wget http://$sitearquivos/scripts/vpsmanager/scripts/expcleaner2.sh -O /bin/expcleaner
	chmod +x /bin/expcleaner
	wget http://$sitearquivos/scripts/vpsmanager/scripts/mudardata.sh -O /bin/mudardata
	chmod +x /bin/mudardata
	wget http://$sitearquivos/scripts/vpsmanager/scripts/remover.sh -O /bin/remover
	wget http://$sitearquivos/scripts/update/remover.sh
	chmod 777 remover.sh
	chmod +x /bin/remover
	wget http://$sitearquivos/scripts/vpsmanager/scripts/sshlimiter2.sh -O /bin/sshlimiter
	chmod +x /bin/sshlimiter
	wget http://$sitearquivos/scripts/vpsmanager/scripts/alterarlimite.sh -O /bin/alterarlimite
	wget http://$sitearquivos/scripts/update/alterarlimite.sh
    chmod 777 alterarlimite.sh
	chmod +x /bin/alterarlimite
	wget http://$sitearquivos/scripts/vpsmanager/scripts/ajuda.sh -O /bin/ajuda
	chmod +x /bin/ajuda
	wget http://$sitearquivos/scripts/vpsmanager/scripts/sshmonitor2.sh -O /bin/sshmonitor
	wget http://$sitearquivos/scripts/update/sshmonitor.sh
	chmod 777 sshmonitor.sh
	chmod +x /bin/sshmonitor
	wget http://$sitearquivos/scripts/update/KillUser.sh
	chmod 777 KillUser.sh
if [ ! -f "/etc/init.d/squid3" ]
	then
		service squid3 reload > /dev/null
	else
		/etc/init.d/squid3 reload > /dev/null
	fi
	if [ ! -f "/etc/init.d/ssh" ]
	then
		service ssh reload > /dev/null
	else
		/etc/init.d/ssh reload > /dev/null
	fi
fi
if [ -d "/etc/squid/" ]
then
    wget http://$sitearquivos/scripts/vpsmanager/squid1.txt -O /tmp/sqd1
	echo "acl url3 dstdomain -i $ipdovps" > /tmp/sqd2
	wget http://$sitearquivos/scripts/vpsmanager/squid2.txt -O /tmp/sqd3
	cat /tmp/sqd1 /tmp/sqd2 /tmp/sqd3 > /etc/squid/squid.conf
	wget http://$sitearquivos/scripts/vpsmanager/payload.txt -O /etc/squid/payload.txt
	echo " " >> /etc/squid/payload.txt
	grep -v "^Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
	echo "Port 443" >> /etc/ssh/sshd_config
	grep -v "^PasswordAuthentication yes" /etc/ssh/sshd_config > /tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
	echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
	wget http://$sitearquivos/scripts/vpsmanager/scripts/addhost.sh -O /bin/addhost
	chmod +x /bin/addhost
	wget http://$sitearquivos/scripts/vpsmanager/scripts/alterarsenha.sh -O /bin/alterarsenha
	wget http://$sitearquivos/scripts/update/AlterarSenha.sh
	chmod 777 AlterarSenha.sh
	chmod +x /bin/alterarsenha
	wget http://$sitearquivos/scripts/vpsmanager/scripts/criarusuario2.sh -O /bin/criarusuario
	wget http://$sitearquivos/scripts/update/criarusuario.sh
	chmod 777 criarusuario.sh
	chmod +x /bin/criarusuario
	wget http://$sitearquivos/scripts/vpsmanager/scripts/delhost.sh -O /bin/delhost
	chmod +x /bin/delhost
	wget http://$sitearquivos/scripts/vpsmanager/scripts/expcleaner2.sh -O /bin/expcleaner
	chmod +x /bin/expcleaner
	wget http://$sitearquivos/scripts/vpsmanager/scripts/mudardata.sh -O /bin/mudardata
	chmod +x /bin/mudardata
	wget http://$sitearquivos/scripts/vpsmanager/scripts/remover.sh -O /bin/remover
	wget http://$sitearquivos/scripts/update/remover.sh
	chmod 777 remover.sh
	chmod +x /bin/remover
	wget http://$sitearquivos/scripts/vpsmanager/scripts/sshlimiter2.sh -O /bin/sshlimiter
	chmod +x /bin/sshlimiter
	wget http://$sitearquivos/scripts/vpsmanager/scripts/alterarlimite.sh -O /bin/alterarlimite
	wget http://$sitearquivos/scripts/update/alterarlimite.sh
    chmod 777 alterarlimite.sh
	chmod +x /bin/alterarlimite
	wget http://$sitearquivos/scripts/vpsmanager/scripts/ajuda.sh -O /bin/ajuda
	chmod +x /bin/ajuda
	wget http://$sitearquivos/scripts/vpsmanager/scripts/sshmonitor2.sh -O /bin/sshmonitor
	wget http://$sitearquivos/scripts/update/sshmonitor.sh
	chmod 777 sshmonitor.sh
	chmod +x /bin/sshmonitor
	wget http://$sitearquivos/scripts/update/KillUser.sh
	chmod 777 KillUser.sh
if [ ! -f "/etc/init.d/squid3" ]
	then
		service squid3 reload > /dev/null
	else
		/etc/init.d/squid3 reload > /dev/null
	fi
	if [ ! -f "/etc/init.d/ssh" ]
	then
		service ssh reload > /dev/null
	else
		/etc/init.d/ssh reload > /dev/null
	fi
fi
tput setaf 3; echo "Proxy Squid3 instalado e rodando nas portas 80, 3128, 8799 e 8080. SSH rodando nas portas 22 e 443. \nScripts instalados como comandos do sistema. Para verificar e aprender a usar os scripts use o comando:\najuda\n" ; tput sgr0
exit 1