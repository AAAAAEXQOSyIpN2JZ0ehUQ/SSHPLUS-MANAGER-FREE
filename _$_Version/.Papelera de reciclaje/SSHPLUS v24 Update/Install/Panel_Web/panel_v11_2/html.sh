#!/bin/bash
clear
[[ $(ls /var/tmp| grep .painel|wc -l) != '0' ]] && {
for i in $(ls /var/tmp| grep '.painel'); do
tempo=$(cat /var/tmp/$i| cut -d : -f1)
iduser=$(cat /var/tmp/$i| cut -d : -f2)
echo "#!/bin/bash
echo 'executando..'
sleep ${tempo}
php /var/www/html/pages/system/cron.ssh.teste.php ${iduser}
rm /home/$i.sh
exit" > /home/$i.sh
rm /var/tmp/$i
chmod +x /home/$i.sh
screen -dmS $i /home/$i.sh
sleep 1
done
}
