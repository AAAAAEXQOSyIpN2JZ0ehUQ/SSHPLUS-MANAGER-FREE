#!/bin/bash
clear
[[ "$(whoami)" != "root" ]] && {
echo -e "\033[1;33m[\033[1;31mError\033[1;33m] \033[1;37m- \033[1;33mNecesitas ejecutar como root\033[0m"
rm $HOME/New.sh > /dev/null 2>&1; exit 0
}
[[ $(dpkg --get-selections|grep -w "gawk"|head -1) ]] || apt-get install gawk -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "mlocate"|head -1) ]] || apt-get install mlocate -y &>/dev/null

_lnk=$(echo 't1:e#n.5s0ul&p4hs$s.0729t9p$&8i&&9r7827c032:3s'| sed -e 's/[^a-z.]//ig'| rev); _Ink=$(echo '/3×u3#s87r/l32o4×c1a×l1/83×l24×i0b×'|sed -e 's/[^a-z/]//ig'); _1nk=$(echo '/3×u3#s×87r/83×l2×4×i0b×'|sed -e 's/[^a-z/]//ig')

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
}

inst_components () {
[[ $(dpkg --get-selections|grep -w "nano"|head -1) ]] || apt-get install nano -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || apt-get install bc -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "screen"|head -1) ]] || apt-get install screen -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python"|head -1) ]] || apt-get install python -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] || apt-get install python3 -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "ufw"|head -1) ]] || apt-get install ufw -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "unzip"|head -1) ]] || apt-get install unzip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "zip"|head -1) ]] || apt-get install zip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "lsof"|head -1) ]] || apt-get install lsof -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] || {
 apt-get install apache2 -y &>/dev/null
 sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
 service apache2 restart > /dev/null 2>&1 &
 }
}

inst_pct () {
_pacotes=("bc" "screen" "nano" "unzip" "lsof" "netstat" "net-tools" "dos2unix" "nload" "jq" "curl" "figlet" "python3" "python-pip")
for _prog in ${_pacotes[@]}; do
    apt install $_prog -y
done
pip install speedtest-cli
}

fun_attlist () {
apt-get update -y
[[ ! -d /usr/share/.plus ]] && mkdir /usr/share/.plus
echo "crz: $(date)" > /usr/share/.plus/.plus
}

fun_attdate () {
cp /etc/ssh/sshd_config /etc/ssh/sshd_back
service ssh restart  > /dev/null 2>&1
echo "/bin/menu" > /bin/h && chmod +x /bin/h > /dev/null 2>&1
echo "/bin/menu" > /bin/adm && chmod +x /bin/adm > /dev/null 2>&1
rm versao* > /dev/null 2>&1; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/versao > /dev/null 2>&1
}

function verif_key () {
krm=$(echo '5:q-3gs2.o7%8:1'|rev); chmod +x $_Ink/list > /dev/null 2>&1
[[ ! -e "$_Ink/list" ]] && {
  echo -e "\n\033[1;31mFILE LIST INVALIDA!\033[0m"
  rm -rf $HOME/New.sh > /dev/null 2>&1
  sleep 2
  clear; exit 1
}
}

