#!/bin/bash

barra="\033[0m\e[34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
SCRIPT_URL_BASE="https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web"
SCRIPT_TEMP="/tmp/painel_installer"
BIN_CMD="/bin/ipw"

[[ ! -e $BIN_CMD ]] && echo "/root/Panelweb.sh" > "$BIN_CMD" && chmod +x "$BIN_CMD"

trap 'tput cnorm; exit' INT TERM

# Barra de progreso visual
fun_bar () {
    local comando1="$1"
    local comando2="$2"

    (
        [[ -e "$HOME/fim" ]] && rm "$HOME/fim"
        $comando1 > /dev/null 2>&1
        $comando2 > /dev/null 2>&1
        touch "$HOME/fim"
    ) &

    tput civis
    echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["

    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[1;31m#"
            sleep 0.1s
        done
        if [[ -e "$HOME/fim" ]]; then
            rm "$HOME/fim"
            break
        fi
        echo -e "\033[1;33m]"
        sleep 1
        tput cuu1 && tput dl1
        echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
    done
    echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
    tput cnorm
}

# Función para descargar y ejecutar scripts
install_script () {
    local url="$1"
    local filename="$SCRIPT_TEMP/$(basename $url)"
    mkdir -p "$SCRIPT_TEMP"
    wget -qO "$filename" "$url"
    chmod +x "$filename"
    "$filename"
}

# Instaladores individuales
panel_v10() { install_script "$SCRIPT_URL_BASE/panel_v10/Painel.sh"; }
panel_v10_2() { install_script "$SCRIPT_URL_BASE/panel_v10_2/install.sh"; }
panel_v11() { install_script "$SCRIPT_URL_BASE/panel_v11/Painelv11.sh"; }
panel_v11_2() { install_script "$SCRIPT_URL_BASE/panel_v11_2/install"; }
panel_v12() { install_script "$SCRIPT_URL_BASE/panel_v12/install"; }
panel_v15() { install_script "$SCRIPT_URL_BASE/panel_v15/install"; }
panel_v15_2() { install_script "$SCRIPT_URL_BASE/panel_v15_2/ocspanel"; }
panel_v20() { install_script "$SCRIPT_URL_BASE/panel_v20/install"; }
panel_v20_mod() { install_script "$SCRIPT_URL_BASE/panel_v20_mod/install"; }
panel_v23() { install_script "$SCRIPT_URL_BASE/panel_v23/install"; }
panel_v23_2() { install_script "$SCRIPT_URL_BASE/panel_v23_2/install"; }
panel_v25() { install_script "$SCRIPT_URL_BASE/panel_v25/install"; }
panel_update2325() { install_script "$SCRIPT_URL_BASE/panel_v23_2/atu-v23-p-v25"; }

# Limpieza de archivos
clean_folder() {
    echo -e "\n\033[1;36mLIMPIANDO ARQUIVOS...\033[0m"
    fun_bar "apt-get update -y" "apt-get upgrade -y"
    rm -rf $HOME/{install*,Painel.sh*,Painelv11.sh*,banco.sql*,*.sql,ocspanel*}
    echo -e "\n\033[1;32mCLEAN FOLDER REALIZADO COM SUCESSO!\033[0m"
    sleep 2
    exec "$0"
}

# Remover painel
remove_panel() {
    read -p $'\n\033[1;37mDeseja remover o MySQL também? [s/N]: \033[0m' answer
    [[ "$answer" =~ ^[Ss]$ ]] || return

    fun_bar "apt-get purge -y mysql-server mysql-client mysql-common" \
            "rm -rf /etc/mysql /var/lib/mysql"
    apt-get autoremove -y && apt-get autoclean -y
    service apache2 restart
    echo -e "\n\033[1;32mPAINEL REMOVIDO COM SUCESSO!\033[0m"
    sleep 2
    exec "$0"
}

# Atualizar script principal
atualizar() {
    echo -e "\n\033[1;36mAtualizando script...\033[0m"
    fun_bar "apt-get update -y" "apt-get upgrade -y"
    wget -qO Panelweb.sh "$SCRIPT_URL_BASE/Panelweb.sh"
    chmod +x Panelweb.sh && ./Panelweb.sh
    exit
}

remove_multiscripts() {
    rm -rf "$HOME/Panelweb.sh" "$BIN_CMD"
    echo -e "\n\033[1;31mSCRIPT DESINSTALADO\033[0m"
    exit
}

# Menu principal
menu() {
    while true; do
        _usor="$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')"
        _usop="$(top -bn1 | awk '/Cpu/ {printf "%.1f%%", 100 - $8}')"

        clear
        echo -e "$barra"
        echo -e "\E[41;1;37m INSTALL PAINEL REVENDA SSH       \033[1;32m[\033[1;37m VERSAO: r002 \033[1;32m]\E[0m"
        echo -e "$barra"
        echo -e "\n\033[1;33mEscolha uma opção:\033[0m"
        echo -e "\033[1;36m01\033[0m - Painel V10       \033[1;31m(ANT)"
        echo -e "\033[1;36m02\033[0m - Painel V10_2     \033[1;31m(DAN)"
        echo -e "\033[1;36m03\033[0m - Painel V11       \033[1;31m(ANT)"
        echo -e "\033[1;36m04\033[0m - Painel V11_2     \033[1;32m(@backup-new)"
        echo -e "\033[1;36m05\033[0m - Painel V12       \033[1;32m(@backup-new)"
        echo -e "\033[1;36m06\033[0m - Painel V15       \033[1;31m(ANT)"
        echo -e "\033[1;36m07\033[0m - Painel V15_2     \033[1;31m(OCS)"
        echo -e "\033[1;36m08\033[0m - Painel V20       \033[1;32m(@backup-new)"
        echo -e "\033[1;36m09\033[0m - Painel V20 MOD   \033[1;32m(@backup-new)"
        echo -e "\033[1;36m10\033[0m - Painel V23       \033[1;32m(@backup-new)"
        echo -e "\033[1;36m11\033[0m - Painel V23_2     \033[1;32m(@Adeilsonfi)"
        echo -e "\033[1;36m12\033[0m - Painel V25       \033[1;32m(@Adeilsonfi)"
        echo -e "\033[1;36m13\033[0m - Atualizar V23→V25"
        echo -e "\033[1;36m14\033[0m - Limpar arquivos"
        echo -e "\033[1;36m15\033[0m - Remover Painel"
        echo -e "\033[1;36m16\033[0m - Atualizar script \033[1;31mRAM:\033[1;37m $_usor"
        echo -e "\033[1;36m17\033[0m - Desinstalar IPW  \033[1;31mCPU:\033[1;37m $_usop"
        echo -e "\033[1;36m00\033[0m - Sair"
        echo -e "$barra"
        read -p $'\n\033[1;32mEscolha: \033[0m' opc

        case "$opc" in
            1) panel_v10 ;;
            2) panel_v10_2 ;;
            3) panel_v11 ;;
            4) panel_v11_2 ;;
            5) panel_v12 ;;
            6) panel_v15 ;;
            7) panel_v15_2 ;;
            8) panel_v20 ;;
            9) panel_v20_mod ;;
            10) panel_v23 ;;
            11) panel_v23_2 ;;
            12) panel_v25 ;;
            13) panel_update2325 ;;
            14) clean_folder ;;
            15) remove_panel ;;
            16) atualizar ;;
            17) remove_multiscripts ;;
            0) echo -e "\n\033[1;31mSaindo...\033[0m"; break ;;
            *) echo -e "\n\033[1;31mOpção inválida!\033[0m"; sleep 2 ;;
        esac
    done
}

menu
