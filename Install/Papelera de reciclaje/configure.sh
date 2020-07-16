#!/bin/bash

# setting port ssh
sed -i '/Port 22222/a Port 22' /etc/ssh/sshd_config
sed -i 's/Port 22/Port 22/g' /etc/ssh/sshd_config
service ssh restart

# setting port ssh
sed -i 's/Port 22222/Port 22/g' /etc/ssh/sshd_config
service ssh restart

