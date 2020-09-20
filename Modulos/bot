#!/bin/bash
#===================================================
#	SCRIPT: BOT SSHPLUS MANAGER
#   DATA ATT:   15 de Jul 2020
#	DESENVOLVIDO POR:	CRAZY_VPN
#   API SHELLBOT:   SHAMAN
#	CONTATO TELEGRAM:	http://t.me/crazy_vpn
#	CANAL TELEGRAM:	http://t.me/sshplus
#===================================================
[[ ! -d /etc/SSHPlus ]] && exit 0
[[ ! -d /etc/bot ]] && exit 0
source ShellBot.sh
api_bot=$1
id_admin=$2
[[ -z $api_bot ]] && exit 0
[[ -z $id_admin ]] && exit 0
[[ $(awk -F" " '{print $2}' /usr/lib/licence) != "@crazy_vpn" ]] && exit 0
ativos='/etc/bot/lista_ativos'
suspensos='/etc/bot/lista_suspensos'
ShellBot.init --token "$api_bot" --monitor --return map --flush
ShellBot.username
fun_menu() {
    if [[ "${message_from_id[$id]}" = "$id_admin" ]]; then
        local env_msg
        env_msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        env_msg+="<b>SEJA BEM VINDO(a) AO BOT SSHPLUS</b>\n"
        env_msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
        env_msg+="⚠️ <i>SELECIONE UMA OPCAO ABAIXO !</i>\n\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "$env_msg" \
            --reply_markup "$keyboard1" \
            --parse_mode html
        return 0
    elif [[ -d /etc/bot/suspensos/${message_from_username} ]]; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "🚫 VC ESTA SUSPENSO 🚫\n\nCONTATE O ADMINISTRADOR")"
        return 0
    elif [[ "$(grep -w "${message_from_username}" $ativos | awk '{print $NF}')" == 'revenda' ]]; then
        local env_msg
        env_msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        env_msg+="<b>SEJA BEM VINDO(a) AO BOT SSHPLUS</b>\n"
        env_msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
        env_msg+="⚠️ <i>SELECIONE UMA OPCAO ABAIXO !</i>\n\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "$env_msg" \
            --reply_markup "$keyboard2" \
            --parse_mode html
        return 0
    elif [[ "$(grep -w "${message_from_username}" $ativos | awk '{print $NF}')" == 'subrevenda' ]]; then
        local env_msg
        env_msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        env_msg+="<b>SEJA BEM VINDO(a) AO BOT SSHPLUS</b>\n"
        env_msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
        env_msg+="⚠️ <i>SELECIONE UMA OPCAO ABAIXO !</i>\n\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "$env_msg" \
            --reply_markup "$keyboard3" \
            --parse_mode html
        return 0
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    fi
}

fun_ajuda() {
    [[ ${message_chat_id[$id]} == "" ]] && {
        id_chatuser="${callback_query_message_chat_id[$id]}"
        id_name="${callback_query_from_username}"
    } || {
        id_chatuser="${message_chat_id[$id]}"
        id_name="${message_from_username}"
    }
    if [[ "$id_chatuser" = "$id_admin" ]]; then
        local env_msg
        env_msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        env_msg+="<b>BEM VINDO(a) AO BOT SSHPLUS</b>\n"
        env_msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
        env_msg+="⚠️ <i>Comandos Disponiveis</i>\n\n"
        env_msg+="[<b>01</b>] /menu = Exibe menu\n"
        env_msg+="[<b>02</b>] /ajuda = Informacoes sobre opcoes\n\n"
        env_msg+="⚠️ <i>Opções Disponiveis</i>\n\n"
        env_msg+="• <u>CRIAR USUARIO</u> = Cria usuario ssh\n\n"
        env_msg+="• <u>CRIAR TESTE</u> = Cria teste ssh\n\n"
        env_msg+="• <u>REMOVER</u> = Remove usuario ssh\n\n"
        env_msg+="• <u>INFO USUARIOS</u> = Informacoes do usuario\n\n"
        env_msg+="• <u>USUARIOS ONLINE</u> = Exibe Usuários onlines\n\n"
        env_msg+="• <u>INFO VPS</u> = Informacoes do servidor\n\n"
        env_msg+="• <u>ALTERAR SENHA</u> = Altera senha ssh\n\n"
        env_msg+="• <u>ALTERAR LIMITE</u> = Altera limite ssh\n\n"
        env_msg+="• <u>ALTERAR DATA</u> = Altera data ssh\n\n"
        env_msg+="• <u>EXPIRADOS</u> = Remove ssh expirados\n\n"
        env_msg+="• <u>BACKUP</u> = Cria Backup ssh e revendas\n\n"
        env_msg+="• <u>OTIMIZAR</u> = Limpa o cache - ram\n\n"
        env_msg+="• <u>SPEEDTESTE</u> = Teste de conexao\n\n"
        env_msg+="• <u>ARQUIVOS</u> = Hospeda Arquivos\n\n"
        env_msg+="• <u>REVENDAS</u> = Gerenciar Revendas\n\n"
        env_msg+="• <u>AUTOBACKUP</u> = lig/Des Backup automatico\n\n"
        env_msg+="• <u>RELATORIO</u> = Informacoes sobre revendas\n\n"
        env_msg+="• <u>AJUDA</u> = Informacoes sobre opcoes\n\n"
        ShellBot.sendMessage --chat_id $id_chatuser \
            --text "$(echo -e $env_msg)" \
            --parse_mode html
        return 0
    elif [[ -d /etc/bot/suspensos/$id_name ]]; then
        ShellBot.sendMessage --chat_id $id_chatuser \
            --text "$(echo -e "🚫 VC ESTA SUSPENSO 🚫\n\nCONTATE O ADMINISTRADOR")"
        return 0
    elif [[ "$(grep -w "$id_name" $ativos | awk '{print $NF}')" == 'revenda' ]]; then
        local env_msg
        env_msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        env_msg+="<b>BEM VINDO(a) AO BOT SSHPLUS</b>\n"
        env_msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
        env_msg+="⚠️ <i>Comandos Disponiveis</i>\n\n"
        env_msg+="[<b>01</b>] /menu = Exibe menu\n"
        env_msg+="[<b>02</b>] /ajuda = Informacoes sobre opcoes\n\n"
        env_msg+="⚠️ <i>Opções Disponiveis</i>\n\n"
        env_msg+="• <u>CRIAR USUARIO</u> = Cria usuario ssh\n\n"
        env_msg+="• <u>CRIAR TESTE</u> = Cria teste ssh\n\n"
        env_msg+="• <u>REMOVER</u> = Remove usuario ssh\n\n"
        env_msg+="• <u>INFO USUARIOS</u> = Informacoes do usuario\n\n"
        env_msg+="• <u>USUARIOS ONLINE</u> = Exibe Usuários onlines\n\n"
        env_msg+="• <u>ALTERAR SENHA</u> = Altera senha ssh\n\n"
        env_msg+="• <u>ALTERAR LIMITE</u> = Altera limite ssh\n\n"
        env_msg+="• <u>ALTERAR DATA</u> = Altera data ssh\n\n"
        env_msg+="• <u>EXPIRADOS</u> = Remove ssh expirados\n\n"
        env_msg+="• <u>REVENDAS</u> = Gerenciar Revendas\n\n"
        env_msg+="• <u>RELATORIO</u> = Informacoes sobre revendas\n\n"
        env_msg+="• <u>AJUDA</u> = Informacoes sobre opcoes\n\n"
        ShellBot.sendMessage --chat_id $id_chatuser \
            --text "$(echo -e $env_msg)" \
            --parse_mode html
        return 0
    elif [[ "$(grep -w "$id_name" $ativos | awk '{print $NF}')" == 'subrevenda' ]]; then
        local env_msg
        env_msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        env_msg+="<b>BEM VINDO(a) AO BOT SSHPLUS</b>\n"
        env_msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
        env_msg+="⚠️ <i>Comandos Disponiveis</i>\n\n"
        env_msg+="[<b>01</b>] /menu = Exibe menu\n"
        env_msg+="[<b>02</b>] /ajuda = Informacoes sobre opcoes\n\n"
        env_msg+="⚠️ <i>Opções Disponiveis</i>\n\n"
        env_msg+="• <u>CRIAR USUARIO</u> = Cria usuario ssh\n\n"
        env_msg+="• <u>CRIAR TESTE</u> = Cria teste ssh\n\n"
        env_msg+="• <u>REMOVER</u> = Remove usuario ssh\n\n"
        env_msg+="• <u>INFO USUARIOS</u> = Informacoes do usuario\n\n"
        env_msg+="• <u>USUARIOS ONLINE</u> = Exibe Usuários onlines\n\n"
        env_msg+="• <u>ALTERAR SENHA</u> = Altera senha ssh\n\n"
        env_msg+="• <u>ALTERAR LIMITE</u> = Altera limite ssh\n\n"
        env_msg+="• <u>ALTERAR DATA</u> = Altera data ssh\n\n"
        env_msg+="• <u>EXPIRADOS</u> = Remove ssh expirados\n\n"
        env_msg+="• <u>AJUDA</u> = Informacoes sobre opcoes\n\n"
        ShellBot.sendMessage --chat_id $id_chatuser \
            --text "$(echo -e $env_msg)" \
            --parse_mode html
        return 0
    else
        ShellBot.sendMessage --chat_id $id_chatuser \
            --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    fi
}

verifica_acesso() {
    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
        [[ "$(grep -wc ${message_from_username} $suspensos)" != '0' ]] || [[ "$(grep -wc ${message_from_username} $ativos)" == '0' ]] && {
            _erro="1"
            return 0
        }
    }
}

fun_adduser() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "👤 CRIAR USUARIO 👤\n\nNome do usuario:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    }
}

criar_user() {
    IP=$(cat /etc/IP)
    newclient() {
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
    file_user=$1
    usuario=$(sed -n '1 p' $file_user | cut -d' ' -f2)
    senha=$(sed -n '2 p' $file_user | cut -d' ' -f2)
    limite=$(sed -n '3 p' $file_user | cut -d' ' -f2)
    data=$(sed -n '4 p' $file_user | cut -d' ' -f2)
    validade=$(echo "$data" | awk -F'/' '{print $2FS$1FS$3}' | xargs -i date -d'{}' +%Y/%m/%d)

    useradd -M -N -s /bin/false $usuario -e $validade >/dev/null 2>&1
    (
        echo "${senha}"
        echo "${senha}"
    ) | passwd "${usuario}" >/dev/null 2>&1
    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
        echo "$usuario:$senha:$info_data:$limite" >/etc/bot/revenda/${message_from_username}/usuarios/$usuario
        echo "$usuario:$senha:$info_data:$limite" >/etc/bot/info-users/$usuario
    }
    echo "$usuario $limite" >>/root/usuarios.db
    echo "$senha" >/etc/SSHPlus/senha/$usuario
    [[ -e "/etc/openvpn/server.conf" ]] && {
        cd /etc/openvpn/easy-rsa/
        ./easyrsa build-client-full $usuario nopass
        newclient "$usuario"
    }
}

fun_deluser() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "🗑 REMOVER USUARIO 🗑\n\nNome do usuario:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    }
}

fun_del_user() {
    usuario=$1
    [[ "${message_from_id[$id]}" = "$id_admin" ]] && {
        piduser=$(ps -u "$usuario" | grep sshd | cut -d? -f1)
        kill -9 $piduser >/dev/null 2>&1
        userdel --force "$usuario" 2>/dev/null
        grep -v ^$usuario[[:space:]] /root/usuarios.db >/tmp/ph
        cat /tmp/ph >/root/usuarios.db
        rm /etc/SSHPlus/senha/$usuario >/dev/null 2>&1
    } || {
        [[ ! -e /etc/bot/revenda/${message_from_username}/usuarios/$usuario ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "❌ O USUARIO NAO EXISTE ❌")" \
                --parse_mode html
            _erro='1'
            return 0
        }
        piduser=$(ps -u "$usuario" | grep sshd | cut -d? -f1)
        kill -9 $piduser >/dev/null 2>&1
        userdel --force "$usuario" 2>/dev/null
        grep -v ^$usuario[[:space:]] /root/usuarios.db >/tmp/ph
        cat /tmp/ph >/root/usuarios.db
        rm /etc/SSHPlus/senha/$usuario >/dev/null 2>&1
        rm /etc/bot/revenda/${message_from_username}/usuarios/$usuario
        rm /etc/bot/info-users/$usuario
    }
    [[ -e /etc/SSHPlus/userteste/$usuario.sh ]] && rm /etc/SSHPlus/userteste/$usuario.sh
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
        [[ -e $HOME/$usuario.ovpn ]] && rm $HOME/$usuario.ovpn >/dev/null 2>&1
    }
}

alterar_senha() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "🔐 Alterar Senha 🔐\n\nNome do usuario:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    }
}

