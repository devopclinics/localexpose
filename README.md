# localexpose

```markdown
# WireGuard VPN Server Setup Script

This script automates the installation and configuration of a WireGuard VPN server on a Linux system. WireGuard is a simple, fast, and modern VPN that utilizes state-of-the-art cryptography.

## Prerequisites

- A Linux server (Debian/Ubuntu or CentOS/RHEL based)
- Root access to the server
- `curl` installed on the server (for detecting public IP)

## Features

- Installs WireGuard
- Generates server keys
- Creates a WireGuard configuration file
- Sets up IP forwarding
- Starts and enables WireGuard at boot

## Installation

1. **Download the script**:
   You can clone this repository or copy the script directly to your server.

   ```bash
   wget https://example.com/wireguard-setup.sh
   ```

2. **Make the script executable**:
   
   ```bash
   chmod +x wireguard-setup.sh
   ```

3. **Run the script**:

   ```bash
   sudo ./wireguard-setup.sh
   ```

## Configuration

- The script will automatically detect the server's public IP and use it for the VPN configuration.
- The default VPN network is `10.0.0.1/24`. You can modify the script if you need a different subnet.
- The server's public key will be displayed at the end of the script execution. You'll need this when configuring VPN clients.

## Adding VPN Clients

To connect a client to the VPN server:

1. Generate keys for the client.
2. Add a peer configuration on the server with the client's public key.
3. Configure the client with its private key, the server's public key, and the VPN server's IP and port.

## Security Note

Ensure your server's firewall is configured to allow traffic on the WireGuard port (default is 51820/UDP).

## Troubleshooting

- Run `wg show` to check the status of the WireGuard interface.
- Check the server's firewall settings if you encounter connectivity issues.

## License

[Genaral]

## Credits

Developed by [www.devopclinics.com]

```

