#!/bin/bash
#===================================================
#	SCRIPT: BOT SSHPLUS MANAGER
#   DATA ATT:   05 de Set 2020
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
    [[ "${message_from_id[$id]}" == "$id_admin" ]] && {
        local env_msg
        env_msg="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n"
        env_msg+="<b>SEJA BEM VINDO(a) AO BOT SSHPLUS</b>\n"
        env_msg+="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n\n"
        env_msg+="‚ö†Ô∏è <i>SELECIONE UMA OPCAO ABAIXO !</i>\n\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "$env_msg" \
            --reply_markup "$keyboard1" \
            --parse_mode html
        return 0
    }
    [[ -d /etc/bot/suspensos/${message_from_username} ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "üö´ VC ESTA SUSPENSO üö´\n\nCONTATE O ADMINISTRADOR")"
        return 0
    }
    if [[ "$(grep -w "${message_from_username}" $ativos | grep -wc 'revenda')" != '0' ]]; then
        local env_msg
        env_msg="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n"
        env_msg+="<b>SEJA BEM VINDO(a) AO BOT SSHPLUS</b>\n"
        env_msg+="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n\n"
        env_msg+="‚ö†Ô∏è <i>SELECIONE UMA OPCAO ABAIXO !</i>\n\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "$env_msg" \
            --reply_markup "$keyboard2" \
            --parse_mode html
        return 0
    elif [[ "$(grep -w "${message_from_username}" $ativos | grep -wc 'subrevenda')" != '0' ]]; then
        local env_msg
        env_msg="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n"
        env_msg+="<b>SEJA BEM VINDO(a) AO BOT SSHPLUS</b>\n"
        env_msg+="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n\n"
        env_msg+="‚ö†Ô∏è <i>SELECIONE UMA OPCAO ABAIXO !</i>\n\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "$env_msg" \
            --reply_markup "$keyboard3" \
            --parse_mode html
        return 0
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e üö´ ACESSO NEGADO üö´)"
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
        env_msg="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n"
        env_msg+="<b>BEM VINDO(a) AO BOT SSHPLUS</b>\n"
        env_msg+="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n\n"
        env_msg+="‚ö†Ô∏è <i>Comandos Disponiveis</i>\n\n"
        env_msg+="[<b>01</b>] /menu = Exibe menu\n"
        env_msg+="[<b>02</b>] /info = Exibe informacoes\n"
        env_msg+="[<b>03</b>] /ajuda = Informacoes sobre opcoes\n\n"
        env_msg+="‚ö†Ô∏è <i>Op√ß√µes Disponiveis</i>\n\n"
        env_msg+="‚Ä¢ <u>CRIAR USUARIO</u> = Cria usuario ssh\n\n"
        env_msg+="‚Ä¢ <u>CRIAR TESTE</u> = Cria teste ssh\n\n"
        env_msg+="‚Ä¢ <u>REMOVER</u> = Remove usuario ssh\n\n"
        env_msg+="‚Ä¢ <u>INFO USUARIOS</u> = Informacoes do usuario\n\n"
        env_msg+="‚Ä¢ <u>USUARIOS ONLINE</u> = Exibe Usu√°rios onlines\n\n"
        env_msg+="‚Ä¢ <u>INFO VPS</u> = Informacoes do servidor\n\n"
        env_msg+="‚Ä¢ <u>ALTERAR SENHA</u> = Altera senha ssh\n\n"
        env_msg+="‚Ä¢ <u>ALTERAR LIMITE</u> = Altera limite ssh\n\n"
        env_msg+="‚Ä¢ <u>ALTERAR DATA</u> = Altera data ssh\n\n"
        env_msg+="‚Ä¢ <u>EXPIRADOS</u> = Remove ssh expirados\n\n"
        env_msg+="‚Ä¢ <u>BACKUP</u> = Cria Backup ssh e revendas\n\n"
        env_msg+="‚Ä¢ <u>OTIMIZAR</u> = Limpa o cache - ram\n\n"
        env_msg+="‚Ä¢ <u>SPEEDTESTE</u> = Teste de conexao\n\n"
        env_msg+="‚Ä¢ <u>ARQUIVOS</u> = Hospeda Arquivos\n\n"
        env_msg+="‚Ä¢ <u>REVENDAS</u> = Gerenciar Revendas\n\n"
        env_msg+="‚Ä¢ <u>AUTOBACKUP</u> = lig/Des Backup automatico\n\n"
        env_msg+="‚Ä¢ <u>RELATORIO</u> = Informacoes sobre revendas\n\n"
        env_msg+="‚Ä¢ <u>AJUDA</u> = Informacoes sobre opcoes\n\n"
        ShellBot.sendMessage --chat_id $id_chatuser \
            --text "$(echo -e $env_msg)" \
            --parse_mode html
        return 0
    elif [[ -d /etc/bot/suspensos/$id_name ]]; then
        ShellBot.sendMessage --chat_id $id_chatuser \
            --text "$(echo -e "üö´ VC ESTA SUSPENSO üö´\n\nCONTATE O ADMINISTRADOR")"
        return 0
    elif [[ "$(grep -w "$id_name" $ativos | awk '{print $NF}')" == 'revenda' ]]; then
        local env_msg
        env_msg="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n"
        env_msg+="<b>BEM VINDO(a) AO BOT SSHPLUS</b>\n"
        env_msg+="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n\n"
        env_msg+="‚ö†Ô∏è <i>Comandos Disponiveis</i>\n\n"
        env_msg+="[<b>01</b>] /menu = Exibe menu\n"
        env_msg+="[<b>02</b>] /info = Exibe informacoes\n"
        env_msg+="[<b>03</b>] /ajuda = Informacoes sobre opcoes\n\n"
        env_msg+="‚ö†Ô∏è <i>Op√ß√µes Disponiveis</i>\n\n"
        env_msg+="‚Ä¢ <u>CRIAR USUARIO</u> = Cria usuario ssh\n\n"
        env_msg+="‚Ä¢ <u>CRIAR TESTE</u> = Cria teste ssh\n\n"
        env_msg+="‚Ä¢ <u>REMOVER</u> = Remove usuario ssh\n\n"
        env_msg+="‚Ä¢ <u>INFO USUARIOS</u> = Informacoes do usuario\n\n"
        env_msg+="‚Ä¢ <u>USUARIOS ONLINE</u> = Exibe Usu√°rios onlines\n\n"
        env_msg+="‚Ä¢ <u>ALTERAR SENHA</u> = Altera senha ssh\n\n"
        env_msg+="‚Ä¢ <u>ALTERAR LIMITE</u> = Altera limite ssh\n\n"
        env_msg+="‚Ä¢ <u>ALTERAR DATA</u> = Altera data ssh\n\n"
        env_msg+="‚Ä¢ <u>EXPIRADOS</u> = Remove ssh expirados\n\n"
        env_msg+="‚Ä¢ <u>REVENDAS</u> = Gerenciar Revendas\n\n"
        env_msg+="‚Ä¢ <u>RELATORIO</u> = Informacoes sobre revendas\n\n"
        env_msg+="‚Ä¢ <u>AJUDA</u> = Informacoes sobre opcoes\n\n"
        ShellBot.sendMessage --chat_id $id_chatuser \
            --text "$(echo -e $env_msg)" \
            --parse_mode html
        return 0
    elif [[ "$(grep -w "$id_name" $ativos | awk '{print $NF}')" == 'subrevenda' ]]; then
        local env_msg
        env_msg="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n"
        env_msg+="<b>BEM VINDO(a) AO BOT SSHPLUS</b>\n"
        env_msg+="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n\n"
        env_msg+="‚ö†Ô∏è <i>Comandos Disponiveis</i>\n\n"
        env_msg+="[<b>01</b>] /menu = Exibe menu\n"
        env_msg+="[<b>02</b>] /info = Exibe informacoes\n"
        env_msg+="[<b>03</b>] /ajuda = Informacoes sobre opcoes\n\n"
        env_msg+="‚ö†Ô∏è <i>Op√ß√µes Disponiveis</i>\n\n"
        env_msg+="‚Ä¢ <u>CRIAR USUARIO</u> = Cria usuario ssh\n\n"
        env_msg+="‚Ä¢ <u>CRIAR TESTE</u> = Cria teste ssh\n\n"
        env_msg+="‚Ä¢ <u>REMOVER</u> = Remove usuario ssh\n\n"
        env_msg+="‚Ä¢ <u>INFO USUARIOS</u> = Informacoes do usuario\n\n"
        env_msg+="‚Ä¢ <u>USUARIOS ONLINE</u> = Exibe Usu√°rios onlines\n\n"
        env_msg+="‚Ä¢ <u>ALTERAR SENHA</u> = Altera senha ssh\n\n"
        env_msg+="‚Ä¢ <u>ALTERAR LIMITE</u> = Altera limite ssh\n\n"
        env_msg+="‚Ä¢ <u>ALTERAR DATA</u> = Altera data ssh\n\n"
        env_msg+="‚Ä¢ <u>EXPIRADOS</u> = Remove ssh expirados\n\n"
        env_msg+="‚Ä¢ <u>AJUDA</u> = Informacoes sobre opcoes\n\n"
        ShellBot.sendMessage --chat_id $id_chatuser \
            --text "$(echo -e $env_msg)" \
            --parse_mode html
        return 0
    else
        ShellBot.sendMessage --chat_id $id_chatuser \
            --text "$(echo -e üö´ ACESSO NEGADO üö´)"
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
            --text "‚ö†Ô∏è VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "üë§ CRIAR USUARIO üë§\n\nNome do usuario:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "üö´ ACESSO NEGADO üö´"
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
            --text "‚ö†Ô∏è VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "üóë REMOVER USUARIO üóë\n\nNome do usuario:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "üö´ ACESSO NEGADO üö´"
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
                --text "$(echo -e "‚ùå O USUARIO NAO EXISTE ‚ùå")" \
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
            --text "‚ö†Ô∏è VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "üîê Alterar Senha üîê\n\nNome do usuario:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "üö´ ACESSO NEGADO üö´"
        return 0
    }
}

alterar_senha_user() {
    usuario=$1
    senha=$2
    echo "$usuario:$senha" | chpasswd
    echo "$senha" >/etc/SSHPlus/senha/$usuario
    [[ -e /etc/bot/revenda/${message_from_username}/usuarios/$usuario ]] && {
        senha2=$(cat /etc/bot/revenda/${message_from_username}/usuarios/$usuario | awk -F : {'print $2'})
        sed -i "/$usuario/ s/\b$senha2\b/$senha/g" /etc/bot/revenda/${message_from_username}/usuarios/$usuario
        sed -i "/$usuario/ s/\b$senha2\b/$senha/g" /etc/bot/info-users/$usuario
    }
    [[ $(ps -u $usuario | grep sshd | wc -l) != '0' ]] && pkill -u $usuario >/dev/null 2>&1
}

alterar_limite() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "‚ö†Ô∏è VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "üë• Alterar Limite üë•\n\nNome do usuario:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "üö´ ACESSO NEGADO üö´"
        return 0
    }
}

alterar_limite_user() {
    usuario=$1
    limite=$2
    database="/root/usuarios.db"
    [[ "${message_from_id[$id]}" == "$id_admin" ]] && {
        grep -v ^$usuario[[:space:]] /root/usuarios.db >/tmp/a
        mv /tmp/a /root/usuarios.db
        echo $usuario $limite >>/root/usuarios.db
        return 0
    }
    [[ -d /etc/bot/revenda/${message_from_username} ]] && {
        [[ ! -e /etc/bot/revenda/${message_from_username}/usuarios/$usuario ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "‚ùå O USUARIO NAO EXISTE ‚ùå")" \
                --parse_mode html
            _erro='1'
            return 0
        }
        _limTotal=$(grep -w 'LIMITE_REVENDA' /etc/bot/revenda/${message_from_username}/${message_from_username} | awk '{print $NF}')
        [[ "$limite" -gt "$_limTotal" ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "‚ùå VC NAO TEM LIMITE SUFICIENTE ‚ùå\n\nLimite Atual: $_limTotal ")" \
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
                --text "$(echo -e "‚ùå Vc nao tem limite suficiente\n\nLimite restante: $_restant1 ")" \
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
            --text "‚ö†Ô∏è VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "‚è≥ Alterar Data ‚è≥\n\nNome do usuario:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "üö´ ACESSO NEGADO üö´"
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
                --text "$(echo -e "‚ùå Erro! Data invalida")" \
                --parse_mode html
            _erro='1'
            return 0
        }
    }
    chage -E $sysdate $usuario
    [[ -e /etc/bot/revenda/${message_from_username}/usuarios/$usuario ]] && {
        data2=$(cat /etc/bot/info-users/$usuario | awk -F : {'print $3'})
        sed -i "s;$data2;$udata;" /etc/bot/info-users/$usuario
        echo $usuario $udata ${message_from_username}
        sed -i "s;$data2;$udata;" /etc/bot/revenda/${message_from_username}/usuarios/$usuario
    }
}

ver_users() {
    if [[ "${callback_query_from_id[$id]}" == "$id_admin" ]]; then
        arq_info=/tmp/$(echo $RANDOM)
        local info_users
        info_users='=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n'
        info_users+='<b>INFORMACOES DOS USUARIOS</b>\n'
        info_users+='=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n\n'
        info_users+='‚ö†Ô∏è Exibe no formato abaixo:\n\n'
        info_users+='<code>USU√ÅRIO SENHA LIMITE DATA</code>\n'
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
                info+="$user ‚Ä¢ $senha ‚Ä¢ $limite ‚Ä¢ $data"
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
                --text "‚ö†Ô∏è VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
            return 0
        }
        [[ $(ls /etc/bot/revenda/${callback_query_from_username}/usuarios | wc -l) == '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "VC AINDA NAO CRIOU USUARIO!"
            return 0
        }
        arq_info=/tmp/$(echo $RANDOM)
        local info_users
        info_users='=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n'
        info_users+='<b>INFORMACOES DOS USUARIOS</b>\n'
        info_users+='=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n\n'
        info_users+='‚ö†Ô∏è Exibe no formato abaixo:\n\n'
        info_users+='<code>USU√ÅRIO SENHA LIMITE DATA</code>\n'
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
                info+="$user ‚Ä¢ $senha ‚Ä¢ $limite ‚Ä¢ $data"
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
            --text "$(echo -e üö´ ACESSO NEGADO üö´)"
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
    if [[ "${callback_query_from_id[$id]}" == "$id_admin" ]]; then
        database="/root/usuarios.db"
        cad_onli=/tmp/$(echo $RANDOM)
        local info_on
        info_on='=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n'
        info_on+='<b>MONITOR USUARIOS ONLINES</b>\n'
        info_on+='=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n\n'
        info_on+='‚ö†Ô∏è Exibe no formato abaixo:\n\n'
        info_on+='<code>USU√ÅRIO  ONLINE/LIMITE  TEMPO\n</code>'
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
                    info2+="üü¢ $user       $conex/$lim       ‚è≥$timerr\n"
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
                --text "‚ö†Ô∏è VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
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
        info_on='=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n'
        info_on+='<b>MONITOR USUARIOS ONLINES</b>\n'
        info_on+='=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n\n'
        info_on+='‚ö†Ô∏è Exibe no formato abaixo:\n\n'
        info_on+='<code>USU√ÅRIO  ONLINE/LIMITE  TEMPO\n</code>'
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
                    info2+="üë§$user       $conex/$lim       ‚è≥$timerr\n"
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
            --text "$(echo -e üö´ ACESSO NEGADO üö´)"
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
    [[ "${message_from_id[$id]}" == "$id_admin" ]] && {
        [[ "$(awk -F : '$3 >= 1000 { print $1 }' /etc/passwd | grep -wc $user)" == '0' ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e ‚ùå Usuario $user n√£o existe !)" \
                --parse_mode html
            _erro='1'
            return 0
        }
    }
    [[ -d /etc/bot/revenda/${message_from_username} ]] && {
        [[ ! -e /etc/bot/revenda/${message_from_username}/usuarios/$user ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e ‚ùå Usuario $user nao existe !)" \
                --parse_mode html
            _erro='1'
            return 0
        }
    }
}

fun_down() {
    [[ "${callback_query_from_id[$id]}" != "$id_admin" ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "üö´ ACESSO NEGADO üö´"
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
            --text "$(echo -e üö´ ACESSO NEGADO üö´)"
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
    info="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n"
    info+="<b>INFORMACOES DO SERVIDOR</b>\n"
    info+="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n\n"
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
            --text "$(echo -e "‚ùåErro tente novamente")"
        _erro='1'
        return 0
    }
    _file2=$2
    [[ -z "$_file2" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "‚ùåErro tente novamente")"
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
        --caption "$(echo -e "‚úÖ CRIADO COM SUCESSO ‚úÖ\n\nUSUARIO: <code>$(awk -F " " '/Nome/ {print $2}' $_file2)</code>\nSENHA: <code>$(awk -F " " '/Senha/ {print $2}' $_file2)</code>\nLIMITE: $(awk -F " " '/Limite/ {print $2}' $_file2)\nEXPIRA EM: $(awk -F " " '/Validade/ {print $2}' $_file2)")" \
        --parse_mode html
    [[ -e "/root/$(awk -F " " '/Nome/ {print $2}' $_file2).ovpn" ]] && {
        ShellBot.sendDocument --chat_id ${message_from_id[$id]} \
            --document "@/root/$(awk -F " " '/Nome/ {print $2}' $_file2).ovpn"
    }
}

otimizer() {
    [[ "${callback_query_from_id[$id]}" != "$id_admin" ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "$(echo -e üö´ ACESSO NEGADO üö´)"
        return 0
    }
    MEM1=$(free | awk '/Mem:/ {print int(100*$3/$2)}')
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
        --text "üßπ LIMPANDO CACHE DO SERVIDOR"
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
    sucess="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n"
    sucess+="<b>OTIMIZADO COM SUCESSO !</b>\n"
    sucess+="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n\n"
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
            --text "$(echo -e üö´ ACESSO NEGADO üö´)"
        return 0
    }
    rm -rf $HOME/speed >/dev/null 2>&1
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
        --text "üöÄ TESTANDO VELOCIDADE DO SERVIDOR"
    speedtest --share >speed
    png=$(cat speed | sed -n '5 p' | awk -F : {'print $NF'})
    down=$(cat speed | sed -n '7 p' | awk -F : {'print $NF'})
    upl=$(cat speed | sed -n '9 p' | awk -F : {'print $NF'})
    lnk=$(cat speed | sed -n '10 p' | awk {'print $NF'})
    local msg
    msg="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n"
    msg+="<b>üöÄ VELOCIDADE DO SERVIDOR üöÄ</b>\n"
    msg+="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n\n"
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
            --text "$(echo -e üö´ ACESSO NEGADO üö´)"
        return 0
    }
    rm /root/backup.vps 1>/dev/null 2>/dev/null
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
        --text "‚ôªÔ∏è CRIANDO BACKUP DE USUARIOS"
    tar cvf /root/backup.vps /root/usuarios.db /etc/shadow /etc/passwd /etc/group /etc/gshadow /etc/bot 1>/dev/null 2>/dev/null
    ShellBot.sendDocument --chat_id ${id_admin} \
        --document "@/root/backup.vps" \
        --caption "$(echo -e "‚ôªÔ∏è BACKUP DE USUARIOS ‚ôªÔ∏è")"
    return 0
}

sobremim() {
    local msg
    msg="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n"
    msg+="<b>ü§ñ BOT SSHPLUS MANAGER ü§ñ</b>\n"
    msg+="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n\n"
    msg+="<b>Desenvolvido por:</b> @crazy_vpn\n"
    msg+="<b>Canal Oficial:</b> @SSHPLUS\n\n"
    msg+="Fui criado com o prop√≥sito de fornecer informa√ß√µes e ferramentas para gest√£o VPN em servidores üêß GNU/Linux üêß.\n\n"
    msg+="<b>Menu:</b> /menu\n"
    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e $msg)" \
        --parse_mode html
    return 0
}

fun_add_teste() {
    if [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]]; then
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "‚ö†Ô∏è VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    elif [[ "${callback_query_from_id[$id]}" == "$id_admin" ]]; then
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "üë§ CRIAR TESTE üë§\n\nQuantas horas deve durar EX: 1:" \
            --reply_markup "$(ShellBot.ForceReply)"
    elif [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]]; then
        _limTotal=$(grep -w "${callback_query_from_username}" $ativos | awk '{print $4}')
        fun_verif_limite_rev ${callback_query_from_username}
        _limsomarev2=$(echo "$_result + 1" | bc)
        [[ "$_limsomarev2" -gt "$_limTotal" ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "‚ùå VC NAO TEM LIMITE DISPONIVEL!"
            return 0
        } || {
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                --text "üë§ CRIAR TESTE üë§\n\nQuantas horas deve durar EX: 1:" \
                --reply_markup "$(ShellBot.ForceReply)"
        }
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "üö´ ACESSO NEGADO üö´"
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
            --text "$(echo -e "‚ùå Erro tente novamente")" \
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
                --caption "$(echo -e "‚úÖ Criado com sucesso ‚úÖ\n\nUSUARIO: <code>$usuario</code>\nSENHA: <code>1234</code>\n\n‚è≥ Expira em: $t_time $hrs")" \
                --parse_mode html
        done
        return 0
    } || {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "‚úÖ <b>Criado com sucesso</b> ‚úÖ\n\nIP: $(cat /etc/IP)\nUSUARIO: <code>$usuario</code>\nSENHA: <code>1234</code>\n\n‚è≥ Expira em: $t_time $hrs")" \
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
            --text "‚åõÔ∏è USUARIOS SSH EXPIRADOS REMOVIDOS"
        return 0
    elif [[ "$(grep -wc "${callback_query_from_username}" $ativos)" != '0' ]]; then
        [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "‚ö†Ô∏è VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
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
            pkill -f $user
            userdel --force $user
            grep -v ^$user[[:space:]] /root/usuarios.db >/tmp/ph
            cat /tmp/ph >/root/usuarios.db
            [[ -e /etc/SSHPlus/userteste/$user.sh ]] && rm /etc/SSHPlus/userteste/$user.sh
            [[ -e "$dir_user/$user" ]] && rm $dir_user/$user
        done
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "‚åõÔ∏è USUARIOS SSH EXPIRADOS REMOVIDOS"
        return 0
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "$(echo -e üö´ ACESSO NEGADO üö´)"
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
        msg="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n"
        msg+="<b>üìä RELATORIO | INFORMACOES</b>\n"
        msg+="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n\n"
        msg+="<b>Usuarios total:</b> $_tuser\n"
        msg+="<b>Usuarios online:</b> $_onli\n"
        msg+="<b>Revendas Ativas:</b> $_cont_rev\n"
        msg+="<b>Revendas Suspensas:</b> $_cont_sus\n"
        msg+="<b>Sub-Revendas:</b> $_cont_sub\n\n"
        msg+="<b>User:</b> @${callback_query_from_username}\n"
        msg+="<b>ID:</b> <code>${callback_query_from_id}</code>\n"
        [[ $_cont_revt != '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "üìä CRIANDO RELATORIO !"
        } || {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "‚ö†Ô∏è NENHUM REVENDEDOR ENCONTRADO !"
            return 0
        }
        echo -e "RELATORIO DOS REVENDEDORES\n\nTotal: $_cont_revt  -  $(printf 'Data: %(%d/%m/%Y)T\n')\n=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=" >/tmp/Relatorio.txt
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
            echo -e "\nSTATUS: $_status\nREVENDEDOR: @$_nome_rev\nLIMITE: $_limite_rev\nDIAS RESTANTES: $_data_rev\nSSH CRIADAS: $total_users\nSSH ONLINE: $total_on\nSUB-REVENDAS: $_subrev\n\n=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=" >>/tmp/Relatorio.txt
        done <<<"$(grep -w 'revenda' $ativos)"
        ShellBot.sendDocument --chat_id $id_admin \
            --document "@/tmp/Relatorio.txt" \
            --caption "$(echo -e "$msg")" \
            --parse_mode html
        return 0
    elif [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]]; then
        [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "‚ö†Ô∏è VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
            return 0
        }
        [[ $(grep -wc 'SUBREVENDA' /etc/bot/revenda/${callback_query_from_username}/${callback_query_from_username}) == '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "‚ö†Ô∏è NENHUM SUB REVENDEDOR ENCONTRADO !"
            _cont_limite=$(grep -w ${callback_query_from_username} $ativos | awk '{print $4}')
            fun_verif_limite_rev ${callback_query_from_username}
            _cont_disp=$(echo $_cont_limite - $_result | bc)
            local msg
            msg="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n"
            msg+="<b>üìä RELATORIO | INFORMACOES</b>\n"
            msg+="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n\n"
            msg+="<b>Limite de Logins:</b> $_cont_limite\n"
            msg+="<b>Limite Disponivel:</b> $_cont_disp\n"
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                --text "$msg" \
                --parse_mode html
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
        _cont_disp=$(echo $_cont_limite - $_result | bc)
        _cont_atv=$(grep -wc SUBREVENDA /etc/bot/revenda/${callback_query_from_username}/${callback_query_from_username})
        _cont_sup=$(fun_contsub | paste -s -d + | bc)
        local msg
        msg="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n"
        msg+="<b>üìä RELATORIO | INFORMACOES</b>\n"
        msg+="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n\n"
        msg+="<b>Limite de Logins:</b> $_cont_limite\n"
        msg+="<b>Limite Disponivel:</b> $_cont_disp\n"
        msg+="<b>Sub-Revendas Total:</b> $_cont_atv\n"
        msg+="<b>Sub-Revendas Suspensas:</b> $_cont_sup\n"
        msg+="<b>User:</b> @${callback_query_from_username}\n"
        msg+="<b>ID:</b> <code>${callback_query_from_id}</code>\n"
        echo -e "RELATORIO DOS SUB REVENDEDORES\n\nTotal: $_cont_atv  -  $(printf 'Data: %(%d/%m/%Y)T\n')\n=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=" >/tmp/Relatorio-${callback_query_from_username}.txt
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
            echo -e "\nSTATUS: $_status\nSUB-REVENDEDOR: @$_usub\nLIMITE: $_limit_sub\nDIAS RESTANTES: $_data_sub\nSSH CRIADAS: $total_users\nSSH ONLINE: $total_on\n\n=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=" >>/tmp/Relatorio-${callback_query_from_username}.txt
        done <<<"$(grep -w 'SUBREVENDA' /etc/bot/revenda/${callback_query_from_username}/${callback_query_from_username})"
        ShellBot.sendDocument --chat_id ${callback_query_message_chat_id[$id]} \
            --document "@/tmp/Relatorio-${callback_query_from_username}.txt" \
            --caption "$(echo -e "$msg")" \
            --parse_mode html
        return 0
    else

        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "üö´ ACESSO NEGADO üö´"
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
                --text "‚ôªÔ∏è BACKUP AUTOMATICO ATIVADO üü¢"
            return 0
        } || {
            [[ $(crontab -l | grep -c "userbackup") != '0' ]] && crontab -l | grep -v 'userbackup' | crontab -
            [[ -d /etc/SSHPlus/backups ]] && rm -rf /etc/SSHPlus/backups
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "‚ôªÔ∏è BACKUP AUTOMATICO DESATIVADO üî¥"
            return 0
        }
    }
}

backup_auto() {
    ShellBot.sendDocument --chat_id $id_admin \
        --document "@/etc/SSHPlus/backups/backup.vps" \
        --caption "$(echo -e "‚ôªÔ∏è BACKUP AUTOMATICO ‚ôªÔ∏è")"
    rm /etc/SSHPlus/backups/backup.vps
    return 0
}

