#!/bin/bash

# Rəng kodları
RED='\e[31m'
GREEN='\e[32m'
NC='\e[0m' # Normal rəng

# Alətlərin endiriləcəyi qovluq
TOOLS_DIR="$HOME/tools"
mkdir -p $TOOLS_DIR

# Go yüklənməyibsə, Go yükləyin
if ! [ -x "$(command -v go)" ]; then
  echo -e "${RED}Go yüklənməmişdir. Yüklənir...${NC}"
  sudo apt-get install snapd -y # snap yoxdursa, snap quraşdırılır
  sudo snap install go || sudo apt install golang-go -y
  echo -e "${GREEN}Go uğurla yükləndi.${NC}"
else
  echo -e "${GREEN}Go artıq mövcuddur.${NC}"
fi

# GOPATH qurun
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Alətlərin siyahısını göstərmək
echo -e "${RED}Yüklənəcək alətlər siyahısı:${NC}"
echo -e "1. Katana"
echo -e "2. Nuclei"
echo -e "3. Subfinder"
echo -e "4. gau"
echo -e "5. urldedupe"
echo -e "6. waybackurls"
echo -e "7. gf"
echo -e "8. SQLMap"
echo -e "9. Dalfox"
echo -e "10. Gobuster"
echo -e "11. WPScan"
echo -e "12. Amass"
echo -e "13. Nmap"
echo -e "14. ZAP (OWASP ZAP Proxy)"
echo -e "15. Hamısı (Bütün alətlər)"

# İstifadəçidən alət seçimi alınır
read -p "Endirmək istədiyiniz alətin nömrəsini daxil edin: " tool_choice

# Alətlərin yükləmə funksiyaları
install_katana() {
  if command -v katana > /dev/null; then
    echo -e "${GREEN}Katana artıq yüklüdür.${NC}"
  else
    echo -e "${RED}Katana yüklənir...${NC}"
    go install github.com/projectdiscovery/katana/cmd/katana@latest
    sudo cp ~/go/bin/katana /usr/local/bin/
    echo -e "${GREEN}Katana uğurla quraşdırıldı.${NC}"
  fi
}

install_nuclei() {
  if command -v nuclei > /dev/null; then
    echo -e "${GREEN}Nuclei artıq yüklüdür.${NC}"
  else
    echo -e "${RED}Nuclei yüklənir...${NC}"
    go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
    sudo cp ~/go/bin/nuclei /usr/local/bin/
    echo -e "${GREEN}Nuclei uğurla quraşdırıldı.${NC}"
    sudo nuclei -up
  fi
}

install_subfinder() {
  if command -v subfinder > /dev/null; then
    echo -e "${GREEN}Subfinder artıq yüklüdür.${NC}"
  else
    echo -e "${RED}Subfinder yüklənir...${NC}"
    go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
    sudo cp ~/go/bin/subfinder /usr/local/bin/
    echo -e "${GREEN}Subfinder uğurla quraşdırıldı.${NC}"
  fi
}

install_gau() {
  if command -v gau > /dev/null; then
    echo -e "${GREEN}gau artıq yüklüdür.${NC}"
  else
    echo -e "${RED}gau yüklənir...${NC}"
    go install github.com/lc/gau/v2/cmd/gau@latest
    sudo cp $GOPATH/bin/gau /usr/local/bin/
    echo -e "${GREEN}gau uğurla quraşdırıldı.${NC}"
  fi
}

install_urldedupe() {
  if command -v urldedupe > /dev/null; then
    echo -e "${GREEN}urldedupe artıq yüklüdür.${NC}"
  else
    echo -e "${RED}urldedupe yüklənir...${NC}"
    go install github.com/lc/urldedupe/cmd/urldedupe@latest
    sudo cp $GOPATH/bin/urldedupe /usr/local/bin/
    echo -e "${GREEN}urldedupe uğurla quraşdırıldı.${NC}"
  fi
}

install_waybackurls() {
  if command -v waybackurls > /dev/null; then
    echo -e "${GREEN}waybackurls artıq yüklüdür.${NC}"
  else
    echo -e "${RED}waybackurls yüklənir...${NC}"
    go install github.com/tomnomnom/waybackurls@latest
    sudo cp $GOPATH/bin/waybackurls /usr/local/bin/
    echo -e "${GREEN}waybackurls uğurla quraşdırıldı.${NC}"
  fi
}

