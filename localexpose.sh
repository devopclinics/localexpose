#!/bin/bash

# Check if running as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Install WireGuard
echo "Installing WireGuard..."
if [ -f /etc/debian_version ]; then
    apt update
    apt install -y wireguard
elif [ -f /etc/redhat-release ]; then
    yum install -y epel-release elrepo-release
    yum install -y wireguard-tools
else
    echo "Unsupported distribution"
    exit 1
fi

# Generate Server Keys
echo "Generating server keys..."
wg genkey | tee /etc/wireguard/privatekey | wg pubkey > /etc/wireguard/publickey

SERVER_PRIVATE_KEY=$(cat /etc/wireguard/privatekey)
SERVER_PUBLIC_KEY=$(cat /etc/wireguard/publickey)

# Server Config
echo "Creating server config..."
cat > /etc/wireguard/wg0.conf <<EOL
[Interface]
Address = 10.0.0.1/24  # This is the VPN's subnet and can be adjusted as needed
SaveConfig = true
PrivateKey = $SERVER_PRIVATE_KEY
ListenPort = 51820

# Peer section can be configured per client
#[Peer]
#PublicKey = [Client Public Key]
#AllowedIPs = 10.0.0.2/32
EOL

# Adjust system settings for IP forwarding
echo "Adjusting system settings for WireGuard..."
echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/99-wireguard-forward.conf
sysctl --system

# Start WireGuard
echo "Starting WireGuard..."
wg-quick up wg0

# Enable WireGuard to start on boot
echo "Enabling WireGuard to start on boot..."
systemctl enable wg-quick@wg0

echo "WireGuard installation complete."
echo "Server public key: $SERVER_PUBLIC_KEY"
