1) scp -r ./digitalocean root@<ipaddress>:/root
2) ssh root@<ipaddress>
3) ./digitalocean/ubuntu_dependencies.sh
4) ./digitalocean/security_configuration.sh
5) ./digitalocean/ssh_git_setup.sh
6) ./digitalocean/setup_postgres.sh
7) ./digitalocean/deploy_production.sh


systemctl status nginx.service
sudo journalctl -xe
cat /var/log/nginx/access.log
cat  /var/log/nginx/error.log
cat /home/<application>/logs/nginx-access.log;
cat /home/<application>/logs/nginx-error.log;
cat /home/<application>/logs/gunicorn-error.log
sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl status <application>
sudo supervisorctl restart <application>

sudo service nginx restart


 
 
