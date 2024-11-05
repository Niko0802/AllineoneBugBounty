#!/bin/bash

# Rəng kodları
RED='\e[31m'
GREEN='\e[32m'
NC='\e[0m' # Normal rəng

# Alətlərin endiriləcəyi qovluq
TOOLS_DIR="$HOME/tools"
mkdir -p $TOOLS_DIR

# Snap varsa Go yükləmək
install_go() {
  if ! [ -x "$(command -v snap)" ]; then
    echo -e "${RED}Snap yüklənməmişdir, yüklənir...${NC}"
    sudo apt update
    sudo apt install snapd -y
  fi

  echo -e "${RED}Go yüklənir...${NC}"
  sudo snap install go --classic
  echo -e "${GREEN}Go uğurla yükləndi.${NC}"
}

# Go dili yüklənməyibsə, Go yükləyin
if ! [ -x "$(command -v go)" ]; then
  install_go
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
echo -e "${RED}15. Nmap${NC}"
echo -e "${RED}16. Loxs${NC}"
echo -e "${RED}17. ZAP (OWASP ZAP Proxy)${NC}"
echo -e "${RED}18. Hamısı (Bütün alətlər)${NC}"

read -p "Endirmək istədiyiniz alətin nömrəsini daxil edin: " tool_choice

# Alətlərin yükləmə funksiyaları
install_katana() {
  if command -v katana > /dev/null; then
    echo -e "${GREEN}Katana artıq yüklüdür.${NC}"
  else
    echo -e "${RED}Katana yüklənir...${NC}"
    go install github.com/projectdiscovery/katana/cmd/katana@latest
    sudo cp $GOPATH/bin/katana /usr/local/bin/
    echo -e "${GREEN}Katana quraşdırıldı.${NC}"
  fi
}

install_nuclei() {
  if command -v nuclei > /dev/null; then
    echo -e "${GREEN}Nuclei artıq yüklüdür.${NC}"
  else
    echo -e "${RED}Nuclei yüklənir...${NC}"
    go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
    sudo cp $GOPATH/bin/nuclei /usr/local/bin/
    echo -e "${GREEN}Nuclei quraşdırıldı.${NC}"
  fi
}

install_subfinder() {
  if command -v subfinder > /dev/null; then
    echo -e "${GREEN}Subfinder artıq yüklüdür.${NC}"
  else
    echo -e "${RED}Subfinder yüklənir...${NC}"
    cd $TOOLS_DIR
    git clone https://github.com/projectdiscovery/subfinder.git
    cd subfinder/v2/cmd/subfinder
    go build
    sudo cp subfinder /usr/local/bin/
    echo -e "${GREEN}Subfinder quraşdırıldı.${NC}"
  fi
}

install_gau() {
  if command -v gau > /dev/null; then
    echo -e "${GREEN}gau artıq yüklüdür.${NC}"
  else
    echo -e "${RED}gau yüklənir...${NC}"
    cd $TOOLS_DIR
    go install github.com/lc/gau/v2/cmd/gau@latest
    sudo cp $GOPATH/bin/gau /usr/local/bin/
    echo -e "${GREEN}gau quraşdırıldı.${NC}"
  fi
}

install_urldedupe() {
  if command -v urldedupe > /dev/null; then
    echo -e "${GREEN}urldedupe artıq yüklüdür.${NC}"
  else
    echo -e "${RED}urldedupe yüklənir...${NC}"
    cd $TOOLS_DIR
    go install github.com/lc/urldedupe/cmd/urldedupe@latest
    sudo cp $GOPATH/bin/urldedupe /usr/local/bin/
    echo -e "${GREEN}urldedupe quraşdırıldı.${NC}"
  fi
}

install_waybackurls() {
  if command -v waybackurls > /dev/null; then
    echo -e "${GREEN}waybackurls artıq yüklüdür.${NC}"
  else
    echo -e "${RED}waybackurls yüklənir...${NC}"
    cd $TOOLS_DIR
    go install github.com/tomnomnom/waybackurls@latest
    sudo cp $GOPATH/bin/waybackurls /usr/local/bin/
    echo -e "${GREEN}waybackurls quraşdırıldı.${NC}"
  fi
}

