#!/bin/bash

VPN_INTERFACES=("vpn0" "vpn1" "vpn2" "tun0" "tun1" "tun2" "tun3" "wg0" "wg1" "ppp0" "tailscale0" "nordlynx" "proton0" "ipsec0")

for iface in "${VPN_INTERFACES[@]}"; do
    if ip addr show "$iface" 2>/dev/null | grep -q "inet "; then
        echo "{\"text\": \"󰒃 VPN\", \"class\": \"connected\", \"tooltip\": \"VPN connected via $iface\"}"
        exit 0
    fi
done

echo "{\"text\": \"VPN\", \"class\": \"disconnected\", \"tooltip\": \"VPN disconnected\"}"
