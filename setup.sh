#!/bin/bash

set -eu
set -o pipefail

source /etc/os-release

# This script will setup an Apt repository for Reef-Pi in one command

echo "Detecting your Raspberry Pi hardware type..."
MODEL=$(grep "model name" /proc/cpuinfo | awk '{print $4}')

if [ "$MODEL" = "ARMv6-compatible" ]; then
    echo "Detected a Raspberry Pi Zero or other ARMv6 machine"
    REPO_SUFFIX="pi0"
else
    echo "Detected an ARMv7 machine (Raspberry Pi 3 or newer)"
    REPO_SUFFIX="pi3"
fi

echo -n "Adding repository for ${REPO_SUFFIX}"
echo "deb http://repo.blueacro.com/repos/reef-${REPO_SUFFIX} ${VERSION_CODENAME} main" | sudo tee /etc/apt/sources.list.d/reefpi.list > /dev/null
echo " done."

echo -n "Importing repository key..."
curl -s http://repo.blueacro.com/repo.key | sudo apt-key add -

echo "Refreshing..."
sudo apt-get update -y

echo "Installing reef-pi..."
sudo apt-get install -y reef-pi
