# Domain-a-Tricks                                             
## ...a Domain-Recon Automation Tool.  


### Installation
For OS Linux: Debian / Ubuntu, etc.

Navigate to the directory containing tool.zip, unzip folder and then navigate every directory on ~/Domain-A-Tricks/tools and follow steps to install every tool featured in the script workbook; (some core scripts written in python will require to add to path certains directories containg list and dicts in order run as expected. 

git clone repository,

`unzip tools.zip`

also:

`sudo apt install photon sublister`

and

`pip3 install zoomeye censys pysecuritytrails photon`

### Usage

`cd ~/Domain-A-Tricks`

`chmod +x domain-a-tricks.sh`


`bash ./domain-a-tricks.sh [TARGET_DOMAIN]`


Where TARGET_DOMAIN is the domain for the reconnaissance process. (e.g) targetdomain.com

### Description

This script automates the domain reconnaissance process using multiple tools. The script uses a combination of Python, Go, and bash scripts to gather information about a target domain. The results from each tool are saved in /results/ directory for further analysis.

### Prerequisites

All tools must be installed and located in the /your/PATH/TO/Domain-A-Tricks/tools directory.
The Censys API credentials (CENSYS_UID and CENSYS_SECRET) must be set before running the script.
Censys, SecurityTrails and Zoomeye API credentials must be obtained and set before running the script.
The following pip packages must be installed: censys, pysecuritytrails, zoomeye, photon 

### Tools 

The following tools are used in the script, located at ~/Domain-A-Tricks/tools, make sure every tool is installed and fully-functional before running this script:

_// Domain_Analyzer
// Censys
// Dirhunt
// SecurityTrails
// Zoomeye
// Brutex 
// CloudFlair
// Cloudfail
// Cloudflare-Origin-IP
// CloudUnflare
// Subfinder
// Bypass-firewalls-by-DNS-history
// Photon (including VirusTotal, Shodan, Whois, AlienVault, Google Dorking, etc)
_
### Output

The obtained output from each tool will be saved in the results directory with the format tool_name-target_domain.txt.
