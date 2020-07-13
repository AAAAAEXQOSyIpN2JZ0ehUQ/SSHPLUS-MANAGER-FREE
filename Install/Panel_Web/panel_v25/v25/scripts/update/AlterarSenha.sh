#!/bin/bash
usermod -p $(openssl passwd -1 $2) $1
echo "1"