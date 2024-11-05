#!/bin/bash

# Qırmızı rəng kodu
RED='\e[31m'
NC='\e[0m' # No Color (default rəngə qaytarmaq)

# Alətlərin endiriləcəyi qovluq
TOOLS_DIR="$HOME/tools"
mkdir -p $TOOLS_DIR

# Go dili yüklənməyibsə, Go yükləyin
if ! [ -x "$(command -v go)" ]; then
  echo -e "${RED}Go yüklənməmişdir. Yüklənir...${NC}"
  wget https://go.dev/dl/go1.21.1.linux-amd64.tar.gz
  sudo tar -C /usr/local -xzf go1.21.1.linux-amd64.tar.gz
  export PATH=$PATH:/usr/local/go/bin
  echo -e "${RED}Go uğurla yükləndi.${NC}"
else
  echo "Go artıq mövcuddur."
fi

# GOPATH qurun
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Alətlərin siyahısını göstərmək
echo -e "${RED}Yüklənəcək alətlər siyahısı:${NC}"
echo -e "${RED}1. Katana${NC}"
echo -e "${RED}2. Nuclei${NC}"
echo -e "${RED}3. Subfinder${NC}"
echo -e "${RED}4. gau${NC}"
echo -e "${RED}5. urldedupe${NC}"
echo -e "${RED}6. waybackurls${NC}"
echo -e "${RED}7. gf${NC}"
echo -e "${RED}8. SQLMap${NC}"
echo -e "${RED}9. Dalfox${NC}"
echo -e "${RED}10. Dirsearch${NC}"
echo -e "${RED}11. Hydra${NC}"
echo -e "${RED}12. Hashcat${NC}"
echo -e "${RED}13. WPScan${NC}"
echo -e "${RED}14. Amass${NC}"
echo -e "${RED}15. ZAP (OWASP ZAP Proxy)${NC}"
echo -e "${RED}16. Nmap${NC}"
echo -e "${RED}17. Loxs${NC}"
echo -e "${RED}18. Hamısı (Bütün alətlər)${NC}"

read -p "Endirmək istədiyiniz alətin nömrəsini daxil edin: " tool_choice

# Alətlərin yükləmə funksiyaları
install_katana() {
  echo -e "${RED}Katana yüklənir...${NC}"
  cd $TOOLS_DIR
  git clone https://github.com/projectdiscovery/katana.git
  cd katana/cmd/katana
  go build
  sudo cp katana /usr/local/bin/
  echo -e "${RED}Katana quraşdırıldı.${NC}"
}

install_nuclei() {
  echo -e "${RED}Nuclei yüklənir...${NC}"
  cd $TOOLS_DIR
  git clone https://github.com/projectdiscovery/nuclei.git
  cd nuclei/v2/cmd/nuclei
  go build
  sudo cp nuclei /usr/local/bin/
  echo -e "${RED}Nuclei quraşdırıldı.${NC}"
}

install_subfinder() {
  echo -e "${RED}Subfinder yüklənir...${NC}"
  cd $TOOLS_DIR
  git clone https://github.com/projectdiscovery/subfinder.git
  cd subfinder/v2/cmd/subfinder
  go build
  sudo cp subfinder /usr/local/bin/
  echo -e "${RED}Subfinder quraşdırıldı.${NC}"
}

install_gau() {
  echo -e "${RED}gau yüklənir...${NC}"
  cd $TOOLS_DIR
  go install github.com/lc/gau/v2/cmd/gau@latest
  sudo cp $GOPATH/bin/gau /usr/local/bin/
  echo -e "${RED}gau quraşdırıldı.${NC}"
}

install_urldedupe() {
  echo -e "${RED}urldedupe yüklənir...${NC}"
  cd $TOOLS_DIR
  go install github.com/lc/urldedupe/cmd/urldedupe@latest
  sudo cp $GOPATH/bin/urldedupe /usr/local/bin/
  echo -e "${RED}urldedupe quraşdırıldı.${NC}"
}

install_waybackurls() {
  echo -e "${RED}waybackurls yüklənir...${NC}"
  cd $TOOLS_DIR
  go install github.com/tomnomnom/waybackurls@latest
  sudo cp $GOPATH/bin/waybackurls /usr/local/bin/
  echo -e "${RED}waybackurls quraşdırıldı.${NC}"
}

