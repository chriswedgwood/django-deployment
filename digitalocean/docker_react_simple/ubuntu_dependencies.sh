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



echo -e "${CYAN}#### INSTALLING SUPERVISOR ####${NC}"

#Supervisor
sudo apt-get -y install supervisor
sudo systemctl enable supervisor
sudo systemctl start supervisor










