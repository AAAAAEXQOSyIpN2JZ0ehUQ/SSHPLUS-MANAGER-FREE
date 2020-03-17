#!/bin/bash
[[ ! -d /etc/SSHPlus ]] && exit 0
[[ ! -d /etc/bot ]] && exit 0
source ShellBot.sh
api_bot=$1
id_admin=$2
[[ -z $api_bot ]] && exit 0
[[ -z $id_admin ]] && exit 0
ShellBot.init --token "$api_bot" --monitor --return map --flush
ShellBot.username
#Exibe informacoes e comandos

ajuda ()
{
    if [[ "${message_from_id[$id]}" = "$id_admin" ]]; then
        local env_msg
        env_msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        env_msg+="<b>BEM VINDO(a) AO BOT SSHPLUS</b>\n"
        env_msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
        env_msg+="⚠️ <i>Comandos Disponiveis</i>\n\n"
        env_msg+="[<b>01</b>] /criarusuario = Cria usuario\n"
        env_msg+="[<b>02</b>] /criarteste = Cria teste ssh\n"
        env_msg+="[<b>03</b>] /remover = Remove usuario\n"
        env_msg+="[<b>04</b>] /infousers = Info usuarios\n"
        env_msg+="[<b>05</b>] /monitor = Usuários onlines\n"
        env_msg+="[<b>06</b>] /infovps = Info servidor \n"
        env_msg+="[<b>07</b>] /alterarsenha = Muda senha\n"
        env_msg+="[<b>08</b>] /alterarlimite = Muda o limite\n"
        env_msg+="[<b>09</b>] /alterardata = Muda data\n"
        env_msg+="[<b>10</b>] /expirados = Deleta expirados\n"
        env_msg+="[<b>11</b>] /backup = Backup de usuarios\n"
        env_msg+="[<b>12</b>] /otimizar = Limpa o cache\n"
        env_msg+="[<b>13</b>] /speedtest = Teste de conexao\n"
        env_msg+="[<b>14</b>] /arquivos = Hospedar Arquivos\n"
        env_msg+="[<b>15</b>] /revenda = Gerenciar Revendas\n"
        env_msg+="[<b>16</b>] /autobackup = Backup automatico\n"
        env_msg+="[<b>17</b>] /relatorio = Informacoes\n"
        env_msg+="[<b>18</b>] /ajuda = Informacoes do bot\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e $env_msg)" \
            --parse_mode html
        return 0
    elif [[ -d /etc/bot/revenda/${message_from_username} ]]; then
        local env_msg1
        env_msg1="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        env_msg1+="<b>BEM VINDO(a) AO BOT SSHPLUS</b>\n"
        env_msg1+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
        env_msg1+="⚠️ <i>Comandos Disponiveis</i>\n\n"
        env_msg1+="[<b>01</b>] /criarusuario = Cria usuario\n"
        env_msg1+="[<b>02</b>] /criarteste = Cria teste ssh\n"
        env_msg1+="[<b>03</b>] /remover = Remove usuario\n"
        env_msg1+="[<b>04</b>] /infousers = Info usuarios\n"
        env_msg1+="[<b>05</b>] /monitor = Usuários onlines\n"
        env_msg1+="[<b>06</b>] /expirados = Deleta expirados\n"
        env_msg1+="[<b>07</b>] /alterarsenha = Muda senha\n"
        env_msg1+="[<b>08</b>] /alterarlimite = Muda o limite\n"
        env_msg1+="[<b>09</b>] /alterardata = Muda data\n"
        env_msg1+="[<b>10</b>] /relatorio = informacoes\n"
        env_msg1+="[<b>11</b>] /ajuda = Informacoes do bot\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e $env_msg1)" \
            --parse_mode html
        return 0
    elif [[ -d /etc/bot/suspensos/${message_from_username} ]]; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e "🚫 VC ESTA SUSPENSO 🚫\n\nCONTATE O ADMINISTRADOR")"
        return 0
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    fi
}

# FUCAO MENU REVENDA !

fun_revenda() {
    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    }
    local env_msg1
    env_msg1="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
    env_msg1+="<b>MENU REVENDA BOT SSHPLUS</b>\n"
    env_msg1+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
    env_msg1+="⚠️ <i>Comandos Disponiveis</i>\n\n"
    env_msg1+="[<b>01</b>] /add_revenda = Cria\n"
    env_msg1+="[<b>02</b>] /del_revenda = Remove\n"
    env_msg1+="[<b>03</b>] /limite_revenda = Altera\n"
    env_msg1+="[<b>04</b>] /data_revenda = Altera\n"
    env_msg1+="[<b>05</b>] /listar_revenda = Mostra\n"
    env_msg1+="[<b>06</b>] /suspender = Bloqueia\n"
    env_msg1+="[<b>07</b>] /ajuda = Informacoes do bot\n"
    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e $env_msg1)" \
        --parse_mode html
    return 0    

}

fun_ajuda() {
    if [[ "${message_from_id[$id]}" = "$id_admin" ]]; then
        local env_msg
        env_msg+="⚠️ <b>COMANDOS E SUAS FUNCOES</b>\n\n"
        env_msg+="<b>1</b> /criarusuario - <code>cria usuario ssh</code>\n\n"
        env_msg+="<b>2</b> /remover - <code>Remove usuario ssh</code>\n\n"
        env_msg+="<b>3</b> /infousers - <code>Exibe informacoes do usuarios</code>\n\n"
        env_msg+="<b>4</b> /monitor - <code>Exibe usuarios online</code>\n\n"
        env_msg+="<b>5</b> /infovps - <code>Exibe informacoes do vps</code>\n\n"
        env_msg+="<b>6</b> /alterarsenha - <code>Altera a senha do usuario</code>\n\n"
        env_msg+="<b>7</b> /alterarlimite - <code>Altera o limite do usuario</code>\n\n"
        env_msg+="<b>8</b> /alterardata - <code>Altera a data do usuario</code>\n\n"
        env_msg+="<b>9</b> /backup - <code>Cria backup de usuarios</code>\n\n"
        env_msg+="<b>10</b> /otimizar - <code>Limpa cache e otimiza a vps</code>\n\n"
        env_msg+="<b>11</b> /speedtest - <code>Execulta teste de velocidade do vps</code>\n\n"
        env_msg+="<b>12</b> /arquivos - <code>Hospeda aquivos (Ex: ehi, kpn e etc)</code>\n\n"
        env_msg+="<b>13</b> /revenda - <code>Exibe menu de gestao revendas</code>\n\n"
        env_msg+="<b>14</b> /add_revenda - <code>Adiciona revendedor</code>\n\n"
        env_msg+="<b>15</b> /del_revenda - <code>Remove revendedor</code>\n\n"
        env_msg+="<b>16</b> /limite_revenda - <code>Altera limite do revendedor</code>\n\n"
        env_msg+="<b>17</b> /data_revenda - <code>Altera data do revendedor e reativa quando suspenso</code>\n\n"
        env_msg+="<b>18</b> /listar_revenda - <code>Exibe revendedores ativos e suspensos</code>\n\n"
        env_msg+="<b>19</b> /suspender - <code>Suspende revendedor e as contas criadas por ele</code>\n\n"
        env_msg+="<b>20</b> /relatorio - <code>Exibe relatorio dos revendedores</code>\n\n"
        env_msg+="<b>21</b> /criarteste - <code>Cria usuario ssh aleatorio temporario</code>\n\n"
        env_msg+="<b>22</b> /expirados - <code>Remove os usuarios expirados</code>\n\n"
        env_msg+="<b>23</b> /autobackup - <code>Ativa o backup automatico</code>\n\n"
        env_msg+="<b>24</b> /sobre - <code>creditos / informacoes</code>\n\n"

        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e $env_msg)" \
            --parse_mode html
        return 0
    elif [[ -d /etc/bot/revenda/${message_from_username} ]]; then
        local env_msg
        env_msg+="⚠️ <b>COMANDOS E SUAS FUNCOES</b>\n\n"
        env_msg+="<b>1</b> /criarusuario - <code>cria usuario ssh</code>\n\n"
        env_msg+="<b>2</b> /remover - <code>Remove usuario ssh</code>\n\n"
        env_msg+="<b>3</b> /infousers - <code>Exibe informacoes do usuarios</code>\n\n"
        env_msg+="<b>4</b> /monitor - <code>Exibe usuarios online</code>\n\n"
        env_msg+="<b>5</b> /infovps - <code>Exibe informacoes do vps</code>\n\n"
        env_msg+="<b>6</b> /alterarsenha - <code>Altera a senha do usuario</code>\n\n"
        env_msg+="<b>7</b> /alterarlimite - <code>Altera o limite do usuario</code>\n\n"
        env_msg+="<b>8</b> /criarteste - <code>Cria usuario ssh aleatorio temporario</code>\n\n"
        env_msg+="<b>9</b> /expirados - <code>Remove usuarios expirados</code>\n\n"
        env_msg+="<b>10</b> /relatorio - <code>Exibe Informacoes</code>\n\n"
        env_msg+="<b>11</b> /alterardata - <code>Remove usuario ssh</code>\n\n"
        env_msg+="<b>12</b> /sobre - <code>creditos / informacoes</code>\n\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e $env_msg)" \
            --parse_mode html
        return 0
    elif [[ -d /etc/bot/suspensos/${message_from_username} ]]; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e "🚫 VC ESTA SUSPENSO 🚫\n\nCONTATE O ADMINISTRADOR")"
        return 0
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    fi

}

msg_bem_vindo()
{
    local msg
    msg="✌️😃 Ola <b>${message_from_first_name[$id]}</b>\nSeja bem-vindo(a)\n\n"
    msg+="Para obter informacoes\nclick ou execute [ /menu ]\n\n"
    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e $msg)" \
        --parse_mode html
    return 0    
}

verifica_suspenso() {
    _RevCliente=$1
    [[ -d /etc/bot/suspensos/$_RevCliente ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e "⚠️ VC ESTA SUSPENSO ⚠️\n\nCONTATE O ADMINISTRADOR")"
        return 0
    }
}


ver_users ()
{
    verifica_suspenso ${message_from_username}
    if [[ "${message_from_id[$id]}" = "$id_admin" ]]; then
        arq_info=/tmp/$(echo $RANDOM)
        local info_users
        info_users='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n'
        info_users+='<b>INFORMACOES DOS USUARIOS</b>\n'
        info_users+='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n'
        info_users+='⚠️ Exibe no formato abaixo:\n\n'
        info_users+='<code>USUÁRIO SENHA LIMITE DATA</code>\n'
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e $info_users)" \
            --parse_mode html
        fun_infu () {
            local info
            for user in $(cat /etc/passwd|awk -F : '$3 >= 1000 {print $1}'|grep -v nobody)
            do
                info='-------------------------------------------------------\n'
                if [[ -f /etc/bot/info-users/$user ]]; then
                    senha=$(cat /etc/bot/info-users/$user|awk  -F : {'print $2'})
                    data=$(cat /etc/bot/info-users/$user|awk -F : {'print $3'})
                    limite=$(cat /etc/bot/info-users/$user|awk -F : {'print $4'})
                    info+="$user - $senha - $limite - $data"
                else
                    [[ -e /etc/SSHPlus/senha/$user ]] && senha2=$(cat /etc/SSHPlus/senha/$user) || senha2=null
                    [[ $(grep -wc "$user" $HOME/usuarios.db) != '0' ]] && limite2=$(grep -wi $user $HOME/usuarios.db |cut -d' ' -f2) || limite2='null'
                    info+="$user - $senha2 - $limite2 - null"
                fi
                echo -e "$info"
            done
        }
        fun_infu > $arq_info
        while : ; do
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(while read linha; do echo $linha; done < <(sed '1,30!d' $arq_info))" \
            --parse_mode html
            sed -i 1,30d $arq_info
            [[ $(cat $arq_info| wc -l) = '0' ]] && rm $arq_info && break
        done
    elif [[ -d /etc/bot/revenda/${message_from_username} ]]; then
        arq_info=/tmp/$(echo $RANDOM)
        cliente="${message_from_username}"
        local info_users
        info_users='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n'
        info_users+='<b>INFORMACOES DOS USUARIOS</b>\n'
        info_users+='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n'
        info_users+='⚠️ Exibe no formato abaixo:\n\n'
        info_users+='<code>USUÁRIO SENHA LIMITE DATA</code>\n'
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e $info_users)" \
            --parse_mode html
        fun_infu () {
            local info
            for user in $(ls /etc/bot/revenda/$cliente/usuarios)
            do
                info='-------------------------------------------------------\n'
                if [[ -f /etc/bot/revenda/$cliente/usuarios/$user ]]; then
                    senha=$(cat /etc/bot/revenda/$cliente/usuarios/$user|awk  -F : {'print $2'})
                    data=$(cat /etc/bot/revenda/$cliente/usuarios/$user|awk -F : {'print $3'})
                    limite=$(cat /etc/bot/revenda/$cliente/usuarios/$user|awk -F : {'print $4'})
                    info+="$user - $senha - $limite - $data"
                else
                    [[ -e /etc/SSHPlus/senha/$user ]] && senha2=$(cat /etc/SSHPlus/senha/$user) || senha2=null
                    [[ $(grep -wc "$user" $HOME/usuarios.db) != '0' ]] && limite2=$(grep -wi $user $HOME/usuarios.db |cut -d' ' -f2) || limite2='null'
                    info+="$user - $senha2 - $limite2 - null"
                fi
                echo -e "$info"
            done
        }
        fun_infu > $arq_info
        while : ; do
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(while read linha; do echo $linha; done < <(sed '1,30!d' $arq_info))" \
            --parse_mode html
            sed -i 1,30d $arq_info
            [[ $(cat $arq_info| wc -l) = '0' ]] && rm $arq_info && break
        done
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    fi
}

