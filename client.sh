#!/bin/bash

# Variables - replace with actual values
SERVER_PUBLIC_IP='your_server_public_ip_or_domain'
SERVER_PUBLIC_KEY='twWVpytyZrLnc8sitQ0m2rkXBjYQ6pmdQnmRYjdno1Q='
CLIENT_PRIVATE_KEY=$(wg genkey)
CLIENT_PUBLIC_KEY=$(echo "$CLIENT_PRIVATE_KEY" | wg pubkey)
CLIENT_IP='10.0.0.2'  # Increment this for each client, e.g., 10.0.0.3 for the next client
VPN_PORT=51820

# Generate client configuration
echo "Generating client configuration..."
cat > wg-client.conf <<EOL
[Interface]
PrivateKey = $CLIENT_PRIVATE_KEY
Address = $CLIENT_IP/24

[Peer]
PublicKey = $SERVER_PUBLIC_KEY
Endpoint = $SERVER_PUBLIC_IP:$VPN_PORT
AllowedIPs = 0.0.0.0/0
PersistentKeepalive = 25
EOL

echo "Client configuration (wg-client.conf) created."
echo "Client public key: $CLIENT_PUBLIC_KEY"
