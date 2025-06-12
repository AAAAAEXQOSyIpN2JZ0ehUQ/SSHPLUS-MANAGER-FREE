#!/bin/bash

#====================================================
#  CODIGO FUENTE:         iLLuminati Dev Team
#====================================================
#  SCRIPT: SSHPlus        SSHPlus Keygen
#  DATA ATUALIZACAO:      01-03-2022 
#  CONTATO TELEGRAM:      @AAAAAEXQOSyIpN2JZ0ehUQ
#  GRUPO TELEGRAM:        https://t.me/AAAAAEXQOSyIpN2JZ0ehUQ
#====================================================

[[ "$(whoami)" != "root" ]] && {
echo -e "\033[1;33m[\033[1;31mErro\033[1;33m] \033[1;37m- \033[1;33mvocê precisa executar como root\033[0m"
rm $HOME/instgerador.sh* > /dev/null 2>&1; exit 0
}

[ ! -d "/etc/sshplus-server" ] && mkdir -p /etc/sshplus-server

SCRIPT_DIR="/etc/sshplus-server/_script_\$"
CRZ_DIR="$SCRIPT_DIR/crz"
GITHUB_RAW="https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Proyectos/SSHPlus_Keygen/Modulos"

cd $HOME
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
echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
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
   echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}

fun_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
echo -e "$IP" >/etc/IP
}

fun_attlist() {
    apt-get update -y && apt-get upgrade -y
}

fun_inst_pct() {
    local packages=("curl" "screen" "zip" "unzip" "apache2")
    for pkg in "${packages[@]}"; do
        apt-get install -y "$pkg"
    done
    sed -i 's/Listen 81/Listen 80/' /etc/apache2/ports.conf
    systemctl enable apache2
    systemctl restart apache2
}

fun_dirconfig() {
    rm -rf /etc/sshplus-server/list /etc/sshplus-server/index.html /etc/sshplus-server/_script_\$ /etc/sshplus-server/versao /bin/keyssh /bin/key /etc/PlusKeygen-Active
    rm -rf /var/www/html/{meuip.php,versao,script,scripts}
    mkdir -p "$CRZ_DIR"
    mkdir -p /var/www/html/{script,scripts}
    echo "/bin/keyssh" > /bin/key
}

fun_downser() {
    cd "$CRZ_DIR"
    wget -O sshplus-v38.zip "https://github.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/raw/master/Proyectos/SSHPlus_Keygen/Modulos/sshplus-v38.zip"
    unzip -o sshplus-v38.zip
    rm -f sshplus-v38.zip
}

fun_instarq() {
    wget -O /etc/sshplus-server/index.html "$GITHUB_RAW/index.html"
    wget -O /etc/sshplus-server/list "$GITHUB_RAW/list"
    wget -O /etc/sshplus-server/versao "$GITHUB_RAW/versao"
    wget -O /bin/keyssh "$GITHUB_RAW/keyssh"
    wget -O /var/www/html/meuip.php "$GITHUB_RAW/meuip.php"
    wget -O /var/www/html/scripts/Plus "$GITHUB_RAW/Plus"
    wget -O /var/www/html/script/versao "$GITHUB_RAW/versao"
}

fun_permarq() {
    chmod +x /etc/sshplus-server/{versao,list,index.html}
    chmod +x /bin/{keyssh,key}
    chmod +x /var/www/html/meuip.php
    chmod +x /var/www/html/scripts/Plus
    chmod +x /var/www/html/script/versao
    chmod -R 755 "$CRZ_DIR"
}

