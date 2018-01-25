#!/usr/bin/env bash

#wget --no-check-certificate --content-disposition https://raw.githubusercontent.com/chriswedgwood/django-deployment/master/create_new_user.sh

read -p "Application User:" APPLICATION_USER
read -p "Server IP:" IPADDRESS

BLUE='\033[0;34m'

adduser $APPLICATION_USER
usermod -aG sudo $APPLICATION_USER

echo -e "${BLUE}RUN THESE NEXT...."
echo -e "${BLUE}mkdir .ssh"
echo -e "${BLUE}touch .ssh/authorized_keys"
echo -e "${BLUE}chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys"

su - $APPLICATION_USER

echo -e "${BLUE}#################################################################################"
echo -e "${BLUE}run exit"
echo -e "${BLUE}NOW RUN cat ~/.ssh/id_rsa.pub locally on your laptop"
echo -e "${BLUE}THEN LOGIN with root - ssh root@$IPADDRESS"
echo -e "${BLUE}su - $APPLICATION_USER"
echo -e "${BLUE}emacs .ssh/authorized_keys"
echo -e "${BLUE}PASTE CONTENTS OF CLIPBOARD INTO FILE"
echo -e "${BLUE}CTR-x CTR-s CTR-z"
echo -e "${BLUE}TRY ssh with $APPLICATION_USER - ssh $APPLICATION_USER@$IPADDRESS"
