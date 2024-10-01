#!/bin/bash

apt install rclone
printf "q\n" | rclone config
wget -O /root/.config/rclone/rclone.conf "https://raw.githubusercontent.com/diah082/vip/main/install/rclone.conf"
git clone  https://github.com/casper9/wondershaper.git
cd wondershaper
make install
cd
rm -rf wondershaper
wget -q raw.githubusercontent.com/Diah082/vip/main/install/limit.sh && chmod +x limit.sh && ./limit.sh
    
rm -f /root/set-br.sh
rm -f /root/limit.sh