fun_montaip() {
  echo -e "\n\033[1;33mCONFIGURAR IP OU DOMÍNIO         \033[0m"
  echo ""

  # Detectar IP pública e IP local
  ip_publica=$(wget -qO- http://ipv4.icanhazip.com)
  ip_local=$(hostname -I | awk '{print $1}')

  echo -e "\033[1;33mIP Pública Detectada: \033[1;37m$ip_publica\033[0m"
  echo -e "\033[1;33mIP Local Detectada:   \033[1;37m$ip_local\033[0m"
  echo ""

  # Solicitar IP ou domínio
  while true; do
    echo -e "\033[1;33mDigite o IP com porta    \033[1;37m(ex: 192.168.1.100:80)\033[0m"
    echo -e "\033[1;33mou o domínio             \033[1;37m(ex: script.sshplus.net)\033[0m"
    echo ""
    echo -ne "\033[1;32mIP ou domínio: \033[1;37m"
    read ip_ou_dominio

    if [[ -z "$ip_ou_dominio" ]]; then
      echo -e "\033[1;31mEntrada vazia. Tente novamente.\033[0m"
      continue
    fi

    # Validação básica
    if [[ "$ip_ou_dominio" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:[0-9]+$ || "$ip_ou_dominio" =~ ^[a-zA-Z0-9.-]+$ ]]; then
      break
    else
      echo -e "\033[1;31mFormato inválido. Tente novamente.\033[0m"
    fi
  done

  # Substituir SEU-IP-AKI nos arquivos
  sed -i "s;SEU-IP-AKI;$ip_ou_dominio;g" /bin/keyssh 2>/dev/null
  sed -i "s;SEU-IP-AKI;$ip_ou_dominio;g" /var/www/html/scripts/Plus 2>/dev/null
  sed -i "s;SEU-IP-AKI;$ip_ou_dominio;g" /etc/sshplus-server/list 2>/dev/null

  echo -e "\n\033[1;32mConfiguração aplicada com sucesso!\033[0m"
  echo ""
  sleep 2
}

fun_montaip_OFF() {
    # Nota: Las variables _lnk (script.sshplus.net) y _lvk (versao del scripts dentro del archivo list) deben ser modificadas    
    # _lnk=$(echo 't1:e#n.5s0ul&p4hs$s.0729t9p$&8i&&9r7827c032:3s'| sed -e 's/[^a-z.]//ig'| rev); 
    # _lvk=$(wget -qO- sshplus.xyz/script/versao)
    fun_ip
    sed -i "s;SEU-IP-AKI;$IP;g" /var/www/html/scripts/Plus
    sed -i "s;SEU-IP-AKI;$IP;g" /etc/sshplus-server/list
    sleep 2
}

fun_index() {
    cp /etc/sshplus-server/index.html "$SCRIPT_DIR/index.html"
    cp /etc/sshplus-server/index.html "$CRZ_DIR/index.html"
    cp /etc/sshplus-server/index.html /var/www/html/script/index.html
    cp /etc/sshplus-server/index.html /var/www/html/scripts/index.html
    [ ! -e "/var/www/html/index.html" ] && cp /etc/sshplus-server/index.html /var/www/html/index.html
}

clear
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%40s%s%-12s\n' "BEM VINDO AO SSHPLUS KEYGEN " ; tput sgr0
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo ""
echo -e "          \033[1;31mATENÇÃO! \033[1;33mESTE SCRIPT INSTALARÁ:\033[0m"
echo ""
echo -e "\033[1;31m• \033[1;33mO GERADOR DE KEYS DO PROJETO \033[1;32mSSHPlus Keygen\033[0m"
echo -e "\033[1;33m  COM FERRAMENTAS PARA ATIVAÇÃO, CONTROLE E GESTÃO\033[0m"
echo ""
echo -e "\033[1;32m• \033[1;32mDICA: \033[1;33mUSE UM TERMINAL COM FUNDO ESCURO PARA MELHOR\033[0m"
echo -e "\033[1;33m  VISUALIZAÇÃO E EXPERIÊNCIA DURANTE A INSTALAÇÃO\033[0m"
echo ""
echo -e "\033[1;31m≠×≠×≠×≠×≠×≠×≠×≠×[\033[1;33m • \033[1;32mBY CRAZY VPN\033[1;33m •\033[1;31m ]≠×≠×≠×≠×≠×≠×≠×≠×\033[0m"
echo ""
read -p "$(echo -e "\033[1;36mDESEJA CONTINUAR \033[1;31m? \033[1;33m[S/N]:\033[1;37m ")" -e -i s resp
[[ $resp = @(n|N) ]] && rm $HOME/instgerador.sh* && exit 0
echo ""
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo ""
echo -e "\033[1;32m [1/8] Atualizando pacotes\033[0m"
fun_bar fun_attlist

echo -e "\033[1;32m [2/8] Instalando dependências\033[0m"
fun_bar fun_inst_pct

echo -e "\033[1;32m [3/8] Configurando diretórios\033[0m"
fun_bar fun_dirconfig

echo -e "\033[1;32m [4/8] Baixando servidor\033[0m"
fun_bar fun_downser

echo -e "\033[1;32m [5/8] Instalando arquivos\033[0m"
fun_bar fun_instarq

echo -e "\033[1;32m [6/8] Aplicando permissões\033[0m"
fun_bar fun_permarq

echo -e "\033[1;32m [7/8] Montando IP nos scripts\033[0m"
fun_montaip

echo -e "\033[1;32m [8/8] Finalizando configuração\033[0m"
fun_bar fun_index

echo -e "\n\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e "\033[1;33mCOMANDO PRINCIPAL: \033[1;32mkeyssh ou key\033[0m"
echo -e "\033[1;33mCONTATO: \033[1;31m(\033[1;36mTELEGRAM\033[1;31m): \033[1;37m@AAAAAEXQOSyIpN2JZ0ehUQ\033[0m"
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo ""

rm $HOME/instgerador.sh* > /dev/null 2>&1; exit 0