monitor_ssh2() {
    fun_drop () {
        port_dropbear=`ps aux | grep dropbear | awk NR==1 | awk '{print $17;}'`
        log=/var/log/auth.log
        loginsukses='Password auth succeeded'
        pids=`ps ax |grep dropbear |grep  " $port_dropbear" |awk -F" " '{print $1}'`
        for pid in $pids
        do
            pidlogs=`grep $pid $log |grep "$loginsukses" |awk -F" " '{print $3}'`
            i=0
            for pidend in $pidlogs
            do
                let i=i+1
            done
            if [ $pidend ];then
                login=`grep $pid $log |grep "$pidend" |grep "$loginsukses"`
                 PID=$pid
                 user=`echo $login |awk -F" " '{print $10}' | sed -r "s/'/ /g"`
                 waktu=`echo $login |awk -F" " '{print $2"-"$1,$3}'`
                 while [ ${#waktu} -lt 13 ]; do
                    waktu=$waktu" "
                 done
                 while [ ${#user} -lt 16 ]; do
                    user=$user" "
                 done
                 while [ ${#PID} -lt 8 ]; do
                    PID=$PID" "
                 done
                 echo "$user $PID $waktu"
                 fi
        done
    }
    verifica_suspenso ${message_from_username}
    if [[ "${message_from_id[$id]}" = "$id_admin" ]]; then
        database="/root/usuarios.db"
        cad_onli=/tmp/$(echo $RANDOM)
        local info_on
          info_on='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n'
          info_on+='<b>MONITOR USUARIOS ONLINES</b>\n'
          info_on+='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n'
          info_on+='⚠️ Exibe no formato abaixo:\n\n'
          info_on+='<code>USUÁRIO  ONLINE/LIMITE  TEMPO\n</code>'
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e $info_on)" \
        --parse_mode html
        fun_online () {
            local info2
            for user in $(cat /etc/passwd|awk -F : '$3 >= 1000 {print $1}'|grep -v nobody)
            do
                [[ "$(grep -w $user $database)" != "0" ]] && lim="$(grep -w $user $database| cut -d' ' -f2)" || lim=0
                [[ $(netstat -nltp|grep 'dropbear'| wc -l) != '0' ]] && drop="$(fun_drop | grep "$user" | wc -l)" || drop=0
                [[ -e /etc/openvpn/openvpn-status.log ]] && ovp="$(cat /etc/openvpn/openvpn-status.log | grep -E ,"$user", | wc -l)" || ovp=0
                sqd="$(ps -u $user | grep sshd | wc -l)"
                _cont=$(($drop + $ovp))
                conex=$(($_cont + $sqd))
                if [[ $conex -gt '0' ]]; then
                    timerr="$(ps -o etime $(ps -u $user |grep sshd |awk 'NR==1 {print $1}')|awk 'NR==2 {print $1}')"
                    info2+="------------------------------\n"
                    info2+="👤$user       $conex/$lim       ⏳$timerr\n"
                fi
            done
            echo -e "$info2"
        }
        fun_online > $cad_onli
        [[ $(cat $cad_onli| wc -w) != '0' ]] && {
            while : ; do
                ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "<code>$(while read linha; do echo $linha; done < <(sed '1,30!d' $cad_onli))</code>" \
                --parse_mode html
                sed -i 1,30d $cad_onli
                [[ "$(cat $cad_onli| wc -l)" = '0' ]] && {
                    rm $cad_onli
                    break
                }
            done
        } || {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "Nenhum usuario online" \
            --parse_mode html
            break
        }
    elif [[ -d /etc/bot/revenda/${message_from_username} ]]; then
        database="/root/usuarios.db"
        cad_onli=/tmp/$(echo $RANDOM)
        local info_on
          info_on='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n'
          info_on+='<b>MONITOR USUARIOS ONLINES</b>\n'
          info_on+='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n'
          info_on+='⚠️ Exibe no formato abaixo:\n\n'
          info_on+='<code>USUÁRIO  ONLINE/LIMITE  TEMPO\n</code>'
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e $info_on)" \
        --parse_mode html
        fun_online () {
            local info2
            for user in $(ls /etc/bot/revenda/${message_from_username}/usuarios)
            do
                [[ "$(grep -w $user $database)" != "0" ]] && lim="$(grep -w $user $database| cut -d' ' -f2)" || lim=0
                [[ $(netstat -nltp|grep 'dropbear'| wc -l) != '0' ]] && drop="$(fun_drop | grep "$user" | wc -l)" || drop=0
                [[ -e /etc/openvpn/openvpn-status.log ]] && ovp="$(cat /etc/openvpn/openvpn-status.log | grep -E ,"$user", | wc -l)" || ovp=0
                sqd="$(ps -u $user | grep sshd | wc -l)"
                _cont=$(($drop + $ovp))
                conex=$(($_cont + $sqd))
                if [[ $conex -gt '0' ]]; then
                    timerr="$(ps -o etime $(ps -u $user |grep sshd |awk 'NR==1 {print $1}')|awk 'NR==2 {print $1}')"
                    info2+="------------------------------\n"
                    info2+="👤$user       $conex/$lim       ⏳$timerr\n"
                fi
            done
            echo -e "$info2"
        }
        fun_online > $cad_onli
        [[ $(cat $cad_onli| wc -w) != '0' ]] && {
            while : ; do
                ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "<code>$(while read linha; do echo $linha; done < <(sed '1,30!d' $cad_onli))</code>" \
                --parse_mode html
                sed -i 1,30d $cad_onli
                [[ "$(cat $cad_onli| wc -l)" = '0' ]] && {
                    rm $cad_onli
                    break
                }
            done
        } || {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "Nenhum usuario online" \
            --parse_mode html
            break
        }
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    fi
}
fun_drop2 () {
    port_dropbear=`ps aux | grep dropbear | awk NR==1 | awk '{print $17;}'`
    log=/var/log/auth.log
    loginsukses='Password auth succeeded'
    pids=`ps ax |grep dropbear |grep  " $port_dropbear" |awk -F" " '{print $1}'`
    for pid in $pids
    do
        pidlogs=`grep $pid $log |grep "$loginsukses" |awk -F" " '{print $3}'`
        i=0
        for pidend in $pidlogs;do
            let i=i+1
        done
        if [ $pidend ];then
            login=`grep $pid $log |grep "$pidend" |grep "$loginsukses"`
            PID=$pid
            user=`echo $login |awk -F" " '{print $10}' | sed -r "s/'/ /g"`
            waktu=`echo $login |awk -F" " '{print $2"-"$1,$3}'`
            while [ ${#waktu} -lt 13 ]; do
                waktu=$waktu" "
            done
            while [ ${#user} -lt 16 ]; do
                 user=$user" "
            done
            while [ ${#PID} -lt 8 ]; do
                PID=$PID" "
            done
            echo "$user $PID $waktu"
        fi
    done
}
infovps () {
[[ "${message_from_id[$id]}" != "$id_admin" ]] && {
    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
    return 0
}
PTs='/tmp/prts'
rm -rf /tmp/online.txt > /dev/null
for user in $(cat /etc/passwd|awk -F : '$3 >= 1000 {print $1}'|grep -v nobody)
do
    [[ -e '/etc/init.d/dropbear' ]] && echo -e "$(fun_drop2 | grep "$user" | wc -l)" >> /tmp/online.txt
    [[ $(ps -u $user |grep sshd |wc -l) -gt '0' ]] && echo -e "$(ps -u $user |grep sshd |wc -l)" >> /tmp/online.txt
    [[ -e /etc/openvpn/openvpn-status.log ]] && echo -e "$(grep -E ,"$user", /etc/openvpn/openvpn-status.log | wc -l)" >> /tmp/online.txt
done
[[ $(paste -s -d + /tmp/online.txt | bc) -gt '0' ]] && on="$(paste -s -d + /tmp/online.txt | bc)" || on=0
system=$(cat /etc/issue.net)
uso=$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')
cpucores=$(grep -c cpu[0-9] /proc/stat)
ram1=$(free -h | grep -i mem | awk {'print $2'})
usoram=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }')
total=$(cat -n /root/usuarios.db | tail -n 1 | awk '{print $1}')
echo -e "SSH: $(grep 'Port' /etc/ssh/sshd_config|cut -d' ' -f2 |grep -v 'no' |xargs)" > $PTs
[[ -e "/etc/stunnel/stunnel.conf" ]] && echo -e "SSL Tunel: $(netstat -nplt |grep 'stunnel' | awk {'print $4'} |cut -d: -f2 |xargs)" >> $PTs
[[ -e "/etc/openvpn/server.conf" ]] && echo -e "Openvpn: $(netstat -nplt |grep 'openvpn' |awk {'print $4'} |cut -d: -f2 |xargs)" >> $PTs
[[ "$(netstat -nplt |grep 'sslh' | wc -l)" != '0' ]] && echo -e "SSlh: $(netstat -nplt |grep 'sslh' |awk {'print $4'} |cut -d: -f2 |xargs)" >> $PTs
[[ "$(netstat -nplt |grep 'squid'| wc -l)" != '0' ]] && echo -e "Squid: $(netstat -nplt |grep 'squid' | awk -F ":" {'print $4'} | xargs)" >> $PTs
[[ "$(netstat -nltp|grep 'dropbear' |wc -l)" != '0' ]] && echo -e "DropBear: $(netstat -nplt |grep 'dropbear' | awk -F ":" {'print $4'} | xargs)" >> $PTs
[[ "$(netstat -nplt |grep 'python' |wc -l)" != '0' ]] && echo -e "Proxy Socks: $(netstat -nplt |grep 'python' | awk {'print $4'} |cut -d: -f2 |xargs)" >> $PTs

local info
      info="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
      info+="<b>INFORMACOES DO SERVIDOR</b>\n"
      info+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
      info+="<b>SISTEMA OPERACIONAL</b>\n"
      info+="$system\n\n"
      info+="<b>PROCESSADOR</b>\n"
      info+="<b>Nucleos:</b> $cpucores\n"
      info+="<b>Ultilizacao:</b> $uso\n\n"
      info+="<b>MEMORIA RAM</b>\n"
      info+="<b>Total:</b> $ram1\n"
      info+="<b>Ultilizacao:</b> $usoram\n\n"
      while read linha
      do
        info+="<b>$(echo -e "$linha")</b>\n"
      done < <(cat $PTs)
      info+="\n<b>$total</b><i> USUARIOS</i><b> $on</b> <i>ONLINE</i>"
 
      ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e $info)" \
        --parse_mode html
        return 0
}

otimizer ()
{
    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    }
    MEM1=`free|awk '/Mem:/ {print int(100*$3/$2)}'`
    apt-get autoclean -y
    echo 3 > /proc/sys/vm/drop_caches
    sync && sysctl -w vm.drop_caches=3 1>/dev/null 2>/dev/null
    sysctl -w vm.drop_caches=0 1>/dev/null 2>/dev/null
    swapoff -a
    swapon -a
    ram1=$(free -h | grep -i mem | awk {'print $2'})
    ram2=$(free -h | grep -i mem | awk {'print $3'})
    ram3=$(free -h | grep -i mem | awk {'print $4'})
    MEM2=`free|awk '/Mem:/ {print int(100*$3/$2)}'`
    res=`expr $MEM1 - $MEM2`
    local sucess
        sucess="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        sucess+="<b>OTIMIZADO COM SUCESSO !</b>\n"
        sucess+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
        sucess+="<i>Ultilizacao anterior</i> $MEM1%\n\n"
        sucess+="<b>Total</b> $ram1\n"
        sucess+="<b>livre</b> $ram3\n"
        sucess+="<b>Em uso</b> $ram2\n"
        sucess+="<i>Ultilizacao atual</i> $MEM2%\n\n"
        sucess+="<b>Economia de:</b> $res%"
    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
    --text "$(echo -e $sucess)" \
    --parse_mode html
    return 0
}

backup_users ()
{
    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    }
    rm /root/backup.vps 1>/dev/null 2>/dev/null
    tar cvf /root/backup.vps /root/usuarios.db /etc/shadow /etc/passwd /etc/group /etc/gshadow /etc/bot 1>/dev/null 2>/dev/null
    local msg
      msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
      msg+="<b>BACKUP DOS USUÁRIOS </b>♻️\n"
      msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
    ShellBot.sendMessage --chat_id ${id_admin} \
    --text "$(echo -e $msg)" \
    --parse_mode html
    ShellBot.sendDocument --chat_id ${id_admin} \
    --document "@/root/backup.vps"
    return 0
}

backup_auto ()
{
    ShellBot.sendDocument --chat_id ${id_admin} \
    --document "@/etc/SSHPlus/backups/backup.vps" \
    --caption "$(echo -e "♻️ BACKUP AUTOMATICO ♻️")"
    rm /etc/SSHPlus/backups/backup.vps
    return 0
}

speed_test ()
{
    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    }
    info='<i>AGUARDE</i>...⌛'
    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
    --text "$(echo -e $info)" \
    --parse_mode html
    rm -rf $HOME/speed > /dev/null 2>&1
    speedtest --share > speed
    png=$(cat speed | sed -n '5 p' |awk -F : {'print $NF'})
    down=$(cat speed | sed -n '7 p' |awk -F :  {'print $NF'})
    upl=$(cat speed | sed -n '9 p' |awk -F :  {'print $NF'})
    lnk=$(cat speed | sed -n '10 p' |awk {'print $NF'})
    local msg
        msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        msg+="<b>🚀 VELOCIDADE DO SERVIDOR 🚀</b>\n"
        msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
        msg+="<b>PING/LATENCIA:</b>$png\n"
        msg+="<b>DOWNLOAD:</b>$down\n"
        msg+="<b>UPLOAD:</b>$upl\n"
    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
    --text "$(echo -e $msg)" \
    --parse_mode html
    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
    --text "$(echo -e $lnk)" \
    --parse_mode html
    rm -rf $HOME/speed > /dev/null 2>&1
    return 0
}

#Exibe payload
payloads ()
{
    local pay
    pay='Payload vivo socks\n\n'
    pay+='`PUT /? HTTP/1.1 Host: santander.com[lf]`\n'
    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
    --text "$(echo -e $pay)" \
    --parse_mode markdown

    return 0
}

sobremim() {
    local msg
        msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        msg+="<b>🤖 BOT SSHPLUS MANAGER 🤖</b>\n"
        msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
        msg+="<b>Desenvolvido por:</b> @crazy_vpn\n"
        msg+="<b>Canal Oficial:</b> @SSHPLUS\n\n"
        msg+="Fui criado com o propósito de fornecer informações e ferramentas para gestao de vps 🐧 GNU/Linux 🐧 com foco em uso VPN\n\n"
        msg+="<b>Menu:</b> /menu\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e $msg)" \
        --parse_mode html
        return 0
}

fun_verif_limit() {
    _ClientR=$1
    _Dir_users1="/etc/bot/revenda/$_ClientR/usuarios"
    _limTotal1=$(grep 'Limite' /etc/bot/revenda/$_ClientR/$_ClientR| awk '{print $NF}')
    _lim2='0'
    for i in $(ls $_Dir_users1); do
        var3=$(cat $_Dir_users1/$i| awk  -F : {'print $4'})
        _lim2=$(echo "${_lim2} + ${var3}"| bc)
    done
    _result1=$(echo ${_lim2})
    _restant1=$(($_limTotal1 - $_result1))
    [[ "$_result1" -ge "$_limTotal1" ]] && {
        verify='1'
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e "❌ Vc nao tem limite suficiente\n\nLimite restante: $_restant1 ")" \
        --parse_mode html
        return 0
    }
}

fun_verif_limit2() {
    _ClientR1=$1
    _Limite=$2
    _Dir_users="/etc/bot/revenda/$_ClientR1/usuarios"
    _limTotal=$(grep 'Limite' /etc/bot/revenda/$_ClientR1/$_ClientR1| awk '{print $NF}')
    _lim3='0'
    for i in $(ls $_Dir_users); do
        var4=$(cat $_Dir_users/$i| awk  -F : {'print $4'})
        _lim3=$(echo "${_lim3} + ${var4}"| bc)
    done
    _result=$(echo ${_lim3})
    _restant2=$(($_limTotal - $_result))
    _somalimit=$(($_Limite + $_result))
    [[ "$_somalimit" -gt "$_limTotal" ]] && {
        verifyLimit='1'
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e "❌ Vc nao tem limite suficiente\n\nLimite restante: $_restant2 ")" \
        --parse_mode html
        return 0
    }
}

fun_adduser () {
    verifica_suspenso ${message_from_username}
    if [[ "${message_from_id[$id]}" = "$id_admin" ]]; then
        ShellBot.sendMessage    --chat_id ${message_from_id[$id]} \
        --text "👤 CRIAR USUARIO 👤\n\nNome do usuario:" \
        --reply_markup "$(ShellBot.ForceReply)"
    elif [[ -d /etc/bot/revenda/${message_from_username} ]]; then
        fun_verif_limit ${message_from_username}
        [[ "$verify" == '1' ]] && return 0
        ShellBot.sendMessage    --chat_id ${message_from_id[$id]} \
        --text "👤 CRIAR USUARIO 👤\n\nNome do usuario:" \
        --reply_markup "$(ShellBot.ForceReply)"
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    fi
}

fun_deluser () {
    verifica_suspenso ${message_from_username}
    if [[ "${message_from_id[$id]}" = "$id_admin" ]]; then
        ShellBot.sendMessage    --chat_id ${message_from_id[$id]} \
        --text "🗑 REMOVER USUARIO 🗑\n\nNome do usuario:" \
        --reply_markup "$(ShellBot.ForceReply)"
    elif [[ -d /etc/bot/revenda/${message_from_username} ]]; then
        ShellBot.sendMessage    --chat_id ${message_from_id[$id]} \
        --text "🗑 REMOVER USUARIO 🗑\n\nNome do usuario:" \
        --reply_markup "$(ShellBot.ForceReply)"
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    fi
}

fun_del_user () {
    usuario=$1
    [[ "${message_from_id[$id]}" = "$id_admin" ]] && {
        piduser=$(ps -u "$usuario" |grep sshd |cut -d? -f1)
        kill -9 $piduser > /dev/null 2>&1
        userdel --force "$usuario" 2>/dev/null
        grep -v ^$usuario[[:space:]] /root/usuarios.db > /tmp/ph ; cat /tmp/ph > /root/usuarios.db
        rm /etc/SSHPlus/senha/$usuario > /dev/null 2>&1
        rm /etc/bot/info-users/$usuario
    } || {
        [[ ! -e /etc/bot/revenda/${message_from_username}/usuarios/$usuario ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
             --text "$(echo -e "❌ O USUARIO NAO EXISTE ❌")" \
             --parse_mode html
             return 0
        }
        piduser=$(ps -u "$usuario" |grep sshd |cut -d? -f1)
        kill -9 $piduser > /dev/null 2>&1
        userdel --force "$usuario" 2>/dev/null
        grep -v ^$usuario[[:space:]] /root/usuarios.db > /tmp/ph ; cat /tmp/ph > /root/usuarios.db
        rm /etc/SSHPlus/senha/$usuario > /dev/null 2>&1
        rm /etc/bot/revenda/${message_from_username}/usuarios/$usuario
    }
    [[ -e /etc/SSHPlus/userteste/$usuario.sh ]] && at -f /etc/SSHPlus/userteste/$usuario.sh now + 1 min > /dev/null 2>&1
    [[ -e "/etc/openvpn/easy-rsa/pki/private/$usuario.key" ]] && {
        [[ -e /etc/debian_version ]] && GROUPNAME=nogroup
        cd /etc/openvpn/easy-rsa/
        ./easyrsa --batch revoke $usuario
        ./easyrsa gen-crl
        rm -rf pki/reqs/$usuario.req
        rm -rf pki/private/$usuario.key
        rm -rf pki/issued/$usuario.crt
        rm -rf /etc/openvpn/crl.pem
        cp /etc/openvpn/easy-rsa/pki/crl.pem /etc/openvpn/crl.pem
        chown nobody:$GROUPNAME /etc/openvpn/crl.pem
        [[ -e $HOME/$usuario.ovpn ]] && rm $HOME/$usuario.ovpn > /dev/null 2>&1
    }
}

criar_user ()
{
    IP=$(cat /etc/IP)
    newclient () {
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
    file_user=$1
    usuario=$(sed -n '1 p' $file_user| cut -d' ' -f2)
    senha=$(sed -n '2 p' $file_user| cut -d' ' -f2)
    limite=$(sed -n '3 p' $file_user| cut -d' ' -f2)
    data=$(sed -n '4 p' $file_user| cut -d' ' -f2)
    validade=$(echo "$data" | awk -F'/' '{print $2FS$1FS$3}' | xargs -i date -d'{}' +%Y/%m/%d)
    if [[ "${message_from_id[$id]}" = "$id_admin" ]]; then
        useradd -M -N -s /bin/false $usuario -e $validade > /dev/null 2>&1
        (echo "${senha}";echo "${senha}") | passwd "${usuario}" > /dev/null 2>&1
        echo "$usuario:$senha:$info_data:$limite" > /etc/bot/info-users/$usuario
    elif [[ -d /etc/bot/revenda/${message_from_username} ]]; then
        #funcao pra contar o limite
        fun_verif_limit2 ${message_from_username} $limite
        [[ "$verifyLimit" == '1' ]] && {
            return 0
        } || {
            useradd -M -N -s /bin/false $usuario -e $validade > /dev/null 2>&1
            (echo "${senha}";echo "${senha}") | passwd "${usuario}" > /dev/null 2>&1
            echo "$usuario:$senha:$info_data:$limite" > /etc/bot/revenda/${message_from_username}/usuarios/$usuario
        }
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e "Erro")"
        return 0
    fi
    echo "$usuario $limite" >> /root/usuarios.db
    echo "$senha" > /etc/SSHPlus/senha/$usuario
    [[ -e "/etc/openvpn/server.conf" ]] && {
        cd /etc/openvpn/easy-rsa/
        ./easyrsa build-client-full $usuario nopass
        newclient "$usuario"
    }
}

alterar_senha() {
    verifica_suspenso ${message_from_username}
    if [[ "${message_from_id[$id]}" = "$id_admin" ]]; then
        ShellBot.sendMessage    --chat_id ${message_from_id[$id]} \
        --text "🔐 Alterar Senha 🔐\n\nNome do usuario:" \
        --reply_markup "$(ShellBot.ForceReply)"
    elif [[ -d /etc/bot/revenda/${message_from_username} ]]; then
        [[ $(ls /etc/bot/revenda/${message_from_username}/usuarios) != '0' ]] && {
            ShellBot.sendMessage    --chat_id ${message_from_id[$id]} \
            --text "🔐 Alterar Senha 🔐\n\nNome do usuario:" \
            --reply_markup "$(ShellBot.ForceReply)"
        } || {
          ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "❌ VC NAO POSSUI USUARIOS ❌")"
            return 0  
        }
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    fi
}
alterar_senha_user ()
{
    usuario=$1
    senha=$2
    [[ "${message_from_id[$id]}" = "$id_admin" ]] && {
        echo "$usuario:$senha" | chpasswd
        [[ -e /etc/bot/info-users/$usuario ]]  && senha2=$(cat /etc/bot/info-users/$usuario|awk  -F : {'print $2'}) || senha2=$(cat /etc/SSHPlus/senha/$usuario)
        sed -i "s/\b$senha2\b/$senha/g" /etc/bot/info-users/$usuario
    } || {
        [[ ! -e /etc/bot/revenda/${message_from_username}/usuarios/$usuario ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
             --text "$(echo -e "❌ O USUARIO NAO EXISTE ❌")" \
             --parse_mode html
             return 0
        }
        echo "$usuario:$senha" | chpasswd
        [[ -e /etc/bot/revenda/${message_from_username} ]]  && senha2=$(cat /etc/bot/revenda/${message_from_username}/usuarios/$usuario|awk  -F : {'print $2'}) || senha2=$(cat /etc/SSHPlus/senha/$usuario)
        sed -i "s/\b$senha2\b/$senha/g" /etc/bot/revenda/${message_from_username}/usuarios/$usuario
    }
    echo "$senha" > /etc/SSHPlus/senha/$usuario
    pkill -f $usuario > /dev/null 2>&1
}

alterar_limite() {
    verifica_suspenso ${message_from_username}
    if [[ "${message_from_id[$id]}" = "$id_admin" ]]; then
        ShellBot.sendMessage    --chat_id ${message_from_id[$id]} \
        --text "👥 Alterar Limite 👥\n\nNome do usuario:" \
        --reply_markup "$(ShellBot.ForceReply)"
    elif [[ -d /etc/bot/revenda/${message_from_username} ]]; then
        [[ $(ls /etc/bot/revenda/${message_from_username}/usuarios) != '0' ]] && {
            ShellBot.sendMessage    --chat_id ${message_from_id[$id]} \
            --text "👥 Alterar Limite 👥\n\nNome do usuario:" \
            --reply_markup "$(ShellBot.ForceReply)"
        } || {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "❌ VC NAO POSSUI USUARIOS ❌")"
            return 0
        }
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    fi
}

alterar_limite_user ()
{
    usuario=$1
    limite=$2
    database="/root/usuarios.db"
    if [[ "${message_from_id[$id]}" = "$id_admin" ]]; then
        grep -v ^$usuario[[:space:]] /root/usuarios.db > /tmp/a
        sleep 1
        mv /tmp/a /root/usuarios.db
        echo $usuario $limite >> /root/usuarios.db
        [[ -e /etc/bot/info-users/$usuario ]] && limite2=$(cat /etc/bot/info-users/$usuario|awk  -F : {'print $4'}) || limite2=$(grep -wi $usuario $database| cut -d' ' -f2)
        sed -i "s/\b$limite2\b/$limite/g" /etc/bot/info-users/$usuario
    elif [[ -d /etc/bot/revenda/${message_from_username} ]]; then
        [[ ! -e /etc/bot/revenda/${message_from_username}/usuarios/$usuario ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
             --text "$(echo -e "❌ O USUARIO NAO EXISTE ❌")" \
             --parse_mode html
             break
        }          
        _limTotal=$(grep 'Limite' /etc/bot/revenda/${message_from_username}/${message_from_username}| awk '{print $NF}')
        [[ "$limite" -gt "$_limTotal" ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "❌ VC NAO TEM LIMITE SUFICIENTE ❌\n\nLimite Atual: $_limTotal ")" \
                --parse_mode html
            break
        }
        tmpvar="/tmp/$(echo $RANDOM)"
        for arqi in $(ls /etc/bot/revenda/${message_from_username}/usuarios); do
            limit_logins=$(cat /etc/bot/revenda/${message_from_username}/usuarios/$arqi|awk  -F : {'print $4'})
            echo -e "$limit_logins" >> $tmpvar
        done
        _resut=$(paste -s -d + $tmpvar| bc)
        lim1=$(($_limTotal - $_resut))
        lim2=$(($_resut + $limite))
        [[ "$lim2" -gt "$_limTotal" ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "❌ VC NAO TEM LIMITE SUFICIENTE ❌\n\nLimite restante: $lim1 ")" \
            --parse_mode html
            rm $tmpvar
            break
        }
        rm $tmpvar
        grep -v ^$usuario[[:space:]] /root/usuarios.db > /tmp/a
        sleep 1
        mv /tmp/a /root/usuarios.db
        echo $usuario $limite >> /root/usuarios.db
        [[ -e /etc/bot/revenda/${message_from_username}/usuarios/$usuario ]] && limite2=$(cat /etc/bot/revenda/${message_from_username}/usuarios/$usuario|awk  -F : {'print $4'}) || limite2=$(grep -wi $usuario $database| cut -d' ' -f2)
        sed -i "s/\b$limite2\b/$limite/g" /etc/bot/revenda/${message_from_username}/usuarios/$usuario
    else
         ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    fi
}

alterar_data() {
    verifica_suspenso ${message_from_username}
    if [[ "${message_from_id[$id]}" = "$id_admin" ]]; then
        ShellBot.sendMessage    --chat_id ${message_from_id[$id]} \
        --text "⏳ Alterar Data ⏳\n\nNome do usuario:" \
        --reply_markup "$(ShellBot.ForceReply)"
    elif [[ -d /etc/bot/revenda/${message_from_username} ]]; then
        [[ $(ls /etc/bot/revenda/${message_from_username}/usuarios) != '0' ]] && {
            ShellBot.sendMessage    --chat_id ${message_from_id[$id]} \
            --text "⏳ Alterar Data ⏳\n\nNome do usuario:" \
            --reply_markup "$(ShellBot.ForceReply)"
        } || {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "❌ VC NAO POSSUI USUARIOS ❌")"
            return 0
        }
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    fi
}

alterar_data_user ()
{
    usuario=$1
    inputdate=$2
    database="/root/usuarios.db"
    [[ "$(echo -e "$inputdate" | sed -e 's/[^/]//ig')" != '//' ]] && {
        udata=$(date "+%d/%m/%Y" -d "+$inputdate days")
        sysdate="$(echo "$udata" | awk -v FS=/ -v OFS=- '{print $3,$2,$1}')"
        echo crazy
    } || {
        udata=$(echo -e "$inputdate")
        sysdate="$(echo -e "$inputdate" | awk -v FS=/ -v OFS=- '{print $3,$2,$1}')"
        today="$(date -d today +"%Y%m%d")"
        timemachine="$(date -d "$sysdate" +"%Y%m%d")"
        [ $today -ge $timemachine ] && {
            verify='1'
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
             --text "$(echo -e "❌ Erro! Data invalida")" \
             --parse_mode html
             return 0
        }
    }
    chage -E $sysdate $usuario
    [[ "${message_from_id[$id]}" = "$id_admin" ]] && {
        [[ -e /etc/bot/info-users/$usuario ]] && data2=$(cat /etc/bot/info-users/$usuario|awk  -F : {'print $3'})
        sed -i "s;$data2;$udata;" /etc/bot/info-users/$usuario
    } || {
        [[ ! -e /etc/bot/revenda/${message_from_username}/usuarios/$usuario ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
             --text "$(echo -e "❌ O USUARIO NAO EXISTE ❌")" \
             --parse_mode html
             return 0
        }
        [[ -e /etc/bot/revenda/${message_from_username}/usuarios/$usuario ]] && data2=$(cat /etc/bot/revenda/${message_from_username}/usuarios/$usuario|awk  -F : {'print $3'})
        sed -i "s;$data2;$udata;" /etc/bot/revenda/${message_from_username}/usuarios/$usuario
    }
}

fun_down() {
    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    }
    [[ ! -d /tmp/file ]] && mkdir /tmp/file
    ShellBot.sendMessage    --chat_id ${message_from_id[$id]} \
    --text "[1] - ADICIONAR ARQUIVO\n[2] - EXCLUIR ARQUIVO\n\nInforme a opcao [1-2]:" \
    --reply_markup "$(ShellBot.ForceReply)"
}

fun_download() {
     Opc=$1
     _file2=$2
     _DirArq=$(ls /etc/bot/arquivos)
     i=0
     unset _Pass
     while read _Arq; do
        i=$(expr $i + 1)
        _oP=$i
        [[ $i == [1-9] ]] && i=0$i && oP+=" 0$i"
        echo -e "[$i] - $_Arq"
        _Pass+="\n${_oP}:${_Arq}"
     done <<< "${_DirArq}"
     _file=$(echo -e "${_Pass}" | grep -E "\b$Opc\b" | cut -d: -f2)
     ShellBot.sendDocument --chat_id ${message_from_id[$id]} \
     --document "@/etc/bot/arquivos/$_file" \
     --caption "✅ Criado com sucesso ✅\n\n$(< $_file2)"
}

fun_del_arq() {
    Opc1=$1
    if [[ -z "$Opc1" ]]; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e "❌Erro tente novamente")"
        return 0
    fi
     _DirArq=$(ls /etc/bot/arquivos)
     i=0
     unset _Pass
     while read _Arq; do
        i=$(expr $i + 1)
        _oP=$i
        [[ $i == [1-9] ]] && i=0$i && oP+=" 0$i"
        echo -e "[$i] - $_Arq"
        _Pass+="\n${_oP}:${_Arq}"
     done <<< "${_DirArq}"
     _file=$(echo -e "${_Pass}" | grep -E "\b$Opc1\b" | cut -d: -f2)
     [[ -e /etc/bot/arquivos/$_file ]] && {
        rm /etc/bot/arquivos/$_file
     } || {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e "❌ Opcao invalida")"
        return 0
     }
}
###### FUNCOES REVENDA #######
fun_add_revenda() {
    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    }
    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
        --text "👥 ADICIONAR REVENDEDOR 👥\n\nInforme o nome:" \
        --reply_markup "$(ShellBot.ForceReply)"
}


