#!/bin/bash

RESULT=$HOME/NyxRecon/result
mkdir -p $RESULT

banner(){
echo "================================="
echo "        NYXRECON V10"
echo "   Lightweight Recon Toolkit"
echo "================================="
}

install_deps(){
echo "[+] Installing recon tools..."

pkg install python git curl wget -y

pip install requests uro

go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install github.com/projectdiscovery/httpx/cmd/httpx@latest
go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install github.com/tomnomnom/assetfinder@latest
go install github.com/lc/gau/v2/cmd/gau@latest
go install github.com/tomnomnom/waybackurls@latest

echo "[✓] Dependencies installed"
}

scan(){
domain=$1
mode=$2

banner
echo "[+] Target: $domain"
echo "[+] Mode: $mode"

echo "[+] Finding subdomains..."
subfinder -d $domain -silent > $RESULT/subdomains.txt
assetfinder --subs-only $domain >> $RESULT/subdomains.txt
sort -u $RESULT/subdomains.txt -o $RESULT/subdomains.txt

echo "[+] Checking live hosts..."
cat $RESULT/subdomains.txt | httpx -silent > $RESULT/live.txt

echo "[+] Collecting URLs..."
cat $RESULT/live.txt | gau > $RESULT/urls.txt
cat $RESULT/live.txt | waybackurls >> $RESULT/urls.txt
sort -u $RESULT/urls.txt -o $RESULT/urls.txt

echo "[+] Extracting parameters..."
grep "=" $RESULT/urls.txt > $RESULT/params.txt

echo "[+] Running nuclei..."
nuclei -l $RESULT/live.txt -silent > $RESULT/nuclei.txt

echo "[✓] Scan complete!"
echo "Results: ~/NyxRecon/result"
}

case $1 in
install) install_deps ;;
scan) scan $2 $3 ;;
*) banner ;;
esac
