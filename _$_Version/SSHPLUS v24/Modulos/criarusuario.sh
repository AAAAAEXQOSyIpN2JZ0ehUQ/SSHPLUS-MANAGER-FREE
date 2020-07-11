#!/bin/bash
IP=$(cat /etc/IP)
# Gerar client.ovpn
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
fun_geraovpn () {
if [[ "$respost" = @(s|S) ]]; then
  cd /etc/openvpn/easy-rsa/
  ./easyrsa build-client-full $username nopass
  newclient "$username"
  sed -e "s;auth-user-pass;<auth-user-pass>\n$username\n$password\n</auth-user-pass>;g" /root/$username.ovpn > /root/tmp.ovpn && mv -f /root/tmp.ovpn /root/$username.ovpn
else
  cd /etc/openvpn/easy-rsa/
  ./easyrsa build-client-full $username nopass
  newclient "$username"
fi
} > /dev/null 2>&1
if [[ -e /etc/openvpn/server.conf ]]; then
  _Port=$(sed -n '1 p' /etc/openvpn/server.conf | cut -d' ' -f2)
  hst=$(sed -n '8 p' /etc/openvpn/client-common.txt | awk {'print $4'})
  rmt=$(sed -n '7 p' /etc/openvpn/client-common.txt)
  hedr=$(sed -n '8 p' /etc/openvpn/client-common.txt)
  prxy=$(sed -n '9 p' /etc/openvpn/client-common.txt)
  rmt2='/SSHPLUS?'
  rmt3=$(cat /etc/IP)
  prx='200.142.130.104'
  vivo1="portalrecarga.vivo.com.br/recarga"
  vivo2="portalrecarga.vivo.com.br/controle/"
  vivo3="navegue.vivo.com.br/pre/"
  vivo4="navegue.vivo.com.br/controle/"
  vivo5="www.vivo.com.br"
  oi="d1n212ccp6ldpw.cloudfront.net"
  bypass="net_gateway"
  cert01="/etc/openvpn/client-common.txt"
  if [[ "$hst" == "$vivo1" ]]; then
    Host="Portal Recarga"
  elif [[ "$hst" == "$vivo2" ]]; then
    Host="Recarga contole"
  elif [[ "$hst" == "$vivo3" ]]; then
    Host="Portal Navegue"
  elif [[ "$hst" == "$vivo4" ]]; then
    Host="Nav controle"
  elif [[ "$hst" == "$IP:$_Port" ]]; then
    Host="Vivo MMS"
  elif [[ "$hst" == "$oi" ]]; then
    Host="Oi"
  elif [[ "$hst" == "$bypass" ]]; then
    Host="Modo Bypass"
  else
    Host="Desconhecido"
  fi
fi
fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} > /dev/null 2>&1
${comando[1]} > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
echo -ne "\033[1;33mAGUARDE \033[1;37m- \033[1;33m["
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
   echo -ne "\033[1;33mAGUARDE \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}
