#!/bin/bash

# Get the IPv4 address, gateway, and netmask for a given interface
# Replace eth0 with your actual network interface if different

#!/bin/bash

# This script expects two arguments:
# 1. Server IP address
# 2. Gateway IP address

# Check if two arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <server-ip> <gateway-ip>"
    exit 1
fi

# Assign the arguments to variables
SERVER_IP=$1
GATEWAY_IP=$2

INTERFACE="$(ip route get 1.2.3.4 | awk '{print $5; exit}')"


ip addr add $SERVER_IP/25 dev $INTERFACE

ip route add default via $GATEWAYIP dev $INTERFACE

echo "nameserver 1.1.1.1" >> /etc/resolv.conf