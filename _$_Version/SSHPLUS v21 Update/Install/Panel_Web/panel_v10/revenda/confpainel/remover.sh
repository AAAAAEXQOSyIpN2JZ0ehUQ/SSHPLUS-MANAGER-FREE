
USR_EX=$1

function _getUserEx()
{
grep "^$1\:x\:" /etc/passwd | \
cut -d ':' -f 1 | \
wc -c | \
sed 's/[^0-9]//g'
}

if [ -z "${USR_EX}" ]; then
echo "Diede mandou especificar um usuário"
exit 1
else
if [ $( _getUserEx $USR_EX ) -gt 3 ]; then
kill -9 `ps -fu $USR_EX | awk '{print $2}' | grep -v PID`
userdel $USR_EX
echo "1"
grep -v ^$USR_EX[[:space:]] /root/usuarios.db > /tmp/ph ; cat /tmp/ph > /root/usuarios.db
rm /etc/SSHPlus/senha/$USR_EX 1>/dev/null 2>/dev/null
rm /etc/usuarios/$USR_EX 1>/dev/null 2>/dev/null
exit 0
else
echo "2"
exit 2
fi
fi