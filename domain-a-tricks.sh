#!/bin/bash

#Print banner
echo "______________________________________________________________________"
echo "|                                                                    |"   
echo "|         DOMAIN                                                     |"
echo "|               -A_                                                  |"
echo "|                  TRICKS   ...a Domain-Recon Automated Tool.        |"
echo "|                                                                    |"
echo "|                                             Author: Edgar Medina   |"
echo "|                                    edgar.medina.m.ed@protonmail.com|"
echo "|____________________________________________________________________|"
echo "" 

# Install needed dependencies

sudo apt-get update
sudo apt-get install python3
sudo apt-get install python3-pip
sudo apt-get install curl

pip3 install censys
pip3 install requests
pip3 install argparse
pip3 install json
pip3 install dirhunt
pip3 install securitytrails
pip3 install zoomeye
pip3 install pipenv
pip3 install dnspython
pip3 install colorama

# Install the tools

git clone https://github.com/e-m3din4/domain-a-tricks

# Find the tools directory
TOOLS_DIR=$(find ~ -name "Domain-A-Tricks" -type d -print | head -n 1)

if [ -z "$TOOLS_DIR" ]; then
  echo "Directory Domain-A-Tricks not found."
  exit 1
fi

# Set variables for each tool
DOMAIN_ANALYZER="$TOOLS_DIR/tools/domain_analyzer/domain_analyzer.py"
CLOUDFAIL="$TOOLS_DIR/tools/CloudFail/cloudfail.py"
CLOUDFLAIR="$TOOLS_DIR/tools/CloudFlair/cloudflair.py"
CLOUDUNFLARE="$TOOLS_DIR/tools/CloudUnflare/cloudunflare.bash"
BYPASS_FIREWALLS="$TOOLS_DIR/tools/bypass-firewalls-by-DNS-history/bypass-firewalls-by-DNS-history.sh"


# Set target domain
TARGET=$1

# Make results directory
mkdir -p results

# Run domain_analyzer.py and save output
python3 "$DOMAIN_ANALYZER" -d "$TARGET" | tee results/domain_analyzer.txt

# Set CENSYS API keys
export CENSYS_UID=YOUR-API-ID
export CENSYS_SECRET=YOUR-API-SECRET

# Search target domain on censys and save output
censys search "$TARGET" | tee results/censys.txt

# Search for subdomains with dirhunt
dirhunt "$TARGET" | tee results/dirhunt.txt

# Search target domain on securitytrails and save output
securitytrails domain "$TARGET" | tee results/securitytrails.txt

# Search target domain on zoomeye and save output
zoomeye domain history "$TARGET" | tee results/zoomeye.txt

# Run brutex and save output
sudo brutex "$TARGET" | tee results/brutex.txt

# Run CloudFlair and save output
python3 "$CLOUDFLAIR" --censys-api-id YOUR-API-ID   --censys-api-secret YOUR-API-SECRET  "$TARGET" | tee results/cloudflair.txt

# Run CloudFail and save output
sudo python3 "$CLOUDFAIL" --target  "$TARGET" | tee results/cloudfail.txt

# Input target domain when prompted by cloudunflare.bash
echo "$TARGET" | "$CLOUDUNFLARE" | tee results/cloudunflare.txt

# Run bypass-firewalls-by-DNS-history.sh
"$BYPASS_FIREWALLS" -d "$TARGET" | tee results/bypass-firewalls-by-DNS-history.txt

# Run subfinder
sudo subfinder -d "$TARGET" -v | sort -u | tee "$TARGET"-subdomains.txt | tee results/subfinder.txt

#Run photon
sudo photon -u https://"$TARGET" --verbose --threads 20 --delay 3 --level 3 --keys --only-urls --wayback --stdout=fuzzable | tee results/photon.txt

#Check if the results directory exists, and create it if not

if [ ! -d results ]; then
mkdir results
fi

#Save the output of each tool in the results directory

python3 "$DOMAIN_ANALYZER" -D -d "$TARGET" -o -e -F | tee results/domain_analyzer.txt
censys search "$TARGET" | tee results/censys.txt
dirhunt "$TARGET" | tee results/dirhunt.txt
securitytrails domain "$TARGET" | tee results/securitytrails.txt
zoomeye domain history "$TARGET" | tee results/zoomeye.txt
sudo brutex "$TARGET" | tee results/brutex.txt
"$BYPASS_FIREWALLS" -d "$TARGET" | tee results/bypass-firewalls-by-DNS-history.txt
sudo subfinder -d "$TARGET" -v | sort -u | tee "$TARGET"-subdomains.txt | tee results/subfinder.txt
sudo photon -u https://"$TARGET" --verbose --threads 20 --delay 3 --level 3 --keys --only-urls --wayback --stdout=fuzzable | tee results/photon.txt