alterar_senha_user() {
    usuario=$1
    senha=$2
    [[ "${message_from_id[$id]}" = "$id_admin" ]] && {
        echo "$usuario:$senha" | chpasswd
        echo "$senha" >/etc/SSHPlus/senha/$usuario
        pkill -u $usuario >/dev/null 2>&1
    } || {
        [[ ! -e /etc/bot/revenda/${message_from_username}/usuarios/$usuario ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "❌ O USUARIO NAO EXISTE ❌")" \
                --parse_mode html
            _erro='1'
            return 0
        }
        echo "$usuario:$senha" | chpasswd
        senha2=$(cat /etc/bot/revenda/${message_from_username}/usuarios/$usuario | awk -F : {'print $2'})
        sed -i "/$usuario/ s/\b$senha2\b/$senha/g" /etc/bot/revenda/${message_from_username}/usuarios/$usuario
        sed -i "/$usuario/ s/\b$senha2\b/$senha/g" /etc/bot/info-users/$usuario
        echo "$senha" >/etc/SSHPlus/senha/$usuario
        pkill -u $usuario >/dev/null 2>&1
    }
}

alterar_limite() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "👥 Alterar Limite 👥\n\nNome do usuario:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    }
}

alterar_limite_user() {
    usuario=$1
    limite=$2
    database="/root/usuarios.db"
    [[ "${message_from_id[$id]}" = "$id_admin" ]] && {
        grep -v ^$usuario[[:space:]] /root/usuarios.db >/tmp/a
        mv /tmp/a /root/usuarios.db
        echo $usuario $limite >>/root/usuarios.db
        return 0
    }
    [[ -d /etc/bot/revenda/${message_from_username} ]] && {
        [[ ! -e /etc/bot/revenda/${message_from_username}/usuarios/$usuario ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "❌ O USUARIO NAO EXISTE ❌")" \
                --parse_mode html
            _erro='1'
            return 0
        }
        _limTotal=$(grep -w 'LIMITE_REVENDA' /etc/bot/revenda/${message_from_username}/${message_from_username} | awk '{print $NF}')
        [[ "$limite" -gt "$_limTotal" ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "❌ VC NAO TEM LIMITE SUFICIENTE ❌\n\nLimite Atual: $_limTotal ")" \
                --parse_mode html
            _erro='1'
            return 0
        }
        _limTotal=$(grep -w "${message_from_username}" $ativos | awk '{print $4}')
        fun_verif_limite_rev ${message_from_username}
        _limsomarev2=$(echo "$_result + $limite" | bc)
        echo "Total $_limsomarev2"
        [[ "$_limsomarev2" -gt "$_limTotal" ]] && {
            [[ "$_limTotal" == "$(($_limTotal - $_result))" ]] && _restant1='0' || _restant1=$(($_limTotal - $_result))
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "❌ Vc nao tem limite suficiente\n\nLimite restante: $_restant1 ")" \
                --parse_mode html
            _erro='1'
            return 0
        }
        grep -v ^$usuario[[:space:]] /root/usuarios.db >/tmp/a
        mv /tmp/a /root/usuarios.db
        echo $usuario $limite >>/root/usuarios.db
        limite2=$(cat /etc/bot/revenda/${message_from_username}/usuarios/$usuario | awk -F : {'print $4'})
        sed -i "/\b$usuario\b/ s/\b$limite2\b/$limite/" /etc/bot/revenda/${message_from_username}/usuarios/$usuario
        sed -i "/\b$usuario\b/ s/\b$limite2\b/$limite/" /etc/bot/info-users/$usuario
    }
}

alterar_data() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "⏳ Alterar Data ⏳\n\nNome do usuario:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    }
}

alterar_data_user() {
    usuario=$1
    inputdate=$2
    database="/root/usuarios.db"
    [[ "$(echo -e "$inputdate" | sed -e 's/[^/]//ig')" != '//' ]] && {
        udata=$(date "+%d/%m/%Y" -d "+$inputdate days")
        sysdate="$(echo "$udata" | awk -v FS=/ -v OFS=- '{print $3,$2,$1}')"
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
            _erro='1'
            return 0
        }
    }
    [[ "${message_from_id[$id]}" = "$id_admin" ]] && {
        chage -E $sysdate $usuario
    }
    [[ -e /etc/bot/revenda/${message_from_username}/usuarios/$usuario ]] && {
        data2=$(cat /etc/bot/info-users/$usuario | awk -F : {'print $3'})
        sed -i "s;$data2;$udata;" /etc/bot/info-users/$usuario
        sed -i "s;$data2;$udata;" /etc/bot/revenda/${message_from_username}/usuarios/$usuario
    }
}

