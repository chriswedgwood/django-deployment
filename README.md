1) scp -r ./digitalocean root@178.62.31.29:/root
2) ssh root@<ipaddress>
3) ./digitalocean/
4) ./digitalocean/security_configuration.sh
5) 

1) ssh -t root@<ip address> "$(cat 1_ubuntu_dependencies.sh)"
2) ssh -t root@<ip address> "$(cat 2_security_configuration.sh)"
3) ssh -t <application name>@<ip address> "$(cat 3_ssh_git_setup.sh)" 

testing 

ssh -T git@github.com

pbcopy < ~/.ssh/id_rsa.pub

ssh git should not be run under sudo!!