#!/bin/bash

docker pull wpscanteam/wpscan

# Function to display available parameters
show_help() {
    echo "Available WPScan Parameters:"
    echo "-----------------------------"
    echo "--enumerate [options]    Enumerate content (e.g., vp, vt, u)"
    echo "                         vp = Vulnerable plugins"
    echo "                         vt = Vulnerable themes"
    echo "                         u  = Users"
    echo "--plugins-detection      Plugin detection mode (mixed, passive, aggressive)"
    echo "--api-token <token>      Use WPScan API token for premium vulnerability data"
    echo "--stealthy               Enable stealthy mode (random delays and user agents)"
    echo "--password-attack        Enable password brute-force attack"
    echo "--disable-tls-checks     Disable SSL verification"
    echo "--random-user-agent      Use a random User-Agent"
    echo "--max-threads <num>      Set maximum threads"
    echo ""
    echo "Example: --enumerate vp vt --plugins-detection aggressive --stealthy"
    echo ""
}

read -p "Show available parameters? (y/n): " show_params
if [[ "$show_params" =~ [Yy] ]]; then
    show_help
fi

while true; do
    read -p "Enter the target URL (e.g., https://example.com): " target_url
    if [ -n "$target_url" ]; then
        break
    else
        echo "Error: URL cannot be empty!"
    fi
done

read -p "Enter additional parameters (space-separated): " user_params

# Execute the scan
echo -e "\nRunning command:"
echo "docker run -it --rm wpscanteam/wpscan --url $target_url $user_params"
docker run -it --rm wpscanteam/wpscan --url "$target_url" $user_params