install_gf() {
  if command -v gf > /dev/null; then
    echo -e "${GREEN}gf artıq yüklüdür.${NC}"
  else
    echo -e "${RED}gf yüklənir...${NC}"
    go install github.com/tomnomnom/gf@latest
    sudo cp $GOPATH/bin/gf /usr/local/bin/
    echo -e "${GREEN}gf uğurla quraşdırıldı.${NC}"
    
    echo -e "${RED}gf pattern-ləri yüklənir...${NC}"
    mkdir -p $HOME/.gf
    git clone https://github.com/NitinYadav00/gf-patterns.git $HOME/.gf/Gf-Patterns
    cp $HOME/.gf/Gf-Patterns/*.json $HOME/.gf/
    echo -e "${GREEN}gf pattern-lər uğurla quraşdırıldı.${NC}"
  fi
}

install_sqlmap() {
  if command -v sqlmap > /dev/null; then
    echo -e "${GREEN}SQLMap artıq yüklüdür.${NC}"
  else
    echo -e "${RED}SQLMap yüklənir...${NC}"
    sudo snap install sqlmap --classic
    echo -e "${GREEN}SQLMap uğurla quraşdırıldı.${NC}"
  fi
}

install_dalfox() {
  if command -v dalfox > /dev/null; then
    echo -e "${GREEN}Dalfox artıq yüklüdür.${NC}"
  else
    echo -e "${RED}Dalfox yüklənir...${NC}"
    go install github.com/hahwul/dalfox/v2@latest
    sudo cp $GOPATH/bin/dalfox /usr/local/bin/
    echo -e "${GREEN}Dalfox uğurla quraşdırıldı.${NC}"
  fi
}

install_gobuster() {
  if command -v gobuster > /dev/null; then
    echo -e "${GREEN}Gobuster artıq yüklüdür.${NC}"
  else
    echo -e "${RED}Gobuster yüklənir...${NC}"
    go install github.com/OJ/gobuster/v3@latest
    sudo cp $GOPATH/bin/gobuster /usr/local/bin/
    echo -e "${GREEN}Gobuster uğurla quraşdırıldı.${NC}"
  fi
}

install_wpscan() {
  if command -v wpscan > /dev/null; then
    echo -e "${GREEN}WPScan artıq yüklüdür.${NC}"
  else
    echo -e "${RED}WPScan yüklənir...${NC}"
    sudo apt-get install ruby ruby-dev -y
    sudo gem install wpscan -y
    echo -e "${GREEN}WPScan uğurla quraşdırıldı.${NC}"
  fi
}

install_amass() {
  if command -v amass > /dev/null; then
    echo -e "${GREEN}Amass artıq yüklüdür.${NC}"
  else
    echo -e "${RED}Amass yüklənir...${NC}"
    go install github.com/OWASP/Amass/v3/...@master
    sudo cp $GOPATH/bin/amass /usr/local/bin/
    echo -e "${GREEN}Amass uğurla quraşdırıldı.${NC}"
  fi
}

install_nmap() {
  if command -v nmap > /dev/null; then
    echo -e "${GREEN}Nmap artıq yüklüdür.${NC}"
  else
    echo -e "${RED}Nmap yüklənir...${NC}"
    sudo snap install nmap
    echo -e "${GREEN}Nmap uğurla quraşdırıldı.${NC}"
  fi
}

install_zaproxy() {
  if command -v zaproxy > /dev/null; then
    echo -e "${GREEN}ZAP artıq yüklüdür.${NC}"
  else
    echo -e "${RED}ZAP yüklənir...${NC}"
    sudo snap install zaproxy --classic
    echo -e "${GREEN}ZAP uğurla quraşdırıldı.${NC}"
  fi
}

# Seçim əsasında müvafiq alət yüklənir
case $tool_choice in
  1)
    install_katana
    ;;
  2)
    install_nuclei
    ;;
  3)
    install_subfinder
    ;;
  4)
    install_gau
    ;;
  5)
    install_urldedupe
    ;;
  6)
    install_waybackurls
    ;;
  7)
    install_gf
    ;;
  8)
    install_sqlmap
    ;;
  9)
    install_dalfox
    ;;
  10)
    install_gobuster
    ;;
  11)
    install_wpscan
    ;;
  12)
    install_amass
    ;;
  13)
    install_nmap
    ;;
  14)
    install_zaproxy
    ;;
  15)
    install_katana
    install_nuclei
    install_subfinder
    install_gau
    install_urldedupe
    install_waybackurls
    install_gf
    install_sqlmap
    install_dalfox
    install_gobuster
    install_wpscan
    install_amass
    install_nmap
    install_zaproxy
    ;;
  *)
    echo -e "${RED}Yanlış seçim.${NC}"
    ;;
esac

echo -e "${GREEN}Skript tamamlandı!${NC}"
