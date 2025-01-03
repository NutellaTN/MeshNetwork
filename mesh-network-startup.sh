#!/bin/bash
make --directory=/path/to/batman-adv-2023.3/ all
make --directory=/path/to/batman-adv-2023.3/ install
service wpa_supplicant stop
systemctl mask wpa_supplicant.service 
ip link set <if> down #e.g <if> = wlan0 
iw <if> set type ibss
ifconfig <if> mtu 1468
iwconfig <if> channel 3
ip link set <if> up
iw <if> ibss join my-mesh-network 2432
modprobe batman-adv
batctl if add <if>
ip link set up dev <if>
ip link set up dev bat0
ifconfig bat0 <ip_address> #e.g <ip_address> 172.27.0.2/16 or any valid ip address
exit 0
