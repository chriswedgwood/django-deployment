#!/usr/bin/env bash
# ssh -t username@host "$(cat example.sh)"

set -o pipefail  # trace ERR through pipes
set -o errexit   # same as set -e : exit the script if any statement returns a non-true return value

read -p "Application User:" APPLICATION
read -p "Droplet IP Address:" IPADDRESS


CYAN='\033[0;36m'
NC='\033[0m' # No Color
echo -e "${CYAN}####CREATING USER $APPLICATION####${NC}"

if getent passwd "$APPLICATION" >/dev/null; then
    printf 'The user %s exists\n' "$APPLICATION"
else
    printf 'The user %s does not exist\n' "$APPLICATION"
    adduser $APPLICATION
fi


gpasswd -a $APPLICATION sudo
usermod -aG sudo $APPLICATION

mkdir -p /home/$APPLICATION/.ssh
touch /home/$APPLICATION/.ssh/authorized_keys

cp /root/.ssh/authorized_keys /home/$APPLICATION/.ssh/authorized_keys
cp -r /root/deploy/ /home/$APPLICATION/
chown -R $APPLICATION:$APPLICATION /home/$APPLICATION/.ssh
chown -R $APPLICATION:$APPLICATION /etc/supervisor/
chown -R $APPLICATION:$APPLICATION /home/$APPLICATION/deploy/





echo "
export IP_ADDRESS='$IPADDRESS'
export APPLICATION='$APPLICATION'
" > /home/$APPLICATION/.env

source  /home/$APPLICATION/.env
echo -e "${CYAN}####MOVING TO USER $APPLICATION####${NC}"



cd /home/$APPLICATION/
sudo su $APPLICATION


