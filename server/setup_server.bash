#!/bin/bash

sudo apt install linuxlogo
cp /etc/issue /etc/issue.bkp
cat /etc/issue.linuxlogo > /etc/issue
mv /etc/motd /etc/motd.bkp
nano /etc/motd

nano /root/.bashrc

apt install net-tools
ip a
nano /etc/network/interfaces

systemctl restart networking
systemctl status networking
ifup enp0s3
apt install iptables
apt install iptables-persistent 
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE

apt install isc-dhcp-server
nano /etc/default/isc-dhcp-server
