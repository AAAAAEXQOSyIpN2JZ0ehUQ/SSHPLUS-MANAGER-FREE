#!/bin/bash

echo -e "\033[1;31mATENCAO!!\033[0m"
echo " "
echo -e "\033[1;33mEssa senha sera usada para entrar no seu servidor
\033[0m"
echo -e "\033[1;32mDIGITE A NOVA SENHA \033[1;32m
para continuar...\033[1;31m\033[0m"
read  -p : pass
(echo $pass; echo $pass)|passwd 2>/dev/null
sleep 1s
echo -e "\033[1;31mSENHA ALTERADA COM SUCESSO!\033[0m"
sleep 5s
cd
clear