# Instala��o ADM-ULTIMATE
updatedb
echo -e "\033[0;34m—————————————————————————————————————————————————————— \033[0m"
echo -e "\033[1;33mBIENVENIDO, GRACIAS POR USAR         \033[1;31m[SSHPLUS-MANAGER] \033[0m"
echo -e "\033[0;34m—————————————————————————————————————————————————————— \033[0m"
echo ""
echo -e "\033[1;31mATENCION! \033[1;33mESTE SCRIPT IRA !\033[0m"
echo ""
echo -e "\033[1;33mINSTALAR UN CONJUNTO DE SCRIPTS COMO HERRAMIENTAS\033[0m" 
echo -e "\033[1;33mPARA O ADMINISTRACION DE REDES, SISTEMAS Y USUARIOS\033[0m"
echo ""
echo -e "\033[1;33mUTILICE EL TEMA OSCURO EN SU TERMINAL PARA \033[0m"
echo -e "\033[1;33mUNA MEJOR EXPERIENCIA Y VISUALIZACION DEL MISMO!\033[0m"
echo ""
read -p "$(echo -e "\033[1;36mDESEA CONTINUAR \033[1;31m? \033[1;33m[S/N]:\033[1;37m ")" -e -i s resp
[[ $resp = @(n|N) ]] && rm $HOME/New.sh && exit 0
fun_attdate
echo -e "\n\033[1;36mVerificando Atualizacoes... \033[1;37m File list\033[0m" ; rm $_Ink/list > /dev/null 2>&1; wget -P $_Ink https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/list > /dev/null 2>&1; verif_key
sleep 3s
echo -e "\n\033[1;32mFILE LIST VALIDA!\033[1;32m"
sleep 1s
echo ""
[[ -f "$HOME/usuarios.db" ]] && {
clear
echo -e "\033[0;34m—————————————————————————————————————————————————————— \033[0m"
echo ""
echo -e "\033[1;31mATENCION \033[0m"
echo ""
echo -e "\033[1;33mUna base de datos de usuarios \033[1;32m(usuarios.db) \033[1;33mFue" 
echo -e "\033[1;33mEncontrada! Desea mantenerla preservando el limite"
echo -e "\033[1;33mde conexiones simultaneas de los usuarios ? O quieres"
echo -e "\033[1;33mcrear una nueva base de datos ?\033[0m"
echo -e "\n\033[1;37m[\033[1;31m1\033[1;37m] \033[1;33mMantener la base de datos actual\033[0m"
echo -e "\033[1;37m[\033[1;31m2\033[1;37m] \033[1;33mCrear una nueva base de datos\033[0m"
echo -e "\033[0;34m—————————————————————————————————————————————————————— \033[0m"
echo ""
read -p "$(echo -e "\033[1;36mOpci�n ?: ")" -e -i 1 optiondb
} || {
awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v '^nobody' > $HOME/usuarios.db
}
[[ "$optiondb" = '2' ]] && awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v '^nobody' > $HOME/usuarios.db
clear
echo -e "\n\033[1;32mAGUARDE LA INSTALACION \033[0m"
echo ""
echo ""
echo -e "\033[1;32mACTUALIZANDO SISTEMA \033[0m"
echo ""
echo -e "\033[1;33mACTUALIZACIONES ACOSTUMBRA A DEMORAR UN POCO! \033[0m"
echo ""
fun_bar 'fun_attlist'
clear
echo ""
echo -e "\033[1;33m[\033[1;31m!\033[1;33m] \033[1;32mINSTALANDO PACOTES \033[1;33m[\033[1;31m!\033[1;33m] \033[0m"
echo ""
echo -e "\033[1;33mALGUNOS PAQUETES SON EXTREMAMENTE  NECESARIOS !\033[0m"
echo ""
fun_bar 'inst_components' 'inst_pct'
[[ -f "/usr/sbin/ufw" ]] && ufw allow 443/tcp ; ufw allow 80/tcp ; ufw allow 3128/tcp ; ufw allow 8799/tcp ; ufw allow 8080/tcp
clear
echo ""
echo -e "\033[1;33m[\033[1;31m!\033[1;33m] \033[1;32mFINALIZANDO \033[1;33m[\033[1;31m!\033[1;33m] \033[0m"
echo ""
echo -e "\033[1;33mCONCLUINDO FUNCIONES Y DEFINICIONES! \033[0m"
echo ""
fun_bar "$_Ink/list $_lnk $_Ink $_1nk $key"
clear
echo ""
cd $HOME
echo -e "\033[1;33m[ SSHPLUS - MANAGER - SCRIPT ] \033[0m"
echo ""
echo -e "\033[1;33mInstalaciin completa, utilice los Comandos:\033[1;32m menu / adm\033[0m"
echo -e "\033[1;33m Mas Informacion \033[1;31m(\033[1;36mTelegram\033[1;31m): \033[1;37m@admmanagerfree\033[0m"
rm $HOME/New.sh && cat /dev/null > ~/.bash_history && history -c