criar_rev() {
    file_rev=$1
    if [[ -z "$file_rev" ]]; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e Erro)"
        break
    fi
    n_rev=$(sed -n '1 p' $file_rev| cut -d' ' -f2)
    u_rev=$(sed -n '2 p' $file_rev| awk  -F '@' {'print $2'})
    l_rev=$(sed -n '3 p' $file_rev| cut -d' ' -f2)
    d_rev=$(sed -n '4 p' $file_rev| cut -d' ' -f2)
    mkdir /etc/bot/revenda/"$u_rev"
    mkdir /etc/bot/revenda/"$u_rev"/usuarios
    touch /etc/bot/revenda/"$u_rev"/$u_rev
    echo -e "Limite: $l_rev\nDias: $d_rev" > /etc/bot/revenda/"$u_rev"/$u_rev
    sed -i '$d' $file_rev
    echo -e "Vencimento: $(date "+%d/%m/%Y" -d "+$d_rev days")" >> $file_rev
}

fun_del_rev() {
    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    }
    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
        --text "🗑 REMOVER REVENDEDOR 🗑\n\nInforme o user dele [Ex: @crazy_vpn]:" \
        --reply_markup "$(ShellBot.ForceReply)"
}

del_rev() {
    _cli_rev=$1
    if [[ -z "$_cli_rev" ]]; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e "Erro")"
        return 0
    fi
    [[ -d /etc/bot/revenda/$_cli_rev ]] && {
        [[ "$(ls /etc/bot/revenda/$_cli_rev/usuarios| wc -l)" != '0' ]] && {
            for _user in $(ls /etc/bot/revenda/$_cli_rev/usuarios); do
                piduser=$(ps -u "$_user" |grep sshd |cut -d? -f1)
                kill -9 $piduser > /dev/null 2>&1
                userdel --force "$_user" 2>/dev/null
                grep -v ^$_user[[:space:]] /root/usuarios.db > /tmp/ph ; cat /tmp/ph > /root/usuarios.db
            done
        }
        rm -rf /etc/bot/revenda/$_cli_rev > /dev/null 2>&1
    }
    [[ -d /etc/bot/suspensos/$_cli_rev ]] && {
        [[ "$(ls /etc/bot/suspensos/$_cli_rev/usuarios| wc -l)" != '0' ]] && {
            for _user in $(ls /etc/bot/revenda/$_cli_rev/usuarios); do
                piduser=$(ps -u "$_user" |grep sshd |cut -d? -f1)
                kill -9 $piduser > /dev/null 2>&1
                userdel --force "$_user" 2>/dev/null
                grep -v ^$_user[[:space:]] /root/usuarios.db > /tmp/ph ; cat /tmp/ph > /root/usuarios.db
            done
        }
        rm -rf /etc/bot/suspensos/$_cli_rev > /dev/null 2>&1
    }
}