ver_users() {
    if [[ "${callback_query_from_id[$id]}" = "$id_admin" ]]; then
        arq_info=/tmp/$(echo $RANDOM)
        local info_users
        info_users='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n'
        info_users+='<b>INFORMACOES DOS USUARIOS</b>\n'
        info_users+='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n'
        info_users+='⚠️ Exibe no formato abaixo:\n\n'
        info_users+='<code>USUÁRIO SENHA LIMITE DATA</code>\n'
        ShellBot.sendMessage --chat_id $id_admin \
            --text "$(echo -e $info_users)" \
            --parse_mode html
        fun_infu() {
            local info
            for user in $(cat /etc/passwd | awk -F : '$3 >= 1000 {print $1}' | grep -v nobody); do
                info='===========================\n'
                [[ -e /etc/SSHPlus/senha/$user ]] && senha=$(cat /etc/SSHPlus/senha/$user) || senha='Null'
                [[ $(grep -wc $user $HOME/usuarios.db) != '0' ]] && limite=$(grep -w $user $HOME/usuarios.db | cut -d' ' -f2) || limite='Null'
                datauser=$(chage -l $user | grep -i co | awk -F : '{print $2}')
                [[ $datauser = ' never' ]] && {
                    data="00/00/00"
                } || {
                    databr="$(date -d "$datauser" +"%Y%m%d")"
                    hoje="$(date -d today +"%Y%m%d")"
                    [[ $hoje -ge $databr ]] && {
                        data="Venceu"
                    } || {
                        dat="$(date -d"$datauser" '+%Y-%m-%d')"
                        data=$(echo -e "$((($(date -ud $dat +%s) - $(date -ud $(date +%Y-%m-%d) +%s)) / 86400)) DIAS")
                    }
                }
                info+="$user • $senha • $limite • $data"
                echo -e "$info"
            done
        }
        fun_infu >$arq_info
        while :; do
            ShellBot.sendMessage --chat_id $id_admin \
                --text "$(while read linha; do echo $linha; done < <(sed '1,30!d' $arq_info))" \
                --parse_mode html
            sed -i 1,30d $arq_info
            [[ $(cat $arq_info | wc -l) = '0' ]] && rm $arq_info && break
        done
    elif [[ "$(grep -wc "${callback_query_from_username}" $ativos)" != '0' ]]; then
        [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
            return 0
        }
        [[ $(ls /etc/bot/revenda/${callback_query_from_username}/usuarios | wc -l) == '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "VC AINDA NAO CRIOU USUARIO!"
            return 0
        }
        arq_info=/tmp/$(echo $RANDOM)
        local info_users
        info_users='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n'
        info_users+='<b>INFORMACOES DOS USUARIOS</b>\n'
        info_users+='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n'
        info_users+='⚠️ Exibe no formato abaixo:\n\n'
        info_users+='<code>USUÁRIO SENHA LIMITE DATA</code>\n'
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "$(echo -e $info_users)" \
            --parse_mode html
        fun_infu() {
            local info
            for user in $(ls /etc/bot/revenda/${callback_query_from_username}/usuarios); do
                info='===========================\n'
                [[ -e /etc/SSHPlus/senha/$user ]] && senha=$(cat /etc/SSHPlus/senha/$user) || senha='Null'
                [[ $(grep -wc $user $HOME/usuarios.db) != '0' ]] && limite=$(grep -w $user $HOME/usuarios.db | cut -d' ' -f2) || limite='Null'
                datauser=$(chage -l $user | grep -i co | awk -F : '{print $2}')
                [[ $datauser = ' never' ]] && {
                    data="00/00/00"
                } || {
                    databr="$(date -d "$datauser" +"%Y%m%d")"
                    hoje="$(date -d today +"%Y%m%d")"
                    [[ $hoje -ge $databr ]] && {
                        data="Venceu"
                    } || {
                        dat="$(date -d"$datauser" '+%Y-%m-%d')"
                        data=$(echo -e "$((($(date -ud $dat +%s) - $(date -ud $(date +%Y-%m-%d) +%s)) / 86400)) DIAS")
                    }
                }
                info+="$user • $senha • $limite • $data"
                echo -e "$info"
            done
        }
        fun_infu >$arq_info
        while :; do
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                --text "$(while read linha; do echo $linha; done < <(sed '1,30!d' $arq_info))" \
                --parse_mode html
            sed -i 1,30d $arq_info
            [[ $(cat $arq_info | wc -l) = '0' ]] && rm $arq_info && break
        done
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    fi
}

fun_drop() {
    port_dropbear=$(ps aux | grep dropbear | awk NR==1 | awk '{print $17;}')
    log=/var/log/auth.log
    loginsukses='Password auth succeeded'
    pids=$(ps ax | grep dropbear | grep " $port_dropbear" | awk -F" " '{print $1}')
    for pid in $pids; do
        pidlogs=$(grep $pid $log | grep "$loginsukses" | awk -F" " '{print $3}')
        i=0
        for pidend in $pidlogs; do
            let i=i+1
        done
        if [ $pidend ]; then
            login=$(grep $pid $log | grep "$pidend" | grep "$loginsukses")
            PID=$pid
            user=$(echo $login | awk -F" " '{print $10}' | sed -r "s/'/ /g")
            waktu=$(echo $login | awk -F" " '{print $2"-"$1,$3}')
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

monitor_ssh() {
    if [[ "${callback_query_from_id[$id]}" = "$id_admin" ]]; then
        database="/root/usuarios.db"
        cad_onli=/tmp/$(echo $RANDOM)
        local info_on
        info_on='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n'
        info_on+='<b>MONITOR USUARIOS ONLINES</b>\n'
        info_on+='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n'
        info_on+='⚠️ Exibe no formato abaixo:\n\n'
        info_on+='<code>USUÁRIO  ONLINE/LIMITE  TEMPO\n</code>'
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "$(echo -e $info_on)" \
            --parse_mode html
        fun_online() {
            local info2
            for user in $(cat /etc/passwd | awk -F : '$3 >= 1000 {print $1}' | grep -v nobody); do
                [[ "$(grep -w $user $database)" != "0" ]] && lim="$(grep -w $user $database | cut -d' ' -f2)" || lim=0
                [[ $(netstat -nltp | grep 'dropbear' | wc -l) != '0' ]] && drop="$(fun_drop | grep "$user" | wc -l)" || drop=0
                [[ -e /etc/openvpn/openvpn-status.log ]] && ovp="$(cat /etc/openvpn/openvpn-status.log | grep -E ,"$user", | wc -l)" || ovp=0
                sqd="$(ps -u $user | grep sshd | wc -l)"
                _cont=$(($drop + $ovp))
                conex=$(($_cont + $sqd))
                [[ $conex -gt '0' ]] && {
                    timerr="$(ps -o etime $(ps -u $user | grep sshd | awk 'NR==1 {print $1}') | awk 'NR==2 {print $1}')"
                    info2+="===========================\n"
                    info2+="🟢 $user       $conex/$lim       ⏳$timerr\n"
                }
            done
            echo -e "$info2"
        }
        fun_online >$cad_onli
        [[ $(cat $cad_onli | wc -w) != '0' ]] && {
            while :; do
                ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                    --text "$(while read linha; do echo $linha; done < <(sed '1,30!d' $cad_onli))" \
                    --parse_mode html
                sed -i 1,30d $cad_onli
                [[ "$(cat $cad_onli | wc -l)" = '0' ]] && {
                    rm $cad_onli
                    break
                }
            done
        } || {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "Nenhum usuario online" \
                --parse_mode html
            return 0
        }
    elif [[ "$(grep -wc "${callback_query_from_username}" $ativos)" != '0' ]]; then
        [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
            return 0
        }
        [[ $(ls /etc/bot/revenda/${callback_query_from_username}/usuarios | wc -l) == '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "VC AINDA NAO CRIOU USUARIO!"
            return 0
        }
        database="/root/usuarios.db"
        cad_onli=/tmp/$(echo $RANDOM)
        local info_on
        info_on='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n'
        info_on+='<b>MONITOR USUARIOS ONLINES</b>\n'
        info_on+='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n'
        info_on+='⚠️ Exibe no formato abaixo:\n\n'
        info_on+='<code>USUÁRIO  ONLINE/LIMITE  TEMPO\n</code>'
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "$(echo -e $info_on)" \
            --parse_mode html
        fun_online() {
            local info2
            for user in $(ls /etc/bot/revenda/${callback_query_from_username}/usuarios); do
                [[ "$(grep -w $user $database)" != "0" ]] && lim="$(grep -w $user $database | cut -d' ' -f2)" || lim=0
                [[ $(netstat -nltp | grep 'dropbear' | wc -l) != '0' ]] && drop="$(fun_drop | grep "$user" | wc -l)" || drop=0
                [[ -e /etc/openvpn/openvpn-status.log ]] && ovp="$(cat /etc/openvpn/openvpn-status.log | grep -E ,"$user", | wc -l)" || ovp=0
                sqd="$(ps -u $user | grep sshd | wc -l)"
                conex=$(($sqd + $ovp + $drop))
                [[ $conex -gt '0' ]] && {
                    timerr="$(ps -o etime $(ps -u $user | grep sshd | awk 'NR==1 {print $1}') | awk 'NR==2 {print $1}')"
                    info2+="------------------------------\n"
                    info2+="👤$user       $conex/$lim       ⏳$timerr\n"
                }
            done
            echo -e "$info2"
        }
        fun_online >$cad_onli
        [[ $(cat $cad_onli | wc -w) != '0' ]] && {
            while :; do
                ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                    --text "<code>$(while read linha; do echo $linha; done < <(sed '1,30!d' $cad_onli))</code>" \
                    --parse_mode html
                sed -i 1,30d $cad_onli
                [[ "$(cat $cad_onli | wc -l)" = '0' ]] && {
                    rm $cad_onli
                    break
                }
            done
        } || {
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                --text "Nenhum usuario online" \
                --parse_mode html
            return 0
        }
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    fi
}

fun_verif_user() {
    user=$1
    [[ -z "$user" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "Erro")" \
            --parse_mode html
        return 0
    }
    [[ "${message_from_id[$id]}" = "$id_admin" ]] && {
        [[ ! -e /etc/bot/info-users/$user ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e ❌ Usuario $user nao existe !)" \
                --parse_mode html
            _erro='1'
            return 0
        }
    }
    [[ -d /etc/bot/revenda/${message_from_username} ]] && {
        [[ ! -e /etc/bot/revenda/${message_from_username}/usuarios/$user ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e ❌ Usuario $user nao existe !)" \
                --parse_mode html
            _erro='1'
            return 0
        }
    }
}

fun_down() {
    [[ "${callback_query_from_id[$id]}" != "$id_admin" ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    }
    [[ ! -d /tmp/file ]] && mkdir /tmp/file
    ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --text "[1] - ADICIONAR ARQUIVO\n[2] - EXCLUIR ARQUIVO\n\nInforme a opcao [1-2]:" \
        --reply_markup "$(ShellBot.ForceReply)"
}

infovps() {
    [[ "${callback_query_from_id[$id]}" != "$id_admin" ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    }
    PTs='/tmp/prts'
    _ons=$(ps -x | grep sshd | grep -v root | grep priv | wc -l)
    [[ -e /etc/openvpn/openvpn-status.log ]] && _onop=$(grep -c "10.8.0" /etc/openvpn/openvpn-status.log) || _onop="0"
    [[ -e /etc/default/dropbear ]] && _drp=$(ps aux | grep dropbear | grep -v grep | wc -l) _ondrp=$(($_drp - 1)) || _ondrp="0"
    _on=$(($_ons + $_onop + $_ondrp))
    total=$(awk -F: '$3>=1000 {print $1}' /etc/passwd | grep -v nobody | wc -l)
    system=$(cat /etc/issue.net)
    uso=$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')
    cpucores=$(grep -c cpu[0-9] /proc/stat)
    ram1=$(free -h | grep -i mem | awk {'print $2'})
    usoram=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }')
    total=$(cat -n /root/usuarios.db | tail -n 1 | awk '{print $1}')
    echo -e "SSH: $(grep 'Port' /etc/ssh/sshd_config | cut -d' ' -f2 | grep -v 'no' | xargs)" >$PTs
    [[ -e "/etc/stunnel/stunnel.conf" ]] && echo -e "SSL Tunel: $(netstat -nplt | grep 'stunnel' | awk {'print $4'} | cut -d: -f2 | xargs)" >>$PTs
    [[ -e "/etc/openvpn/server.conf" ]] && echo -e "Openvpn: $(netstat -nplt | grep 'openvpn' | awk {'print $4'} | cut -d: -f2 | xargs)" >>$PTs
    [[ "$(netstat -nplt | grep 'sslh' | wc -l)" != '0' ]] && echo -e "SSlh: $(netstat -nplt | grep 'sslh' | awk {'print $4'} | cut -d: -f2 | xargs)" >>$PTs
    [[ "$(netstat -nplt | grep 'squid' | wc -l)" != '0' ]] && echo -e "Squid: $(netstat -nplt | grep 'squid' | awk -F ":" {'print $4'} | xargs)" >>$PTs
    [[ "$(netstat -nltp | grep 'dropbear' | wc -l)" != '0' ]] && echo -e "DropBear: $(netstat -nplt | grep 'dropbear' | awk -F ":" {'print $4'} | xargs)" >>$PTs
    [[ "$(netstat -nplt | grep 'python' | wc -l)" != '0' ]] && echo -e "Proxy Socks: $(netstat -nplt | grep 'python' | awk {'print $4'} | cut -d: -f2 | xargs)" >>$PTs
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
    while read linha; do
        info+="<b>$(echo -e "$linha")</b>\n"
    done < <(cat $PTs)
    info+="\n<b>$total</b><i> USUARIOS</i><b> $_on</b> <i>ONLINE</i>"
    ShellBot.sendMessage --chat_id $id_admin \
        --text "$(echo -e $info)" \
        --parse_mode html
    return 0
}

fun_download() {
    Opc=$1
    [[ -z "$Opc" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "❌Erro tente novamente")"
        _erro='1'
        return 0
    }
    _file2=$2
    [[ -z "$_file2" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "❌Erro tente novamente")"
        _erro='1'
        return 0
    }
    _DirArq=$(ls /etc/bot/arquivos)
    i=0
    unset _Pass
    while read _Arq; do
        i=$(expr $i + 1)
        _oP=$i
        [[ $i == [1-9] ]] && i=0$i && oP+=" 0$i"
        echo -e "[$i] - $_Arq"
        _Pass+="\n${_oP}:${_Arq}"
    done <<<"${_DirArq}"
    _file=$(echo -e "${_Pass}" | grep -E "\b$Opc\b" | cut -d: -f2)
    echo $_file2
    ShellBot.sendDocument --chat_id ${message_from_id[$id]} \
        --document "@/etc/bot/arquivos/$_file" \
        --caption "$(echo -e "✅ CRIADO COM SUCESSO ✅\n\nUSUARIO: <code>$(awk -F " " '/Nome/ {print $2}' $_file2)</code>\nSENHA: <code>$(awk -F " " '/Senha/ {print $2}' $_file2)</code>\nLIMITE: $(awk -F " " '/Limite/ {print $2}' $_file2)\nEXPIRA EM: $(awk -F " " '/Validade/ {print $2}' $_file2)")" \
        --parse_mode html
    [[ -e "/root/$(awk -F " " '/Nome/ {print $2}' $_file2).ovpn" ]] && {
        ShellBot.sendDocument --chat_id ${message_from_id[$id]} \
            --document "@/root/$(awk -F " " '/Nome/ {print $2}' $_file2).ovpn"
    }
}

fun_del_arq() {
    Opc1=$1
    [[ -z "$Opc1" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "❌Erro tente novamente")"
        _erro='1'
        return 0
    }
    _DirArq=$(ls /etc/bot/arquivos)
    i=0
    unset _Pass
    while read _Arq; do
        i=$(expr $i + 1)
        _oP=$i
        [[ $i == [1-9] ]] && i=0$i && oP+=" 0$i"
        echo -e "[$i] - $_Arq"
        _Pass+="\n${_oP}:${_Arq}"
    done <<<"${_DirArq}"
    _file=$(echo -e "${_Pass}" | grep -E "\b$Opc1\b" | cut -d: -f2)
    [[ -e /etc/bot/arquivos/$_file ]] && {
        rm /etc/bot/arquivos/$_file
    } || {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "❌ Opcao invalida")"
        _erro='1'
        return 0
    }
}

otimizer() {
    [[ "${callback_query_from_id[$id]}" != "$id_admin" ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    }
    MEM1=$(free | awk '/Mem:/ {print int(100*$3/$2)}')
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
        --text "🧹 LIMPANDO CACHE DO SERVIDOR"
    apt-get autoclean -y
    echo 3 >/proc/sys/vm/drop_caches
    sync && sysctl -w vm.drop_caches=3 1>/dev/null 2>/dev/null
    sysctl -w vm.drop_caches=0 1>/dev/null 2>/dev/null
    swapoff -a
    swapon -a
    ram1=$(free -h | grep -i mem | awk {'print $2'})
    ram2=$(free -h | grep -i mem | awk {'print $3'})
    ram3=$(free -h | grep -i mem | awk {'print $4'})
    MEM2=$(free | awk '/Mem:/ {print int(100*$3/$2)}')
    res=$(expr $MEM1 - $MEM2)
    local sucess
    sucess="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
    sucess+="<b>OTIMIZADO COM SUCESSO !</b>\n"
    sucess+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
    sucess+="<i>Ultilizacao anterior</i> $MEM1%\n\n"
    sucess+="<b>Memoria Ram Total</b> $ram1\n"
    sucess+="<b>livre</b> $ram3\n"
    sucess+="<b>Em uso</b> $ram2\n"
    sucess+="<i>Ultilizacao atual</i> $MEM2%\n\n"
    sucess+="<b>Economia de:</b> $res%"
    ShellBot.sendMessage --chat_id $id_admin \
        --text "$(echo -e $sucess)" \
        --parse_mode html
    return 0
}

speed_test() {
    [[ "${callback_query_from_id[$id]}" != "$id_admin" ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    }
    rm -rf $HOME/speed >/dev/null 2>&1
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
        --text "🚀 TESTANDO VELOCIDADE DO SERVIDOR"
    speedtest --share >speed
    png=$(cat speed | sed -n '5 p' | awk -F : {'print $NF'})
    down=$(cat speed | sed -n '7 p' | awk -F : {'print $NF'})
    upl=$(cat speed | sed -n '9 p' | awk -F : {'print $NF'})
    lnk=$(cat speed | sed -n '10 p' | awk {'print $NF'})
    local msg
    msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
    msg+="<b>🚀 VELOCIDADE DO SERVIDOR 🚀</b>\n"
    msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
    msg+="<b>PING/LATENCIA:</b>$png\n"
    msg+="<b>DOWNLOAD:</b>$down\n"
    msg+="<b>UPLOAD:</b>$upl\n"
    ShellBot.sendMessage --chat_id $id_admin \
        --text "$(echo -e $msg)" \
        --parse_mode html
    ShellBot.sendMessage --chat_id $id_admin \
        --text "$(echo -e $lnk)" \
        --parse_mode html
    rm -rf $HOME/speed >/dev/null 2>&1
    return 0
}

backup_users() {
    [[ "${callback_query_from_id[$id]}" != "$id_admin" ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    }
    rm /root/backup.vps 1>/dev/null 2>/dev/null
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
        --text "♻️ CRIANDO BACKUP DE USUARIOS"
    tar cvf /root/backup.vps /root/usuarios.db /etc/shadow /etc/passwd /etc/group /etc/gshadow /etc/bot 1>/dev/null 2>/dev/null
    ShellBot.sendDocument --chat_id ${id_admin} \
        --document "@/root/backup.vps" \
        --caption "$(echo -e "♻️ BACKUP DE USUARIOS ♻️")"
    return 0
}

sobremim() {
    local msg
    msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
    msg+="<b>🤖 BOT SSHPLUS MANAGER 🤖</b>\n"
    msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
    msg+="<b>Desenvolvido por:</b> @crazy_vpn\n"
    msg+="<b>Canal Oficial:</b> @SSHPLUS\n\n"
    msg+="Fui criado com o propósito de fornecer informações e ferramentas para gestão VPN em servidores 🐧 GNU/Linux 🐧.\n\n"
    msg+="<b>Menu:</b> /menu\n"
    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e $msg)" \
        --parse_mode html
    return 0
}

fun_add_teste() {
    if [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]]; then
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    elif [[ "${callback_query_from_id[$id]}" == "$id_admin" ]]; then
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "👤 CRIAR TESTE 👤\n\nQuantas horas deve durar EX: 1:" \
            --reply_markup "$(ShellBot.ForceReply)"
    elif [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]]; then
        _limTotal=$(grep -w "${callback_query_from_username}" $ativos | awk '{print $4}')
        fun_verif_limite_rev ${callback_query_from_username}
        _limsomarev2=$(echo "$_result + 1" | bc)
        [[ "$_limsomarev2" -gt "$_limTotal" ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "❌ VC NAO TEM LIMITE DISPONIVEL!"
            return 0
        } || {
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                --text "👤 CRIAR TESTE 👤\n\nQuantas horas deve durar EX: 1:" \
                --reply_markup "$(ShellBot.ForceReply)"
        }
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    fi
}

fun_teste() {
    usuario=$(echo teste$((RANDOM % +500)))
    senha='1234'
    limite='1'
    t_time=$1
    ex_date=$(date '+%d/%m/%C%y' -d " +2 days")
    tuserdate=$(date '+%C%y/%m/%d' -d " +2 days")
    [[ -z $t_time ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "❌ Erro tente novamente")" \
            --parse_mode html
        return 0
        _erro='1'
    }
    useradd -M -N -s /bin/false $usuario -e $tuserdate >/dev/null 2>&1
    (
        echo "$senha"
        echo "$senha"
    ) | passwd $usuario >/dev/null 2>&1
    echo "$senha" >/etc/SSHPlus/senha/$usuario
    echo "$usuario $limite" >>/root/usuarios.db
    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
        echo "$usuario:$senha:$ex_date:$limite" >/etc/bot/revenda/${message_from_username}/usuarios/$usuario
    }
    dir_teste="/etc/bot/revenda/${message_from_username}/usuarios/$usuario"
    cat <<-EOF >/etc/SSHPlus/userteste/$usuario.sh
	#!/bin/bash
	# USUARIO TESTE
	[[ \$(ps -u "$usuario" | grep -c sshd) != '0' ]] && pkill -u $usuario
	userdel --force $usuario
	grep -v ^$usuario[[:space:]] /root/usuarios.db > /tmp/ph ; cat /tmp/ph > /root/usuarios.db
	[[ -e $dir_teste ]] && rm $dir_teste
	rm /etc/SSHPlus/senha/$usuario > /dev/null 2>&1
	rm /etc/SSHPlus/userteste/$usuario.sh
	EOF
    chmod +x /etc/SSHPlus/userteste/$usuario.sh
    echo "/etc/SSHPlus/userteste/$usuario.sh" | at now + $t_time hour >/dev/null 2>&1
    [[ "$t_time" == '1' ]] && hrs="hora" || hrs="horas"
    [[ "$(ls /etc/bot/arquivos | wc -l)" != '0' ]] && {
        for arqv in $(ls /etc/bot/arquivos); do
            ShellBot.sendDocument --chat_id ${message_from_id[$id]} \
                --document "@/etc/bot/arquivos/$arqv" \
                --caption "$(echo -e "✅ Criado com sucesso ✅\n\nUSUARIO: <code>$usuario</code>\nSENHA: <code>1234</code>\n\n⏳ Expira em: $t_time $hrs")" \
                --parse_mode html
        done
        return 0
    } || {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "✅ <b>Criado com sucesso</b> ✅\n\nIP: $(cat /etc/IP)\nUSUARIO: <code>$usuario</code>\nSENHA: <code>1234</code>\n\n⏳ Expira em: $t_time $hrs")" \
            --parse_mode html
        return 0
    }
}

fun_exp_user() {
    if [[ "${callback_query_from_id[$id]}" == "$id_admin" ]]; then
        [[ $(cat /root/usuarios.db | wc -l) == '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "VC AINDA NAO CRIOU USUARIO!"
            return 0
        }
        datenow=$(date +%s)
        for user in $(cat /etc/passwd | awk -F : '$3 >= 1000 {print $1}' | grep -v nobody); do
            expdate=$(chage -l $user | awk -F: '/Account expires/{print $2}')
            echo $expdate | grep -q never && continue
            datanormal=$(date -d"$expdate" '+%d/%m/%Y')
            expsec=$(date +%s --date="$expdate")
            diff=$(echo $datenow - $expsec | bc -l)
            echo $diff | grep -q ^\- && continue
            pkill -u $user
            userdel --force $user
            grep -v ^$user[[:space:]] /root/usuarios.db >/tmp/ph
            cat /tmp/ph >/root/usuarios.db
            [[ -e /etc/bot/info-users/$user ]] && rm /etc/bot/info-users/$user
            [[ -e /etc/SSHPlus/userteste/$user.sh ]] && rm /etc/SSHPlus/userteste/$user.sh
            [[ "$(ls /etc/bot/revenda)" != '0' ]] && {
                for ex in $(ls /etc/bot/revenda); do
                    [[ -e /etc/bot/revenda/$exp/usuarios/$user ]] && rm /etc/bot/revenda/$ex/usuarios/$user
                done
            }
        done
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⌛️ USUARIOS SSH EXPIRADOS REMOVIDOS"
        return 0
    elif [[ "$(grep -wc "${callback_query_from_username}" $ativos)" != '0' ]]; then
        [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
            return 0
        }
        [[ $(ls /etc/bot/revenda/${callback_query_from_username}/usuarios | wc -l) == '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "VC AINDA NAO CRIOU USUARIO!"
            return 0
        }
        datenow=$(date +%s)
        dir_user="/etc/bot/revenda/${callback_query_from_username}/usuarios"
        for user in $(ls $dir_user); do
            expdate=$(chage -l $user | awk -F: '/Account expires/{print $2}')
            echo $expdate | grep -q never && continue
            datanormal=$(date -d"$expdate" '+%d/%m/%Y')
            expsec=$(date +%s --date="$expdate")
            diff=$(echo $datenow - $expsec | bc -l)
            echo $diff | grep -q ^\- && continue
            pkill -u $user
            userdel --force $user
            grep -v ^$user[[:space:]] /root/usuarios.db >/tmp/ph
            cat /tmp/ph >/root/usuarios.db
            [[ -e /etc/SSHPlus/userteste/$user.sh ]] && rm /etc/SSHPlus/userteste/$user.sh
            [[ -e "$dir_user/$user" ]] && rm $dir_user/$user
        done
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⌛️ USUARIOS SSH EXPIRADOS REMOVIDOS"
        return 0
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    fi
}

relatorio_rev() {
    if [[ "${callback_query_from_id[$id]}" = "$id_admin" ]]; then
        _ons=$(ps -x | grep sshd | grep -v root | grep priv | wc -l)
        _tuser=$(awk -F: '$3>=1000 {print $1}' /etc/passwd | grep -v nobody | wc -l)
        [[ -e /etc/openvpn/openvpn-status.log ]] && _onop=$(grep -c "10.8.0" /etc/openvpn/openvpn-status.log) || _onop="0"
        [[ -e /etc/default/dropbear ]] && _drp=$(ps aux | grep dropbear | grep -v grep | wc -l) _ondrp=$(($_drp - 1)) || _ondrp="0"
        _onli=$(($_ons + $_onop + $_ondrp))
        _cont_rev=$(echo $(grep -wc revenda $ativos) - $(grep -wc revenda $suspensos) | bc)
        _cont_sus=$(grep -wc revenda $suspensos)
        _cont_sub=$(grep -wc subrevenda $ativos)
        _cont_revt=$(grep -wc revenda $ativos)
        local msg
        msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        msg+="<b>📊 RELATORIO | INFORMACOES</b>\n"
        msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
        msg+="<b>Usuarios total:</b> $_tuser\n"
        msg+="<b>Usuarios online:</b> $_onli\n"
        msg+="<b>Revendas Ativas:</b> $_cont_rev\n"
        msg+="<b>Revendas Suspensas:</b> $_cont_sus\n"
        msg+="<b>Sub-Revendas:</b> $_cont_sub\n\n"
        msg+="<b>User:</b> @${callback_query_from_username}\n"
        msg+="<b>ID:</b> <code>${callback_query_from_id}</code>\n"
        [[ $_cont_revt != '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "📊 CRIANDO RELATORIO !"
        } || {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⚠️ NENHUM REVENDEDOR ENCONTRADO !"
            return 0
        }
        echo -e "RELATORIO DOS REVENDEDORES\n\nTotal: $_cont_revt  -  $(printf 'Data: %(%d/%m/%Y)T\n')\n=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=" >/tmp/Relatorio.txt
        while read _revlist; do
            _nome_rev="$(echo $_revlist | awk '{print $2}')"
            _limite_rev="$(echo $_revlist | awk '{print $4}')"
            _data_rev="$(echo $_revlist | awk '{print $6}')"
            [[ -e "/etc/bot/revenda/$_nome_rev/$_nome_rev" ]] && {
                _dirsts='revenda'
                _status='Ativo'
            } || {
                _dirsts='suspensos'
                _status='Suspenso'
            }
            _subrev="$(grep -wc SUBREVENDA /etc/bot/$_dirsts/$_nome_rev/$_nome_rev)"
            fun_on() {
                for user in $(ls /etc/bot/$_dirsts/$_nome_rev/usuarios); do
                    [[ $(netstat -nltp | grep 'dropbear' | wc -l) != '0' ]] && drop="$(fun_drop | grep "$user" | wc -l)" || drop=0
                    [[ -e /etc/openvpn/openvpn-status.log ]] && ovp="$(cat /etc/openvpn/openvpn-status.log | grep -E ,"$user", | wc -l)" || ovp=0
                    sqd="$(ps -u $user | grep sshd | wc -l)"
                    conex=$(($sqd + $ovp + $drop))
                    echo -e "$conex"
                done
            }
            [[ "$(ls /etc/bot/$_dirsts/$_nome_rev/usuarios | wc -l)" != '0' ]] && {
                total_on=$(fun_on | paste -s -d + | bc)
                total_users=$(ls /etc/bot/$_dirsts/$_nome_rev/usuarios | wc -l)
            } || {
                total_on='0'
                total_users='0'
            }
            echo -e "\nSTATUS: $_status\nREVENDEDOR: @$_nome_rev\nLIMITE: $_limite_rev\nDIAS RESTANTES: $_data_rev\nSSH CRIADAS: $total_users\nSSH ONLINE: $total_on\nSUB-REVENDAS: $_subrev\n\n=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=" >>/tmp/Relatorio.txt
        done <<<"$(grep -w 'revenda' $ativos)"
        ShellBot.sendDocument --chat_id $id_admin \
            --document "@/tmp/Relatorio.txt" \
            --caption "$(echo -e "$msg")" \
            --parse_mode html
        return 0
    elif [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]]; then
        [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
            return 0
        }
        [[ $(grep -wc 'SUBREVENDA' /etc/bot/revenda/${callback_query_from_username}/${callback_query_from_username}) == '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⚠️ NENHUM SUB REVENDEDOR ENCONTRADO !"
            return 0
        }
        fun_contsub() {
            while read _sublist; do
                _usub="$(echo $_sublist | awk '{print $2}')"
                echo $(grep -wc $_usub $suspensos)
            done <<<"$(grep -w 'SUBREVENDA' /etc/bot/revenda/${callback_query_from_username}/${callback_query_from_username})"
        }
        _cont_limite=$(grep -w ${callback_query_from_username} $ativos | awk '{print $4}')
        fun_verif_limite_rev ${callback_query_from_username}
        _cont_disp=$(echo $_result - $_cont_limite | bc)
        _cont_atv=$(grep -wc SUBREVENDA /etc/bot/revenda/${callback_query_from_username}/${callback_query_from_username})
        _cont_sup=$(fun_contsub | paste -s -d + | bc)
        local msg
        msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        msg+="<b>📊 RELATORIO | INFORMACOES</b>\n"
        msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
        msg+="<b>Limite de Logins:</b> $_cont_limite\n"
        msg+="<b>Limite Disponivel:</b> $_cont_disp\n"
        msg+="<b>Sub-Revendas Total:</b> $_cont_atv\n"
        msg+="<b>Sub-Revendas Suspensas:</b> $_cont_sup\n"
        msg+="<b>User:</b> @${callback_query_from_username}\n"
        msg+="<b>ID:</b> <code>${callback_query_from_id}</code>\n"
        echo -e "RELATORIO DOS SUB REVENDEDORES\n\nTotal: $_cont_atv  -  $(printf 'Data: %(%d/%m/%Y)T\n')\n=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=" >/tmp/Relatorio-${callback_query_from_username}.txt
        while read _sublist; do
            _usub="$(echo $_sublist | awk '{print $2}')"
            _limit_sub=$(echo $_sublist | awk '{print $4}')
            _data_sub=$(grep -w $_usub $ativos | awk '{print $6}')
            [[ -e "/etc/bot/revenda/$_usub/$_usub" ]] && {
                _dirsts='revenda'
                _status='Ativo'
            } || {
                _dirsts='suspensos'
                _status='Suspenso'
            }
            fun_subon() {
                for user in $(ls /etc/bot/$_dirsts/$_usub/usuarios); do
                    [[ $(netstat -nltp | grep 'dropbear' | wc -l) != '0' ]] && drop="$(fun_drop | grep "$user" | wc -l)" || drop=0
                    [[ -e /etc/openvpn/openvpn-status.log ]] && ovp="$(cat /etc/openvpn/openvpn-status.log | grep -E ,"$user", | wc -l)" || ovp=0
                    sqd="$(ps -u $user | grep sshd | wc -l)"
                    conex=$(($sqd + $ovp + $drop))
                    echo -e "$conex"
                done
            }
            [[ "$(ls /etc/bot/$_dirsts/$_usub/usuarios | wc -l)" != '0' ]] && {
                total_on=$(fun_on | paste -s -d + | bc)
                total_users=$(ls /etc/bot/$_dirsts/$_usub/usuarios | wc -l)
            } || {
                total_on='0'
                total_users='0'
            }
            echo -e "\nSTATUS: $_status\nSUB-REVENDEDOR: @$_usub\nLIMITE: $_limit_sub\nDIAS RESTANTES: $_data_sub\nSSH CRIADAS: $total_users\nSSH ONLINE: $total_on\n\n=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=" >>/tmp/Relatorio-${callback_query_from_username}.txt
        done <<<"$(grep -w 'SUBREVENDA' /etc/bot/revenda/${callback_query_from_username}/${callback_query_from_username})"
        ShellBot.sendDocument --chat_id ${callback_query_message_chat_id[$id]} \
            --document "@/tmp/Relatorio-${callback_query_from_username}.txt" \
            --caption "$(echo -e "$msg")" \
            --parse_mode html
        return 0
    else

        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    fi
}

fun_backauto() {
    [[ "${callback_query_from_id[$id]}" = "$id_admin" ]] && {
        [[ ! -d /etc/SSHPlus/backups ]] && {
            mkdir /etc/SSHPlus/backups
            [[ $(crontab -l | grep -c "userbackup") = '0' ]] && (
                crontab -l 2>/dev/null
                echo "0 */6 * * * /bin/userbackup 1"
            ) | crontab -
            s
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "♻️ BACKUP AUTOMATICO ATIVADO 🟢"
            return 0
        } || {
            [[ $(crontab -l | grep -c "userbackup") != '0' ]] && crontab -l | grep -v 'userbackup' | crontab -
            [[ -d /etc/SSHPlus/backups ]] && rm -rf /etc/SSHPlus/backups
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "♻️ BACKUP AUTOMATICO DESATIVADO 🔴"
            return 0
        }
    }
}

backup_auto() {
    ShellBot.sendDocument --chat_id $id_admin \
        --document "@/etc/SSHPlus/backups/backup.vps" \
        --caption "$(echo -e "♻️ BACKUP AUTOMATICO ♻️")"
    rm /etc/SSHPlus/backups/backup.vps
    return 0
}

msg_bem_vindo() {
    local msg
    msg="✌️😃 Ola <b>${message_from_first_name[$id]}</b>\n\nSEJA BEM VINDO(a)\n\n"
    msg+="Para acessar o menu\nclick ou execute [ /menu ]\n\n"
    msg+="Para obter informacoes\nclick ou execute [ /ajuda ]\n\n"
    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e $msg)" \
        --parse_mode html
    return 0
}

fun_verif_limite_rev() {
    _userrev=$1
    [[ "$(grep -w "$_userrev" $ativos | awk '{print $NF}')" == 'revenda' ]] && {
        echo $_userrev
        [[ $(grep -wc 'SUBREVENDA' /etc/bot/revenda/$_userrev/$_userrev) != '0' ]] && {
            _limsomarev=$(grep -w 'SUBREVENDA' /etc/bot/revenda/$_userrev/$_userrev | awk {'print $4'} | paste -s -d + | bc)
        } || {
            _limsomarev='0'
        }
        [[ $(ls /etc/bot/revenda/$_userrev/usuarios | wc -l) != '0' ]] && {
            _mlim1='0'
            _meus_users="/etc/bot/revenda/$_userrev/usuarios"
            for _user_ in $(ls $_meus_users); do
                _mlim2=$(cat $_meus_users/$_user_ | awk -F : {'print $4'})
                _mlim1=$(echo "${_mlim1} + ${_mlim2}" | bc)
            done
        }
        [[ -z "$_mlim1" ]] && _mlim1='0'
        _result=$(echo "${_limsomarev} + ${_mlim1}" | bc)
    }
    [[ "$(grep -w "$_userrev" $ativos | awk '{print $NF}')" == 'subrevenda' ]] && {
        [[ "$(ls /etc/bot/revenda/$_userrev/usuarios | wc -l)" != '0' ]] && {
            _dir_users="/etc/bot/revenda/$_userrev/usuarios"
            _lim1='0'
            for i in $(ls $_dir_users); do
                _lim2=$(cat $_dir_users/$i | awk -F : {'print $4'})
                _lim1=$(echo "${_lim1} + ${_lim2}" | bc)
            done
        }
        [[ -z "$_lim1" ]] && _lim1='0'
        _result=$(echo "${_lim1}")
    }
}

fun_add_revenda() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "👥 ADICIONAR REVENDEDOR 👥\n\nInforme o nome:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    }
}

criar_rev() {
    file_rev=$1
    [[ -z "$file_rev" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e Erro)"
        _erro='1'
        break
    }
    n_rev=$(sed -n '1 p' $file_rev | cut -d' ' -f2)
    u_rev=$(sed -n '2 p' $file_rev | awk -F '@' {'print $2'})
    l_rev=$(sed -n '3 p' $file_rev | cut -d' ' -f2)
    d_rev=$(sed -n '4 p' $file_rev | cut -d' ' -f2)
    [[ "${message_from_id[$id]}" = "$id_admin" ]] && {
        t_rev='revenda'
    } || {
        t_rev='subrevenda'
        echo -e "SUBREVENDA: $u_rev LIMITE_SUBREVENDA: $l_rev" >>/etc/bot/revenda/${message_from_username}/${message_from_username}
    }
    mkdir /etc/bot/revenda/"$u_rev"
    mkdir /etc/bot/revenda/"$u_rev"/usuarios
    touch /etc/bot/revenda/"$u_rev"/$u_rev
    echo -e "USER: $u_rev LIMITE: $l_rev DIAS: $d_rev TIPO: $t_rev" >>$ativos
    echo -e "=========================\nLIMITE_REVENDA: $l_rev\nDIAS_REVENDA: $d_rev\n=========================\n" >/etc/bot/revenda/"$u_rev"/$u_rev
    sed -i '$d' $file_rev
    echo -e "Vencimento: $(date "+%d/%m/%Y" -d "+$d_rev days")" >>$file_rev
}

fun_del_rev() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "🗑 REMOVER REVENDEDOR 🗑\n\nInforme o user dele [Ex: @crazy_vpn]:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    }
}

del_rev() {
    _cli_rev=$1
    [[ -z "$_cli_rev" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "Erro")"
        return 0
    }
    [[ "${message_from_id[$id]}" == "$id_admin" ]] && {
        [[ "$(grep -wc "$_cli_rev" $ativos)" != '0' ]] && {
            [[ -e "/etc/bot/revenda/$_cli_rev/$_cli_rev" ]] && _dirsts='revenda' || _dirsts='suspensos'
            [[ "$(grep -wc 'SUBREVENDA' /etc/bot/$_dirsts/$_cli_rev/$_cli_rev)" != '0' ]] && {
                while read _listsub2; do
                    _usub="$(echo $_listsub2 | awk '{print $2}')"
                    [[ -e "/etc/bot/revenda/$_usub/$_usub" ]] && _dirsts2='revenda' || _dirsts2='suspensos'
                    _dir_users="/etc/bot/$_dirsts2/$_usub/usuarios"
                    [[ "$(ls $_dir_users | wc -l)" != '0' ]] && {
                        for _user in $(ls $_dir_users); do
                            piduser=$(ps -u "$_user" | grep sshd | cut -d? -f1)
                            kill -9 $piduser >/dev/null 2>&1
                            userdel --force "$_user" 2>/dev/null
                            grep -v ^$_user[[:space:]] /root/usuarios.db >/tmp/ph
                            cat /tmp/ph >/root/usuarios.db
                            rm /etc/bot/info-users/$_user
                        done
                    }
                    rm -rf /etc/bot/$_dirsts2/$_usub >/dev/null 2>&1
                    sed -i "/\b$_usub\b/d" $ativos
                    [[ $(grep -wc "$_usub" $suspensos) != '0' ]] && {
                        sed -i "/\b$_usub\b/d" $suspensos
                    }
                done <<<"$(grep -w 'SUBREVENDA' /etc/bot/$_dirsts/$_cli_rev/$_cli_rev)"
            }
            [[ "$(ls /etc/bot/$_dirsts/$_cli_rev/usuarios | wc -l)" != '0' ]] && {
                for _user in $(ls /etc/bot/$_dirsts/$_cli_rev/usuarios); do
                    piduser=$(ps -u "$_user" | grep sshd | cut -d? -f1)
                    kill -9 $piduser >/dev/null 2>&1
                    userdel --force "$_user" 2>/dev/null
                    grep -v ^$_user[[:space:]] /root/usuarios.db >/tmp/ph
                    cat /tmp/ph >/root/usuarios.db
                    rm /etc/bot/info-users/$_user
                done
            }
            rm -rf /etc/bot/$_dirsts/$_cli_rev >/dev/null 2>&1
            sed -i "/\b$_cli_rev\b/d" $ativos
            [[ $(grep -wc "$_cli_rev" $suspensos) != '0' ]] && {
                sed -i "/\b$_cli_rev\b/d" $suspensos
            }
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "REMOVIDO COM SUCESSO")" \
                --parse_mode html
            return 0
        } || {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e ❌ REVENDEDEDOR NAO EXISTE ❌)"
            return 0
        }
    } || {
        [[ "$(grep -wc "$_cli_rev" /etc/bot/revenda/${message_from_username}/${message_from_username})" != '0' ]] && {
            [[ -d /etc/bot/revenda/$_cli_rev ]] && {
                [[ "$(ls /etc/bot/revenda/$_cli_rev/usuarios | wc -l)" != '0' ]] && {
                    for _user in $(ls /etc/bot/revenda/$_cli_rev/usuarios); do
                        piduser=$(ps -u "$_user" | grep sshd | cut -d? -f1)
                        kill -9 $piduser >/dev/null 2>&1
                        userdel --force "$_user" 2>/dev/null
                        grep -v ^$_user[[:space:]] /root/usuarios.db >/tmp/ph
                        cat /tmp/ph >/root/usuarios.db
                        rm /etc/bot/info-users/$_user
                    done
                }
                rm -rf /etc/bot/revenda/$_cli_rev >/dev/null 2>&1
                sed -i "/\b$_cli_rev\b/d" $ativos
                sed -i "/\b$_cli_rev\b/d" /etc/bot/revenda/${message_from_username}/${message_from_username}
            }
            [[ -d /etc/bot/suspensos/$_cli_rev ]] && {
                [[ "$(ls /etc/bot/suspensos/$_cli_rev/usuarios | wc -l)" != '0' ]] && {
                    for _user in $(ls /etc/bot/suspensos/$_cli_rev/usuarios); do
                        piduser=$(ps -u "$_user" | grep sshd | cut -d? -f1)
                        kill -9 $piduser >/dev/null 2>&1
                        userdel --force "$_user" 2>/dev/null
                        grep -v ^$_user[[:space:]] /root/usuarios.db >/tmp/ph
                        cat /tmp/ph >/root/usuarios.db
                        rm /etc/bot/info-users/$_user
                    done
                }
                rm -rf /etc/bot/suspensos/$_cli_rev >/dev/null 2>&1
                sed -i "/\b$_cli_rev\b/d" $ativos
                sed -i "/\b$_cli_rev\b/d" $suspensos
                sed -i "/\b$_cli_rev\b/d" /etc/bot/revenda/${message_from_username}/${message_from_username}
            }
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "REMOVIDO COM SUCESSO")" \
                --parse_mode html
            return 0
        } || {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e ❌ REVENDEDEDOR NAO EXISTE ❌)"
            return 0
        }
    }
}

