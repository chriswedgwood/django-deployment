#!/usr/bin/env bash
read -p "Server IP:" IPADDRESS

scp  setup_ubuntu_dependencies.sh root@$IPADDRESS:/home/pcndodger
scp  setup_all.sh root@$IPADDRESS:/home/pcndodger


