#!/bin/bash

# This script expects two arguments:
# 1. Server IP address
# 2. Gateway IP address

# Check if two arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <username/repo> <filename-with-ext> Optional: <output-path> default is current dir"
    exit 1
fi

# Assign the arguments to variables
REPO=$1
FILE=$2
STORE=${3:-.}


curl -o $STORE https://raw.githubusercontent.com/$REPO/main/$FIlE