fun_lim_rev() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "♾ ALTERAR LIMITE REVENDA ♾\n\nInforme o user dele [Ex: @crazy_vpn]:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    }
}

lim_rev() {
    _file_lim=$1
    [[ -z "$_file_lim" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "Erro")"
        return 0
    }
    _rev_usern=$(grep -w 'Revendedor' $_file_lim | awk -F '@' {'print $2'})
    new_l=$(grep -w 'Limite' $_file_lim | awk {'print $2'})
    [[ -d /etc/bot/revenda/$_rev_usern ]] && {
        l_old=$(grep -w 'LIMITE_REVENDA' /etc/bot/revenda/$_rev_usern/$_rev_usern | awk {'print $2'})
        sed -i "/LIMITE_REVENDA/ s/$l_old/$new_l/g" /etc/bot/revenda/$_rev_usern/$_rev_usern
        sed -i "/$_rev_usern/ s/LIMITE: $l_old/LIMITE: $new_l/" $ativos
        [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
            sed -i "/\b$_rev_usern\b/ s/$l_old/$new_l/g" /etc/bot/revenda/${message_from_username}/${message_from_username}
        }
        echo $_rev_usern
    } || {
        l_old=$(grep -w 'LIMITE_REVENDA' /etc/bot/suspensos/$_rev_usern/$_rev_usern | awk {'print $2'})
        sed -i "/LIMITE_REVENDA/ s/$l_old/$new_l/g" /etc/bot/suspensos/$_rev_usern/$_rev_usern
        sed -i "/\b$_rev_usern\b/ s/LIMITE: $l_old/LIMITE: $new_l/" $ativos
        sed -i "/\b$_rev_usern\b/ s/LIMITE: $l_old/LIMITE: $new_l/" $suspensos
        [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
            sed -i "/\b$_rev_usern\b/ s/$l_old/$new_l/" /etc/bot/revenda/${message_from_username}/${message_from_username}
        }
        echo $_rev_usern
    }
}