fun_edithost () {
  clear
  echo -e "\E[44;1;37m          ALTERAR HOST OVPN            \E[0m"
  echo ""
  echo -e "\033[1;33mHOST EM USO\033[1;37m: \033[1;32m$Host"
  echo ""
  echo -e "\033[1;31m[\033[1;36m1\033[1;31m] \033[1;33mVIVO RECARGA"
  echo -e "\033[1;31m[\033[1;36m2\033[1;31m] \033[1;33mVIVO NAVEGUE PRE"
  echo -e "\033[1;31m[\033[1;36m3\033[1;31m] \033[1;33mVIVO MMS \033[1;31m[\033[1;37mAPN: \033[1;32mmms.vivo.com.br\033[1;31m]"
  echo -e "\033[1;31m[\033[1;36m4\033[1;31m] \033[1;33mHOST OI 4G \033[1;31m[\033[1;32mAlgumas Regioes\033[1;31m]"
  echo -e "\033[1;31m[\033[1;36m5\033[1;31m] \033[1;33mMODO BYPASS \033[1;31m[\033[1;32mopen + http injector\033[1;31m]"
  echo -e "\033[1;31m[\033[1;36m6\033[1;31m] \033[1;33mTODOS HOSTS \033[1;31m[\033[1;32m1 Ovpn de cada\033[1;31m]" 
  echo -e "\033[1;31m[\033[1;36m7\033[1;31m] \033[1;33mEDITAR MANUALMENTE"
  echo -e "\033[1;31m[\033[1;36m0\033[1;31m] \033[1;33mVOLTAR"
  echo ""
  echo -ne "\033[1;32mQUAL HOST DESEJA ULTILIZAR \033[1;33m?\033[1;37m "; read respo
  if [[ -z "$respo" ]]; then
    echo ""
    echo -e "\033[1;31mOpcao invalida!"
    sleep 2
    fun_edithost
  fi
  if [[ "$respo" = '1' ]]; then
    echo ""
    echo -e "\033[1;32mALTERANDO HOST!\033[0m"
    echo ""
    fun_althost () {
        sed -i "s;$rmt;remote $rmt2 $_Port;" $cert01
        sed -i "s;$hedr;http-proxy-option CUSTOM-HEADER Host $vivo1;" $cert01
        sed -i "s;$prxy;http-proxy $IP 80;" $cert01
    }
    fun_bar 'fun_althost'
    echo ""
    echo -e "\033[1;32mHOST ALTERADO COM SUCESSO!\033[0m"
    fun_geraovpn
    sleep 1.5
  elif [[ "$respo" = '2' ]]; then
    echo ""
    echo -e "\033[1;32mALTERANDO HOST!\033[0m"
    echo ""
    fun_althost2 () {
      sed -i "s;$rmt;remote $rmt2 $_Port;" $cert01
      sed -i "s;$hedr;http-proxy-option CUSTOM-HEADER Host $vivo3;" $cert01
      sed -i "s;$prxy;http-proxy $IP 80;" $cert01
    }
    fun_bar 'fun_althost2'
    echo ""
    echo -e "\033[1;32mHOST ALTERADO COM SUCESSO!\033[0m"
    fun_geraovpn
    sleep 1.5
  elif [[ "$respo" = '3' ]]; then
    echo ""
    echo -e "\033[1;32mALTERANDO HOST!\033[0m"
    echo ""
    fun_althost3 () {
      sed -i "s;$rmt;remote $rmt3;" $cert01
      sed -i "s;$hedr;http-proxy-option CUSTOM-HEADER Host $IP:$_Port;" $cert01
      sed -i "s;$prxy;http-proxy $prx 80;" $cert01
    }
    fun_bar 'fun_althost3'
    echo ""
    echo -e "\033[1;32mHOST ALTERADO COM SUCESSO!\033[0m"
    fun_geraovpn
    sleep 1.5
  elif [[ "$respo" = '4' ]]; then
    echo ""
    echo -e "\033[1;32mALTERANDO HOST!\033[0m"
    echo ""
    fun_althost4 () {
      sed -i "s;$rmt;remote $oi $_Port;" $cert01
      sed -i "s;$hedr;http-proxy-option CUSTOM-HEADER Host $oi;" $cert01
      sed -i "s;$prxy;http-proxy $IP 80;" $cert01
    }
    fun_bar 'fun_althost4'
    echo ""
    echo -e "\033[1;32mHOST ALTERADO COM SUCESSO!\033[0m"
    fun_geraovpn
    sleep 1.5
  elif [[ "$respo" = '5' ]]; then
    echo ""
    echo -e "\033[1;32mALTERANDO HOST!\033[0m"
    echo ""
    fun_althost5 () {
      sed -i "s;$rmt;remote $IP $_Port;" $cert01
      sed -i "s;$hedr;route $IP 255.255.255.255 net_gateway;" $cert01
      sed -i "s;$prxy;http-proxy 127.0.0.1 8989;" $cert01
    }
    fun_bar 'fun_althost5'
    echo ""
    echo -e "\033[1;32mHOST ALTERADO COM SUCESSO!\033[0m"
    fun_geraovpn
    sleep 1.5
  elif [[ "$respo" = '6' ]]; then
      [[ ! -e "$HOME/$username.ovpn" ]] && fun_geraovpn
      echo ""
      echo -e "\033[1;32mALTERANDO HOSTS!\033[0m"
      echo ""
      fun_packhost () {
        [[ ! -d "$HOME/OVPN" ]] && mkdir $HOME/OVPN 
        sed -i "7,9"d $HOME/$username.ovpn
        sleep 0.5
        sed -i "7i\remote $rmt2 $_Port\nhttp-proxy-option CUSTOM-HEADER Host $vivo1\nhttp-proxy $IP 80" $HOME/$username.ovpn
        cp $HOME/$username.ovpn /root/OVPN/$username-vivo1.ovpn
        sed -i "8"d $HOME/$username.ovpn
        sleep 0.5
        sed -i "8i\http-proxy-option CUSTOM-HEADER Host $vivo3" $HOME/$username.ovpn
        cp $HOME/$username.ovpn /root/OVPN/$username-vivo2.ovpn        
        sed -i "7,9"d $HOME/$username.ovpn
        sleep 0.5
        sed -i "7i\remote $rmt3 $_Port\nhttp-proxy-option CUSTOM-HEADER Host $IP:$_Port\nhttp-proxy $prx 80" $HOME/$username.ovpn
        cp $HOME/$username.ovpn /root/OVPN/$username-vivo3.ovpn        
        sed -i "7,9"d $HOME/$username.ovpn
        sleep 0.5
        sed -i "7i\remote $oi $_Port\nhttp-proxy-option CUSTOM-HEADER Host $oi\nhttp-proxy $IP 80" $HOME/$username.ovpn
        cp $HOME/$username.ovpn /root/OVPN/$username-oi.ovpn
        sed -i "7,9"d $HOME/$username.ovpn
        sleep 0.5
        sed -i "7i\remote $IP $_Port\nroute $IP 255.255.255.255 net_gateway\nhttp-proxy 127.0.0.1 8989" $HOME/$username.ovpn
        cp $HOME/$username.ovpn /root/OVPN/$username-bypass.ovpn
        cd $HOME/OVPN && zip $username.zip *.ovpn > /dev/null 2>&1 && cp $username.zip $HOME/$username.zip
        cd $HOME && rm -rf /root/OVPN > /dev/null 2>&1
      }
      fun_bar 'fun_packhost'
      echo ""
      echo -e "\033[1;32mALTERADO COM SUCESSO!\033[0m"
      sleep 1.5
  elif [[ "$respo" = '7' ]]; then
    echo ""
    echo -e "\033[1;32mALTERANDO ARQUIVO OVPN!\033[0m"
    echo ""
    echo -e "\033[1;31mATENCAO!\033[0m"
    echo ""
    echo -e "\033[1;33mPARA SALVAR USE AS TECLAS \033[1;32mctrl x y\033[0m"
    sleep 4
    clear
    nano /etc/openvpn/client-common.txt
    echo ""
    echo -e "\033[1;32mALTERADO COM SUCESSO!\033[0m"
    fun_geraovpn
    sleep 1.5
  elif [[ "$respo" = '0' ]]; then
    echo ""
    echo -e "\033[1;31mRetornando...\033[0m"
    sleep 2
  else
    echo ""
    echo -e "\033[1;31mOpcao invalida !\033[0m"
    sleep 2
    fun_edithost
  fi
}
[[ ! -e /usr/lib/sshplus ]] && rm -rf /bin/ > /dev/null 2>&1
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%30s%s%-15s\n' "Criar usuário SSH" ; tput sgr0
echo ""
echo -ne "\033[1;32mNome do usuário:\033[1;37m "; read username
awk -F : ' { print $1 }' /etc/passwd > /tmp/users 
if grep -Fxq "$username" /tmp/users
then
  tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Este usuário já existe. tente outro nome." ; echo "" ; tput sgr0
  exit 1  
