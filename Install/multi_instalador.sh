#!/bin/bash

barra="\033[0m\e[34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
MIP_CMD="/bin/mip"
SSHPLUS_SCRIPT="https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master"

# Crear acceso rápido si no existe
[[ ! -e $MIP_CMD ]] && echo "/root/sshplus.sh" > $MIP_CMD && chmod +x $MIP_CMD

# Barra de carga
fun_bar() {
  local cmd1="$1"
  local cmd2="$2"

  (
    [[ -e $HOME/fim ]] && rm $HOME/fim
    $cmd1 > /dev/null 2>&1
    $cmd2 > /dev/null 2>&1
    touch $HOME/fim
  ) &

  tput civis
  echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["

  while true; do
    for ((i = 0; i < 18; i++)); do
      echo -ne "\033[1;31m#"
      sleep 0.1s
    done
    [[ -e $HOME/fim ]] && rm $HOME/fim && break
    echo -e "\033[1;33m]"
    sleep 1
    tput cuu1 && tput dl1
    echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
  done

  echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
  tput cnorm
}

# Funciones principales
sshplusfree() {
  apt-get update -y && apt-get upgrade -y
  wget "$SSHPLUS_SCRIPT/Plus" -O Plus && chmod +x Plus && ./Plus
}

sshpluskey() {
  bash <(wget -qO- sshplus.xyz/scripts/sshplus.sh)
}

install_panel() {
  version="$1"
  script_url="$SSHPLUS_SCRIPT/Install/Panel_Web/$version/install"
  wget "$script_url" -O install && chmod +x install && ./install
}

panel_update2325() {
  wget "$SSHPLUS_SCRIPT/Install/Panel_Web/panel_v23_2/atu-v23-p-v25" -O atu && chmod +x atu && ./atu
}

panelwebversiones() {
  apt-get update -y && apt-get upgrade -y
  wget "$SSHPLUS_SCRIPT/Install/Panel_Web/Panelweb.sh" -O Panelweb.sh && chmod +x Panelweb.sh && ./Panelweb.sh
}

keyssh() {
  apt-get update -y && apt-get upgrade -y
  wget "$SSHPLUS_SCRIPT/Install/Generador/instgerador.sh" -O instgerador.sh && chmod +x instgerador.sh && ./instgerador.sh
}

fun_tcpspeed() {
  rm -f $HOME/tcptweaker.sh
  bash <(wget -qO- "$SSHPLUS_SCRIPT/Install/TCP-Speed/tcptweaker.sh")
}

atualizar() {
  echo ""
  fun_bar "apt-get update -y"
  fun_bar "apt-get upgrade -y"

  fun_att() {
    service ssh restart
    rm -f $HOME/sshplus.sh /bin/mip
    wget "$SSHPLUS_SCRIPT/Install/Multi-Instalador/sshplus.sh" -O /root/sshplus.sh
  }

  fun_bar fun_att
  echo -e "\n\033[1;33m UPDATE COM SUCESSO -\033[1;32m OK !\033[1;37m"
  sleep 2
  chmod +x /root/sshplus.sh && /root/sshplus.sh
}

remove_multiscripts() {
  rm -f $HOME/sshplus.sh /bin/mip
  echo -e "\n\033[1;31mRemovido com sucesso.\033[0m"
}

# Menú principal
menu() {
  while true; do
    clear
    RAM=$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')
    CPU=$(top -bn1 | awk '/Cpu/ { printf("%.2f%%", 100 - $8) }')

    echo -e "$barra"
    echo -e "\E[41;1;37mMULTI-INSTALADOR                  \033[1;32m[\033[1;37m VERSAO: r021 \033[1;32m]\E[0m"
    echo -e "$barra"
    echo ""
    echo -e "\033[1;31m[01] \033[1;33mSSHPLUS MANAGER FREE"
    echo -e "\033[1;31m[02] \033[1;33mSSHPLUS MANAGER OFICIAL (KEYS)"
    echo -e "\033[1;31m[03] \033[1;33mPAINEL SSHPLUS WEB V.20"
    echo -e "\033[1;31m[04] \033[1;33mPAINEL VIP-VPS WEB V.23"
    echo -e "\033[1;31m[05] \033[1;33mPAINEL VIP-VPS WEB V.25"
    echo -e "\033[1;31m[06] \033[1;33mUPDATE V23 ➜ V25"
    echo -e "\033[1;31m[07] \033[1;33mPAINEL REVENDA SSH (VERSÕES)"
    echo -e "\033[1;31m[08] \033[1;33mGERADOR DE KEYS SSHPLUS"
    echo -e "\033[1;31m[09] \033[1;33mTCP-TWEAKER 1.0"
    echo -e "\033[1;31m[10] \033[1;35m[!] ATUALIZAR \033[1;31m(RAM: $RAM)"
    echo -e "\033[1;31m[11] \033[1;35m[!] DESINSTALAR MIP \033[1;31m(CPU: $CPU)"
    echo -e "\033[1;31m[00] \033[1;37mSAIR"
    echo -e "$barra"
    echo ""
    read -p $'\033[1;32mO QUE DESEJA FAZER? \033[1;33m» \033[1;37m' opcao

    case "$opcao" in
      1 | 01) sshplusfree ;;
      2 | 02) sshpluskey ;;
      3 | 03) install_panel "panel_v20" ;;
      4 | 04) install_panel "panel_v23_2" ;;
      5 | 05) install_panel "panel_v25" ;;
      6 | 06) panel_update2325 ;;
      7 | 07) panelwebversiones ;;
      8 | 08) keyssh ;;
      9 | 09) fun_tcpspeed ;;
      10) atualizar ;;
      11) remove_multiscripts ;;
      0 | 00)
        echo -e "\033[1;31mSaindo...\033[0m"
        sleep 1
        break
        ;;
      *) echo -e "\n\033[1;31mOpção inválida!\033[0m" && sleep 2 ;;
    esac
  done
}

# Iniciar menú
menu
