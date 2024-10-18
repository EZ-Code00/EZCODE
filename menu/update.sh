#!/bin/bash
if command -v 7z &> /dev/null; then
    echo -ne
else
apt install p7zip-full -y
fi
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
REPO="https://raw.githubusercontent.com/Diah082/vip/main/"
###########- COLOR CODE -##############
echo -e " [INFO] Downloading File"
sleep 2
wget ${REPO}menu/menu.zip
wget -q -O /usr/bin/enc "${REPO}install/encrypt" ; chmod +x /usr/bin/enc
7z x -pas123@Newbie menu.zip
chmod +x menu/*
enc menu/*
mv menu/* /usr/local/sbin
rm -rf menu
rm -rf menu.zip
rm -rf /usr/local/sbin/*~
rm -rf /usr/local/sbin/gz*
rm -rf /usr/local/sbin/*.bak
serverV=$( curl -sS ${REPO}versi  )
echo $serverV > /opt/.ver
echo -e " [INFO] Download File Successfully"
sleep 2
exit