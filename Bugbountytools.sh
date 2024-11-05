#!/bin/bash

# Rəng kodları
RED='\e[31m'
GREEN='\e[32m'
NC='\e[0m' # Normal rəng

# Katana alətinin quraşdırılması
install_katana() {
  if command -v katana > /dev/null; then
    echo -e "${GREEN}Katana artıq yüklüdür.${NC}"
  else
    echo -e "${RED}Katana yüklənir...${NC}"
    
    # Katana alətini Go vasitəsilə quraşdırırıq
    go install github.com/projectdiscovery/katana/cmd/katana@latest

    # Katana alətini /usr/local/bin/ qovluğuna köçürürük
    sudo cp ~/go/bin/katana /usr/local/bin/

    # Yüklənmə uğurlu oldu mesajı
    echo -e "${GREEN}Katana uğurla quraşdırıldı.${NC}"
  fi
}

# Nuclei alətinin quraşdırılması və yenilənməsi
install_nuclei() {
  if command -v nuclei > /dev/null; then
    echo -e "${GREEN}Nuclei artıq yüklüdür.${NC}"
  else
    echo -e "${RED}Nuclei yüklənir...${NC}"
    
    # Nuclei alətini Go vasitəsilə quraşdırırıq
    go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest

    # Nuclei alətini /usr/local/bin/ qovluğuna köçürürük
    sudo cp ~/go/bin/nuclei /usr/local/bin/

    # Yüklənmə uğurlu oldu mesajı
    echo -e "${GREEN}Nuclei uğurla quraşdırıldı.${NC}"
    
    # Nuclei alətini yeniləyirik
    sudo nuclei -up
  fi
}

# WPScan alətinin quraşdırılması
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

# Amass alətinin quraşdırılması
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

# Nmap alətinin quraşdırılması
install_nmap() {
  if command -v nmap > /dev/null; then
    echo -e "${GREEN}Nmap artıq yüklüdür.${NC}"
  else
    echo -e "${RED}Nmap yüklənir...${NC}"
    sudo snap install nmap
    echo -e "${GREEN}Nmap quraşdırıldı.${NC}"
  fi
}

# ZAP Proxy alətinin quraşdırılması
install_zaproxy() {
  if command -v zaproxy > /dev/null; then
    echo -e "${GREEN}ZAP artıq yüklüdür.${NC}"
  else
    echo -e "${RED}ZAP yüklənir...${NC}"
    sudo snap install zaproxy --classic
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