install_gf() {
  echo -e "${RED}gf yüklənir...${NC}"
  cd $TOOLS_DIR
  go install github.com/tomnomnom/gf@latest
  sudo cp $GOPATH/bin/gf /usr/local/bin/
  echo -e "${RED}gf quraşdırıldı.${NC}"
  
  echo -e "${RED}gf pattern-ləri yüklənir...${NC}"
  mkdir -p $HOME/.gf
  git clone https://github.com/NitinYadav00/gf-patterns.git $HOME/.gf/Gf-Patterns
  cp $HOME/.gf/Gf-Patterns/*.json $HOME/.gf/
  echo -e "${RED}gf pattern-lər uğurla quraşdırıldı.${NC}"
}

install_sqlmap() {
  echo -e "${RED}SQLMap yüklənir...${NC}"
  sudo snap install sqlmap
  if [ $? -ne 0 ]; then
    echo "SQLMap yüklənmədi, --classic rejimində yüklənir..."
    sudo snap install sqlmap --classic
  fi
  echo -e "${RED}SQLMap uğurla quraşdırıldı.${NC}"
}

install_dalfox() {
  echo -e "${RED}Dalfox yüklənir...${NC}"
  cd $TOOLS_DIR
  go install github.com/hahwul/dalfox/v2@latest
  sudo cp $GOPATH/bin/dalfox /usr/local/bin/
  echo -e "${RED}Dalfox quraşdırıldı.${NC}"
}

install_dirsearch() {
  echo -e "${RED}Dirsearch yüklənir...${NC}"
  cd $TOOLS_DIR
  git clone https://github.com/maurosoria/dirsearch.git
  sudo ln -s $TOOLS_DIR/dirsearch/dirsearch.py /usr/local/bin/dirsearch
  echo -e "${RED}Dirsearch quraşdırıldı.${NC}"
}

install_hydra() {
  echo -e "${RED}Hydra yüklənir...${NC}"
  sudo apt-get install -y hydra
  echo -e "${RED}Hydra quraşdırıldı.${NC}"
}

install_hashcat() {
  echo -e "${RED}Hashcat yüklənir...${NC}"
  sudo apt-get install -y hashcat
  echo -e "${RED}Hashcat quraşdırıldı.${NC}"
}

install_wpscan() {
  echo -e "${RED}WPScan yüklənir...${NC}"
  sudo apt-get install -y ruby ruby-dev
  sudo gem install wpscan
  echo -e "${RED}WPScan quraşdırıldı.${NC}"
}

install_amass() {
  echo -e "${RED}Amass yüklənir...${NC}"
  sudo apt-get install -y amass
  echo -e "${RED}Amass quraşdırıldı.${NC}"
}

install_zaproxy() {
  echo -e "${RED}ZAP yüklənir...${NC}"
  sudo snap install zaproxy
  if [ $? -ne 0 ]; then
    echo "ZAP yüklənmədi, --classic rejimində yüklənir..."
    sudo snap install zaproxy --classic
  fi
  echo -e "${RED}ZAP uğurla quraşdırıldı.${NC}"
}

install_nmap() {
  echo -e "${RED}Nmap yüklənir...${NC}"
  sudo apt-get install -y nmap
  echo -e "${RED}Nmap quraşdırıldı.${NC}"
}

install_loxs() {
  echo -e "${RED}Loxs yüklənir...${NC}"
  cd $TOOLS_DIR
  git clone https://github.com/coffinxp/loxs.git
  cd loxs
  if ! [ -x "$(command -v pip3)" ]; then
    echo -e "${RED}pip3 yüklənməmişdir. Yüklənir...${NC}"
    sudo apt-get install -y python3-pip
  fi
  pip3 install -r requirements.txt
  echo -e "${RED}Loxs quraşdırıldı.${NC}"
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
    install_dirsearch
    ;;
  11)
    install_hydra
    ;;
  12)
    install_hashcat
    ;;
  13)
    install_wpscan
    ;;
  14)
    install_amass
    ;;
  15)
    install_zaproxy
    ;;
  16)
    install_nmap
    ;;
  17)
    install_loxs
    ;;
  18)
    echo -e "${RED}Bütün alətlər yüklənir...${NC}"
    install_katana
    install_nuclei
    install_subfinder
    install_gau
    install_urldedupe
    install_waybackurls
    install_gf
    install_sqlmap
    install_dalfox
    install_dirsearch
    install_hydra
    install_hashcat
    install_wpscan
    install_amass
    install_zaproxy
    install_nmap
    install_loxs
    ;;
  *)
    echo -e "${RED}Yanlış seçim.${NC}"
    ;;
esac
