# WPScan-Docker

This is a simple Bash script to run WPScan using Docker. It ensures the latest WPScan image is pulled and provides an interactive prompt for entering the target URL and additional parameters.

## Prerequisites

- Docker installed on your system.
- Internet connection to pull the latest WPScan image.

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/daaaaaaanyyyyy/wpscan-docker.git
   cd wpscan-docker
   ```
2. Make the script executable:
   ```bash
   chmod +x wpscan-docker.sh
   ```

## usage

1. Run the script:

   ```bash
   ./wpscan-docker.sh

   ```

2. Example Usage
   ```bash
   Show available parameters? (y/n): y
   (Displays parameter help...)
   

    Enter the target URL (e.g., https://example.com): https://www.example.com
   Enter additional parameters (space-separated): --enumerate vp vt --stealthy
 
   Running command:
   docker run -it --rm wpscanteam/wpscan --url https://example --enumerate vp vt --stealthy
## Features

- Ensures the latest WPScan Docker image is used.
- Interactive prompts for user input.
- Supports additional WPScan parameters.
