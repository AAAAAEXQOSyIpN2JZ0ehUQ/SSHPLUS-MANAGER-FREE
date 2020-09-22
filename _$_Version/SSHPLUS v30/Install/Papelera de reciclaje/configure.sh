#!/bin/bash

# setting port ssh
sed -i '/Port 22222/a Port 22' /etc/ssh/sshd_config
sed -i 's/Port 22/Port 22/g' /etc/ssh/sshd_config
service ssh restart

# setting port ssh ( SI DETECTA EL PUERTO 22222 LO CAMBIA A PUERTO 22 )
sed -i 's/Port 22222/Port 22/g' /etc/ssh/sshd_config
service ssh restart

# setting port ssh ( SI DETECTA EL PUERTO 22 AGREGA EL PUERTO 22222 ABAJO DEL PUERTO 22 )
sed -i '/Port 22/a Port 22222' /etc/ssh/sshd_config
service ssh restart
