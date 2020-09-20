#!/bin/bash

#-----------------------------------------------------------------------------------------------------------
#	DATA:				07 de Março de 2017
#	SCRIPT:				ShellBot.sh
#	VERSÃO:				6.0
#	DESENVOLVIDO POR:	Juliano Santos [SHAMAN]
#	PÁGINA:				http://www.shellscriptx.blogspot.com.br
#	FANPAGE:			https://www.facebook.com/shellscriptx
#	GITHUB:				https://github.com/shellscriptx
# 	CONTATO:			shellscriptx@gmail.com
#
#	DESCRIÇÃO:			ShellBot é uma API não-oficial desenvolvida para facilitar a criação de 
#						bots na plataforma TELEGRAM. Constituída por uma coleção de métodos
#						e funções que permitem ao desenvolvedor:
#
#							* Gerenciar grupos, canais e membros.
#							* Enviar mensagens, documentos, músicas, contatos e etc.
#							* Enviar teclados (KeyboardMarkup e InlineKeyboard).
#							* Obter informações sobre membros, arquivos, grupos e canais.
#							* Para mais informações consulte a documentação:
#							  
#							https://github.com/shellscriptx/ShellBot/wiki
#
#						O ShellBot mantém o padrão da nomenclatura dos métodos registrados da
#						API original (Telegram), assim como seus campos e valores. Os métodos
#						requerem parâmetros e argumentos para a chamada e execução. Parâmetros
#						obrigatórios retornam uma mensagem de erro caso o argumento seja omitido.
#					
#	NOTAS:				Desenvolvida na linguagem Shell Script, utilizando o interpretador de 
#						comandos BASH e explorando ao máximo os recursos built-in do mesmo,
#						reduzindo o nível de dependências de pacotes externos.
#-----------------------------------------------------------------------------------------------------------

[[ $_SHELLBOT_SH_ ]] && return 1

if ! awk 'BEGIN { exit ARGV[1] < 4.3 }' ${BASH_VERSINFO[0]}.${BASH_VERSINFO[1]}; then
	echo "${BASH_SOURCE:-${0##*/}}: erro: requer o interpretador de comandos 'bash 4.3' ou superior." 1>&2
	exit 1
fi

# Informações
readonly -A _SHELLBOT_=(
[name]='ShellBot'
[keywords]='Shell Script Telegram API'
[description]='API não-oficial para criação de bots na plataforma Telegram.'
[version]='6.0'
[language]='shellscript'
[shell]=${SHELL}
[shell_version]=${BASH_VERSION}
[author]='Juliano Santos [SHAMAN]'
[email]='shellscriptx@gmail.com'
[wiki]='https://github.com/shellscriptx/shellbot/wiki'
[github]='https://github.com/shellscriptx/shellbot'
[packages]='curl 7.0, getopt 2.0, jq 1.5'
)

# Verifica dependências.
while read _pkg_ _ver_; do
	if command -v $_pkg_ &>/dev/null; then
		if [[ $($_pkg_ --version 2>&1) =~ [0-9]+\.[0-9]+ ]]; then
			if ! awk 'BEGIN { exit ARGV[1] < ARGV[2] }' $BASH_REMATCH $_ver_; then
				printf "%s: erro: requer o pacote '%s %s' ou superior.\n" ${_SHELLBOT_[name]} $_pkg_ $_ver_ 1>&2
				exit 1
			fi
		else
			printf "%s: erro: '%s' não foi possível obter a versão.\n" ${_SHELLBOT_[name]} $_pkg_ 1>&2
			exit 1
		fi
	else
		printf "%s: erro: '%s' o pacote requerido está ausente.\n" ${_SHELLBOT_[name]} $_pkg_ 1>&2
		exit 1
	fi
done <<< "${_SHELLBOT_[packages]//,/$'\n'}"

# bash (opções).
shopt -s	checkwinsize			\
			cmdhist					\
			complete_fullquote		\
			expand_aliases			\
			extglob					\
			extquote				\
			force_fignore			\
			histappend				\
			interactive_comments	\
			progcomp				\
			promptvars				\
			sourcepath

# Desabilita a expansão de nomes de arquivos (globbing).
set -f

