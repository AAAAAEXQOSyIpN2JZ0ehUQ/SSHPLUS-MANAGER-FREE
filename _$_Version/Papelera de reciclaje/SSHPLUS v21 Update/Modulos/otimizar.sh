#!/bin/bash
clear
fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
echo -ne "     \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
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
   echo -ne "     \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}
echo -e "\E[44;1;37m                Otimizar Servidor                \E[0m"
echo ""
#
echo -e "\033[1;32m               Atualizando pacotes\033[0m"
echo ""
fun_bar 'apt-get update -y' 'apt-get upgrade -y'
echo ""
echo -e "\033[1;32m      Corrigindo problemas de dependências"
echo""
fun_bar 'apt-get -f install'
# Corrigir problemas de dependências, concluir instalação de pacotes pendentes e outros erros
echo""
echo -e "\033[1;32m            Removendo pacotes inúteis"
echo ""
fun_bar 'apt-get autoremove -y' 'apt-get autoclean -y'
# Remover pacotes instalados automaticamente e que não tem mais nenhuma utilidade para o sistema
# Remover pacotes antigos ou duplicados
echo ""
# Remove arquivos inúteis do cache, onde registra as cópias das atualizações q são instaladas pelo gerenciador de pacotes

echo -e "\033[1;32m        Removendo pacotes com problemas"
echo ""
fun_bar 'apt-get -f remove -y' 'apt-get clean -y'
#Remover pacotes com problemas
#Limpar o cache da memoria RAM
clear
echo -e "\033[1;31m═══════════════════════════════════════════════\033[0m"
echo ""
MEM1=`free|awk '/Mem:/ {print int(100*$3/$2)}'`
ram1=$(free -h | grep -i mem | awk {'print $2'})
ram2=$(free -h | grep -i mem | awk {'print $4'})
ram3=$(free -h | grep -i mem | awk {'print $3'})
swap1=$(free -h | grep -i swap | awk {'print $2'})
swap2=$(free -h | grep -i swap | awk {'print $4'})
swap3=$(free -h | grep -i swap | awk {'print $3'})

echo -e "\033[1;31m•\033[1;32mMemoria RAM\033[1;31m•\033[0m                    \033[1;31m•\033[1;32mSwap\033[1;31m•\033[0m"
echo -e " \033[1;33mTotal: \033[1;37m$ram1                   \033[1;33mTotal: \033[1;37m$swap1"
echo -e " \033[1;33mEm Uso: \033[1;37m$ram3                  \033[1;33mEm Uso: \033[1;37m$swap3"
echo -e " \033[1;33mLivre: \033[1;37m$ram2                   \033[1;33mLivre: \033[1;37m$swap2\033[0m"
echo ""
echo -e "\033[1;37mMemória \033[1;32mRAM \033[1;37mAntes da Otimizacao:\033[1;36m" $MEM1% 
echo ""
echo -e "\033[1;31m═══════════════════════════════════════════════\033[0m"
sleep 3
echo ""
fun_limpram () {
sync 
echo 3 > /proc/sys/vm/drop_caches
sleep 4
sync && sysctl -w vm.drop_caches=3
sysctl -w vm.drop_caches=0
swapoff -a
swapon -a
sleep 4
}
function aguarde {
sleep 1
helice ()
{
	fun_limpram > /dev/null 2>&1 & 
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
echo -ne "\033[1;37mLIMPANDO MEMORIA \033[1;32mRAM \033[1;37me \033[1;32mSWAP\033[1;32m.\033[1;33m.\033[1;31m. \033[1;33m"
helice
echo -e "\e[1DOk"
}
aguarde
sleep 1.5s
clear
echo -e "\033[1;32m═══════════════════════════════════════════════\033[0m"
echo ""
MEM2=`free|awk '/Mem:/ {print int(100*$3/$2)}'`
ram1=$(free -h | grep -i mem | awk {'print $2'})
ram2=$(free -h | grep -i mem | awk {'print $4'})
ram3=$(free -h | grep -i mem | awk {'print $3'})
swap1=$(free -h | grep -i swap | awk {'print $2'})
swap2=$(free -h | grep -i swap | awk {'print $4'})
swap3=$(free -h | grep -i swap | awk {'print $3'})

echo -e "\033[1;31m•\033[1;32mMemoria RAM\033[1;31m•\033[0m                    \033[1;31m•\033[1;32mSwap\033[1;31m•\033[0m"
echo -e " \033[1;33mTotal: \033[1;37m$ram1                   \033[1;33mTotal: \033[1;37m$swap1"
echo -e " \033[1;33mEm Uso: \033[1;37m$ram3                  \033[1;33mEm Uso: \033[1;37m$swap3"
echo -e " \033[1;33mLivre: \033[1;37m$ram2                   \033[1;33mLivre: \033[1;37m$swap2\033[0m"
echo ""
echo -e "\033[1;37mMemória \033[1;32mRAM \033[1;37mapós a Otimizacao:\033[1;36m" $MEM2% 
echo ""
echo -e "\033[1;37mEconomia de :\033[1;31m `expr $MEM1 - $MEM2`%\033[0m"

echo -e "\033[1;32m═══════════════════════════════════════════════\033[0m"