#!/usr/bin/env bash
#ssh root@ipaddress 'bash -s' < initialise_droplet.sh
#TODO update and emacs
#TODO how to copy over ssh . Need to do this as application and git ssh not setup
set -o pipefail  # trace ERR through pipes
set -o errexit   # same as set -e : exit the script if any statement returns a non-true return value

CYAN='\033[0;36m'
NC='\033[0m' # No Color
echo -e "${CYAN}####INSTALLING DEPENDENCIES ####${NC}"

#General updates
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get install -y emacs
sudo apt-get install curl


echo -e "${CYAN}#### INSTALLING CADDY ####${NC}"

sudo curl https://getcaddy.com | bash -s personal
sudo setcap cap_net_bind_service=+ep /usr/local/bin/caddy

echo -e "${CYAN}#### INSTALLING SUPERVISOR ####${NC}"

#Supervisor
sudo apt-get -y install supervisor
sudo systemctl enable supervisor
sudo systemctl start supervisor


echo -e "${CYAN}#### NODE DEPENDENCIES ####${NC}"

sudo apt-get install -y nodejs
sudo apt-get install -y npm 

#Memory stuff that seems to work
sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
sudo /sbin/mkswap /var/swap.1
sudo /sbin/swapon /var/swap.1










