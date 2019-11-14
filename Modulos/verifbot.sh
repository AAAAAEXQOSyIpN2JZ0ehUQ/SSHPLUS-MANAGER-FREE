#!/bin/bash
[[ ! -d /etc/SSHPlus ]] && exit 0
[[ ! -d /etc/bot/revenda ]] && exit 0
for arq in $(ls /etc/bot/revenda); do
    _diasR=$(grep 'Dias' /etc/bot/revenda/$arq/$arq| awk '{print $NF}')
    [[ "$_diasR" -eq '0' ]] && {
    	[[ "$(ls /etc/bot/revenda/$arq/usuarios| wc -l)" != '0' ]] && {
            for _user in $(ls /etc/bot/revenda/$arq/usuarios); do
                usermod -L $_user
                pkill -f $_user
            done
        }
        mv /etc/bot/revenda/$arq /etc/bot/suspensos/$arq
    } || {
    	_days=$(($_diasR - 1))
    	sed -i "s;$_diasR;$_days;" /etc/bot/revenda/$arq/$arq
    }
done