fun_lim_rev() {
    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    }
    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
        --text "♾ ALTERAR LIMITE REVENDA ♾\n\nInforme o user dele [Ex: @crazy_vpn]:" \
        --reply_markup "$(ShellBot.ForceReply)"
}

lim_rev() {
    _file_lim=$1
    if [[ -z "$_file_lim" ]]; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e "Erro")"
        return 0
    fi
    _rev_usern=$(grep 'Revendedor' $_file_lim| awk  -F '@' {'print $2'})
    new_l=$(grep 'Limite' $_file_lim| awk '{print $NF}')
    [[ -d /etc/bot/revenda/$_rev_usern ]] && {
        _base_l="/etc/bot/revenda/$_rev_usern/$_rev_usern"
        l_old=$(grep 'Limite' /etc/bot/revenda/$_rev_usern/$_rev_usern| awk '{print $NF}')
        sed -i "s;$l_old;$new_l;" /etc/bot/revenda/$_rev_usern/$_rev_usern
    } || {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e "Erro")"
        return 0
    }
}

fun_dat_rev() {
    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    }
    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
        --text "📆 ALTERAR DATA REVENDA 📆\n\nInforme o user dele [Ex: @crazy_vpn]:" \
        --reply_markup "$(ShellBot.ForceReply)"
}

