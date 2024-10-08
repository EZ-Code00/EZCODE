#!/bin/bash
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1
function CEKIP () {
MYIP=$(curl -sS ipv4.icanhazip.com)
IPVPS=$(curl -sS https://raw.githubusercontent.com/diah082/izinv1/main/ip | grep $MYIP | awk '{print $4}')
if [[ $MYIP == $IPVPS ]]; then
domain
Pasang
else
  key2
  domain
  Pasang
fi
}
clear
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
cd /root
if [ "${EUID}" -ne 0 ]; then
echo "You need to run this script as root"
exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
echo "OpenVZ is not supported"
exit 1
fi
localip=$(hostname -I | cut -d\  -f1)
hst=( `hostname` )
dart=$(cat /etc/hosts | grep -w `hostname` | awk '{print $2}')
if [[ "$hst" != "$dart" ]]; then
echo "$localip $(hostname)" >> /etc/hosts
fi
secs_to_human() {
echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds"
}
mkdir -p /etc/xray
mkdir -p /var/lib/ >/dev/null 2>&1
echo "IP=" >> /var/lib/ipvps.conf
clear
echo -e  "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e  "${tyblue}│              MASUKKAN NAMA KAMU          │${NC}"
echo -e  "${tyblue}└──────────────────────────────────────────┘${NC}"
echo " "
until [[ $name =~ ^[a-zA-Z0-9_.-]+$ ]]; do
read -rp "Masukan Nama Kamu Disini tanpa spasi : " -e name
done
rm -rf /etc/xray/username
echo "$name" > /etc/xray/username
echo ""
clear
author=$(cat /etc/xray/username)
echo ""
echo ""

function key2(){
clear
echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│ \033[1;37mPlease select a your Choice              ${tyblue}│${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│  [ 1 ]  \033[1;37mTRIAL 1 HARI      ${NC}"
echo -e "${tyblue}│  "                                        
echo -e "${tyblue}│  [ 2 ]  \033[1;37mMEMBER SUDAH BELI     ${NC}"
echo -e "${tyblue}│     "                                     
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
until [[ $key =~ ^[12]+$ ]]; do 
read -p "   Please select numbers 1 atau 2 : " key
done
if [[ $key == "1" ]]; then
MYIP=$(curl -sS ipv4.icanhazip.com)
rm -rf /etc/github
mkdir /etc/github
curl -s https://pastebin.com/raw/6db30eqk > /etc/github/api
curl -s https://pastebin.com/raw/FRQebp6J > /etc/github/email
curl -s https://pastebin.com/raw/92QcnCQJ > /etc/github/username
clear
APIGIT=$(cat /etc/github/api)
EMAILGIT=$(cat /etc/github/email)
USERGIT=$(cat /etc/github/username)
hhari=$(date -d "1 days" +"%Y-%m-%d")
mkdir /root/listip
cd /root/listip
wget https://raw.githubusercontent.com/diah082/izinv1/main/ip >/dev/null 2>&1
echo "### $author $hhari $MYIP @trial" >> listip
sleep 1
git config --global user.email "${EMAILGIT}" >/dev/null 2>&1
git config --global user.name "${USERGIT}" >/dev/null 2>&1
git init >/dev/null 2>&1
git add listip
git commit -m register >/dev/null 2>&1
git branch -M main >/dev/null 2>&1
git remote add origin https://github.com/${USERGIT}/izinv1 >/dev/null 2>&1
git push -f https://${APIGIT}@github.com/${USERGIT}/izinv1 >/dev/null 2>&1
sleep 1
rm -rf /root/listip
rm -rf /etc/github
clear
fi
if [[ $key == "2" ]]; then
clear
echo -e  "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e  "${tyblue}│              MASUKKAN LICENSE KEY        │${NC}"
echo -e  "${tyblue}└──────────────────────────────────────────┘${NC}"
echo " "
read -rp "Masukan Key Kamu Disini (Ctrl + C Exit) : " -e kode

if [ -z $kode ]; then
echo -e "KODE SALAH SILAHKAN MASUKKAN ULANG KODENYA"
key2
cd
if [[ $kode == "NBVIP" ]]; then
MYIP=$(curl -sS ipv4.icanhazip.com)
rm -rf /etc/github
mkdir /etc/github
curl -s https://pastebin.com/raw/6db30eqk > /etc/github/api
curl -s https://pastebin.com/raw/FRQebp6J > /etc/github/email
curl -s https://pastebin.com/raw/92QcnCQJ > /etc/github/username
clear
APIGIT=$(cat /etc/github/api)
EMAILGIT=$(cat /etc/github/email)
USERGIT=$(cat /etc/github/username)
hhari=$(date -d "30 days" +"%Y-%m-%d")
mkdir /root/listip
cd /root/listip
wget https://raw.githubusercontent.com/diah082/izinv1/main/ip >/dev/null 2>&1

echo "### $author $hhari $MYIP @listip" >> ip

sleep 0.5
rm -rf .git
git config --global user.email "${EMAILGIT}" >/dev/null 2>&1
git config --global user.name "${USERGIT}" >/dev/null 2>&1
git init >/dev/null 2>&1
git add ip 
git commit -m register >/dev/null 2>&1
git branch -M main >/dev/null 2>&1
git remote add origin https://github.com/${USERGIT}/izinv1 >/dev/null 2>&1
git push -f https://${APIGIT}@github.com/${USERGIT}/izinv1 >/dev/null 2>&1
sleep 0.5
rm ip
elif [[ $kode == "NBLVIP" ]]; then
MYIP2=$(curl -sS ipv4.icanhazip.com)
author2=$(cat /etc/xray/username)
rm -rf /etc/github
mkdir /etc/github
curl -s https://pastebin.com/raw/6db30eqk > /etc/github/api
curl -s https://pastebin.com/raw/FRQebp6J > /etc/github/email
curl -s https://pastebin.com/raw/92QcnCQJ > /etc/github/username
clear
APIGIT=$(cat /etc/github/api)
EMAILGIT=$(cat /etc/github/email)
USERGIT=$(cat /etc/github/username)
hhari2=$(date -d "999 days" +"%Y-%m-%d")
mkdir /root/listip
cd /root/listip
wget https://raw.githubusercontent.com/diah082/izinv1/main/ip >/dev/null 2>&1

sed -i "/# VIP/a ### ${author2} ${hhari2} ${MYIP2} ON 999 VIP" /root/listip/ip

sleep 0.5
rm -rf .git
git config --global user.email "${EMAILGIT}" >/dev/null 2>&1
git config --global user.name "${USERGIT}" >/dev/null 2>&1
git init >/dev/null 2>&1
git add ip 
git commit -m register >/dev/null 2>&1
git branch -M main >/dev/null 2>&1
git remote add origin https://github.com/${USERGIT}/izinv1 >/dev/null 2>&1
git push -f https://${APIGIT}@github.com/${USERGIT}/izinv1 >/dev/null 2>&1
sleep 0.5
rm ip
elif [[ $kode == "NBRVIP" ]]; then
MYIP3=$(curl -sS ipv4.icanhazip.com)
author3=$(cat /etc/xray/username)
rm -rf /etc/github
mkdir /etc/github
curl -s https://pastebin.com/raw/6db30eqk > /etc/github/api
curl -s https://pastebin.com/raw/FRQebp6J > /etc/github/email
curl -s https://pastebin.com/raw/92QcnCQJ > /etc/github/username
clear
APIGIT=$(cat /etc/github/api)
EMAILGIT=$(cat /etc/github/email)
USERGIT=$(cat /etc/github/username)
hhari3=$(date -d "999 days" +"%Y-%m-%d")
mkdir /root/listip
cd /root/listip
wget https://raw.githubusercontent.com/diah082/izinv1/main/ip >/dev/null 2>&1

sed -i "/# RESELLER/a ### ${author3} ${hhari3} ${MYIP3} ON 999" /root/listip/ip

sleep 0.5
rm -rf .git
git config --global user.email "${EMAILGIT}" >/dev/null 2>&1
git config --global user.name "${USERGIT}" >/dev/null 2>&1
git init >/dev/null 2>&1
git add ip 
git commit -m register >/dev/null 2>&1
git branch -M main >/dev/null 2>&1
git remote add origin https://github.com/${USERGIT}/izinv1 >/dev/null 2>&1
git push -f https://${APIGIT}@github.com/${USERGIT}/izinv1 >/dev/null 2>&1
sleep 0.5
rm ip
clear
else
echo -e "KODE SALAH SILAHKAN MASUKKAN ULANG KODENYA"
sleep 1
key2
fi
fi
fi
}
function domain(){
fun_bar() {
    CMD[0]="$1"
    CMD[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne "  \033[0;33mUpdate Domain.. \033[1;37m- \033[0;33m["
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[0;32m#"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[0;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "  \033[0;33mUpdate Domain... \033[1;37m- \033[0;33m["
    done
    echo -e "\033[0;33m]\033[1;37m -\033[1;32m Succes !\033[1;37m"
    tput cnorm
}
res1() {
wget https://raw.githubusercontent.com/diah082/vip/main/install/pointing.sh && chmod +x pointing.sh && ./pointing.sh
clear
}
clear
cd
echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│ \033[1;37mPlease select a your Choice to Set Domain${tyblue}│${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│  [ 1 ]  \033[1;37mDomain kamu sendiri        ${NC}"
echo -e "${tyblue}│  "                                        
echo -e "${tyblue}│  [ 2 ]  \033[1;37mDomain Yang Punya Script      ${NC}"
#echo -e "${tyblue}│     "                                     
#echo -e "${tyblue}│  [ 3 ]  \033[1;37mDomain Kamu Sendiri & Domain SlowDNS Kamu Sendiri    ${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
until [[ $domain =~ ^[132]+$ ]]; do 
read -p "   Please select numbers 1  atau 2 : " domain
done
if [[ $domain == "1" ]]; then
clear
echo -e  "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e  "${tyblue}│              \033[1;37mTERIMA KASIH                ${tyblue}│${NC}"
echo -e  "${tyblue}│         \033[1;37mSUDAH MENGGUNAKAN SCRIPT         ${tyblue}│${NC}"
echo -e  "${tyblue}│                \033[1;37mDARI SAYA                 ${tyblue}│${NC}"
echo -e  "${tyblue}└──────────────────────────────────────────┘${NC}"
echo " "
until [[ $dnss =~ ^[a-zA-Z0-9_.-]+$ ]]; do 
read -rp "Masukan domain kamu Disini : " -e dnss
done
rm -rf /etc/xray
rm -rf /etc/v2ray
rm -rf /etc/nsdomain
rm -rf /etc/per
mkdir -p /etc/xray
mkdir -p /etc/v2ray
mkdir -p /etc/nsdomain
touch /etc/xray/domain
touch /etc/v2ray/domain
touch /etc/xray/slwdomain
touch /etc/v2ray/scdomain
echo "$dnss" > /root/domain
echo "$dnss" > /root/scdomain
echo "$dnss" > /etc/xray/scdomain
echo "$dnss" > /etc/v2ray/scdomain
echo "$dnss" > /etc/xray/domain
echo "$dnss" > /etc/v2ray/domain
echo "IP=$dnss" > /var/lib/ipvps.conf
echo ""
clear
fi
if [[ $domain == "2" ]]; then
clear
echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│ \033[1;37mPlease select a your Choice to Set Domain${tyblue}│${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│  [ 1 ]  \033[1;37mDomain xxx.server-tunneling.systems          ${NC}"
echo -e "${tyblue}│  [ 2 ]  \033[1;37mDomain xxx.supersaiya.ninja          ${NC}"
echo -e "${tyblue}│  [ 3 ]  \033[1;37mDomain xxx.vpn-premium.my.id          ${NC}"
echo -e "${tyblue}│  [ 4 ]  \033[1;37mDomain xxx.vpn-premium.tech          ${NC}"                                        
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
until [[ $domain2 =~ ^[1-4]+$ ]]; do 
read -p "   Please select numbers 1 sampai 4 : " domain2
done
fi
if [[ $domain2 == "1" ]]; then
clear
echo -e  "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e  "${tyblue}│  \033[1;37mContoh subdomain xxx.newbie-store.my.id        ${tyblue}│${NC}"
echo -e  "${tyblue}│    \033[1;37mxxx jadi subdomain kamu               ${tyblue}│${NC}"
echo -e  "${tyblue}└──────────────────────────────────────────┘${NC}"
echo " "
until [[ $dn1 =~ ^[a-zA-Z0-9_.-]+$ ]]; do
read -rp "Masukan subdomain kamu Disini tanpa spasi : " -e dn1
done
rm -rf /etc/xray
rm -rf /etc/v2ray
rm -rf /etc/nsdomain
rm -rf /etc/per
mkdir -p /etc/xray
mkdir -p /etc/v2ray
mkdir -p /etc/nsdomain
touch /etc/xray/domain
touch /etc/v2ray/domain
touch /etc/xray/slwdomain
touch /etc/v2ray/scdomain
echo "$dn1" > /root/domain
echo "$dn1" > /root/scdomain
echo "$dn1" > /etc/xray/scdomain
echo "$dn1" > /etc/v2ray/scdomain
echo "$dn1" > /etc/xray/domain
echo "$dn1" > /etc/v2ray/domain
echo "IP=$dn1" > /var/lib/ipvps.conf
echo ""
clear
cd
sleep 1
fun_bar 'res1'
clear
rm /root/subdomainx
elif [[ $domain2 == "2" ]]; then
clear
echo -e  "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e  "${tyblue}│  \033[1;37mContoh subdomain xxx.vpnnewbie.my.id         ${tyblue}│${NC}"
echo -e  "${tyblue}│    \033[1;37mxxx jadi subdomain kamu               ${tyblue}│${NC}"
echo -e  "${tyblue}└──────────────────────────────────────────┘${NC}"
echo " "
until [[ $dn2 =~ ^[a-zA-Z0-9_.-]+$ ]]; do
read -rp "Masukan subdomain kamu Disini tanpa spasi : " -e dn2
done
rm -rf /etc/xray
rm -rf /etc/v2ray
rm -rf /etc/nsdomain
rm -rf /etc/per
mkdir -p /etc/xray
mkdir -p /etc/v2ray
mkdir -p /etc/nsdomain
touch /etc/xray/domain
touch /etc/v2ray/domain
touch /etc/xray/slwdomain
touch /etc/v2ray/scdomain
echo "$dn2" > /root/domain
echo "$dn2" > /root/scdomain
echo "$dn2" > /etc/xray/scdomain
echo "$dn2" > /etc/v2ray/scdomain
echo "$dn2" > /etc/xray/domain
echo "$dn2" > /etc/v2ray/domain
echo "IP=$dn2" > /var/lib/ipvps.conf
echo ""
cd
sleep 1
fun_bar 'res1'
clear
elif [[ $domain2 == "3" ]]; then
clear
echo -e  "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e  "${tyblue}│  \033[1;37mContoh subdomain xxx.putrasultan.my.id        ${tyblue}│${NC}"
echo -e  "${tyblue}│    \033[1;37mxxx jadi subdomain kamu               ${tyblue}│${NC}"
echo -e  "${tyblue}└──────────────────────────────────────────┘${NC}"
echo " "
until [[ $dn3 =~ ^[a-zA-Z0-9_.-]+$ ]]; do
read -rp "Masukan subdomain kamu Disini tanpa spasi : " -e dn3
done
rm -rf /etc/xray
rm -rf /etc/v2ray
rm -rf /etc/nsdomain
rm -rf /etc/per
mkdir -p /etc/xray
mkdir -p /etc/v2ray
mkdir -p /etc/nsdomain
touch /etc/xray/domain
touch /etc/v2ray/domain
touch /etc/xray/slwdomain
touch /etc/v2ray/scdomain
echo "$dn3" > /root/domain
echo "$dn3" > /root/scdomain
echo "$dn3" > /etc/xray/scdomain
echo "$dn3" > /etc/v2ray/scdomain
echo "$dn3" > /etc/xray/domain
echo "$dn3" > /etc/v2ray/domain
echo "IP=$dn3" > /var/lib/ipvps.conf
echo ""
cd
sleep 1
fun_bar 'res1'
clear
rm /root/subdomainx
elif [[ $domain2 == "4" ]]; then
clear
echo -e  "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e  "${tyblue}│  \033[1;37mContoh subdomain xxx.rahmatstore.site        ${tyblue}│${NC}"
echo -e  "${tyblue}│    \033[1;37mxxx jadi subdomain kamu               ${tyblue}│${NC}"
echo -e  "${tyblue}└──────────────────────────────────────────┘${NC}"
echo " "
until [[ $dn4 =~ ^[a-zA-Z0-9_.-]+$ ]]; do
read -rp "Masukan subdomain kamu Disini tanpa spasi : " -e dn4
done
rm -rf /etc/xray
rm -rf /etc/v2ray
rm -rf /etc/nsdomain
rm -rf /etc/per
mkdir -p /etc/xray
mkdir -p /etc/v2ray
mkdir -p /etc/nsdomain
touch /etc/xray/domain
touch /etc/v2ray/domain
touch /etc/xray/slwdomain
touch /etc/v2ray/scdomain
echo "$dn4" > /root/domain
echo "$dn4" > /root/scdomain
echo "$dn4" > /etc/xray/scdomain
echo "$dn4" > /etc/v2ray/scdomain
echo "$dn4" > /etc/xray/domain
echo "$dn4" > /etc/v2ray/domain
echo "IP=$dn4" > /var/lib/ipvps.conf
echo ""
cd
sleep 1
fun_bar 'res1'
fi
if [[ $domain == "3" ]]; then
clear
echo -e  "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e  "${tyblue}│              \033[1;37mTERIMA KASIH                ${tyblue}│${NC}"
echo -e  "${tyblue}│         \033[1;37mSUDAH MENGGUNAKAN SCRIPT         ${tyblue}│${NC}"
echo -e  "${tyblue}│                \033[1;37mDARI SAYA                 ${tyblue}│${NC}"
echo -e  "${tyblue}└──────────────────────────────────────────┘${NC}"
echo " "
until [[ $dns1 =~ ^[a-zA-Z0-9_.-]+$ ]]; do 
read -rp "Masukan domain kamu Disini : " -e dns1
done
echo ""
echo "$dns1" > /etc/xray/domain
echo "$dns1" > /etc/v2ray/domain
echo "IP=$dns1" > /var/lib/ipvps.conf
clear
#echo ""
#echo -e  "${tyblue}┌──────────────────────────────────────────┐${NC}"
#echo -e  "${tyblue}│              \033[1;37mTERIMA KASIH                ${tyblue}│${NC}"
#echo -e  "${tyblue}│         \033[1;37mSUDAH MENGGUNAKAN SCRIPT         ${tyblue}│${NC}"
#echo -e  "${tyblue}│                \033[1;37mDARI SAYA                 ${tyblue}│${NC}"
#echo -e  "${tyblue}└──────────────────────────────────────────┘${NC}"
#echo " "
#until [[ $dns2 =~ ^[a-zA-Z0-9_.-]+$ ]]; do
#read -rp "Masukan Domain SlowDNS kamu Disini : " -e dns2
#done
#echo $dns2 >/etc/xray/dns
fi
}
mkdir -p /etc/nbwr/theme
cat <<EOF>> /etc/nbwr/theme/green
BG : \E[40;1;42m
TEXT : \033[0;32m
EOF
cat <<EOF>> /etc/nbwr/theme/yellow
BG : \E[40;1;43m
TEXT : \033[0;33m
EOF
cat <<EOF>> /etc/nbwr/theme/red
BG : \E[40;1;41m
TEXT : \033[0;31m
EOF
cat <<EOF>> /etc/nbwr/theme/blue
BG : \E[40;1;44m
TEXT : \033[0;34m
EOF
cat <<EOF>> /etc/nbwr/theme/magenta
BG : \E[40;1;45m
TEXT : \033[0;35m
EOF
cat <<EOF>> /etc/nbwr/theme/cyan
BG : \E[40;1;46m
TEXT : \033[0;36m
EOF
cat <<EOF>> /etc/nbwr/theme/lightgray
BG : \E[40;1;47m
TEXT : \033[0;37m
EOF
cat <<EOF>> /etc/nbwr/theme/darkgray
BG : \E[40;1;100m
TEXT : \033[0;90m
EOF
cat <<EOF>> /etc/nbwr/theme/lightred
BG : \E[40;1;101m
TEXT : \033[0;91m
EOF
cat <<EOF>> /etc/nbwr/theme/lightgreen
BG : \E[40;1;102m
TEXT : \033[0;92m
EOF
cat <<EOF>> /etc/nbwr/theme/lightyellow
BG : \E[40;1;103m
TEXT : \033[0;93m
EOF
cat <<EOF>> /etc/nbwr/theme/lightblue
BG : \E[40;1;104m
TEXT : \033[0;94m
EOF
cat <<EOF>> /etc/nbwr/theme/lightmagenta
BG : \E[40;1;105m
TEXT : \033[0;95m
EOF
cat <<EOF>> /etc/nbwr/theme/lightcyan
BG : \E[40;1;106m
TEXT : \033[0;96m
EOF
cat <<EOF>> /etc/nbwr/theme/color.conf
lightcyan
EOF
function Pasang(){
cd
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1
clear
wget https://raw.githubusercontent.com/diah082/vip/main/tools.sh &> /dev/null
chmod +x tools.sh 
bash tools.sh
clear
start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
apt install git curl -y >/dev/null 2>&1
apt install python -y >/dev/null 2>&1
}
function Installasi(){
fun_bar() {
    CMD[0]="$1"
    CMD[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne "  \033[0;33mLagi Menginstal File \033[1;37m- \033[0;33m["
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[0;32m#"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[0;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "  \033[0;33mLagi Menginstal File \033[1;37m- \033[0;33m["
    done
    echo -e "\033[0;33m]\033[1;37m -\033[1;32m Succes !\033[1;37m"
    tput cnorm
}


res2() {
wget https://raw.githubusercontent.com/diah082/vip/main/install/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh
clear
} 

res3() {
wget https://raw.githubusercontent.com/diah082/vip/main/install/ins-xray.sh && chmod +x ins-xray.sh && ./ins-xray.sh
clear
}

res4() {
wget https://raw.githubusercontent.com/diah082/vip/main/sshws/insshws.sh && chmod +x insshws.sh && ./insshws.sh
clear
}

res5() {
wget https://raw.githubusercontent.com/diah082/vip/main/install/set-br.sh && chmod +x set-br.sh && ./set-br.sh
clear
}

res6() {
wget https://raw.githubusercontent.com/diah082/vip/main/sshws/ohp.sh && chmod +x ohp.sh && ./ohp.sh
clear
}

res7() {
wget https://raw.githubusercontent.com/diah082/vip/main/menu/update.sh && chmod +x update.sh && ./update.sh
clear
}

res8() {
wget https://raw.githubusercontent.com/diah082/vip/main/slowdns/installsl.sh && chmod +x installsl.sh && bash installsl.sh
clear
}

res9() {
wget https://raw.githubusercontent.com/diah082/vip/main/install/udp-custom.sh && chmod +x udp-custom.sh && bash udp-custom.sh
clear
}

echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│      PROCESS INSTALLED SSH & OPENVPN     │${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
fun_bar 'res2'

echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│           PROCESS INSTALLED XRAY         │${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
fun_bar 'res3'

echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│       PROCESS INSTALLED WEBSOCKET SSH    │${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
fun_bar 'res4'

echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│       PROCESS INSTALLED BACKUP MENU      │${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
fun_bar 'res5'

echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│           PROCESS INSTALLED OHP          │${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
fun_bar 'res6'


echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│           DOWNLOAD EXTRA MENU            │${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
fun_bar 'res7'

echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│           DOWNLOAD SYSTEM                │${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
fun_bar 'res8'

echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│           DOWNLOAD UDP COSTUM            │${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
fun_bar 'res9'
}

function iinfo(){
domain=$(cat /etc/xray/domain)
TIMES="10"
CHATID="6701388433"
KEY="7124749210:AAGz4PSHpA5dFb6i8BOoycKgnEPhKpUvPUM"
URL="https://api.telegram.org/bot$KEY/sendMessage"
ISP=$(cat /etc/xray/isp)
CITY=$(cat /etc/xray/city)
domain=$(cat /etc/xray/domain) 
TIME=$(date +'%Y-%m-%d %H:%M:%S')
RAMMS=$(free -m | awk 'NR==2 {print $2}')
MODEL2=$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')
MYIP=$(curl -sS ipv4.icanhazip.com)
IZIN=$(curl -sS https://raw.githubusercontent.com/diah082/izinv1/main/ip | grep $MYIP | awk '{print $3}' )
d1=$(date -d "$IZIN" +%s)
d2=$(date -d "$today" +%s)
EXP=$(( (d1 - d2) / 86400 ))

TEXT="
<code>━━━━━━━━━━━━━━━━━━━━</code>
<code>⚠️ AUTOSCRIPT PREMIUM ⚠️</code>
<code>━━━━━━━━━━━━━━━━━━━━</code>
<code>NAME : </code><code>${author}</code>
<code>TIME : </code><code>${TIME} WIB</code>
<code>DOMAIN : </code><code>${domain}</code>
<code>IP : </code><code>${MYIP}</code>
<code>ISP : </code><code>${ISP} $CITY</code>
<code>OS LINUX : </code><code>${MODEL2}</code>
<code>RAM : </code><code>${RAMMS} MB</code>
<code>EXP SCRIPT : </code><code>$EXP Days</code>
<code>━━━━━━━━━━━━━━━━━━━━</code>
<i> Notifikasi Installer Script...</i>
"'&reply_markup={"inline_keyboard":[[{"text":"🔥ᴏʀᴅᴇʀ","url":"https://t.me/newbie_Store24"},{"text":"🔥GRUP","url":"https://t.me/newbielearning"}]]}'
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
clear
}

CEKIP
Installasi
cat> /root/.profile << END
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
clear
welcome
END
chmod 644 /root/.profile
if [ -f "/root/log-install.txt" ]; then
rm /root/log-install.txt > /dev/null 2>&1
fi
if [ -f "/etc/afak.conf" ]; then
rm /etc/afak.conf > /dev/null 2>&1
fi
if [ ! -f "/etc/log-create-user.log" ]; then
echo "Log All Account " > /etc/log-create-user.log
fi
history -c
serverV=$( curl -sS https://raw.githubusercontent.com/diah082/VIP/main/versi  )
echo $serverV > /opt/.ver
echo "00" > /home/daily_reboot
aureb=$(cat /home/daily_reboot)
b=11
if [ $aureb -gt $b ]
then
gg="PM"
else
gg="AM"
fi
cd
curl -sS ifconfig.me > /etc/myipvps
curl -s ipinfo.io/city?token=75082b4831f909 >> /etc/xray/city
curl -s ipinfo.io/org?token=75082b4831f909  | cut -d " " -f 2-10 >> /etc/xray/isp
rm /root/setup.sh >/dev/null 2>&1
rm /root/pointing.sh >/dev/null 2>&1
rm /root/ssh-vpn.sh >/dev/null 2>&1
rm /root/ins-xray.sh >/dev/null 2>&1
rm /root/insshws.sh >/dev/null 2>&1
rm /root/set-br.sh >/dev/null 2>&1
rm /root/ohp.sh >/dev/null 2>&1
rm /root/update.sh >/dev/null 2>&1
rm /root/installsl.sh >/dev/null 2>&1
rm /root/udp-custom.sh >/dev/null 2>&1
secs_to_human "$(($(date +%s) - ${start}))" | tee -a log-install.txt
sleep 3
echo  ""
cd
iinfo
echo -e "${tyblue}┌────────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│  Install SCRIPT SELESAI..                  │${NC}"
echo -e "${tyblue}└────────────────────────────────────────────┘${NC}"
echo  ""
sleep 4
echo -e "[ ${yell}WARNING${NC} ] Do you want to reboot now ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi
