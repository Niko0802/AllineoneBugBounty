#!/bin/bash

sudo bash -c "
apt-get update -y && apt-get upgrade -y 
apt-get install hydra -y
snap install metasploit-framework
apt-get install nmap -y
apt-get install hashcat -y
apt install dirsearch -y
apt install gobuster -y
snap install searchsploit
apt install snort -y
apt install golang-go -y
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
CGO_ENABLED=1 go install github.com/projectdiscovery/katana/cmd/katana@latest
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install -v github.com/projectdiscovery/naabu/cmd/naabu@latest
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
apt install virtualbox-qt -y
apt install hashid -y
apt install sqlmap -y
snap install amass
"
