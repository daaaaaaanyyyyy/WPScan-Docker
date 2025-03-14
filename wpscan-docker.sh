#!/bin/bash

# Ensure Docker image is up-to-date
docker pull wpscanteam/wpscan

# Prompt user for target URL
read -p "Enter the target URL (e.g., https://example.com): " target_url

# Check if URL was provided
if [ -z "$target_url" ]; then
    echo "Error: No URL provided!"
    exit 1
fi

# Prompt user for additional parameters
read -p "Enter additional parameters (e.g., --enumerate vp, --plugins-detection aggressive): " user_params

# Run WPScan with user inputs
docker run -it --rm wpscanteam/wpscan --url "$target_url" $user_params
