#!/bin/bash

# Rəng kodları
RED='\e[31m'
GREEN='\e[32m'
NC='\e[0m' # Normal rəng

# Alətlərin endiriləcəyi qovluq
TOOLS_DIR="$HOME/tools"
mkdir -p $TOOLS_DIR

# Sistem paketlərini güncəlləyin
echo -e "${RED}Sistem paketləri güncəllənir...${NC}"
sudo apt-get update && sudo apt-get upgrade -y

# Go yüklənməyibsə, Go yükləyin
if ! [ -x "$(command -v go)" ]; then
  echo -e "${RED}Go yüklənməmişdir. Yüklənir...${NC}"
  sudo apt-get install snapd -y # snap yoxdursa, snap quraşdırılır
  sudo snap install go --classic || sudo apt install golang-go -y
  echo -e "${GREEN}Go uğurla yükləndi.${NC}"
else
  echo -e "${GREEN}Go artıq mövcuddur.${NC}"
fi

# GOPATH qurun
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Alətlərin siyahısını göstərin
declare -A tools
tools=( ["1"]="katana" ["2"]="nuclei" ["3"]="subfinder" ["4"]="gau" ["5"]="waybackurls" ["6"]="gf" ["7"]="sqlmap" ["8"]="dalfox" ["9"]="gobuster" ["10"]="amass" ["11"]="nmap" ["12"]="zaproxy" ["13"]="Hamısı" )

echo -e "${RED}Yüklənəcək alətlər siyahısı:${NC}"
for key in "${!tools[@]}"; do
  echo -e "$key. ${tools[$key]}"
done

# İstifadəçidən alət seçimi alınır
read -p "Endirmək istədiyiniz alətin nömrəsini daxil edin (1-13): " tool_choice

# Alətlərin yüklənməsi
install_tool() {
  local tool_name=$1
  if command -v $tool_name > /dev/null; then
    echo -e "${GREEN}$tool_name artıq yüklüdür.${NC}"
  else
    echo -e "${RED}$tool_name yüklənir...${NC}"
    case $tool_name in
      katana)
        go install github.com/projectdiscovery/katana/cmd/katana@latest
        ;;
      nuclei)
        go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
        sudo cp $GOPATH/bin/nuclei /usr/local/bin/
        echo -e "${GREEN}Nuclei uğurla quraşdırıldı.${NC}"
        nuclei
        sudo nuclei -up
        ;;
      subfinder)
        go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
        ;;
      gau)
        go install github.com/lc/gau/v2/cmd/gau@latest
        ;;
      waybackurls)
        go install github.com/tomnomnom/waybackurls@latest
        ;;
      gf)
        go install github.com/tomnomnom/gf@latest
        mkdir -p $HOME/.gf
        git clone https://github.com/NitinYadav00/gf-patterns.git $HOME/.gf/Gf-Patterns
        cp $HOME/.gf/Gf-Patterns/*.json $HOME/.gf/
        ;;
      sqlmap)
        sudo snap install sqlmap --classic
        ;;
      dalfox)
        go install github.com/hahwul/dalfox/v2@latest
        ;;
      gobuster)
        go install github.com/OJ/gobuster/v3@latest
        ;;
      amass)
        go install github.com/OWASP/Amass/v3/...@master
        ;;
      nmap)
        sudo snap install nmap
        ;;
      zaproxy)
        sudo snap install zaproxy --classic
        ;;
      *)
        echo -e "${RED}Yanlış seçim.${NC}"
        return
        ;;
    esac
    sudo cp $GOPATH/bin/$tool_name /usr/local/bin/
    echo -e "${GREEN}$tool_name uğurla quraşdırıldı.${NC}"
  fi
}

# Seçim əsasında müvafiq alət yüklənir
case $tool_choice in
  1) install_tool "katana" ;;
  2) install_tool "nuclei" ;;
  3) install_tool "subfinder" ;;
  4) install_tool "gau" ;;
  5) install_tool "waybackurls" ;;
  6) install_tool "gf" ;;
  7) install_tool "sqlmap" ;;
  8) install_tool "dalfox" ;;
  9) install_tool "gobuster" ;;
  10) install_tool "amass" ;;
  11) install_tool "nmap" ;;
  12) install_tool "zaproxy" ;;
  13)
    for tool in "${tools[@]}"; do
      install_tool "$tool"
    done
    ;;
  *) echo -e "${RED}Yanlış seçim.${NC}" ;;
esac

echo -e "${GREEN}Skript tamamlandı!${NC}"
