#!/bin/bash
clear
[[ -e /home/versao ]] && rm /home/versao
wget -P /home http://ssh-plus.tk/script/versao > /dev/null 2>&1
[[ -f "/home/versao" ]] && {
	vrs1=$(sed -n '1 p' /bin/versao| sed -e 's/[^0-9]//ig')
    vrs2=$(sed -n '1 p' /home/versao | sed -e 's/[^0-9]//ig')
	[[ "$vrs1" != "$vrs2" ]] && mv /home/versao /tmp/att
}
