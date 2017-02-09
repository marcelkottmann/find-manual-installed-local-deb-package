#!/bin/bash

set -e

sudo rm -rf /var/lib/apt/lists/*
echo "Updating package information..."
sudo apt-get update -qq
dpkg --get-selections | grep -v deinstall | awk '{print $1}'| awk -F ":" '{print $1}' | sort | uniq > /tmp/installed_packages
grep -s ^Package /var/lib/apt/lists/* | awk '{print $2}' | sort | uniq > /tmp/avail_packages

echo "Locally installed packages outside of current apt-get sources list:"
echo ""
grep -vxF -f /tmp/avail_packages /tmp/installed_packages