fun_dat_rev() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "📆 ALTERAR DATA REVENDA 📆\n\nInforme o user dele [Ex: @crazy_vpn]:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    }
}

dat_rev() {
    _datfile=$1
    [[ -z "$_datfile" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "Erro")"
        _erro='1'
        return 0
    }
    _revd=$(grep -w 'Revendedor' $_datfile | cut -d'@' -f2)
    new_d=$(grep -w 'Data' $_datfile | awk '{print $NF}')
    [[ -d "/etc/bot/suspensos/$_revd" ]] && {
        [[ "$(ls /etc/bot/suspensos/$_revd/usuarios | wc -l)" != '0' ]] && {
            for _user in $(ls /etc/bot/suspensos/$_revd/usuarios); do
                usermod -U $_user
            done
        }
        d_old=$(grep -w 'DIAS_REVENDA' /etc/bot/suspensos/$_revd/$_revd | awk {'print $2'})
        sed -i "/\b$_revd\b/ s/DIAS: $d_old/DIAS: $new_d/" $ativos
        sed -i "/DIAS_REVENDA/ s/$d_old/$new_d/" /etc/bot/suspensos/$_revd/$_revd
        [[ "$(grep -wc 'SUBREVENDA' /etc/bot/suspensos/$_revd/$_revd)" != '0' ]] && {
            while read _listsub; do
                _usub="$(echo $_listsub | awk '{print $2}')"
                [[ "$(ls /etc/bot/suspensos/$_usub/usuarios | wc -l)" != '0' ]] && {
                    for _user in $(ls /etc/bot/suspensos/$_usub/usuarios); do
                        usermod -U $_user
                    done
                }
                mv /etc/bot/suspensos/$_usub /etc/bot/revenda/$_usub
                sed -i "/\b$_usub\b/d" $suspensos
            done <<<"$(grep -w 'SUBREVENDA' /etc/bot/suspensos/$_revd/$_revd)"
        }
        mv /etc/bot/suspensos/$_revd /etc/bot/revenda/$_revd
        sed -i "/\b$_revd\b/d" $suspensos
        sed -i "s;$new_d;$(date "+%d/%m/%Y" -d "+$new_d days");" $_datfile
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "⚠️ $_revd ESTAVA SUSPENSO E FOI REATIVADO !")" \
            --parse_mode html
    } || {
        d_old=$(grep -w 'DIAS_REVENDA' /etc/bot/revenda/$_revd/$_revd | awk {'print $2'})
        sed -i "/\b$_revd\b/ s/DIAS: $d_old/DIAS: $new_d/" $ativos
        sed -i "/DIAS_REVENDA/ s/$d_old/$new_d/" /etc/bot/revenda/$_revd/$_revd
        sed -i "s;$new_d;$(date "+%d/%m/%Y" -d "+$new_d days");" $_datfile
    }
}

