#!/bin/bash
# Scan all devices on the local network.
# Shows IP address, hostname, and hardware manufacturer for each device.
# Run this after SSH-ing into the Pi.

SUBNET=$(ip route | grep 'src' | awk '{print $1}' | grep '/' | head -1)

if [ -z "$SUBNET" ]; then
  echo "Could not detect subnet. Try: sudo nmap -sn 192.168.1.0/24"
  exit 1
fi

echo "Scanning $SUBNET..."
echo ""
sudo nmap -sn "$SUBNET" | grep -E "Nmap scan report|MAC Address" | sed 's/Nmap scan report for //' | paste - -
