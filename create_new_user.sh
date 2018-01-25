#!/usr/bin/env bash

#wget --no-check-certificate --content-disposition https://raw.githubusercontent.com/chriswedgwood/django-deployment/master/create_new_user.sh

read -p "Application User:" APPLICATION_USER


adduser $APPLICATION_USER
usermod -aG sudo $APPLICATION_USER

echo "RUN THESE..."
echo "mkdir .ssh"
echo "touch .ssh/authorized_keys"

echo "chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys"
echo "exit"
echo "exit"

echo "#################################################################################"
echo "NOW RUN cat ~/.ssh/id_rsa.pub locally on your laptop"
echo "THEN LOGIN with root - ssh root@ip.ad.dr.es"
echo "su - $APPLICATION_USER"
echo "emacs ./ssh/authorized_keys"
echo "PASTE CONTENTS OF CLIPBOARD INTO FILE"
echo "CTR-x CTR-s CTR-z"
echo "exit"
echo "exit"
echo "TRY ssh with $APPLICATION_USER - ssh $APPLICATION_USER@ip.ad.dr.es"