fun_list_rev() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    if [[ "${callback_query_from_id[$id]}" == "$id_admin" ]]; then
        local msg1
        msg1="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n📃 LISTA DE REVENDEDORES !\n=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        [[ "$(grep -wc 'revenda' $ativos)" != '0' ]] && {
            while read _atvs; do
                _uativ="$(echo $_atvs | awk '{print $2}')"
                [[ "$(grep -wc "$_uativ" $suspensos)" == '0' ]] && _stsrev='ATIVO' || _stsrev='SUSPENSO'
                msg1+="• @$_uativ - $_stsrev\n"
            done <<<"$(grep -w 'revenda' /etc/bot/lista_ativos)"
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                --text "$(echo -e "$msg1")" \
                --parse_mode html
            return 0
        } || {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "VC NAO TEM REVENDEDORES"
            return 0
        }
    elif [[ "$(grep -w ${callback_query_from_username} $ativos | awk '{print $NF}')" == 'revenda' ]]; then
        _patch="/etc/bot/revenda"
        local msg1
        msg1="=×=×=×=×=×=×=×=×=×=×=×=×=\n📃 LISTA DE SUB REVENDEDORES !\n=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        [[ "$(grep -wc "SUBREVENDA" $_patch/${callback_query_from_username}/${callback_query_from_username})" != '0' ]] && {
            while read _listsub; do
                _usub="$(echo $_listsub | awk '{print $2}')"
                [[ "$(grep -wc "$_usub" $suspensos)" == '0' ]] && _usts='ATIVO' || _usts='SUSPENSO'
                msg1+="• @$_usub - $_usts\n"
            done <<<"$(grep -w 'SUBREVENDA' $_patch/${callback_query_from_username}/${callback_query_from_username})"
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                --text "$(echo -e "$msg1")" \
                --parse_mode html
            return 0
        } || {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "VC NAO TEM SUB REVENDEDORES"
            return 0
        }
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    fi
}

fun_susp_rev() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "🔒 SUSPENDER REVENDEDOR 🔒\n\nInforme o user dele [Ex: @crazy_vpn]:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    }
}

susp_rev() {
    _revs=$1
    [[ -z "$_revs" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "Erro")"
        return 0
    }
    [[ -d "/etc/bot/suspensos/$_revs" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "O USUARIO JA ESTA SUSPENSO !")" \
            --parse_mode html
        return 0
    }
    [[ ! -d "/etc/bot/revenda/$_revs" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "O USUARIO NAO EXISTE !")" \
            --parse_mode html
        return 0
    }
    [[ "${message_from_id[$id]}" == "$id_admin" ]] && {
        [[ "$(grep -wc 'SUBREVENDA' /etc/bot/revenda/$_revs/$_revs)" != '0' ]] && {
            while read _listsub3; do
                _usub3="$(echo $_listsub3 | awk '{print $2}')"
                _dir_users="/etc/bot/revenda/$_usub3/usuarios"
                [[ "$(ls $_dir_users | wc -l)" != '0' ]] && {
                    for _user in $(ls $_dir_users); do
                        usermod -L $_user
                        pkill -f $_user
                    done
                }
                mv /etc/bot/revenda/$_usub3 /etc/bot/suspensos/$_usub3
                grep -w "$_usub3" $ativos >>$suspensos
            done <<<"$(grep -w 'SUBREVENDA' /etc/bot/revenda/$_revs/$_revs)"
        }
        [[ "$(ls /etc/bot/revenda/$_revs/usuarios | wc -l)" != '0' ]] && {
            for _user_ in $(ls /etc/bot/revenda/$_revs/usuarios); do
                usermod -L $_user_
                pkill -f $_user_
            done
        }
        mv /etc/bot/revenda/$_revs /etc/bot/suspensos/$_revs
        grep -w "$_revs" $ativos >>$suspensos
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "SUSPENDIDO COM SUCESSO")" \
            --parse_mode html
        return 0
    } || {
        [[ "$(grep -wc "$_revs" /etc/bot/revenda/${message_from_username}/${message_from_username})" != '0' ]] && {
            [[ "$(ls /etc/bot/revenda/$_revs/usuarios | wc -l)" != '0' ]] && {
                for _user_ in $(ls /etc/bot/revenda/$_revs/usuarios); do
                    usermod -L $_user_
                    pkill -f $_user_
                done
            }
            mv /etc/bot/revenda/$_revs /etc/bot/suspensos/$_revs
            grep -w "$_revs" $ativos >>$suspensos
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "SUSPENDIDO COM SUCESSO")" \
                --parse_mode html
            return 0
        } || {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "O SUB REVENDEDOR NAO EXISTE")" \
                --parse_mode html
            return 0
        }
    }
}

fun_menurevenda() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "SELECIONE UMA OPÇÃO ABAIXO:" \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'menu4')"
        return 0
    }
}

# LISTA MENU ADMIN
unset menu1
menu1=''
ShellBot.InlineKeyboardButton --button 'menu1' --line 1 --text 'CRIAR USUARIO' --callback_data '_criaruser'
ShellBot.InlineKeyboardButton --button 'menu1' --line 2 --text 'CRIAR TESTE' --callback_data '_criarteste'
ShellBot.InlineKeyboardButton --button 'menu1' --line 3 --text 'REMOVER' --callback_data '_deluser'
ShellBot.InlineKeyboardButton --button 'menu1' --line 4 --text 'ALTERAR SENHA' --callback_data '_altsenha'
ShellBot.InlineKeyboardButton --button 'menu1' --line 5 --text 'ALTERAR LIMITE' --callback_data '_altlimite'
ShellBot.InlineKeyboardButton --button 'menu1' --line 6 --text 'ALTERAR DATA' --callback_data '_altdata'
ShellBot.InlineKeyboardButton --button 'menu1' --line 7 --text 'USUARIOS ONLINE' --callback_data '_monitor'
ShellBot.InlineKeyboardButton --button 'menu1' --line 8 --text 'INFO USUARIOS' --callback_data '_verusers'
ShellBot.InlineKeyboardButton --button 'menu1' --line 9 --text 'EXPIRADOS' --callback_data '_expirados'
ShellBot.InlineKeyboardButton --button 'menu1' --line 1 --text 'INFO VPS' --callback_data '_infovps'
ShellBot.InlineKeyboardButton --button 'menu1' --line 2 --text 'OTIMIZAR' --callback_data '_otimizar'
ShellBot.InlineKeyboardButton --button 'menu1' --line 3 --text 'ARQUIVOS' --callback_data '_arqdown'
ShellBot.InlineKeyboardButton --button 'menu1' --line 4 --text 'REVENDA' --callback_data '_opcoesrev'
ShellBot.InlineKeyboardButton --button 'menu1' --line 5 --text 'SPEEDTESTE' --callback_data '_speedteste'
ShellBot.InlineKeyboardButton --button 'menu1' --line 6 --text 'BACKUP USUARIOS' --callback_data '_backupusers'
ShellBot.InlineKeyboardButton --button 'menu1' --line 7 --text "ALTO BACKUP" --callback_data '_autobkp'
ShellBot.InlineKeyboardButton --button 'menu1' --line 8 --text 'RELATORIO' --callback_data '_relatorio'
ShellBot.InlineKeyboardButton --button 'menu1' --line 9 --text 'AJUDA' --callback_data '_ajuda'
ShellBot.regHandleFunction --function fun_adduser --callback_data _criaruser
ShellBot.regHandleFunction --function fun_add_teste --callback_data _criarteste
ShellBot.regHandleFunction --function fun_deluser --callback_data _deluser
ShellBot.regHandleFunction --function alterar_senha --callback_data _altsenha
ShellBot.regHandleFunction --function alterar_limite --callback_data _altlimite
ShellBot.regHandleFunction --function alterar_data --callback_data _altdata
ShellBot.regHandleFunction --function fun_down --callback_data _arqdown
ShellBot.regHandleFunction --function monitor_ssh --callback_data _monitor
ShellBot.regHandleFunction --function ver_users --callback_data _verusers
ShellBot.regHandleFunction --function fun_exp_user --callback_data _expirados
ShellBot.regHandleFunction --function otimizer --callback_data _otimizar
ShellBot.regHandleFunction --function speed_test --callback_data _speedteste
ShellBot.regHandleFunction --function infovps --callback_data _infovps
ShellBot.regHandleFunction --function backup_users --callback_data _backupusers
ShellBot.regHandleFunction --function fun_backauto --callback_data _autobkp
ShellBot.regHandleFunction --function relatorio_rev --callback_data _relatorio
ShellBot.regHandleFunction --function fun_ajuda --callback_data _ajuda
ShellBot.regHandleFunction --function fun_menurevenda --callback_data _opcoesrev
unset keyboard1
keyboard1="$(ShellBot.InlineKeyboardMarkup -b 'menu1')"

