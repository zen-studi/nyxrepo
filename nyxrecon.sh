#!/data/data/com.termux/files/usr/bin/bash

banner(){
clear
echo "================================="
echo "          NYXRECON V11"
echo "   Lightweight Recon Toolkit"
echo "================================="
}

recon_lite(){
echo "[+] Target: $target"
mkdir -p nyx_$target
cd nyx_$target

echo "[+] Finding subdomains..."
subfinder -d $target -silent > subdomains.txt

echo "[+] Checking live hosts..."
cat subdomains.txt | httpx -silent > live.txt

echo "[+] Collecting URLs..."
cat live.txt | gau > urls.txt
cat live.txt | waybackurls >> urls.txt

sort -u urls.txt -o urls.txt
echo "[✓] Recon Lite finished!"
}

recon_deep(){
echo "[+] Running deep recon..."
nmap -T4 -F $target > ports.txt
echo "[✓] Port scan saved!"
}

js_finder(){
echo "[+] Extracting JS files..."
grep "\.js" urls.txt | sort -u > js.txt
echo "[✓] JS files saved!"
}

param_finder(){
echo "[+] Finding parameters..."
grep "=" urls.txt | sort -u > params.txt
echo "[✓] Parameters saved!"
}

sensitive_finder(){
echo "[+] Searching sensitive files..."
grep -Ei "admin|login|dashboard|backup|.env|config" urls.txt > sensitive.txt
echo "[✓] Sensitive paths saved!"
}

open_redirect(){
echo "[+] Searching open redirect candidates..."
grep -Ei "redirect=|url=|next=|return=" urls.txt > redirect_candidates.txt
echo "[✓] Open redirect candidates saved!"
}

ssrf_candidates(){
echo "[+] Searching SSRF candidates..."
grep -Ei "url=|dest=|uri=" urls.txt > ssrf_candidates.txt
echo "[✓] SSRF candidates saved!"
}

xss_candidates(){
echo "[+] Searching XSS candidates..."
grep "=" urls.txt > xss_candidates.txt
echo "[✓] XSS candidates saved!"
}

menu(){
banner
echo "1) Recon Lite"
echo "2) Recon Deep (Port Scan)"
echo "3) JS Finder"
echo "4) Parameter Finder"
echo "5) Sensitive Finder"
echo "6) Open Redirect Finder"
echo "7) SSRF Finder"
echo "8) XSS Candidate Finder"
echo "9) Full Auto Recon"
echo "0) Exit"
read -p "Select: " opt

case $opt in
1) read -p "Target: " target; recon_lite ;;
2) read -p "Target: " target; recon_deep ;;
3) js_finder ;;
4) param_finder ;;
5) sensitive_finder ;;
6) open_redirect ;;
7) ssrf_candidates ;;
8) xss_candidates ;;
9) 
read -p "Target: " target
recon_lite
recon_deep
js_finder
param_finder
sensitive_finder
open_redirect
ssrf_candidates
xss_candidates
echo "[✓] FULL RECON DONE!"
;;
0) exit ;;
*) echo "Invalid" ;;
esac
}

menu
