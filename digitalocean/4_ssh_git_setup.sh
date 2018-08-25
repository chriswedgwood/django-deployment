#!/usr/bin/env bash

CYAN='\033[0;36m'
NC='\033[0m' # No Color

source .env
echo -e "${CYAN}####SETUP SSH FOR GITHUB CLONES####${NC}"
ssh-keygen -t rsa -b 4096 -C "wedgemail@gmail.com"
echo -e "${CYAN}####CHECK ssh-agent IS UP####${NC}"
eval $(ssh-agent -s)
echo -e "${CYAN}####adding id_rsa to agent. You need to re-enter the ssh key passphrase ####${NC}"

ssh-add ~/.ssh/id_rsa
echo -e "${CYAN}####COPY THIS KEY TO GITHUB####${NC}"
cat cat /home/$APPLICATION/.ssh/id_rsa.pub
