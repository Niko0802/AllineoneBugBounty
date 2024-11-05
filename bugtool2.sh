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
echo "8. Hamısı (Bütün alətlər)"

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
    echo "Bütün alətlər yüklənir..."
    install_katana
    install_nuclei
    install_subfinder
    install_gau
    install_urldedupe
    install_waybackurls
    install_gf
    echo "Bütün alətlər uğurla quraşdırıldı."
    ;;
  *)
    echo "Yanlış seçim etdiniz. Zəhmət olmasa düzgün nömrəni daxil edin."
    ;;
esac

echo "Skript tamamlandı!"
