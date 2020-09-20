#!/bin/bash
usermod -p $(openssl passwd -1 $2) $1
echo "$2" > /etc/SSHPlus/senha/$1
echo "1"
pkill -f $1