# LISTA MENU REVENDEDOR
unset menu2
menu2=''
ShellBot.InlineKeyboardButton --button 'menu2' --line 1 --text 'CRIAR USUARIO' --callback_data '_criaruser2'
ShellBot.InlineKeyboardButton --button 'menu2' --line 1 --text 'CRIAR TESTE' --callback_data '_criarteste2'
ShellBot.InlineKeyboardButton --button 'menu2' --line 2 --text 'REMOVER' --callback_data '_deluser2'
ShellBot.InlineKeyboardButton --button 'menu2' --line 2 --text 'USUARIOS ONLINE' --callback_data '_monitor2'
ShellBot.InlineKeyboardButton --button 'menu2' --line 3 --text 'ALTERAR LIMITE' --callback_data '_altlimite2'
ShellBot.InlineKeyboardButton --button 'menu2' --line 3 --text 'INFO USUARIOS' --callback_data '_verusers2'
ShellBot.InlineKeyboardButton --button 'menu2' --line 4 --text 'ALTERAR SENHA' --callback_data '_altsenha2'
ShellBot.InlineKeyboardButton --button 'menu2' --line 4 --text 'EXPIRADOS' --callback_data '_expirados2'
ShellBot.InlineKeyboardButton --button 'menu2' --line 5 --text 'ALTERAR DATA' --callback_data '_altdata2'
ShellBot.InlineKeyboardButton --button 'menu2' --line 5 --text 'REVENDA' --callback_data '_opcoesrev2'
ShellBot.InlineKeyboardButton --button 'menu2' --line 6 --text 'RELATORIO' --callback_data '_relatorio2'
ShellBot.InlineKeyboardButton --button 'menu2' --line 6 --text 'AJUDA' --callback_data '_ajuda2'
ShellBot.regHandleFunction --function fun_adduser --callback_data _criaruser2
ShellBot.regHandleFunction --function fun_add_teste --callback_data _criarteste2
ShellBot.regHandleFunction --function fun_deluser --callback_data _deluser2
ShellBot.regHandleFunction --function alterar_senha --callback_data _altsenha2
ShellBot.regHandleFunction --function alterar_limite --callback_data _altlimite2
ShellBot.regHandleFunction --function alterar_data --callback_data _altdata2
ShellBot.regHandleFunction --function monitor_ssh --callback_data _monitor2
ShellBot.regHandleFunction --function ver_users --callback_data _verusers2
ShellBot.regHandleFunction --function fun_exp_user --callback_data _expirados2
ShellBot.regHandleFunction --function relatorio_rev --callback_data _relatorio2
ShellBot.regHandleFunction --function fun_menurevenda --callback_data _opcoesrev2
ShellBot.regHandleFunction --function fun_ajuda --callback_data _ajuda2
unset keyboard2
keyboard2="$(ShellBot.InlineKeyboardMarkup -b 'menu2')"

#LISTA MUNU SUB REVENDEDOR
unset menu3
menu3=''
ShellBot.InlineKeyboardButton --button 'menu3' --line 1 --text 'CRIAR USUARIO' --callback_data '_criaruser3'
ShellBot.InlineKeyboardButton --button 'menu3' --line 1 --text 'CRIAR TESTE' --callback_data '_criarteste3'
ShellBot.InlineKeyboardButton --button 'menu3' --line 2 --text 'REMOVER' --callback_data '_deluser3'
ShellBot.InlineKeyboardButton --button 'menu3' --line 2 --text 'USUARIOS ONLINE' --callback_data '_monitor3'
ShellBot.InlineKeyboardButton --button 'menu3' --line 3 --text 'ALTERAR LIMITE' --callback_data '_altlimite3'
ShellBot.InlineKeyboardButton --button 'menu3' --line 3 --text 'INFO USUARIOS' --callback_data '_verusers3'
ShellBot.InlineKeyboardButton --button 'menu3' --line 4 --text 'ALTERAR SENHA' --callback_data '_altsenha3'
ShellBot.InlineKeyboardButton --button 'menu3' --line 4 --text 'EXPIRADOS' --callback_data '_expirados3'
ShellBot.InlineKeyboardButton --button 'menu3' --line 5 --text 'ALTERAR DATA' --callback_data '_altdata3'
ShellBot.InlineKeyboardButton --button 'menu3' --line 5 --text 'AJUDA' --callback_data '_ajuda3'
ShellBot.regHandleFunction --function fun_adduser --callback_data _criaruser3
ShellBot.regHandleFunction --function fun_add_teste --callback_data _criarteste3
ShellBot.regHandleFunction --function fun_deluser --callback_data _deluser3
ShellBot.regHandleFunction --function alterar_senha --callback_data _altsenha3
ShellBot.regHandleFunction --function alterar_limite --callback_data _altlimite3
ShellBot.regHandleFunction --function alterar_data --callback_data _altdata3
ShellBot.regHandleFunction --function monitor_ssh --callback_data _monitor3
ShellBot.regHandleFunction --function ver_users --callback_data _verusers3
ShellBot.regHandleFunction --function fun_exp_user --callback_data _expirados3
ShellBot.regHandleFunction --function fun_ajuda --callback_data _ajuda3
unset keyboard3
keyboard3="$(ShellBot.InlineKeyboardMarkup -b 'menu3')"

#LISTA MENU OPCOES REVENDA
unset menu4
menu4=''
ShellBot.InlineKeyboardButton --button 'menu4' --line 1 --text 'ADICIONAR REVENDA' --callback_data '_addrev'
ShellBot.InlineKeyboardButton --button 'menu4' --line 2 --text 'REMOVER REVENDA' --callback_data '_delrev'
ShellBot.InlineKeyboardButton --button 'menu4' --line 3 --text 'ALTERAR LIMITE REVENDA' --callback_data '_limrev'
ShellBot.InlineKeyboardButton --button 'menu4' --line 4 --text 'ALTERAR DATA REVENDA' --callback_data '_datrev'
ShellBot.InlineKeyboardButton --button 'menu4' --line 5 --text 'LISTAR REVENDA' --callback_data '_listrev'
ShellBot.InlineKeyboardButton --button 'menu4' --line 6 --text 'SUSPENDER REVENDA' --callback_data '_susprevendas'
ShellBot.regHandleFunction --function fun_add_revenda --callback_data _addrev
ShellBot.regHandleFunction --function fun_del_rev --callback_data _delrev
ShellBot.regHandleFunction --function fun_lim_rev --callback_data _limrev
ShellBot.regHandleFunction --function fun_dat_rev --callback_data _datrev
ShellBot.regHandleFunction --function fun_list_rev --callback_data _listrev
ShellBot.regHandleFunction --function fun_susp_rev --callback _susprevendas
unset keyboard4
keyboard4="$(ShellBot.InlineKeyboardMarkup -b 'menu4')"

