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


echo -e "${CYAN}####INSTALLING PYTHON ####${NC}"

#Python
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt-get update -y
sudo apt-get install -y python3.6
sudo apt-get install -y python3.6-dev
sudo apt-get install -y python3.6-venv
sudo apt-get install -y unixodbc-dev

echo -e "${CYAN}#### INSTALLING POSTGRES ####${NC}"

#Postgres
sudo apt-get -y install postgresql postgresql-contrib

echo -e "${CYAN}#### INSTALLING NGINX ####${NC}"

sudo apt-get -y install nginx

echo -e "${CYAN}#### INSTALLING SUPERVISOR ####${NC}"

#Supervisor
sudo apt-get -y install supervisor
sudo systemctl enable supervisor
sudo systemctl start supervisor

echo -e "${CYAN}#### INSTALLING VIRTUALENV ####${NC}"

#Virualenv
sudo apt-get install python3-pip
wget https://bootstrap.pypa.io/get-pip.py
sudo -H python3.6 get-pip.py
sudo -H pip3.6 install virtualenv

echo -e "${CYAN}#### INSTALLING POSTGRES DEPENDENCIES ####${NC}"

sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev
sudo apt-get install -y libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev 
sudo apt-get install -y postgresql-server-dev-all
sudo apt-get install -y postgresql-common
sudo apt-get install -y python-psycopg2


echo -e "${CYAN}#### NODE DEPENDENCIES ####${NC}"

sudo apt-get install -y nodejs
sudo apt-get install -y npm 


sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
sudo /sbin/mkswap /var/swap.1
sudo /sbin/swapon /var/swap.1