else
  if (echo $username | egrep [^a-zA-Z0-9.-_] &> /dev/null)
  then
    tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você digitou um nome de usuário inválido!" ; tput setab 1 ; echo "Use apenas letras, números, pontos e traços." ; tput setab 4 ; echo "Não use espaços, acentos ou caracteres especiais!" ; echo "" ; tput sgr0
    exit 1
  else
    sizemin=$(echo ${#username})
    if [[ $sizemin -lt 2 ]]
    then
      tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você digitou um nome de usuário muito curto," ; echo "use no mínimo dois caracteres!" ; echo "" ; tput sgr0
      exit 1
    else
      sizemax=$(echo ${#username})
      if [[ $sizemax -gt 10 ]]
      then
        tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você digitou um nome de usuário muito grande," ; echo "use no máximo 10 caracteres!" ; echo "" ; tput sgr0
        exit 1
      else
        if [[ -z $username ]]
        then
          tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você digitou um nome de usuário vazio!" ; echo "" ; tput sgr0
          exit 1
        else  
           echo -ne "\033[1;32mSenha:\033[1;37m "; read password
          if [[ -z $password ]]
          then
            tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você digitou uma senha vazia!" ; echo "" ; tput sgr0
            exit 1
          else
            sizepass=$(echo ${#password})
            if [[ $sizepass -lt 4 ]]
            then
              tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Senha curta!, use no mínimo 4 caracteres" ; echo "" ; tput sgr0
              exit 1
            else  
                echo -ne "\033[1;32mDias Para Expirar:\033[1;37m "; read dias
              if (echo $dias | egrep '[^0-9]' &> /dev/null)
              then
                tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você digitou um número de dias inválido!" ; echo "" ; tput sgr0
                exit 1
              else
                if [[ -z $dias ]]
                then
                  tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você deixou o número de dias para a conta expirar vazio!" ; echo "" ; tput sgr0
                  exit 1
                else  
                  if [[ $dias -lt 1 ]]
                  then
                    tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você deve digitar um número de dias maior que zero!" ; echo "" ; tput sgr0
                    exit 1
                  else
                      echo -ne "\033[1;32mLimite De Conexões:\033[1;37m "; read sshlimiter
                    if (echo $sshlimiter | egrep '[^0-9]' &> /dev/null)
                    then
                      tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você digitou um número de conexões inválido!" ; echo "" ; tput sgr0
                      exit 1
                    else
                      if [[ -z $sshlimiter ]]
                      then
                        tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Você deixou o limite de conexões vazio!" ; echo "" ; tput sgr0
                        exit 1
                      else
                        if [[ $sshlimiter -lt 1 ]]
                        then
                          tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Número de conexões simultâneas deve ser maior que zero!" ; echo "" ; tput sgr0
                          exit 1
                        else
                          final=$(date "+%Y-%m-%d" -d "+$dias days")
                          gui=$(date "+%d/%m/%Y" -d "+$dias days")
                          pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
                          sleep 0.5s
                          useradd -e $final -M -s /bin/false -p $pass $username
                          echo "$password" > /etc/SSHPlus/senha/$username
                          echo "$username $sshlimiter" >> /root/usuarios.db
                          if [[ -e /etc/openvpn/server.conf ]]; then
                              echo -ne "\033[1;32mGerar Arquivo Ovpn \033[1;31m? \033[1;33m[s/n]:\033[1;37m "; read resp
                              if [[ "$resp" = @(s|S) ]]; then
                                rm $username.zip $username.ovpn > /dev/null 2>&1
                                echo -ne "\033[1;32mGerar Com usuário e Senha \033[1;31m? \033[1;33m[s/n]:\033[1;37m "; read respost
                                echo -ne "\033[1;32mHost Atual\033[1;37m: \033[1;31m(\033[1;37m$Host\033[1;31m) \033[1;37m- \033[1;32mAlterar \033[1;31m? \033[1;33m[s/n]:\033[1;37m "; read oprc
                                if [[ "$oprc" = @(s|S) ]]; then
                                  fun_edithost
                                else
                                   fun_geraovpn
                                fi
                                gerarovpn () {
                                  if [[ ! -e "/root/$username.zip" ]]; then
                                    zip /root/$username.zip /root/$username.ovpn
                                    sleep 1.5
                                  fi
                                }
                                clear
                                echo -e "\E[44;1;37m       CONTA SSH CRIADA !      \E[0m"
                                [ $? -eq 0 ] && tput setaf 2 ; tput bold ; echo ""; echo -e "\033[1;32mIP: \033[1;37m$IP" ; echo -e "\033[1;32mUsuário: \033[1;37m$username" ; echo -e "\033[1;32mSenha: \033[1;37m$password" ; echo -e "\033[1;32mExpira em: \033[1;37m$gui" ; echo -e "\033[1;32mLimite de conexões: \033[1;37m$sshlimiter" ; echo "" || echo "Não foi possível criar o usuário!" ; tput sgr0
                                sleep 1
                                function aguarde {
                                  helice () {
                                    gerarovpn > /dev/null 2>&1 & 
                                    tput civis
                                    while [ -d /proc/$! ]
                                    do
                                      for i in / - \\ \|
                                      do
                                        sleep .1
                                        echo -ne "\e[1D$i"
                                      done
                                    done
                                    tput cnorm
                                  }
                                  echo -ne "\033[1;31mCRIANDO OVPN\033[1;33m.\033[1;31m. \033[1;32m"
                                  helice
                                  echo -e "\e[1DOK"
                                }
                                aguarde
                                VERSION_ID=$(cat /etc/os-release | grep "VERSION_ID")
                                echo ""
                                if [ -d /var/www/html/openvpn ]; then
                                  mv $HOME/$username.zip /var/www/html/openvpn/$username.zip > /dev/null 2>&1
                                  if [[ "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
                                    echo -e "\033[1;32mLINK\033[1;37m: \033[1;36m$IP:81/html/openvpn/$username.zip"
                                  else
                                    echo -e "\033[1;32mLINK\033[1;37m: \033[1;36m$IP:81/openvpn/$username.zip"
                                  fi
                                else
                                  echo -e "\033[1;32mDisponivel em\033[1;31m" ~/"$username.zip\033[0m"
                                  sleep 1
                                fi
                              else
                                clear
                                echo -e "\E[44;1;37m       CONTA SSH CRIADA !      \E[0m"
                                [ $? -eq 0 ] && tput setaf 2 ; tput bold ; echo ""; echo -e "\033[1;32mIP: \033[1;37m$IP" ; echo -e "\033[1;32mUsuário: \033[1;37m$username" ; echo -e "\033[1;32mSenha: \033[1;37m$password" ; echo -e "\033[1;32mExpira em: \033[1;37m$gui" ; echo -e "\033[1;32mLimite de conexões: \033[1;37m$sshlimiter" ; echo "" || echo "Não foi possível criar o usuário!" ; tput sgr0
                              fi
                          else
                            clear
                            echo -e "\E[44;1;37m       CONTA SSH CRIADA !      \E[0m"
                            [ $? -eq 0 ] && tput setaf 2 ; tput bold ; echo ""; echo -e "\033[1;32mIP: \033[1;37m$IP" ; echo -e "\033[1;32mUsuário: \033[1;37m$username" ; echo -e "\033[1;32mSenha: \033[1;37m$password" ; echo -e "\033[1;32mExpira em: \033[1;37m$gui" ; echo -e "\033[1;32mLimite de conexões: \033[1;37m$sshlimiter" ; echo "" || echo "Não foi possível criar o usuário!" ; tput sgr0
                          fi
                        fi
                      fi
                    fi
                  fi
                fi
              fi
            fi
          fi
        fi
      fi
    fi
  fi  
fi