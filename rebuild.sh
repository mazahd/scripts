sed -i '/fsType = "tmpfs";/a\      options = [ "defaults" "size=2G" "mode=755" ];' /etc/nixos/hardware-configuration.nix

sed -i '/fsType = "zfs";/a\      options = [ "zfsutil" ];' /etc/nixos/hardware-configuration.nix

sed -i '/options = \[ "zfsutil" \];/{x;s/^/x/;/xx/{x;a \
      neededForBoot = true;
    ;b};x}' /etc/nixos/hardware-configuration.nix


# The URL of the GitHub repository's archive in the desired branch, usually master or main.
REPO_URL="https://github.com/nix-community/impermanence/archive/refs/heads/master.zip"

# The output filename for the downloaded ZIP file.
OUTPUT_ZIP="impermanence.zip"

# The directory to which the repository should be extracted.
EXTRACT_TO="/etc/nixos"

# Use curl to download the repository's ZIP archive.
curl -L $REPO_URL -o $OUTPUT_ZIP

# Unzip the archive to the specified directory.
unzip $OUTPUT_ZIP -d $EXTRACT_TO

# Remove the ZIP file after extraction.
rm $OUTPUT_ZIP

mv /etc/nixos/impermanence-master /etc/nixos/impermanence

# Change to the directory (optional).
cd $EXTRACT_TO

# Print the current directory contents.
echo "Repository cloned into directory:"
ls

curl -o /etc/nixos/configuration.nix https://raw.githubusercontent.com/mazahd/config/main/configuration.nix

sed -i "s/networking\.hostId = \"[^\"]*\"/networking.hostId = \"$(head -c 8 /etc/machine-id)\"/" /etc/nixos/configuration.nix

curl -o /etc/nixos/initrd.nix https://raw.githubusercontent.com/mazahd/config/main/initrd.nix


# Get the IPv4 address, gateway, and netmask for a given interface
# Replace eth0 with your actual network interface if different
INTERFACE="$(ip route get 1.2.3.4 | awk '{print $5; exit}')"

# Get the IPv4 address
IP_ADDR=$(ip addr show $INTERFACE | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)

# Get the IPv4 gateway
IP_GATEWAY=$(ip route | grep default | grep $INTERFACE | awk '{print $3}')

# Get the IPv4 netmask
# Calculate netmask from the CIDR prefix
CIDR_PREFIX=$(ip addr show $INTERFACE | grep 'inet ' | awk '{print $2}' | cut -d/ -f2)

# Convert CIDR prefix to a netmask
CIDR2MASK=(0x00000000 0x80000000 0xc0000000 0xe0000000 0xf0000000 0xf8000000 0xfc000000 0xfe000000 0xff000000 0xff800000 0xffc00000 0xffe00000 0xfff00000 0xfff80000 0xfffc0000 0xfffe0000 0xffff0000 0xffff8000 0xffffc000 0xffffe000 0xfffff000 0xfffff800 0xfffffc00 0xfffffe00 0xffffff00 0xffffff80 0xffffffc0 0xffffffe0 0xfffffff0 0xfffffff8 0xfffffffc 0xfffffffe 0xffffffff)
BIN_MASK=${CIDR2MASK[$CIDR_PREFIX]}
IP_NETMASK=$(printf "%d.%d.%d.%d" $(($BIN_MASK >> 24 & 255)) $(($BIN_MASK >> 16 & 255)) $(($BIN_MASK >> 8 & 255)) $(($BIN_MASK & 255)))


# Store the values in the specified format
RESULT="ip=${IP_ADDR}::${IP_GATEWAY}:${IP_NETMASK}::${INTERFACE}:none"

# Save to a file or output
echo $RESULT


sed -i "s/ip=<ipv4_address>::<ipv4_gateway>:<ipv4_netmask>::<interface>:none/ip=$RESULT/g" /etc/nixos/initrd.nix

# Uncomment the following line to save to a file
# echo $RESULT > /path/to/output/file

# End of the script
