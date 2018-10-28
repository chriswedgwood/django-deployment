#!/usr/bin/env bash
#ssh root@ipaddress 'bash -s' < initialise_droplet.sh
#TODO update and emacs
#TODO how to copy over ssh . Need to do this as application and git ssh not setup

CYAN='\033[0;36m'
NC='\033[0m' # No Color
echo -e "${CYAN}####INSTALLING DEPENDENCIES ####${NC}"



#General updates
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get install emacs


echo -e "${CYAN}####INSTALLING PYTHON ####${NC}"

#Python
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get install python3.6
sudo apt-get install python3.6-dev
sudo apt-get install unixodbc-dev

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
wget https://bootstrap.pypa.io/get-pip.py
sudo -H python3.6 get-pip.py
sudo -H pip3.6 install virtualenv


sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev
sud apt-get install -y libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev     xz-utils tk-dev python3.6 python3.6-venv python3.6-dev











