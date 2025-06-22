#!/bin/bash

# Universal macOS Development Environment Setup
# Streamlined setup for any macOS device

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[SETUP]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SETUP]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[SETUP]${NC} $1"
}

log_error() {
    echo -e "${RED}[SETUP]${NC} $1"
}

# Verify macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    log_error "This script is designed for macOS only!"
    exit 1
fi

log_info "Starting Universal macOS Development Environment Setup..."

# Get sudo access once
sudo -v
while true; do sudo -n true; sleep 10; kill -0 "$$" || exit; done 2>/dev/null &

# Ensure required directories exist
mkdir -p scripts configs

# Step 1: Install Command Line Tools
log_info "Installing Xcode Command Line Tools..."
if ! xcode-select -p &>/dev/null; then
    xcode-select --install
    log_warning "Command Line Tools installation initiated. Please complete the installation popup and re-run this script."
    exit 0
fi
log_success "Command Line Tools ready"

# Step 2: Setup Homebrew and essential packages
log_info "Setting up Homebrew and essential packages..."
chmod +x scripts/homebrew.sh
./scripts/homebrew.sh

# Verify Homebrew is accessible
if ! command -v brew &>/dev/null; then
    log_error "Homebrew installation failed - not accessible in PATH"
    exit 1
fi
log_success "Homebrew verified and accessible"

# Step 3: Setup Zsh environment
log_info "Setting up Zsh environment..."
chmod +x scripts/zsh-setup.sh
./scripts/zsh-setup.sh

# Step 4: Setup Karabiner Elements
log_info "Setting up Karabiner Elements..."
chmod +x scripts/karabiner.sh
./scripts/karabiner.sh

# Step 5: Configure macOS defaults
log_info "Configuring macOS system preferences..."
chmod +x scripts/macos-defaults.sh
./scripts/macos-defaults.sh

# Step 6: Install additional applications
log_info "Setting up additional applications..."
chmod +x scripts/applications.sh
./scripts/applications.sh

# Final verification
log_info "Verifying installation..."
failed_tools=()

# Check essential tools
essential_tools=("brew" "git" "node" "python3" "zsh")
for tool in "${essential_tools[@]}"; do
    if ! command -v "$tool" &>/dev/null; then
        failed_tools+=("$tool")
    fi
done

if [ ${#failed_tools[@]} -gt 0 ]; then
    log_warning "The following essential tools are not accessible:"
    printf '%s\n' "${failed_tools[@]}"
    log_warning "You may need to restart your terminal and run 'source ~/.zshrc'"
else
    log_success "All essential development tools verified and accessible"
fi

log_success "Universal macOS Development Environment Setup completed!"
echo ""
log_info "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Grant permissions to Karabiner Elements (System Preferences > Security & Privacy)"
echo "  3. Configure Powerlevel10k by running: p10k configure"
echo "  4. Install additional apps using: ./download_manual_apps.sh"
echo ""
log_info "Homebrew Application Management:"
echo "  • Save current apps: ./scripts/save_brew_apps.sh"
echo "  • Install from config: ./scripts/install_brew_apps.sh"
echo ""
log_info "All configurations are backed up in the 'configs' directory" 