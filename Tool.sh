#!/bin/bash


sudo bash -c "
apt-get update -y
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
go install github.com/tomnomnom/gf@latest
go install github.com/tomnomnom/waybackurls@latest
go install github.com/bp0lr/gauplus@latest
go install github.com/lc/gau/v2/cmd/gau@latest
git clone https://github.com/NitinYadav00/gf-patterns.git
"


if [ "$(id -u)" -eq 0 ]; then
    # Eğer root kullanıcısıysak, /root/go/bin dizininden kopyala
    sudo cp /root/go/bin/* /usr/local/bin/
    echo "Root kullanıcısı. Dosyalar /root/go/bin dizininden /usr/local/bin dizinine kopyalandı."
else
    # Eğer normal kullanıcıysak, $HOME/go/bin dizininden kopyala
    sudo cp $HOME/go/bin/* /usr/local/bin/
    echo "Normal kullanıcı. Dosyalar $HOME/go/bin dizininden /usr/local/bin dizinine kopyalandı."
fi
