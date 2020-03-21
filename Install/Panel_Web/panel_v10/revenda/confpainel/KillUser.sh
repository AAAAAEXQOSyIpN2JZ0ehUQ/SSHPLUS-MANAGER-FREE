
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

echo "1"

exit 0
else
echo "nao existe"
exit 2
fi
fi