msg_bem_vindo() {
    local msg
    msg="‚úåÔ∏èüòÉ Ola <b>${message_from_first_name[$id]}</b>\n\nSEJA BEM VINDO(a)\n\n"
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
            --text "‚ö†Ô∏è VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "üë• ADICIONAR REVENDEDOR üë•\n\nInforme o nome:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "üö´ ACESSO NEGADO üö´"
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
            --text "‚ö†Ô∏è VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "üóë REMOVER REVENDEDOR üóë\n\nInforme o user dele [Ex: @crazy_vpn]:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "üö´ ACESSO NEGADO üö´"
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
                    [[ -d /etc/bot/$_dirsts2/$_usub ]] && rm -rf /etc/bot/$_dirsts2/$_usub >/dev/null 2>&1
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
            [[ -d /etc/bot/$_dirsts/$_cli_rev ]] && rm -rf /etc/bot/$_dirsts/$_cli_rev >/dev/null 2>&1
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
                --text "$(echo -e ‚ùå REVENDEDEDOR NAO EXISTE ‚ùå)"
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
                [[ -d /etc/bot/revenda/$_cli_rev ]] && rm -rf /etc/bot/revenda/$_cli_rev >/dev/null 2>&1
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
                [[ -d /etc/bot/suspensos/$_cli_rev ]] && rm -rf /etc/bot/suspensos/$_cli_rev >/dev/null 2>&1
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
                --text "$(echo -e ‚ùå REVENDEDEDOR NAO EXISTE ‚ùå)"
            return 0
        }
    }
}

fun_lim_rev() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "‚ö†Ô∏è VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "‚ôæ ALTERAR LIMITE REVENDA ‚ôæ\n\nInforme o user dele [Ex: @crazy_vpn]:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "üö´ ACESSO NEGADO üö´"
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
            --text "‚ö†Ô∏è VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "üìÜ ALTERAR DATA REVENDA üìÜ\n\nInforme o user dele [Ex: @crazy_vpn]:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "üö´ ACESSO NEGADO üö´"
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
            --text "$(echo -e "‚ö†Ô∏è $_revd ESTAVA SUSPENSO E FOI REATIVADO !")" \
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
            --text "‚ö†Ô∏è VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    if [[ "${callback_query_from_id[$id]}" == "$id_admin" ]]; then
        local msg1
        msg1="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\nüìÉ LISTA DE REVENDEDORES !\n=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n"
        [[ "$(grep -wc 'revenda' $ativos)" != '0' ]] && {
            while read _atvs; do
                _uativ="$(echo $_atvs | awk '{print $2}')"
                [[ "$(grep -wc "$_uativ" $suspensos)" == '0' ]] && _stsrev='ATIVO' || _stsrev='SUSPENSO'
                msg1+="‚Ä¢ @$_uativ - $_stsrev\n"
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
        msg1="=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\nüìÉ LISTA DE SUB REVENDEDORES !\n=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=\n"
        [[ "$(grep -wc "SUBREVENDA" $_patch/${callback_query_from_username}/${callback_query_from_username})" != '0' ]] && {
            while read _listsub; do
                _usub="$(echo $_listsub | awk '{print $2}')"
                [[ "$(grep -wc "$_usub" $suspensos)" == '0' ]] && _usts='ATIVO' || _usts='SUSPENSO'
                msg1+="‚Ä¢ @$_usub - $_usts\n"
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
            --text "üö´ ACESSO NEGADO üö´"
        return 0
    fi
}

fun_susp_rev() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "‚ö†Ô∏è VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "üîí SUSPENDER REVENDEDOR üîí\n\nInforme o user dele [Ex: @crazy_vpn]:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "üö´ ACESSO NEGADO üö´"
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

infouserbot() {
    [[ $(grep -wc ${message_from_username} $ativos) != '0' ]] && {
        _cont_limite=$(grep -w ${message_from_username} $ativos | awk '{print $4}')
        fun_verif_limite_rev ${message_from_username}
        _cont_disp=$(echo $_cont_limite - $_result | bc)
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "<b>NOME: </> ${message_from_first_name[$(ShellBot.ListUpdates)]}\n<b>USER:</>" "@${message_from_username[$(ShellBot.ListUpdates)]:-null}")\n<b>ID:</> ${message_from_id[$(ShellBot.ListUpdates)]}\nACESSO: REVENDA\n<b>LIMITE TOTAL:</b> $_cont_limite\n<b>LIMITE RESTANTE:</b> $_cont_disp" \
            --parse_mode html
        return 0
    } || {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "<b>NOME: </> ${message_from_first_name[$(ShellBot.ListUpdates)]}\n<b>USER:</>" "@${message_from_username[$(ShellBot.ListUpdates)]:-null}")\n<b>ID:</> ${message_from_id[$(ShellBot.ListUpdates)]} " \
            --parse_mode html
        return 0
    }
}

