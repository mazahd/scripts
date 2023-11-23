#!/bin/bash

# Get the IPv4 address, gateway, and netmask for a given interface
# Replace eth0 with your actual network interface if different
INTERFACE="eth0"

# Get the IPv4 address
IP_ADDR=$(ip addr show $INTERFACE | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)

# Get the IPv4 gateway
IP_GATEWAY=$(ip route | grep default | grep $INTERFACE | awk '{print $3}')

# Get the IPv4 netmask
# Calculate netmask from the CIDR prefix
CIDR_PREFIX=$(ip addr show $INTERFACE | grep 'inet ' | awk '{print $2}' | cut -d/ -f2)
IP_NETMASK=$(ipcalc -4 -n $IP_ADDR/$CIDR_PREFIX | grep Netmask | awk '{print $2}')

# Store the values in the specified format
RESULT="ip=${IP_ADDR}::${IP_GATEWAY}:${IP_NETMASK}::${INTERFACE}:none"

# Save to a file or output
echo $RESULT
# Uncomment the following line to save to a file
# echo $RESULT > /path/to/output/file

# End of the script

