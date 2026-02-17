#!/bin/bash
clear
echo "Installing NyxRecon V10..."

# update termux
pkg update -y && pkg upgrade -y

# basic tools
pkg install git wget curl python golang -y

# create folder
mkdir -p $HOME/NyxRecon
cd $HOME/NyxRecon

echo "[+] Downloading NyxRecon engine..."
wget https://raw.githubusercontent.com/zen-studi/nyxrepo/main/nyxrecon.sh

chmod +x nyxrecon.sh

# move to bin so can run globally
mv nyxrecon.sh $PREFIX/bin/nyxrecon

echo "[✓] NyxRecon installed successfully!"
echo ""
echo "Run command:"
echo "nyxrecon install"