fun_menurevenda() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "‚ö†Ô∏è VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "SELECIONE UMA OP√á√ÉO ABAIXO:" \
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
    #Obtem as atualiza√ß√µes
    ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 35
    #Lista o √≠ndice das atualiza√ß√µes
    for id in $(ShellBot.ListUpdates); do
        #Inicio thread
        (
            ShellBot.watchHandle --callback_data ${callback_query_data[$id]}
            # Requisi√ß√µes somente no privado.
            [[ ${message_chat_type[$id]} != 'private' ]] && continue
            CAD_ARQ=/tmp/cad.${message_from_id[$id]}
            if [[ ${message_entities_type[$id]} == bot_command ]]; then
                #Verifica se a mensagem enviada pelo usu√°rio √© um comando v√°lido.
                case ${message_text[$id]} in
                *)
                    :
                    #comandos
                    comando=(${message_text[$id]})
                    [[ "${comando[0]}" = "/start" ]] && msg_bem_vindo
                    [[ "${comando[0]}" = "/menu" ]] && fun_menu
                    [[ "${comando[0]}" = "/info" ]] && infouserbot
                    [[ "${comando[0]}" = "/hrlp" || "${comando[0]}" = "/ajuda" ]] && fun_ajuda
                    [[ "${comando[0]}" = "/bot" || "${comando[0]}" = "/sobre" ]] && sobremim
                    ;;
                esac
            fi
            if [[ ${message_reply_to_message_message_id[$id]} ]]; then
                # Analisa a interface de resposta.
                case ${message_reply_to_message_text[$id]} in
                'üë§ CRIAR USUARIO üë§\n\nNome do usuario:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ "$(awk -F : '$3 >= 1000 { print $1 }' /etc/passwd | grep -w ${message_text[$id]} | wc -l)" != '0' ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "‚ùå Erro! USUARIO INVALIDO ‚ùå\n\n‚ö†Ô∏è Informe Outro Nome..")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    [ "${message_text[$id]}" == 'root' ] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "‚ùå ERRO! USUARIO INVALIDO ‚ùå\n\n‚ö†Ô∏è Informe Outro Nome..")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    sizemin=$(echo -e ${#message_text[$id]})
                    [[ "$sizemin" -lt '4' ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "‚ùå Erro !\n\nUse no m√≠nimo 4 caracteres\n[EX: test]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    sizemax=$(echo -e ${#message_text[$id]})
                    [[ "$sizemax" -gt '10' ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "‚ùå Erro !\n\nUse no maximo 8 caracteres\n[EX: crazy]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    echo "Nome: ${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Senha:' \
                        --reply_markup "$(ShellBot.ForceReply)" # For√ßa a resposta.
                    ;;
                'Senha:')
                    sizepass=$(echo -e ${#message_text[$id]})
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ "$sizepass" -lt '4' ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "‚ùå Erro !\n\nUse no m√≠nimo 4 caracteres\n[EX: 1234]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    echo "Senha: ${message_text[$id]}" >>$CAD_ARQ
                    # Pr√≥ximo campo.
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Limite:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Limite:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "‚ùå Erro ! \n\nUltilize apenas numeros [EX: 1]")" \
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
                                --text "$(echo -e "‚ùå Vc nao tem limite suficiente\n\nLimite disponivel: $_restant1 ")" \
                                --parse_mode html
                            >$CAD_ARQ
                            break
                        }
                    }
                    echo "Limite: ${message_text[$id]}" >>$CAD_ARQ
                    # Pr√≥ximo campo.
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Validade em dias: ' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;

                'Validade em dias:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "‚ùå Erro ! \n\nUltilize apenas numeros [EX: 30]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    info_data=$(date '+%d/%m/%C%y' -d " +${message_text[$id]} days")
                    echo "Validade: $info_data" >>$CAD_ARQ
                    criar_user $CAD_ARQ
                    [[ "(grep -w ${message_text[$id]} /etc/passwd)" = '0' ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e ‚ùå Erro ao criar usuario !)" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    [[ "$(ls /etc/bot/arquivos | wc -l)" != '0' ]] && {
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text 'üì• ARQUIVOS DISPONIVEIS üì•\n\nDeseja baixar? Sim ou Nao?:' \
                            --reply_markup "$(ShellBot.ForceReply)"
                    } || {
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text "<b>‚úÖ CRIADO COM SUCESSO ‚úÖ</b>\n\nIP: $(cat /etc/IP)\nUSUARIO: <code>$(awk -F " " '/Nome/ {print $2}' $CAD_ARQ)</code>\nSENHA: <code>$(awk -F " " '/Senha/ {print $2}' $CAD_ARQ)</code>\nLIMITE: $(awk -F " " '/Limite/ {print $2}' $CAD_ARQ)\nEXPIRA EM: $(awk -F " " '/Validade/ {print $2}' $CAD_ARQ)" \
                            --parse_mode html
                        break
                    }
                    ;;
                'üì• ARQUIVOS DISPONIVEIS üì•\n\nDeseja baixar? Sim ou Nao?:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([A-Za-z]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "‚ùå Opcao Invalida ‚ùå\n\n‚ö†Ô∏è Ultilize apenas letras [EX: sim ou nao]")" \
                            --parse_mode html
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text "<b>‚úÖ CRIADO COM SUCESSO ‚úÖ</b>\n\nIP: $(cat /etc/IP)\nUSUARIO: <code>$(awk -F " " '/Nome/ {print $2}' $CAD_ARQ)</code>\nSENHA: <code>$(awk -F " " '/Senha/ {print $2}' $CAD_ARQ)</code>\nLIMITE: $(awk -F " " '/Limite/ {print $2}' $CAD_ARQ)\nEXPIRA EM: $(awk -F " " '/Validade/ {print $2}' $CAD_ARQ)" \
                            --parse_mode html
                        break
                    }
                    [[ "${message_text[$id]}" = @(Sim|sim|SIM) ]] && {
                        msg_cli="‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†\n"
                        msg_cli+="<b>ARQUIVOS PRE-CONFIGURADOS </b>‚ùó\n"
                        msg_cli+="‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†\n\n"
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
                            --text "<b>‚úÖ CRIADO COM SUCESSO ‚úÖ</b>\n\nIP: $(cat /etc/IP)\nUSUARIO: <code>$(awk -F " " '/Nome/ {print $2}' $CAD_ARQ)</code>\nSENHA: <code>$(awk -F " " '/Senha/ {print $2}' $CAD_ARQ)</code>\nLIMITE: $(awk -F " " '/Limite/ {print $2}' $CAD_ARQ)\nEXPIRA EM: $(awk -F " " '/Validade/ {print $2}' $CAD_ARQ)" \
                            --parse_mode html
                    }
                    ;;
                'Informe o Numero do Arquivo:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "‚ùå Opcao Invalida ‚ùå \n\n‚ö†Ô∏è Ultilize apenas numeros [EX: 1]")" \
                            --parse_mode html
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text "<b>‚úÖ CRIADO COM SUCESSO ‚úÖ</b>\n\nIP: $(cat /etc/IP)\nUSUARIO: <code>$(awk -F " " '/Nome/ {print $2}' $CAD_ARQ)</code>\nSENHA: <code>$(awk -F " " '/Senha/ {print $2}' $CAD_ARQ)</code>\nLIMITE: $(awk -F " " '/Limite/ {print $2}' $CAD_ARQ)\nEXPIRA EM: $(awk -F " " '/Validade/ {print $2}' $CAD_ARQ)" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    fun_download ${message_text[$id]} $CAD_ARQ
                    # Limpa o arquivo tempor√°rio.
                    >$CAD_ARQ
                    break
                    ;;
                'üóë REMOVER USUARIO üóë\n\nNome do usuario:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    fun_del_user ${message_text[$id]}
                    [[ "$_erro" == '1' ]] && break
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "‚úÖ *Removido com sucesso.* üöÆ" \
                        --parse_mode markdown
                    ;;
                'üîê Alterar Senha üîê\n\nNome do usuario:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    fun_verif_user ${message_text[$id]}
                    echo "$_erro"
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
                            --text "$(echo -e "‚ùå Erro !\n\n‚ö†Ô∏è Use m√≠nimo 4 caracteres [EX: 1234]")" \
                            --parse_mode html
                        break
                    }
                    alterar_senha_user $(cat /tmp/name-s) ${message_text[$id]}
                    [[ "$_erro" == '1' ]] && break
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "$(echo -e "=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó\n<b>‚úÖ SENHA ALTERADA !</b> !\n=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó\n\n<b>Usuario:</b> $(cat /tmp/name-s)\n<b>Nova senha:</b> ${message_text[$id]}")" \
                        --parse_mode html
                    rm /tmp/name-s >/dev/null 2>&1
                    ;;
                'üë• Alterar Limite üë•\n\nNome do usuario:')
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
                            --text "$(echo -e "‚ùå Erro ! \n\n‚ö†Ô∏è Ultilize apenas numeros [EX: 1]")" \
                            --parse_mode html
                        break
                    }
                    alterar_limite_user $(cat /tmp/name-l) ${message_text[$id]}
                    [[ "$_erro" == '1' ]] && break
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "$(echo -e "=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó\n<b>‚úÖ LIMITE ALTERADO !</b> !\n=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó\n\n<b>Usuario:</b> $(cat /tmp/name-l)\n<b>Novo Limite:</b> ${message_text[$id]}")" \
                        --parse_mode html
                    rm /tmp/name-l >/dev/null 2>&1
                    ;;
                '‚è≥ Alterar Data ‚è≥\n\nNome do usuario:')
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
                            --text "$(echo -e "‚ùå Erro! Siga o exemplo\n\nDias formato [EX: 30]\nData formato [EX: 30/12/2019]")" \
                            --parse_mode html
                        break
                    }
                    alterar_data_user $(cat /tmp/name-d) ${message_text[$id]}
                    [[ "$_erro" == '1' ]] && break
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "$(echo -e "=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó\n<b>‚úÖ DATA ALTERADA !</b> !\n=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó\n\n<b>Usuario:</b> $(cat /tmp/name-d)\n<b>Nova Data:</b> $udata")" \
                        --parse_mode html
                    rm /tmp/name-d >/dev/null 2>&1
                    ;;
                '[1] - ADICIONAR ARQUIVO\n[2] - EXCLUIR ARQUIVO\n\nInforme a opcao [1-2]:')
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "‚ùå Erro ! \n\n‚ö†Ô∏è Ultilize apenas numeros [EX: 1 ou 2]")" \
                            --parse_mode html
                        break
                    }
                    if [[ "${message_text[$id]}" = '1' ]]; then
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text "üì§ HOSPEDAR ARQUIVOS üì§\n\nEnvie-me o arquivo:" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    elif [[ "${message_text[$id]}" = '2' ]]; then
                        [[ $(ls /etc/bot/arquivos | wc -l) != '0' ]] && {
                            msg_cli1="‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†\n"
                            msg_cli1+="üöÄ<b> ARQUIVOS HOSPEDADOS </b>\n"
                            msg_cli1+="‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†‚â†\n\n"
                            for _file in $(ls /etc/bot/arquivos); do
                                i=$(($i + 1))
                                msg_cli1+="<b>[$i]</b> - $_file\n"
                            done
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "$msg_cli1")" \
                                --parse_mode html
                            ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                                --text "üóëExcluir Arquivo\nInforme o Numero do Arquivo:" \
                                --reply_markup "$(ShellBot.ForceReply)"
                        } || {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "Nao existe arquivos disponiveis")" \
                                --parse_mode html
                            break
                        }
                    else
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "‚ùå Opcao Invalida")" \
                            --parse_mode html
                        break
                    fi
                    ;;
                'üóëExcluir Arquivo\nInforme o Numero do Arquivo:')
                    [[ "${message_from_id[$id]}" != "$id_admin" ]] && break
                    Opc1=${message_text[$id]}
                    echo $Opc1
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "‚ùå Erro ao Excluir arquivo ! \n\n‚ö†Ô∏è Ultilize apenas numeros [EX: 1]")" \
                            --parse_mode html
                        break
                    } || {
                        echo "opcao $Opc1"
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
                            ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                                --text "‚úÖ *Excluido com sucesso* ‚úÖ" \
                                --parse_mode markdown
                            break
                        } || {
                            ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                                --text "$(echo -e "‚ùå Opcao invalida")"
                            break
                        }
                    }
                    ;;
                'üì§ HOSPEDAR ARQUIVOS üì§\n\nEnvie-me o arquivo:')
                    if [ "${update_id[$id]}" ]; then
                        # Monitora o envio de arquivos
                        [[ ${message_document_file_id[$id]} ]] && file_id=${message_document_file_id[$id]} && download_file=1
                        # Verifica se o download est√° ativado.
                        [[ $download_file -eq 1 ]] && {
                            file_id=($file_id)
                            ShellBot.getFile --file_id "${file_id[0]}"
                            ShellBot.downloadFile --file_path ${return[file_path]} --dir "/tmp/file" && {
                                msg='*‚úÖ Arquivo hospedado com sucesso.*\n\n'
                                msg+="*üì§ Informa√ß√µes*\n\n"
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
                                --text "$(echo -e "‚ùå Erro ao receber arquivo ‚ùå")" \
                                --parse_mode markdown
                            break
                        }
                    fi
                    ;;
                    # FUNCOES DE GESTAO REVENDA
                    #
                    # Adicionar, remover, limite, data, suspencao, relatorio
                    #
                'üë• ADICIONAR REVENDEDOR üë•\n\nInforme o nome:')
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
                            --text "$(echo -e "‚ùå Erro \n\n‚ö†Ô∏è Informe o user [EX: @crazy_vpn]")" \
                            --parse_mode html
                        break
                    }
                    [[ -d /etc/bot/revenda/$_VAR1 ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "‚ùå O Revendedor ${message_text[$id]} ja existe")" \
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
                            --text "$(echo -e "‚ùå Erro ! \n\n‚ö†Ô∏è Ultilize apenas numeros [EX: 10]")" \
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
                                --text "$(echo -e "‚ùå Vc nao tem limite suficiente\n\nLimite disponivel: $_restant1 ")" \
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
                        --text "‚úÖ Criado com sucesso. ‚úÖ\n\n$(<$CAD_ARQ)\n\nBOT: @${message_reply_to_message_from_username}" \
                        --parse_mode html
                    ;;
                    # REMOVE REVENDEDOR
                'üóë REMOVER REVENDEDOR üóë\n\nInforme o user dele [Ex: @crazy_vpn]:')
                    echo -e "${message_text[$id]}" >$CAD_ARQ
                    _Var=$(sed -n '1 p' $CAD_ARQ | awk -F '@' {'print $2'})
                    [[ -z $_Var ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "‚ùå User invalido")" \
                            --parse_mode html
                        break
                    }
                    del_rev $_Var
                    break
                    ;;
                    # ALTERAR LIMITE
                '‚ôæ ALTERAR LIMITE REVENDA ‚ôæ\n\nInforme o user dele [Ex: @crazy_vpn]:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    echo -e "Revendedor: ${message_text[$id]}" >$CAD_ARQ
                    _Var1=$(sed -n '1 p' $CAD_ARQ | awk -F '@' {'print $2'})
                    [[ -z $_Var1 ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "‚ùå Nome invalido !")" \
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
                                --text "$(echo -e "‚ùå Revendedor ${message_text[$id]} nao existe")" \
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
                                --text "$(echo -e "‚ùå O Sub-revendedor nao existe")" \
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
                            --text "$(echo -e "‚ùå Erro ! \n\nUltilize apenas numeros [EX: 1]")" \
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
                                --text "$(echo -e "‚ùå Vc nao tem limite suficiente")" \
                                --parse_mode html
                            break
                        }
                        [[ "$_limsomarev" -gt "$_limTotal" ]] && {
                            [[ "$_limTotal" == "$(($_limTotal - $_result))" ]] && _restant1='0' || _restant1=$(($_limTotal - $_result))
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "‚ùå Vc nao tem limite suficiente\n\nLimite restante: $_restant1 ")" \
                                --parse_mode html
                            break
                        }
                    }
                    echo -e "Limite: ${message_text[$id]}" >>$CAD_ARQ
                    lim_rev $CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "$(echo -e "=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó\n<b>‚úÖ LIMITE REVENDA ALTERADO !</b> !\n=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó\n\n$(<$CAD_ARQ)")" \
                        --parse_mode html
                    # ALTERAR DATA
                    ;;
                'üìÜ ALTERAR DATA REVENDA üìÜ\n\nInforme o user dele [Ex: @crazy_vpn]:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    _VAR1=$(echo -e ${message_text[$id]} | awk -F '@' {'print $2'})
                    [[ -z $_VAR1 ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "Revendedor ${message_text[$id]} nao existe")" \
                            --parse_mode html
                        break
                    }
                    [[ "${message_from_id[$id]}" == "$id_admin" ]] && {
                        [[ $(grep -wc $_VAR1 $ativos) != '0' ]] && {
                            echo -e "Revendedor: ${message_text[$id]}" >$CAD_ARQ
                            ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                                --text 'Dias de acesso [Ex: 30]:' \
                                --reply_markup "$(ShellBot.ForceReply)"
                        } || {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "‚ùå O Revendedor ${message_text[$id]} nao existe")" \
                                --parse_mode html
                            break
                        }
                    } || {
                        [[ $(grep -w ${message_from_username} $ativos | awk '{print $NF}') == 'revenda' ]] && {
                            [[ "$(grep -wc "$_VAR1" /etc/bot/revenda/${message_from_username}/${message_from_username})" != '0' ]] && {
                                echo -e "Revendedor: ${message_text[$id]}" >$CAD_ARQ
                                ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                                    --text 'Dias de acesso [Ex: 30]:' \
                                    --reply_markup "$(ShellBot.ForceReply)"
                            } || {
                                ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                    --text "$(echo -e "‚ùå O SubRevendedor ${message_text[$id]} nao existe")" \
                                    --parse_mode html
                                break
                            }
                        }
                    }
                    ;;
                'Dias de acesso [Ex: 30]:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "‚ùå Erro ! \n\nUltilize apenas numeros [EX: 30]")" \
                            --parse_mode html
                        break
                    }
                    echo -e "Data: ${message_text[$id]}" >>$CAD_ARQ
                    dat_rev $CAD_ARQ
                    [[ "$_erro" == '1' ]] && break
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "$(echo -e "=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó\n<b>‚úÖ DATA REVENDA ALTERADA !</b> !\n=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó=√ó\n\n$(<$CAD_ARQ)")" \
                        --parse_mode html
                    ;;
                    # SUSPENDER REVENDEDOR
                'üîí SUSPENDER REVENDEDOR üîí\n\nInforme o user dele [Ex: @crazy_vpn]:')
                    _VAR1=$(echo -e ${message_text[$id]} | awk -F '@' {'print $2'})
                    [[ -z $_VAR1 ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "‚ùå Revendedor ${message_text[$id]} nao existe")" \
                            --parse_mode html
                        break
                    }
                    susp_rev $_VAR1
                    break
                    ;;
                'üë§ CRIAR TESTE üë§\n\nQuantas horas deve durar EX: 1:')
                    verifica_acesso
                    echo $_erro
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "‚ùå Erro ! \n\nUltilize apenas numeros [EX: 1]")" \
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
                                --text "$(echo -e "‚ùå Vc nao tem limite suficiente")" \
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
Bz$z$RBz$SBz$UOBz$VOBz$WOBz$XOBz$inz$YOBz$ZOBz$aOBz$LRBz$RRBz$SRBz$ANBz$wJz$BNBz$rOBz$NBz$FGBz$z$RBz$SBz$UOBz$VOBz$WOBz$XOBz$inz$YOBz$ZOBz$aOBz$TRBz$URBz$SRBz$ANBz$wJz$VRBz$WRBz$RJz$XRBz$z$Mlz$iPBz$jPBz$YRBz$z$lPBz$mPBz$ZRBz$CMBz$DMBz$oPBz$Wwz$pPBz$mPBz$qPBz$rPBz$sPBz$aRBz$fVz$z$KZz$LZz$MZz$z$Vz$YOz$LBz$VOz$WOz$uZz$mCBz$uZz$nCBz$bRBz$fz$xBz$z$uZz$fCBz$cRBz$z$PDz$z$RBz$SBz$dRBz$eRBz$fRBz$gRBz$hRBz$iRBz$jRBz$kRBz$lRBz$Mz$Nz$mRBz$nRBz$oRBz$pRBz$qRBz$rRBz$z$TXz$sRBz$Jvz$RBz$SBz$mLBz$nLBz$oLBz$AJBz$gQz$z$nNz$z$RBz$SBz$tRBz$uRBz$vRBz$nCz$HFz$IFz$qMz$GKz$HFz$IFz$JFz$wRBz$xRBz$VFz$z$iz$qCz$mCz$rCz$yRBz$ASBz$VFz$aJz$qhz$OQz$QEz$yz$quz$ruz$z$BSBz$CSBz$ePz$DSBz$ESBz$WDz$XDz$YDz$UFz$VFz$z$wDz$FSBz$CEz$DEz$GSBz$HSBz$ISBz$JSBz$Emz$KSBz$LSBz$MSBz$NSBz$mEz$nEz$z$OSBz$oJz$WDz$PSBz$QSBz$aKz$RSBz$z$SSBz$z$TSBz$z$USBz$VSBz$WSBz$WDz$PSBz$QSBz$aKz$ZUz$z$mBz$XSBz$YSBz$ZSBz$fWz$aSBz$bSBz$xz$yz$oCBz$pCBz$qCBz$gQz$z$mBz$XSBz$YSBz$ZSBz$fWz$cSBz$dSBz$Fz$eSBz$fSBz$gSBz$z$mBz$XSBz$YSBz$ZSBz$fWz$hSBz$iSBz$Fz$jSBz$kSBz$DCBz$lSBz$z$mBz$XSBz$YSBz$ZSBz$fWz$mSBz$nSBz$Mdz$GFz$oSBz$pSBz$RKz$qSBz$xEz$rSBz$Zz$sSBz$TOBz$ePBz$z$mBz$XSBz$YSBz$ZSBz$fWz$tSBz$uSBz$vSBz$XSBz$YSBz$ZSBz$fWz$aSBz$MGz$xz$yz$Vqz$Wqz$z$wSBz$z$xSBz$z$wEz$z$wDz$FSBz$CEz$DEz$ySBz$ATBz$uBBz$mCz$uBBz$mCz$ZKz$aKz$bDz$REz$SEz$z$OSBz$oJz$WDz$BTBz$CTBz$DTBz$CEz$DEz$ETBz$tCz$FTBz$PJz$z$GTBz$Nmz$xMBz$pkz$HTBz$jCz$PSz$QSz$cGz$RSz$XTz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$mBz$Pfz$KNz$Qfz$Rfz$Sfz$Tfz$Ufz$nz$Vfz$ALz$Wfz$Xfz$cXz$XEz$fABz$qCz$mCz$OTBz$PTBz$Emz$HSz$ISz$WKz$XKz$Fz$CFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$QTBz$AHz$RTBz$STBz$SHBz$TTBz$UTBz$JGBz$KGBz$VTBz$WTBz$XTBz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$xDz$qCz$mCz$OTBz$PTBz$sBz$tBz$bTBz$cTBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$dTBz$eTBz$AHz$RTBz$STBz$SHBz$TTBz$UTBz$JGBz$KGBz$VTBz$WTBz$XTBz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$fTBz$gTBz$gDz$hDz$hTBz$iTBz$mCz$OTBz$PTBz$jTBz$z$mBz$kTBz$lTBz$mTBz$nTBz$QEz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oTBz$pTBz$qTBz$rTBz$sTBz$tTBz$uTBz$vTBz$wTBz$xTBz$Zrz$yTBz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$fTBz$AUBz$gDz$hDz$hTBz$iTBz$mCz$OTBz$PTBz$jTBz$z$mBz$kTBz$BUBz$CUBz$DUBz$lEz$Zz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oTBz$pTBz$qTBz$EUBz$FUBz$GUBz$uTBz$vTBz$wTBz$xTBz$kqz$HUBz$SSz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$QLz$IUBz$JUBz$nBz$oBz$KUBz$LUBz$VFz$Ziz$BSBz$MUBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$NUBz$OUBz$HDz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$PUBz$QUBz$RUBz$SUBz$TUBz$UUBz$z$wSBz$z$VUBz$WUBz$CLz$z$fTBz$qNz$FNz$GNz$XUBz$YUBz$oBz$KUBz$LUBz$VFz$CLz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$mBz$kTBz$ZUBz$aUBz$bUBz$cUBz$Zz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oTBz$pTBz$qTBz$rTBz$sTBz$tTBz$uTBz$vTBz$wTBz$xTBz$dUBz$yTBz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$QLz$eUBz$fUBz$oJz$WDz$PSBz$QSBz$aKz$gUBz$YTBz$ZTBz$aTBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$imz$hUBz$yCz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$wSBz$z$CIBz$iUBz$XTz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$mUBz$nUBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oUBz$jCz$Goz$pUBz$qUBz$rUBz$sUBz$tUBz$uUBz$vUBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$mBz$nBz$oBz$pBz$qBz$rBz$sBz$aJz$uBz$vBz$wBz$fz$xBz$z$iSz$jSz$kSz$eEz$lSz$SFz$WDz$XDz$YDz$ZDz$aDz$RTz$CBz$STz$TTz$UTz$VTz$WTz$XTz$z$jBz$VJz$YTz$EOz$ZTz$oJz$WDz$XDz$YDz$ZDz$aDz$PDz$z$iSz$aTz$bTz$FNz$GNz$cTz$dTz$eTz$nBz$oBz$KUBz$LUBz$VFz$haz$Ewz$z$mBz$iTz$jTz$kTz$mTz$nTz$iTz$oTz$pTz$fz$xBz$z$LEBz$wUBz$dEBz$xUBz$OTz$PTz$iABz$jABz$yUBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$GUz$HUz$IUz$fMz$JUz$KUz$LUz$MUz$NUz$OUz$AVBz$wABz$hiz$sTz$BVBz$CVBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$PDz$z$QLz$DVBz$EOz$EVBz$CEz$DEz$ETBz$tCz$RKz$FVBz$GVBz$HVBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$nmz$ENz$IVBz$JVBz$KVBz$HDz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$wSBz$z$LVBz$hNz$MVBz$NVBz$OVBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$mUBz$nUBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oUBz$jCz$Goz$pUBz$qUBz$rUBz$sUBz$tUBz$uUBz$PVBz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$CGz$hxz$VMz$SNz$Osz$AVz$QVBz$RVBz$Rsz$SVBz$WDz$PSBz$QSBz$aKz$TVBz$UVBz$z$QLz$VVBz$NWz$WVBz$XVBz$YVBz$INz$FVBz$GVBz$HVBz$z$uKz$vKz$CYz$BSBz$MUBz$z$mBz$yDz$AEz$oJz$WDz$PSBz$QSBz$aKz$ZVBz$VXz$eRz$aVBz$PEz$QEz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$Zfz$Alz$bVBz$uKz$cVBz$wGz$dVBz$SSz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$mBz$sZz$ALz$lRz$Klz$eIz$STz$eZz$Ldz$aJz$kJz$fz$xBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$eVBz$ZIz$fVBz$srz$trz$gVBz$hVBz$iVBz$jVBz$kVBz$lVBz$mVBz$JDBz$nVBz$oVBz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$QFz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$pVBz$pZz$ywz$THBz$UHBz$sEz$qVBz$rVBz$sVBz$tVBz$Wdz$LBz$uVBz$vVBz$YGz$wVBz$Xcz$Pfz$KNz$xVBz$yVBz$AWBz$aXz$KJz$Ouz$BWBz$ZTBz$CWBz$ltz$DWBz$WHz$wVBz$Xcz$Pfz$KNz$xVBz$EWBz$UOz$omz$VTz$pmz$FWBz$GVBz$GWBz$fcz$itz$FTz$TIBz$Pfz$KNz$xVBz$HWBz$hHz$IWBz$sSz$NYz$JWBz$BSBz$KWBz$kmz$lmz$mmz$fmz$rRz$gmz$hmz$nmz$ENz$omz$VTz$pmz$FWBz$GVBz$LWBz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$wSBz$z$MWBz$rfz$uNBz$NWBz$OWBz$PWBz$QWBz$RWBz$SWBz$TWBz$UWBz$VWBz$WWBz$XWBz$YWBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$ZWBz$aWBz$Fz$CFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$bWBz$cWBz$dWBz$eWBz$TTBz$UTBz$Goz$pUBz$qUBz$rUBz$fWBz$gWBz$xTBz$hWBz$iWBz$jWBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$pVBz$pZz$ywz$THBz$UHBz$sEz$qVBz$rVBz$sVBz$tVBz$Wdz$LBz$uVBz$vVBz$YGz$wVBz$Xcz$Pfz$KNz$xVBz$yVBz$AWBz$aXz$KJz$Ouz$BWBz$ZTBz$CWBz$ltz$DWBz$WHz$wVBz$Xcz$Pfz$KNz$xVBz$EWBz$UOz$omz$VTz$pmz$FWBz$GVBz$GWBz$fcz$itz$FTz$TIBz$Pfz$KNz$xVBz$HWBz$hHz$IWBz$sSz$NYz$JWBz$BSBz$KWBz$kmz$lmz$mmz$fmz$rRz$gmz$hmz$nmz$ENz$omz$VTz$pmz$FWBz$GVBz$LWBz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$mBz$nBz$oBz$KUBz$LUBz$VFz$dez$kWBz$lWBz$mWBz$nWBz$Zz$RFz$z$oCBz$oWBz$pWBz$qWBz$qWBz$qWBz$qWBz$qWBz$rWBz$mFz$z$oCBz$sWBz$KCz$tWBz$uWBz$vWBz$wWBz$xWBz$yWBz$AXBz$BXBz$cFz$z$oCBz$sWBz$CXBz$qWBz$qWBz$qWBz$qWBz$qWBz$qWBz$jCz$ICz$z$TXz$Flz$DXBz$YEBz$JHBz$RDz$EXBz$FXBz$VKz$naz$z$Qlz$GXBz$Tlz$CLz$z$oCBz$sWBz$KCz$HXBz$IXBz$JXBz$Xmz$KXBz$ICz$z$GZz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$pUz$oCBz$LXBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$JGBz$KGBz$MXBz$NXBz$QSz$OXBz$PXBz$QXBz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$QFz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$pVBz$pZz$ywz$THBz$UHBz$sEz$qVBz$rVBz$sVBz$tVBz$Wdz$LBz$uVBz$vVBz$YGz$wVBz$Xcz$Pfz$KNz$xVBz$yVBz$AWBz$aXz$KJz$Ouz$BWBz$ZTBz$CWBz$ltz$DWBz$WHz$wVBz$Xcz$Pfz$KNz$xVBz$EWBz$UOz$omz$VTz$pmz$FWBz$GVBz$GWBz$fcz$itz$FTz$TIBz$Pfz$KNz$xVBz$HWBz$hHz$IWBz$sSz$NYz$JWBz$BSBz$KWBz$kmz$lmz$mmz$fmz$rRz$gmz$hmz$nmz$ENz$omz$VTz$pmz$FWBz$GVBz$LWBz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$PDz$z$wSBz$z$RXBz$SXBz$TXBz$UXBz$VXBz$WXBz$XXBz$YXBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$mUBz$nUBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$bWBz$cWBz$dWBz$eWBz$ZXBz$aXBz$bXBz$cXBz$dXBz$eXBz$fXBz$gXBz$hXBz$iXBz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$pVBz$pZz$ywz$THBz$UHBz$sEz$qVBz$rVBz$sVBz$tVBz$Wdz$LBz$uVBz$vVBz$YGz$wVBz$Xcz$Pfz$KNz$xVBz$yVBz$AWBz$aXz$KJz$Ouz$BWBz$ZTBz$CWBz$ltz$DWBz$WHz$wVBz$Xcz$Pfz$KNz$xVBz$EWBz$UOz$omz$VTz$pmz$FWBz$GVBz$GWBz$fcz$itz$FTz$TIBz$Pfz$KNz$xVBz$HWBz$hHz$IWBz$sSz$NYz$JWBz$BSBz$KWBz$kmz$lmz$mmz$fmz$rRz$gmz$hmz$nmz$ENz$omz$VTz$pmz$FWBz$GVBz$LWBz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$jBz$gfz$wkz$oJz$WDz$PSBz$QSBz$aKz$jXBz$GVBz$HVBz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$wSBz$z$kXBz$NNBz$vQBz$sGz$Zcz$lXBz$mXBz$nXBz$vGz$wGz$oXBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$jBz$yOz$ZDz$oJz$WDz$PSBz$QSBz$aKz$PDz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$pXBz$uHz$qXBz$rXBz$unz$sXBz$tXBz$SSz$z$IDz$JDz$KDz$uXBz$vXBz$PJz$z$wSBz$z$wXBz$fHz$xXBz$NUBz$yXBz$jCz$PSz$QSz$cGz$RSz$XTz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$jBz$VJz$Kfz$CYz$qCz$mCz$OTBz$PTBz$AYBz$z$QLz$ySz$BYBz$ICz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$QLz$BEz$CEz$DEz$ETBz$tCz$RKz$Avz$CYBz$DYBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$EYBz$mXz$WUBz$yCz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$wSBz$z$FYBz$ZHz$fUBz$XTz$z$fTBz$qNz$FNz$GNz$XUBz$YUBz$oBz$KUBz$LUBz$VFz$CLz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$mBz$kTBz$ZUBz$aUBz$bUBz$cUBz$Zz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oTBz$GYBz$HYBz$IYBz$sTBz$tTBz$uTBz$vTBz$JYBz$KYBz$LYBz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$VRz$WRz$UMz$aRz$CYz$yKz$vsz$CYBz$DYBz$MYBz$CEz$DEz$ETBz$tCz$NYBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$gDz$hDz$OYBz$GCz$GCz$GCz$GCz$GCz$PYBz$QYBz$jtz$RYBz$lHBz$SYBz$kFz$TYBz$WCz$WCz$WCz$WCz$WCz$UYBz$VYBz$Swz$eNz$Xwz$WYBz$ULz$ePz$XYBz$YYBz$VYBz$ZYBz$ZHz$fUBz$kFz$oJz$WDz$PSBz$QSBz$aKz$aYBz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$jPz$aSz$aDz$bYBz$lPz$mPz$nPz$oPz$z$wSBz$z$cYBz$fHz$xXBz$imz$dYBz$eYBz$uOz$vOz$wOz$eNz$YXBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$QLz$fYBz$gYBz$hYBz$iYBz$z$jBz$VJz$Kfz$CYz$qCz$mCz$OTBz$PTBz$AYBz$z$QLz$ySz$BYBz$ICz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$QLz$BEz$CEz$DEz$ETBz$tCz$RKz$Avz$CYBz$jYBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$kYBz$FYz$iUBz$QXBz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$wSBz$z$FYBz$lYBz$EOz$YXBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$mUBz$nUBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oUBz$jCz$mYBz$nYBz$oYBz$pYBz$qYBz$UXBz$rYBz$xTBz$sYBz$SSz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$VRz$WRz$fMz$TSz$AJz$TUz$tYBz$uYBz$vYBz$wYBz$qCz$mCz$OTBz$PTBz$AYBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$gDz$hDz$OYBz$GCz$GCz$GCz$GCz$GCz$PYBz$QYBz$FTz$xYBz$UHz$ywz$yYBz$AZBz$fKBz$GCz$GCz$GCz$GCz$BZBz$CZBz$DZBz$wGz$Skz$Okz$yKz$vsz$CYBz$jYBz$AMBz$EZBz$FZBz$hHz$GZBz$Okz$qCz$mCz$OTBz$PTBz$sBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$jPz$aSz$aDz$HZBz$lPz$mPz$nPz$oPz$z$wSBz$z$IZBz$YHz$JZBz$LWz$KZBz$uOz$vOz$wOz$eNz$YXBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$jBz$VJz$Kfz$CYz$qCz$mCz$OTBz$PTBz$AYBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$QLz$BEz$CEz$DEz$ETBz$tCz$RKz$Avz$CYBz$LZBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$CGz$KGBz$MZBz$NZBz$OZBz$LBBz$QXBz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$wSBz$z$PZBz$SXBz$QZBz$JVBz$JDBz$qMz$YXBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$RZBz$SZBz$Zz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$TZBz$UZBz$cfz$VZBz$xGz$WZBz$XZBz$Scz$YZBz$ZZBz$aZBz$Lxz$DXz$EXz$hXBz$bZBz$cZBz$dZBz$yTBz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$VRz$WRz$qMz$FEz$eZBz$ULz$ePz$XYBz$fZBz$oJz$WDz$PSBz$QSBz$aKz$PDz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$gDz$hDz$OYBz$GCz$GCz$GCz$GCz$GCz$PYBz$QYBz$NXz$gZBz$hZBz$iZBz$qqz$wJBz$GCz$GCz$GCz$GCz$GCz$jZBz$kkz$afz$RSz$kFz$tVBz$Wdz$aSz$aDz$kZBz$kkz$EYBz$lZBz$mZBz$Okz$xUz$nZBz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$jPz$aSz$aDz$oZBz$lPz$mPz$nPz$oPz$z$wSBz$z$pZBz$qZBz$jEBz$kEBz$rZBz$uWBz$sZBz$flz$tZBz$uZBz$rfz$sfz$vZBz$JGz$wZBz$NGz$xZBz$yZBz$YXBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$mUBz$nUBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oUBz$jCz$mYBz$nYBz$oYBz$pYBz$qYBz$UXBz$rYBz$xTBz$AaBz$BaBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$wDz$xDz$qCz$mCz$OTBz$PTBz$sBz$PYz$LTBz$mEz$nEz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$CaBz$DaBz$EaBz$rfz$uNBz$FaBz$GaBz$HaBz$IaBz$JaBz$eIz$KaBz$HDz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$UEz$VEz$SFz$WDz$PSBz$QSBz$aKz$fWz$LaBz$NJz$OJz$PJz$z$iz$iZz$Cz$Jz$MaBz$XXBz$dEz$kZz$NaBz$PEz$QEz$yz$cDz$z$oCBz$OaBz$CXBz$qWBz$qWBz$qWBz$qWBz$qWBz$qWBz$cFz$z$oCBz$OaBz$PaBz$QaBz$rZBz$uWBz$RaBz$SaBz$sHz$TaBz$UCz$z$oCBz$OaBz$UaBz$qWBz$qWBz$qWBz$qWBz$qWBz$qWBz$VaBz$mFz$z$TXz$Flz$DXBz$YEBz$JHBz$RDz$EXBz$FXBz$VKz$naz$z$Qlz$GXBz$Tlz$CLz$z$oCBz$OaBz$sjz$WaBz$XaBz$YaBz$ylz$ZaBz$mFz$z$GZz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$pUz$oCBz$OaBz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$aaBz$baBz$caBz$eIz$daBz$JGz$eaBz$faBz$gaBz$haBz$FXBz$iaBz$yCz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$QFz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$jaBz$kaBz$laBz$maBz$eIz$MZBz$QGz$RGz$naBz$SSz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$pEz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$bWBz$cWBz$dWBz$oaBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$wEz$z$wSBz$z$paBz$qaBz$raBz$FXBz$saBz$JGBz$KGBz$MXBz$NXBz$QSz$OXBz$PXBz$XTz$z$mBz$nBz$oBz$pBz$qBz$rBz$sBz$aJz$uBz$vBz$wBz$fz$taBz$uaBz$z$vaBz$waBz$WDz$PSBz$QSBz$aKz$PDz$z$QLz$xaBz$yaBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$mUBz$nUBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$AbBz$BbBz$CbBz$DbBz$XXBz$EbBz$GYBz$FbBz$Qkz$GbBz$HbBz$IbBz$NXBz$JYBz$KYBz$yTBz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$QFz$RFz$z$QLz$JbBz$Ioz$wlz$KbBz$z$Ilz$Jlz$sZz$ALz$lRz$Klz$eIz$Llz$z$xaz$z$Mlz$Nlz$nOz$z$KZz$GIz$Olz$Plz$MZz$z$Qlz$Rlz$Slz$Tlz$z$Ulz$Vlz$z$iz$Wlz$Xlz$Ylz$Zz$Zlz$alz$blz$clz$dlz$z$QLz$fNz$elz$flz$glz$hlz$z$ilz$jlz$klz$llz$mlz$nlz$ICz$z$GZz$olz$plz$qlz$rlz$z$Flz$slz$QLz$fNz$plz$tlz$ulz$FPz$Zdz$vlz$wlz$LbBz$mMz$nMz$Ejz$CNz$z$Vz$CQz$RDz$EXBz$FXBz$MbBz$Xmz$NbBz$Zz$RFz$z$jPz$LBz$MBz$ObBz$KABz$PbBz$mfz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$QbBz$qaBz$qXBz$rXBz$unz$RbBz$SbBz$HDz$z$IDz$JDz$KDz$uXBz$vXBz$PJz$z$gZz$hZz$z$QFz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$bWBz$TbBz$dWBz$oaBz$oVz$z$gZz$hZz$z$PDz$z$PDz$z$wSBz$z$UbBz$VbBz$WbBz$rZBz$uWBz$XbBz$jCz$YbBz$ZbBz$abBz$FXBz$bbBz$CLz$z$wDz$BEz$cbBz$dbBz$rBz$sBz$Ibz$UJz$z$iz$qCz$mCz$ebBz$Cmz$fbBz$gbBz$rBz$Emz$fz$hbBz$gbBz$ibBz$CEz$DEz$jbBz$Irz$Flz$XMBz$tCz$kbBz$lbBz$mbBz$nbBz$obBz$mNz$z$iz$gfz$wkz$Flz$pbBz$qbBz$fz$xBz$z$IMz$rbBz$sbBz$gbBz$WNz$z$RBz$SBz$dRBz$tbBz$ubBz$lMz$vbBz$wbBz$gbBz$xbBz$WFz$z$RBz$SBz$ybBz$AcBz$BcBz$CcBz$IMz$YKBz$DcBz$NDz$EcBz$lMz$FcBz$uCz$GcBz$HcBz$lfz$IcBz$yz$cDz$z$ECz$JcBz$OXBz$KcBz$LcBz$McBz$NcBz$OcBz$tnz$PcBz$QcBz$z$JCz$RcBz$ScBz$NHz$TcBz$UcBz$cFz$z$JCz$VcBz$WcBz$EVBz$CEz$DEz$jbBz$Irz$Flz$XcBz$kwz$mFz$z$JCz$YcBz$ZcBz$acBz$bcBz$RDz$EXBz$FXBz$ccBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$pUz$xCz$yPz$z$IDz$JDz$KDz$uXBz$vXBz$PJz$z$ZSz$aSz$IMz$dcBz$ecBz$fcBz$aSz$IMz$Kiz$Liz$gcBz$ALz$lRz$Klz$eIz$rPz$qCz$mCz$ebBz$Cmz$fbBz$hcBz$bEz$z$gZz$hZz$z$PDz$z$QFz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$AbBz$icBz$jcBz$DbBz$XXBz$kcBz$SSz$z$IDz$JDz$KDz$uXBz$vXBz$PJz$z$gZz$hZz$z$PDz$z$wEz$z$wSBz$z$cYBz$rQBz$Fkz$sQBz$uwz$vwz$lcBz$vZBz$JGz$eaBz$mcBz$ncBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$QLz$IUBz$JUBz$nBz$oBz$KUBz$LUBz$VFz$Ziz$BSBz$MUBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$JGBz$KGBz$vGz$LGBz$MGBz$NGBz$OGBz$PGBz$QGBz$oVBz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$wSBz$z$RXBz$SXBz$ocBz$AJz$pcBz$qcBz$rcBz$vz$wz$scBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$tcBz$dEBz$QLz$fNz$nBz$oBz$KUBz$LUBz$VFz$qRz$rRz$yHBz$AIBz$sSz$NYz$cEBz$z$Vz$ucBz$vcBz$Fz$CFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$wcBz$aXBz$xcBz$SXBz$ocBz$AJz$uUBz$OGBz$PGBz$QGBz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$Vz$QDz$RDz$gRz$RJz$hRz$tcBz$ycBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$AdBz$RJz$BdBz$CdBz$CEz$DEz$ETBz$tCz$DdBz$EdBz$dfz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$QLz$FdBz$GdBz$nBz$oBz$KUBz$LUBz$VFz$iLz$HdBz$IdBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$JdBz$KdBz$Rvz$MGBz$LdBz$MdBz$NdBz$yCz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$wSBz$z$OdBz$grz$iFz$PdBz$QdBz$RdBz$SdBz$XTz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$mUBz$nUBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oUBz$jCz$mYBz$nYBz$oYBz$pYBz$qYBz$UXBz$rYBz$xTBz$TdBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$mBz$nBz$oBz$pBz$qBz$rBz$sBz$aJz$uBz$vBz$wBz$fz$xBz$z$iSz$jSz$kSz$eEz$lSz$SFz$WDz$XDz$YDz$ZDz$aDz$RTz$CBz$STz$TTz$UTz$VTz$WTz$XTz$z$jBz$VJz$YTz$EOz$ZTz$oJz$WDz$XDz$YDz$ZDz$aDz$PDz$z$iSz$aTz$fxz$gDz$NEBz$sTz$tTz$mez$qCz$mCz$OTBz$PTBz$sBz$fTz$gTz$z$mBz$iTz$jTz$kTz$CUBz$wCz$iSz$jSz$UdBz$Zz$RFz$z$LEBz$wUBz$dEBz$xUBz$OTz$PTz$iABz$jABz$yUBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$GUz$HUz$IUz$fMz$JUz$KUz$LUz$MUz$NUz$OUz$AVBz$wABz$hiz$sTz$BVBz$CVBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$PDz$z$QLz$DVBz$EOz$EVBz$CEz$DEz$ETBz$tCz$RKz$FVBz$GVBz$HVBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$JdBz$VdBz$JVBz$Arz$WdBz$XdBz$yCz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$wSBz$z$OdBz$YdBz$NVBz$ZdBz$adBz$bdBz$XTz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$QLz$VVBz$NWz$WVBz$nBz$oBz$KUBz$LUBz$VFz$iLz$HdBz$IdBz$z$RGBz$cdBz$ddBz$yKz$BWBz$ZTBz$edBz$z$uKz$pEBz$fdBz$GVBz$HVBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$gdBz$uqz$vqz$hdBz$idBz$jdBz$kdBz$ldBz$GVBz$mdBz$ndBz$odBz$pdBz$WDz$BTBz$CTBz$DTBz$CEz$DEz$EEz$FEz$hBz$GEz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$wSBz$z$kXBz$NNBz$vQBz$oSz$WHBz$Spz$tOz$qdBz$SXBz$ocBz$AJz$pcBz$qcBz$rcBz$vz$wz$scBz$z$QLz$fNz$SFz$WDz$PSBz$QSBz$aKz$gUBz$HdBz$IdBz$z$rdBz$rMz$sMz$sdBz$uMz$HdBz$IdBz$qRz$rRz$yHBz$AIBz$sSz$NYz$cEBz$z$Vz$ucBz$tdBz$fz$xBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$udBz$mGBz$DNz$vdBz$SSz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$yOz$hDBz$wdBz$tuz$z$gZz$hZz$z$wSBz$z$xdBz$UHz$bHz$cHz$ydBz$uwz$AeBz$vZBz$JGz$eaBz$BeBz$CeBz$DeBz$EeBz$FeBz$GeBz$HeBz$XTz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$QLz$fNz$IeBz$nIBz$JeBz$oJz$WDz$PSBz$QSBz$aKz$gUBz$HdBz$IdBz$z$rdBz$dEBz$WMz$XMz$tEBz$BWBz$ZTBz$KeBz$IJz$LeBz$MeBz$qhz$nz$rhz$z$Vz$ucBz$NeBz$Fz$CFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$OeBz$DXBz$DNz$PeBz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$mBz$nBz$oBz$pBz$qBz$rBz$sBz$tBz$uBz$vBz$wBz$fz$xBz$z$iz$yDz$AEz$QeBz$NeBz$JABz$KABz$tz$XKz$Fz$CFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$JGBz$KGBz$ReBz$EOz$iFz$oVBz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$QFz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$SeBz$nIBz$TeBz$nBz$oBz$KUBz$LUBz$VFz$UeBz$az$VeBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$PDz$z$iz$yDz$AEz$oJz$WDz$XDz$YDz$ZDz$aDz$pJz$GBz$dEz$IJz$JJz$KJz$LJz$WeBz$XeBz$RJz$SJz$fz$xBz$z$mBz$bJz$KEz$SGBz$wdBz$YeBz$Cz$Jz$pPz$iEz$VDz$WDz$XDz$YDz$ZDz$aDz$gIBz$CEz$DEz$EEz$FEz$hBz$aLBz$aJz$kJz$fz$xBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$JGBz$KGBz$ReBz$EOz$iFz$oVBz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$QFz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$ZeBz$aeBz$RJz$BdBz$ffz$cfz$dfz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$PDz$z$wSBz$z$RXBz$SXBz$beBz$hHz$ceBz$deBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$mUBz$nUBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oUBz$jCz$Goz$pUBz$qUBz$rUBz$sUBz$tUBz$uUBz$vUBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$mBz$nBz$oBz$pBz$qBz$rBz$sBz$aJz$uBz$vBz$wBz$fz$xBz$z$iSz$jSz$kSz$eEz$lSz$SFz$WDz$XDz$YDz$ZDz$aDz$RTz$CBz$STz$TTz$UTz$VTz$WTz$XTz$z$jBz$VJz$YTz$EOz$ZTz$oJz$WDz$XDz$YDz$ZDz$aDz$PDz$z$iSz$aTz$fxz$gDz$NEBz$sTz$tTz$mez$qCz$mCz$OTBz$PTBz$sBz$fTz$gTz$z$iz$yDz$AEz$SABz$TABz$uwz$UABz$LBz$MBz$MEz$GOz$nBz$oBz$pBz$ZEz$aEz$bEz$VDz$WDz$XDz$YDz$ZDz$aDz$eeBz$PEz$QEz$yz$cDz$z$iSz$aTz$bTz$FNz$GNz$WEz$XEz$IABz$Byz$gIz$dABz$Cz$Jz$pPz$iEz$VDz$WDz$XDz$YDz$ZDz$aDz$gIBz$CEz$DEz$EEz$FEz$hBz$feBz$TTz$XUz$VTz$YUz$geBz$Tyz$Uyz$Bz$Vyz$heBz$ieBz$nBz$oBz$KUBz$LUBz$VFz$haz$Ewz$z$QFz$RFz$z$iSz$aTz$bTz$Yyz$z$PDz$z$mBz$iTz$jTz$kTz$mTz$jeBz$iTz$oTz$pTz$fz$xBz$z$QLz$NTz$PEBz$QEBz$keBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$GUz$HUz$IUz$fMz$JUz$KUz$LUz$Zsz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$mBz$iTz$jTz$kTz$CUBz$wCz$iSz$jSz$UdBz$Zz$RFz$z$mBz$iTz$oTz$pTz$SKz$qTz$iSz$jSz$rTz$sTz$tTz$uTz$fz$vTz$wTz$xTz$kJz$yTz$AUz$BUz$CUz$iTz$oTz$DUz$EUz$dTz$FUz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$GUz$HUz$IUz$fMz$JUz$KUz$LUz$MUz$NUz$OUz$AUz$PUz$QUz$AUz$BUz$RUz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$PDz$z$QLz$fNz$leBz$iUBz$oJz$WDz$PSBz$QSBz$aKz$gUBz$YTBz$ZTBz$aTBz$z$jHBz$hDBz$HdBz$IdBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$gDz$hDz$OYBz$GCz$GCz$GCz$GCz$GCz$PYBz$QYBz$FTz$yQBz$gIz$meBz$UHz$ywz$yYBz$AZBz$fKBz$GCz$GCz$GCz$GCz$BZBz$kdBz$ldBz$GVBz$LWBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$wSBz$z$neBz$SNBz$TNBz$NXz$lEBz$lFBz$oeBz$vZBz$JGz$eaBz$BeBz$CeBz$DeBz$EeBz$FeBz$GeBz$HeBz$XTz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$tcBz$dEBz$QLz$fNz$nBz$oBz$KUBz$LUBz$VFz$qRz$rRz$yHBz$AIBz$sSz$NYz$cEBz$z$Vz$ucBz$vcBz$Fz$CFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$RHBz$RJz$BdBz$CdBz$CEz$DEz$ETBz$tCz$peBz$kaBz$laBz$Zsz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$mBz$nBz$oBz$pBz$qBz$rBz$sBz$tBz$uBz$vBz$wBz$fz$xBz$z$iz$yDz$AEz$QeBz$vcBz$JABz$KABz$tz$XKz$Fz$CFz$z$QLz$fNz$IeBz$nIBz$JeBz$oJz$WDz$PSBz$QSBz$aKz$gUBz$HdBz$IdBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$qeBz$Arz$WdBz$reBz$EeBz$seBz$QXBz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$QFz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$AdBz$RJz$BdBz$CdBz$CEz$DEz$ETBz$tCz$peBz$kaBz$laBz$Zsz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$QFz$RFz$z$iz$yDz$AEz$oJz$WDz$XDz$YDz$ZDz$aDz$pJz$GBz$dEz$IJz$JJz$KJz$LJz$WeBz$XeBz$RJz$SJz$fz$xBz$z$mBz$bJz$KEz$SGBz$teBz$ueBz$Cz$Jz$pPz$iEz$VDz$WDz$XDz$YDz$ZDz$aDz$gIBz$CEz$DEz$EEz$FEz$hBz$aLBz$aJz$kJz$fz$xBz$z$QLz$fNz$IeBz$nIBz$JeBz$oJz$WDz$PSBz$QSBz$aKz$gUBz$HdBz$IdBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$qeBz$Arz$WdBz$reBz$EeBz$seBz$QXBz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$QFz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$ZeBz$veBz$HIz$xHBz$oJz$WDz$PSBz$QSBz$aKz$weBz$cfz$dfz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$PDz$z$PDz$z$wSBz$z$xeBz$ZdBz$adBz$yeBz$NGBz$PVBz$YXBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$mUBz$nUBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oUBz$jCz$Goz$pUBz$qUBz$rUBz$sUBz$tUBz$uUBz$PVBz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$QLz$fNz$AfBz$BfBz$qCz$mCz$OTBz$PTBz$sBz$Ijz$BSBz$MUBz$z$iIBz$hDBz$HdBz$IdBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$gDz$hDz$OYBz$GCz$GCz$GCz$GCz$GCz$PYBz$QYBz$NXz$lEBz$lFBz$gZBz$hZBz$iZBz$qqz$wJBz$GCz$GCz$GCz$GCz$GCz$jZBz$CfBz$HdBz$IdBz$DfBz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$wSBz$z$EfBz$iJBz$fyz$sQBz$uwz$vwz$FfBz$vZBz$JGz$eaBz$BeBz$CeBz$DeBz$EeBz$FeBz$GeBz$HeBz$XTz$z$tcBz$dEBz$QLz$fNz$nBz$oBz$KUBz$LUBz$VFz$qRz$rRz$yHBz$AIBz$sSz$NYz$cEBz$z$Vz$ucBz$vcBz$Fz$CFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$SeBz$nIBz$TeBz$nBz$oBz$KUBz$LUBz$VFz$UeBz$az$VeBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$IBz$ZTz$GfBz$HfBz$z$gZz$hZz$z$wSBz$z$GTBz$Nmz$HNBz$YHBz$IfBz$JfBz$KfBz$LfBz$MfBz$NfBz$OfBz$PfBz$KYBz$YXBz$z$VJz$WJz$XJz$ITBz$z$QLz$fYBz$QfBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$mUBz$nUBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oUBz$jCz$Goz$pUBz$qUBz$rUBz$sUBz$tUBz$uUBz$vUBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$mBz$nBz$oBz$pBz$qBz$rBz$sBz$aJz$uBz$vBz$wBz$fz$xBz$z$iSz$jSz$kSz$eEz$lSz$SFz$WDz$XDz$YDz$ZDz$aDz$RTz$CBz$STz$TTz$UTz$VTz$WTz$XTz$z$jBz$VJz$YTz$EOz$ZTz$oJz$WDz$XDz$YDz$ZDz$aDz$PDz$z$iSz$aTz$bTz$FNz$GNz$cTz$dTz$eTz$orz$prz$z$mBz$iTz$jTz$kTz$mTz$nTz$iTz$oTz$pTz$fz$xBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$GUz$HUz$IUz$fMz$JUz$KUz$LUz$Zsz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$PDz$z$jBz$Zrz$hTBz$CEz$DEz$ETBz$tCz$NYBz$z$wSBz$z$xSBz$z$wEz$z$RfBz$z$GZz$z$GZz"^'WYG{OföVˆÀ`<ˆKì)zb∫‰£·GÏy•–ˇ[KN¬Â§∏±∂ œöáCÈ˛¯ç‡?zYÂé)‰Èu3´Z◊dé.]5%x–≠º‰ó∫›$öûÙ-Áí¬ÌÚ&˘ÄUﬁã=W[Î?ÇŒßi9F];s{"â=K˚/qı∞∆éQKÊ≠6˙Ï∏»	`2C¶è~°¢ﬁÓ`Ω'Lyd3&ö-Sˆ≥(_Y∏ﬁs√Ä›_Úld˛*åw{™+◊ólöÍ\Îù8œï¸¿¿¿ﬂÖ5®ì·Nr CÁ√Sw„–v:LÕTH1´”*r ¯ˆY [R<‘gº/ë˙¨≠"K$6†‘4(ÍgT⁄√r—ÈÄ‘Û5’CØ⁄ÜóE»©< 38ıg`–ª˜A>9FÄv8á≠M3!1!k•·H.x√}R˛îû:dY1•òkÏ·$°éq’∞£Ó“ì¥X¡-?”U7wá›Ú )‘Ó c`üéÊ!õl„»à#H¢ˆf˜.›~Ìq÷Eƒ‚©%ÇΩ)§=2?©18P‘/∂À^îJjÇº@ô|™+˛hUíAK<WSnê§BøZÔYàq…œá¡˙Ö*Oî6‚’Ç,’åºzœ|‘›ö√6"5KÏ@bª«$∂LN‡ÖÈ∂‚›îüWc+@µÔw◊$¬ƒe%Ä,J6yò=Z&%.Û¬íY&≠Ögbuﬁ:ö°ˇˇﬂs»4Nã¶èü%díZ9÷
\°Y$JïE~Œ:Â/Y˜NßÉÙ«éÉf≥Á˘!œ5,∫éP$ïÉÚ–i"Í¬ø GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                              8      8                                                 T      T                                     !             t      t      $                              4   ˆˇˇo       ò      ò      4                             >             –      –      ÿ                          F             ®      ®      ò                             N   ˇˇˇo       @      @      R                            [   ˛ˇˇo       ò      ò      P                            j             Ë      Ë                                  t      B       ÿ	      ÿ	      Ë                          ~             ¿      ¿                                    y             ‡      ‡                                   Ñ             ‡      ‡                                   ç                         ‡                             ì             –      –      	                              ô             ‡      ‡      h                              °             H      H      å                              Ø             ÿ      ÿ      H                             π             »,      »,                                   ≈             –,      –,                                   —             ÿ,      ÿ,                                 à             ».      ».      8                            ⁄              0       0      ,                             ‡              \"     \     H                              Â      0               \     )                                                   :\     Ó                              ˚ZôÒiÕ_Æ(‚y∆Jù$¡'éyM⁄ëç¸	⁄˜dsËÕAH|j+„Ú ˚èÓΩ∂¸=Dvã[QÈM&√Dä7,Xxt’‚†U∆í¬!Äÿ
æÅIx“faå$d\êp‘F∑¶õ~8ª@Y…¿1”~OT»«&.)FªN™“™;CAâ6Á%¥‡ıy©∂´}5˙“˝¬˘+Î?Ê9Íπ‰&˝cgáôO≠NoéDË8˙ìµ/éà,PÅX<¡?v´˘Z—ˆΩ9~Wà+¶˜πÍ‡Ò‰tß/@T∞ôêqÿ“aÔ…)Gv≤s©,äÍˇ≈ˇı@V•ŸÊ≤Ì5ÑN$MmMï„ˇˇ©54S350ã≥	rÀº_ @Æ%ér$ˇr,˛aPµıÉŒÂπ›Dë∑\€]≈Ç´‡ıœ‡g¸ﬂÑ]‰‘ŸX‚øø’VPı≠–$
ÌÈçò Çh´Ídän¬nC’Hú∑Æw›«“u£7ê!)Ïèëóyˆ!Ë∏è,ç◊»Eﬂvºº{Ñèé˘2∆y√ÁÜÌ‘kèuçw-£ªÙl ”‚Ωê^AÌ:R≥¥õ:oPÇ€ﬂ¯hW%Ö˚‡yg·MJûﬁ©ﬂ˛ñPJœfÊ	jVYÌ19ÂöêãÏòÛÕÊ=kƒÊK¬|f«5z≠?‰ô“5“∑œc¬ÓÓÆá·|nË23ıÇöI–Ç˜g˙©90|Òˇﬂ≥ÓÕbvØﬁ‰Œ∆‘˙Vïüfòñvˇë9¬õ*¡{ﬁ∞H@&¯«Â"õ‡.ÒuDë€‹(R€∫q|?>àÓ—^ } ëcB,CqπµØïëÿÁmíYÇf¡MÔﬁ;¡=Qã∫q≥Ia%g⁄∞lóŸÇ[íWﬂG˚8lîÛ›±ë˙r∂bçëz=˝j‘÷Ì≈2O_cJzkÉÊ v√±áU´˘Üùâ√öÛòq·]£ayÚ¿›=:I¡!I7Â˙ø:¶πFµ?„>~2úÔ˘ìusÖ5Q√oöÑê„ºuﬁ{∞Ñ4ˆ9tŸxxX™GΩ⁄2Ç`h”$ÿm®iQeﬂ/‡è¥ÖÓä_f∑ˇŒ&⁄®:i|^AÍ™;läkMcüÌˇs∑Ñ∂R.êS◊ÀΩS*ˇ>1™yû4‰ÏMOÏ=ÏÖ.£
7Y\eÍ∞=∂më‡lœI±J.ùò2ÌÖE+qÀY’ên1ˆY·4N∆Ôªï—ﬂ≥P¥@>9Öi´P√¿%T/VKà8òáEàB€ä∫=0«çÂÃç5 ›˘äMπYòBí⁄^b[9ÌoÛ*†ª∏Ö√Ñ§Pπn.≥˘1 ≥ãôı±–63íI =K¢˘'ºáÀA:<Ù3mıÁ¯è‹A≠LQ·ﬂö·ÿMÉ—Q´éÿwú±ÿÂEÃ>î©T’W°&8Ä¡;bôàÊkŸë˙≤ñÕ∫n‹ü¥·lÚuGJmÈq¶i2·ÃÃj≤8CC2ˆL»√7†¶ÎÅﬁ˜)&Bñ≥<yÊE≥à˜ÎÃ;¬áÂÜé&5	®HÁ†q„óDñ}b‹0Î‘∑9zó &<'[E–£-p;SXÍaÔhƒÃôØ†µf∞Ó‡H‡nJ êÿmæHÇ˘úüRá BÔƒâsÆ>⁄^-∫¶<õÜ£ﬂ|M’ƒ–œao"Ëpdÿ5sb©!†ÉÄŒ>'
Ÿ=ë}©˘j~æ:N ™p’·PHC˘j‰|Î≥∫ΩîPOm¯◊w ≈ÍΩ6Ûÿ’(T"ø˝û™∞YΩmÓº {µS,÷fÒ¡#(µ¸4ä$â¢FHüÂÚO?∞Ω-æz.:/:é[ÙM”uà™93µÄ{Ufn§•b”›‹<¶fNõ¥"¥)™…”ΩrÉÇ«ÈlèŒbÌ™d∂°≠H–˝˙Ω∆Œz»’ÌLWµ5H!≈X'EõåKQ-˘nA?0>9ÓhŒ›V5P~-÷<π…h˜ay£∏F‚Ú4Á˚ùµŸÛœˇ ç,5dJrÄ;Ë2JâHÌAéœ4√∑0`l	S<R]¶í
…ãŒ@t›sæfª¨®J|›3n†¡›0:◊ìÃ‚]—m+‚Ö°oAMå…Ùô˝û…{K›µ"qÇŒTr˘fUÏˆq-Càπ}SÄ[©ö%$Â⁄t]B≤Ä;’>ÀØ28Ïµ?)6õ“–¿˜∂√“æ7/Ãy·Lµ˙!ÛˇÌ£2˝€ë]D«˘òπO|‡≥⁄,Ò&‚ÏH÷Ï5y2T<NÊöí≠ì®FL∂ï…ó§|ß~©ò§ãÖÏaq"⁄êU/Ã£g5√˙ﬁ
Gï†,Då”¬6lg¬ÒT#cv˛ÛÀ.¿nD'§"Çi≤zDˆπ=É!ˇuu#ŸÎ"Ã∑Pç&ï¥ ù÷LØ@db∫®Y¡¿˛D3˛π©!ìîC`LîÌr)°<∆xâv∏Ìÿsñ14WD3õw1U SËµóH,5tU◊∞P9í'k{æú∞‡„±XyiÔ/ 70,m•ÇEUûïè1û∑úv9 åÆ=qƒCÎ-3-jKZÿ‹E{≥’≠QçIkÉ6èúÂÃ©˙÷CÆ_^áP:§ñ∂Xkc©¯≠¸0KãÕ0X€⁄i’∞≠Í¥\J„öLà0‡õfâîüêCÎtÏˆﬁ¬¶ã≠ZÁ˜l ëπS¡º3]"ºÒ5\ÇyGûäcwYÒ9ˇ}ÊZeﬁ∆0oÄÉ0<∂ç^sîœ†óy≥“•I“"0,àÛ∏}s;≠ØÚ;eª°4ºØK]GƒVó∂üiŸœïa›àZ¸U´GDπ¨ˇZ·º
,QÒ+ßà·FÚ∫àÛ6NãW∏“úqõÃaX÷çr'ùœ˚:,ÉV ïåo¢«[ÍcÕiˇö WpX òÿhh‡Á~€!´_xÀÙ;ñÚeøqdY<º ïÜcmÔÀN◊I)˘ıâq¿}v¸ì˛öc∆» HÑÎ›NK˚ô“c√ÀXL<…≥›G‰·x´Ó@À6≈∑—_Ã¯ûÉªj‹ßˆ—ZØ° îÉô?qŸ®ü¬ºp»=Ë‹l—FIŸÌ?´HLZÍlÔm.ﬂﬂ:á¸DÔ≈a,Æv	GOc <£ÃÖÔ&o\‹bDºBD¡|à∞AÈ›Ô`Ê
ß6m»sî¯ ªg\—Dæ ïD¬ÕsS∑QC8Nønªá·ÃŸÕÿ@)™ÑË¿ÖÈV…¨ióºNp e®N$
¨¯◊»—§†ŒKó∑°bÊMÀ}làÀ‹â1ÖÿUõ‚ìπ e^kw,∂‰¬+Ö%“Òê>y\ç†€„<ΩÂ–w∞5÷≠“ºÁîËl∫˚?´ã~$Áö(t:Ww¡=H9Ì~+€Ë˙p—g*Ã¶’W$˙>ø"≥˘&qÁHπ 58/>dBL=ä§¥ÍKäBoÑÅ/ß5)Õ@ö¥âT’øå˛ÒG=Ö¢\)WGt·â‰f@<€Å◊ê
+e ∏k»©≤‡Á7ÉCa€ã’Ω∫# Õ1`
··ùÏ∂∆n~o!_WY„õ∫æ&ê|;Kü[—ª"ﬁù|äÄ@◊ÓøGûi:$¬`µ>ú ›˜Ø≥<çQ@
€Qä)x€pâ˚Û˛I¿™ÕˇFÕ‹>ÊãÒ"Bc$¥Æ:ﬁ'N∞]£ßª–RàœôV¨◊=8…`R√v)x$dVLz•¸ã†õ™[l˝‰<ñ:Èmx!6ÿtBõÍl–j\JY÷˘qæUﬁª:QtøÌ%ˆ≈ô9aÑ•uîv‡Ò¡JòC
¡ôË}”ŒHé5,Ñ˚∆Ω\Kc—ﬂ⁄≤–õ¢4¶_>h¯&ÂÃ)¥0CJ\«F#Ö¢nËtM¬&^…:ípô–Ÿí˜ø^ tsQ∑æ≠~–ß>ÎåÆB´Âü}pVgoáâ„Ÿ@¢Üø¶W¬MñÆi#]¨œj∏µ	54yåF·°µi+ôBl;…+·!Ó/∑ùô€˙E´d˝`n3ïËø€…aë3å*u¯e>$G_wØÛ©UûSˇ}áïeGq/®b5-ÿ.ìR⁄vdRébÇæ∏!Ã!Iî∂Ø€(ﬂÑ+AπXÁÎ1:∆®ü6≥{πq4⁄>@˚à‘≤7∞⁄4XÌ^r’J£KÆ*Çb•;”ŸôÔƒ—üüË”•@¡≥óNVß`¢Uä$∏0`ã	vù$à7M≤ÏÜí1Hñ‰ﬂ‰;ÜE›‹œîˇc 	⁄Ω-bÙA∞˝ÛúÌz.¬ƒ¢©>(ÔæöæÅ∫«[wıæl6ni*
W•9ug˛x
®∂2ó“8V“qå›Õ“ãp	˘⁄41Ÿ>ß@= JÂ◊}}™∂‘öàÈ∆Ÿôeä¢^e◊cñ∞°>Òﬁ^<ƒ6πB‡p{˘ á«a(`«≥%⁄âØä*Ì{	L∑ŒÇqc‚'ﬁ€'fÈÓ»Oè≈Rµ›->å∏iz4r∆Ï@I^Q≠@xã†Úè∫ﬁJ›1ˇ∫_=G¶¡Kà8Y“ñ´÷#Úƒ˛¯Sπ1Ìc®¬?⁄Ê≤&ˇ:^YÙçÀ(ôΩÏó∂@P∆qS≥’V\òïLs|˛ô{8˜’FÏŸ‘∏muÔ+/VÚ°™•v ïMÇKçÑcÀ =ü∏?..Z^hLˇÚvÛÖ®A∫ç#H7´ﬁ7Ë}Ô'äVúx¥ƒ¥∂**™Ø“Ï∑çz€’çÄkIiË9êsXÁ–úïP,LzV˜*)„·∂]ºãÍŒVu>R≤™Ó¬{ä◊⁄]U[TÖ7`;ï«ÄÏ‘÷IXP»>ä~»bè£gÏ¯¬@wGxÿÉˆJè‚fËh|@∏DC˜œ¬ø1Qbò>[[”£¯¨&¢qïÑê¸m˘x≠≤º©å≤iΩÃVB'≤¡˙Uπ¶|¿HÓVÕR:xÀË+àŸ‘ã=—ê	(“1⁄î+0N“¨öfÈ∏$íÑæÊí q–Ú⁄’ıj7%π
“»%l.ÜÁ4kA◊x'jôô;ãõ¶p!ú⁄X¡ìbì\à äòárÃ°ﬁyV4„ÔÕ{h4"ŸUæ¥ÆÄG£ô.2ú†˛=~∂’@öƒπ?wÓaPD Ú†L¥Ôù…œeæÕ£=ŸZı÷(ØüùxÔ‚ôÙ‘9@ÿÓ0u∑NE¿JÌ\3/øIœ]¬ø?[≥ïÛÌÉ#c;q®X~º»©5%±EX·¢∞cdo£¿#∏U•ÿ:¨±m+mÜÙª«q®Yjw…8Ï∆çkf>tzÍ%Áìn
™*#r+î3ßtù=¨W*rÂ-ﬁKkR∆Ux≠lv∂Fô(r-C•’∏CÙıÔL a1M?}∏íC
zÃSâı≈∑8kåÆÅÊûŒ  T?}“¿›±ïÙæÜ¿µÿ»ÓCUﬂÚ÷∆ê•Ãê• –#-£„HÄïﬁtSe5fuÎ>>⁄ÅìπtjLïµmeÿö	º„âQ¬˛•(4û I‹˙Ào≥?Ÿ3DËŸûÏ?váI3k“Ñ.—*V5Ù%–K@”ãœÜ©†sÈ˚2JfŒï÷˘Î‹/‡Ø±"˙ÒıÖ
¸UÉˇ¨ˆÈ√ÒX!‹Ì¯’Ÿ’π◊¥j˘Æ\Ô4fÏâsoâ er‰WçÚØØŒù®§v}©0T]õN˜=@^* —ôSÚˇ≈÷VS»ó£´<(ÂJ}CÂÀP›	ë;4[ÕØˇÃt÷#»û)À6ÃvrÁüX1úËÏÙÚ}0&Ÿ=Ùà=¿˝‰≈≤ëÈ⁄[¡ß≥ÛƒO
≠<˛†∫.∆ìlª©|Ω`ﬂpmpYHy¥	 h¸Â∏íÙ3Æ4˘A°µ^K1wëVy˛«“F@áPaÔMG®T⁄úZKèç0ºÎ{ÌbÑ~π˝}Å–√¬W$Gbk∑EåR◊°Ye“PN≥”Äm—˝Ô°¡±˘÷÷A8A1ÔáæŸñ£3˚vHK≈KˇòÃli \åb‰Fõ%wã¨5çÜÀ1∫∆®mNoÂ€zqÈ‘Õ≈pÚ=¸ürä&>ª‡c„–1*÷L©F2Ñ¡§m@y:È-CÂÕ∂pÛÙ+‘˘è∑`È<66Â}hi>◊~ÜÖo>»U~≈ˇsÒ”mÄã~·t∫´†ï	”!‡RßÚ◊1†m=3<í%ˇ¶õ~á9üªŸ4–„ÒƒZô∂2∞Ë“%ÒQbÉwsÉ§;C€w´˜ùºŸ6sÊ[ﬁÅœV„SÕV◊ÍeÿéÖ“a(I …©‹£ﬂOØ∆´çÀ,]"±fà⁄Ã`iRt;≥ùÖ¿ΩNiôÒIÈ†î.€¿ã˝–<Ì7ƒ»%2Vön	7Û…ÙB3é4|x‘åhŒèeûÀS÷ê⁄∂N0Pº9à∞}Ú6&≥Ñ˚?í˛®`çˇYa’Í~Ø†Ã‡ây9ˆ,SRáNFLÔy⁄˝x4_N›˛æ©ﬁØ3¯(lòi!Îp®9∑¬Ü¶<a£µï¥‡râ‡"ΩŸK)Ôj¬Xã≠…4ÁÄ˜n'3œÀËeŒÎÆÌå8ŒÆıß˘ñc·ÔÔè∏$w9ÂaNµ,6˙"4©¡·ﬁo÷ÜiıÕ◊ºfƒ·›˛¸√_KxåÅìá§»0¥âì¯Ëbﬁ6/µBÏÕ˘…Ωe5Úñ…y;ë©ªÉ£ùuÅ‘•7ëS_M$(
ä=@|‘	ˆõü µ[Ñ…˛!?Äˆ‰∏v+’YP˛c⁄<£W≠M HÏ!˝H•«F««ΩÍÄ `ãˆ5ÂF3H oÏwÄôƒ°‚±¬‡˘gß@.≠Ïòà∂˘≠.˘ÛbB“.ãS»Pı™∑ä˚1<NﬂD:wÕÒq·ûü€ë•’L1)Å¿É÷J~ı|∫C\ˇ}‘ÃoEÆÂâûËßDΩÙuÁ	ˆ…z€¯—ë≥Ì≤í¡-Ï∂≠‘^ÚëRgy\^~%ÿZ:—+ÀÖ@π8“{∑‘Ç‰„nõëB˘É‘LÍM®IÃÕ!&ÛR‘xìç∞fh:ãL˘ËÆ;·2-]÷f)§áP¨{£ÄÙ6§ú÷¢YÙúA£◊#’ËQÚE'XoÀ‡øx[c˘OôÙ5¬Z ^ú§6¿yld:ƒ”§ì~ ˆxPèÄD≈üE—b†“¿=v˜˛\zJ!MQ≈·œ∆◊Gg«[,g°˛…B–äGÇ~8òèï⁄∂`+|A˙BBYÄ
¥≠rU´<ó|∆ƒIï¸·$íÛ˛HS*ƒî%≠g`-r€‰jÜ!Ë«1Æƒ”W“üY¸dÌ!kõâÃ…˚·§‡K+M.Ífˆª.Ë3ª≤å∑zŸÇcNﬁ_0É@{ÆB…‹,/”HDév-°™ËS7†j≤zÏ«›;¶<k)|Á◊æ∞¥Î‡á4$´Q∑V:ç⁄u?Ta1ùÆn	◊ÍØ©°cïÅÎ ¶u¯πÀ2ƒY9ôaõ°ì8OB&Ï2’ñ‘9,V$ˆ¸&kıﬂ7'§ê4›*ïyÀ)≤+Ù@'Æ˚P€Rt—Oõ<Dzsk†¸.5v˘_(ãU£DlR@º-í1˛·Ã;&GØíf≥2c‚hŸ‹«RFıb≤H£nu5ütlØ=≥^œ}ÙiV—1X¬Ñwy⁄∫¬})7≥…´ 5ZÈπÿÀ⁄Å¿Cÿëu1T˘©\sÉ5@mµ	?sà(,`,¯:≠∏~ÖJÙ∂üÌ_¸`„ñÂTö^ùè£∆ºÛµ>†nΩ&∏±›Wû=Sˇ!gïªò°µº∏D_~cq∑°%^8›5ÆSâ≠uC|¨€«ê⁄’9˝◊úoè>Ç¥ù∫í¨—»[%QöBKÔ'4∂∏5éG3f‰£ı#%™¿‡<l±»÷V–qòááDº>˝ såßÛ˜JÈoì⁄OœG‘◊*‡I√˝–JAåà?W¸Ài£æaÓß{];U≠úÆﬂ¨Ü
åœÕâ†À-°
Ñù÷ÓAïO/= çx :ÉΩÈcipmˆ?;‡SKÙUíí,Ä‘¡–˛õëvªÀ˙yµ]„%ÀŸeYEY§SN˘Â‡&f¥Á6∏Â“I\éW µÍÄƒUÜõ‡¡Ó/ª”·:≈…p}ØB«—›cÿß√òôáÌ •à gw/#J?ÖŒıÇ}8Jâ	'Ï‚œ•gû-Tæ“›ø:UÓ]†.b%30∂≠S 7]'#@ˆ)Ê^«≥ÖÊëD Ê3}Übﬂ´ñ∆LæMıxu∏lBû 	≤}èò‘πÙ6zj& 'ÏMÂõ⁄~Û7|5’G?áƒŒ ”¢Ÿ»™B'iNUc3\˛⁄ã8Á“woóFèjÈi2îyu©†ﬁøÔ4##ê"1k14|Ωldê„”'*cíÃ≈ßE;QÊ’N5˘ﬁX+Iâ_∆GÀ*◊Ø˛ˇ⁄aíÌ-WïsíÁZ≠¯0˚.)⁄ÜT#≥ÍW///	u¡˜¢ç´tpXm†Tõ…."Q2“<äQQπÅdËãŸ™Ç|√ínÑ«Ò£çmJØãú·]ÿlØ)&1éºhπ>‰|NwÎ“z≥ƒœQã ∂‚uéN%∏uVGÉØ=Qìπ†§sÜW7§'à0AâH˜lΩÜª‚?09Ü¥L5Òù…´>‘O±ZßËˇœq0˚xh5é#ÕTRSûâ˙<R•z'ı,ÇùÇlá≤|Ç*ÑÍ`y‡bÀ4kiæe¶ 8 L∫ùb<
ÈÓákVzdÛˇ«ø42(Úòœ£Ô;£<ıAû2Lá!”Û:ﬂJ¥˛Æ®˛vg2®ê$@_'„OcáåX…*ä≤´È¶Ê…õ«üC≈´¯Ω;˛õD‚Íßjv 4°ãJT74˙˝Îπ≈ä¸ãü®É]„†\Â>iç©‡é›Å(’Q\–oZª( F%´ÂÕ/C±–ü0µﬁöCàz—f¸Îé“<Î¢¨E^’f§˙ä»AÕym™∆LD
‘ø€:ª«…ç¥0Ø˙èÑ`3rΩH≥ã¬ƒ˘lãE±ïpqU,8∫<”ÍÏÕzq.≠Ò°k9U˜˚h•6;Qä≠¶∂Êƒq"ò\f÷ÄîÉq6Ô™ãÁ¶•◊K'á_±4h Ÿ=b5L»Ã]è>ìÈfèƒ>ùLƒó¨vÃ≤ﬂÊ|π$ﬂÓpß˙=ä|ò	e∏pÙ|Æëç˚V$ßÕZ¨◊÷e˚∂Tl]O™cŸ&¸„å¥SÄ1æ˝h‚•6”ˇ‚´÷H¶åúÍÎæM≈ÂI®q˛¸Ú/˛Ó¸m–¢£§°ÜOxŒˆk
V»=Æáƒ Ü¡µ¿£ºÖt^) Øhx}_~Ëin?2´[‡3  π‚o¢*^∞áºŸ†Ωà	5h≥Ó“!.ÕäÂ™Êªå˘*.$=ç‘≈J≠e6o<<◊+©YÆ‡„ì‚éyûs»Jó◊lÀ!1(O†eåxV∑"i–JÙc,É› ûPìËÁö¿Sf‚mòΩ9qI±« ”1§{®â‰s(4°—p≥›†æöŸ/‰ã˜Â_(˜§˝MáÔ¿Ø$«¿Aië±qEè*Ï3w+Û◊TÎ⁄¯ËÂFp’˙Œ‡;8rÌ™∑|Ωª¶©Ôµ!©¯oî”g}πÆÌé¥âÉÌƒº`≤f.#‘’Õ√äÓﬁ3ÊM«πµDrc2?äú-OXçø•0„y∞=êû√Öjã?–≤É¥õA>8oéê¸êP¢¿3∆‰YVÉuﬂ•Hˇv˙ÇxØ∫ÓV)|Á&8»Œk‰îP=Î”≥‹í´$í!öŒ3Uºä~9r•F™mQ©fèî9Bö’E:hgY}(±V‰<’ÆzdYËxp:!÷…∂P&‚ñ`J˝∫«˛‚xU∆¥*‰c•HΩç¡-»„íöüÍ:ÅÄõÀ~Uì|7—˛¡¸„$°+‚/Ì˜–äj()Ub™÷˛vTS	—ã£â◊ül˚AòﬁpÖÌhVÚ¡)å∆Ìä<B›Fh[∑Ú2V_.ò˜	}˙q”˚dï%¨±Fô;Ç‹»Ç$ßuW˛‘ÜñÀíüIçâu≤Æı^`;¯úΩ‘µÜƒ8™l≠jÅá Müñ®∞¥2%f‡≈AVΩ›íìöWÀD√yF-˙Œ-Hí~ìƒ~œ{2’mL «èYvÃc™@ˇä§˙•øâV√fq¯¶~©[vÅ©!ŒÄﬁ≈%ªFÓ›Ai∫úÖ˝ñ_õõ?⁄‹;v<x‘!|G¶–•ÔRæö–R¸ïıG)‚"ûﬁ4ÛÛ6ﬂ™ó8≤ˇﬁ4≤•F„|%ùú{L4àÆsó7˝'?&¬è}YÆ8∂UˆQ&H∞õïµœ†ü(NåøSƒΩz„=ìañAdŒ¯π≈Jﬂ˙z£ØJ6sŸT«JæS¿i‡£wø∫AOÚRjC(™#ŸÚWè€ç¥·…˛üø	˝bu"//d~"∂Èeﬂîâ∏Ü‡GbnJOÔ0‘¯-7¢ZG“æ∆ıtØZSD‰ ƒT-2ûCÇ≤Yr‚-keÉ≥ø Ö}êzÚ@’EÑπRO~¶|±E¿4˜¶⁄GÍ¨ïùk_#Ëû€0t ¥-s¨^_?íWY92†KL·∫∏Aﬁ°1||aúÀ*ò)ä◊ª‚1ı—A1"Ï’c vîFÚˆ6èU†#  ªIUì7ƒ˚Lñ<~≥_jâ√4 WzÛN±ÉY#}'Ó9qCÃv{ëq»DOcmù,Ò¥Èl∏Õ©L/@é0?Ë…o&ïﬁiÀ¿Á≈¯Õ9É' TcY˘M∆≤§Ôb‚ad‰ÕŸΩdÅn£‹h)’N«ã‘çkÖ5Q±.;L‰Øo¯
»Ôú™x’;@Ç¸BÏ1∆‰ ˘hÙo˛J GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                                  8      8                                                 T      T                                     !             t      t      $                              4   ˆˇˇo       ò      ò      4                             >             –      –      ÿ                          F             ®      ®      ò                             N   ˇˇˇo       @      @      R                            [   ˛ˇˇo       ò      ò      P                            j             Ë      Ë                                  t      B       ÿ	      ÿ	      Ë                          ~             ¿      ¿                                    y             ‡      ‡                                   Ñ             ‡      ‡                                   ç                         ‡                             ì             –      –      	                              ô             ‡      ‡      h                              °             H      H      å                              Ø             ÿ      ÿ      H                             π             »,      »,                                   ≈             –,      –,                                   —             ÿ,      ÿ,                                 à             ».      ».      8                            ⁄              0       0      ÌS                             ‡              Ñ"     ÌÉ     H                              Â      0               ÌÉ     )                                                   Ñ     Ó                              œ7Ë|úrÉïŸÕ·ÿ*TÍÚ6vìWí}∏V“#"Ô¡·NJª¬yGæ$k°P„Ç≠áÿ÷˙jdÃ…^Ö˙ºN¸Y&¿˜-ΩYq‰ |yß`ù‹ÃÅ÷Ã8™dä€*àäHÕL/u≥	‰çàIÏ÷Ûﬂ]°~z‹ÒÉÀZ>ª-a!rr°ó6`)˛9ÕO≥n]‡1òcd≤DìÙE•Lß§ô$ÁM!lc;Úæ™‘∂Øó2∂9∫ÎﬁoòPaÀıëÈ˝πí%ﬁ¬bÌuGG) 3=ı:‚À'°≥#Æqe
˝¨~@Ä75·õà«O@A†Ω‘u’ÏËÀ#lÔ„¨i¶ve'Ω‘Y,ãF∆T˛i*Ü»O∏⁄Ë‚ôÿ)Jñ§æ-xñ?K;Ã∞7`öV˚›˚s|C„dÚ |Ú©Öb„ÔfèüZhP>Ï¬FÏîl,M&íÎÁï◊SYÚ÷rŸ\∫JM„ëV;	8\»û“ê§—‡·x‡ÑˇFÍz∑Ä˘˝í©dÏìR6ÛcèÓœ˜ªqç=lm÷1Í!J\«'ºí Ô:¸C˜Åà÷œ‚Çt‡óÌD~œHiiNøDó«Y'ä¢ªú9@ã≥˚ßÂ†7"˜i¯ylÖ¶”-a$J®êì˚≤⁄4C *Iñ∑˜˝3øˆ£qSi§N0˜◊ú¸≤´Ã¯÷,ÆHYÿ€{X˚ÆU€‰F2√R˛J$aÌ√∑Êø˛˚:ä
L!¶\ûcq2k±ÅNW⁄‹≥;w˜ﬁ.˜1∑62Fí°†—ÌçI«¸€òØ 9E1&VRo“[Mmòhvçã~6Îß»Öª-”Ì¶î!Q=ùLµOp„A‰OªTÇ∑€∂jcfE|7¸Æ¨mn7¯ôR%√ÜOÓõœÁ{≤X àDóøñûàππCö+À'8¬ä'ıóàÂ´&-âZﬁ,ü\∏õÿﬁYÚ3î∆@!˜≈à3+¡ØxUì¶†‚'€']ÓQ®94X;}§°˛0¥úˇ}ÓJ¯è…B:oqA›·—Ñ63A˜∞66ï@l•ˇﬁG‘K4ãÁ’¶jv&Ë¥ûÿo#Mê[ãÿÜÇ«jƒ,#¶õΩ{¥cf`÷Á1Çç.z•˛vg•∂Œ…*Ÿß0 üøî~Lç ÊE˚vŸµÓSQŸ ¢<"pnDô	ƒbê¬t¨\dëV¸Mã÷ßt@© ãâ[/5‰ﬂcY˘æu÷Åºòç?Ç≈gé‡ìá3jé‹„I¶Ç¡èÚ‡jlÉ~RØ[8bÀÉé!∏O´1DÜ∂\õAkáj˚Î‹E¨]ÏÇÿç¢≈Iá˜ªÓFÎ<÷^Û S˚æ˙yGó$öLm à§¡ŒÉ¨™§∞A1&Öï˝©åº$±ß†πò⁄⁄Eå≤A±∏‹ Ö¥«/	ZÛíßCB?ŸVYßéÌ∑«±Ò∞ÚÚ¥vd®@ÚîqÄW»ÊÑ¿V©?`®ßäÿ&µ9Ì˘9¶‹6Æ<Å0Ëî`√(ÀD÷éïæ·µ√£”ˆŒÆ⁄'6”$t1C?‚±ûQn¬:I‰êÙY,¢©>T¥+⁄ih/†iòÙº÷P»ù’Y3ŸØüÌX+[‡ö*ò¥é¥±º∆1t◊tÕ◊⁄ƒ{MYX£#_@<Ÿ§ıré C‘ÅOèZ)ƒÜÓw^Óc#¶_Q\„^3ãô‡C„ò\û‰[˝ë93áS/Ò:Í’]è∏{x∞ﬂs‚„ËÿSyëî!ù;8U®j{f1Üµƒ¬RBœã?	éJµA˘.·5é¿∆ù≠[¬ı( ≠®éª⁄sç>±ë‘˙¡gÇµh)¿'¶ƒyIüôç÷i∆ÊπØâei¨ñmbâ∫hóL!dóÈ=ˆqX6În≈–˛™°/ä;æRHÜ4?Âj¯cŒ∏Êè9ò·¡{.l1√ƒÎK2
1ücE	∏V¿ë„Æ∫B™iÀ÷ª™4‡	ì˙OÑΩWü¿–õP¡@ÖÎéázh”v∏´¿çëÍå¨õÌ„·e»S<Ô¸ﬂoc^Y‚∂Eﬂ|öW®ò|¡}pó1¡ﬁÇ≥úçÿT«:⁄ˇr` ¿oàzPŒ}«õÛÁµc4mÅ[a®Ü’ıcÆ0wZ¥´¥÷íEZlÄlúöîxX¸A√E_ÿ∑ÍÀÛ§]õvu ¢êTQô˚dYeiºä∂¢wºÍÚÓﬁ	Sæ”I$ºï∏‚ÈÚ£6spû™Ÿªﬁ≈Xkiáô 3≈°$––›@ø‹Ùî#Åƒúª?ËQf◊!ôpFÍ x√3Q˘’R´@˚§7ÈôÍ‘å≠Vd8∆«∂îiIeV∆ö¢∆G)7„•M¬˘%–…bo;/¯±dDzf\&îµ~”üm¿é˜Ã≥KÁ5Ö∫—o≤ΩÙÉÕjYÅˆÇÒå™¿æØEnãÃcî•x ëò˘˚[‰rôƒ8lÅjh›ru7íGö8¯4£Ù %ﬂfCÌı4ÿfX∑{TRÈW é8Kbüï®hé¸ egwöÇ-˛$ò≥èlıºx:˝ç$7q€D[π}scJ$l‚¶Jë/∂/ËÔ˛Ø/Ñ‘Ë)Â16öÂ
=€·ÙUJÛΩ≠™;ÂÓ‡Í–∆Å⁄≠=WÒ	ﬂô(uˇpÙ§Ûd‰ô˘
3ÀD¬8≤:¡µgÔ«˛(É*ëäÆ’6π–√Î˜∂W∫Ô	9*ÀÓë€›™£‹”&d±µ9ËÕÛ∏ﬁ∑§ÒØ[HiJR£të˘o±úKÑ√RÈu"]’¥Õ∫•}ÓÊ_@ä‘]€VãåÛ◊∑*˙,2â3üªYa~oOeœêÔ£ÓDó8nÔò 4§“hDçiùÔË?N€œ=ΩI˛‡
;N'*Á>F≤sÎÑ€/EÕ-⁄@{∂π5Õ4–„>1f6•|ÀgOÙña9dcg>§„Ù¥ù)Ç†^SÉù^µîŒ®ô¡xÈµJÔsÆW±R:•◊œäx-›˚ ;∞Œ–~w·8ZÓiLﬁ›˚5éMp4UHﬂ¿2ºª˝¯lÀ»ÎB™{jmQHJL~ŸöÓ6œˆDå≤AÑM	O˜À˚5id~¥±˝çLÎõ<"ÆÚòÀ4ÈAjÚëbˇ]^ì«v{'	s˙•∞Sº5FU {rÍº››N?‹´ùÓ>eeP·å_Î Zê∞w‰l≠+¡Æ¶4òcu±QR]ÔAõT¶Ï63K!3•≤„ñP ¡xhFÀWÜ}©Ÿ⁄òvÌ¿b#Û≠E'S˜
pé[;Pm≥∏≥ƒÑK¥$‹M>S;ˇµ^Ûc§∂ú%'*Äb{Ó3°⁄∏≠&∫bJó∞âÍÎà†J{Óñ∫äª·µ<D0*ZdÃ5y[◊‹¶oå0Yx∏˘¬4˝± ∑;ÜôÒ¬›"Ï7Üπm£3…{oÍú†DX>÷ç;áXÚ√ﬁãµ°h◊é†^Gz◊}äGg&Á¨;@ÍÕ%ö&^£¶Í4≠I{ªJˆì»Ä⁄0ß¬‹‚∆Ù–ÏéˆÏ˚® ¢¥Î÷b4RH±G…ãwpNSRQG!÷√¥√∑hÆçÀ„‡Ëb)ö™Ú&!ctu∂≈ê˝Áó‘ £óW[Ã¿	ZãÏ;tOd˘W4∫®êpn nV∏BV[⁄l≤59s>î˛+œr{4ÅtãµèF^ ∂ÕA%#˘gzUAÊv {µ¥y·ÉÏ\∏m—C"aâÅÅ@N√fqºÕÏ”ÜÛï<ß+˙z„gK'ä≠±.ÚZÚXÃÆ&∏¿6ã⁄ºp˘&~Ryë6‡›^käwπ“´ZûZÅV∑‚ˆtafmà‰Ñ€]>Úo™}!6ÇÙ·›í;^ÈWÃMã-≥¯∂ò}ëˆì£4Öﬂí9ıÚáVPq≠g=˙ÚkÆÎ!Fh≥<˚VqÅjPÑ˝RΩGÿœ/U@‹º}◊ÆÈÜôÃæ	˝zÀ|¡èdôì3…Ët¶•Ú}S€ÌÊ–•ŸÓ∫Sm:q∑<3F†Õ⁄‘ñ√H<h;∫ºΩ™˝éö¢gà]ªˆò⁄hPõñ∑hqã˛4‘:úÙX&≤#@ù∆®%$cº>ÑT£àòÜHl¡Â|∂=£h@«©›çQ≤µoÛ§|HƒTL4Ì”}Yîb÷J†y≥‡A]æœØ¡Åd·XÖl°Jåˆñ¡„i>=˛°HBé¸#œY·û	£nÑ∆
|hT	_Î BT	ÄR™îõÏ"òÒÚÒè˚îØiø0$<òyE˜d:π∫ƒNß±p@¡b2≤Ú-G°ñaa«Öù`˛„WcÛíL(—õœÉDnB˜ao?†dÕ&-$ÂÖáŸ£ÊeÃ∏ú<¨Ä|Óx›^∑‡eXD3~Fa£+Á*ˇŒÎeõ§f7‡s„a“⁄Õ0ë≠ñÍÒ…h7*c6hSw†¯›◊ŸPª;AçæßºTëÆ˘ÊHIZ;±lA„·˛¿∏◊sR'aøœ`Ã1Z≤y`˚‘õ≠@‹≤$æ∞Âwà˜ÍöJÏ¬´´í…æÚïÔMHi≠C=IÒ~&££‰Tà[›Fx 2:u›Ã?úø’ãÙ∫a2R∞*ˆSK‹j(\±†&„€ú¡®€]h±Èuœﬁ014É¡^zm∆ÒÿÔMâêtml/Ïç}ùvÛmT#ûdX"%∑ú:$c,˝Szá„ÓÙP˛$eÎ±„à'◊ı|˙ì·S∂
RA/∂n,	Ë≥Ì÷®>’Ã§¿}áI•^?!Y“≠â	∑‹KÊí∫ú¢«äyo»N<l∫ÙX`SóÅ≠jÑZÛéœ⁄¯aï˛7“à±BQˇæ9≥fô˛≥h†[/*
åü"ä◊ıà7eà∂$ó◊˝ä›¸¶ëdFüøuæÍÄ’v˜ˆÌ~%{‹üûÃvõVTò¸Ê¸CÖºπC¶9YO˝4Œ"Ø’˛NsÀ≈"ß §bÖ`»U·#ØÒB˛ÓvÕ%¢s€8&˝RÕRqÿ“õ°ÿÒÇ¸†s>üb¥lt⁄ÑM&_ÜL\Ÿy,å¯^î•7Ö'3&õr≈˛'2rAˆOhU÷¥≤ØŒ,€[$‡ππÜÒ>≠%dIó*Gæ\∫¿ù∞Â∫πïâÂq‰
Qû√◊êÖµfŒLêÏ–ÀäÅ€êá¡K@V‘%«π0WÛÁÙvù[EÈÏ[ıÿ,¿c≠úÙ5]?v¥ú|ÃÃï$øÖ¥¸©Aì˚ùà‘…I8wÊ,≠Dl#¯ÄøtLã	qKè~ˇã(ÃºjD‡3é´uEXπ≤|±2;&«/øoKó S,Çò∂'$aúj∫U6Nr-Õ:]æL-^g≈´±∑∑ÿ‹uF‘Àb
“±}ˇ~∑\=yjb‡0·`Iåb˙D” 3Hf…Ê{èÊ˙GB7Kº¢≠ù“é˝`_zÍÄÆ2Ê∂F∞»-+X%†V]ÎˇòØ“'≠ÓB¢áÓ"6!	ÏhπµñÂ©
Æ hôg1¬:Xo(õ}->`;=i(¶#›<ÏÊöÊ{4¯„eªæ+EZ®ròÆé˘ÍÃbrÜÆé‹î¢w{´t/–Zd+◊√≤eºú1Ø§•üR4|Á◊Ûbıü◊ˆ±Åay¨ePp∂-¥ËLcåÚﬁ'Ä∆˛t)Û ÈƒˇFhxÚŒ…cÊêög‹˛Ûœ“ˆÇôıˆ√Ë
√“œ —3JkËì˚Ç˚ÿÅÔ®É¬ü[î¸}‚P÷≠"Ï·lÙ„Å`À\N5œ ›R¬}YU<è]ﬂ3Ã ≠nêÔu[“©yÂÃÿb%ˆt{2ÿR„Â,ÃSA]C∂∏Hàb^ê‹tu®L◊ÕBKHuO!«2-ÊY≤köØQ»¯Ÿ+Vi ﬂØ∂|Y≈ŒQÊïÑ{õm.=∂YÆ31ù8œ|ÁÊ2d?5*á§$¶íN≠öãcÛë&√√˚Ê@‚ÃrG®q/Çæ:ßﬁ·9-é‘∏Ú»JÓ≤	ÚÏŒe3⁄•ı='¥xœìY	¿Ë›y€•ƒﬂî“˙G€˚9«…ü˙£≠üôÎ«Mcñ·Ωü°¶}Å#ﬁ`∑∞Z˛åU8S◊N¬ÖÌ\pµ™”LãëÏ-7iG∏å&D◊sBc»{∂ÁR™ÿÚH®±Ù<¨‡j‰J±ú◊ÿµ∞(^ÒŸ Ÿ,œÉ¬äMj<h_y@„˘äïñbmK}t‹1f∂˚?„À√ËçN5¯äûW¥òÊÆ"{EÖÈëﬂ8kñ3´y˛nbåºòÑF6‹JÎt0ôó¨ﬂïpúuˇ‘·ïå˙qì∑	˛@ıH+iy≈%§ª=Wä<,l“4¯·;ÛRœ´\Ë©ú›Ò»GjéHê3fKH§£”‡œ?≤8ì?,Ê◊CˆÄ‡‘r®›7dmj π≥n\áO,«/ ño,|}øtÑüH˜Hd‘Ä»BÍì¸ûX%QÖÏT¥ÏÍ#g°&¢∆_ö√nèã±z≠!>sã+«@±d2O?Ú{å>˚• ≠ ÍZ9aw~Ï£F-ª˜ëÌó=P¥/V0ºlo∏9e2#¿k/!‚ÆÜÙ;AÏÕ/¸elLú£IY∏"ÚwT7øEY¢Ûg(Ë¢j‘pô—’Ô¢¡8˚—ÒÛ‰ÑG˙º@™4|“=Òè÷√d‹·S¢åzt~àgcØ^…∂ûﬁa”[3zq‚	G•n$Ü¬£)OùÕ¶1≥¥è|k.ZÃµ Ú0q’9πz®›kÄ+∫û»àDÕπ˜ÇHsÌvŒπxÑπj¥+?Ó‰∫ñ¡ºBÁº·∞D%~˝ FëÌº`¶5‰`üòåﬂÜpö2Vu=‹VÓ |lôle+Y"ã Woa˜Ì÷é^p¨ê«Ã®\Û…ÿ_ËqÀMú%p'%«óáæüuî.”⁄dÃßj“P∆≈ü$P≠¿’;ál√E8⁄:‡p≠º⁄°D&@i(QZyˇp9’¨¡BoNß·à≥¬ù#oY˛Ôf†4å·ûµ3¯.2hg(JÑ/ò+!ﬂ‘æD3~£h
Ñø∑ˇÓÍhUÚ}~<≠’-øˆìµ◊ÕLµsW:yÚx›‡Zœ]Ÿ_á‚åFÿô⁄é™±[ºº®r0ˇ≠©ü"|vL`OY¿÷;MÊ˜£ê©˛Mfß¿ñ¶m?ºbÿâeN÷∆û0Üul”íÅ∫ä$K3#òô Y0p∆o,”“\7T3˝ÚcÑhœW˚PÖt]πóˆSaOÉ“ÛˇÈ≈F¸Xz˙K›~¥≠÷Ø˝Ë5rFÓ
=Akç≈=£∏<ç}A‘zôNtÂ+Úôÿ…H÷≤~H¯lR6Ææ√s¸g+9ı©z…#ò˘CäìT‹ÚZ;ˇ∆é5uM˘ËI`ÇUæ˝·6yzûñX{â_’ƒ^úSì†å˙ÍÌmCÕjbÆ|ô(à-&©Ö¢2‰w˜CK◊&Îc ÷Q0Cî˝Æ˜¨*ê’≤£ŸMá{ÄlÛw∞¬á-ÆÎNÑ<~»—|v»(°Y˝T˝ .Jà™ ÙûB••,”¥"8S°%xÓFGCnECúèÀGZ¿Âùeã¢ë^V©Äè˝!ê"?Ö"X…êû-.ŸtàöZ&ˇÂ…ëC;ƒØ8Ê@Z%Ik´kƒt¸bÅ*êZüÙ˘?ÙﬁÜ"(¡Ê◊˘ÕTÛaøûÕÉ…ÂîÙuÔìé‰çÕŸk÷_ç˛!t’BÌo5N.‘≤ÁÂò{⁄kmúO˚j)fAâÙ?™i≈´5‡Qd¥múRÆ-ΩÉõY”ñƒ¸˝ÖÒE/ZYı\+Á≠èõ•7mTOö”5k¶Ã0¢…6(∫{X’N1yﬂû˙Æ÷g&˘8Ä†±CÕÁkàc√û8∫jäΩIí\CA3´DZ≠XTÂŸÙÈä7∑r£?’fﬁxòwU¡ï≤◊Â∞?]tìCMá-ÿø‰Jb$»-Aõ•DÒf⁄£k±àÃ«y@[ºé„Èf¢Œ∞Û–Õˆ˝í£SÉ	-&uﬁØê´w
Î“∆z∂∞‡Xë]sb+j_:¸ç∫¶ÅôVDÕ0†„™VìãØÜ~7ﬁqÌ·ˇmÓ∫pSjÇò8û…ŸÇt0ˇﬂ)Ï∞õ#°zïé\î¸KOª£z=<≤‹å_zºuzõüñáO2´Ò≠@Ä
’|U$å«N∫+	FäÉ ˝ùüî%Ô«–‡ta~Ê›‘j‰“q3÷+_ﬂqÍcsÍaâı6xΩY1∫∞˛òÑ	i‹tú≥ü¸ìÊˆÖ–XñYNÕ“‘,=ÏÊÌÎ~rıÅ€—ıxÖït¶Z+*g¬ÑµèW¿cÉ˛PjÎ;È^0j9`≤áı&üõÅÆ«¨â0Ààå|äÕvv_‘8 :+¿¬ ÊaºhÉ&EÒ&Õ~£ŸpPx∞S±zbÏ•"Æ∆	Çq ÖF 7:òµ›ræM¬=≈rëwÌÛcìY!‹êA„á˜·ø1yuÎ4\Æq" ôˆ¸°˚+/ÿªqª—¯≥≤∏Â,-ÙbQ∆”tÁ÷ıÕóŸìIk¿∫'í≤€Ek¿qôµâ˚Pœ{7¶â-sîƒMÆXQ˜√±Î§d∆Íœá[i<ÂdD53øm⁄IöMﬁ_öç∑ÏÑ{ˇ6f£ö-çj¥È”Òœ85lırF?ìl.´$0üfæ3LlÁ6?Ÿx	‰{*CàΩaÙÏ=∏"§æ‡•Ú-⁄cQ≥h…¡r≠≈Ó◊	wïklÇxÖäµ=¨Z¸çˇÓ∫»b{Ü,=˘⁄Á±^Gx  OT¶ç âéˇxIAgtΩÓ†˙Áz˛œ,.tÉ¯>tHí÷ì`"ÿk+”ü÷¡@—©∫–xÁ€ß[_†ô”Ë,Óø¿‚#˜NO"ÓÁ‰.πéÈâ–eÆ+ƒN≈ò6Òáı≤èî≥„ÒÍ Ωx	G⁄¨-q{À
≤Ωë®o!Ω‘ Ë◊ÁÓ»ÏŸË™RÚÒ—Ãûˇ“{û.[´◊ÀÃïœ°_∑xG¶@4(ﬁ—–£Áo£∫~YòM¥D%Ä∫O±*a≠jñ,ìt˛ÆE°ñ¥DQ3c™Ã±_÷ﬂ!ë.“´5˝„g£˚™^Ø@ÙëFW<	õ#‡{Dq©ﬂ+√|Œ“wÁ‡!EèbXÉÙü€0±ÂÃ’≈G7Ò0T—Dî¡Ng86GZ{◊Ω‘[±s7‚%Æ˙‚ˆÁDn∏âÌMJ<¥Ér˚ﬁÓ”õ¬.L6e/\ÇﬁWd‘k~º∞Ïu:Ÿ¬ÖvàrÁwEÇ:tœp⁄˛Õ]‹$¡±ê@mA,‚{§ 	•ç”rVHB«#@îÄπBŒJÇ<ãÆ¥¬–ﬁulë@tËà∂Ø´˜C+˝m„G”û=ŸR ·#ﬂÚôKÛ+ãg¬¿Ï)ZKJ,Ëj¯;kŸ^JÃ˜ñø""'66E¯ˆYˇ‚É<êNáºmo'e™ì?› tÀ#ñÚYÃ7Q√ëQ¶T„•¢jbŸäuÑ¥ç˙¿çoå∞	—∂[ïH¨;^ £âf≥c(Á›tùw*≤|©ºN`„®ƒ≈>
h»p+`Dn!ÜvøàÌÈ;jí˜∏Úúõ”º¢ò˙¨¬Ó}a ÎÉábBO,JπæBr±QL$ ÔΩ≈õæàπ€v7=v"¿˛Ö‘/XéÓöüÏÏ⁄€Õ†wå(0hüg•äeh"‰ó{sÖt$Ñ_Ï·ˇdm(ï’«¸z›áﬂÚóG|ﬂèÔd¶dâ®ÈöªIáúHÎ
qÄﬂ8}Z:úÅ`¨≈SmN˚VË∑†oTË[_Z€>íYô©^”±˚UŒ∂{{Œâ… ‡≤ÇÄ!◊i}6√YuV≤ ·≤6Ä Ï¸<hÀ∆1ñ¶‰'ëÉ'U‹ú´è´¨†ç^¨√ﬂÃ∞€	ßœK=v/Vù5G.∏nÑï/$∂‹ƒC:q>∏ÙG—úŸåL0*ÅwX:Ê‹œÒÛ®Ë∏Î#)Û<g´1Ø}Õ≈ö¶RÊ◊|gN‘¢4±q&æeŒß∫ G≠ØY8^÷#p≠uVÑÒæ”∆`x“.77˝ﬂT∑™úd±KΩÍ©îÒÕûB[#4ˆ˚z˛tM-´Ñ+äŸ‚4uGÊ¿—iô¬6ûay˙ÑÆz©èy‹ß…a“T:µâØ¸ooAŸõ9dä4È8Hc‚ÿ›ˇµÖ…WP¶ˇ	o
WI¶[Zﬂø‰®\˛5Í˛Ío» «ÂQ‘ãQ›¢¡Ë˘
éTdnIÇΩeﬂ d¥cˇ#+ ÎQøú£ú>dÖ8oç‘Ç°^É‰(Á¯›J¯v˘ÏÜJ´#ÓHbSŒö¬·'óc…¥h'7LPE-j>.‡7fÇ«äpÏ√ﬁáÜ¿Æ$w—åü	Ÿ(í]LrîhŸ/dá?PK◊—ﬁÜÓ˝¿èù hçÚà´ÖÂ¯¯z`“ëè6œÜcÌ^5À‰#Œ‚‰]ÄÆ∆°Nπ&3±≠Ò>°(WqØ∫^*Ú¯’¯UU¶cHjoûÕéLﬂÄäÅ®‚ÚWùQeç|X°t-ô Ç@ÊÊàQ¯Ô–Ü;Ø∆1∞®$Evm”Ú≈tgÚ1uN[◊i^œY.Vîﬁ^Z3H©ÉúHê;û5±ÌM≈∑kïôÏ§wJˇÜX∫nKdÚg ;˜vñ9(Éá5H>†ﬁO9 Ù∞Û7mıÒ‹@UŒßV	üZÄ5ì®π›Y}‡®∂™ùgøêû,Üê«Ê÷n<‡ó`C+˝EÂˇüc‡HãÂÅJv w¸∞√ñV2“7@jóÑï†Å€ÜÅzÈb¬Ì®Ö8•ØU/ﬁÎÜæΩQ)T’æÙWôzŸd;◊h(Ì`ûì∏Ë?ó‘≈ßìÇ¯º◊Œ{Ã%G˛)´9 bÄ√î”◊}nRŸÊ\£3›ˇ3G\Ú:]ù›`¸ú4”GBl!YR}hı∞F∞HG˜J£ÍÖ"ﬁ¯É€î∑ØÆˇÒ Kmù≥cN˘w˛Bæˆåb‡c–4B»∑]oÃoæ&è	î-Ω˜|∂oz˘.qÜêQòÙ!Ã6ÍÑSGÙ ScﬁzÛÁ!•ù[uU£â€4⁄t(¸A^Á∆≤/∫”Ç±¸ô3>–öáË*rÃ_L@áIÇÊ0Hô_l‚ ﬁ2∑Ífˆ˚6ëÇÅ≠ëNﬁèî'zXY∑[Äö|ûyØVcM_Lﬂ‚kaè˝Øú€>0O´[®ø@≠Åﬁ'05äFÉÈíbÀ˛√[˚r˜◊±(⁄ ‘6©îIÆ‘˜/≥`È©ßlí9Œ^8íπ4±∂⁄Ê∑Æ`Cf^>À}ü¥&F ∏ÄÔπÅ–ÌÜÅ˘=\‡Ù˝UNddf√£1@BÊfâ	ˆ6¬x∞ˇâ©<Ââ0áÜ?ÎÍ•Æç◊Ô–ΩUY≈ucº¨%4≥÷4<p!	°ë'Q|ˆ+†Œpåp QÊ-íSBE)vÇ©Ê§≤á∂CØ¿¡˛ÏaÃ“Ywú™^…∑˘6Fo∏ÔV]¢ﬁÊç¶Oì±ÊöÉ? ÍpÍ¢`õóMO=b¨ﬂ@¿≈Œ€lıˇœ‹ôS¨t^®}eD≥Pd≤–Û—ï¬¨‡¢∞õõGx¢c◊J‡=èÙﬂY·íi≤Ü;HHËJ)äK⁄	Áﬁ•.WGí.ísk!h\¡>î+f9cNÉåŸŒg„µEâ‰ù–wÀbÍ7ÑSîÜ“?√4¶¸òıÄ$ŒNå≤—;Èn`:oKrÛûy≤ŸîÚù…ôöaéÜ]in‰KXSW∏ç∆ ∫¢3U‡»H}ë·Úo3xÕúã‹o'c¬PE Pˇ√W37˚aµçCŒ≥¯ÄûÉ]©ÛÖµ(JIVJÆ}&ÊyàõÀjÜkˇ	]≥˜‚ø≠ÁË≥11
{>∏˘eûsÌ:z∏•7Å7ÖîÕ|vç)]u‹èßÁ
ÊüK>w8yÚÒÙ)/u`J˙ıvl•† |Y√cd™iıB‡.ª” ⁄«I	=™S7†kÆN÷,À0.îö2˝êtﬁæ/≤ﬂ	z)∑‘gÓt”ùÄ‰ÎW∑àÊõ+å˘Íº¨…∆&ÛŸ›«AÃ;iº¯U	õÛ∏¶”—òÕºTyÜ†yı}@6J{J¥7C
KMÁX
†ˇs–≠Açª[åŸÕI#Hì◊Ä◊·Ã$¯≥}S|«M∆	⁄»ƒÓÊ {˘˘HBê÷Ù≠’›“ŒêP—‰ÃÈ¨∞µÙyz„_ö^Xì¶öØ7p£Hy&G∑@õG'≥˝,wˇå]‰•T;¯Ñr™ˇ∫a@”˝M÷EuâBë∂∫êBÃÓ'qÚ¶≈.ñæ≤•0]•ÍæÂæª3î®D:‘˛À π>;¨Â⁄|¿å!ÒÍ∆‹®¨öd‡.eàM™√!®é9sGwØÙ]±ŒŸq[˙bE¡>ÓnŸSN∏◊Tböv)∞~q'.eÑﬂ4^PèX≥’ÚƒâÀ◊”–Ø(3Jü>sOΩ‰wÎI¸ ~Z≥œ„Œ¬ßWçæ/aéﬁâ¡)( úwæÄÔ© ÎtHEêV¯_:∆"‚Ø°M0,öÚU√ÚÒ;∞r*Z=œÜ[`›Tø‚˙9íõá£À≥>Ω∞˙=amgª´~ã1ŸÎ.´'Iç!Éº
¬àæ E∆ı¡?V.ß⁄%ùˇâ-4Aw¡c˙· £®√§Óâß„KÁ:zèMTµÎ`¥tz‚®ºYj TK@YÔËî÷¶;∫Ú"ıl≤B¡g.!¢ú˛KXX∂x≠∏Ò°#Üw…¡1º‰&(ñiÈ˝ó:ßÜ q<x?1$0“H∂Jx|Œ]£˜Û·Ò§Ïﬂì#eìï¢≥·>ÿ …[2A◊ û{¯íáŸÉ,≈éY≤qÏG˘˚ı7”HÛ—§&|'±˜D¯«¨æV∑	)Q=˝L34 :}!:ûb–ïÅz‹¿83xO=¢Sé‡P€Ö¸MY$Kx¬≠IX.^m®:.‡n¶0´IÉ9)‘<Zä]!‰Åm]D¶úH
Ò?8“≠ﬂX(ÜíRZ®éµπ€˝ìHZÿbu´ùF∑oÙñqMø¯ﬂSà†Aπ∑ÆfÜ…¸t|`3ÅU Û¢äÎÇú>
<FLı`i¨œøïò“íÌNB†£îEó»3Ω“pfeàtX“
§ú˛í™‡ÌæÉ˙R…í“ë∆êd6îÉú˘ØncÇxT'Rπøpö≠/ßÇÁ:Ty ‰›7ya‘slÑ·–Z%-nxÁ.ËÅ€üÉôÜæÓ æ“ﬁˆL? ø¨O°}U˚¢ÉjjòÎtä¯µ∂£uvÔl¬/7Ç€Ü#X€˚_à…!¥ñ4?èÈPFçaºQ)∆Ä`H[Êk¥¬äØ!≈Î5ﬂüÃﬂ\˝/¢äê_é·àTaÈúΩœqíì!≥ßÊü‹∆?©Ÿ◊M®aﬁ¿ëD!z·ﬂIÍP€~rè%Y/n´¯å±œŸZ1∏b"xÛfömHy∑3 ì±<#◊ïRŸ¥¿Ö¨M7|'ëÆﬂÛ–WÁ7ÒUÄk≥5üeq√<∫÷õg$“‰Kdì*WcÇ?õtîﬂ°œ@4ÜpåÜG"ÆÙì`Y&ã±ä%ÇÖAb&wfD˝kµâÖ;–v^äSÎ¨8v]¬ÑMË“)i˘9‡_~›À3gPo8∆Œ∑Q!…<Õ≤*≈6x≠=K◊¶Dá§èdo√Ã¿3Üªÿ"Öà∆M˝ì˚;ﬂ“‚$„i…sŒ87ö˘kül[Wè·lÄi3õ∑1/≥lÖN3i∏¸›Ü5!.Ä¿ÆÌ|˝r˝f¶ò◊«—C◊Wí
¡Jû—<≥Ûj4¥!– ûÕíõ493R˚#S”zÊ›;1‰⁄ éˆã¬´•„{≈ÇIX}ëQœ°MÛı n€˝™‚Ñé’≤4π.˘;wQYÙ‚™√Ñ˜∑y%Uœb˜Ts˙gzâ=,æ˜Z∑2“	ã∆Ï6äp-AÍEf@[6£RäMÚê◊/Ωï&MYÍVÂ∞C;¥I|ûé„ﬂÈÇ<§òäó)b∆Ê¯ÌˇEGÈú,ö‡H’îëR26	PìFı,–åU3S<+A;qà$µøÌ˝ïÇèË¥Æ∆∏oZ˛dÜœ‹D.ÖSüx≠√7õ¿ÕOµ“˛‘ò∑CÛ∂ßzÜòVâ‹n∑a¬Vo:2rüÛ?ºCıéB…'˘∞≥ï6KÏø'[vàÕ¯X—* q
-`ˇº¢»‰ú‘ˇLàïÉ”ÅB˚‹πÑ˘á|RX¶ ƒ'¯%&¥»Óôd√ò±K.4Øwã1üÖ∏◊√Û€á”≠Aàu0"⁄Ûªå?È¡_ò9z#j©"7Ä3˙tÇè‚/–k• çÄÙH41Œì…Ìq)ñì`«[ã÷›πÍ$≤Î±3‡˙?+®ı∑„Ü·yAê·ú∏z5qá ñ:HmÏB¨n∫™dœaGVB¿pÑPR!l
õ°|"¬\ŒZ…∫ùvº1fo»∂Ww«è»∞4$K÷†nò≤ fî!™
›µ<C%=€îS\¶vWOö£%;ΩÌ€#˙pD•{"Z∑eÙq[âàÆÊ/…\Ü˜)>2;¸  áe¿á∫ÏöÆ^ˆ8Á•n{ùàr««•√≈„‡†H†£–ª]ΩVMDÚcaﬁ∂ÈP}∞ıtªòWõ9†<‹p¯9-OEIúäKèÌeÀ⁄òãˇÕ±WiÍ¯¶∆iü ñÔE‡åœ,Ωëà¨Ê•Eq∑]qÖ»Ô˘¿ñ¿)5¿¿$†±÷ÕÃî^ÿø¬P1zÆ¢ˇΩjÔ∂+ÖwT∫7ﬂ>∂êÉ]©‚6∆Ìıà>'Ì…™4Úa`wÿµ2 NÅ¢dˇÁ6‘’+]S` c´QU±Ã‰g˛Ù1C≤≤®∑≤∂ûËäsËágHàÑ¨3÷?áÕ$ÓÃ ‹\”èäBª)*Fù?.$¶w≠+#‡% âÛDxø]òú∫k,øˆnz ô¿ΩŸÓ‚Äfê´âp¨Øë6¢’Æa3F˛Ó≤*≠©ô'…2Áá÷jã<˙7∆k‰u¸“»ywÙ¡¢°j;…4n∞ºyá'ƒ!=ãç! â;\íb	W’´˘?Á¬tUr1œ˙X‘æyI3JëobÌtıPá˛®\™°úëcÊ÷B∂–öãéù◊—"¨AÖôµzÍ=yíô$36µñGúläR=$›À8{£SL≈ˇçJôC≈ÑÄ>bJP·óµN!ãFÊV~a˙“Æ¿“;l–ˇqQiä3 ?Å"Hh.cÁê]∫>åz(¯˘˘È¯zBzu{DˆûåªfÓKƒ®ä·4
-˛˜ÜIÉãæˇœµù[∏§íb„;Ï≈p–ùÔ‘¥Ê·ªÔgrÚƒq¬y2≥4REñ5ÅÇ˚ÒsÃèc†DIÅˇ8È´‹…ûB,ºuﬂÒ«%à˝¶¯óƒ'‚ek+Ákd—p≠9,L{X	Ò7˚∏\ÉµèÆõs¬ÿ-¿ôÄë	ê?BºåæñØMëg™≠§ÀH≤?£9øÿ“?i€–®å5€¢ÀãÔ\ÚôqG‹è»õl3‘+¶ktÅ;ü»R{jYz˘ÛÏ	:Â Àe749b?‡Œ¥a	——$|;AÇïº{â®Ö√™kçvlÛ≠°-‡ﬁïnÁgoπãÏıÕoãâÎ2p◊›€eSHX ÈÜ ìÔ_◊«qêS^Ö!Õ™∏%›)¸∫bMª6A‘a÷Â(Hu{¶˚úsG,1%U.ﬂZêÏßK˙ﬁåﬂ`'@7iÇÂ%}Åôâ…≈ªÓÈŒty∫≈µ˙Rœ⁄≥ˆÍÑiÖièÎ(åµÌH§1r|´-òq‚ì√≤mv®à`¨ 1uY4aÅ¿n	∫v:,ÛÊYãW<ÓåêóÒD!ªuñ©¯ñjs»{ÆıoîN˚Îãz¶óªàV‹CÀsXukÓ‡yÛTBo7ﬁóÜŸÉÙâåö üV©ı2Ï¡•E74ã(lÕónvãPâùD*ﬂ4…5›øh Ä∏Dœ™l<x™}z± :¶N—ÓÇö$_Yå)⁄õ9íª}beÈû›ÌIZg˚c25
AÑ€0uUeœ‚è™}»=8F†û/?|â◊ÑÑ:∑∫D¯>)Dï~™e`:›MIÌ¥y-0ñ∂:B“ıáÀ3ßÙx<s"°”\±±_˛»©Ï}"≠∏–µ”¯¶ r3&g´c⁄ŒÆ+∂`ãµ(4¢•VªSã	„ñäóÇ¸ ®cv=EÏp«L˚}u0á€oñgyy˛{ï˝ `¶c÷≤°√çåã⁄à	P∏(k?€÷jTPiœT˛ÃT^r∑4%YPÈÊ‹t¡e}¶}]™X3¨Ñ~{ÿ|H,€ª‰‡=`…$=>Â¢º˜¿btÃQ!x÷†ÙÆ<€¯¯¿ÿ˛h¢"¶‡Iú 	ˇt'Ay.πOŒÆ˛ÎÎŸ„„ôÎºóT^∫˙?√D€√M€8uÁyÔ3>„‚<œÕ≤∞ØûlGÚÀÌ
≈1Êâ¡¬Ù©;„æo"¢Q_ru$œ%¬<lµo£5‘¯æS∫ÄHcº,!+Oƒ|Æ6õ#[jI¶∂”Æ%v¿ZK∏üröË’V˜ÇcºˇÚö6Nl¨5@ZZ∑¥”Œ¢FhäøüA–@√€K‡ ~åˇæÊYux’›E§7CKFFá\ﬂbßBqnœq-∂À£∏Ÿç∂5®¸⁄‡+GeGŒ¡&1ht⁄ÜCK¥˙W≤r?ß®Ë§Ç»•°ÙÌ;ª«bÌ0za
•VµümR^~ë'z©©CNK7;Qs˜÷‰IPFTQÎ´ä‹vín|πÈ%c,tÆc∞ˇ◊®≠çb˛”∑PøcWJ{j'Ú¸ñoµï´
«ª∆Êc‡îÒCí≈˙‚Ñ]:ŒŸ§ıÃ†ã;V—o∑€6∆ñ˝≠˙›BÎ ’∞∏4xÚRñ˘7ÖZéê,˝G3ù0ºó˛É.”3Iãh¬~le3LÍé⁄{∫◊√¬—`<é¯Jå{x`Ø¡ÏÉjÑòÈÀÀ‘Z•P}◊àÂ7ƒs0 ´Ü`ZHMsÃ∑˜d6·0µä®ü%w≠˛ØrrﬂÅrä“ÂPX◊PÄ1∞Ê;∏Ï€›Rã˛w‡ÈkáªQÿ€™Ù≤˙u¿+&—aâˇ<géÛêÚÇqqk›˘'.—Ÿ∆µ”;vˇaG√—ˇ9é-#•êêmä7ú[:u!ÔI]eHø≠[Ç~lÇ∏ÑÂß0M¡ï]/ïÀzœAúæä˙$”π—.<Põæ –Ì»Ú√árÚ¶æ!◊ æñã∏∫^qåçÆ‹)mÂI=”?≈'MöıÙ¢≥y¥‘?å û˛V+¨3TûWÏ∞ñ≤ÿòˇrçÛA	éı›û4jh“iæ˛ÒS/
ÒÜ˜¢©zµ©ÌCúÑ¶êyÑ.ÆÓóÄXUmG“ùRƒ$IfAÚ·ˆõŒ98–Ωﬂa7cêÂR'f™|Âƒ∏µ|⁄`„SƒÔìK(c	≈@kU&Ω|åh˘rÅΩ*6‘ß5ä,àO=w‚â†Fíß”`˘–›Ü9÷˘∫î$ÒhÀûU.&§lûáı>ÕáÊŸZ˘9T ⁄Ì”æÅ˜ØÍ√±à‡ØΩLNEAç»sÎ#m%w7<R;)&˘´©ñ·[˙;Œ∏á˝»™ë˚¥ã!+¬]}˛á§¯3¬°…£¸Ëù8∑Vø”Sá}cõ_Õ&Ä¯ÈﬁvËf‡ô‹ÇbÄK∑tv÷»˛T,Ôã‰› ÍSËPn…ÈKKLÃÀòÍÇö_˘p(¯ƒT¥ﬂÙÀÎ—À’%¥&ì}ﬂ…\¨îıñèˆ ƒryRD>›ƒ:ñBJvß"üúπ∂,∞∆,ŒœAÁjìÙØ—“øÊ’Ñ k∆k‚—pØæ&€nÌ=Ω¯~•bô‰k— @UÎ¨VèÏhî]SÑÛ¬q˙ˇ/Ú~‘UëmgvŸ8Aç,∆©ÇUïÎÍÛ=w˜ˇÈÒˇ‰}Ì:[°Ö4⁄∆NhÛvkßaVöeì\ì˚Nì2m \¶ëÈl‡Q`ˆc÷a7∑•ùK∏˙ﬂ¥Hr»{É Ë§'˜Jπ‡∑ô2êïÌÒ†%©F√ıˇΩ‘≥G|Ä Ginn`∏(Ap¬sáR	uD™öÌ]‚∑£ ˛°…f
7’k˛≠`¿!Ë*]W’¯D∆V'∂qﬂYë›y3¶‡=ﬁ∂©œ¥V/uwá¢uﬁwn#=ƒKÛ6*L«∆˙Æ¶8å\·[7ãÖØ£QÏ»áL[¯ÇÖEJçE<±}…_%ó±•FT≤ónü`ˆ∞eC^≈ë£ØU[a”%o3Jè ˚4PÁ®øÜµ6n¯BÃæ‘pŒÛ#OÅ˜tÒ*øÄÙ∫¥õÆ "∑Y%xúÒ6pbdÅ(≥ (ÙJÁt?¢)DÆ≈ÛxË™¯Aœpﬁ¡ßN#¨≤•‘f®ıéú?v~:√« ∂?Ëa8*0®ÒOW¸
∫—pb∆ˇ˛vÑèKHVK˛ñ3`Œ]êweÇ«Ωó√«Qî7≥Z7≤`≠√‰<,ìY+)çã˜ÍoPû66˘’áç;ÁDÓGÒ±,.¿X¡ÑÎß„í,R‚ÀàÇ∆â”≈˜¥?	ek7&ƒ˘@HÂÁX»yÖ\P§MR&‹5Ê°-˝Vlªÿ?‚ù9"Ê	?ÁÉƒﬂ¶-gÃ@C&Â/$;ú,˜tkŸ§¸¯¬7©â˚¨iRñx◊º!˛°Q"›ÌO‘b∫Æt_™l!∞£À:üx§∞À:)ÍÂÜ]2cJÅ8¨<Ê õëçΩB0â|– ÅÕ[™∑mèƒ}!∞zk2≤nô9
+∆«m˜QÈ«S
I eÛÿ”ÉúPôΩ )2∆B†`{´ãAr¯8ƒ‚ ÌI8S=&¿≠vYkwmï©4◊JîSı îhÕ-¸ŒDÈ}<Téc<⁄oßQ‹=˙E•h;∆¸£ﬂ –€ò≈∞ì!e^?âëfCåwX—¿„Ω∞¬àÅû ód—*f÷LÃ™z∞ù‡Û*WL˚tW πR:πs—D¸ÑHPÚ]Ü¢˙fñ$æ‚ 3Ô)ã∫‚•_ÄÓ|ƒÍﬂ2QÎ%Ør»™ÿ_œóBÔ 1UÏ˙˚¯Zy◊>ÿ#*
HŸ|ÉUpRÏ≤B∑‰[–V…mcBs;Ådüá>©–%‚õzRÓg1Íå+∫‚4ÑPó«ƒ“H(ÊÁ∞%ëÅ=∂cŸ1∂«ôª˘∏¶Ö„agÂ∏Ø¨|Åı•h›Uçn÷ %9£Wk´d®RÍå≥Q§ò
SEÜ’:+>ÅÀÜXñ´ë:Å•Û-
úÙ(3FÕÀQ ◊ˆL4dÖ Î›ñño–ôÒvçÅ)ûvR—Ωù@ØÊ6˚Ík`okKL‚ª”|≠J	ÃÃ3jBÖ<ˇ•⁄ÂâÙÖﬁàÊMÙ1öˆV èôœ‡Ã:#Rw"˜Q0›€%˙aÇGQvyÏlçC7FK∂,ÉPO÷»rŒ£¨ˆ»¶WÃ(üû¶NBƒîé{´∫ˇ¸
’ƒ|§ﬁP‘Ëˆ,µÃ”ΩÂﬁ…å-P¬öÃmUÀi_°-‹E¸ïﬂÂåö´ÿniΩM2Jz>õ<Ÿg©.2é‘@kLhØ,M;8ÁÁUPÕ¢Ç¡≥Yö…MX!Vƒ:¢,ÍŒy%a∑]‰Z‡¸w°∞–< ‘Í^8A#s„O]≤»Éπ*ê–·Óµ;Œ≤≤pbÉ≠,W≥DA|É5fÑNM—“wb£XPXì
Fèm…<ô ﬁb[Â7KLºôf
k8ÇŒ‹⁄4n??¥Œ¨~Fü¸$˛Ë6À5Ûeõ˝–‘ü∞Zæ‰…˛$~Ã–¸ÿõ‘;ù”ªÜ	Üª˝ÎV˚º*z[⁄’øû„Â¥æÀ¥ìRf¬ÿpHìm3Íh„LÔπfÆWíteFé#C∂ï⁄nç#˚WÏdGGìÒ˙†Yz2Õﬂy[ãû∫§4◊~£e¢¶`˘ì≈Aï‘Üœ&gIX5(“ë,]0ÊdΩÄ#"ÆÑAI]÷V2]dÉÀJ‹ sÆíü¬Ü&Cç/gØ›ÎÀ4)ˆä[TÔ\◊ªß≥ºbNªmAz7ÖfÏ∑DÿÉd¨[óØÜeÜA:˝(úK‰
[&Öì¨ç˘ôE=q…°}v˝~¨ö„2‹m⁄
%˝Å#öœ(hnK⁄7ÌW≠Îl,ó „ 7ΩA„Ve;Òyàtà‘N¿¬•n≠öD™¸´Fπ≈àù‹ﬁ–|#ÎósÿÂ4öã¢Gù=ã∂Ëö≤ì‡lXh
5GMàpåwdÓ´ˇyNFå“ÕtlÄLÌ`µ˜ñ¸„åT]è}K;|≈â√‹ï©ä)ëOÚàlù¡-∂Ω3j¯∞/Çtó	¥"ﬁ≥[Ù¶_/`úv±]§g|aõÁYL€¿"s ◊ï÷µI1™ë≠Ò¡ªhr⁄ñmv}«¬î£É∂Mç≠$C˜VÓÁÁõŸ\√Bœ‹N™rº É‚Ñ'e;>≥…Îÿ„.˙ ñ“Úï2¬qÅl‰=å’¿oYÁ’ï&â^ajıêe¿ß˚íòÓ' ∞ôL~â™SI≠1ÔBXx°j⁄_jql≤™[Ÿus¡)ÒJ‘EîÓÛ∆›5V◊à1„ËúTÆ¡∫YîŒ)êS˘⁄'>o16ÛgTJ>›{"∆wŒ≈8âVÌ&}“X˙^»ê˛˜RM60…Yˆ‡–≈¶	O≈_m≤ﬁì0±≥à´Pª°Nøô°œ—÷)»∂˘é\›!aJ‘@ﬁÚëçû£ﬁYD-›Œ&≠†¸÷i≤œ˜“‘14u˛
gêò3v_w§xUrüõŸ}N©t]|Iè∞iï%g†ç˜9ì*ØÛ¢Tl˜∆˙⁄¶”WÙ}ÃR˘‚©~xœÊ\›Q„™UO°Zú˜pOˆÌIÊ1+ê∞£`óºΩu≠}ê(f‡ É:fz<÷…2√Â{™ß;»Kõ_Y‘R'ózçwD≤™ãÓÅU!D:ùÔRE+ê«zò OØ&°÷æd5_tË
 ◊ãU¯–êï¿‚⁄Î˝k≤x”«¥˘iã∑ÑÔÌ‰d’Ôd¨zπ•KI;,˜*Å™¢Ö}j9w”ƒ/X¥=Ú,}ûß7CÛÅˇ≠ïˆ◊†zúÂ÷ï∏õƒO·Oh”|Êr$∂û5K #‡≠û}ÃÉSa<Ô&N>ùß€çM=™UI8kîx∏„&W`Ú€¥T£{f‚Éâ^´\¡Æ±
ÊüÈïXÃº∞-Øã·£Ö	gÒa,à ª9’¢VtãÏÕW®}ÑWf[´Î€µS›√D?ÔLKw±Î©`4Ù-åù´ı¥wQ`c,∂
Ÿ˙I»Fï@\úÚHE˙®yÔ÷åÅÅ5é”ñÚˇ´®	Ö¢SMÈËéFÖÄéÀ{7EjKˆèbx≈ÒK[„KåUå.®⁄ëh^ÈÌ‚d%'Œ2r≈¬‘=á∆â‚©‘È5)vd“P}d∏€{¢…]ÓÑ’!ˆö„ÀÿkëaM;67p`≠’2˝Ró∂.X˜o_ÊÙ4ÍœÎ∂ßVG	§Ç@‹Û†ä»”àj>I|óAÏ˜(‡,0À˚Ç£r…≠LÌÚ@é}	a$ÃCnI€∞5“ÿˇ‚˙$dûó.K≠{9†ª»≈*#ÍˆfX?B	u·åÍn“≠¶ ˘T{3ı7˚¸%6Êù?\ﬂH—Ù*^	Ã%ü∆Ã†¿ ÛSÔ)P`71˝wç›ø_“ÍΩ€ äÙ%)∫Ú {Ên)9^Säs≥¡§±82è¯ëa„O=„Ÿ1	Ï¸Õg≥÷8Ì4ãw®?9MÒqÄj‚M`19Q;=>7
¶FΩ|´±
"ZJ\ß<Õ&º87ûÖòæ∑“ÚN*Ùp◊qÇ#˚•}E%ÅœK>É›çõEÓ¨7˝˙bÔ”Óa√pÖæ'ÖËsƒ˜°}=¬È˙ˇ‰]‘06Ûuª±ãæµ§Â;åY |Q°˙eﬁΩg»∏f≠|ÅEÄ∑9ırÎÅ0°&‹≤p›/¬~*']Áè&†ı”µrT˚Û4Èj∞¿ê«ùC8zs˙˘ù"VÖ±}%ßP€•÷±ı1+`·ÏÒ©â5·®‹˝E˛TÀ∞—W!Ãq«£~xÆt™⁄’ã∆∆5O¸T§ÛRÍÒ¶∂¢xß˘öskaÈ⁄≈^Ñü3e˙Eµˆ\	õO[ÜA=„z‰›WHvn2P3ê‘“ƒ‰8æ)ÌµÜˆQ’RÿT˙œ˘◊‰PZæR™Ú‚~≈¶b˝eåÍ·lË3DˇàZ˘WS–;§ïcB@U%æÃ!1≠L¿„π®˛ß†X°¯¨q4Pb ¥§
	 »$ñÈ<»ó?W"Œ :Ã®€%I”—ª"—÷¬€‡å§"çAÍ%Äˇ|£Œ}ﬁõ&π¿oåí+î¥HeäAjóÂo∫r∞•ò1•‘tí≤∏l–(¯cTåùÚ¢®3@|˚ã-†#^F83ªÀÊ ÑRõ≠K˛ÿûÀ∏F˛≈áAÇ£n#«Õj  %ÃÁÔP:ã˝Öâ˛^üù)W„(k?]Ì„Ã™öz´õüwÇè«Ω≈B§ƒ°Ca öEÚ∑∞2û‚Æ¿|)k…‚öY™Wtpö4;[ñˆ‹˘Æç+√+A•⁄"n:ÕQ‘'˚,õk«≥†7	¥†.xÀp•r@©‡zw1Oû-{9ôBÌ:E¸qOÖQ∏%Ä0ÒNóbéAC	∏uXW¢‘ê<~v]{Á¨~m˛6í~fÑnµ—D\Mä¶l-{˝ií{ﬂˆ«úu4ö´«Ká«gYƒnYŸ¯ˇF%{Cèøo˛∂6ö+k5◊3NÍ~÷±Ê/Ω™ùÉñ ºíK†ÕªûÉÒ9Ø]nÜêΩpì"ı√‡†a¯$˜Ó¥¢¸ B…ª·M≠˝âÉõFÙ´⁄°ù¯A˛Òeˆ T™£P™Êf«g‚dkË∫±›fåı)ÌI'ﬁØﬂ»ÉTsinŸ1÷Ì:~#∆0-Ωˆ5Ê‰√/,£3Ù&ágêıA¡À.’:T*Ö+/B!d(‰6…cmFWìŒø$ƒ Âê/ªñj¡lîÏõ÷ ˛‰5ﬁ¯òL?‡Ø“∞Íb‡•˘J¥∫∂HßRµR 7S©0Îˆo‹÷}ã⁄O<≈±j™gegpÜ¬√§ç˙˜7*„-öøKﬁfá££√
,((î5ô˜\æÑVµªÅôÈXÏ3£ ô*m±Œ{tŸßù;“õV ˜NN 
–dÙÏº‡_´πäkYì‡3;}6wP—Õ…‚i≠tËh‘ŒHÙ-Û≠∏†˘E€v{S∆M!‡J/±æ√&Ïëo‡øbéxoßä†–ÎL>ﬁô_ø∞c	ﬂ«˜ÿÌ„i\ƒ)øS°.˙,>õ¸)≤Hhë‚«Pì+Yr@!jMÇk¨+eMY`yò˚u¡Ææ)?†Òê4È¶\
u^¯Öp§∞÷Ú
6k¢2·d·†é!@±túõ˘¶,n¿ãgE¸ˆ“˝	i£<JÍñ?+Ò†≤åº´3ÈÛtÅ9pç/Cä0LÙ‘â?‹ß*sÁUâÿˆ;e≥Êòú ãÅƒÅÙƒô$é˘õÕ÷B˜I)M”Cg˜ıˇìˆã§xP&áEÎ j˝Æcò|:€sÑ¿Wfn˚\néR˙3 KYRêEr˚B!^€ùô∂ª—u√’€2–8°_ãõìVÁÏ®x2st<“O⁄kÎà¬º˝ÖëŸ∑bY¡úÙTÚ‹AöTtµ«ËÒô8Ã>∑çsãÜd>gvó)å~h¿üΩ4UÑGU#î ±ï><C°Z´Ú’*~T/Áœ§J$)gkHΩ~lRIËáZÀ¸_wQM>–°n∏∑=\aÜiÕŒ&L:yïXa≥eË∞≈`ƒ≠ÁOqüÆ¸Çp›Qó)ãø‰q‹ò◊≈Iú%≥”ö"Å:(060@π†
8GñH{∫‚ë®\-Œj·°{|ƒ˝∂Ï-Ìm¶Ωã∞ı“G>ÿ¬¯ª’âd2∑2ùò‘òÀÖBπ¢∞_`;UWîÁå¢Ô"Œ9øg◊|¶ÌH+/Õ‡`-qÉ*…„§¥“ªªıäÙ¥Úån®y∂‘©∑¢âœ¶äS–Sk‚6ñ	ÃR˛VG≥HI?∑Úπn∆b&hÏ>8í…åc˜ES‹\”/[*vsøN*≤òyjæ‚V˝È∆¶M„ûì6•pìyüÓ§˝‘LAáS⁄ æô‚ó¸˛^£KAAﬂxÁOaÓ˙¯ÿD^_ò9_V”Akj>j»‚∂	$ïÇÂçl”àr÷ÄèÆ≈Ì]'m¥˙Æ dÌã,œB6Ûÿ∏ˇΩFlêœﬁgPm[#sÇê'|?H·-‘¸EÓ˝Ô´D\<:£c®πy›ÏÜn≠]Â⁄1Û◊G8»66∑‚{éO¡Ú˜{k¸XXÇ∆lÜt…kO˚_'BòÔxŒßZIªyÿ
; ∂6˛èÅ÷˚J≈sö¿”¡k∞|9W◊ÉP[ã&B]QÏü'Ë¶rÆoÓŒrY~Óì÷≈Èr¢ò&‰ıD6‚„]Àä–y§›Ëí´ZÏ*I ñÈ%«†¨ñ[‚y>@D»ΩmÌ• ô Ï√Il√Y≠~
ûF´µÚA’∫Nˇ%ºÑbÑ¨bqo¨›3ﬂ·ÑÍÄÀï5Ω◊Fííî®ë¨ŒN0·∞µé&˛ø2≈‰JŒìd…”;fŒ§_P‹≠ÅΩ^7Lq]K1b}ˆFëA%VyÔ)¥˛èÇ£ù‚Ùzêu8Ó¨Ñ_
œëmMà≥ﬂ…»AÛIˆÚŸyïw\âÒÏˇ)⁄¨Æ:∑~À$ÃSÿ´†Ø<‚£ÜŸï`S*◊Ø¥…õ¥Ûv`°∞ |<Ï–óÏµG)òÍ∞r≈™Át_±§ÜsE7ãf¥»RÑ›Ípí1ö+Jùõ[bFB◊•ÛÁπòn-›¶πDZÅñﬁ^ÄOÒ≤ÈÕ4∫ièØ“ÙU∆‹^J;<ÙÄJv)’òx«Ja‰ñüÅ%º1¯±áæçñÿ—X…∆Ÿ==àµŸ“ΩÎ≠\m”üÀ &âWº¶0éˇ˘Uÿí…K§Q }$;≈ò}ò±c|BÌ”ˇîçì˛‚lt5WáXñ´p“ª5j8ŒU2òó ló¥p$Go¥{|È”ïp,,úˇÿ“i†Üf”˛Ûãïß¸∫Ôk¬£Á>ç∫‘˛Ê ÉˇÛVi˜Ôj hΩö˛eó∏Uz¯ÍπÜ§çÑãçüçíe˜ñ\Á&ˆj‰êhI' û*õóTπ·¢EoAT¸‘πÙj€l<—÷ b>jâ_	¥˙°»NøÅ0a«ü£úw‘ê‚ÍlN'=$Hüb≤)¬º›º^¶(;Ô€"
xöﬂ	| u Ò≥Ó9SQÏ|©Zœ €$)§Ú∆#k`t‹ÕÍßæùï˜Ê‰m˙ç«…î»•πÚº]
Ø$-Ö0èb˝y	ºû¥Öòt%<I∫Ót˜´—Zˆ0t{`›^}ÊìÖŒõ
fäåL”GR¬ªImçK«É{<˛‹@€:Ω¬UQG#ÏRä¸‹I∞^õsÂ·ß0©*¨Â(â&ƒ„«5=!a»>ﬂgÔ>bXÁCˇÏ)≈“RN¯W‹,,j3é2QÃπªPª®£a®ºN—Å!$–{„ˆô∆y<T¨é æG€˘∑ß[_c™1‰ÀU¥Â–ò€iß‰0! ÑÕØ§ãˆÄö˙zR°÷±Ä„ÈK8û06rﬁ¢ˇ'Õ¿ÀY∑LÙ±«FSù¯X€Bi·ößèˆó1ˆ©Xƒj$!q”8W&÷OÙ+¬^>£¯ZªüÍ≤7©·tmKôäl
ú@CÙgDÊo®lÆLd	Û∫<dÉ—h\’'¯jÌ|É1bë†˝OWbX`gK£Z~¿›P)˙≠˛!•åìèƒÚ°e˛ü¥V∂iX—≤PÕè†˜äMı´Û	7ÜôGKãÈ±äàe‡ärñÙ h|∏œY∆ñ¶ºBö≈z!^¬lÍ´t4ÑUøˆÏ≥¡Tµ>ÑKeJ·$ßÃû»*a5TäAÿﬂœÃµê jœ-Óì9¸†@!G¿6!FL.ö÷pr∂rBÇ'”¢í¢œÅΩc∫∫˙‹Jú[=Ω¢âÏ<`]ØœÚòˆ≈;àh
%nƒ‡qøºº∆X∫ç˜Ì`¶/òú&^◊Ø∆‚πÏP~Ã¬=â‚ó˘Qî¸HÇ\ÔÜåà"≤Ê˙a¨›ò.ôe÷Óo⁄–‚…Xv∆†˘"êØ¢aˇù√´zﬁD®x©òOó)h2gÇ¯|ô˚ ±û,∞;\∂œ†^GJ˜ñ‚ ¿JÃ|wOuÄÀê«Z fá{¢w◊XGx∑é¬Ø%§ØÊÔø≥l6·∂ŒqœñÃö¸TûÀÓ˜fÆ°)]«ŒÆΩÀb)e
∏3|à H#∆ù9ei'\|ç
∑gÊÖtîC@ˆlB[w˚èÙÉY=¶ ⁄‡ÜC‚øïÌ›LU√“…X	NÇL™˘G:ÓÀì+r¥R:IZÔ
Ê;_™("2Q•˚ü«5çí…∏~æX∏≤’°ﬂˆ›>†Îg£öÙ≥ÔR‡%ﬂsÔòymV—&^Ñ˚n&€dÓÇ®¸úØ6å≤·ä°z–’4/Y0ùÄÉ'q©∞n∆M¸⁄ åû.{¢=Lwr|—¢QØ‘÷$FÄ’µG#”C˝ÛWäıˆ∏qòˆæh:·T2∫pëïNkYé◊ùåÀÙ¿Í–1É∆í.*s9~¶ÙÔÆÜÖ¸òÒ ÒÄÿé£É$cnÙïÒªÖÑÈ∞¯#/ûMû•J6ñJ(#∂$∆:H*®=¿ö˘F‚ˆ&µEΩÎLÙÅóò∫”ºÅ´∂ClP<≤o®Ö&œ;E=ˇä˜Å"›Ê◊^Ù›
´ v˚](j|—£†+ËµiÎµÛ‚7ıQÛ‹(R—\|&”wÉ¸‚ Œ“£o˛å$gw⁄[YqNbe+ã∑¸ëx∑Ë;‰”<≤¶ﬂ!§kF„ g<1Ÿãî>∂ı≥∞
+hÚ£÷Ô‡âñø´;+ÒGØKDà÷ÿ«ç¯º@®«kπàµèxïUƒIÅ∂êê…@€»≤Êê?ﬁMáÍòÕsM\Î‚v˘7:C∏Ò‘H∫$»›÷Æmç∫îŒ¨õÚ˙¯ﬁ›oÿ™ÕõÔV:·ÕO&Z	ªnÿ;t.mÚ‹‰Ü ’!ÎxÙ&ñ÷8c%_æ.,UH{Ñ]ËêPƒuXJu-lf‰Z@{0xﬂV◊ùÑÚ…ãHÃoÔ]¿≥“˝HFjÆ`N	°…:®êÒF‰†,"ß˘íñVRJ(kHq≤≤ )¥ÀdŒsÙøπ	£…™–ÏR…~È –3I<{∫Ô.⁄/∂˙hÑn]D(gËÚ∏ﬁdÇ\N¢-ÅÏj˝¶Y+Å[[ÖVÓñƒK⁄Ì≤¬ﬂƒ{æ)˛w°H˘ç≤ˆ4"µg~;x‘)ôuÈÜ(¨fÌ($&?é»ááU:~âE°?¨z%Û£5ç@Ày-ÙûD›“„eZ8üÿ¬Âzëô{∑çÏ7-x◊ß¶ÀFÎÊ#æ…à(Ò≈k«üCWíbD¨öP⁄'ÇπÛ»•⁄Îc§t|ßùnl™⁄3Jﬂv°qŸÂs5¯Ü]{@PCÂ+/Iœ§≈vA4„Ï6Ìéÿ_gΩ~⁄ÛvaPÒ¢°5áÃd—úóIÀı6Ÿl«õE'•›ˆ>G‡ÈCh∂®9R∞–e˙ú[1uhû=„eÊ‚›(!$6zjƒ#£”t{Œ÷ Ü>ûƒAÅ*Gg5*E]KiîMw∑;2[R–Õ’‡§’g‚s+$ÙVl\ãñ°È·}.ÉåÊææBƒﬁôÚÇnZe‚Üä÷‹ˆ3hå’Qn·Œùd[É#∆4ﬂÿxÀñÁ%˚ ´Ü°à}‘	™AxãköÖ`Hd8[›Ò≈(Ìè‘s0\M˙∞és;ûâ,
#?èÉáÙª„—ø‘óÁ¬&º6W']f"ıïIîuûBµ.≈<#Å Ù@ıå(∑≥ÂÌ
˛he7v[ÃøÔÎ5é-ÍΩÛ'‡uG’µ<aﬁÙ√‚¬˜á'.˝É˚ΩrÊÚ‹æû}Kt3á’|Í’^	óUëøÉèBLµe>∂yuÇˇià2Ò]DmGÀQ≤!‚r•q¥$Ωjä¸!ñÜ6™Ö†3∏íê˝ˇÿÀ*…Ì;í~∑;[A8|EPÀÜΩP'	πÅπZÖÑÁrë#ºKo˛ÉÎC”ˇZΩ_Ç≠h;/nıäãzsÌüñÛØ™∞˙Æ}ÒQˇ¨¡_.o«jü5_)¡Ÿ84«ÿÀ∫áujÅèˇï
Qö
˝\i,À1ñkfıï(œÕ]ñ¶(Q-ùºØ-’Æ¬ﬂˇ\Í˝∏S)ÑÑ¿ÎµÖÖSq˙ôm(7)◊dˇÜ'ﬂÖÉ…É<≠¡¢m≤ç#8°®åƒÜ¨1Æ„[ÖGZn9ëÚ/ ¬Ò¬0£PS‹Ò¸h¿Ó∞ÒùìM#€®/J·¿=Â÷mô^«…ﬁ	GŸ6æÀ”R˜-¡&x£ÁµàΩ"çVÅU Ém=bvW™Ñ1‡C˝¥ï´√ÿ—;{∏vëÕîÁÌT+{ Ç%O¥í±∫'«fÍü8&Òg*±4øò!◊ÏMS∑–xÑô59¿˝†´ùÿ—∏…Ëÿ1âe“!á™‘˝∆§vÃ)ıe^/&\œ“˘®£≤qåä¢†r5êCe

ê÷3Ü<íµcÓÖ5Á-Ÿôüf$B7Kyl€ñ∞@∞ªJ@ë~∆Œ|2˛gÊ/AÄœß§Æ€]'H8Ω˘ym¥ƒÆFBuSÚGQÙÆ7$∑Ûò[F7bnÄõ+yô.ÿHtΩän∞—¿§Ä¯»pØº¡NC$º√øË=”Çk¨ ‡»àj78<˜›ºÔ•,üb5´$ÉÓH@≤)Ô€´[àu<Q˝ßà6„ünπÃπ@Ö®à≈ZêÔJlö¶ı‚FâŒDmNXΩÿÀ-ŸÑn_-ˆ%áá“ÙØxÈøZ0Õ‰ˇQMj]
|6÷™[oàïñ©‚ãXZtµ§Âô£˜ÎÒaH¸ﬁ“àê-° ∂∞ï∆G>®“óGØ∏ÏîQèå<ÅÌÖ}ÃPTï~ˆñ4ß+˚Ój£¡ß	±_ıE±Ö—ÌøsÉåy”·R◊•Ü~–Åm:%/<Ã8Ó,-4›≤À∏≈?<Q∏2«b
lËà<jˆwê%¥]]¢âä÷g<‹2ı¢r1Ù*A'Ò£1]å∫ö˜∞à’«Ê2jpΩ@◊˘
Ó¿| ¥¶a€òˆí«ëäx§Nk¯Å’h>@84K'Ù«G®n©ÑÆí˝AYèÃ“3ﬁ û◊°t@‡äÅæÃ?≤ìá[0‡	ﬂr!ÃñÌü Ãøh£a‹‰AgfY&2ôŸ∆ 4»Q“0à⁄QTq>Û;≥§ØÅìVË˘∞,IÁÚjªº2éÏ∫h>⁄}à∂π7À:À!#≈“1Ú‰Ü6†Ch./"ón2qÏ5áuÏ@¨∑{xŸû>´–0«ÍN µëâ‰¡¨{0ﬁÌtëˇ¥>∑0∑ëœı<†&ä;R´Ò‰4’•‡P’æ=Ú“≤É“g¬âóyfnWï\ë–Ø<¡ìpñ9QÁ%‚◊Ö¥>G>÷¿Y=/±Dƒ’ïΩVQÉÌã‘’õ‰˙ù∆“"{j∫Á+$Z∆h‘>¥íP‰‘˘o®Œå»®SöÀœ´5âí`û∑ªd€9^êÀØõØÉï+c*∏,”∆û‹r‘f5ºh‹Ã°:\mÈ¯lç<òÒgQ:^‰ÿ:V¨†\·§“ÙüØ/˚Ù:ÜÇwsﬁpëŒuÒÃù®(MAR[6Ò
eÌ'·bdŸ$ÿ∑îi–bﬂ¡k´_‘ﬂa1ºL"«≤Ô1ÒQ7V*[.‚Ôó≤RwtΩ#‘—˜≥2‰ÓZ∂•?˜v^"“ç¡%∑ú,—ø ¢∑≥‘≈ó√ üy-∂mø‰8∂´=x–ıåm!],! ‰’‘©mò…˜¬1dÅHHüÅˇJæw≥à’bµ˜bôÃ7B9œE·gâ[∞(›∞sõ(éO,%éÃeË'®!˜¥gŸ∑oÏ¯H–!%Åï¡©$’;6dRTm:|\t ƒMÇ4:¢-ÉsN®Ù‰jù{sC±◊K,π>©œõö`kî•¿¡(3—(Ù;∆¸∑9?hãl>D´ÁGÆßpÃ<å˝=¿ËJÆ˝Ë=k˘»◊7É!À$–rîúÆ©)¨ÁÈπˆ“ªAÅπCjˆÆcøÜõÕ
∫Ó’ﬂøHs\˜Ö£o]˚B=√—Å-»0ëà∂-U¡ËDó«ﬂ:`◊XÊ{]UÿYòÒó\√äåHˇIj¡1ØX¯≥73å˙äÈPbCÈT⁄EÚœ§;Îπ:5$˚f”T_áãìõöñ%	ÁàL–‹&ÙÂòT—QèuãmIﬂÕ—k`lÄ+âÎ≥’ªê¸—Ñ∑jàn˙è‰Ö˝-e ˛—+k◊´o4Z∂
FÁÀüËá'VÇ∑;¥imh>™‘VCäû–ï¥úú‚π; Ac!ƒ]Ã–∆:O.y˙èPF®€Âyqöê6s«r>	÷`ÕÒΩö¡Ñ‘≥M∂›\¸Ü8‚ˇ©|ê∑≤%Aà˚¢VÌ_ÒØ‰≈¡óÕMÒ*Jwb,v®√[
BÄLÀ|Ô"iN2Ÿ⁄ Ïß›“aU5çÀA6”ëﬁG*ç5˜hHõ!Îfí}Îeﬂ@öl€¢ﬂ‡4Ω'EË:”oÀk∏‹Ÿ«mÁYÎ“æ X6 4ŸˇΩ<S¶w'©ÁÛüœxñâ`t2Æ?Fvf<OfP]$ç± ŸsÏÃàåõ§1.e"£ò—‚ﬁÿXD®´eœÛ∏ô¯í‰^ïp˙:u,i€NsQ¯HñÒAs¯f∞™^B∏C°N¥úâ*…Úˇx7Ô 08`=*¢±"≥”^v∫∑enTÓò·û5‡l–·ú	B⁄3‰ãUò£(ˆ>‘ˆsBKa€hCzù$ë
Ùrß˛¥Å1ôá1∞∞( Ô6üÂ©‚0ΩôN77r»Ag;ÈeÔjóàxπ)œ·Ùæì§¡u’Ã3nj•ç3Áın–Z^;ÚÊ≥†›‡Ç—üödC[Ÿ(áDw-—´«Ê"x!_’%ˇ≤ÇÉ•ËÈx¡°ŒäÂF∏∑ÚÕ~¥†Ñ’µ„´€„^·e·áÇ…q˙ãtúZˇÅ°∑8ìÖ∑†9W$ªËÏ Q˚R‘≈√ŒQ8j¨7ÏMÔ$·u‹ÅØ4¶øAÆz)õîÛÌèE¡T	ê•B˚QyÁüiÄﬁËé®M]W«áÚ\{ﬂÎ¡°? 1Â,7Ü÷WŒY]$™ÇYr	KŒÑ+πFÃ˘˝ﬂ)§=Óï]Edeü¡ä°k˙ﬁF¨õqf·>`Ú<?fVµ£DJ äÆf)oÀ€˝≈πfÆ}Ãêº,Ç¯lì^√HìíAiº±YáåVLEjX¨÷x©ì•,ãøÍ‘Ï‹õÔn›Y*é≤±	˛asWå.Ü5¡+bM<"8+%Ì«\§nÜ3 8O)7∞ùéæ)ºD_~o¡Ã¨‰Ω)™÷>{≠çØÕ∆˛˜˝ØïãmæH≤∆!‡íÕƒóã‘¿5´ˇ<&¨ ÷zê’rçÑÚ∆a§‰(≈ƒªìâR]Të/ø[:Ï⁄¨y_¥íQzÛˆ_º$◊O≠)n<√OTC∞IIú#ˆÉ™®‘%úÀÖ∏á™è◊W∏EcıwE]∫Tû©'îø™?geJÎº—ïL®ÏÓP˙˜«?TÇîaÖ2
¨« W2÷l6!WÚÚÏ>õŸCâ)>ÄÒ~‘s6¯EA•˝=”ÄsıÿfÁƒ•ÉûÈ»'çπ•b,∏ô%˛⁄ÀÂ»#úüñëw˝y<¢¸⁄ã	¢≥ó\Y˘àì≠mxRA;u›€nS	Áè¨‰j8ÌÏÑiE~ÒWühÑ—YøG6õT•Ó]ç~
qÈC_ˆ/‰_tbQÃtÒ4Û	π≈cyöa?øÕÅ…>jùa;Å¿∞‰|Y±Mjq„ ˜ÅK˙@|
WÊıGSw\Äµ 1.ú†6´w∏˜r˘Ôg÷\n”'r/BÚÂb$Ëë¡˛1@5›∏Ì‘+Á‰ÍL®s|5Â¨xÿë€˝zlæyûˇØ{∏ùP„Ñ4˛nÅÓt*˝Ë¶3ŒS¨¶Âá§_ÙbŸíaà%^˝©ì˚Íå>Áu‰C7«ÍNé|CU÷Rﬁ‰lBj≠’e≈ÈOR'7«RDıahÉﬁ´t4Ç«f4®ûƒ~ägS‹èã§ú›∞‡˜•B_) ùUçegÛô~ú8B<ÃÇê©NÆ¯˛èÔ£“OÕÚZjHË–∞‹j.x¢qìﬁ=oÁ)ä5◊É4gsÿ9¬•,t‡$·JSZÌƒÓÃ;È.≈ISmº+¶–”ú‡G¢¿lÑøﬂ¯ÉÕ≈Ö“ o ∆é·sÃK›ÌËæ5ã°äaÓÉÂºHkéH⁄èhñJ	ÎW$65ÛG™sÈπ˝J®Å/d…õÛuÉ!ﬁ@(#+ÄGb∂ZÅ™°,ãÂ’éúÛe†ÁxjôÙÑ⁄®ùiTJÎ˛Îv¸7Lã”R~9Ûe±
–K˛U%˝,πÌï7Ä#ó)öî`Á4:ûm-8‘j6)êR&ºQK“'niP	˝±Â*ªSXørêì‹«Ωm‰)%¯{@CMg≤∑∑ªµi¨“N÷é°.Mø·ÒÜû^üÉá≈{øPlr$-ºç⁄è‹∞~ﬂkíûLÉ$Î·ƒniäÈlè©º¸ƒ IÅÆ#ä‘/≥öõRÁw“ ;@i≈*÷U”ìQÔWr8Ÿ \Í™0≥„¥N5õm≠mmËÆ◊Æÿ≠¨@Uúò«‘qÁ1\íauEE*î{≈(2n‡EøπÚ¬f3Àﬂ◊<∆	ôXjûØ92*˛3R0¢cÁ"À⁄Â2˝5Ÿ‹£Ø¸Äæö0˜ÕZı≠&£8ã3f6tlNÛydñêí“-A…˙úø¸IÊüZ+ç#í¶Yº∆T∞?πF–Õÿ·ü"iæ)˝úb.»ÔQZñ´aSq∂±oIÅ<"b‹(ÖF)Do&M~√Ø≠åü˛Ê5™Hà˛ãÃn’N™˜±á 7ÕJ{<q»ª5xi¡h®M’-Ôa˙]6I.˙èO1]ô≠övV@Óø'™S:õ)hããbË¬´ÒÒ¶Å@◊ﬁ⁄ÖyÂ˚œ&Íè(∑”DÒonY˙˘º„ªg’¨VÌÂ5«kÆ≠f}”Q¸Bƒ–áµ?ı:ÔÀ™3ÛWAIE'~í-∫˘™éK∏äç|Z2ö
A’˘Û§@Ê¸Ç0A©ØN<‹6áñÅ?!ª|#Ì-/Î&<ﬂÀ}≈«ˇˆ©•VÂÅ^ıúG´íœÒ©¸ ï#]tÓ⁄:∂Ÿ0æÇ’hWtÑ_i ßÄÃ´õúºòΩRª∆™ı `œ0R4ª]®?Ω`eí,•»≠b`k¥Üz∆|{'L¨Fü≤{Z#öŒ5˙3«&DmÓÚœO^ÉkÂ˝1bxYÆ$üN◊®Ë>B∂t=Í;d/®S"w¢Ä˚e¯>»qòvñ7≈mRmUë∞ÓˆAR%Í•GbG»]T.Vìˆ«+m]c2À∂† HQ,M?#èëIy6ë‹}Y9“àêf~WëÏµıÄ´ø°ÛŒAOÚ—‡;KÃ'ï&agÆÒÕ,I_ˇT7Ä ˆ"Ù6V„7RNÎz„€KøÕÏxÃ=ñÕ4π¬;™¯ëç »´SóÕ˙®©Egw^Té÷Z•£ó<pÃı3ü+ô,,bÿyoMtˆ∫m‘¸Ô.°í∆›í“6ôqb3ûéïvÊ[É˛R=~¿VRºEÄ]◊G;€Ÿst¶<ïK{mœyø¯cJ;®ÀôÄ‘[Î‚m^b·Ä‰Bˆçëc]"j°ŒN›vv˜+KS-¿uê¢{ÜΩ'|Kπﬂ®≈»£·ÄX0˜O[B¢rpcË då"9mÚË∑Í)Äéóc»≥#IVñππ∫ø„ÃKTs¯<â∞'≥1µæ…√!ë ’µ+KÃ‰Àá£ØSÓµZB(S≤¶e5[$˛FèÈE¸Fê…+\PŒ§Ω¿˛ ÈQõU&äÅ&â†läà^ÜŒÔP˘K°»WEÜDÜñúÎ,ûv≠ƒ N1ÿπx_àhØÇ¥PKñ—#⁄W$p]¡\â_”7$”ÖVÌ^eΩòŒmÇæfçT7∞/è’†Ìñ¸wˆœÆ£4qêíÅˆPƒΩ5F|õ”–”Ñ bY†Pú«Êlv™sü=ÙïéZLD†»‡tô≥˘ôS9fC’-*A§,QNüåìÜ¢·fÁÇ/«ˆ»zaëCö˜áp%±≤…›|Ù§{ø≥\&öﬁUb’‹≈neèääA<T?lõ3¨Ø—`¯˚ÈN]æl:ÑÎ®åêò^ÃÌ|Z@k≈Ô=%˙5 ‰É}£Ô∏'€`¥·n—r/>Ù¨KN≈ã∫äz¯Øu-œZ±M˝°%|f⁄^‘´–€€–àZMÂ⁄◊`“Ü÷ V0±§-R™Sœ--‰Ÿ˛¿¥ê=h∞äNäaØ\ËÖ\?µ‰„`é6/ûd]Ç=\CÚj‘/”Ñ∫!—kV»C÷'Ô6∂&fTä√◊»∫äÓÍ]r§Å¿PÏƒßµ≥ã0¢¬Ê…);SÌ,÷ó¡ıçft&≈˚Îm∞Ù <%√ˇå)G‡Y˚#Ö—ª†ì∞-˘%<Í7XËˇx%$<$0…Nw©d—§àWvC˜	Ù%a"ô-\Å,’ßQÃÇ⁄˘Ñ~À("üJ©>?´X†Œ]:˚πº(ècz†/¸{Iˆ »¡)œ„»˝qX<±›ÎÁ»”W7ä¯fát∞}tx?ùG#ea ◊π]ıj;·yS»A'Ÿò^cêƒÎtiyÌ®4À|ïÏTOJI∫Ö*3ŸÛu Ã^0û#£òÑÖ-2∫¯ØPÂü0MZ∂wéèjè7ÓgØÉR™n/4°Í-Q:U⁄C¢4˘√âÖ«ºÿ#á¶⁄√ÆIÛ‚Î›<#íÒf4&`OÍÈ‘±êâ
¥#[ÏÊ	5⁄Ï!∑¸]œ ¿á%ÁÁt“—HÉ‘ÿﬁåË
ÈÒ@√›az⁄øI˙Ø
Ç‘ÚiHƒ;ëGiTÓˆsﬁ~⁄–øùÆ â‡aÑèld^p≠#´>kª®¿™ü3õ}≤uNq¸í*Örå
¯gWÄz+SÂÁ˚•ëöŸ-å¢f˝¥cèﬂÈkÛck∫ÑÄ5∞”óŒ¡)iöVÅ&¯Ë$≠L¥å6∂¯)ª[-'±ßLazg˘I(#≤√y4Ír i√¨üz§…5 ˜\®c
À»Û'{∑°Ø°Ã∞46s·’ÌÜü#ÜñÄû>ÖIÕNÃ¡uGy˜+ƒÀ_˙>@–,∆oPM–ÏDVÓçZº‹'}Rn˜ifî*‹Ù%5ıH¸dòIii6Æø$;·@_jØV”ghAD\f`ë\®ç¿A◊*™ÿj2Ñ,≈sñu…jã1“Õv.3÷øèMP¿$zj2S’egYyîÏ*î∂îÁfÏ^ï 4U∞≥¢ t«{ﬂ˘Œ¥^5ÿ -ƒÙ¡{â‡bÕ¡ÖÌˆ⁄ù™}ûD˝>Á±ùøuÁÌ:‹ÆµeéV\Ÿ€Jœ∂Ëy3Üóx†ï∂áFS•…çÛi¢∏œ1–%ç© ÿy∑¿ÚÍGäcÁnfmm6°a:
Ú⁄5√ˇ¬m öÊ∑[Ÿ¢¢câÉ¯ÍçXƒÆπ˛πΩÒìÚ¥íµ!ìPJ´‡ÏMDÚ◊»œ≤ü‹
cãƒaDÅS◊tj))˝y0H%4rV'I8–ÿˆ€;Åüù≈!ùï˜ø 9QN^cÉ—π™◊„4®ª*Éˆ´#îqDÑ⁄|ôù”Ól1QÔö„}Rã9}0)2ƒõwH™Qƒ¬ÎaﬂæPL¢;ÛÆ’ëSdå‚,º_Äß÷…Q'éÛ—A?¡„{¥ëQ∆#§*@1mÓÃoø£8À«$ﬁ∑Ø¯Xq‹‘&n%Ïë “¸#?Í<Y˚ØízY1XJ	£yÊwüUùåÁg£πc«¯N®ˇ¥:.ì>Ü•âéØ,ï£®Í@5—®ÿã†Ñ[§â£==∞l—ÓÚvwÅ%§äªG2¶àgx1@>·àôÖú(OŸÿª´«Æ!?0G„∫*Ì©≥U!Âñ%#w≠º¸øX%2˝…›≈x˛®FÁcIPÚ∆¶´<:Œ≥ËäØß„‘µ“Úó˜Òú†7ÑÄñTs\˙à6¬÷È™aòQEmZ?áM◊>sv˜#˜éwjÎqÛÛßµ ê`,)≤qñπÃ’A≠¿X ‡Œ∆¶z1ëÎ$Ñí⁄N#:zLÏÏ„¶∏πË—f®)Üà¯ûåøD’ÒZÑÓ®®)#ıÿº«í§ô¯M√÷ºb{bhk8ZÄíﬂo;àò^}ÆnVk6Ëœ‡]ì_4O}ñ ﬂˇ6Z∂™:%Â¬æD?m≥ñÿÈ~Èπ_GMæ{ú<fú4kSﬁ¶yƒh7	®§Ω>}¶ºf`≠≠⁄)J:∞3LMg∏°F^∆Qnˆ—≠txj€ŸÖàá`±—wÏÇ™9–ÒqXOãd›xÑ‘J2H√ú#ú"¨$Ç^ı˙Kx•ÑH∏vπ≈Eu‹#Óa˜8ì@¸/dòQΩ‘o≤Œ∫*t?s,∂-=|r≥Xñ°πçŸLŒ÷{2nÕC,°≤ﬁpm	‰≠}c™Oﬂ7≤£Ò@}=SπA¬ÜÖÔ(8Õò¶◊}STé∑˛ﬁó·œŒÖ¿˝V∑`=Êe÷˛ƒÆ{
œÈf 5ÏOı˚RÛ©´{¬ÈaÀN¢MDP»[S”+UºësÜ«_÷Ω[(∞v—\ÒîES`ì”·S™sß}û˝:0p¡˜–ó¥,¿e¢ë¡î&ËÜöªâ|”‹&FÉ£ÂÅﬁÚü¬7¬Ô˜'ëâÈ&Ø5ã øùõ-‰—…†ØﬂíOÏUÜÆD}÷÷¿˝∂∞Ï<◊´CtFqYfC"ÚôBÓÓ»ú3Fs	M3‰ Íõd_‚÷∏I€O›ÈNÀÿh]€´ØÙ0†<yzO2hh∏tÎ°¬∑yŸÖ7˚ö„∑ìˇÁ4pé|èﬁØ¯GΩ∞º©Q`ÀYPë{ÎtÜ£Üã<õç¨)
<π4Ow‰ 6ãÄ‰ Su|?Í‚Úâm.$˚€NVæL¶61≤Vh=◊j!ÿæóT˝ÅW‡s·M°I}SNï™·PCö{?rÊaJ§¯ü¢y˜ÇÏÿ–éﬁ1h†€uÇ+πï.Tm∆¯Œù∆∞?@ß¬,Äìª^≠«êhlãÍòEÄ∆ôí3_äp'… g	»)6HΩÒßj∏7 £;PãÈ6I®8π–Ÿ7°aAÍ3ëàÏ…l®d§™N¬‡ójQ;+r&Õ‘h∑ÛõI|áÑî~ô¨'˝P“L≥‰~Ã5πË`,- vÂÙ.pô@ı-øé⁄Áå+πÿ>mºº9Úu"R¢0Ä£ßeóπîS’˝Åïã[|á6≈£¨Ç›û¯ˇÒö/q=◊◊‘ël‹ÂAŸf÷e¬R|Iâl,ë	∏â©$8aÛ6¢_á†ÎÓwP∞ Õ˙S:	ÄTõâ%í∂IÀ—™‹≈‡~$Û≈ﬂÛ</§˝ûZ8®€åCeòh˜N±√ \üÂ=
0#–?ª=ZouJFØöØßÈaj	Ω
Ô˚'˙+K ;b◊{Î∏xZ.{•/¡T p¸≥—fΩèp¨äòß∂‰qÒFHmd4%›éSX4ÉâMâÖ[ÎæÍ\ktı*ŸÑ ÃâÑ Øbè∫√Ü”L‘]“’∏Ωî¢ˇAÈñ^	cÁédñÛô™∑~Ù€÷ îî^7Ø^Nøqê®Ó≤k’@œl1√‹{%Z6V‰ÀÍBô°PX‡œ≥Ü•ÙV&ï=]Wìk<^UaÔ ±G3íINa¸‘Ò+E0⁄nvÔ∆
[i∞Å ü¢|Á’1$p-˘w$ê6j¡PD/«4ı“è¯;@y‡Ç»Òë˘'zF3
|ùÃÃ‚˚îÒfßÈ¢Ëc®»+ëqΩäá¿±ñ:¯ EthAJ’b˛<	ËﬁÒLÜ∫Ã≤K>p÷≈0á\j'ØÙè¿6⁄Õ=ÃHFµ'8≠ÛÕ`?–— ù.jVÂ€H¿©U˝uûD*≈},sp˙”∞§≈◊§cÄ\*íA€Æ0ˇ#œCNî¡{2u€‚{ßR$
X4ã¥^ˆc˘¯*¯5˙<Ñé˝ ñ/uqÒπCƒúJOP®nGh@í8Såtÿrÿ±°M#≤>lÇ*0uÄoÓ∂*VˆHÈ/úv§uíMC∑õgj⁄{÷\¶zàÈ:w†eŒóÆ∏∆K/j¿¡Å8™l£ÖËz·éÇ\´
FÂÇÁKP~˘ED7∞˘1˛jæjCRà$·
Åå«róØΩÁ-∑r˚(# !T ø“äÕ›U:ø`ªKuÉæ2{Ù`2Â”.ˆ//KCP
⁄◊+∏,fwç"√¶ÅŸ˝90È^˜é'N—wYÁR0
]zÇÍúEÌB«¸ƒ TıÍaT·e‚	¥≥Äõ”=Øﬁõ)`Ü≈¶snp#2px([⁄|=?^FÛ« ≠ö>]x⁄ÜŸ`LÄ‘TÓDx!µIÀ≈M$î˛6[ˇ„ˆ>@n«Hy»Mh∑ë·ÿG“"WùÁ•®9ßBîß%äÊf˘ˇ.BxB∆´¬Xåõü^Ω˜˚•ú§±÷LÛkÛˆŸÄŸÆ2Q>ú p(úáYÇˇ§'∞{s§ÊgΩ‹A=ÕÏˇl›=Öy>ı¢€)5¨4≤”Â.GâØGÒÒÖøqæxO¸˝…;Ûk˘îL@Ä∫eË\Ô˝6Ô˝ªÆ	-mÅ|jE¶r±ΩlE	tÜâ/õÔ¯ﬁ–¥˝"çzå¿2qÔÏ∑˘`>ÇèŸqß“OΩ◊d√Ÿ4xÂ1ör¨'lY˛›IÍîCK“≈€¨7É~áAVÏ/ }Rá˛>jòG‚‹%<ÆÎZ#öŸ´€/ó‡_∑]u
u¸¥sL	∫/˙óU6EAM†dËzƒ©ß§	^~iw{q+Âxà†®É7˝π|?£Ôó≥≥AZXKπ[ "“Eî˛≈ywN —QäŒ]íÎÇÇ¥6√é»ÈŸÍº~ª‰¯32Scqé1œ –¢üÑŸcìgr[QLFk≈…OΩ¸Å–PÖ3¡eë5Çaÿ"Â±Üy˘‘jEx∞ﬂBˇù?Åmè°Q‚PâC(¨)Ÿ2¢Ú+w]pí’ q W°|Á®8ƒ%Ø_=[âé,	π£f*5<JßUk∑¨4îµRÕyxËé'HÀÉ—‚˝Ï †Rı÷è@~Â´5í∏j&nºÛË4‹v\$Bﬂı$Úªìc∞jÛËÿújTàê¬EÑ™y`!÷Ñc∂yá¶lòbˇ¸iÔR«†p2ı˘√∑>Gb∏ßÉé,ÊD¶nÎNa|ÚfŒ∫?Ï˚8∞≥w˜/üôæÀÄqÔÓÑˆ<ñ˘ûÏ·¶ ìYCª–;—ˇ⁄kΩ•Ï¿‹Øõ“Î2ÃäE∏è&_õGÛ£†6^qq0qLú/ÚâÔ
eû•8äÿΩ§C@ä„+GBúπs=¯ò-˛Ã®6VÄ;lù˘·Ql'5ònw5'ÍC-˙Ä%ì≠(ëy–»–P<Ó˝M–ü<;‘‘©K	—6Mˇ0Õ%√{MUı≈n!]O-2Óim√>HËDïÁuc9ﬁZé”w¨ôÊÕõCÎÎp⁄⁄ãù¢¨aãÒ˜sf[†9⁄.Q€ß7®Bzî.Î≤≈>¶ﬁ‡R@kC8ﬁ™ì^JÃ8x⁄äTÅ¬¸ƒ=ëÚ(D˚ÓÇ°ÕcÛœ6FÆ‡Ÿ+¶F£Ä–¯ìÙ∆–Ü∏˘ ≥ËMUµ∞H√	.`‚;ãàÅ/	Q'Â“µ£ãØn?óªîLk›Î\Ω¸TIÖ÷xè'†õΩm¬`¯qŒ7	äÃVˆ©f·Ä˚√}P&ÖëN&,[„öDíè ôùñÔì@UuF÷p
S¿UÁúÁ5√ê¶ØÆÎA=˛÷ú£∆0„•*Ò4D◊KöæÁÇÛ™ñÉQF2=áp<îGŸ8	(ÆFƒz_õ∆˙ZÆ|MX—™YË·s$vª˝Æ»ÀÒµzåkRep ‚ΩYıèOìÌ1ß¬Vä!{Ã3áGøÛ]YÕ;ãm1qÅÆ^≤µpYwÄØó—~d´ƒ˘÷R÷ÍéaW¿|…A*(Û‡ôMW˝Z±Œÿ“ﬁ¿ó◊»m*ûW∏ Øx}x∫ß†≠à9˚ﬂS¯:«ö⁄1»£ûÚBˆ´B•$øﬁgæåÔ˜áœKÄ	OGi·C’Á±«)®slNó+lvì*Ç"äRm\ΩSx&4ÖjGZQ˘!{¢ïÁ-]£¶á¶)™1{=◊’êP¸≈’g/πQ5©Êö/˜∑’^ˇ)êzBÕR^¢#x}0ß67¯k‡ﬂàzÚ∑q™çÒåô]fYuƒ¸ãËt>O™0Û2™ÊÍêwô(2Üôe˚^báF◊è^ÛÕÆxﬁ¸´â‚ï¶s≥‹?cÿÇ_7ÂÊ}ºu€∞Cä∏ªh¥gÒó˝ó

K(W:ã0ΩÍg¢–‰_F¿âJ»D≤|¨§©<¥à6–±é
<æ«'%j¯
…> Ÿ«°«∏l2b®P0áÁ‚Ò‘πF˘$?Ó}Œ«E„hR™Ü
∏mø	Éëj“¶\Òz7t:vx(ÙF9*Xã‘ﬂñÎó™°áö2ÒlŸN^Sdï»ü@»á∏;±«ÜÔ^qáb(È∂Z€#3)ÅáéP-$êı%Æ` æ'PÆÜ¡6Ë›^—îπ≠∏Ì÷9ueQ≈íuVàön6˚8ı#â§©K⁄ë)8cΩÚu‡ÊØUK ﬁuqg‡ùì/¢7ÿÌiJÃ‘=›J√˘s˙éÓo UÄ·Ûå˚ÜªûΩìãœ˝¢ wVß¡skªÁzµvi%væ•X≤1S8ÌÒˆÄ}≈~ ﬁHò5Y®[ê÷ ?}˛ñ’∞»)Èµﬂ5ò•¥πÑ¸QπÌ´bH¿Úã¯_{u^K⁄t¯èèÿƒ(}y‚u3∫cﬂ´üÀ+*ß|àπ»óì=è"ÕhÁıÂ`ÿÁ÷¢9ÎøÂäŒ±∂’€]Rd˚™XãÕ%ÛµŸÛ¡Ïˇc&Í"uΩ+∆ôâ˝†4¯JåÉ±wÕÃQ„ø–æu˜®òâ¡IOZ“iWrùPΩ)‘’€K£ßúáfØW%$NÕºRÎF4ïnˇ∆xú6∆Î°6ØI”6ØÇç‘ß‹¢d/ç™C¡@≤»?yA‹èw¢zÉD±2çÖi<˜∞‘≥AøG ˙À?sÉæ~0:è∂£ÃøõﬁooíÑs‘Cª◊Cµ¢É)Æü-2]¨9`›sìΩR≤ú¡".FïâP⁄Õ|P0*Ô^\M
ñÆË
û{!\Œ‘¯êˆ'÷å*_‹-„Ä}´mrª}ûie®‡ dØü\?ïÑ"Ævˇ≤£‚3!ˆﬁéhÊIÂÑ≥K-ª+¯€ó|- 0OÆßNaJ1îk'r˘êXCv›ˆ¡≤Ì—…öM‰«N¸ºe]ñÒqædkOΩØ∆ö¶à•Xv©*?Cx#∆8#¬Ùà ˙lﬁvÿ.3áÙŒ.|tÜÛ±2a)UmÔçê≤Ç“|9‰ÈZ¡EéH:\v∑—˝™ÓÆ‹P◊2Ω«¿MyBfKøü0®∑ãi˝≤8v)ÔG&ö6’wÜ≠©CtiëÌ¨¯9kòiOı}M0ÖÑYuÃÄUÜà0Ãvö]dFUû≤Ì≈=˝CãsêÃÜ\Mñ_¢Á•M≥ËÄ.g‡U'¶í$Í0]/¡*µwK}ieø∂€û*\Õë{ÆÊ¢Ty«?ó˜ú«∏«|◊?»TY1πË“Ùá¸PTéÀtmXÓ4óÜ,3MÂ˚ º:ìî≈ ≠≠ú°4ôÒâ'Ωåú*‰ã_{åØ_q´*-ÊΩ>zÇ	'0•…e?∫Ôfw{¢`é‹üéåˇˇ8)-Álôiu¿öäˇZEÓ¿Ωj√_ÀQb®Ò5mãä%kˇÊptµÛ5r^¯“*J4“;$,uG2Hº&¥ºπ÷|øK1≥Ä£yu;ƒ© Œ,„ãtåº”≤qèæ*f;Í±lù2Æ¨ÜÍp0˘pˇù‚ö¯&ŒÀŸ?[òj¡”Ts@Ò¶P†R◊ã√Ñ3î–È.‚‚U∞Æ/	«ZÀöØ?⁄°Â+A8Õ˚	Q.Âˇ˘·‹jíäôÇì`›_˙çû‘.Ñˇoº<∑éÊtÊà»ÚÚZ}ã›ÏªpÊHªvìªÊOΩ#…≤ÌÊ&”¸ØõÔ¢ˆm.‘~èÓ ◊˝ºNêw4‡5WÁˇ
‘Â0®‚ﬂD“Ç:?∞Ω û¨Àu™àƒ: ¯5P5Z◊ã˝kƒ–Ì˛ûÕh´y4!$ºÊ_ºﬁzÚ/|'äSB”@Åónñ §ÌuPg™rãfXÍ#7eg·>Ò5Ä	¡à†“˜7Ú€‡y+H#ù‘äıøÆ-$ƒîÖ<ÉçEEÊ
¯Îâ$3≠¡7∑»ÂÂÌ™yÛ¨˛00ãuu°[åÆyóærÇHñ∂ıXæ-áıtΩnhjmòö˘öiúH‚3TµOÍkDC*rS±ÖH%B∂ç≠$&G3W∑ùÛ Ä&‘‹VøHõrV$íüJ’VÿÇz˛ ó2!OœOO;V$≠„`HÊ”V=˜Ë‹Aæ2A¨CJ,ìA‚i}9çïÁqˆ/X…Öï¿nq-£oP4zì~ß'òÈ
gCé¸* ÛZXº‡Ì}O_Ä|úÎR–fÊNÊ˜Ë^[v[ÜwN·œ¡Ωàç§yruﬂX√Ìf™ÂíC⁄	üaÅÌCP¯Å*â£I.ª§¸gÈ{œ˙•’Ø≤70üzÄòéïπ£8“UævQ”ﬁ;NÒ
IñF–Vvo–˜PÜ"Â?∆Bôs≈‘Ó#ﬂlv*ãº˙·3j≤*s∞ïË\2ı{3@ÙB+‘NóJy#s;ﬁ∏eQªÊ£C´98&m>gu2©†¯8Qq[X‰aì¬˘‘˙x=#OvIΩ¥∞2ÊZ“ÌR>√gó®»+k·$∂4y.K∑Rõ.úX‚Mä…ß]∂˙hıΩœåfó∑—y‹P/ ^\Å∞˜ØMOíö⁄\B7<†˙pî`L1Å(Å∞9KñÕ¿ç}›®∏lÍÔ&êá! Åh≤âë4: I`M	Ó Ã⁄øÑF©t∆–NÒkr”%ñdY–/Ÿê&$~Ò;JÀ˙Œ£BŸtG'fKíÿXf˛ÔÀXø˚1⁄ãX˛
J9T3#(◊fL≠*≤˘ΩãR#âAÔ·Í€vlŸÄ∂’ÃF˘Ù_˜k!ﬁ®Y2öÒõ‹&wRíP“Ic®™°
… 4"Q˙n,ı?§—f$˘l˜BœüWz@bCAcxOÖ eáƒ”äÒ€1ÄQóõuëm‘◊,QMéïèÒﬂwÿD˛úâçÛ	øsZV–Ë=ΩÓJÈ@òw÷'i‰·ºJﬂYbiÁVr¶…Õ˝ŸûÊ‹£ﬂ&åøˆÊm⁄ÌOó8/öòÿ~∫ÿ|ìvbÑRcyíÉ8ñyTSÎDÇ€ﬂ≥œ&2ä˛Øu¢»B©äz?öCW¶óCÎ 4“öZ$Y¥BŒ≈Âñ‹ÏÿÖvS≈zÓ	“ï†Ä∫4KÔÂJ
§¿MrÜ2	c‚Èï6Ø$∏·πYˆ:*Ö1kN=vÚ˛√dÖˆnËP“™áÅπ´:õeìíüßΩ%™Óë¯,Îöô÷Ü@PMdÎØ∂Ä;V8’:®‰√·lÅñ'÷ßªhGb&l˛A¯ñj÷âÆTbi&bíÏœæ#ƒ·ô C√ù!	)À§=ñú‘r]∞«¿Ì#¨ŸÚªòyØüΩr=ﬁ|g© §@ΩxB0÷Ú˜ñ‰∫∏æ¨sW¡Û—pìé„–m_7Ä‹W=Tôn+åe¬òJ|Q(≈`Í∏1ZK¿>-ûSC0õ\Ö4 ∞¿0rYzÓ™Éo„ '[s’ôè7„FV·≥ò}H÷Æ∫/(©Ÿ¨øIè¿p§„yµr{ÌV¡Ci£˜∏tJè"æKÆò˜n·á/R+J5• ®!Ì˛„1hÜ)j?ù¥Œ¿∫çi%◊ãY∑Qè]R8~@7arüÁõ	'9æı˙yÒl–Aëˇ∂h"È•$´’VäBc”äÚtÜjZæjÚEdpÈzúê≤t„ü@ZMõc yKñòö—@Ø
‘Ô˝Ñj GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                                8      8                                                 T      T                                     !             t      t      $                              4   ˆˇˇo       ò      ò      4                             >             –      –      ÿ                          F             ®      ®      ò                             N   ˇˇˇo       @      @      R                            [   ˛ˇˇo       ò      ò      P                            j             Ë      Ë                                  t      B       ÿ	      ÿ	      Ë                          ~             ¿      ¿                                    y             ‡      ‡                                   Ñ             ‡      ‡                                   ç                         ‡                             ì             –      –      	                              ô             ‡      ‡      h                              °             H      H      å                              Ø             ÿ      ÿ      H                             π             »,      »,                                   ≈             –,      –,                                   —             ÿ,      ÿ,                                 à             ».      ».      8                            ⁄              0       0      «ﬂ                             ‡             ‡#     «     H                              Â      0               «     )                                                        Ó                              