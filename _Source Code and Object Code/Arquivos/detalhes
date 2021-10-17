#!/bin/bash
clear
echo -e "\E[44;1;37m               INFORMACOES DO VPS                 \E[0m"
echo ""
if [ -f /etc/lsb-release ]
then
echo -e "\033[1;31m• \033[1;32mSISTEMA OPERACIONAL\033[1;31m •\033[0m"
echo ""
name=$(cat /etc/lsb-release |grep DESCRIPTION |awk -F = {'print $2'})
codename=$(cat /etc/lsb-release |grep CODENAME |awk -F = {'print $2'})
echo -e "\033[1;33mNome: \033[1;37m$name"
echo -e "\033[1;33mCodeName: \033[1;37m$codename"
echo -e "\033[1;33mKernel: \033[1;37m$(uname -s)"
echo -e "\033[1;33mKernel Release: \033[1;37m$(uname -r)"
if [ -f /etc/os-release ]
then
devlike=$(cat /etc/os-release |grep LIKE |awk -F = {'print $2'})
echo -e "\033[1;33mDerivado do OS: \033[1;37m$devlike"
echo ""
fi
else
system=$(cat /etc/issue.net)
echo -e "\033[1;31m• \033[1;32mSISTEMA OPERACIONAL\033[1;31m •\033[0m"
echo ""
echo -e "\033[1;33mNome: \033[1;37m$system"
echo ""
fi

if [ -f /proc/cpuinfo ]
then
uso=$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')
echo -e "\033[1;31m• \033[1;32mPROCESSADOR\033[1;31m •\033[0m"
echo ""
modelo=$(cat /proc/cpuinfo |grep "model name" |uniq |awk -F : {'print $2'})
cpucores=$(grep -c cpu[0-9] /proc/stat)
cache=$(cat /proc/cpuinfo |grep "cache size" |uniq |awk -F : {'print $2'})
echo -e "\033[1;33mModelo:\033[1;37m$modelo"
echo -e "\033[1;33mNucleos:\033[1;37m $cpucores"
echo -e "\033[1;33mMemoria Cache:\033[1;37m$cache"
echo -e "\033[1;33mArquitetura: \033[1;37m$(uname -p)"
echo -e "\033[1;33multilizacao: \033[37m$uso"
echo ""
else
echo -e "\033[1;32mPROCESSADOR\033[0m"
echo ""
echo "Não foi possivel obter informações"
fi

if free 1>/dev/null 2>/dev/null
then
ram1=$(free -h | grep -i mem | awk {'print $2'})
ram2=$(free -h | grep -i mem | awk {'print $4'})
ram3=$(free -h | grep -i mem | awk {'print $3'})
usoram=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }')

echo -e "\033[1;31m• \033[1;32mMEMORIA RAM\033[1;31m •\033[0m"
echo ""
echo -e "\033[1;33mTotal: \033[1;37m$ram1"
echo -e "\033[1;33mEm Uso: \033[1;37m$ram3"
echo -e "\033[1;33mLivre: \033[1;37m$ram2"
echo -e "\033[1;33multilizacao: \033[37m$usoram"
echo ""
else
echo -e "\033[1;32mMEMORIA RAM\033[0m"
echo ""
echo "Não foi possivel obter informações"
fi
[[ ! -e /bin/versao ]] && rm -rf /etc/SSHPlus
echo -e "\033[1;31m• \033[1;32mSERVICOS EM EXECUCAO\033[1;31m •\033[0m"
echo ""
PT=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
for porta in `echo -e "$PT" | cut -d: -f2 | cut -d' ' -f1 | uniq`; do
    svcs=$(echo -e "$PT" | grep -w "$porta" | awk '{print $1}' | uniq)
    echo -e "\033[1;33mServico \033[1;37m$svcs \033[1;33mPorta \033[1;37m$porta"
done