#!/usr/bin/env bash
# ssh -t username@host "$(cat example.sh)"

set -o pipefail  # trace ERR through pipes
set -o errexit   # same as set -e : exit the script if any statement returns a non-true return value

read -p "Application User:" APPLICATION
read -p "Droplet IP Address:" IPADDRESS
read -p "Site Domain(no www):" DOMAIN

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



echo "
export IP_ADDRESS='$IPADDRESS'
export APPLICATION='$APPLICATION'
export DOMAIN='$DOMAIN'" > ~/.env

source  ~/.env


