#!/bin/bash

# ─── Color Definitions ──────────────────────────────────────────
RED='\033[0;31m'     # Errors
GREEN='\033[0;32m'   # Success
YELLOW='\033[1;33m'  # Prompts
CYAN='\033[0;36m'    # Info
BLUE='\033[0;34m'    # Header
RESET='\033[0m'      # Reset

clear

# ─── Simple Header ─────────────────────────────────────────────
echo -e "${BLUE}"
echo "======================================="
echo "=           WPscan‑docker             ="
echo "======================================="
echo -e "${RESET}"
sleep 1

# ─── Decorative Whale ─────────────────────────────────────────
echo -e "${CYAN}"
cat << 'EOF'
    ##         .
## ## ##        ==
## ## ## ## ##    ===
/""""""""""""""""\___/ ===
\_@"@"@"@"@"@"@"@_/
  \_@"@"@"@"@"@_/
      """"""""
EOF
echo -e "${RESET}"
sleep 0.5

# ─── Pull Image ────────────────────────────────────────────────
echo -e "${YELLOW}[*] Pulling latest WPScan Docker image...${RESET}"
docker pull wpscanteam/wpscan > /dev/null &
echo -e "${GREEN}[✓] Image pull initiated.${RESET}"
echo ""

# ─── Fake Engine Init ─────────────────────────────────────────
steps=(
  "Initializing core scanner engine"
  "Loading vulnerability database"
  "Setting up stealth parameters"
  "Calibrating thread pool"
)
for step in "${steps[@]}"; do
  echo -ne "${CYAN}[*] $step...${RESET}"
  sleep 0.5
  echo -e " ${GREEN}done.${RESET}"
done
echo ""

# ─── Help Function ────────────────────────────────────────────
show_help(){
  echo -e "${BLUE}Available WPScan Parameters:${RESET}"
  echo "----------------------------"
  echo -e "${YELLOW}--enumerate [vp|vt|u]${RESET}    Enumerate (plugins/themes, users)"
  echo -e "${YELLOW}--plugins-detection${RESET}      Plugin detection: mixed|passive|aggressive"
  echo -e "${YELLOW}--api-token <token>${RESET}      Your WPScan API token"
  echo -e "${YELLOW}--stealthy${RESET}               Random delays & user‑agents"
  echo -e "${YELLOW}--password-attack${RESET}        Brute‑force passwords"
  echo -e "${YELLOW}--disable-tls-checks${RESET}     Skip SSL verification"
  echo -e "${YELLOW}--random-user-agent${RESET}      Randomize UA header"
  echo -e "${YELLOW}--max-threads <num>${RESET}      Max concurrent threads"
  echo ""
  echo "Example:"
  echo "  --enumerate vp vt --plugins-detection aggressive --stealthy"
  echo ""
}

# ─── Ask If They Want Help ─────────────────────────────────────
echo -ne "${YELLOW}Show available parameters? (y/n): ${RESET}"
read ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
  show_help
fi

# ─── Target Input ──────────────────────────────────────────────
while :; do
  echo -ne "${YELLOW}Enter target URL (https://example.com): ${RESET}"
  read target
  if [[ -n "$target" ]]; then
    break
  fi
  echo -e "${RED}Error: URL cannot be empty!${RESET}"
done

# ─── Extra Params ──────────────────────────────────────────────
echo -ne "${YELLOW}Enter additional WPScan parameters: ${RESET}"
read user_params

# ─── Loading Bar ──────────────────────────────────────────────
echo -e "\n${CYAN}[*] Spinning up scan container:${RESET}"
bar="=========="
for i in $(seq 1 10); do
  printf "\r[%-10s] %d%%" "${bar:0:$i}" "$((i*10))"
  sleep 0.15
done
echo -e "\n"

# ─── Execute Scan ─────────────────────────────────────────────
echo -e "${GREEN}[▶] Running:${RESET}"
echo "  docker run -it --rm wpscanteam/wpscan --url $target $user_params"
docker run -it --rm wpscanteam/wpscan --url "$target" $user_params

# ─── Mission Complete ─────────────────────────────────────────
echo -e "${BLUE}"
echo "======================================="
echo "      MISSION COMPLETE ✅             "
echo "  WPscan‑docker has finished!         "
echo "======================================="
echo -e "${RESET}"

