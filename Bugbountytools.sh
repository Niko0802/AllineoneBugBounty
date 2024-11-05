#!/bin/bash

# Alətlərin endiriləcəyi qovluq
TOOLS_DIR="$HOME/tools"
mkdir -p $TOOLS_DIR

# Go dili yüklənməyibsə, Go yükləyin
if ! [ -x "$(command -v go)" ]; then
  echo "Go yüklənməmişdir. Yüklənir..."
  wget https://go.dev/dl/go1.21.1.linux-amd64.tar.gz
  sudo tar -C /usr/local -xzf go1.21.1.linux-amd64.tar.gz
  export PATH=$PATH:/usr/local/go/bin
  echo "Go uğurla yükləndi."
else
  echo "Go artıq mövcuddur."
fi

# GOPATH qurun
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Alətlərin siyahısını göstərmək
echo "Yüklənəcək alətlər siyahısı:"
echo "1. Katana"
echo "2. Nuclei"
echo "3. Subfinder"
echo "4. gau"
echo "5. urldedupe"
echo "6. waybackurls"
echo "7. gf"
echo "8. SQLMap"
echo "9. Dalfox"
echo "10. Dirsearch"
echo "11. Hydra"
echo "12. Hashcat"
echo "13. WPScan"
echo "14. Amass"
echo "15. ZAP (OWASP ZAP Proxy)"
echo "16. Hamısı (Bütün alətlər)"

read -p "Endirmək istədiyiniz alətin nömrəsini daxil edin: " tool_choice

# Alətlərin yükləmə funksiyaları
install_katana() {
  echo "Katana yüklənir..."
  cd $TOOLS_DIR
  git clone https://github.com/projectdiscovery/katana.git
  cd katana/cmd/katana
  go build
  sudo cp katana /usr/local/bin/
  echo "Katana quraşdırıldı."
}

install_nuclei() {
  echo "Nuclei yüklənir..."
  cd $TOOLS_DIR
  git clone https://github.com/projectdiscovery/nuclei.git
  cd nuclei/v2/cmd/nuclei
  go build
  sudo cp nuclei /usr/local/bin/
  echo "Nuclei quraşdırıldı."
}

install_subfinder() {
  echo "Subfinder yüklənir..."
  cd $TOOLS_DIR
  git clone https://github.com/projectdiscovery/subfinder.git
  cd subfinder/v2/cmd/subfinder
  go build
  sudo cp subfinder /usr/local/bin/
  echo "Subfinder quraşdırıldı."
}

install_gau() {
  echo "gau yüklənir..."
  cd $TOOLS_DIR
  go install github.com/lc/gau/v2/cmd/gau@latest
  sudo cp $GOPATH/bin/gau /usr/local/bin/
  echo "gau quraşdırıldı."
}

install_urldedupe() {
  echo "urldedupe yüklənir..."
  cd $TOOLS_DIR
  go install github.com/lc/urldedupe/cmd/urldedupe@latest
  sudo cp $GOPATH/bin/urldedupe /usr/local/bin/
  echo "urldedupe quraşdırıldı."
}

install_waybackurls() {
  echo "waybackurls yüklənir..."
  cd $TOOLS_DIR
  go install github.com/tomnomnom/waybackurls@latest
  sudo cp $GOPATH/bin/waybackurls /usr/local/bin/
  echo "waybackurls quraşdırıldı."
}

install_gf() {
  echo "gf yüklənir..."
  cd $TOOLS_DIR
  go install github.com/tomnomnom/gf@latest
  sudo cp $GOPATH/bin/gf /usr/local/bin/
  echo "gf quraşdırıldı."
  
  echo "gf pattern-ləri yüklənir..."
  mkdir -p $HOME/.gf
  git clone https://github.com/1ndianl33t/Gf-Patterns $HOME/.gf/Gf-Patterns
  cp $HOME/.gf/Gf-Patterns/*.json $HOME/.gf/
  echo "gf pattern-lər uğurla quraşdırıldı."
}

install_sqlmap() {
  echo "Snap vasitəsilə SQLMap yüklənir..."
  sudo snap install sqlmap
  if [ $? -ne 0 ]; then
    echo "SQLMap yüklənmədi, --classic rejimində yüklənir..."
    sudo snap install sqlmap --classic
  fi
  echo "SQLMap uğurla quraşdırıldı."
}

install_dalfox() {
  echo "Dalfox yüklənir..."
  cd $TOOLS_DIR
  go install github.com/hahwul/dalfox/v2@latest
  sudo cp $GOPATH/bin/dalfox /usr/local/bin/
  echo "Dalfox quraşdırıldı."
}

install_dirsearch() {
  echo "Dirsearch yüklənir..."
  cd $TOOLS_DIR
  git clone https://github.com/maurosoria/dirsearch.git
  sudo ln -s $TOOLS_DIR/dirsearch/dirsearch.py /usr/local/bin/dirsearch
  echo "Dirsearch quraşdırıldı."
}

install_hydra() {
  echo "Hydra yüklənir..."
  sudo apt-get install -y hydra
  echo "Hydra quraşdırıldı."
}

install_hashcat() {
  echo "Hashcat yüklənir..."
  sudo apt-get install -y hashcat
  echo "Hashcat quraşdırıldı."
}

install_wpscan() {
  echo "WPScan yüklənir..."
  sudo apt-get install -y ruby ruby-dev
  sudo gem install wpscan
  echo "WPScan quraşdırıldı."
}

install_amass() {
  echo "Amass yüklənir..."
  sudo apt-get install -y amass
  echo "Amass quraşdırıldı."
}

install_zaproxy() {
  echo "Snap vasitəsilə ZAP yüklənir..."
  sudo snap install zaproxy
  if [ $? -ne 0 ]; then
    echo "ZAP yüklənmədi, --classic rejimində yüklənir..."
    sudo snap install zaproxy --classic
  fi
  echo "ZAP uğurla quraşdırıldı."
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
    echo "Bütün alətlər yüklənir..."
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
    echo "Bütün alətlər uğurla quraşdırıldı."
    ;;
  *)
    echo "Yanlış seçim etdiniz. Zəhmət olmasa düzgün nömrəni daxil edin."
    ;;
esac

echo "Skript tamamlandı!"