dat_rev() {
    _datfile=$1
    if [[ -z "$_datfile" ]]; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e "Erro")"
        return 0
    fi
    _revd=$(grep 'Revendedor' $_datfile| cut -d'@' -f2)
    new_d=$(grep 'Data' $_datfile| awk '{print $NF}')
    if [[ -d "/etc/bot/suspensos/$_revd" ]]; then
        [[ "$(ls /etc/bot/suspensos/$_revd/usuarios| wc -l)" != '0' ]] && {
            for _user in $(ls /etc/bot/suspensos/$_revd/usuarios); do
                usermod -U $_user
            done
        }
        d_old=$(grep 'Dias' /etc/bot/suspensos/$_revd/$_revd| awk '{print $NF}')
        sed -i "s;$d_old;$new_d;" /etc/bot/suspensos/$_revd/$_revd
        mv /etc/bot/suspensos/$_revd /etc/bot/revenda/$_revd
        sed -i "s;$new_d;$(date "+%d/%m/%Y" -d "+$new_d days");" $_datfile
    elif [[ -d "/etc/bot/revenda/$_revd" ]]; then
        d_old=$(grep 'Dias' /etc/bot/revenda/$_revd/$_revd| awk '{print $NF}')
        sed -i "s;$d_old;$new_d;" /etc/bot/revenda/$_revd/$_revd
        sed -i "s;$new_d;$(date "+%d/%m/%Y" -d "+$new_d days");" $_datfile
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e "Erro")"
        return 0
    fi
}

fun_list_rev() {
    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    }
    [[ -e /tmp/lista.txt ]] && rm /tmp/lista.txt
    echo "=×=×=×=×=×=×=×=×=×=×=×=×=×=\n📃 LISTA DE REVENDEDORES !\n=×=×=×=×=×=×=×=×=×=×=×=×=×=\n" > /tmp/lista.txt
    [[ "$(ls /etc/bot/revenda| wc -l)" != '0' ]] && {
        for arq in $(ls /etc/bot/revenda); do
            echo -e "• @$arq - ATIVO" >> /tmp/lista.txt
        done
    } || {
        echo -e "Nenhum revendedor ativo" >> /tmp/lista.txt
    }
    [[ "$(ls /etc/bot/suspensos| wc -l)" != '0' ]] && {
        for arq2 in $(ls /etc/bot/suspensos); do
            echo -e "• @$arq2 - SUSPENSO" >> /tmp/lista.txt
        done
    } || {
        echo -e "\nNenhum revendedor suspenso" >> /tmp/lista.txt
    }
    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
    --text "$(echo -e "$(< /tmp/lista.txt)")" \
    --parse_mode html
    rm /tmp/lista.txt
    return 0
}

fun_susp_rev() {
    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    }
    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
        --text "🔒 SUSPENDER REVENDEDOR 🔒\n\nInforme o user dele [Ex: @crazy_vpn]:" \
        --reply_markup "$(ShellBot.ForceReply)"
}

susp_rev() {
    _revs=$1
    if [[ -z "$_revs" ]]; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e "Erro")"
        return 0
    fi
    if [[ -d "/etc/bot/revenda/$_revs" ]]; then
        [[ "$(ls /etc/bot/revenda/$_revs/usuarios| wc -l)" != '0' ]] && {
            for _user in $(ls /etc/bot/revenda/$_revs/usuarios); do
                usermod -L $_user
                pkill -f $_user
            done
        }
        mv /etc/bot/revenda/$_revs /etc/bot/suspensos/$_revs
    elif [[ -d "/etc/bot/suspensos/$_revs" ]]; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e "⚠️ O Revendedor Ja esta suspenso\n\nPara reativar altere a Data dele")"
        return 0
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e "Erro")"
        return 0
    fi
}

relatorio_rev() {
    verifica_suspenso ${message_from_username}
    if [[ "${message_from_id[$id]}" = "$id_admin" ]]; then
        _ons=$(ps -x | grep sshd | grep -v root | grep priv | wc -l)
        _tuser=$(awk -F: '$3>=1000 {print $1}' /etc/passwd | grep -v nobody | wc -l)
        [[ -e /etc/openvpn/openvpn-status.log ]] && _onop=$(grep -c "10.8.0" /etc/openvpn/openvpn-status.log) || _onop="0"
        [[ -e /etc/default/dropbear ]] && _drp=$(ps aux | grep dropbear | grep -v grep | wc -l) _ondrp=$(($_drp - 1)) || _ondrp="0"
        _onli=$(($_ons + $_onop + $_ondrp))
        _cont_rev=$(ls /etc/bot/revenda|wc -l)
        _cont_sus=$(ls /etc/bot/suspensos|wc -l)
        local msg
        msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        msg+="<b>📊 RELATORIO | INFORMACOES</b>\n"
        msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
        msg+="<b>Usuarios total:</b> $_tuser\n"
        msg+="<b>Usuarios online:</b> $_onli\n"
        msg+="<b>Revendas Ativas:</b> $_cont_rev\n"
        msg+="<b>Revendas Suspensas:</b> $_cont_sus\n\n"
        msg+="<b>User:</b> @${message_from_username}\n"
        msg+="<b>ID:</b> <code>${message_from_id}</code>\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e $msg)" \
        --parse_mode html

        [[ -e /tmp/online.txt ]] && rm /tmp/online.txt > /dev/null 2>&1
        [[ -e /tmp/Relatorio.txt ]] && rm /tmp/Relatorio.txt > /dev/null 2>&1
        revon=$(ls /etc/bot/revenda| wc -l)
        revoff=$(ls /etc/bot/suspensos| wc -l)
        t_rev=$(expr $revon + $revoff)
        [[ "$t_rev" == '0' ]] && return 0
        echo -e "RELATORIO DOS REVENDEDORS\n\nTotal: $t_rev  -  $(printf 'Data: %(%d/%m/%Y)T\n')\n=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=" > /tmp/Relatorio.txt
        for arq in $(ls /etc/bot/revenda); do
            _nomeR=$(ls /etc/bot/revenda/$arq| grep -v 'usuarios')
            unset _limiteR
            _limiteR=$(grep 'Limite' /etc/bot/revenda/$_nomeR/$_nomeR| awk '{print $NF}')
            _diasR=$(grep 'Dias' /etc/bot/revenda/$_nomeR/$_nomeR| awk '{print $NF}')
            [[ "$(ls /etc/bot/revenda/$_nomeR/usuarios| wc -l)" != '0' ]] && {
                touch /tmp/online.txt
                for user in $(ls /etc/bot/revenda/$_nomeR/usuarios); do
                    [[ -e '/etc/init.d/dropbear' ]] && echo -e "$(fun_drop2 | grep "$user" | wc -l)" >> /tmp/online.txt
                    [[ $(ps -u $user |grep sshd |wc -l) -gt '0' ]] && echo -e "$(ps -u $user |grep sshd |wc -l)" >> /tmp/online.txt
                    [[ -e /etc/openvpn/openvpn-status.log ]] && echo -e "$(grep -E ,"$user", /etc/openvpn/openvpn-status.log | wc -l)" >> /tmp/online.txt
                done
                [[ $(paste -s -d + /tmp/online.txt | bc) -gt '0' ]] && on="$(paste -s -d + /tmp/online.txt | bc)" || on=0
                total_U=$(ls /etc/bot/revenda/$_nomeR/usuarios| wc -l)
            } || {
                on=0
                total_U=$(ls /etc/bot/revenda/$_nomeR/usuarios| wc -l)
            }
            echo -e "\nREVENDEDOR: @$_nomeR\nLIMITE: $_limiteR\nDIAS RESTANTES: $_diasR\nSSH CRIADAS: $total_U\nSSH ONLINE: $on\n\n=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=" >> /tmp/Relatorio.txt
        done
        [[ "$(ls /etc/bot/suspensos| wc -l)" != '0' ]] && {
            for arq2 in $(ls /etc/bot/suspensos); do
                _diasRest=$(grep 'Dias' /etc/bot/suspensos/$arq2/$arq2| awk '{print $NF}')
                [[ $"_diasRest" -eq '0' ]] && var1='Expirou' || var1='Foi Bloqueado'
                echo -e "\nSUSPENSO: $arq2\nOBSERVACAO: $var1\n\n" >> /tmp/Relatorio.txt
            done
        }
        sleep 1
        [[ -e /tmp/Relatorio.txt ]] && {
            ShellBot.sendDocument --chat_id ${message_from_id[$id]} \
            --document "@/tmp/Relatorio.txt" \
            --caption "📊 RELATORIO REVENDEDORES"
            return 0
        }
    elif [[ -d /etc/bot/revenda/${message_from_username} ]]; then
        unset _limTotal4
        unset _lim1
        unset _Lim3
        on_user_rev=/tmp/online.$(echo $RANDOM)
        touch $on_user_rev
        _Dir_users="/etc/bot/revenda/${message_from_username}/usuarios"
        _limTotal4=$(grep 'Limite' /etc/bot/revenda/${message_from_username}/${message_from_username}| awk '{print $NF}')
        _cont_users=$(ls $_Dir_users|wc -l)
        unset _lim1
        _lim1='0'
        for i in $(ls $_Dir_users); do
            var2=$(cat $_Dir_users/$i| awk  -F : {'print $4'})
            _lim1=$(echo "${_lim1} + ${var2}"| bc)
            [[ -e '/etc/init.d/dropbear' ]] && echo -e "$(fun_drop2 | grep "$i" | wc -l)" >> $on_user_rev
            [[ $(ps -u $i |grep sshd |wc -l) -gt '0' ]] && echo -e "$(ps -u $i |grep sshd |wc -l)" >> $on_user_rev
            [[ -e /etc/openvpn/openvpn-status.log ]] && echo -e "$(grep -E ,"$i", /etc/openvpn/openvpn-status.log | wc -l)" >> $on_user_rev
        done
        [[ $(paste -s -d + $on_user_rev | bc) -gt '0' ]] && _on="$(paste -s -d + $on_user_rev | bc)" || _on=0
        _Lim3=$(echo ${_lim1})
        _restante4=$(($_limTotal4 - $_Lim3))
        local msg
        msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        msg+="<b>📊 RELATORIO | INFORMACOES</b>\n"
        msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
        msg+="<b>Limite De Logins:</b> $_limTotal4\n"
        msg+="<b>Limite Restante:</b> $_restante4\n"
        msg+="<b>Limite ultilizado:</b> $_Lim3\n"
        msg+="<b>Usuarios criados:</b> $_cont_users\n"
        msg+="<b>Usuarios Online:</b> $_on\n\n"
        msg+="<b>User:</b> @${message_from_username}\n"
        msg+="<b>ID:</b> <code>${message_from_id}</code>\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e $msg)" \
        --parse_mode html
        [[ -e "$on_user_rev" ]] && rm $on_user_rev
        return 0
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e 🚫 ACESSO NEGADO 🚫)" \
        --parse_mode html
        return 0
    fi
 }

