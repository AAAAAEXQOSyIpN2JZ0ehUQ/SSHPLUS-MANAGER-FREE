#!/bin/bash
clear
usuario=$1
dias=$2
finaldate=$(date "+%Y-%m-%d" -d "+$dias days")
gui=$(date "+%d/%m/%Y" -d "+$dias days")
chage -E $finaldate $usuario