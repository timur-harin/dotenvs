#!/bin/bash

# Streamlined Additional Applications Setup

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[APPS]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[APPS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[APPS]${NC} $1"
}

log_error() {
    echo -e "${RED}[APPS]${NC} $1"
}

log_info "Setting up additional applications..."

# Verify Homebrew is available
if ! command -v brew &>/dev/null; then
    log_error "Homebrew not found. Please run homebrew.sh first."
    exit 1
fi

# Check if we have saved applications config
if [ -f "configs/brew_cask_apps.txt" ] || [ -f "configs/Brewfile" ]; then
    log_info "Found saved applications config - installing from saved list..."
    chmod +x scripts/install_brew_apps.sh
    ./scripts/install_brew_apps.sh
else
    log_info "No saved applications config found - saving current applications..."
    chmod +x scripts/save_brew_apps.sh
    ./scripts/save_brew_apps.sh
    
    log_info "Now installing applications from saved config..."
    chmod +x scripts/install_brew_apps.sh
    ./scripts/install_brew_apps.sh
fi

# Create comprehensive manual download script
log_info "Creating manual download script..."

cat > download_manual_apps.sh << 'EOF'
#!/bin/bash

# Manual Application Downloads
# Open download pages for applications not available via Homebrew

echo "Opening download pages for manual installation..."

# Development Tools
echo "=== Development Tools ==="
open "https://www.figma.com/downloads/"

# Media & Entertainment
echo "=== Media & Entertainment ==="
open "https://music.yandex.com/download/"

# Productivity
echo "=== Productivity ==="


# Utilities
echo "=== Utilities ==="
open "https://getoutline.org/get-started/"
open "https://telemost.yandex.ru/download"
open "https://www.utorrent.com/web/"
open "https://yandex.ru/soft/punto/mac/"


# Commercial Software
echo ""
echo "=== Commercial Software (Purchase Required) ==="
open "https://macpaw.com/cleanmymac"
open "https://www.microsoft.com/microsoft-365"
open "https://www.screen.studio/"
open "https://www.getvivid.app/"
open "https://daisydiskapp.com/"


echo ""
echo "=== App Store Applications ==="
echo "Install these from the Mac App Store:"
echo "Outline VPN"
echo "Xcode"
echo "Keynote, Numbers, Pages"


echo ""
echo "All download pages have been opened in your browser."
echo "Please download and install each application manually."
EOF

chmod +x download_manual_apps.sh

# Create a verification script to check installed applications
cat > verify_apps.sh << 'EOF'
#!/bin/bash

# Verify installed applications

echo "Checking installed applications..."

# Applications to check
apps=(
    "Cursor"
    "Visual Studio Code"
    "iTerm"
    "Docker"
    "Postman"
    "IINA"
    "Obsidian"
    "Raycast"
    "Rectangle"
    "Stats"
    "Telegram"
    "The Unarchiver"
    "Karabiner-Elements"
)

installed=()
missing=()

for app in "${apps[@]}"; do
    if [[ -d "/Applications/${app}.app" ]]; then
        installed+=("$app")
    else
        missing+=("$app")
    fi
done

echo ""
echo "✅ Installed Applications:"
printf '  • %s\n' "${installed[@]}"

if [ ${#missing[@]} -gt 0 ]; then
    echo ""
    echo "❌ Missing Applications:"
    printf '  • %s\n' "${missing[@]}"
    echo ""
    echo "Run './download_manual_apps.sh' to download missing applications"
fi

echo ""
echo "Applications verification completed!"
EOF

chmod +x verify_apps.sh

log_success "Additional applications setup completed!"
log_info "Created scripts:"
echo "  • save_brew_apps.sh - Save current Homebrew applications to config"
echo "  • install_brew_apps.sh - Install applications from saved config"
echo "  • download_manual_apps.sh - Opens download pages for manual installation"
echo "  • verify_apps.sh - Checks which applications are installed"
echo ""
log_info "To manage Homebrew applications:"
echo "  Save current apps: ./scripts/save_brew_apps.sh"
echo "  Install from config: ./scripts/install_brew_apps.sh"
echo ""
log_warning "To install applications not available via Homebrew:"
echo "  Run: ./download_manual_apps.sh" 