fun_add_teste () {
    verifica_suspenso ${message_from_username}
    if [[ "${message_from_id[$id]}" = "$id_admin" ]]; then
        ShellBot.sendMessage    --chat_id ${message_from_id[$id]} \
        --text "👤 CRIAR TESTE 👤\n\nQuantas horas deve durar EX: 1:" \
        --reply_markup "$(ShellBot.ForceReply)"
    elif [[ -d /etc/bot/revenda/${message_from_username} ]]; then
        fun_verif_limit ${message_from_username}
        [[ "$verify" == '1' ]] && return 0
        ShellBot.sendMessage    --chat_id ${message_from_id[$id]} \
        --text "👤 CRIAR TESTE 👤\n\nQuantas horas deve durar EX: 1:" \
        --reply_markup "$(ShellBot.ForceReply)"
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    fi
}

fun_verif_user() {
    user=$1
    verifica_suspenso ${message_from_username}
    if [[ -z "$user" ]]; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e "Erro")" \
        --parse_mode html
        return 0
    fi
    [[ "${message_from_id[$id]}" = "$id_admin" ]] && {
        [[ ! -e /etc/bot/info-users/$user ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e ❌ Usuario $user nao existe !)" \
            --parse_mode html
            _existe='1'
            return 0
        }
    }
    [[ -d /etc/bot/revenda/${message_from_username} ]] && {
        [[ ! -e /etc/bot/revenda/${message_from_username}/usuarios/$user ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e ❌ Usuario $user nao existe !)" \
            --parse_mode html
            _existe='1'
            return 0
        }
    }
}

fun_teste (){
    usuario=$(echo teste$(( RANDOM% + 250 )))
    senha='1234'
    limite='1'
    t_time=$1
    ex_date=$(date '+%d/%m/%C%y' -d " +0 days")
    if [[ -z $t_time ]]; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e "❌ Erro tente novamente")" \
        --parse_mode html
        return 0
    fi
    if [[ "${message_from_id[$id]}" = "$id_admin" ]]; then
        echo "$usuario:$senha:$ex_date:$limite" > /etc/bot/info-users/$usuario
        dir_teste="/etc/bot/info-users/$usuario"
    else
        echo "$usuario:$senha:$ex_date:$limite" > /etc/bot/revenda/${message_from_username}/usuarios/$usuario
        dir_teste="/etc/bot/revenda/${message_from_username}/usuarios/$usuario"
    fi
    tuserdate=$(date '+%C%y/%m/%d' -d " +2 days")
    useradd -M -N -s /bin/false $usuario -e $tuserdate > /dev/null 2>&1
    (echo "$senha";echo "$senha") | passwd $usuario > /dev/null 2>&1
    echo "$senha" > /etc/SSHPlus/senha/$usuario
    echo "$usuario $limite" >> /root/usuarios.db
    echo "#!/bin/bash
pkill -f "$usuario"
userdel --force $usuario
grep -v ^$usuario[[:space:]] /root/usuarios.db > /tmp/ph ; cat /tmp/ph > /root/usuarios.db
rm /etc/SSHPlus/senha/$usuario > /dev/null 2>&1
rm $dir_teste
rm -rf /etc/SSHPlus/userteste/$usuario.sh" > /etc/SSHPlus/userteste/$usuario.sh
chmod +x /etc/SSHPlus/userteste/$usuario.sh
at -f /etc/SSHPlus/userteste/$usuario.sh now + $t_time hour > /dev/null 2>&1

[[ "$t_time" == '1' ]] && hrs="hora" || hrs="horas"
if [[ "$(ls /etc/bot/arquivos| wc -l)" != '0' ]]; then
    for arqv in $(ls /etc/bot/arquivos); do
        ShellBot.sendDocument --chat_id ${message_from_id[$id]} \
        --document "@/etc/bot/arquivos/$arqv" \
        --caption "$(echo -e "✅ Criado com sucesso ✅\n\nUSUARIO: $usuario\nSENHA: 1234\n\n⏳ Expira em: $t_time $hrs")" \
        sleep 0.5
    done
    return 0
else
    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
    --text "$(echo -e "✅ <b>Criado com sucesso</b> ✅\n\nIP: $(cat /etc/IP)\nUSUARIO: <code>$usuario</code>\nSENHA: <code>1234</code>\n\n⏳ Expira em: $t_time $hrs")" \
    --parse_mode html
    return 0
fi
}

fun_exp_user() {
    verifica_suspenso ${message_from_username}
    if [[ "${message_from_id[$id]}" = "$id_admin" ]]; then
        for user in $(ls /etc/bot/info-users/); do
            expdate=$(chage -l $user|awk -F: '/Account expires/{print $2}')
            [[ $(echo $expdate) == 'never' ]] && {
                pkill -f $user
                userdel --force $user
                [[ $(grep -w $user /root/usuarios.db|wc -l) != '0' ]] && grep -v ^$user[[:space:]] /root/usuarios.db > /tmp/ph ; cat /tmp/ph > /root/usuarios.db
            }
            echo $expdate|grep -q never && continue
            datanormal=$(date -d"$expdate" '+%d/%m/%Y')
            tput setaf 3 ; tput bold ; printf '%-15s%-17s%s' $user $datanormal ; tput sgr0
            expsec=$(date +%s --date="$expdate")
            diff=$(echo $datenow - $expsec|bc -l)
            tput setaf 2 ; tput bold
            echo $diff|grep -q ^\- && echo "Ativo    Não removido" && continue
            tput setaf 1 ; tput bold
            echo "Expirado    Removido"
            pkill -f $user
            userdel --force $user
            grep -v ^$user[[:space:]] /root/usuarios.db > /tmp/ph ; cat /tmp/ph > /root/usuarios.db
            [[ -e /etc/bot/info-users/$user ]] && rm /etc/bot/info-users/$user
        done
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e "⏳ Usuarios expirados removidos")" \
        --parse_mode html
        return 0
    elif [[ -d /etc/bot/revenda/${message_from_username} ]]; then
        dir_user="/etc/bot/revenda/${message_from_username}/usuarios"
        for user in `ls $dir_user`; do
            expdate=$(chage -l $user|awk -F: '/Account expires/{print $2}')
            [[ $(echo $expdate) == 'never' ]] && {
                pkill -f $user
                userdel --force $user
                [[ $(grep -w $user /root/usuarios.db|wc -l) != '0' ]] && grep -v ^$user[[:space:]] /root/usuarios.db > /tmp/ph ; cat /tmp/ph > /root/usuarios.db
            }
            echo $expdate|grep -q never && continue
            datanormal=$(date -d"$expdate" '+%d/%m/%Y')
            tput setaf 3 ; tput bold ; printf '%-15s%-17s%s' $user $datanormal ; tput sgr0
            expsec=$(date +%s --date="$expdate")
            diff=$(echo $datenow - $expsec|bc -l)
            tput setaf 2 ; tput bold
            echo $diff|grep -q ^\- && echo "Ativo    Não removido" && continue
            tput setaf 1 ; tput bold
            echo "Expirado    Removido"
            pkill -f $user
            userdel --force $user
            grep -v ^$user[[:space:]] /root/usuarios.db > /tmp/ph ; cat /tmp/ph > /root/usuarios.db
            [[ -e "$dir_user/$user" ]] && rm $dir_user/$user
        done
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e "⏳ Usuarios expirados removidos")" \
        --parse_mode html
        return 0
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e 🚫 ACESSO NEGADO 🚫)" \
        --parse_mode html
        return 0
    fi
}

fun_backauto () {
    [[ "${message_from_id[$id]}" = "$id_admin" ]] && {
        back_opc=$1
        if [[ -z $back_opc ]]; then
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "⚠️ Siga o exemplo !\n\n[EX:] /autobackup ativar\n[EX:] /autobackup desativar")" \
            --parse_mode html
            return 0
        fi
        if [[ "$back_opc" = "ativar" ]]; then
            [[ $(crontab -l|grep -c "userbackup") = '0' ]] && (crontab -l 2>/dev/null; echo "0 */6 * * * /bin/userbackup 1") | crontab -
            [[ ! -d /etc/SSHPlus/backups ]] && mkdir /etc/SSHPlus/backups
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "♻️ BACKUP AUTOMATICO ♻️\n\nATIVADO COM SUCESSO ✅")" \
            --parse_mode html
            return 0
        elif [[ "$back_opc" = "desativar" ]]; then
            [[ $(crontab -l|grep -c "userbackup") != '0' ]] && crontab -l | grep -v 'userbackup' | crontab -
            [[ -d /etc/SSHPlus/backups ]] && rm -rf /etc/SSHPlus/backups
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "♻️ BACKUP AUTOMATICO ♻️\n\nDESATIVADO COM SUCESSO ✅")" \
            --parse_mode html
            return 0
        else
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "❌ Erro... ⚠️ Siga o exemplo !\n\n[EX:] /autobackup ativar\n[EX:] /autobackup desativar")" \
            --parse_mode html
            return 0
        fi
    }
}

