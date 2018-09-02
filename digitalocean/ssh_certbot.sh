#!/usr/bin/env bash


sudo apt-get update
sudo apt-get install python-certbot-nginx
sudo nginx -t
sudo systemctl reload nginx
sudo ufw disable
sudo ufw enable
sudo ufw allow 'Nginx Full'
sudo ufw delete allow 'Nginx HTTP'
sudo ufw allow 'OpenSSH'
sudo ufw status

sudo add-apt-repository ppa:certbot/certbot

sudo certbot --nginx -d peoplevsparkingtickets.co.uk -d www.peoplevsparkingtickets.co.uk