readonly _SHELLBOT_SH_=1					# Inicialização
readonly _BOT_SCRIPT_=${0##*/}				# Script
readonly _CURL_OPT_='--silent --request'	# CURL (opções)

# Erros
readonly _ERR_TYPE_BOOL_='tipo incompatível: suporta somente "true" ou "false".'
readonly _ERR_TYPE_INT_='tipo incompatível: suporta somente inteiro.'
readonly _ERR_TYPE_FLOAT_='tipo incompatível: suporta somente float.'
readonly _ERR_PARAM_REQUIRED_='opção requerida: verique se o(s) parâmetro(s) ou argumento(s) obrigatório(s) estão presente(s).'
readonly _ERR_TOKEN_UNAUTHORIZED_='não autorizado: verifique se possui permissões para utilizar o token.'
readonly _ERR_TOKEN_INVALID_='token inválido: verique o número do token e tente novamente.'
readonly _ERR_BOT_ALREADY_INIT_='ação não permitida: o bot já foi inicializado.'
readonly _ERR_FILE_NOT_FOUND_='arquivo não encontrado: não foi possível ler o arquivo especificado.'
readonly _ERR_DIR_WRITE_DENIED_='permissão negada: não é possível gravar no diretório.'
readonly _ERR_DIR_NOT_FOUND_='Não foi possível acessar: diretório não encontrado.'
readonly _ERR_FILE_DOWNLOAD_='falha no download: arquivo não encontrado.'
readonly _ERR_FILE_INVALID_ID_='id inválido: arquivo não encontrado.'
readonly _ERR_UNKNOWN_='erro desconhecido: ocorreu uma falha inesperada. Reporte o problema ao desenvolvedor.'
readonly _ERR_SERVICE_NOT_ROOT_='acesso negado: requer privilégios de root.'
readonly _ERR_SERVICE_EXISTS_='erro ao criar o serviço: o nome do serviço já existe.'
readonly _ERR_SERVICE_SYSTEMD_NOT_FOUND_='erro ao ativar: o sistema não possui suporte ao gerenciamento de serviços "systemd".'
readonly _ERR_SERVICE_USER_NOT_FOUND_='usuário não encontrado: a conta de usuário informada é inválida.'
readonly _ERR_VAR_NAME_='variável não encontrada: o identificador é inválido ou não existe.'
readonly _ERR_FUNCTION_NOT_FOUND_='função não encontrada: o identificador especificado é inválido ou não existe.'
readonly _ERR_ARG_='argumento inválido: o argumento não é suportado pelo parâmetro especificado.'
readonly _ERR_RULE_ALREADY_EXISTS_='falha ao definir: o nome da regra já existe.'

declare -A _BOT_FUNCTION_LIST_
declare -a _BOT_RULES_LIST_

Json() { local obj=$(jq "$1" <<< "${*:2}"); obj=${obj#\"}; echo "${obj%\"}"; }

GetAllValues(){ 
	local obj=$(jq "[..|select(type == \"string\" or type == \"number\" or type == \"boolean\")|tostring]|join(\"${_BOT_DELM_/\"/\\\"}\")" <<< $*)
	obj=${obj#\"}; echo "${obj%\"}"
}

GetAllKeys(){
	local key; jq -r 'path(..|select(type == "string" or type == "number" or type == "boolean"))|map(if type == "number" then .|tostring|"["+.+"]" else . end)|join(".")' <<< $* | \
	while read key; do echo "${key//.\[/\[}"; done
}

FlagConv()
{
	local var str=$2

	while [[ $str =~ \$\{([a-z_]+)\} ]]; do
		[[ ${BASH_REMATCH[1]} == @(${_var_init_list_// /|}) ]] && var=${BASH_REMATCH[1]}[$1] || var=_
		str=${str//${BASH_REMATCH[0]}/${!var}}
	done

	echo "$str"
}

CreateLog()
{
	local i fmt

	for ((i=0; i < $1; i++)); do
		printf -v fmt "$_BOT_LOG_FORMAT_" || MessageError API

		# Suprimir erros.
		exec 5<&2
		exec 2<&-

		# Flags
		fmt=${fmt//\{OK\}/${return[ok]:-$ok}}
		fmt=${fmt//\{UPDATE_ID\}/${update_id[$i]}}
		fmt=${fmt//\{MESSAGE_ID\}/${return[message_id]:-${message_message_id[$i]:-${edited_message_message_id[$id]:-${callback_query_id[$i]}}}}}
		fmt=${fmt//\{FROM_ID\}/${return[from_id]:-${message_from_id[$i]:-${edited_message_from_id[$id]:-${callback_query_from_id[$i]}}}}}
		fmt=${fmt//\{FROM_IS_BOT\}/${return[from_is_bot]:-${message_from_is_bot[$i]:-${edited_message_from_is_bot[$id]:-${callback_query_from_is_bot[$i]}}}}}
		fmt=${fmt//\{FROM_FIRST_NAME\}/${return[from_first_name]:-${message_from_first_name[$i]:-${edited_message_from_first_name[$id]:-${callback_query_from_first_name[$i]}}}}}
		fmt=${fmt//\{FROM_USERNAME\}/${return[from_username]:-${message_from_username[$i]:-${edited_message_from_username[$id]:-${callback_query_from_username[$i]}}}}}
		fmt=${fmt//\{FROM_LANGUAGE_CODE\}/${message_from_language_code[$i]:-${edited_message_from_language_code[$id]:-${callback_query_from_language_code[$i]}}}}
		fmt=${fmt//\{CHAT_ID\}/${return[chat_id]:-${message_chat_id[$i]:-${edited_message_chat_id[$id]:-${callback_query_message_chat_id[$i]}}}}}
		fmt=${fmt//\{CHAT_TITLE\}/${return[chat_title]:-${message_chat_title[$i]:-${edited_message_chat_title[$id]:-${callback_query_message_chat_title[$i]}}}}}
		fmt=${fmt//\{CHAT_TYPE\}/${return[chat_type]:-${message_chat_type[$i]:-${edited_message_chat_type[$id]:-${callback_query_message_chat_type[$i]}}}}}
		fmt=${fmt//\{MESSAGE_DATE\}/${return[date]:-${message_date[$i]:-${edited_message_date[$id]:-${callback_query_message_date[$i]}}}}}
		fmt=${fmt//\{MESSAGE_TEXT\}/${return[text]:-${message_text[$i]:-${edited_message_text[$id]:-${callback_query_message_text[$i]}}}}}
		fmt=${fmt//\{ENTITIES_TYPE\}/${return[entities_type]:-${message_entities_type[$i]:-${edited_message_entities_type[$id]:-${callback_query_data[$i]}}}}}
		fmt=${fmt//\{BOT_TOKEN\}/${_BOT_INFO_[0]}}
		fmt=${fmt//\{BOT_ID\}/${_BOT_INFO_[1]}}
		fmt=${fmt//\{BOT_FIRST_NAME\}/${_BOT_INFO_[2]}}
		fmt=${fmt//\{BOT_USERNAME\}/${_BOT_INFO_[3]}}
		fmt=${fmt//\{BASENAME\}/$_BOT_SCRIPT_}
		fmt=${fmt//\{METHOD\}/${FUNCNAME[2]/main/ShellBot.getUpdates}}
		fmt=${fmt//\{RETURN\}/$(GetAllValues ${*:2})}

		exec 2<&5

		# log
		[[ $fmt ]] && { echo "$fmt" >> "$_BOT_LOG_FILE_" || MessageError API; }
	done

	return $?
}

MethodReturn()
{
	# Retorno
	case $_BOT_TYPE_RETURN_ in
		json) echo "$*";;
		value) GetAllValues $*;;
		map)
			local key val obj
			declare -Ag return=() || MessageError API

			for obj in $(GetAllKeys $*); do
				key=${obj//[0-9\[\]]/}
				key=${key#result.}
				key=${key//./_}

				val=$(Json ".$obj" $*)
				
				[[ ${return[$key]} ]] && return[$key]+=${_BOT_DELM_}${val} || return[$key]=$val
				[[ $_BOT_MONITOR_ ]] && printf "[%s]: return[%s] = '%s'\n" "${FUNCNAME[1]}" "$key" "$val"
			done
			;;
	esac
	
	[[ $_BOT_LOG_FILE_ ]] && CreateLog 1 $* &
	[[ $(jq -r '.ok' <<< $*) == true ]]

	return $?
}

MessageError()
{
	# Variáveis locais
	local err_message err_param err_line err_func assert ind
	
	# A variável 'BASH_LINENO' é dinâmica e armazena o número da linha onde foi expandida.
	# Quando chamada dentro de um subshell, passa ser instanciada como um array, armazenando diversos
	# valores onde cada índice refere-se a um shell/subshell. As mesmas caracteristicas se aplicam a variável
	# 'FUNCNAME', onde é armazenado o nome da função onde foi chamada.
	
	# Obtem o índice da função na hierarquia de chamada.
	[[ ${FUNCNAME[1]} == CheckArgType ]] && ind=2 || ind=1
	err_line=${BASH_LINENO[$ind]}	# linha
	err_func=${FUNCNAME[$ind]}		# função
	
	# Lê o tipo de ocorrência.
	# TG - Erro externo retornado pelo core do telegram.
	# API - Erro interno gerado pela API do ShellBot.
	case $1 in
		TG)
			# arquivo Json
			err_param="$(Json '.error_code' ${*:2})"
			err_message="$(Json '.description' ${*:2})"
			;;
		API)
			err_param="${3:--}: ${4:--}"
			err_message="$2"
			assert=1
			;;
	esac

	# Imprime erro
	printf "%s: erro: linha %s: %s: %s: %s\n"	\
							"${_BOT_SCRIPT_}"	\
							"${err_line:--}" 	\
							"${err_func:--}" 	\
							"${err_param:--}" 	\
							"${err_message:-$_ERR_UNKNOWN_}" 1>&2 

	# Finaliza script/thread em caso de erro interno, caso contrário retorna 1
	[[ $assert ]] && exit 1 || return 1
}

CheckArgType(){

	local ctype="$1"
	local param="$2"
	local value="$3"

	# CheckArgType recebe os dados da função chamadora e verifica
	# o dado recebido com o tipo suportado pelo parâmetro.
	# É retornado '0' para sucesso, caso contrário uma mensagem
	# de erro é retornada e o script/thread é finalizado com status '1'.
	case $ctype in
		user)		id "$value" &>/dev/null										|| MessageError API "$_ERR_SERVICE_USER_NOT_FOUND_" "$param" "$value";;
		func)		[[ $(type -t "$value") == function						]] 	|| MessageError API "$_ERR_FUNCTION_NOT_FOUND_" "$param" "$value";;
		var)		[[ -v $value 											]] 	|| MessageError API "$_ERR_VAR_NAME_" "$param" "$value";;
		int)		[[ $value =~ ^-?[0-9]+$ 								]] 	|| MessageError API "$_ERR_TYPE_INT_" "$param" "$value";;
		float)		[[ $value =~ ^-?[0-9]+\.[0-9]+$ 						]] 	|| MessageError API "$_ERR_TYPE_FLOAT_" "$param" "$value";;
		bool)		[[ $value =~ ^(true|false)$ 							]] 	|| MessageError API "$_ERR_TYPE_BOOL_" "$param" "$value";;
		token)		[[ $value =~ ^[0-9]+:[a-zA-Z0-9_-]+$ 					]] 	|| MessageError API "$_ERR_TOKEN_INVALID_" "$param" "$value";;
		file)		[[ $value =~ ^@ && ! -f ${value#@} 						]] 	&& MessageError API "$_ERR_FILE_NOT_FOUND_" "$param" "$value";;
		mediatype)	[[ $value == @(animation|document|audio|photo|video)	]]	|| MessageError API "$_ERR_ARG_" "$param" "$value";;
		return)		[[ $value == @(json|map|value) 							]] 	|| MessageError API "$_ERR_ARG_" "$param" "$value";;
		parsemode)	[[ $value == @(markdown|html) 							]] 	|| MessageError API "$_ERR_ARG_" "$param" "$value";;
		point)		[[ $value == @(forehead|eyes|mouth|chin) 				]] 	|| MessageError API "$_ERR_ARG_" "$param" "$value";;
		cmd)		[[ $value =~ ^/[a-zA-Z0-9_]+$ 							]] 	|| MessageError API "$_ERR_ARG_" "$param" "$value";;
		flag)		[[ $value =~ ^[a-zA-Z0-9_]+$ 							]] 	|| MessageError API "$_ERR_ARG_" "$param" "$value";;
		action)		[[ $value == @(typing|upload_photo) 					]] 	||
					[[ $value == @(record_video|upload_video) 				]] 	||
					[[ $value == @(record_audio|upload_audio) 				]] 	||
					[[ $value == @(upload_document|find_location) 			]] 	||
					[[ $value == @(record_video_note|upload_video_note) 	]] 	|| MessageError API "$_ERR_ARG_" "$param" "$value";;
		itime)		[[ $value =~ ^([01][0-9]|2[0-3]):[0-5][0-9]-([01][0-9]|2[0-3]):[0-5][0-9]$ ]] \
																				|| MessageError API "$_ERR_ARG_" "$param" "$value";;
		idate)		[[ $value =~ ^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/([0-9]{4,})-(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/([0-9]{4,})$ ]] \
																				|| MessageError API "$_ERR_ARG_" "$param" "$value";;
    esac

	return 0
}

FlushOffset()
{    
	local sid eid jq_obj

	while :; do
		jq_obj=$(ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 5)
		mapfile -t update_id < <(jq -r '.result|.[]|.update_id' <<< $jq_obj)
		[[ $update_id ]] || break
		sid=${sid:-${update_id[0]}}
		eid=${update_id[-1]}
	done
	
	echo "${sid:-0}|${eid:-0}"
	unset _FLUSH_OFFSET_

	return 0
}

CreateUnitService()
{
	local service=${1%.*}.service
	local ok='\033[0;32m[OK]\033[0;m'
	local fail='\033[0;31m[FALHA]\033[0;m'
	
	((UID == 0)) || MessageError API "$_ERR_SERVICE_NOT_ROOT_"

	# O modo 'service' requer que o sistema de gerenciamento de processos 'systemd'
	# esteja presente para que o Unit target seja linkado ao serviço.
	if ! which systemctl &>/dev/null; then
		MessageError API "$_ERR_SERVICE_SYSTEMD_NOT_FOUND_"; fi


	# Se o serviço existe.
	test -e /lib/systemd/system/$service && \
	MessageError API "$_ERR_SERVICE_EXISTS_" "$service"

	# Gerando as configurações do target.
	cat > /lib/systemd/system/$service << _eof
[Unit]
Description=$1 - (SHELLBOT)
After=network-online.target

[Service]
User=$2
WorkingDirectory=$PWD
ExecStart=/bin/bash $1
ExecReload=/bin/kill -HUP \$MAINPID
ExecStop=/bin/kill -KILL \$MAINPID
KillMode=process
Restart=on-failure
RestartPreventExitStatus=255
Type=simple

[Install]
WantedBy=multi-user.target
_eof

	[[ $? -eq 0 ]] && {	
		
		printf '%s foi criado com sucesso !!\n' $service	
		echo -n "Habilitando..."
 		systemctl enable $service &>/dev/null && echo -e $ok || \
		{ echo -e $fail; MessageError API; }

		sed -i -r '/^\s*ShellBot.init\s/s/\s--?(s(ervice)?|u(ser)?\s+\w+)\b//g' "$1"
		systemctl daemon-reload

		echo -n "Iniciando..."
		systemctl start $service &>/dev/null && {
		
			echo -e $ok
			systemctl status $service
			echo -e "\nUso: sudo systemctl {start|stop|restart|reload|status} $service"
		
		} || echo -e $fail
	
	} || MessageError API

	exit 0
}

# Inicializa o bot, definindo sua API e _TOKEN_.
ShellBot.init()
{
	# Verifica se o bot já foi inicializado.
	[[ $_SHELLBOT_INIT_ ]] && MessageError API "$_ERR_BOT_ALREADY_INIT_"
	
	local enable_service user_unit _jq_bot_info method_return delm ret logfmt
	
	local param=$(getopt --name "$FUNCNAME" \
						 --options 't:mfsu:l:o:r:d:' \
						 --longoptions 'token:,
										monitor,
										flush,
										service,
										user:,
										log_file:,
										log_format:,
										return:,
										delimiter:' \
    					 -- "$@")
    
	# Define os parâmetros posicionais
	eval set -- "$param"
   
	while :
    	do
			case $1 in
				-t|--token)
	    			CheckArgType token "$1" "$2"
	    			declare -gr _TOKEN_=$2												# TOKEN
	    			declare -gr _API_TELEGRAM_="https://api.telegram.org/bot$_TOKEN_"	# API
	    			shift 2
	   				;;
	   			-m|--monitor)
					# Ativa modo monitor
	   				declare -gr _BOT_MONITOR_=1
	   				shift
	   				;;
				-f|--flush)
					# Define a FLAG flush para o método 'ShellBot.getUpdates'. Se ativada, faz com que
					# o método obtenha somente as atualizações disponíveis, ignorando a extração dos
					# objetos JSON e a inicialização das variáveis.
					declare -x _FLUSH_OFFSET_=1
					shift
					;;
				-s|--service)
					enable_service=1
					shift
					;;
				-u|--user)
					CheckArgType user "$1" "$2"
					user_unit=$2
					shift 2
					;;
				-l|--log_file)
					declare -gr _BOT_LOG_FILE_=$2
					shift 2
					;;
				-o|--log_format)
					logfmt=$2
					shift 2
					;;
				-r|--return)
					CheckArgType return "$1" "$2"
					ret=$2
					shift 2
					;;
				-d|--delimiter)
					delm=$2
					shift 2
					;;
	   			--)
	   				shift
	   				break
	   				;;
	   		esac
	   	done
  
	# Parâmetro obrigatório.	
	[[ $_TOKEN_ ]] 							|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-t, --token]"
	[[ $user_unit && ! $enable_service ]] 	&& MessageError API "$_ERR_PARAM_REQUIRED_" "[-s, --service]" 
	[[ $enable_service ]] 					&& CreateUnitService "$_BOT_SCRIPT_" "${user_unit:-$USER}"
		   
    # Um método simples para testar o token de autenticação do seu bot. 
    # Não requer parâmetros. Retorna informações básicas sobre o bot em forma de um objeto Usuário.
    ShellBot.getMe()
    {
    	# Chama o método getMe passando o endereço da API, seguido do nome do método.
    	local jq_obj=$(curl $_CURL_OPT_ GET $_API_TELEGRAM_/${FUNCNAME#*.})

    	_jq_bot_info=$jq_obj

		# Verifica o status de retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	return $?
    }

   	ShellBot.getMe &>/dev/null || MessageError API "$_ERR_TOKEN_UNAUTHORIZED_" '[-t, --token]'
	
	# Salva as informações do bot.
	declare -gr _BOT_INFO_=(
		[0]=$_TOKEN_
		[1]=$(Json '.result.id' $_jq_bot_info)
		[2]=$(Json '.result.first_name' $_jq_bot_info)
		[3]=$(Json '.result.username' $_jq_bot_info)
	)

	# Configuração. (padrão)
	declare -gr _BOT_LOG_FORMAT_=${logfmt:-%(%d/%m/%Y %H:%M:%S)T: \{BASENAME\}: \{BOT_USERNAME\}: \{UPDATE_ID\}: \{METHOD\}: \{FROM_USERNAME\}: \{MESSAGE_TEXT\}}
	declare -gr _BOT_TYPE_RETURN_=${ret:-value}
	declare -gr _BOT_DELM_=${delm:-|}
	declare -gr _SHELLBOT_INIT_=1 
	
    # SHELLBOT (FUNÇÕES)
	# Inicializa as funções para chamadas aos métodos da API do telegram.
	ShellBot.ListUpdates(){ echo ${!update_id[@]}; }
	ShellBot.TotalUpdates(){ echo ${#update_id[@]}; }
	ShellBot.OffsetEnd(){ local -i offset=${update_id[@]: -1}; echo $offset; }
	ShellBot.OffsetNext(){ echo $((${update_id[@]: -1}+1)); }
   	
	ShellBot.token() { echo "${_BOT_INFO_[0]}"; }
	ShellBot.id() { echo "${_BOT_INFO_[1]}"; }
	ShellBot.first_name() { echo "${_BOT_INFO_[2]}"; }
	ShellBot.username() { echo "${_BOT_INFO_[3]}"; }
  
    ShellBot.regHandleFunction()
    {
    	local function callback_data handle args
    
		local param=$(getopt	--name "$FUNCNAME" \
								--options 'f:a:d:' \
								--longoptions	'function:,
												args:,
												callback_data:' \
								-- "$@")
    
		eval set -- "$param"
    		
		while :
		do
   			case $1 in
   				-f|--function)
					CheckArgType func "$1" "$2"
   					function=$2
   					shift 2
   					;;
    			-a|--args)
   					args=$2
   					shift 2
   					;;
   				-d|--callback_data)
   					callback_data=${2//|/\\|}
   					shift 2
   					;;
   				--)
   					shift
   					break
   					;;
   			esac
   		done

		[[ $function ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-f, --function]"
   		[[ $callback_data ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-d, --callback_data]"
   
   		_BOT_FUNCTION_LIST_[$callback_data]+="$function $args|"

   		return 0
    }
    
    ShellBot.watchHandle()
    {
    	local 	callback_data func func_handle \
    			param=$(getopt --name "$FUNCNAME" \
								--options 'd' \
								--longoptions 'callback_data' \
								-- "$@")
    
    	eval set -- "$param"
    
    	while :
    	do
    		case $1 in
    			-d|--callback_data)
    				shift 2
    				callback_data=$1
    				;;
    			*)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	# O parâmetro callback_data é parcial, ou seja, Se o handle for válido, os elementos
    	# serão listados. Caso contrário a função é finalizada.
    	[[ $callback_data ]] || return 1
   	
		while read -d'|' func; do $func
		done <<< ${_BOT_FUNCTION_LIST_[$callback_data]}
    
    	# retorno
    	return 0
    }
    
    ShellBot.getWebhookInfo()
    {
    	# Variável local
    	local jq_obj
	
    	# Chama o método getMe passando o endereço da API, seguido do nome do método.
    	jq_obj=$(curl $_CURL_OPT_ GET $_API_TELEGRAM_/${FUNCNAME#*.})
    	
    	# Verifica o status de retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    	
    	return $?
    }
    
    ShellBot.deleteWebhook()
    {
    	# Variável local
    	local jq_obj
	
    	# Chama o método getMe passando o endereço da API, seguido do nome do método.
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.})
    	
    	# Verifica o status de retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    	
    	return $?
    }
    
    ShellBot.setWebhook()
    {
    	local url certificate max_connections allowed_updates jq_obj
    	
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'u:c:m:a:' \
							 --longoptions 'url:, 
    										certificate:,
    										max_connections:,
    										allowed_updates:' \
    						 -- "$@")
    	
    	eval set -- "$param"
    	
    	while :
    	do
    		case $1 in
    			-u|--url)
    				url=$2
    				shift 2
    				;;
    			-c|--certificate)
					CheckArgType file "$1" "$2"
    				certificate=$2
    				shift 2
    				;;
    			-m|--max_connections)
    				CheckArgType int "$1" "$2"
    				max_connections=$2
    				shift 2
    				;;
    			-a|--allowed_updates)
    				allowed_updates=$2
    				shift 2
    				;;
    			--)
    				shift 
    				break
    				;;
    		esac
    	done
    	
    	[[ $url ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-u, --url]"
    
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${url:+-d url="$url"} \
									${certificate:+-d certificate="$certificate"} \
									${max_connections:+-d max_connections="$max_connections"} \
									${allowed_updates:+-d allowed_updates="$allowed_updates"})
    
    	# Testa o retorno do método.
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    	
    	# Status
    	return $?
    }	
    
    ShellBot.setChatPhoto()
    {
    	local chat_id photo jq_obj
    	
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:p:' \
							 --longoptions 'chat_id:,photo:' \
							 -- "$@")
    	
    	eval set -- "$param"
    	
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			-p|--photo)
					CheckArgType file "$1" "$2"
    				photo=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	[[ $chat_id ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $photo ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-p, --photo]"
    	
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-F chat_id="$chat_id"} \
 									${photo:+-F photo="$photo"})
    
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    		
    	# Status
    	return $?
    }
    
    ShellBot.deleteChatPhoto()
    {
    	local chat_id jq_obj
    	
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:' \
							 --longoptions 'chat_id:' \
							 -- "$@")
    	
    	eval set -- "$param"
    	
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	[[ $chat_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} ${chat_id:+-d chat_id="$chat_id"})
    
		MethodReturn $jq_obj || MessageError TG $jq_obj
    	
		# Status
    	return $?
    
    }
    
    ShellBot.setChatTitle()
    {
    	
    	local chat_id title jq_obj
    	
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:t:' \
							 --longoptions 'chat_id:,title:' \
							 -- "$@")
    	
    	eval set -- "$param"
    	
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			-t|--title)
    				title=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	[[ $chat_id ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $title ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-t, --title]"
    	
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-d chat_id="$chat_id"} \
 									${title:+-d title="$title"})
    
		MethodReturn $jq_obj || MessageError TG $jq_obj
    	
		# Status
    	return $?
    }
    
    
    ShellBot.setChatDescription()
    {
    	
    	local chat_id description jq_obj
    	
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:d:' \
							 --longoptions 'chat_id:,description:' \
							 -- "$@")
    	
    	eval set -- "$param"
    	
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			-d|--description)
    				description=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	[[ $chat_id ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $description ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-d, --description]"
    	
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-d chat_id="$chat_id"} \
 									${description:+-d description="$description"})
    
		MethodReturn $jq_obj || MessageError TG $jq_obj
    		
    	# Status
    	return $?
    }
    
    ShellBot.pinChatMessage()
    {
    	
    	local chat_id message_id disable_notification jq_obj
    	
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:m:n:' \
							 --longoptions 'chat_id:,
											message_id:,
    										disable_notification:' \
    						 -- "$@")
    	
    	eval set -- "$param"
    	
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			-m|--message_id)
    				CheckArgType int "$1" "$2"
    				message_id=$2
    				shift 2
    				;;
    			-n|--disable_notification)
    				CheckArgType bool "$1" "$2"
    				disable_notification=$2
    				shift 2
    				;;	
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	[[ $chat_id ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $message_id ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-m, --message_id]"
    	
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-d chat_id="$chat_id"} \
 									${message_id:+-d message_id="$message_id"} \
 									${disable_notification:+-d disable_notification="$disable_notification"})
    
		MethodReturn $jq_obj || MessageError TG $jq_obj
    		
    	# Status
    	return $?
    }
    
    ShellBot.unpinChatMessage()
    {
    	local chat_id jq_obj
    	
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:' \
							 --longoptions 'chat_id:' \
							 -- "$@")
    	
    	eval set -- "$param"
    	
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	[[ $chat_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} ${chat_id:+-d chat_id="$chat_id"})
    
		MethodReturn $jq_obj || MessageError TG $jq_obj
    		
    	# Status
    	return $?
    }
    
    ShellBot.restrictChatMember()
    {
    	local	chat_id user_id until_date can_send_messages \
    			can_send_media_messages can_send_other_messages \
    			can_add_web_page_previews jq_obj
    
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:u:d:s:m:o:w:' \
    						 --longoptions 'chat_id:,
    										user_id:,
    										until_date:,
    										can_send_messages:,
    										can_send_media_messages:,
    										can_send_other_messages:,
    										can_add_web_page_previews:' \
							 -- "$@")
    	
    	eval set -- "$param"
    	
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			-u|--user_id)
    				CheckArgType int "$1" "$2"
    				user_id=$2
    				shift 2
    				;;
    			-d|--until_date)
    				CheckArgType int "$1" "$2"
    				until_date=$2
    				shift 2
    				;;
    			-s|--can_send_messages)
    				CheckArgType bool "$1" "$2"
    				can_send_messages=$2
    				shift 2
    				;;
    			-m|--can_send_media_messages)
    				CheckArgType bool "$1" "$2"
    				can_send_media_messages=$2
    				shift 2
    				;;
    			-o|--can_send_other_messages)
    				CheckArgType bool "$1" "$2"
    				can_send_other_messages=$2
    				shift 2
    				;;
    			-w|--can_add_web_page_previews)
    				CheckArgType bool "$1" "$2"
    				can_add_web_page_previews=$2
    				shift 2
    				;;				
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	[[ $chat_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $user_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --user_id]"
    	
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-d chat_id="$chat_id"} \
									${user_id:+-d user_id="$user_id"} \
									${until_date_:+-d until_date="$until_date"} \
									${can_send_messages:+-d can_send_messages="$can_send_messages"} \
									${can_send_media_messages:+-d can_send_media_messages="$can_send_media_messages"} \
									${can_send_other_messages:+-d can_send_other_messages="$can_send_other_messages"} \
									${can_add_web_page_previews:+-d can_add_web_page_previews="$can_add_web_page_previews"})
    
		MethodReturn $jq_obj || MessageError TG $jq_obj
    		
    	# Status
    	return $?
    	
    }
    
    
    ShellBot.promoteChatMember()
    {
    	local	chat_id user_id can_change_info can_post_messages \
    			can_edit_messages can_delete_messages can_invite_users \
    			can_restrict_members can_pin_messages can_promote_members \
				jq_obj
    
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:u:i:p:e:d:v:r:f:m:' \
							 --longoptions 'chat_id:,
    										user_id:,
    										can_change_info:,
    										can_post_messages:,
    										can_edit_messages:,
    										can_delete_messages:,
    										can_invite_users:,
    										can_restrict_members:,
    										can_pin_messages:,
    										can_promote_members:' \
							 -- "$@")
    	
    	eval set -- "$param"
    	
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			-u|--user_id)
    				CheckArgType int "$1" "$2"
    				user_id=$2
    				shift 2
    				;;
    			-i|--can_change_info)
    				CheckArgType bool "$1" "$2"
    				can_change_info=$2
    				shift 2
    				;;
    			-p|--can_post_messages)
    				CheckArgType bool "$1" "$2"
    				can_post_messages=$2
    				shift 2
    				;;
    			-e|--can_edit_messages)
    				CheckArgType bool "$1" "$2"
    				can_edit_messages=$2
    				shift 2
    				;;
    			-d|--can_delete_messages)
    				CheckArgType bool "$1" "$2"
    				can_delete_messages=$2
    				shift 2
    				;;
    			-v|--can_invite_users)
    				CheckArgType bool "$1" "$2"
    				can_invite_users=$2
    				shift 2
    				;;
    			-r|--can_restrict_members)
    				CheckArgType bool "$1" "$2"
    				can_restrict_members=$2
    				shift 2
    				;;
    			-f|--can_pin_messages)
    				CheckArgType bool "$1" "$2"
    				can_pin_messages=$2
    				shift 2
    				;;	
    			-m|--can_promote_members)
    				CheckArgType bool "$1" "$2"
    				can_promote_members=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	[[ $chat_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $user_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --user_id]"
    	
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-d chat_id="$chat_id"} \
									${user_id:+-d user_id="$user_id"} \
									${can_change_info:+-d can_change_info="$can_change_info"} \
									${can_post_messages:+-d can_post_messages="$can_post_messages"} \
									${can_edit_messages:+-d can_edit_messages="$can_edit_messages"} \
									${can_delete_messages:+-d can_delete_messages="$can_delete_messages"} \
									${can_invite_users:+-d can_invite_users="$can_invite_users"} \
									${can_restrict_members:+-d can_restrict_members="$can_restrict_members"} \
									${can_pin_messages:+-d can_pin_messages="$can_pin_messages"} \
									${can_promote_members:+-d can_promote_members="$can_promote_members"})
    
		MethodReturn $jq_obj || MessageError TG $jq_obj
    		
    	# Status
    	return $?
    }
    
    ShellBot.exportChatInviteLink()
    {
    	local chat_id jq_obj
    
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:' \
							 --longoptions 'chat_id:' \
							 -- "$@")
    	
    	eval set -- "$param"
    
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    
    	[[ $chat_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	
    	jq_obj=$(curl $_CURL_OPT_ GET $_API_TELEGRAM_/${FUNCNAME#*.} ${chat_id:+-d chat_id="$chat_id"})
    	
    	# Testa o retorno do método.
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    		
    	# Status
    	return $?
    }
    
    ShellBot.sendVideoNote()
    {
    	local chat_id video_note duration length disable_notification \
    			reply_to_message_id reply_markup jq_obj
    
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:v:t:l:n:r:k:' \
							 --longoptions 'chat_id:,
    										video_note:,
    										duration:,
    										length:,
    										disable_notification:,
    										reply_to_message_id:,
    										reply_markup:' \
    						 -- "$@")
    	
    	# Define os parâmetros posicionais
    	eval set -- "$param"
    	
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			-v|--video_note)
					CheckArgType file "$1" "$2"
    				video_note=$2
    				shift 2
    				;;
    			-t|--duration)
    				CheckArgType int "$1" "$2"
    				duration=$2
    				shift 2
    				;;
    			-l|--length)
    				CheckArgType int "$1" "$2"
    				length=$2
    				shift 2
    				;;
    			-n|--disable_notification)
    				CheckArgType bool "$1" "$2"
    				disable_notification=$2
    				shift 2
    				;;
    			-r|--reply_to_message_id)
    				CheckArgType int "$1" "$2"
    				reply_to_message_id=$2
    				shift 2
    				;;
    			-k|--reply_markup)
    				reply_markup=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	[[ $chat_id ]]		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $video_note ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-v, --video_note]"
    	
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-F chat_id="$chat_id"} \
									${video_note:+-F video_note="$video_note"} \
									${duration:+-F duration="$duration"} \
									${length:+-F length="$length"} \
									${disable_notification:+-F disable_notification="$disable_notification"} \
									${reply_to_message_id:+-F reply_to_message_id="$reply_to_message_id"} \
									${reply_markup:+-F reply_markup="$reply_markup"})
    
    	# Testa o retorno do método.
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    	
    	# Status
    	return $?
    }
    
    
    ShellBot.InlineKeyboardButton()
    {
        local 	__button __line __text __url __callback_data \
                __switch_inline_query __switch_inline_query_current_chat
    
        local __param=$(getopt 	--name "$FUNCNAME" \
							 	--options 'b:l:t:u:c:q:s:' \
							 	--longoptions 'button:,
												line:,
												text:,
												url:,
												callback_data:,
												switch_inline_query:,
												switch_inline_query_chat:' \
							 	-- "$@")
    
    	eval set -- "$__param"
    
    	while :
    	do
    		case $1 in
    			-b|--button)
    				# Ponteiro que recebe o endereço de "button" com as definições
    				# da configuração do botão inserido.
					CheckArgType var "$1" "$2"
    				__button=$2
    				shift 2
    				;;
    			-l|--line)
    				CheckArgType int "$1" "$2"
					__line=$(($2-1))
    				shift 2
    				;;
    			-t|--text)
					__text=$(echo -e "$2")
    				shift 2
    				;;
    			-u|--url)
    				__url=$2
    				shift 2
    				;;
    			-c|--callback_data)
    				__callback_data=$2
    				shift 2
    				;;
    			-q|--switch_inline_query)
    				__switch_inline_query=$2
    				shift 2
    				;;
    			-s|--switch_inline_query_current_chat)
    				__switch_inline_query_current_chat=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    
    	[[ $__button ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-b, --button]"
    	[[ $__text ]] 			|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-t, --text]"
    	[[ $__callback_data ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --callback_data]"
    	[[ $__line ]] 			|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-l, --line]"
    	
		__button=$__button[$__line]

		printf -v $__button "${!__button#[}"
		printf -v $__button "${!__button%]}"
		
		printf -v $__button '%s {"text": "%s", "callback_data": "%s", "url": "%s", "switch_inline_query": "%s", "switch_inline_query_current_chat": "%s"}' 	\
							"${!__button:+${!__button},}"																									\
							"${__text}"																														\
							"${__callback_data}"																											\
							"${__url}"																														\
							"${__switch_inline_query}"																										\
							"${__switch_inline_query_current_chat}"

		printf -v $__button "[${!__button}]"

    	return $?
    }
    
    ShellBot.InlineKeyboardMarkup()
    {
    	local __button __keyboard

        local __param=$(getopt 	--name "$FUNCNAME" \
							 	--options 'b:' \
							 	--longoptions 'button:' \
							 	-- "$@")
    
    	eval set -- "$__param"
    
    	while :
    	do
    		case $1 in
    			-b|--button)
    				# Ponteiro que recebe o endereço da variável "teclado" com as definições
    				# de configuração do botão inserido.
					CheckArgType var "$1" "$2"
    				__button="$2"
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	[[ $__button ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-b, --button]"
    
		__button=$__button[@]

		printf -v __keyboard '%s,' "${!__button}"
		printf -v __keyboard "${__keyboard%,}"

    	# Constroi a estrutura dos objetos + array keyboard, define os valores e salva as configurações.
    	# Por padrão todos os valores são 'false' até que seja definido.
		printf '{"inline_keyboard": [%s]}' "${__keyboard}"
    
		return $?
    }
    
    ShellBot.answerCallbackQuery()
    {
    	local callback_query_id text show_alert url cache_time jq_obj
    	
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:t:s:u:e:' \
    						 --longoptions 'callback_query_id:,
    										text:,
    										show_alert:,
    										url:,
    										cache_time:' \
    						 -- "$@")
    
    
    	eval set -- "$param"
    	
    	while :
    	do
    		case $1 in
    			-c|--callback_query_id)
    				callback_query_id=$2
    				shift 2
    				;;
    			-t|--text)
					text=$(echo -e "$2")
    				shift 2
    				;;
    			-s|--show_alert)
    				# boolean
    				CheckArgType bool "$1" "$2"
    				show_alert=$2
    				shift 2
    				;;
    			-u|--url)
    				url=$2
    				shift 2
    				;;
    			-e|--cache_time)
    				# inteiro
    				CheckArgType int "$1" "$2"
    				cache_time=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	[[ $callback_query_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --callback_query_id]"
    	
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${callback_query_id:+-d callback_query_id="$callback_query_id"} \
									${text:+-d text="$text"} \
									${show_alert:+-d show_alert="$show_alert"} \
									${url:+-d url="$url"} \
									${cache_time:+-d cache_time="$cache_time"})
    
		MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	return $?
    }
    
    # Cria objeto que representa um teclado personalizado com opções de resposta
    ShellBot.ReplyKeyboardMarkup()
    {
    	# Variáveis locais
    	local __button __resize_keyboard __on_time_keyboard __selective __keyboard
    	
    	# Lê os parâmetros da função.
    	local __param=$(getopt 	--name "$FUNCNAME" \
							 	--options 'b:r:t:s:' \
    						 	--longoptions 'button:,
    										resize_keyboard:,
    										one_time_keyboard:,
    										selective:' \
    						 	-- "$@")
    	
    	# Transforma os parâmetros da função em parâmetros posicionais
    	#
    	# Exemplo:
    	#	--param1 arg1 --param2 arg2 --param3 arg3 ...
    	# 		$1			  $2			$3
    	eval set -- "$__param"
    	
    	# Aguarda leitura dos parâmetros
    	while :
    	do
    		# Lê o parâmetro da primeira posição "$1"; Se for um parâmetro válido,
    		# salva o valor do argumento na posição '$2' e desloca duas posições a esquerda (shift 2); Repete o processo
    		# até que o valor de '$1' seja igual '--' e finaliza o loop.
    		case $1 in
    			-b|--button)
					CheckArgType var "$1" "$2"
    				__button=$2
    				shift 2
    				;;
    			-r|--resize_keyboard)
    				# Tipo: boolean
    				CheckArgType bool "$1" "$2"
    				__resize_keyboard=$2
    				shift 2
    				;;
    			-t|--one_time_keyboard)
    				# Tipo: boolean
    				CheckArgType bool "$1" "$2"
    				__on_time_keyboard=$2
    				shift 2
    				;;
    			-s|--selective)
    				# Tipo: boolean
    				CheckArgType bool "$1" "$2"
    				__selective=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	# Imprime mensagem de erro se o parâmetro obrigatório for omitido.
    	[[ $__button ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-b, --button]"
		
		__button=$__button[@]

		printf -v __keyboard '%s,' "${!__button}"
		printf -v __keyboard "${__keyboard%,}"

    	# Constroi a estrutura dos objetos + array keyboard, define os valores e salva as configurações.
    	# Por padrão todos os valores são 'false' até que seja definido.
		printf '{"keyboard": [%s], "resize_keyboard": %s, "one_time_keyboard": %s, "selective": %s}'	\
				"${__keyboard}"																			\
				"${__resize_keyboard:-false}" 															\
				"${__on_time_keyboard:-false}"															\
				"${__selective:-false}"

    	# status
    	return $?
    }

	ShellBot.KeyboardButton()
	{
		local __text __contact __location __button __line

		local __param=$(getopt	--name "$FUNCNAME"	\
								--options 'b:l:t:c:o:'	\
								--longoptions 'button:,
												line:,
												text:,
												request_contact:,
												request_location:' \
								-- "$@")
	
		eval set -- "$__param"
	
		while :
		do
			case $1 in
				-b|--button)
					CheckArgType var "$1" "$2"
					__button=$2
					shift 2
					;;
				-l|--line)
					CheckArgType int "$1" "$2"
					__line=$(($2-1))
					shift 2
					;;
				-t|--text)
					__text=$2
					shift 2
					;;
				-c|--request_contact)
					CheckArgType bool "$1" "$2"
					__contact=$2
					shift 2
					;;
				-o|--request_location)
					CheckArgType bool "$1" "$2"
					__location=$2
					shift 2
					;;
				--)
					shift
					break
					;;
			esac
		done

    	[[ $__button ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-b, --button]"
    	[[ $__text ]] 			|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-t, --text]"
    	[[ $__line ]] 			|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-l, --line]"
    
		__button=$__button[$__line]

		printf -v $__button "${!__button#[}"
		printf -v $__button "${!__button%]}"
		
		printf -v $__button '%s {"text": "%s", "request_contact": %s, "request_location": %s}' 	\
							"${!__button:+${!__button},}"										\
							"${__text}"															\
							"${__contact:-false}"												\
							"${__location:-false}"

		printf -v $__button "[${!__button}]"

    	return $?
	}
	
	ShellBot.ForceReply()
	{
		local selective

		local param=$(getopt 	--name "$FUNCNAME" 			\
								--options 's:' 				\
								--longoptions 'selective:' 	\
								-- "$@")

		eval set -- "$param"

		while :
		do
			case $1 in
				-s|--selective)
					CheckArgType bool "$1" "$2"
					selective=$2
					shift 2
					;;
				--)
					shift
					break
					;;
			esac
		done

		printf '{"force_reply": true, "selective": %s}' ${selective:-false}

		return $?
	}

	ShellBot.ReplyKeyboardRemove()
	{
		local selective

		local param=$(getopt 	--name "$FUNCNAME" 			\
								--options 's:' 				\
								--longoptions 'selective:' 	\
								-- "$@")

		eval set -- "$param"

		while :
		do
			case $1 in
				-s|--selective)
					CheckArgType bool "$1" "$2"
					selective=$2
					shift 2
					;;
				--)
					shift
					break
					;;
			esac
		done

		printf '{"remove_keyboard": true, "selective": %s}' ${selective:-false}

		return $?
	}

    # Envia mensagens 
    ShellBot.sendMessage()
    {
    	# Variáveis locais 
    	local chat_id text parse_mode disable_web_page_preview
		local disable_notification reply_to_message_id reply_markup jq_obj
    	
    	# Lê os parâmetros da função
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:t:p:w:n:r:k:' \
							 --longoptions 'chat_id:,
    										text:,
    										parse_mode:,
    										disable_web_page_preview:,
    										disable_notification:,
    										reply_to_message_id:,
    										reply_markup:' \
    						 -- "$@")
    
    	# Define os parâmetros posicionais
    	eval set -- "$param"
    	
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			-t|--text)
					text=$(echo -e "$2")
    				shift 2
    				;;
    			-p|--parse_mode)
    				# Tipo: "markdown" ou "html"
    				CheckArgType parsemode "$1" "$2"
    				parse_mode=$2
    				shift 2
    				;;
    			-w|--disable_web_page_preview)
    				# Tipo: boolean
    				CheckArgType bool "$1" "$2"
    				disable_web_page_preview=$2
    				shift 2
    				;;
    			-n|--disable_notification)
    				# Tipo: boolean
    				CheckArgType bool "$1" "$2"
    				disable_notification=$2
    				shift 2
    				;;
    			-r|--reply_to_message_id)
    				# Tipo: inteiro
    				CheckArgType int "$1" "$2"
    				reply_to_message_id=$2
    				shift 2
    				;;
    			-k|--reply_markup)
    				reply_markup=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    
    	# Parâmetros obrigatórios.
    	[[ $chat_id ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $text ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-t, --text]"
    
    	# Chama o método da API, utilizando o comando request especificado; Os parâmetros 
    	# e valores são passados no form e lidos pelo método. O retorno do método é redirecionado para o arquivo 'update.Json'.
    	# Variáveis com valores nulos são ignoradas e consequentemente os respectivos parâmetros omitidos.
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-d chat_id="$chat_id"} \
									${text:+-d text="$text"} \
									${parse_mode:+-d parse_mode="$parse_mode"} \
									${disable_web_page_preview:+-d disable_web_page_preview="$disable_web_page_preview"} \
									${disable_notification:+-d disable_notification="$disable_notification"} \
									${reply_to_message_id:+-d reply_to_message_id="$reply_to_message_id"} \
									${reply_markup:+-d reply_markup="$reply_markup"})
   
    	# Testa o retorno do método.
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    	
    	# Status
    	return $?
    }
    
    # Função para reencaminhar mensagens de qualquer tipo.
    ShellBot.forwardMessage()
    {
    	# Variáveis locais
    	local chat_id form_chat_id disable_notification message_id jq_obj
    	
    	# Lê os parâmetros da função
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:f:n:m:' \
    						 --longoptions 'chat_id:,
    										from_chat_id:,
    										disable_notification:,
    										message_id:' \
    						 -- "$@")
    
    	
    	# Define os parâmetros posicionais
    	eval set -- "$param"
    
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id="$2"
    				shift 2
    				;;
    			-f|--from_chat_id)
    				from_chat_id="$2"
    				shift 2
    				;;
    			-n|--disable_notification)
    				# Tipo: boolean
    				CheckArgType bool "$1" "$2"
    				disable_notification="$2"
    				shift 2
    				;;
    			-m|--message_id)
    				# Tipo: inteiro
    				CheckArgType int "$1" "$2"
    				message_id="$2"
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	# Parâmetros obrigatórios.
    	[[ $chat_id ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $from_chat_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-f, --from_chat_id]"
    	[[ $message_id ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-m, --message_id]"
    
    	# Chama o método
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-d chat_id="$chat_id"} \
									${from_chat_id:+-d from_chat_id="$from_chat_id"} \
									${disable_notification:+-d disable_notification="$disable_notification"} \
									${message_id:+-d message_id="$message_id"})
    	
    	# Retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	# status
    	return $?
    }
    
    # Utilize essa função para enviar fotos.
    ShellBot.sendPhoto()
    {
    	# Variáveis locais
    	local chat_id photo caption disable_notification reply_to_message_id reply_markup jq_obj
    
    	# Lê os parâmetros da função
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:p:t:n:r:k:' \
    						 --longoptions 'chat_id:, 
    										photo:,
    										caption:,
    										disable_notification:,
    										reply_to_message_id:,
    										reply_markup:' \
    						 -- "$@")
    
    
    	# Define os parâmetros posicionais
    	eval set -- "$param"
    
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			-p|--photo)
					CheckArgType file "$1" "$2"
    				photo=$2
    				shift 2
    				;;
    			-t|--caption)
    				# Limite máximo de caracteres: 200
					caption=$(echo -e "$2")
    				shift 2
    				;;
    			-n|--disable_notification)
    				# Tipo: boolean
    				CheckArgType bool "$1" "$2"
    				disable_notification=$2
    				shift 2
    				;;
    			-r|--reply_to_message_id)
    				# Tipo: inteiro
    				CheckArgType int "$1" "$2"
    				reply_to_message_id=$2
    				shift 2
    				;;
    			-k|--reply_markup)
    				reply_markup=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	# Parâmetros obrigatórios
    	[[ $chat_id ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $photo ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-p, --photo]"
    	
    	# Chama o método
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-F chat_id="$chat_id"} \
									${photo:+-F photo="$photo"} \
									${caption:+-F caption="$caption"} \
									${disable_notification:+-F disable_notification="$disable_notification"} \
									${reply_to_message_id:+-F reply_to_message_id="$reply_to_message_id"} \
									${reply_markup:+-F reply_markup="$reply_markup"})
    	
    	# Retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	# Status
    	return $?
    }
    
    # Utilize essa função para enviar arquivos de audio.
    ShellBot.sendAudio()
    {
    	# Variáveis locais
    	local chat_id audio caption duration performer title disable_notification reply_to_message_id reply_markup jq_obj
    	
    	# Lê os parâmetros da função
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:a:t:d:e:i:n:r:k' \
    						 --longoptions 'chat_id:,
    										audio:,
    										caption:,
    										duration:,
    										performer:,
    										title:,
    										disable_notification:,
    										reply_to_message_id:,	
    										reply_markup:' \
    						 -- "$@")
    
    	# Define os parâmetros posicionais
    	eval set -- "$param"
    
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			-a|--audio)
					CheckArgType file "$1" "$2"
    				audio=$2
    				shift 2
    				;;
    			-t|--caption)
					caption=$(echo -e "$2")
    				shift 2
    				;;
    			-d|--duration)
    				# Tipo: inteiro
    				CheckArgType int "$1" "$2"
    				duration=$2
    				shift 2
    				;;
    			-e|--performer)
    				performer=$2
    				shift 2
    				;;
    			-i|--title)
    				title=$2
    				shift 2
    				;;
    			-n|--disable_notification)
    				# Tipo: boolean
    				CheckArgType bool "$1" "$2"
    				disable_notification=$2
    				shift 2
    				;;
    			-r|--reply_to_message_id)
    				# Tipo: inteiro
    				CheckArgType int "$1" "$2"
    				reply_to_message_id=$2
    				shift 2
    				;;
    			-k|--reply_markup)
    				reply_markup=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	# Parâmetros obrigatórios
    	[[ $chat_id ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $audio ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-a, --audio]"
    	
    	# Chama o método
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-F chat_id="$chat_id"} \
									${audio:+-F audio="$audio"} \
									${caption:+-F caption="$caption"} \
									${duration:+-F duration="$duration"} \
									${performer:+-F performer="$performer"} \
									${title:+-F title="$title"} \
									${disable_notification:+-F disable_notification="$disable_notification"} \
									${reply_to_message_id:+-F reply_to_message_id="$reply_to_message_id"} \
									${reply_markup:+-F reply_markup="$reply_markup"})
    
    	# Retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	# Status
    	return $?
    		
    }
    
    # Utilize essa função para enviar documentos.
    ShellBot.sendDocument()
    {
    	# Variáveis locais
    	local chat_id document caption disable_notification reply_to_message_id reply_markup jq_obj
    	
    	# Lê os parâmetros da função
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:d:t:n:r:k:' \
    						 --longoptions 'chat_id:,
											document:,
    										caption:,
    										disable_notification:,
    										reply_to_message_id:,
    										reply_markup:' \
    						 -- "$@")
    
    	
    	# Define os parâmetros posicionais
    	eval set -- "$param"
    
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			-d|--document)
					CheckArgType file "$1" "$2"
    				document=$2
    				shift 2
    				;;
    			-t|--caption)
					caption=$(echo -e "$2")
    				shift 2
    				;;
    			-n|--disable_notification)
    				CheckArgType bool "$1" "$2"
    				disable_notification=$2
    				shift 2
    				;;
    			-r|--reply_to_message_id)
    				CheckArgType int "$1" "$2"
    				reply_to_message_id=$2
    				shift 2
    				;;
    			-k|--reply_markup)
    				reply_markup=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	# Parâmetros obrigatórios
    	[[ $chat_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $document ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-d, --document]"
    	
    	# Chama o método
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-F chat_id="$chat_id"} \
									${document:+-F document="$document"} \
									${caption:+-F caption="$caption"} \
									${disable_notification:+-F disable_notification="$disable_notification"} \
									${reply_to_message_id:+-F reply_to_message_id="$reply_to_message_id"} \
									${reply_markup:+-F reply_markup="$reply_markup"})
    
    	# Retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	# Status
    	return $?
    	
    }
    
    # Utilize essa função para enviat stickers
    ShellBot.sendSticker()
    {
    	# Variáveis locais
    	local chat_id sticker disable_notification reply_to_message_id reply_markup jq_obj
    
    	# Lê os parâmetros da função
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:s:n:r:k:' \
    						 --longoptions 'chat_id:,
    										sticker:,
    										disable_notification:,
    										reply_to_message_id:,
    										reply_markup:' \
    						 -- "$@")
    
    	# Define os parâmetros posicionais
    	eval set -- "$param"
    
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			-s|--sticker)
					CheckArgType file "$1" "$2"
    				sticker=$2
    				shift 2
    				;;
    			-n|--disable_notification)
    				# Tipo: boolean
    				CheckArgType bool "$1" "$2"
    				disable_notification=$2
    				shift 2
    				;;
    			-r|--reply_to_message_id)
    				# Tipo: inteiro
    				CheckArgType int "$1" "$2"
    				reply_to_message_id=$2
    				shift 2
    				;;
    			-k|--reply_markup)
    				reply_markup=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	# Parâmetros obrigatórios
    	[[ $chat_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $sticker ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-s, --sticker]"
    
    	# Chama o método
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-F chat_id="$chat_id"} \
									${sticker:+-F sticker="$sticker"} \
									${disable_notification:+-F disable_notification="$disable_notification"} \
									${reply_to_message_id:+-F reply_to_message_id="$reply_to_message_id"} \
									${reply_markup:+-F reply_markup="$reply_markup"})
    
    	# Testa o retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	# Status
    	return $?
    }
   
	ShellBot.getStickerSet()
	{
		local name jq_obj
		
		local param=$(getopt --name "$FUNCNAME" \
							 --options 'n:' \
							 --longoptions 'name:' \
							 -- "$@")
		
		# parâmetros posicionais
		eval set -- "$param"

		while :
		do
			case $1 in
				-n|--name)
					name=$2
					shift 2
					;;
				--)
					shift
					break
					;;
			esac
		done
    	
		[[ $name ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-n, --name]"
    	
		jq_obj=$(curl $_CURL_OPT_ GET $_API_TELEGRAM_/${FUNCNAME#*.} ${name:+-d name="$name"})
    
		# Testa o retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	# Status
    	return $?
	} 
	
	ShellBot.uploadStickerFile()
	{
		local user_id png_sticker jq_obj
		
		local param=$(getopt --name "$FUNCNAME" \
							 --options 'u:s:' \
							 --longoptions 'user_id:,
											png_sticker:' \
							 -- "$@")
		
		eval set -- "$param"
		
		while :
		do
			case $1 in
				-u|--user_id)
    				CheckArgType int "$1" "$2"
					user_id=$2
					shift 2
					;;
				-s|--png_sticker)
					CheckArgType file "$1" "$2"
					png_sticker=$2
					shift 2
					;;
				--)
					shift
					break
					;;
				esac
		done

		[[ $user_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-u, --user_id]"
		[[ $png_sticker ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-s, --png_sticker]"
    	
		jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${user_id:+-F user_id="$user_id"} \
									${png_sticker:+-F png_sticker="$png_sticker"})
    	
		# Testa o retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	# Status
    	return $?
					
	}

	ShellBot.setStickerPositionInSet()
	{
		local sticker position jq_obj

		local param=$(getopt --name "$FUNCNAME" \
							 --options 's:p:' \
							 --longoptions 'sticker:,
											position:' \
							 -- "$@")
		
		eval set -- "$param"

		while :
		do
			case $1 in
				-s|--sticker)
					sticker=$2
					shift 2
					;;
				-p|--position)
					CheckArgType int "$1" "$2"
					position=$2
					shift 2
					;;
				--)
					shift
					break
					;;
			esac
		done
		
		[[ $sticker ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-s, --sticker]"
		[[ $position ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-p, --position]"
    	
		jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${sticker:+-d sticker="$sticker"} \
									${position:+-d position="$position"})
    	
		# Testa o retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
		# Status
    	return $?
				
	}
	
	ShellBot.deleteStickerFromSet()
	{
		local sticker jq_obj

		local param=$(getopt --name "$FUNCNAME" \
							 --options 's:' \
							 --longoptions 'sticker:' \
							 -- "$@")
		
		eval set -- "$param"

		while :
		do
			case $1 in
				-s|--sticker)
					sticker=$2
					shift 2
					;;
				--)
					shift
					break
					;;
			esac
		done
		
		[[ $sticker ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-s, --sticker]"
    	
		jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} ${sticker:+-d sticker="$sticker"})
    	
		# Testa o retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    	
		# Status
    	return $?
				
	}
	
	ShellBot.stickerMaskPosition()
	{

		local point x_shift y_shift scale zoom
		
		local param=$(getopt --name "$FUNCNAME" \
							 --options 'p:x:y:s:z:' \
							 --longoptions 'point:,
											x_shift:,
											y_shift:,
											scale:,
											zoom:' \
							 -- "$@")

		eval set -- "$param"
		
		while :
		do
			case $1 in
				-p|--point)
					CheckArgType point "$1" "$2"
					point=$2
					shift 2
					;;
				-x|--x_shift)
					CheckArgType float "$1" "$2"
					x_shift=$2
					shift 2
					;;
				-y|--y_shift)
					CheckArgType float "$1" "$2"
					y_shift=$2
					shift 2
					;;
				-s|--scale)
					CheckArgType float "$1" "$2"
					scale=$2
					shift 2
					;;
				-z|--zoom)
					CheckArgType float "$1" "$2"
					zoom=$2
					shift 2
					;;
				--)
					shift
					break
					;;
			esac
		done
		
		[[ $point ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-p, --point]"
		[[ $x_shift ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-x, --x_shift]"
		[[ $y_shift ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-y, --y_shift]"
		[[ $scale ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-s, --scale]"
		[[ $zoom ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-z, --zoom]"
		
		cat << _EOF
{ "point": "$point", "x_shift": $x_shift, "y_shift": $y_shift, "scale": $scale, "zoom": $zoom }
_EOF

	return 0

	}

	ShellBot.createNewStickerSet()
	{
		local user_id name title png_sticker emojis contains_masks mask_position jq_obj
		
		local param=$(getopt --name "$FUNCNAME" \
							 --options 'u:n:t:s:e:c:m:' \
							 --longoptions 'user_id:,
											name:,
											title:,
											png_sticker:,
											emojis:,
											contains_mask:,
											mask_position:' \
							 -- "$@")

		eval set -- "$param"
		
		while :
		do
			case $1 in
				-u|--user_id)
					CheckArgType int "$1" "$2"
					user_id=$2
					shift 2
					;;
				-n|--name)
					name=$2
					shift 2
					;;
				-t|--title)
					title=$2
					shift 2
					;;
				-s|--png_sticker)
					CheckArgType file "$1" "$2"
					png_sticker=$2
					shift 2
					;;
				-e|--emojis)
					emojis=$2
					shift 2
					;;
				-c|--contains_masks)
    				CheckArgType bool "$1" "$2"
					contains_masks=$2
					shift 2
					;;
				-m|--mask_position)
					mask_position=$2
					shift 2
					;;
				--)
					shift
					break
					;;
			esac
		done
		
		[[ $user_id ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-u, --user_id]"
		[[ $name ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-n, --name]"
		[[ $title ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-t, --title]"
		[[ $png_sticker ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-s, --png_sticker]"
		[[ $emojis ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-e, --emojis]"
	
		jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${user_id:+-F user_id="$user_id"} \
									${name:+-F name="$name"} \
									${title:+-F title="$title"} \
									${png_sticker:+-F png_sticker="$png_sticker"} \
									${emojis:+-F emojis="$emojis"} \
									${contains_masks:+-F contains_masks="$contains_masks"} \
									${mask_position:+-F mask_position="$mask_position"})
    	
		# Testa o retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    	
		# Status
    	return $?
			
	}
	
	ShellBot.addStickerToSet()
	{
		local user_id name png_sticker emojis mask_position jq_obj
		
		local param=$(getopt --name "$FUNCNAME" \
							 --options 'u:n:s:e:m:' \
							 --longoptions 'user_id:,
											name:,
											png_sticker:,
											emojis:,
											mask_position:' \
							 -- "$@")

		eval set -- "$param"
		
		while :
		do
			case $1 in
				-u|--user_id)
					CheckArgType int "$1" "$2"
					user_id=$2
					shift 2
					;;
				-n|--name)
					name=$2
					shift 2
					;;
				-s|--png_sticker)
					CheckArgType file "$1" "$2"
					png_sticker=$2
					shift 2
					;;
				-e|--emojis)
					emojis=$2
					shift 2
					;;
				-m|--mask_position)
					mask_position=$2
					shift 2
					;;
				--)
					shift
					break
					;;
			esac
		done
		
		[[ $user_id ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-u, --user_id]"
		[[ $name ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-n, --name]"
		[[ $png_sticker ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-s, --png_sticker]"
		[[ $emojis ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-e, --emojis]"
	
		jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${user_id:+-F user_id="$user_id"} \
									${name:+-F name="$name"} \
									${png_sticker:+-F png_sticker="$png_sticker"} \
									${emojis:+-F emojis="$emojis"} \
									${mask_position:+-F mask_position="$mask_position"})
    	
		# Testa o retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    	
		# Status
    	return $?
			
	}

    # Função para enviar arquivos de vídeo.
    ShellBot.sendVideo()
    {
    	# Variáveis locais
    	local chat_id video duration width height caption disable_notification \
				reply_to_message_id reply_markup jq_obj supports_streaming
    
    	# Lê os parâmetros da função
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:v:d:w:h:t:n:r:k:s:' \
							 --longoptions 'chat_id:,
    										video:,
    										duration:,
    										width:,
    										height:,
    										caption:,
    										disable_notification:,
    										reply_to_message_id:,
    										reply_markup:,
											supports_streaming:' \
    						 -- "$@")
    
    	
    	# Define os parâmetros posicionais
    	eval set -- "$param"
    
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			-v|--video)
					CheckArgType file "$1" "$2"
    				video=$2
    				shift 2
    				;;
    			-d|--duration)
    				# Tipo: inteiro
    				CheckArgType int "$1" "$2"
    				duration=$2
    				shift 2
    				;;
    			-w|--width)
    				# Tipo: inteiro
    				CheckArgType int "$1" "$2"
    				width=$2
    				shift 2
    				;;
    			-h|--height)
    				# Tipo: inteiro
    				CheckArgType int "$1" "$2"
    				height=$2
    				shift 2
    				;;
    			-t|--caption)
					caption=$(echo -e "$2")
    				shift 2
    				;;
    			-n|--disable_notification)
    				# Tipo: boolean
    				CheckArgType bool "$1" "$2"
    				disable_notification=$2
    				shift 2
    				;;
    			-r|--reply_to_message_id)
    				CheckArgType int "$1" "$2"
    				reply_to_message_id=$2
    				shift 2
    				;;
    			-k|--reply_markup)
    				reply_markup=$2
    				shift 2
    				;;
				-s|--supports_streaming)
    				CheckArgType bool "$1" "$2"
					supports_streaming=$2
					shift 2
					;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	# Parâmetros obrigatórios.
    	[[ $chat_id ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $video ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-v, --video]"
    
    	# Chama o método
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-F chat_id="$chat_id"} \
									${video:+-F video="$video"} \
									${duration:+-F duration="$duration"} \
									${width:+-F width="$width"} \
									${height:+-F height="$height"} \
									${caption:+-F caption="$caption"} \
									${disable_notification:+-F disable_notification="$disable_notification"} \
    								${reply_to_message_id:+-F reply_to_message_id="$reply_to_message_id"} \
    								${reply_markup:+-F reply_markup="$reply_markup"} \
									${supports_streaming:+-F supports_streaming="$supports_streaming"})
    
    	# Testa o retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	# Status
    	return $?
    	
    }
    
    # Função para enviar audio.
    ShellBot.sendVoice()
    {
    	# Variáveis locais
    	local chat_id voice caption duration disable_notification reply_to_message_id reply_markup jq_obj
    
    	# Lê os parâmetros da função
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:v:t:d:n:r:k:' \
    						 --longoptions 'chat_id:,
    										voice:,
    										caption:,
    										duration:,
    										disable_notification:,
    										reply_to_message_id:,
    										reply_markup:' \
    						 -- "$@")
    
    	
    	# Define os parâmetros posicionais
    	eval set -- "$param"
    
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			-v|--voice)
					CheckArgType file "$1" "$2"
    				voice=$2
    				shift 2
    				;;
    			-t|--caption)
					caption=$(echo -e "$2")
    				shift 2
    				;;
    			-d|--duration)
    				# Tipo: inteiro
    				CheckArgType int "$1" "$2"
    				duration=$2
    				shift 2
    				;;
    			-n|--disable_notification)
    				# Tipo: boolean
    				CheckArgType bool "$1" "$2"
    				disable_notification=$2
    				shift 2
    				;;
    			-r|--reply_to_message_id)
    				# Tipo: inteiro
    				CheckArgType int "$1" "$2"
    				reply_to_message_id=$2
    				shift 2
    				;;
    			-k|--reply_markup)
    				reply_markup=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
					;;
    		esac
    	done
    	
    	# Parâmetros obrigatórios.
    	[[ $chat_id ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $voice ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-v, --voice]"
    	
    	# Chama o método
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-F chat_id="$chat_id"} \
    								${voice:+-F voice="$voice"} \
    								${caption:+-F caption="$caption"} \
    								${duration:+-F duration="$duration"} \
    								${disable_notification:+-F disable_notification="$disable_notification"} \
    								${reply_to_message_id:+-F reply_to_message_id="$reply_to_message_id"} \
    								${reply_markup:+-F reply_markup="$reply_markup"})
    
    	# Testa o retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	# Status
    	return $?
    	
    }
    
    # Função utilizada para enviar uma localidade utilizando coordenadas de latitude e longitude.
    ShellBot.sendLocation()
    {
    	# Variáveis locais
    	local chat_id latitude longitude live_period
		local disable_notification reply_to_message_id reply_markup jq_obj
    
    	# Lê os parâmetros da função
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:l:g:p:n:r:k:' \
    						 --longoptions 'chat_id:,
    										latitude:,
    										longitude:,
											live_period:,
    										disable_notification:,
    										reply_to_message_id:,
    										reply_markup:' \
    						 -- "$@")
    
    	
    	# Define os parâmetros posicionais
    	eval set -- "$param"
    	
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			-l|--latitude)
    				# Tipo: float
    				CheckArgType float "$1" "$2"
    				latitude=$2
    				shift 2
    				;;
    			-g|--longitude)
    				# Tipo: float
    				CheckArgType float "$1" "$2"
    				longitude=$2
    				shift 2
    				;;
				-p|--live_period)
    				CheckArgType int "$1" "$2"
					live_period=$2
					shift 2
					;;
    			-n|--disable_notification)
    				# Tipo: boolean
    				CheckArgType bool "$1" "$2"
    				disable_notification=$2
    				shift 2
    				;;
    			-r|--reply_to_message_id)
    				# Tipo: inteiro
    				CheckArgType int "$1" "$2"
    				reply_to_message_id=$2
    				shift 2
    				;;
    			-k|--reply_markup)
    				reply_markup=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
					;;
    		esac
    	done
    	
    	# Parâmetros obrigatórios
    	[[ $chat_id ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $latitude ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-l, --latitude]"
    	[[ $longitude ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-g, --longitude]"
    			
    	# Chama o método
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-F chat_id="$chat_id"} \
    								${latitude:+-F latitude="$latitude"} \
    								${longitude:+-F longitude="$longitude"} \
									${live_period:+-F live_period="$live_period"} \
    								${disable_notification:+-F disable_notification="$disable_notification"} \
    								${reply_to_message_id:+-F reply_to_message_id="$reply_to_message_id"} \
    								${reply_markup:+-F reply_markup="$reply_markup"})
    
    	# Testa o retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	return $?
    	
    }
    
    # Função utlizada para enviar detalhes de um local.
    ShellBot.sendVenue()
    {
    	# Variáveis locais
    	local chat_id latitude longitude title address foursquare_id disable_notification reply_to_message_id reply_markup jq_obj
    	
    	# Lê os parâmetros da função
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:l:g:i:a:f:n:r:k:' \
    						 --longoptions 'chat_id:,
    										latitude:,
    										longitude:,
    										title:,
    										address:,
    										foursquare_id:,
    										disable_notification:,
    										reply_to_message_id:,
    										reply_markup:' \
    						 -- "$@")
    
    	# Define os parâmetros posicionais
    	eval set -- "$param"
    	
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			-l|--latitude)
    				# Tipo: float
    				CheckArgType float "$1" "$2"
    				latitude=$2
    				shift 2
    				;;
    			-g|--longitude)
    				# Tipo: float
    				CheckArgType float "$1" "$2"
    				longitude=$2
    				shift 2
    				;;
    			-i|--title)
    				title=$2
    				shift 2
    				;;
    			-a|--address)
    				address=$2
    				shift 2
    				;;
    			-f|--foursquare_id)
    				foursquare_id=$2
    				shift 2
    				;;
    			-n|--disable_notification)
    				# Tipo: boolean
    				CheckArgType bool "$1" "$2"
    				disable_notification=$2
    				shift 2
    				;;
    			-r|--reply_to_message_id)
    				# Tipo: inteiro
    				CheckArgType int "$1" "$2"
    				reply_to_message_id=$2
    				shift 2
    				;;
    			-k|--reply_markup)
    				reply_markup=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
					;;
    		esac
    	done
    			
    	# Parâmetros obrigatórios.
    	[[ $chat_id ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $latitude ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-l, --latitude]"
    	[[ $longitude ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-g, --longitude]"
    	[[ $title ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-i, --title]"
    	[[ $address ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-a, --address]"
    	
    	# Chama o método
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-F chat_id="$chat_id"} \
    								${latitude:+-F latitude="$latitude"} \
    								${longitude:+-F longitude="$longitude"} \
    								${title:+-F title="$title"} \
    								${address:+-F address="$address"} \
    								${foursquare_id:+-F foursquare_id="$foursquare_id"} \
    								${disable_notification:+-F disable_notification="$disable_notification"} \
    								${reply_to_message_id:+-F reply_to_message_id="$reply_to_message_id"} \
    								${reply_markup:+-F reply_markup="$reply_markup"})
    
    	# Testa o retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	# Status
    	return $?
    }
    
    # Utilize essa função para enviar um contato + numero
    ShellBot.sendContact()
    {
    	# Variáveis locais
    	local chat_id phone_number first_name last_name disable_notification reply_to_message_id reply_markup jq_obj
    	
    	# Lê os parâmetros da função
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:p:f:l:n:r:k:' \
    						 --longoptions 'chat_id:,
    										phone_number:,
    										first_name:,
    										last_name:,
    										disable_notification:,
    										reply_to_message_id:,
    										reply_markup:' \
    						 -- "$@")
    
    
    	# Define os parâmetros posicionais
    	eval set -- "$param"
    
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			-p|--phone_number)
    				phone_number=$2
    				shift 2
    				;;
    			-f|--first_name)
    				first_name=$2
    				shift 2
    				;;
    			-l|--last_name)
    				last_name=$2
    				shift 2
    				;;
    			-n|--disable_notification)
    				# Tipo: boolean
    				CheckArgType bool "$1" "$2"
    				disable_notification=$2
    				shift 2
    				;;
    			-r|--reply_to_message_id)
    				# Tipo: inteiro
    				CheckArgType int "$1" "$2"
    				reply_to_message_id=$2
    				shift 2
    				;;
    			-k|--reply_markup)
    				reply_markup=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
					;;
    		esac
    	done
    	
    	# Parâmetros obrigatórios.	
    	[[ $chat_id ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $phone_number ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-p, --phone_number]"
    	[[ $first_name ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-f, --first_name]"
    	
    	# Chama o método
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-F chat_id="$chat_id"} \
    								${phone_number:+-F phone_number="$phone_number"} \
    								${first_name:+-F first_name="$first_name"} \
    								${last_name:+-F last_name="$last_name"} \
    								${disable_notification:+-F disable_notification="$disable_notification"} \
    								${reply_to_message_id:+-F reply_to_message_id="$reply_to_message_id"} \
    								${reply_markup:+-F reply_markup="$reply_markup"})
    
    	# Testa o retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	# Status
    	return $?
    }
    
    # Envia uma ação para bot.
    ShellBot.sendChatAction()
    {
    	# Variáveis locais
    	local chat_id action jq_obj
    	
    	# Lê os parâmetros da função
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:a:' \
    						 --longoptions 'chat_id:,
    										action:' \
    						 -- "$@")
    
    	# Define os parâmetros posicionais
    	eval set -- "$param"
    
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			-a|--action)
    				CheckArgType action "$1" "$2"
    				action=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
					;;
    		esac
    	done
    
    	# Parâmetros obrigatórios.		
    	[[ $chat_id ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $action ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-a, --action]"
    	
    	# Chama o método
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-d chat_id="$chat_id"} \
									${action:+-d action="$action"})
    	
    	# Testa o retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	# Status
    	return $?
    }
    
    # Utilize essa função para obter as fotos de um determinado usuário.
    ShellBot.getUserProfilePhotos()
    {
    	# Variáveis locais 
    	local user_id offset limit ind last index max item total jq_obj
    
    	# Lê os parâmetros da função
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'u:o:l:' \
    						 --longoptions 'user_id:,
    										offset:,
    										limit:' \
    						 -- "$@")
    
    	
    	# Define os parâmetros posicionais
    	eval set -- "$param"
    	
    	while :
    	do
    		case $1 in
    			-u|--user_id)
    				CheckArgType int "$1" "$2"
    				user_id=$2
    				shift 2
    				;;
    			-o|--offset)
    				CheckArgType int "$1" "$2"
    				offset=$2
    				shift 2
    				;;
    			-l|--limit)
    				CheckArgType int "$1" "$2"
    				limit=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	# Parâmetros obrigatórios.
    	[[ $user_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-u, --user_id]"
    	
    	# Chama o método
    	jq_obj=$(curl $_CURL_OPT_ GET $_API_TELEGRAM_/${FUNCNAME#*.} \
									${user_id:+-d user_id="$user_id"} \
									${offset:+-d offset="$offset"} \
									${limit:+-d limit="$limit"})
  
    	# Verifica se ocorreu erros durante a chamada do método	
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    	
    	# Status
    	return $?
    }
    
    # Função para listar informações do arquivo especificado.
    ShellBot.getFile()
    {
    	# Variáveis locais
    	local file_id jq_obj
    
    	# Lê os parâmetros da função
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'f:' \
    						 --longoptions 'file_id:' \
    						 -- "$@")
    
    	
    	# Define os parâmetros posicionais
    	eval set -- "$param"
    
    	while :
    	do
    		case $1 in
    			-f|--file_id)
    				file_id=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	# Parâmetros obrigatórios.
    	[[ $file_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-f, --file_id]"
    	
    	# Chama o método.
    	jq_obj=$(curl $_CURL_OPT_ GET $_API_TELEGRAM_/${FUNCNAME#*.} ${file_id:+-d file_id="$file_id"})
    
    	# Testa o retorno do método.
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	# Status
    	return $?
    }		
    
    # Essa função kicka o usuário do chat ou canal. (somente administradores)
    ShellBot.kickChatMember()
    {
    	# Variáveis locais
    	local chat_id user_id until_date jq_obj
    
    	# Lê os parâmetros da função
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:u:d:' \
    						 --longoptions 'chat_id:,
    										user_id:,
    										until_date:' \
    						 -- "$@")
    
    	# Define os parâmetros posicionais
    	eval set -- "$param"
    
    	# Trata os parâmetros
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			-u|--user_id)
    				CheckArgType int "$1" "$2"
    				user_id=$2
    				shift 2
    				;;
    			-d|--until_date)
    				CheckArgType int "$1" "$2"
    				until_date=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	# Parametros obrigatórios.
    	[[ $chat_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $user_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-u, --user_id]"
    	
    	# Chama o método
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-d chat_id="$chat_id"} \
    								${user_id:+-d user_id="$user_id"} \
    								${until_date:+-d until_date="$until_date"})
    
    	# Verifica se ocorreu erros durante a chamada do método	
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	# Status
    	return $?
    }
    
    # Utilize essa função para remove o bot do grupo ou canal.
    ShellBot.leaveChat()
    {
    	# Variáveis locais
    	local chat_id jq_obj
    
    	# Lê os parâmetros da função
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:' \
    						 --longoptions 'chat_id:' \
    						 -- "$@")
    
    	
    	# Define os parâmetros posicionais
    	eval set -- "$param"
    
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    
    	[[ $chat_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} ${chat_id:+-d chat_id="$chat_id"})
    
    	# Verifica se ocorreu erros durante a chamada do método	
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	return $?
    	
    }
    
    ShellBot.unbanChatMember()
    {
    	local chat_id user_id jq_obj
    
    	# Lê os parâmetros da função
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:u:' \
    						 --longoptions 'chat_id:,
    										user_id:' \
    						 -- "$@")
    
    	
    	# Define os parâmetros posicionais
    	eval set -- "$param"
    
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			-u|--user_id)
    				CheckArgType int "$1" "$2"
    				user_id=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	[[ $chat_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $user_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-u, --user_id]"
    	
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-d chat_id="$chat_id"} \
    								${user_id:+-d user_id="$user_id"})
    
    	# Verifica se ocorreu erros durante a chamada do método	
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	return $?
    }
    
    ShellBot.getChat()
    {
    	# Variáveis locais
    	local chat_id jq_obj
    
    	# Lê os parâmetros da função
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:' \
    						 --longoptions 'chat_id:' \
    						 -- "$@")
    
    	
    	# Define os parâmetros posicionais
    	eval set -- "$param"
    
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    
    	[[ $chat_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	
    	jq_obj=$(curl $_CURL_OPT_ GET $_API_TELEGRAM_/${FUNCNAME#*.} ${chat_id:+-d chat_id="$chat_id"})
    
    	# Verifica se ocorreu erros durante a chamada do método	
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    	
    	# Status
    	return $?
    }
    
    ShellBot.getChatAdministrators()
    {
    	local chat_id total key index jq_obj
    
    	# Lê os parâmetros da função
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:' \
    						 --longoptions 'chat_id:' \
    						 -- "$@")
    
    	
    	# Define os parâmetros posicionais
    	eval set -- "$param"
    
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    
    	[[ $chat_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	
    	jq_obj=$(curl $_CURL_OPT_ GET $_API_TELEGRAM_/${FUNCNAME#*.} ${chat_id:+-d chat_id="$chat_id"})
    
    	# Verifica se ocorreu erros durante a chamada do método	
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	# Status	
    	return $?
    }
    
    ShellBot.getChatMembersCount()
    {
    	local chat_id jq_obj
    
    	# Lê os parâmetros da função
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:' \
    						 --longoptions 'chat_id:' \
    						 -- "$@")
    
    	
    	# Define os parâmetros posicionais
    	eval set -- "$param"
    
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    
    	[[ $chat_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	
    	jq_obj=$(curl $_CURL_OPT_ GET $_API_TELEGRAM_/${FUNCNAME#*.} ${chat_id:+-d chat_id="$chat_id"})
    
    	# Verifica se ocorreu erros durante a chamada do método	
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	return $?
    }
    
    ShellBot.getChatMember()
    {
    	# Variáveis locais
    	local chat_id user_id jq_obj
    
    	# Lê os parâmetros da função
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:u:' \
    						 --longoptions 'chat_id:,
    						 				user_id:' \
    						 -- "$@")
    
    	
    	# Define os parâmetros posicionais
    	eval set -- "$param"
    
    	while :
    	do
    		case $1 in
    			-c|--chat_id)
    				chat_id=$2
    				shift 2
    				;;
    			-u|--user_id)
    				CheckArgType int "$1" "$2"
    				user_id=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
    				;;
    		esac
    	done
    	
    	[[ $chat_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $user_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-u, --user_id]"
    	
    	jq_obj=$(curl $_CURL_OPT_ GET $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-d chat_id="$chat_id"} \
    								${user_id:+-d user_id="$user_id"})
    
    	# Verifica se ocorreu erros durante a chamada do método	
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	return $?
    }
    
    ShellBot.editMessageText()
    {
    	local chat_id message_id inline_message_id text parse_mode disable_web_page_preview reply_markup jq_obj
    	
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:m:i:t:p:w:r:' \
    						 --longoptions 'chat_id:,
    										message_id:,
    										inline_message_id:,
    										text:,
    										parse_mode:,
    										disable_web_page_preview:,
    										reply_markup:' \
    						 -- "$@")
    	
    	eval set -- "$param"
    
    	while :
    	do
    			case $1 in
    				-c|--chat_id)
    					chat_id=$2
    					shift 2
    					;;
    				-m|--message_id)
    					CheckArgType int "$1" "$2"
    					message_id=$2
    					shift 2
    					;;
    				-i|--inline_message_id)
    					CheckArgType int "$1" "$2"
    					inline_message_id=$2
    					shift 2
    					;;
    				-t|--text)
						text=$(echo -e "$2")
    					shift 2
    					;;
    				-p|--parse_mode)
    					CheckArgType parsemode "$1" "$2"
    					parse_mode=$2
    					shift 2
    					;;
    				-w|--disable_web_page_preview)
    					CheckArgType bool "$1" "$2"
    					disable_web_page_preview=$2
    					shift 2
    					;;
    				-r|--reply_markup)
    					reply_markup=$2
    					shift 2
    					;;
    				--)
    					shift
    					break
						;;
    			esac
    	done
    	
    	[[ $text ]] 			|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-t, --text]"
		[[ $inline_message_id ]] && unset chat_id message_id || {
			[[ $chat_id ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
			[[ $message_id ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-m, --message_id]"
		}
    	
    
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-d chat_id="$chat_id"} \
    								${message_id:+-d message_id="$message_id"} \
    								${inline_message_id:+-d inline_message_id="$inline_message_id"} \
    								${text:+-d text="$text"} \
    								${parse_mode:+-d parse_mode="$parse_mode"} \
    								${disable_web_page_preview:+-d disable_web_page_preview="$disable_web_page_preview"} \
    								${reply_markup:+-d reply_markup="$reply_markup"})
    
    	# Verifica se ocorreu erros durante a chamada do método	
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    	
    	return $?
    	
    }
    
    ShellBot.editMessageCaption()
    {
    	local chat_id message_id inline_message_id caption reply_markup jq_obj
    	
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:m:i:t:r:' \
    						 --longoptions 'chat_id:,
    										message_id:,
    										inline_message_id:,
    										caption:,
    										reply_markup:' \
    						 -- "$@")
    	
    	eval set -- "$param"
    
    	while :
    	do
    			case $1 in
    				-c|--chat_id)
    					chat_id=$2
    					shift 2
    					;;
    				-m|--message_id)
    					CheckArgType int "$1" "$2"
    					message_id=$2
    					shift 2
    					;;
    				-i|--inline_message_id)
    					CheckArgType int "$1" "$2"
    					inline_message_id=$2
    					shift 2
    					;;
    				-t|--caption)
						caption=$(echo -e "$2")
    					shift 2
    					;;
    				-r|--reply_markup)
    					reply_markup=$2
    					shift 2
    					;;
    				--)
    					shift
    					break
						;;
    			esac
    	done
    				
    	[[ $chat_id ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $message_id ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-m, --message_id]"
    	
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-d chat_id="$chat_id"} \
    								${message_id:+-d message_id="$message_id"} \
    								${inline_message_id:+-d inline_message_id="$inline_message_id"} \
    								${caption:+-d caption="$caption"} \
    								${reply_markup:+-d reply_markup="$reply_markup"})
    
    	# Verifica se ocorreu erros durante a chamada do método	
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    	
    	return $?
    	
    }
    
    ShellBot.editMessageReplyMarkup()
    {
    	local chat_id message_id inline_message_id reply_markup jq_obj
    	
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:m:i:r:' \
    						 --longoptions 'chat_id:,
    										message_id:,
    										inline_message_id:,
    										reply_markup:' \
    						 -- "$@")
    	
    	eval set -- "$param"
    
    	while :
    	do
    			case $1 in
    				-c|--chat_id)
    					chat_id=$2
    					shift 2
    					;;
    				-m|--message_id)
    					CheckArgType int "$1" "$2"
    					message_id=$2
    					shift 2
    					;;
    				-i|--inline_message_id)
    					CheckArgType int "$1" "$2"
    					inline_message_id=$2
    					shift 2
    					;;
    				-r|--reply_markup)
    					reply_markup=$2
    					shift 2
    					;;
    				--)
    					shift
    					break
						;;
    			esac
    	done
		
		[[ $inline_message_id ]] && unset chat_id message_id || {
			[[ $chat_id ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
			[[ $message_id ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-m, --message_id]"
		}
    
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-d chat_id="$chat_id"} \
    								${message_id:+-d message_id="$message_id"} \
     								${inline_message_id:+-d inline_message_id="$inline_message_id"} \
    								${reply_markup:+-d reply_markup="$reply_markup"})
    
    	# Verifica se ocorreu erros durante a chamada do método	
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    	
    	return $?
    	
    }
    
    ShellBot.deleteMessage()
    {
    	local chat_id message_id jq_obj
    	
    	local param=$(getopt --name "$FUNCNAME" \
							 --options 'c:m:' \
    						 --longoptions 'chat_id:,
    										message_id:' \
    						 -- "$@")
    	
    	eval set -- "$param"
    
    	while :
    	do
    			case $1 in
    				-c|--chat_id)
    					chat_id=$2
    					shift 2
    					;;
    				-m|--message_id)
    					CheckArgType int "$1" "$2"
    					message_id=$2
    					shift 2
    					;;
    				--)
    					shift
    					break
						;;
    			esac
    	done
    	
    	[[ $chat_id ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
    	[[ $message_id ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-m, --message_id]"
    
    	jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-d chat_id="$chat_id"} \
    								${message_id:+-d message_id="$message_id"})
    
    	# Verifica se ocorreu erros durante a chamada do método	
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    	
    	return $?
    
    }
   
	ShellBot.downloadFile() {
	
		local file_path dir
		local uri="https://api.telegram.org/file/bot$_TOKEN_"

		local param=$(getopt --name "$FUNCNAME" \
								--options 'f:d:' \
								--longoptions 'file_path:,
												dir:' \
								-- "$@")
		
		eval set -- "$param"

		while :
		do
			case $1 in
				-f|--file_path)
					file_path=$2
					shift 2
					;;
				-d|--dir)
					[[ -d $2 ]] && {
						[[ -w $2 ]] || MessageError API "$_ERR_DIR_WRITE_DENIED_" "$1" "$2"
					} || MessageError API "$_ERR_DIR_NOT_FOUND_" "$1" "$2"
					dir=${2%/}
					shift 2
					;;
				--)
					shift
					break
					;;
			esac
		done

		[[ $file_path ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-f, --file_path]"
		[[ $dir ]] 			|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-d, --dir]"

		dir=$(mktemp -u --tmpdir="$dir" "file$(date +%d%m%Y%H%M%S)-XXXXX${ext:+.$ext}")
		wget "$uri/$file_path" -O "$dir" &>/dev/null || MessageError API "$_ERR_FILE_DOWNLOAD_" "$file_path"
				
		return $?
	}

	ShellBot.editMessageLiveLocation()
	{
		local chat_id message_id inline_message_id
		local latitude longitude reply_markup jq_obj
		
		local param=$(getopt --name "$FUNCNAME" \
								--options 'c:m:i:l:g:r:' \
								--longoptions 'chat_id:,
												message_id:,
												inline_message_id:,
												latitude:,
												longitude:,
												reply_markup:' \
								-- "$@")
		
		eval set -- "$param"

		while :
		do
			case $1 in
				-c|--chat_id)
					chat_id=$2
					shift 2
					;;
				-m|--message_id)
    				CheckArgType int "$1" "$2"
					message_id=$2
					shift 2
					;;
    			-i|--inline_message_id)
					CheckArgType int "$1" "$2"
					inline_message_id=$2
					shift 2
					;;
    			-l|--latitude)
    				# Tipo: float
    				CheckArgType float "$1" "$2"
    				latitude=$2
    				shift 2
    				;;
    			-g|--longitude)
    				# Tipo: float
    				CheckArgType float "$1" "$2"
    				longitude=$2
    				shift 2
    				;;
    			-r|--reply_markup)
    				reply_markup=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
					;;
			esac
		done
	
		[[ $inline_message_id ]] && unset chat_id message_id || {
			[[ $chat_id ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
			[[ $message_id ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-m, --message_id]"
		}
    	
		jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-d chat_id="$chat_id"} \
									${message_id:+-d message_id="$message_id"} \
									${inline_message_id:+-d inline_message_id="$inline_message_id"} \
    								${latitude:+-d latitude="$latitude"} \
    								${longitude:+-d longitude="$longitude"} \
    								${reply_markup:+-d reply_markup="$reply_markup"})
    
    	# Testa o retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	return $?
	}	

	ShellBot.stopMessageLiveLocation()
	{
		local chat_id message_id inline_message_id reply_markup jq_obj
		
		local param=$(getopt --name "$FUNCNAME" \
								--options 'c:m:i:r:' \
								--longoptions 'chat_id:,
												message_id:,
												inline_message_id:,
												reply_markup:' \
								-- "$@")
		
		eval set -- "$param"

		while :
		do
			case $1 in
				-c|--chat_id)
					chat_id=$2
					shift 2
					;;
				-m|--message_id)
    				CheckArgType int "$1" "$2"
					message_id=$2
					shift 2
					;;
    			-i|--inline_message_id)
					CheckArgType int "$1" "$2"
					inline_message_id=$2
					shift 2
					;;
    			-r|--reply_markup)
    				reply_markup=$2
    				shift 2
    				;;
    			--)
    				shift
    				break
					;;
			esac
		done
	
		[[ $inline_message_id ]] && unset chat_id message_id || {
			[[ $chat_id ]] 		|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
			[[ $message_id ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-m, --message_id]"
		}
    	
		jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-d chat_id="$chat_id"} \
									${message_id:+-d message_id="$message_id"} \
									${inline_message_id:+-d inline_message_id="$inline_message_id"} \
    								${reply_markup:+-d reply_markup="$reply_markup"})
    
    	# Testa o retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	return $?
	}

	ShellBot.setChatStickerSet()
	{
		local chat_id sticker_set_name jq_obj

		local param=$(getopt --name "$FUNCNAME" \
								--options 'c:s:' \
								--longoptions 'chat_id:,
												sticker_set_name:' \
								-- "$@")
		
		eval set -- "$param"
		
		while :
		do
			case $1 in
				-c|--chat_id)
					chat_id=$2
					shift 2
					;;
				-s|--sticker_set_name)
					sticker_set_name=$2
					shift 2
					;;
				--)
					shift
					break
					;;
			esac
		done

		[[ $chat_id ]] 			|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
		[[ $sticker_set_name ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-s, --sticker_set_name]"
		
		jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-d chat_id="$chat_id"} \
									${sticker_set_name:+-d sticker_set_name="$sticker_set_name"})
		
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    	
		return $?
	}

	ShellBot.deleteChatStickerSet()
	{
		local chat_id jq_obj

		local param=$(getopt --name "$FUNCNAME" \
								--options 'c:' \
								--longoptions 'chat_id:' \
								-- "$@")
		
		eval set -- "$param"
		
		while :
		do
			case $1 in
				-c|--chat_id)
					chat_id=$2
					shift 2
					;;
				--)
					shift
					break
					;;
			esac
		done

		[[ $chat_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
		
		jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} ${chat_id:+-d chat_id="$chat_id"})
		
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    	
    	return $?
	}
	
	ShellBot.inputMedia()
	{
		local __type __input __media __caption __parse_mode __thumb __width 
		local __height __duration __supports_streaming __performer __title

		local __param=$(getopt --name "$FUNCNAME" \
								--options 't:i:m:c:p:b:w:h:d:s:f:e:' \
								--longoptions 'type:,
												input:,
												media:,
												caption:,
												parse_mode:,
												thumb:,
												witdh:,
												height:,
												duration:,
												supports_streaming:,
												performer:,
												title:' \
								-- "$@")
	
	
		eval set -- "$__param"
		
		while :
		do
			case $1 in
				-t|--type)
					CheckArgType mediatype "$1" "$2"
					__type=$2
					shift 2
					;;
				-i|--input)
					CheckArgType var "$1" "$2"
					__input=$2
					shift 2
					;;
				-m|--media)
					CheckArgType file "$1" "$2"
					__media=$2
					shift 2
					;;
				-c|--caption)
					__caption=$(echo -e "$2")
					shift 2
					;;
				-p|--parse_mode)
					CheckArgType parsemode "$1" "$2"
					__parse_mode=$2
					shift 2
					;;
				-b|--thumb)
					CheckArgType file "$1" "$2"
					__thumb=$2
					shift 2
					;;
				-w|--width)
					CheckArgType int "$1" "$2"
					__width=$2
					shift 2
					;;
				-h|--height)
					CheckArgType int "$1" "$2"
					__height=$2
					shift 2
					;;
				-d|--duration)
					CheckArgType int "$1" "$2"
					__duration=$2
					shift 2
					;;
				-s|--supports_streaming)
					CheckArgType bool "$1" "$2"
					__supports_streaming=$2
					shift 2
					;;
				-f|--performer)
					__performer=$2
					shift 2
					;;
				-e|--title)
					__title=$2
					shift 2
					;;
				--)
					shift
					break
					;;
			esac
		done

		[[ $__type ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-t, --type]"
		[[ $__input ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-i, --input]"
		[[ $__media ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-m, --media]"

		local -n __input
		
    	__input="${__input:+$__input,}{\"type\":\"$__type\","
		__input+="\"media\":\"$__media\""
		__input+="${__caption:+,\"caption\":\"$__caption\"}"
		__input+="${__parse_mode:+,\"parse_mode\":\"$__parse_mode\"}"
		__input+="${__thumb:+,\"thumb\":\"$__thumb\"}"
		__input+="${__width:+,\"width\":\"$__width\"}"
		__input+="${__height:+,\"height\":\"$__height\"}"
		__input+="${__duration:+,\"duration\":\"$__duration\"}"
		__input+="${__supports_streaming:+,\"supports_streaming\":$__supports_streaming}"
		__input+="${__performer:+,\"performer\":\"$__performer\"}"
		__input+="${__title:+,\"title\":\"$__title\"}}"

		return $?
	}

	ShellBot.sendMediaGroup()
	{
		local chat_id media disable_notification reply_to_message_id jq_obj
		
		local param=$(getopt 	--name "$FUNCNAME" \
								--options 'c:m:n:r:' \
								--longoptions 'chat_id:,
												media:,
												disable_notification:,
												reply_to_message_id:' \
								-- "$@")
	
		eval set -- "$param"
		
		while :
		do
			case $1 in
				-c|--chat_id)
					chat_id=$2
					shift 2
					;;
				-m|--media)
					media=[$2]
					shift 2
					;;
				-n|--disable_notification)
    				CheckArgType bool "$1" "$2"
					disable_notification=$2
					shift 2
					;;
				-r|--reply_to_message_id)
    				CheckArgType int "$1" "$2"
    				reply_to_message_id=$2
    				shift 2
					;;
				--)
					shift
					break
					;;
			esac
		done

		[[ $chat_id ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
		[[ $media ]] 	|| MessageError API "$_ERR_PARAM_REQUIRED_" "[-m, --media]"
		
		jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-F chat_id="$chat_id"} \
    								${media:+-F media="$media"} \
    								${disable_notification:+-F disable_notification="$disable_notification"} \
    								${reply_to_message_id:+-F reply_to_message_id="$reply_to_message_id"})
    
		# Retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	# Status
    	return $?
	}

	ShellBot.editMessageMedia()
	{
		local chat_id message_id inline_message_id media reply_markup jq_obj

		local param=$(getopt	--name "$FUNCNAME" \
								--options 'c:i:n:m:k:' \
								--longoptions	'chat_id:,
												message_id:,
												inline_message_id:,
												media:,
												reply_markup:'	\
								-- "$@")

		eval set -- "$param"
		
		while :
		do
			case $1 in
				-c|--chat_id)
					chat_id=$2
					shift 2
					;;
				-i|--message_id)
					CheckArgType int "$1" "$2"
					message_id=$2
					shift 2
					;;
				-n|--inline_message_id)
					CheckArgType int "$1" "$2"
					inline_message_id=$2
					shift 2
					;;
				-m|--media)
					media=$2
					shift 2
					;;
				-k|--reply_markup)
					reply_markup=$2
					shift 2
					;;
				--)
					shift
					break
					;;
			esac
		done

		[[ $inline_message_id ]] || {
			[[ $chat_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
			[[ $message_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-i, --message_id]"
		}
		
		[[ $media ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-m, --media]"
		
		jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-F chat_id="$chat_id"} \
									${message_id:+-F message_id="$message_id"} \
									${inline_message_id:+-F inline_message_id="$inline_message_id"} \
    								${media:+-F media="$media"} \
    								${reply_markup:+-F reply_markup="$reply_markup"})   
		 
		# Retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	# Status
    	return $?
	}

	ShellBot.sendAnimation()
	{
		local chat_id animation duration width height 
		local thumb caption parse_mode disable_notification 
		local reply_to_message_id reply_markup jq_obj
		
		local param=$(getopt	--name "$FUNCNAME" \
								--options 'c:a:d:w:h:b:o:p:n:r:k:' \
								--longoptions 'chat_id:,
												animation:,
												duration:,
												width:,
												height:,
												thumb:,
												caption:,
												parse_mode:,
												disable_notification:,
												reply_to_message_id:,
												reply_markup:' \
								-- "$@")
		
		eval set -- "$param"
		
		while :
		do
			case $1 in
				-c|--chat_id)
					chat_id=$2
					shift 2
					;;
				-a|--animation)
					CheckArgType file "$1" "$2"
					animation=$2
					shift 2
					;;
				-d|--duration)
					CheckArgType int "$1" "$2"
					duartion=$2
					shift 2
					;;
				-w|--width)
					CheckArgType int "$1" "$2"
					width=$2
					shift 2
					;;
				-h|--height)
					CheckArgType int "$1" "$2"
					height=$2
					shift 2
					;;
				-b|--thumb)
					CheckArgType file "$1" "$2"
					thumb=$2
					shift 2
					;;
				-o|--caption)
					caption=$(echo -e "$2")
					shift 2
					;;
				-p|--parse_mode)
					CheckArgType parsemode "$1" "$2"
					parse_mode=$2
					shift 2
					;;
				-n|--disable_notification)
					CheckArgType bool "$1" "$2"
					disable_notification=$2
					shift 2
					;;
				-r|--reply_to_message_id)
					CheckArgType int "$1" "$2"
					reply_to_message_id=$2
					shift 2
					;;
				-k|--reply_markup)
					reply_markup=$2
					shift 2
					;;
				--)
					shift
					break
					;;
			esac
		done

		[[ $chat_id ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-c, --chat_id]"
		[[ $animation ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-a, --animation]"
		
		jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
									${chat_id:+-F chat_id="$chat_id"} \
									${animation:+-F animation="$animation"} \
									${duration:+-F duration="$duration"} \
									${width:+-F width="$width"} \
									${height:+-F height="$height"} \
									${thumb:+-F thumb="$thumb"} \
									${caption:+-F caption="$caption"} \
									${parse_mode:+-F parse_mode="$parse_mode"} \
									${disable_notification:+-F disable_notification="$disable_notification"} \
									${reply_to_message_id:+-F reply_to_message_id="$reply_to_message_id"} \
    								${reply_markup:+-F reply_markup="$reply_markup"})   
		 
		# Retorno do método
    	MethodReturn $jq_obj || MessageError TG $jq_obj
    
    	# Status
    	return $?
	}

	ShellBot.setMessageRules()
	{
		local action command user_id username chat_id 
		local chat_type time date language message_id 
		local is_bot text entities_type file_type
		local query_data query_id query_text send_message
		local chat_member mime_type num_args exec rule
		local action_args weekday user_status chat_name 
		local message_status reply_message rule_name parse_mode
		local forward_message reply_markup continue

		local param=$(getopt	--name "$FUNCNAME" \
								--options 's:a:z:c:i:u:h:v:y:l:m:b:t:n:f:p:q:r:g:o:e:d:w:j:x:' \
								--longoptions	'name:,
												action:,
												action_args:,
												command:,
												user_id:,
												username:,
												chat_id:,
												chat_name:,
												chat_type:,
												language_code:,
												message_id:,
												is_bot:,
												text:,
												entitie_type:,
												file_type:,
												mime_type:,
												query_data:,
												query_id:,
												chat_member:,
												num_args:,
												time:,
												date:,
												weekday:,
												user_status:,
												message_status:,
												exec:,
												bot_reply_message:,
												bot_send_message:,
												bot_forward_message:,
												bot_reply_markup:,
												bot_parse_mode:,
												continue' \
								-- "$@")
		
		eval set -- "$param"
	
		while :
		do
			case $1 in
				-s|--name)
					CheckArgType flag "$1" "$2"
					rule_name=$2
					shift 2
					;;
				-a|--action)
					CheckArgType func "$1" "$2"
					action=$2
					shift 2
					;;
				-z|--action_args)
					action_args=${2//\\/\\\\}
					action_args=${action_args//|/\\|}
					shift 2
					;;
				-c|--command)
					CheckArgType cmd "$1" "$2"
					command=${command:+$command,}${2}
					shift 2
					;;
				-i|--user_id)
					user_id=${user_id:+$user_id,}${2//|/\\|}
					shift 2
					;;
				-u|--username)
					username=${username:+$username,}${2//|/\\|}
					shift 2
					;;
				-h|--chat_id)
					chat_id=${chat_id:+$chat_id,}${2//|/\\|}
					shift 2
					;;
				-v|--chat_name)
					chat_name=${chat_name:+$chat_name,}${2//|/\\|}
					shift 2
					;;
				-y|--chat_type)
					chat_type=${chat_type:+$chat_type,}${2//|/\\|}
					shift 2
					;;
				-e|--time)
					CheckArgType itime "$1" "$2"
					time=${time:+$time,}${2}
					shift 2
					;;
				-d|--date)
					CheckArgType idate "$1" "$2"
					date=${date:+$date,}${2}
					shift 2
					;;
				-l|--laguage_code)
					language=${language:+$language,}${2//|/\\|}
					shift 2
					;;
				-m|--message_id)
					message_id=${message_id:+$message_id,}${2//|/\\|}
					shift 2
					;;
				-b|--is_bot)
					is_bot=${is_bot:+$is_bot,}${2//|/\\|}
					shift 2
					;;
				-t|--text)
					text=${2//|/\\|}
					shift 2
					;;
				-n|--entitie_type)
					entities_type=${entities_type:+$entities_type,}${2//|/\\|}
					shift 2
					;;
				-f|--file_type)
					file_type=${file_type:+$file_type,}${2//|/\\|}
					shift 2
					;;
				-p|--mime_type)
					mime_type=${mime_type:+$mime_type,}${2//|/\\|}
					shift 2
					;;
				-q|--query_data)
					query_data=${query_data:+$query_data,}${2//|/\\|}
					shift 2
					;;
				-r|--query_id)
					query_id=${query_id:+$query_id,}${2//|/\\|}
					shift 2
					;;
				-g|--chat_member)
					chat_member=${chat_member:+$chat_member,}${2//|/\\|}
					shift 2
					;;
				-o|--num_args)
					num_args=${num_args:+$num_args,}${2//|/\\|}
					shift 2
					;;
				-w|--weekday)
					weekday=${weekday:+$weekday,}${2//|/\\|}
					shift 2
					;;
				-j|--user_status)
					user_status=${user_status:+$user_status,}${2//|/\\|}
					shift 2
					;;
				-x|--message_status)
					message_status=${message_status:+$message_status,}${2//|/\\|}
					shift 2
					;;
				--bot_reply_message)
					reply_message=${2//\\/\\\\}
					reply_message=${reply_message//|/\\|}
					shift 2
					;;
				--bot_send_message)
					send_message=${2//\\/\\\\}
					send_message=${send_message//|/\\|}
					shift 2
					;;
				--bot_forward_message)
					forward_message=${forward_message:+$forward_message,}${2//|/\\|}
					shift 2
					;;
				--bot_reply_markup)
					reply_markup=${2//\\/\\\\}
					reply_markup=${reply_markup//|/\\|}
					shift 2
					;;
				--bot_parse_mode)
					parse_mode=${2//|/\\|}
					shift 2
					;;
				--exec)
					exec=${2//\\/\\\\}
					exec=${exec//|/\\|}
					shift 2
					;;
				--continue)
					continue=true
					shift
					;;
				--)
					shift
					break
					;;
			esac
		done
		
		[[ $rule_name ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-s, --name]"

		for rule in "${_BOT_RULES_LIST_[@]}"; do
			IFS='|' read _ _ rule _ <<< $rule
			[[ $rule == $rule_name ]] && MessageError API "$_ERR_RULE_ALREADY_EXISTS_" "[-s, --name]" "$rule_name"
		done

		_BOT_RULES_LIST_+=("${BASH_SOURCE[1]##*/}|${BASH_LINENO}|${rule_name}|${action}|${action_args}|${exec}|${message_id:-+any}|${is_bot:-+any}|${command:-+any}|${user_id:-+any}|${username:-+any}|${chat_id:-+any}|${chat_name:-+any}|${chat_type:-+any}|${language:-+any}|${text}|${entities_type:-+any}|${file_type:-+any}|${mime_type:-+any}|${query_id:-+any}|${query_data:-+any}|${chat_member:-+any}|${num_args:-+any}|${time:-+any}|${date:-+any}|${weekday:-+any}|${user_status:-+any}|${message_status:-+any}|${reply_message}|${send_message}|${forward_message}|${reply_markup}|${parse_mode}|${continue}")
	
		return $?
	}

	ShellBot.manageRules()
	{
		local __uid __rule __action __command __user_id __username
		local __message_id __is_bot __text __entities_type __file_type
		local __chat_id __chat_type __language __time __date __botcmd 
		local __err __tm __stime __etime __ctime __mime_type __weekday
		local __dt __sdate __edate __cdate __query_data __query_id
		local __chat_member __mem __ent __type __num_args __args
		local __action_args __user_status __status __out __reply_message
		local __rule_name __rule_line __rule_source __chat_name __fwid
		local __reply_markup __send_message __forward_message __parse_mode
		local __stdout __buffer __exec __continue

		local __u_message_text __u_message_id __u_message_from_is_bot 
		local __u_message_from_id __u_message_from_username __msgstatus __argpos
		local __u_message_from_language_code __u_message_chat_id __message_status
		local __u_message_chat_type __u_message_date __u_message_entities_type
		local __u_message_mime_type

		local 	__param=$(getopt	--name "$FUNCNAME" \
									--options 'u:' \
									--longoptions 'update_id:' \
									-- "$@")

				
		eval set -- "$__param"
		
		while :
		do
			case $1 in
				-u|--update_id)
					CheckArgType int "$1" "$2"
					__uid=$2
					shift 2
					;;
				--)
					shift
					break
					;;
			esac			
		done
		
		[[ $__uid ]] || MessageError API "$_ERR_PARAM_REQUIRED_" "[-u, --update_id]"

		# Define a lista de regras (somente-leitura)
		readonly _BOT_RULES_LIST_

		# Regras
		for __rule in "${_BOT_RULES_LIST_[@]}"; do

			IFS='|' read	__rule_source		\
							__rule_line			\
							__rule_name			\
							__action 			\
							__action_args 		\
							__exec				\
							__message_id 		\
							__is_bot 			\
							__command 			\
							__user_id 			\
							__username 			\
							__chat_id 			\
							__chat_name			\
							__chat_type 		\
							__language 			\
							__text 				\
							__entities_type 	\
							__file_type 		\
							__mime_type 		\
							__query_id 			\
							__query_data 		\
							__chat_member 		\
							__num_args 			\
							__time 				\
							__date 				\
							__weekday			\
							__user_status		\
							__message_status	\
							__reply_message		\
							__send_message		\
							__forward_message	\
							__reply_markup		\
							__parse_mode		\
							__continue			<<< $__rule
		
				__u_message_text=${message_text[$__uid]:-${edited_message_text[$__uid]:-${callback_query_message_text[$__uid]}}}
				__u_message_id=${message_message_id[$__uid]:-${edited_message_message_id[$__uid]:-${callback_query_message_message_id[$__uid]}}}
				__u_message_from_is_bot=${message_from_is_bot[$__uid]:-${edited_message_from_is_bot[$__uid]:-${callback_query_from_is_bot[$__uid]}}}
				__u_message_from_id=${message_from_id[$__uid]:-${edited_message_from_id[$__uid]:-${callback_query_from_id[$__uid]}}}
				__u_message_from_username=${message_from_username[$__uid]:-${edited_message_from_username[$__uid]:-${callback_query_from_username[$__uid]}}}
				__u_message_from_language_code=${message_from_language_code[$__uid]:-${edited_message_from_language_code[$__uid]:-${callback_query_from_language_code[$__uid]}}}
				__u_message_chat_id=${message_chat_id[$__uid]:-${edited_message_chat_id[$__uid]:-${callback_query_message_chat_id[$__uid]}}}
				__u_message_chat_username=${message_chat_username[$__uid]:-${edited_message_chat_username[$__uid]:-${callback_query_message_chat_username[$__uid]}}}
				__u_message_chat_type=${message_chat_type[$__uid]:-${edited_message_chat_type[$__uid]:-${callback_query_message_chat_type[$__uid]}}}
				__u_message_date=${message_date[$__uid]:-${edited_message_edit_date[$__uid]:-${callback_query_message_date[$__uid]}}}
				__u_message_entities_type=${message_entities_type[$__uid]:-${edited_message_entities_type[$__uid]:-${callback_query_message_entities_type[$__uid]}}}
				__u_message_mime_type=${message_document_mime_type[$__uid]:-${message_video_mime_type[$__uid]:-${message_audio_mime_type[$__uid]:-${message_voice_mime_type[$__uid]}}}}
	
				IFS=' ' read -ra __args <<< $__u_message_text
			
				[[ $__num_args			== +any ||	${#__args[@]}							== @(${__num_args//,/|})					]]	&&
				[[ $__command			== +any	||	${__u_message_text%% *}					== @(${__command//,/|})?(@${_BOT_INFO_[3]}) ]]	&&
				[[ $__message_id 		== +any	||	$__u_message_id 						== @(${__message_id//,/|})					]] 	&&
				[[ $__is_bot 			== +any ||	$__u_message_from_is_bot				== @(${__is_bot//,/|})						]]	&&
				[[ $__user_id			== +any ||	$__u_message_from_id					== @(${__user_id//,/|})						]]	&&
				[[ $__username			== +any ||	$__u_message_from_username				== @(${__username//,/|}) 					]]	&&
				[[ $__language			== +any	||	$__u_message_from_language_code			== @(${__language//,/|}) 					]]	&&
				[[ $__chat_id			== +any	||	$__u_message_chat_id					== @(${__chat_id//,/|})						]] 	&&
				[[ $__chat_name			== +any	||	$__u_message_chat_username				== @(${__chat_name//,/|})					]] 	&&
				[[ $__chat_type			== +any	||	$__u_message_chat_type					== @(${__chat_type//,/|})					]]	&&
				[[ ! $__text					||	$__u_message_text						=~ $__text									]]	&&
				[[ $__mime_type			== +any	||	$__u_message_mime_type					== @(${__mime_type//,/|})					]]	&&
				[[ $__query_id			== +any	||	${callback_query_id[$__uid]}			== @(${__query_id//,/|})					]]	&&
				[[ $__query_data		== +any	||	${callback_query_data[$__uid]}			== @(${__query_data//,/|})					]]	&&
				[[ $__weekday			== +any	|| 	$(printf '%(%u)T' $__u_message_date) 	== @(${__weekday//,/|})						]]	|| continue
			
				for __msgstatus in ${__message_status//,/ }; do
					[[ $__msgstatus == +any 															]]	||
					[[ $__msgstatus == pinned		&& ${message_pinned_message_message_id[$__uid]} 	]] 	||
					[[ $__msgstatus == edited 		&& ${edited_message_message_id[$__uid]}				]] 	||
					[[ $__msgstatus == forwarded	&& ${message_forward_from_id[$__uid]}				]]	||
					[[ $__msgstatus == reply		&& ${message_reply_to_message_message_id[$__uid]}	]] 	||
					[[ $__msgstatus == callback		&& ${callback_query_message_message_id[$__uid]}		]]	&& break
				done
				
				(($?)) && continue

				for __ent in ${__entities_type//,/ }; do
					[[ $__ent == +any 												]]	||
					[[ $__ent == @(${__u_message_entities_type//$_BOT_DELM_/|}) 	]] 	&& break
				done

				(($?)) && continue
	
				for __mem in ${__chat_member//,/ }; do
					[[ $__mem == +any												]] ||
					[[ $__mem == new 	&& ${message_new_chat_member_id[$__uid]} 	]] ||
					[[ $__mem == left 	&& ${message_left_chat_member_id[$__uid]} 	]] && break
				done
			
				(($?)) && continue

				for __type in ${__file_type//,/ }; do
					[[ $__type == +any 																								]] 	||
					[[ $__type == document 	&& ${message_document_file_id[$__uid]}	&& 	! ${message_document_thumb_file_id[$__uid]}	]] 	||
					[[ $__type == gif 		&& ${message_document_file_id[$__uid]}  &&	${message_document_thumb_file_id[$__uid]}	]] 	||
					[[ $__type == photo		&& ${message_photo_file_id[$__uid]} 													]] 	||
					[[ $__type == sticker 	&& ${message_sticker_file_id[$__uid]} 													]]	||
					[[ $__type == video		&& ${message_video_file_id[$__uid]} 													]]	||
					[[ $__type == audio		&& ${message_audio_file_id[$__uid]} 													]]	||
					[[ $__type == voice		&& ${message_voice_file_id[$__uid]} 													]]	||
					[[ $__type == contact	&& ${message_contact_user_id[$__uid]} 													]]	||
					[[ $__type == location	&& ${message_location_latitude[$__uid]}													]]	&& break
				done
					
				(($?)) && continue

				for __tm in ${__time//,/ }; do
					IFS='-' read __stime __etime <<< $__tm
					printf -v __ctime '%(%H:%M)T' $__u_message_date

					[[ $__time	== +any 				]]				||
					[[ $__ctime == @($__stime|$__etime) ]] 				||
					[[ $__ctime > $__stime && $__ctime < $__etime ]]	&& break
				done
					
				(($?)) && continue
	
				for __dt in ${__date//,/ }; do

					IFS='-' read __sdate __edate <<< $__dt
					IFS='/' read -a __sdate <<< $__sdate
					IFS='/' read -a __edate <<< $__edate
					
					__sdate=${__sdate[2]}/${__sdate[1]}/${__sdate[0]}
					__edate=${__edate[2]}/${__edate[1]}/${__edate[0]}

					printf -v __cdate '%(%Y/%m/%d)T' $__u_message_date
					
					[[ $__date	== +any 							]] 	||
					[[ $__cdate == @($__sdate|$__edate) 			]] 	||
					[[ $__cdate > $__sdate && $__cdate < $__edate 	]]	&& break
				done

				(($?)) && continue
	
				if [[ $__user_status != +any ]]; then
					case $_BOT_TYPE_RETURN_ in
						value)
							__out=$(ShellBot.getChatMember 	--chat_id $__u_message_chat_id \
															--user_id $__u_message_from_id 2>/dev/null)
							
							IFS=$_BOT_DELM_ read -a __out <<< $__out
							[[ ${__out[2]} == true ]]
							__status=${__out[$(($? ? 6 : 5))]}
							;;
						json)
							__out=$(ShellBot.getChatMember 	--chat_id $__u_message_chat_id \
															--user_id $__u_message_from_id 2>/dev/null)
							
							__status=$(Json '.result.status' $__out)
							;;
						map)	
							ShellBot.getChatMember 	--chat_id $__u_message_chat_id \
													--user_id $__u_message_from_id &>/dev/null

							__status=${return[status]}
							;;
					esac
					[[ $__status == @(${__user_status//,/|}) ]]	|| continue
				fi
				
				# Monitor
				[[ $_BOT_MONITOR_ ]]	&& 	printf '[%s]: %s: %s: %s: %s: %s: %s: %s: %s: %s: %s\n'		\
											"${FUNCNAME}"												\
											"$((__uid+1))"												\
											"$(printf '%(%d/%m/%Y %H:%M:%S)T' ${__u_message_date})"		\
											"${__u_message_chat_type}"									\
											"${__u_message_chat_username:--}"							\
											"${__u_message_from_username:--}"							\
											"${__rule_source}"											\
											"${__rule_line}"											\
											"${__rule_name}" 											\
											"${__action:--}"											\
											"${__exec:--}"
			
				# Log	
				[[ $_BOT_LOG_FILE_ ]] 	&&	printf '%s: %s: %s: %s: %s: %s: %s\n'						\
										 	"$(printf '%(%d/%m/%Y %H:%M:%S)T')"							\
									 	 	"${FUNCNAME}"												\
										 	"${__rule_source}"											\
										 	"${__rule_line}"											\
										 	"${__rule_name}"											\
											"${__action:--}"											\
											"${__exec:--}"												>> "$_BOT_LOG_FILE_"

				[[ $__reply_message ]] && ShellBot.sendMessage	--chat_id $__u_message_chat_id							\
																--reply_to_message_id $__u_message_id 					\
																--text "$(FlagConv $__uid "$__reply_message")"			\
																${__reply_markup:+--reply_markup "$__reply_markup"}		\
																${__parse_mode:+--parse_mode $__parse_mode}				&>/dev/null
				
				[[ $__send_message ]] && ShellBot.sendMessage	--chat_id $__u_message_chat_id							\
																--text "$(FlagConv $__uid "$__send_message")" 			\
																${__reply_markup:+--reply_markup "$__reply_markup"}		\
																${__parse_mode:+--parse_mode $__parse_mode}				&>/dev/null
				
				for __fwid in ${__forward_message//,/ }; do
					ShellBot.forwardMessage		--chat_id $__fwid					\
												--from_chat_id $__u_message_chat_id \
												--message_id $__u_message_id		&>/dev/null
				done

				# Chama a função passando os argumentos posicionais. (se existir)
				${__action:+$__action ${__action_args:-${__args[*]}}}
		
				# Executa a linha de comando e salva o retorno.
				__stdout=${__exec:+$(set -- ${__args[*]}; eval $(FlagConv $__uid "$__exec") 2>&1)}

				while [[ $__stdout ]]; do
					# Salva em buffer os primeiros 4096 caracteres.
					read -rN 4096 __buffer <<< $__stdout
					
					# Envia o buffer.
					ShellBot.sendMessage	--chat_id $__u_message_chat_id 			\
											--reply_to_message_id $__u_message_id	\
											--text "$__buffer"						&>/dev/null

					# Descarta os caracteres lidos.
					__stdout=${__stdout:4096}
				done 

				${__continue:-return 0}
		done

		return 1
	}

    ShellBot.getUpdates()
    {
    	local total_keys offset limit timeout allowed_updates jq_obj
		local vet val var obj oldv bar

		# Define os parâmetros da função
		local param=$(getopt 	--name "$FUNCNAME" \
								--options 'o:l:t:a:' \
								--longoptions 'offset:,
												limit:,
												timeout:,
												allowed_updates:' \
								-- "$@")
    
		eval set -- "$param"

    	while :
    	do
    		case $1 in
    			-o|--offset)
    				CheckArgType int "$1" "$2"
    				offset=$2
    				shift 2
    				;;
    			-l|--limit)
    				CheckArgType int "$1" "$2"
    				limit=$2
    				shift 2
    				;;
    			-t|--timeout)
    				CheckArgType int "$1" "$2"
    				timeout=$2
    				shift 2
    				;;
    			-a|--allowed_updates)
    				allowed_updates=$2
    				shift 2
    				;;
    			--)
    				# Se não houver mais parâmetros
    				shift 
    				break
    				;;
    		esac
    	done
    	
		# Seta os parâmetros
		jq_obj=$(curl $_CURL_OPT_ POST $_API_TELEGRAM_/${FUNCNAME#*.} \
								${offset:+-d offset="$offset"} \
								${limit:+-d limit="$limit"} \
								${timeout:+-d timeout="$timeout"} \
								${allowed_updates:+-d allowed_updates="$allowed_updates"})


		# Limpa as variáveis inicializadas.
		unset $_var_init_list_ _var_init_list_
	
    	[[ $(jq -r '.result|length' <<< $jq_obj) -eq 0 ]] && return 0
		[[ $_FLUSH_OFFSET_ ]] && { echo "$jq_obj"; return 0; } # flush

		if [[ $_BOT_MONITOR_ ]]; then
			printf -v bar '=%.s' {1..50}
			printf "$bar\nData: %(%d/%m/%Y %T)T\n"
			printf 'Script: %s\nBot (nome): %s\nBot (usuario): %s\nBot (id): %s\n' 	\
					"${_BOT_SCRIPT_}" 												\
					"${_BOT_INFO_[2]}" 												\
					"${_BOT_INFO_[3]}" 												\
					"${_BOT_INFO_[1]}"
		fi

		for obj in $(GetAllKeys $jq_obj); do
	
			[[ $obj =~ [0-9]+ ]]
			vet=${BASH_REMATCH:-0}
			
			var=${obj//[0-9\[\]]/}
			var=${var#result.}
			var=${var//./_}
	
			declare -g $var
			local -n byref=$var # ponteiro
						
			val=$(Json ".$obj" $jq_obj)
			byref[$vet]+=${byref[$vet]:+$_BOT_DELM_}${val}

			if [[ $_BOT_MONITOR_ ]]; then
				[[ $vet -ne ${oldv:--1} ]] && printf "$bar\nMensagem: %d\n$bar\n" $((vet+1))
				printf "[%s]: %s = '%s'\n" "$FUNCNAME" "$var" "$val"
				oldv=$vet
			fi
	
			unset -n byref
			[[ $var != @(${_var_init_list_// /|}) ]] && _var_init_list_=${_var_init_list_:+$_var_init_list_ }${var}
		done
	
		# Log (thread)	
		[[ $_BOT_LOG_FILE_ ]] && CreateLog ${#update_id[@]} $jq_obj &
	
   		 # Status
   	 	return $?
	}
   
	# Bot métodos (somente leitura)
	readonly -f ShellBot.token 						\
				ShellBot.id 						\
				ShellBot.username 					\
				ShellBot.first_name 				\
				ShellBot.regHandleFunction 			\
				ShellBot.watchHandle 				\
				ShellBot.ListUpdates 				\
				ShellBot.TotalUpdates 				\
				ShellBot.OffsetEnd 					\
				ShellBot.OffsetNext 				\
				ShellBot.getMe 						\
				ShellBot.getWebhookInfo 			\
				ShellBot.deleteWebhook 				\
				ShellBot.setWebhook 				\
				ShellBot.init 						\
				ShellBot.ReplyKeyboardMarkup 		\
				ShellBot.ForceReply					\
				ShellBot.ReplyKeyboardRemove		\
				ShellBot.KeyboardButton				\
				ShellBot.sendMessage 				\
				ShellBot.forwardMessage 			\
				ShellBot.sendPhoto 					\
				ShellBot.sendAudio 					\
				ShellBot.sendDocument 				\
				ShellBot.sendSticker 				\
				ShellBot.sendVideo 					\
				ShellBot.sendVideoNote 				\
				ShellBot.sendVoice 					\
				ShellBot.sendLocation 				\
				ShellBot.sendVenue 					\
				ShellBot.sendContact 				\
				ShellBot.sendChatAction 			\
				ShellBot.getUserProfilePhotos 		\
				ShellBot.getFile 					\
				ShellBot.kickChatMember 			\
				ShellBot.leaveChat 					\
				ShellBot.unbanChatMember 			\
				ShellBot.getChat 					\
				ShellBot.getChatAdministrators 		\
				ShellBot.getChatMembersCount 		\
				ShellBot.getChatMember 				\
				ShellBot.editMessageText 			\
				ShellBot.editMessageCaption 		\
				ShellBot.editMessageReplyMarkup 	\
				ShellBot.InlineKeyboardMarkup 		\
				ShellBot.InlineKeyboardButton 		\
				ShellBot.answerCallbackQuery 		\
				ShellBot.deleteMessage 				\
				ShellBot.exportChatInviteLink 		\
				ShellBot.setChatPhoto 				\
				ShellBot.deleteChatPhoto 			\
				ShellBot.setChatTitle 				\
				ShellBot.setChatDescription 		\
				ShellBot.pinChatMessage 			\
				ShellBot.unpinChatMessage 			\
				ShellBot.promoteChatMember 			\
				ShellBot.restrictChatMember 		\
				ShellBot.getStickerSet 				\
				ShellBot.uploadStickerFile 			\
				ShellBot.createNewStickerSet 		\
				ShellBot.addStickerToSet 			\
				ShellBot.setStickerPositionInSet 	\
				ShellBot.deleteStickerFromSet 		\
				ShellBot.stickerMaskPosition 		\
				ShellBot.downloadFile 				\
				ShellBot.editMessageLiveLocation 	\
				ShellBot.stopMessageLiveLocation 	\
				ShellBot.setChatStickerSet 			\
				ShellBot.deleteChatStickerSet 		\
				ShellBot.sendMediaGroup 			\
				ShellBot.editMessageMedia 			\
				ShellBot.inputMedia 				\
				ShellBot.sendAnimation 				\
				ShellBot.setMessageRules 			\
				ShellBot.manageRules 				\
				ShellBot.getUpdates

   	# Retorna objetos
	printf '%s|%s|%s|%s\n'	"${_BOT_INFO_[1]}" \
							"${_BOT_INFO_[2]}" \
							"${_BOT_INFO_[3]}" \
							"${_FLUSH_OFFSET_:+$(FlushOffset)}"

	# status
   	return 0
}

# Funções (somente leitura)
readonly -f MessageError 		\
			Json 				\
			FlushOffset 		\
			CreateUnitService 	\
			GetAllKeys 			\
			GetAllValues 		\
			MethodReturn 		\
			CheckArgType 		\
			CreateLog			\
			FlagConv

# /* SHELLBOT */