while :
do
   [[ -d "/etc/SSHPlus/backups" ]] && {
    [[ -e "/etc/SSHPlus/backups/backup.vps" ]] && {
        backup_auto
    }
   }
    #Obtem as atualizações
    ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 35
    #Lista o índice das atualizações
    for id in $(ShellBot.ListUpdates)
    do
    #Inicio thread
    (
        CAD_ARQ=/tmp/cad.${message_from_id[$id]}
        if [[ ${message_entities_type[$id]} == bot_command ]]
        then
        #Verifica se a mensagem enviada pelo usuário é um comando válido.
        case ${message_text[$id]} in
            *)
                :
                #comandos
                comando=(${message_text[$id]})
                [[ "${comando[0]}" = "start" || "${comando[0]}" = "/start" ]] && msg_bem_vindo
                [[ "${comando[0]}" = "menu" || "${comando[0]}" = "/menu" ]] && ajuda
                [[ "${comando[0]}" = "01" || "${comando[0]}" = "/criarusuario" ]] && fun_adduser
                [[ "${comando[0]}" = "02" || "${comando[0]}" = "/remover" ]] && fun_deluser
                [[ "${comando[0]}" = "03" || "${comando[0]}" = "/infousers" ]] && ver_users
                [[ "${comando[0]}" = "04" || "${comando[0]}" = "/monitor" ]] && monitor_ssh2
                [[ "${comando[0]}" = "05" || "${comando[0]}" = "/infovps" ]] && infovps
                [[ "${comando[0]}" = "06" || "${comando[0]}" = "/payload_vivo" ]] && payload_vivo
                [[ "${comando[0]}" = "07" || "${comando[0]}" = "/payload_oi" ]] && payload_oi
                [[ "${comando[0]}" = "08" || "${comando[0]}" = "/alterarsenha" ]] && alterar_senha
                [[ "${comando[0]}" = "09" || "${comando[0]}" = "/alterarlimite" ]] && alterar_limite
                [[ "${comando[0]}" = "10" || "${comando[0]}" = "/alterardata" ]] && alterar_data # "${comando[1]}" "${comando[2]}"
                [[ "${comando[0]}" = "11" || "${comando[0]}" = "/backup" ]] && backup_users
                [[ "${comando[0]}" = "12" || "${comando[0]}" = "/otimizar" ]] && otimizer
                [[ "${comando[0]}" = "13" || "${comando[0]}" = "/speedtest" ]] && speed_test
                [[ "${comando[0]}" = "14" || "${comando[0]}" = "/arquivos" ]] && fun_down
                [[ "${comando[0]}" = "15" || "${comando[0]}" = "/revenda" ]] && fun_revenda
                [[ "${comando[0]}" = "16" || "${comando[0]}" = "/ajuda" ]] && fun_ajuda
                [[ "${comando[0]}" = "/bot" || "${comando[0]}" = "/sobre" ]] && sobremim
                ## Menu revenda ##
                [[ "${comando[0]}" = "/add_revenda" ]] && fun_add_revenda
                [[ "${comando[0]}" = "/del_revenda" ]] && fun_del_rev
                [[ "${comando[0]}" = "/limite_revenda" ]] && fun_lim_rev
                [[ "${comando[0]}" = "/data_revenda" ]] && fun_dat_rev
                [[ "${comando[0]}" = "/listar_revenda" ]] && fun_list_rev
                [[ "${comando[0]}" = "/suspender" ]] && fun_susp_rev
                [[ "${comando[0]}" = "/relatorio" ]] && relatorio_rev
                [[ "${comando[0]}" = "/criarteste" ]] && fun_add_teste #"${comando[1]}"
                [[ "${comando[0]}" = "/expirados" ]] && fun_exp_user
                [[ "${comando[0]}" = "/autobackup" ]] && fun_backauto "${comando[1]}"
            ;;
        esac
        fi
        if [[ ${message_reply_to_message_message_id[$id]} ]]; then

if [[ "${message_from_id[$id]}" = "$id_admin" ]]; then
   echo "valido"
else
[[ ! -d /etc/bot/revenda/${message_from_username} ]] && {
   ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e 🚫 ACESSO NEGADO ! 🚫)"
        break
        }
