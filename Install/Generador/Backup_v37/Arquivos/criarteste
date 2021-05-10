#!/bin/bash
IP=$(cat /etc/IP)
if [ ! -d /etc/SSHPlus/userteste ]; then
mkdir /etc/SSHPlus/userteste
fi
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%30s%s%-15s\n' "Criar usuario teste" ; tput sgr0
echo ""
[ "$(ls -A /etc/SSHPlus/userteste)" ] && echo -e "\033[1;32mTeste Ativo!\033[1;37m" || echo -e "\033[1;31mNenhum test ativo!\033[0m"
echo ""
for testeson in $(ls /etc/SSHPlus/userteste |sort |sed 's/.sh//g')
do
echo "$testeson"
done
echo ""
echo -ne "\033[1;32mNome do usuario\033[1;37m: "; read nome
if [[ -z $nome ]]
then
echo ""
tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "Nome vazio ou invalido." ; echo "" ; tput sgr0
	exit 1
fi
awk -F : ' { print $1 }' /etc/passwd > /tmp/users 
if grep -Fxq "$nome" /tmp/users
then
	tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "Este usuário já existe." ; echo "" ; tput sgr0
	exit 1
fi
echo -ne "\033[1;32mSenha\033[1;37m: "; read pass
if [[ -z $pass ]]
then
echo ""
tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "Senha vazia ou invalida." ; echo "" ; tput sgr0
	exit 1
fi
echo -ne "\033[1;32mLimite\033[1;37m: "; read limit
if [[ -z $limit ]]
then
echo ""
tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "Limite vazio ou invalido." ; echo "" ; tput sgr0
	exit 1
fi
echo -ne "\033[1;32mMinutos \033[1;33m(\033[1;31mEx: \033[1;37m60\033[1;33m)\033[1;37m: "; read u_temp
if [[ -z $limit ]]
then
echo ""
tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "Limite vazio ou invalido." ; echo "" ; tput sgr0
	exit 1
fi
useradd -M -s /bin/false $nome
(echo $pass;echo $pass) |passwd $nome > /dev/null 2>&1
echo "$pass" > /etc/SSHPlus/senha/$nome
echo "$nome $limit" >> /root/usuarios.db
echo "#!/bin/bash
pkill -f "$nome"
userdel --force $nome
grep -v ^$nome[[:space:]] /root/usuarios.db > /tmp/ph ; cat /tmp/ph > /root/usuarios.db
rm /etc/SSHPlus/senha/$nome > /dev/null 2>&1
rm -rf /etc/SSHPlus/userteste/$nome.sh
exit" > /etc/SSHPlus/userteste/$nome.sh
chmod +x /etc/SSHPlus/userteste/$nome.sh
at -f /etc/SSHPlus/userteste/$nome.sh now + $u_temp min > /dev/null 2>&1
clear
echo -e "\E[44;1;37m     Usuario Teste Criado     \E[0m"
echo ""
echo -e "\033[1;32mIP:\033[1;37m $IP"
echo -e "\033[1;32mUsuario:\033[1;37m $nome"
echo -e "\033[1;32mSenha:\033[1;37m $pass"
echo -e "\033[1;32mLimite:\033[1;37m $limit"
echo -e "\033[1;32mValidade:\033[1;37m $u_temp Minutos"
echo ""
echo -e "\033[1;33mApos o tempo definido o usuario"
echo -e "\033[1;32m$nome \033[1;33msera desconectado e deletado.\033[0m"
exit
