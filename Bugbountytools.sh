#!/bin/bash

# Rəng kodları
RED='\e[31m'
GREEN='\e[32m'
NC='\e[0m' # Normal rəng

# Alətlərin endiriləcəyi qovluq
TOOLS_DIR="$HOME/tools"
mkdir -p $TOOLS_DIR

# Go dili yüklənməyibsə, Go yükləyin
if ! [ -x "$(command -v go)" ]; then
  echo -e "${RED}Go yüklənməmişdir. Yüklənir...${NC}"
  wget https://go.dev/dl/go1.21.1.linux-amd64.tar.gz
  sudo tar -C /usr/local -xzf go1.21.1.linux-amd64.tar.gz
  export PATH=$PATH:/usr/local/go/bin
  echo -e "${GREEN}Go uğurla yükləndi.${NC}"
else
  echo -e "${GREEN}Go artıq mövcuddur.${NC}"
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
echo -e "${RED}10. Gobuster${NC}"
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
  echo -e "${GREEN}Katana quraşdırıldı.${NC}"
}

install_nuclei() {
  echo -e "${RED}Nuclei yüklənir...${NC}"
  cd $TOOLS_DIR
  git clone https://github.com/projectdiscovery/nuclei.git
  cd nuclei/v2/cmd/nuclei
  go build
  sudo cp nuclei /usr/local/bin/
  echo -e "${GREEN}Nuclei quraşdırıldı.${NC}"
}

install_subfinder() {
  echo -e "${RED}Subfinder yüklənir...${NC}"
  cd $TOOLS_DIR
  git clone https://github.com/projectdiscovery/subfinder.git
  cd subfinder/v2/cmd/subfinder
  go build
  sudo cp subfinder /usr/local/bin/
  echo -e "${GREEN}Subfinder quraşdırıldı.${NC}"
}

install_gau() {
  echo -e "${RED}gau yüklənir...${NC}"
  cd $TOOLS_DIR
  go install github.com/lc/gau/v2/cmd/gau@latest
  sudo cp $GOPATH/bin/gau /usr/local/bin/
  echo -e "${GREEN}gau quraşdırıldı.${NC}"
}

install_urldedupe() {
  echo -e "${RED}urldedupe yüklənir...${NC}"
  cd $TOOLS_DIR
  go install github.com/lc/urldedupe/cmd/urldedupe@latest
  sudo cp $GOPATH/bin/urldedupe /usr/local/bin/
  echo -e "${GREEN}urldedupe quraşdırıldı.${NC}"
}

install_waybackurls() {
  echo -e "${RED}waybackurls yüklənir...${NC}"
  cd $TOOLS_DIR
  go install github.com/tomnomnom/waybackurls@latest
  sudo cp $GOPATH/bin/waybackurls /usr/local/bin/
  echo -e "${GREEN}waybackurls quraşdırıldı.${NC}"
}

install_gf() {
  echo -e "${RED}gf yüklənir...${NC}"
  cd $TOOLS_DIR
  go install github.com/tomnomnom/gf@latest
  sudo cp $GOPATH/bin/gf /usr/local/bin/
  echo -e "${GREEN}gf quraşdırıldı.${NC}"
  
  echo -e "${RED}gf pattern-ləri yüklənir...${NC}"
  mkdir -p $HOME/.gf
  git clone https://github.com/NitinYadav00/gf-patterns.git $HOME/.gf/Gf-Patterns
  cp $HOME/.gf/Gf-Patterns/*.json $HOME/.gf/
  echo -e "${GREEN}gf pattern-lər uğurla quraşdırıldı.${NC}"
}

install_sqlmap() {
  echo -e "${RED}SQLMap yüklənir...${NC}"
  sudo snap install sqlmap
  echo -e "${GREEN}SQLMap uğurla quraşdırıldı.${NC}"
}

install_dalfox() {
  echo -e "${RED}Dalfox yüklənir...${NC}"
  go install github.com/hahwul/dalfox/v2@latest
  sudo cp $GOPATH/bin/dalfox /usr/local/bin/
  echo -e "${GREEN}Dalfox quraşdırıldı.${NC}"
}

install_gobuster() {
  echo -e "${RED}Gobuster yüklənir...${NC}"
  go install github.com/OJ/gobuster/v3@latest
  sudo cp $GOPATH/bin/gobuster /usr/local/bin/
  echo -e "${GREEN}Gobuster quraşdırıldı.${NC}"
}

install_hydra() {
  echo -e "${RED}Hydra yüklənir...${NC}"
  sudo apt-get install hydra
  echo -e "${GREEN}Hydra quraşdırıldı.${NC}"
}

install_hashcat() {
  echo -e "${RED}Hashcat yüklənir...${NC}"
  sudo apt-get install hashcat
  echo -e "${GREEN}Hashcat quraşdırıldı.${NC}"
}

install_wpscan() {
  echo -e "${RED}WPScan yüklənir...${NC}"
  sudo apt-get install ruby ruby-dev
  sudo gem install wpscan
  echo -e "${GREEN}WPScan quraşdırıldı.${NC}"
}

install_amass() {
  echo -e "${RED}Amass yüklənir...${NC}"
  sudo snap install amass --classic
  echo -e "${GREEN}Amass quraşdırıldı.${NC}"
}

install_zaproxy() {
  echo -e "${RED}ZAP yüklənir...${NC}"
  sudo snap install zaproxy --classic
  echo -e "${GREEN}ZAP quraşdırıldı.${NC}"
}

install_nmap() {
  echo -e "${RED}Nmap yüklənir...${NC}"
  sudo apt-get install nmap
  echo -e "${GREEN}Nmap quraşdırıldı.${NC}"
}

install_loxs() {
  echo -e "${RED}Loxs yüklənir...${NC}"
  cd $TOOLS_DIR
  git clone https://github.com/coffinxp/loxs.git
  echo -e "${GREEN}Loxs quraşdırıldı.${NC}"
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