fi
            
            # Analisa a interface de resposta.
            case ${message_reply_to_message_text[$id]} in
                    '👤 CRIAR USUARIO 👤\n\nNome do usuario:')
                        [[ "$(awk -F : '$3 >= 1000 { print $1 }' /etc/passwd |grep -w ${message_text[$id]}| wc -l)" != '0' ]] && {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Erro! USUARIO INVALIDO ❌\n\n⚠️ Informe Outro Nome..")" \
                                --parse_mode html
                            > $CAD_ARQ
                            break
                        }
                        [ "${message_text[$id]}" == 'root' ] && {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Erro! USUARIO INVALIDO ❌\n\n⚠️ Informe Outro Nome..")" \
                                --parse_mode html
                            > $CAD_ARQ
                            break
                        }
                        sizemin=$(echo -e ${#message_text[$id]})
                        [[ "$sizemin" -lt '4' ]] && {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Erro !\n\nUse no mínimo 4 caracteres\n[EX: test]")" \
                                --parse_mode html
                            > $CAD_ARQ
                            break
                        }
                        sizemax=$(echo -e ${#message_text[$id]})
                        [[ "$sizemax" -gt '8' ]] && {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Erro !\n\nUse no maximo 8 caracteres\n[EX: crazy]")" \
                                --parse_mode html
                            > $CAD_ARQ
                            break
                        }
                        # Salva os dados referentes e envia o próximo campo
                        # repetindo o processo até a finalização do cadastro.
                        echo "Nome: ${message_text[$id]}" > $CAD_ARQ                      
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text 'Senha:' \
                            --reply_markup "$(ShellBot.ForceReply)" # Força a resposta.
                        ;;
                    'Senha:')
                        sizepass=$(echo -e ${#message_text[$id]})
                        [[ "$sizepass" -lt '4' ]] && {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Erro !\n\nUse no mínimo 4 caracteres\n[EX: 1234]")" \
                                --parse_mode html
                            > $CAD_ARQ
                            break
                        }
                        echo "Senha: ${message_text[$id]}" >> $CAD_ARQ
                        
                        # Próximo campo.
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text 'Limite:' \
                            --reply_markup "$(ShellBot.ForceReply)"
                        ;;
                    'Limite:')
                        [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Erro ! \n\nUltilize apenas numeros [EX: 1]")" \
                                --parse_mode html
                            > $CAD_ARQ
                            break
                        }
                        echo "Limite: ${message_text[$id]}" >> $CAD_ARQ

                        # Próximo campo.
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text 'Validade em dias: ' \
                            --reply_markup "$(ShellBot.ForceReply)"
                        ;;
                        
                    'Validade em dias:')
                        [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Erro ! \n\nUltilize apenas numeros [EX: 30]")" \
                                --parse_mode html
                            > $CAD_ARQ
                            break
                        }
                        info_data=$(date '+%d/%m/%C%y' -d " +${message_text[$id]} days")
                        echo "Validade: $info_data" >> $CAD_ARQ
                        criar_user $CAD_ARQ
                        [[ "(grep -w ${message_text[$id]} /etc/passwd)" = '0' ]] && {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e Erro ao criar usuario !)" \
                                --parse_mode html
                            > $CAD_ARQ
                            break
                        } 
                        [[ "$verifyLimit" == '1' ]] && break         
                        [[ "$(ls /etc/bot/arquivos| wc -l)" != '0' ]] && {
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text '📥 ARQUIVOS DISPONIVEIS 📥\n\nDeseja baixar? Sim ou Nao?:' \
                            --reply_markup "$(ShellBot.ForceReply)"
                        } || {
                            ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                                --text "✅ *Criado com sucesso.* ✅\n\nIP: $(cat /etc/IP)\n$(< $CAD_ARQ)" \
                                --parse_mode markdown
                            break
                        }
                        ;;
                    '📥 ARQUIVOS DISPONIVEIS 📥\n\nDeseja baixar? Sim ou Nao?:')
                        [[ ${message_text[$id]} != ?(+|-)+([A-Za-z]) ]] && {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Opcao Invalida ❌\n\n⚠️ Ultilize apenas letras [EX: sim ou nao]")" \
                                --parse_mode html
                            ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                                --text "✅ *Criado com sucesso.* ✅\n\nIP: $(cat /etc/IP)\n$(< $CAD_ARQ)" \
                                --parse_mode markdown
                            break
                        }
                        [[ "${message_text[$id]}" = @(Sim|sim|SIM) ]] && {
                                msg_cli="≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠\n"
                                msg_cli+="<b>ARQUIVOS PRE-CONFIGURADOS </b>❗\n"
                                msg_cli+="≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠\n\n"
                                for _file in `ls /etc/bot/arquivos`; do
                                    i=$(( $i + 1 ))
                                    msg_cli+="<b>[$i]</b> - $_file\n"
                                done
                                ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                    --text "$(echo -e "$msg_cli")" \
                                    --parse_mode html
                                ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                                    --text 'Informe o Numero do Arquivo:' \
                                    --reply_markup "$(ShellBot.ForceReply)"
                        } || {
                            ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                                --text "✅ *Criado com sucesso.* ✅\n\nIP: $(cat /etc/IP)\n$(< $CAD_ARQ)" \
                                --parse_mode markdown
                        }
                        ;;
                    'Informe o Numero do Arquivo:')
                        [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Opcao Invalida ❌ \n\n⚠️ Ultilize apenas numeros [EX: 1]")" \
                                --parse_mode html
                            ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                                --text "✅ *Criado com sucesso.* ✅\n\nIP: $(cat /etc/IP)\n$(< $CAD_ARQ)" \
                                --parse_mode markdown
                        break
                        }
                        fun_download ${message_text[$id]} $CAD_ARQ
                        [[ -e "/root/$usuario.ovpn" ]] && {
                            ShellBot.sendDocument --chat_id ${message_from_id[$id]} \
                            --document "@/root/$usuario.ovpn"
                        }
                        
                        # Limpa o arquivo temporário.
                        > $CAD_ARQ
                        ;;
                    '🗑 REMOVER USUARIO 🗑\n\nNome do usuario:')                        
                        fun_verif_user ${message_text[$id]}
                        [[ "$_existe" == '1' ]] && break
                        fun_del_user ${message_text[$id]}
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text "✅ *Removido com sucesso.* 🚮" \
                            --parse_mode markdown
                        ;;
                    '🔐 Alterar Senha 🔐\n\nNome do usuario:')
                        fun_verif_user ${message_text[$id]}
                        [[ "$_existe" == '1' ]] && break
                        echo "${message_text[$id]}" > /tmp/name-s
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text 'Nova senha:' \
                            --reply_markup "$(ShellBot.ForceReply)"
                        ;;
                     'Nova senha:')
                        sizepass=$(echo -e ${#message_text[$id]})
                        [[ "$sizepass" -lt '4' ]] && {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Erro !\n\n⚠️ Use mínimo 4 caracteres [EX: 1234]")" \
                                --parse_mode html
                            break
                        }
                        alterar_senha_user $(cat /tmp/name-s) ${message_text[$id]}
                        [[ "$verify" == '1' ]] && break
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text "$(echo -e "=×=×=×=×=×=×=×=×=×=×=×\n<b>✅ SENHA ALTERADA !</b> !\n=×=×=×=×=×=×=×=×=×=×=×\n\n<b>Usuario:</b> $(cat /tmp/name-s)\n<b>Nova senha:</b> ${message_text[$id]}")" \
                            --parse_mode html
                        rm /tmp/name-s > /dev/null 2>&1
                        ;;
                    '👥 Alterar Limite 👥\n\nNome do usuario:')
                        fun_verif_user ${message_text[$id]}
                        [[ "$_existe" == '1' ]] && break
                        echo "${message_text[$id]}" > /tmp/name-l
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text 'Novo limite:' \
                            --reply_markup "$(ShellBot.ForceReply)"
                        ;;
                    'Novo limite:')
                        [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Erro ! \n\n⚠️ Ultilize apenas numeros [EX: 1]")" \
                                --parse_mode html
                            break
                        }
                        alterar_limite_user $(cat /tmp/name-l) ${message_text[$id]}
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text "$(echo -e "=×=×=×=×=×=×=×=×=×=×=×\n<b>✅ LIMITE ALTERADO !</b> !\n=×=×=×=×=×=×=×=×=×=×=×\n\n<b>Usuario:</b> $(cat /tmp/name-l)\n<b>Novo Limite:</b> ${message_text[$id]}")" \
                            --parse_mode html
                        rm /tmp/name-l > /dev/null 2>&1
                        ;;
                    '⏳ Alterar Data ⏳\n\nNome do usuario:')
                        fun_verif_user ${message_text[$id]}
                        [[ "$_existe" == '1' ]] && break
                        echo "${message_text[$id]}" > /tmp/name-d
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text 'informe os dias ou data:' \
                            --reply_markup "$(ShellBot.ForceReply)"
                        ;;
                    'informe os dias ou data:')
                        [[ ${message_text[$id]} != ?(+|-)+([0-9/]) ]] && {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Erro! Siga o exemplo\n\nDias formato [EX: 30]\nData formato [EX: 30/12/2019]")" \
                                --parse_mode html
                            break
                        }
                        alterar_data_user $(cat /tmp/name-d) ${message_text[$id]}
                        [[ "$verify" == '1' ]] && break
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text "$(echo -e "=×=×=×=×=×=×=×=×=×=×=×\n<b>✅ DATA ALTERADA !</b> !\n=×=×=×=×=×=×=×=×=×=×=×\n\n<b>Usuario:</b> $(cat /tmp/name-d)\n<b>Nova Data:</b> $udata")" \
                            --parse_mode html
                        rm /tmp/name-d > /dev/null 2>&1
                        ;;
                    '[1] - ADICIONAR ARQUIVO\n[2] - EXCLUIR ARQUIVO\n\nInforme a opcao [1-2]:')
                        [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Erro ! \n\n⚠️ Ultilize apenas numeros [EX: 1 ou 2]")" \
                                --parse_mode html
                            break
                        }
                        if [[ "${message_text[$id]}" = '1' ]]; then
                            ShellBot.sendMessage    --chat_id ${message_from_id[$id]} \
                            --text "📤 HOSPEDAR ARQUIVOS 📤\n\nEnvie-me o arquivo:" \
                            --reply_markup "$(ShellBot.ForceReply)"
                        elif [[ "${message_text[$id]}" = '2' ]]; then
                            [[ $(ls /etc/bot/arquivos| wc -l) != '0' ]] && {
                                msg_cli1="≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠\n"
                                msg_cli1+="🚀<b> ARQUIVOS HOSPEDADOS </b>\n"
                                msg_cli1+="≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠\n\n"
                                for _file in $(ls /etc/bot/arquivos); do
                                    i=$(( $i + 1 ))
                                    msg_cli1+="<b>[$i]</b> - $_file\n"
                                done
                                ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                    --text "$(echo -e "$msg_cli1")" \
                                    --parse_mode html
                            ShellBot.sendMessage    --chat_id ${message_from_id[$id]} \
                            --text "🗑Excluir Arquivo\nInforme o Numero do Arquivo:" \
                            --reply_markup "$(ShellBot.ForceReply)"
                        } || {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "Nao existe arquivos disponiveis")" \
                                --parse_mode html
                                break
                        }
                        else
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Opcao Invalida")" \
                                --parse_mode html
                            break
                        fi
                        ;;
                    '🗑Excluir Arquivo\nInforme o Numero do Arquivo:')
                        [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Erro ao Excluir arquivo ! \n\n⚠️ Ultilize apenas numeros [EX: 1]")" \
                                --parse_mode html
                            break
                        } || {
                            fun_del_arq ${message_text[$id]}
                            ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                                --text "✅ *Excluido com sucesso* ✅" \
                                --parse_mode markdown
                            break
                        }
                        ;;
                    '📤 HOSPEDAR ARQUIVOS 📤\n\nEnvie-me o arquivo:')
                        if [ "${update_id[$id]}" ]; then
                            # Monitora o envio de arquivos
                            # Se a variável do tipo for inicializada, salva o ID do arquivo enviado em 'file_id' e ativa o download.
                            [[ ${message_document_file_id[$id]} ]] && file_id=${message_document_file_id[$id]} && download_file=1           
                            # Verifica se o download está ativado.
                            [[ $download_file -eq 1 ]] && {
                                # Inicializa um array se houver mais de um ID salvo em 'file_id'.
                                # (É recomendado para fotos e vídeos, pois haverá o mesmo arquivo com diversas resoluções e ID's)
                                file_id=($file_id)
                                # Executa o metodo 'ShellBot.getFile', captura o id do download
                                ShellBot.getFile --file_id "${file_id[0]}"
                                # Executa o método 'ShellBot.downloadFile', captura os dados de retorno e salva em 'file_path'
                                ShellBot.downloadFile --file_path ${return[file_path]} --dir "/tmp/file" && {
                                    # Layout da mensagem
                                    msg='*✅ Arquivo hospedado com sucesso.*\n\n'
                                    msg+="*📤 Informações*\n\n"
                                    msg+="*Nome*: ${message_document_file_name}\n"
                                    msg+="*Salvo em*: /etc/bot/arquivos"                    
                                    # Envia a mensagem de confirmação e anexa as informações
                                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                        --text "$(echo -e "$msg")" \
                                        --parse_mode markdown
                                        mv /tmp/file/$(ls -1rt /tmp/file| tail  -n1) /etc/bot/arquivos/${message_document_file_name}
                                    break   
                                }
                            } || {
                                ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                    --text "$(echo -e "❌ Erro ao receber arquivo ❌")" \
                                    --parse_mode markdown
                                break
                            }
                        fi
                        ;;
                        # FUNCOES DE GESTAO REVENDA
                        #
                        # Adicionar, remover, limite, data, suspencao, relatorio
                        # 
                    '👥 ADICIONAR REVENDEDOR 👥\n\nInforme o nome:')
                        echo "Nome: ${message_text[$id]}" > $CAD_ARQ
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text 'Informe o user dele [Ex: @crazy_vpn]:' \
                            --reply_markup "$(ShellBot.ForceReply)"
                        ;;
                    'Informe o user dele [Ex: @crazy_vpn]:')
                        _VAR1=$(echo -e ${message_text[$id]}| awk  -F '@' {'print $2'})
                        [[ -z $_VAR1 ]] && {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Erro \n\n⚠️ Informe o user [EX: @crazy_vpn]")" \
                                --parse_mode html
                                break
                        }
                        [[ -d /etc/bot/revenda/$_VAR1 ]] && {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ O Revendedor ${message_text[$id]} ja existe")" \
                                --parse_mode html
                            break
                        }
                        echo "User: ${message_text[$id]}" >> $CAD_ARQ
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text 'Quantas SSH ele pode criar:' \
                            --reply_markup "$(ShellBot.ForceReply)"
                        ;;
                    'Quantas SSH ele pode criar:')
                        echo "Limite: ${message_text[$id]}" >> $CAD_ARQ
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text 'Quantos dias de acesso:' \
                            --reply_markup "$(ShellBot.ForceReply)"
                        ;;
                    'Quantos dias de acesso:')
                        echo "Validade: ${message_text[$id]}" >> $CAD_ARQ
                        _clientrev=$(cat $CAD_ARQ) 
                        criar_rev $CAD_ARQ
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text "✅ Criado com sucesso. ✅\n\n$(< $CAD_ARQ)\n\nBOT: @${message_reply_to_message_from_username}" \
                            --parse_mode html
                        ;;
                     # REMOVE REVENDEDOR
                    '🗑 REMOVER REVENDEDOR 🗑\n\nInforme o user dele [Ex: @crazy_vpn]:')
                        echo -e "${message_text[$id]}" > $CAD_ARQ
                        _Var=$(sed -n '1 p' $CAD_ARQ| awk  -F '@' {'print $2'})
                        [[ -z $_Var ]] && {
                             ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "Revendedor ${message_text[$id]} nao existe")" \
                                --parse_mode html
                                break
                        }
                        if [[ -d "/etc/bot/revenda/$_Var" ]]; then
                            del_rev $_Var
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "${message_text[$id]} foi Removido com sucesso")" \
                                --parse_mode html
                            break
                        elif [[ -d "/etc/bot/suspensos/$_Var" ]]; then
                            del_rev $_Var
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "${message_text[$id]} foi Removido com sucesso")" \
                                --parse_mode html
                            break
                        else
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Revendedor ${message_text[$id]} nao existe")" \
                                --parse_mode html
                            break
                        fi
                        ;;
                    # ALTERAR LIMITE
                    '♾ ALTERAR LIMITE REVENDA ♾\n\nInforme o user dele [Ex: @crazy_vpn]:')
                        echo -e "Revendedor: ${message_text[$id]}" > $CAD_ARQ
                        _Var1=$(sed -n '1 p' $CAD_ARQ| awk  -F '@' {'print $2'})
                        [[ -z $_Var1 ]] && {
                             ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Revendedor ${message_text[$id]} nao existe")" \
                                --parse_mode html
                                break
                        }
                        [[ -d "/etc/bot/revenda/$_Var1" ]] && {
                            ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text 'Informe o Limite SSH:' \
                            --reply_markup "$(ShellBot.ForceReply)"
                        } || {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Revendedor ${message_text[$id]} nao existe")" \
                                --parse_mode html
                                break
                        }
                        ;;
                    'Informe o Limite SSH:')
                        [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Erro ! \n\nUltilize apenas numeros [EX: 1]")" \
                                --parse_mode html
                            break
                        }
                        echo -e "Limite: ${message_text[$id]}" >> $CAD_ARQ
                        lim_rev $CAD_ARQ
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text "$(echo -e "=×=×=×=×=×=×=×=×=×=×=×\n<b>✅ LIMITE REVENDA ALTERADO !</b> !\n=×=×=×=×=×=×=×=×=×=×=×\n\n$(< $CAD_ARQ)")" \
                            --parse_mode html
                    # ALTERAR DATA
                        ;;
                    '📆 ALTERAR DATA REVENDA 📆\n\nInforme o user dele [Ex: @crazy_vpn]:')
                        _VAR1=$(echo -e ${message_text[$id]}| awk  -F '@' {'print $2'})
                        [[ -z $_VAR1 ]] && {
                             ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "Revendedor ${message_text[$id]} nao existe")" \
                                --parse_mode html
                                break
                        }
                        if [[ -d /etc/bot/revenda/$_VAR1 ]]; then
                            echo -e "Revendedor: ${message_text[$id]}" > $CAD_ARQ
                            ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text 'Dias de acesso [Ex: 30]:' \
                            --reply_markup "$(ShellBot.ForceReply)"
                        elif [[ -d /etc/bot/suspensos/$_VAR1 ]]; then
                            echo -e "Revendedor: ${message_text[$id]}" > $CAD_ARQ
                            ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text 'Dias de acesso [Ex: 30]:' \
                            --reply_markup "$(ShellBot.ForceReply)"
                        else      
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ O Revendedor ${message_text[$id]} nao existe")" \
                                --parse_mode html
                            break
                        fi
                        ;;
                    'Dias de acesso [Ex: 30]:')
                        [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Erro ! \n\nUltilize apenas numeros [EX: 30]")" \
                                --parse_mode html
                            break
                        }
                        echo -e "Data: ${message_text[$id]}" >> $CAD_ARQ
                        dat_rev $CAD_ARQ
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text "$(echo -e "=×=×=×=×=×=×=×=×=×=×=×\n<b>✅ DATA REVENDA ALTERADA !</b> !\n=×=×=×=×=×=×=×=×=×=×=×\n\n$(< $CAD_ARQ)")" \
                            --parse_mode html
                        ;;
                    # SUSPENDER REVENDEDOR
                    '🔒 SUSPENDER REVENDEDOR 🔒\n\nInforme o user dele [Ex: @crazy_vpn]:')
                        _VAR1=$(echo -e ${message_text[$id]}| awk  -F '@' {'print $2'})
                        [[ -z $_VAR1 ]] && {
                             ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Revendedor ${message_text[$id]} nao existe")" \
                                --parse_mode html
                                break
                        }
                        if [[ -d /etc/bot/revenda/$_VAR1 ]]; then
                            susp_rev $_VAR1
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "⚠️ $_VAR1 e as contas SSH dele\nForam Suspensos\n\nPara reativar altere a Data dele")" \
                                --parse_mode html
                            break
                        elif [[ -d /etc/bot/suspensos/$_VAR1 ]]; then
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                 --text "$(echo -e "⚠️ $_VAR1 Ja esta suspenso\n\nPara reativar altere a Data dele")" \
                                --parse_mode html
                            break
                        else
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                 --text "$(echo -e "❌ O Revendedor ${message_text[$id]} nao existe")" \
                                 --parse_mode html
                            break
                        fi
                        ;;
                    '👤 CRIAR TESTE 👤\n\nQuantas horas deve durar EX: 1:')
                        [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Erro ! \n\nUltilize apenas numeros [EX: 1]")" \
                                --parse_mode html
                            > $CAD_ARQ
                            break
                        }
                        fun_teste ${message_text[$id]}
                        ;;
            esac
        fi
    ) &
    done
done
#FIM