install_gf() {
  if command -v gf > /dev/null; then
    echo -e "${GREEN}gf artıq yüklüdür.${NC}"
  else
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
  fi
}

install_sqlmap() {
  if command -v sqlmap > /dev/null; then
    echo -e "${GREEN}SQLMap artıq yüklüdür.${NC}"
  else
    echo -e "${RED}SQLMap yüklənir...${NC}"
    sudo snap install sqlmap
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
    echo -e "${GREEN}Dalfox quraşdırıldı.${NC}"
  fi
}

install_gobuster() {
  if command -v gobuster > /dev/null; then
    echo -e "${GREEN}Gobuster artıq yüklüdür.${NC}"
  else
    echo -e "${RED}Gobuster yüklənir...${NC}"
    go install github.com/OJ/gobuster/v3@latest
    sudo cp $GOPATH/bin/gobuster /usr/local/bin/
    echo -e "${GREEN}Gobuster quraşdırıldı.${NC}"
  fi
}

install_hydra() {
  if command -v hydra > /dev/null; then
    echo -e "${GREEN}Hydra artıq yüklüdür.${NC}"
  else
    echo -e "${RED}Hydra yüklənir...${NC}"
    sudo apt-get install hydra -y
    echo -e "${GREEN}Hydra quraşdırıldı.${NC}"
  fi
}

install_hashcat() {
  if command -v hashcat > /dev/null; then
    echo -e "${GREEN}Hashcat artıq yüklüdür.${NC}"
  else
    echo -e "${RED}Hashcat yüklənir...${NC}"
    sudo apt-get install hashcat -y
    echo -e "${GREEN}Hashcat quraşdırıldı.${NC}"
  fi
}

install_wpscan() {
  if command -v wpscan > /dev/null; then
    echo -e "${GREEN}WPScan artıq yüklüdür.${NC}"
  else
    echo -e "${RED}WPScan yüklənir...${NC}"
    sudo apt-get install ruby ruby-dev -y
    sudo gem install wpscan -y
    echo -e "${GREEN}WPScan quraşdırıldı.${NC}"
  fi
}

install_amass() {
  if command -v amass > /dev/null; then
    echo -e "${GREEN}Amass artıq yüklüdür.${NC}"
  else
    echo -e "${RED}Amass yüklənir...${NC}"
    go install github.com/OWASP/Amass/v3/...@latest
    sudo cp $GOPATH/bin/amass /usr/local/bin/
    echo -e "${GREEN}Amass quraşdırıldı.${NC}"
  fi
}

install_nmap() {
  if command -v nmap > /dev/null; then
    echo -e "${GREEN}Nmap artıq yüklüdür.${NC}"
  else
    echo -e "${RED}Nmap yüklənir...${NC}"
    sudo snap install nmap
    echo -e "${GREEN}Nmap quraşdırıldı.${NC}"
  fi
}

install_loxs() {
  if command -v loxs > /dev/null; then
    echo -e "${GREEN}Loxs artıq yüklüdür.${NC}"
  else
    echo -e "${RED}Loxs yüklənir...${NC}"
    cd $TOOLS_DIR
    git clone https://github.com/coffinxp/loxs.git
    cd loxs
    echo -e "${GREEN}Loxs yükləndi. Quraşdırma tamamlanır...${NC}"
    echo -e "${RED}Quraşdırılır...${NC}"
    pip3 install -r requirements.txt
    echo -e "${GREEN}Loxs quraşdırıldı.${NC}"
  fi
}

install_zaproxy() {
  if command -v zaproxy > /dev/null; then
    echo -e "${GREEN}ZAP artıq yüklüdür.${NC}"
  else
    echo -e "${RED}ZAP yüklənir...${NC}"
    sudo snap install zaproxy
    echo -e "${GREEN}ZAP quraşdırıldı.${NC}"
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
    install_nmap
    ;;
  16)
    install_loxs
    ;;
  17)
    install_zaproxy
    ;;
  18)
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
    install_hydra
    install_hashcat
    install_wpscan
    install_amass
    install_nmap
    install_loxs
    install_zaproxy
    ;;
  *)
    echo -e "${RED}Yanlış seçim.${NC}"
    ;;
esac

echo -e "${GREEN}Skript tamamlandı!${NC}"
