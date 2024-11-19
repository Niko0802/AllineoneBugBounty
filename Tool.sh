#!/bin/bash

# Go proqramlaşdırma dilini yoxlamaq və quraşdırmaq
if ! command -v go &> /dev/null; then
    echo "Go proqramlaşdırma dili sistemdə tapılmadı. Quraşdırılır..."
    sudo apt-get install -y golang-go
else
    echo "Go proqramlaşdırma dili sistemdə mövcuddur."
fi

# Snap paket menecerini yoxlamaq və quraşdırmaq
if ! command -v snap &> /dev/null; then
    echo "Snap paket meneceri sistemdə tapılmadı. Quraşdırılır..."
    sudo apt-get install -y snapd
else
    echo "Snap paket meneceri sistemdə mövcuddur."
fi

# Alətlərin quraşdırılması
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
sudo apt install nikto -y
sudo apt install steghide
sudo apt install python3-pip
sudo apt-get install stegcracker -y
"

# Toolların /usr/local/bin/ qovluğuna kopyalanması 
if [ "$(id -u)" -eq 0 ]; then
    # Root istifadəçisiysə, /root/go/bin qovluğuna kopyalayırıq
    sudo cp /root/go/bin/* /usr/local/bin/
    echo "Root istifadəçisi. Fayllar /root/go/bin dizinindən /usr/local/bin dizinine kopyalandı."
else
    # Normal istifadəçiysə, $HOME/go/bin qovluğuna kopyalayırıq
    sudo cp $HOME/go/bin/* /usr/local/bin/
    echo "Normal istifadəçi. Fayllar $HOME/go/bin dizinindən /usr/local/bin dizinine kopyalandı."
fi