while :; do
    [[ -e "/etc/SSHPlus/backups/backup.vps" ]] && {
        backup_auto
    }
    #Obtem as atualizações
    ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 35
    #Lista o índice das atualizações
    for id in $(ShellBot.ListUpdates); do
        #Inicio thread
        (
            ShellBot.watchHandle --callback_data ${callback_query_data[$id]}
            # Requisições somente no privado.
            [[ ${message_chat_type[$id]} != 'private' ]] && continue
            CAD_ARQ=/tmp/cad.${message_from_id[$id]}
            if [[ ${message_entities_type[$id]} == bot_command ]]; then
                #Verifica se a mensagem enviada pelo usuário é um comando válido.
                case ${message_text[$id]} in
                *)
                    :
                    #comandos
                    comando=(${message_text[$id]})
                    [[ "${comando[0]}" = "start" || "${comando[0]}" = "/start" ]] && msg_bem_vindo
                    [[ "${comando[0]}" = "menu" || "${comando[0]}" = "/menu" ]] && fun_menu
                    [[ "${comando[0]}" = "16" || "${comando[0]}" = "/ajuda" ]] && fun_ajuda
                    [[ "${comando[0]}" = "/bot" || "${comando[0]}" = "/sobre" ]] && sobremim
                    ;;
                esac
            fi
            if [[ ${message_reply_to_message_message_id[$id]} ]]; then
                # Analisa a interface de resposta.
                case ${message_reply_to_message_text[$id]} in
                '👤 CRIAR USUARIO 👤\n\nNome do usuario:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ "$(awk -F : '$3 >= 1000 { print $1 }' /etc/passwd | grep -w ${message_text[$id]} | wc -l)" != '0' ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro! USUARIO INVALIDO ❌\n\n⚠️ Informe Outro Nome..")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    [ "${message_text[$id]}" == 'root' ] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ ERRO! USUARIO INVALIDO ❌\n\n⚠️ Informe Outro Nome..")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    sizemin=$(echo -e ${#message_text[$id]})
                    [[ "$sizemin" -lt '4' ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro !\n\nUse no mínimo 4 caracteres\n[EX: test]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    sizemax=$(echo -e ${#message_text[$id]})
                    [[ "$sizemax" -gt '10' ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro !\n\nUse no maximo 8 caracteres\n[EX: crazy]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    echo "Nome: ${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Senha:' \
                        --reply_markup "$(ShellBot.ForceReply)" # Força a resposta.
                    ;;
                'Senha:')
                    sizepass=$(echo -e ${#message_text[$id]})
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ "$sizepass" -lt '4' ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro !\n\nUse no mínimo 4 caracteres\n[EX: 1234]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    echo "Senha: ${message_text[$id]}" >>$CAD_ARQ
                    # Próximo campo.
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Limite:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Limite:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro ! \n\nUltilize apenas numeros [EX: 1]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
                        _limTotal=$(grep -w "${message_from_username}" $ativos | awk '{print $4}')
                        fun_verif_limite_rev ${message_from_username}
                        _limsomarev2=$(echo "$_result + ${message_text[$id]}" | bc)
                        [[ "$_limsomarev2" -gt "$_limTotal" ]] && {
                            _restant1=$(($_limTotal - $_result))
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Vc nao tem limite suficiente\n\nLimite disponivel: $_restant1 ")" \
                                --parse_mode html
                            >$CAD_ARQ
                            break
                        }
                    }
                    echo "Limite: ${message_text[$id]}" >>$CAD_ARQ
                    # Próximo campo.
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Validade em dias: ' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;

                'Validade em dias:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro ! \n\nUltilize apenas numeros [EX: 30]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    info_data=$(date '+%d/%m/%C%y' -d " +${message_text[$id]} days")
                    echo "Validade: $info_data" >>$CAD_ARQ
                    criar_user $CAD_ARQ
                    [[ "(grep -w ${message_text[$id]} /etc/passwd)" = '0' ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e ❌ Erro ao criar usuario !)" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    [[ "$(ls /etc/bot/arquivos | wc -l)" != '0' ]] && {
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text '📥 ARQUIVOS DISPONIVEIS 📥\n\nDeseja baixar? Sim ou Nao?:' \
                            --reply_markup "$(ShellBot.ForceReply)"
                    } || {
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text "<b>✅ CRIADO COM SUCESSO ✅</b>\n\nIP: $(cat /etc/IP)\nUSUARIO: <code>$(awk -F " " '/Nome/ {print $2}' $CAD_ARQ)</code>\nSENHA: <code>$(awk -F " " '/Senha/ {print $2}' $CAD_ARQ)</code>\nLIMITE: $(awk -F " " '/Limite/ {print $2}' $CAD_ARQ)\nEXPIRA EM: $(awk -F " " '/Validade/ {print $2}' $CAD_ARQ)" \
                            --parse_mode html
                        break
                    }
                    ;;
                '📥 ARQUIVOS DISPONIVEIS 📥\n\nDeseja baixar? Sim ou Nao?:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([A-Za-z]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Opcao Invalida ❌\n\n⚠️ Ultilize apenas letras [EX: sim ou nao]")" \
                            --parse_mode html
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text "<b>✅ CRIADO COM SUCESSO ✅</b>\n\nIP: $(cat /etc/IP)\nUSUARIO: <code>$(awk -F " " '/Nome/ {print $2}' $CAD_ARQ)</code>\nSENHA: <code>$(awk -F " " '/Senha/ {print $2}' $CAD_ARQ)</code>\nLIMITE: $(awk -F " " '/Limite/ {print $2}' $CAD_ARQ)\nEXPIRA EM: $(awk -F " " '/Validade/ {print $2}' $CAD_ARQ)" \
                            --parse_mode html
                        break
                    }
                    [[ "${message_text[$id]}" = @(Sim|sim|SIM) ]] && {
                        msg_cli="≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠\n"
                        msg_cli+="<b>ARQUIVOS PRE-CONFIGURADOS </b>❗\n"
                        msg_cli+="≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠\n\n"
                        for _file in $(ls /etc/bot/arquivos); do
                            i=$(($i + 1))
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
                            --text "<b>✅ CRIADO COM SUCESSO ✅</b>\n\nIP: $(cat /etc/IP)\nUSUARIO: <code>$(awk -F " " '/Nome/ {print $2}' $CAD_ARQ)</code>\nSENHA: <code>$(awk -F " " '/Senha/ {print $2}' $CAD_ARQ)</code>\nLIMITE: $(awk -F " " '/Limite/ {print $2}' $CAD_ARQ)\nEXPIRA EM: $(awk -F " " '/Validade/ {print $2}' $CAD_ARQ)" \
                            --parse_mode html
                    }
                    ;;
                'Informe o Numero do Arquivo:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Opcao Invalida ❌ \n\n⚠️ Ultilize apenas numeros [EX: 1]")" \
                            --parse_mode html
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text "<b>✅ CRIADO COM SUCESSO ✅</b>\n\nIP: $(cat /etc/IP)\nUSUARIO: <code>$(awk -F " " '/Nome/ {print $2}' $CAD_ARQ)</code>\nSENHA: <code>$(awk -F " " '/Senha/ {print $2}' $CAD_ARQ)</code>\nLIMITE: $(awk -F " " '/Limite/ {print $2}' $CAD_ARQ)\nEXPIRA EM: $(awk -F " " '/Validade/ {print $2}' $CAD_ARQ)" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    fun_download ${message_text[$id]} $CAD_ARQ
                    # Limpa o arquivo temporário.
                    >$CAD_ARQ
                    break
                    ;;
                '🗑 REMOVER USUARIO 🗑\n\nNome do usuario:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    fun_del_user ${message_text[$id]}
                    [[ "$_erro" == '1' ]] && break
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "✅ *Removido com sucesso.* 🚮" \
                        --parse_mode markdown
                    ;;
                '🔐 Alterar Senha 🔐\n\nNome do usuario:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    fun_verif_user ${message_text[$id]}
                    [[ "$_erro" == '1' ]] && break
                    echo "${message_text[$id]}" >/tmp/name-s
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Nova senha:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Nova senha:')
                    sizepass=$(echo -e ${#message_text[$id]})
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ "$sizepass" -lt '4' ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro !\n\n⚠️ Use mínimo 4 caracteres [EX: 1234]")" \
                            --parse_mode html
                        break
                    }
                    alterar_senha_user $(cat /tmp/name-s) ${message_text[$id]}
                    [[ "$_erro" == '1' ]] && break
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "$(echo -e "=×=×=×=×=×=×=×=×=×=×=×\n<b>✅ SENHA ALTERADA !</b> !\n=×=×=×=×=×=×=×=×=×=×=×\n\n<b>Usuario:</b> $(cat /tmp/name-s)\n<b>Nova senha:</b> ${message_text[$id]}")" \
                        --parse_mode html
                    rm /tmp/name-s >/dev/null 2>&1
                    ;;
                '👥 Alterar Limite 👥\n\nNome do usuario:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    echo $_erro segundo
                    fun_verif_user ${message_text[$id]}
                    echo "$_erro"
                    [[ "$_erro" == '1' ]] && break
                    echo "${message_text[$id]}" >/tmp/name-l
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Novo limite:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Novo limite:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro ! \n\n⚠️ Ultilize apenas numeros [EX: 1]")" \
                            --parse_mode html
                        break
                    }
                    alterar_limite_user $(cat /tmp/name-l) ${message_text[$id]}
                    [[ "$_erro" == '1' ]] && break
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "$(echo -e "=×=×=×=×=×=×=×=×=×=×=×\n<b>✅ LIMITE ALTERADO !</b> !\n=×=×=×=×=×=×=×=×=×=×=×\n\n<b>Usuario:</b> $(cat /tmp/name-l)\n<b>Novo Limite:</b> ${message_text[$id]}")" \
                        --parse_mode html
                    rm /tmp/name-l >/dev/null 2>&1
                    ;;
                '⏳ Alterar Data ⏳\n\nNome do usuario:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    fun_verif_user ${message_text[$id]}
                    [[ "$_erro" == '1' ]] && break
                    echo "${message_text[$id]}" >/tmp/name-d
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'informe os dias ou data:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'informe os dias ou data:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([0-9/]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro! Siga o exemplo\n\nDias formato [EX: 30]\nData formato [EX: 30/12/2019]")" \
                            --parse_mode html
                        break
                    }
                    alterar_data_user $(cat /tmp/name-d) ${message_text[$id]}
                    [[ "$_erro" == '1' ]] && break
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "$(echo -e "=×=×=×=×=×=×=×=×=×=×=×\n<b>✅ DATA ALTERADA !</b> !\n=×=×=×=×=×=×=×=×=×=×=×\n\n<b>Usuario:</b> $(cat /tmp/name-d)\n<b>Nova Data:</b> $udata")" \
                        --parse_mode html
                    rm /tmp/name-d >/dev/null 2>&1
                    ;;
                '[1] - ADICIONAR ARQUIVO\n[2] - EXCLUIR ARQUIVO\n\nInforme a opcao [1-2]:')
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro ! \n\n⚠️ Ultilize apenas numeros [EX: 1 ou 2]")" \
                            --parse_mode html
                        break
                    }
                    if [[ "${message_text[$id]}" = '1' ]]; then
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text "📤 HOSPEDAR ARQUIVOS 📤\n\nEnvie-me o arquivo:" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    elif [[ "${message_text[$id]}" = '2' ]]; then
                        [[ $(ls /etc/bot/arquivos | wc -l) != '0' ]] && {
                            msg_cli1="≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠\n"
                            msg_cli1+="🚀<b> ARQUIVOS HOSPEDADOS </b>\n"
                            msg_cli1+="≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠\n\n"
                            for _file in $(ls /etc/bot/arquivos); do
                                i=$(($i + 1))
                                msg_cli1+="<b>[$i]</b> - $_file\n"
                            done
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "$msg_cli1")" \
                                --parse_mode html
                            ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                                --text "Excluir Arquivo\nInforme o Numero do Arquivo:" \
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
                        [[ ${message_document_file_id[$id]} ]] && file_id=${message_document_file_id[$id]} && download_file=1
                        # Verifica se o download está ativado.
                        [[ $download_file -eq 1 ]] && {
                            file_id=($file_id)
                            ShellBot.getFile --file_id "${file_id[0]}"
                            ShellBot.downloadFile --file_path ${return[file_path]} --dir "/tmp/file" && {
                                msg='*✅ Arquivo hospedado com sucesso.*\n\n'
                                msg+="*📤 Informações*\n\n"
                                msg+="*Nome*: ${message_document_file_name}\n"
                                msg+="*Salvo em*: /etc/bot/arquivos"
                                ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                    --text "$(echo -e "$msg")" \
                                    --parse_mode markdown
                                mv /tmp/file/$(ls -1rt /tmp/file | tail -n1) /etc/bot/arquivos/${message_document_file_name}
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
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    echo "Nome: ${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Informe o user dele [Ex: @crazy_vpn]:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Informe o user dele [Ex: @crazy_vpn]:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    _VAR1=$(echo -e ${message_text[$id]} | awk -F '@' {'print $2'})
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
                    echo "User: ${message_text[$id]}" >>$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Quantas SSH ele pode criar:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Quantas SSH ele pode criar:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro ! \n\n⚠️ Ultilize apenas numeros [EX: 10]")" \
                            --parse_mode html
                        break
                    }
                    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
                        _limTotal=$(grep -w "${message_from_username}" $ativos | awk '{print $4}')
                        fun_verif_limite_rev ${message_from_username}
                        _limsomarev=$(echo "$_result + ${message_text[$id]}" | bc)
                        [[ "$_limsomarev" -gt "$_limTotal" ]] && {
                            _restant1=$(($_limTotal - $_result))
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Vc nao tem limite suficiente\n\nLimite disponivel: $_restant1 ")" \
                                --parse_mode html
                            break
                        }
                    }
                    echo "Limite: ${message_text[$id]}" >>$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Quantos dias de acesso:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Quantos dias de acesso:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    echo "Validade: ${message_text[$id]}" >>$CAD_ARQ
                    _clientrev=$(cat $CAD_ARQ)
                    criar_rev $CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "✅ Criado com sucesso. ✅\n\n$(<$CAD_ARQ)\n\nBOT: @${message_reply_to_message_from_username}" \
                        --parse_mode html
                    ;;
                    # REMOVE REVENDEDOR
                '🗑 REMOVER REVENDEDOR 🗑\n\nInforme o user dele [Ex: @crazy_vpn]:')
                    echo -e "${message_text[$id]}" >$CAD_ARQ
                    _Var=$(sed -n '1 p' $CAD_ARQ | awk -F '@' {'print $2'})
                    [[ -z $_Var ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ User invalido")" \
                            --parse_mode html
                        break
                    }
                    del_rev $_Var
                    break
                    ;;
                    # ALTERAR LIMITE
                '♾ ALTERAR LIMITE REVENDA ♾\n\nInforme o user dele [Ex: @crazy_vpn]:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    echo -e "Revendedor: ${message_text[$id]}" >$CAD_ARQ
                    _Var1=$(sed -n '1 p' $CAD_ARQ | awk -F '@' {'print $2'})
                    [[ -z $_Var1 ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Nome invalido !")" \
                            --parse_mode html
                        break
                    }
                    [[ "${message_from_id[$id]}" == "$id_admin" ]] && {
                        [[ $(grep -wc $_Var1 $ativos) != '0' ]] && {
                            ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                                --text 'Informe o Limite SSH:' \
                                --reply_markup "$(ShellBot.ForceReply)"
                        } || {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Revendedor ${message_text[$id]} nao existe")" \
                                --parse_mode html
                            break
                        }
                    }
                    [[ $(grep -w ${message_from_username} $ativos | awk '{print $NF}') == 'revenda' ]] && {
                        [[ "$(grep -wc "$_Var1" /etc/bot/revenda/${message_from_username}/${message_from_username})" != '0' ]] && {
                            ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                                --text 'Informe o Limite SSH:' \
                                --reply_markup "$(ShellBot.ForceReply)"
                        } || {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ O Sub-revendedor nao existe")" \
                                --parse_mode html
                            break
                        }
                    }
                    ;;
                'Informe o Limite SSH:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro ! \n\nUltilize apenas numeros [EX: 1]")" \
                            --parse_mode html
                        break
                    }
                    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
                        _limTotal=$(grep -w "${message_from_username}" $ativos | awk '{print $4}')
                        fun_verif_limite_rev ${message_from_username}
                        _limsomarev=$(echo "$_result + ${message_text[$id]}" | bc)

                        [[ $(grep -wc 'SUBREVENDA' /etc/bot/revenda/${message_from_username}/${message_from_username}) != '0' ]] && {
                            _limsomarev2=$(echo "$(grep -w 'SUBREVENDA' /etc/bot/revenda/${message_from_username}/${message_from_username} | awk {'print $4'} | paste -s -d + | bc)" + "${message_text[$id]}" | bc)
                        } || {
                            _limsomarev2='0'
                        }
                        [[ "$_limsomarev2" -ge "$_limTotal" ]] && {
                            echo $_limsomarev2
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Vc nao tem limite suficiente")" \
                                --parse_mode html
                            break
                        }
                        [[ "$_limsomarev" -gt "$_limTotal" ]] && {
                            [[ "$_limTotal" == "$(($_limTotal - $_result))" ]] && _restant1='0' || _restant1=$(($_limTotal - $_result))
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Vc nao tem limite suficiente\n\nLimite restante: $_restant1 ")" \
                                --parse_mode html
                            break
                        }
                    }
                    echo -e "Limite: ${message_text[$id]}" >>$CAD_ARQ
                    lim_rev $CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "$(echo -e "=×=×=×=×=×=×=×=×=×=×=×\n<b>✅ LIMITE REVENDA ALTERADO !</b> !\n=×=×=×=×=×=×=×=×=×=×=×\n\n$(<$CAD_ARQ)")" \
                        --parse_mode html
                    # ALTERAR DATA
                    ;;
                '📆 ALTERAR DATA REVENDA 📆\n\nInforme o user dele [Ex: @crazy_vpn]:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    _VAR1=$(echo -e ${message_text[$id]} | awk -F '@' {'print $2'})
                    [[ -z $_VAR1 ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "Revendedor ${message_text[$id]} nao existe")" \
                            --parse_mode html
                        break
                    }
                    if [[ -d /etc/bot/revenda/$_VAR1 ]]; then
                        echo -e "Revendedor: ${message_text[$id]}" >$CAD_ARQ
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text 'Dias de acesso [Ex: 30]:' \
                            --reply_markup "$(ShellBot.ForceReply)"
                    elif [[ -d /etc/bot/suspensos/$_VAR1 ]]; then
                        echo -e "Revendedor: ${message_text[$id]}" >$CAD_ARQ
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
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro ! \n\nUltilize apenas numeros [EX: 30]")" \
                            --parse_mode html
                        break
                    }
                    echo -e "Data: ${message_text[$id]}" >>$CAD_ARQ
                    dat_rev $CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "$(echo -e "=×=×=×=×=×=×=×=×=×=×=×\n<b>✅ DATA REVENDA ALTERADA !</b> !\n=×=×=×=×=×=×=×=×=×=×=×\n\n$(<$CAD_ARQ)")" \
                        --parse_mode html
                    ;;
                    # SUSPENDER REVENDEDOR
                '🔒 SUSPENDER REVENDEDOR 🔒\n\nInforme o user dele [Ex: @crazy_vpn]:')
                    _VAR1=$(echo -e ${message_text[$id]} | awk -F '@' {'print $2'})
                    [[ -z $_VAR1 ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Revendedor ${message_text[$id]} nao existe")" \
                            --parse_mode html
                        break
                    }
                    susp_rev $_VAR1
                    break
                    ;;
                '👤 CRIAR TESTE 👤\n\nQuantas horas deve durar EX: 1:')
                    verifica_acesso
                    echo $_erro
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro ! \n\nUltilize apenas numeros [EX: 1]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
                        _limTotal=$(grep -w "${message_from_username}" $ativos | awk '{print $4}')
                        fun_verif_limite_rev ${message_from_username}
                        _limsomarev2=$(echo "$_result + 1" | bc)
                        [[ "$_limsomarev2" -gt "$_limTotal" ]] && {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Vc nao tem limite suficiente")" \
                                --parse_mode html
                            >$CAD_ARQ
                            break
                        }
                    }
                    fun_teste ${message_text[$id]}
                    ;;
                esac
            fi
        ) &
    done
done
#FIM
