#!/bin/bash
clear
DirBackup="banco19157"
rm /var/www/html/admin/pages/apis/$DirBackup/sshplus.sql > /dev/null 2>&1
senha=$(cat /var/www/html/pages/system/pass.php |cut -d"'" -f2)
mysqldump -u root -p$senha sshplus > /var/www/html/admin/pages/apis/$DirBackup/sshplus.sql