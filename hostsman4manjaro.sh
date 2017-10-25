#!/bin/bash
#This updates the hosts file
mv /etc/hosts.bak /etc/hosts
cp /etc/hosts /etc/hosts.bak
cd /home/james #If you run as cron job.
wget https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling/hosts
wget https://hosts-file.net/ad_servers.txt
sed -i 's/127.0.0.1/0.0.0.0/g' ad_servers.txt
cat ad_servers.txt >> hosts
cat list >> hosts
uniq hosts > /tmp/hosts.new && mv /tmp/hosts.new hosts
cat hosts >> /etc/hosts 
systemctl restart NetworkManager.service
rm hosts ad_servers.txt
cat /etc/hosts >> hosts.log