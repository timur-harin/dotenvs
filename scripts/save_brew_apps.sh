#!/bin/bash

# Save Current Homebrew Cask Applications to Config
# This script saves the current list of installed Homebrew cask applications

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[SAVE]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SAVE]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[SAVE]${NC} $1"
}

log_error() {
    echo -e "${RED}[SAVE]${NC} $1"
}

# Verify Homebrew is available
if ! command -v brew &>/dev/null; then
    log_error "Homebrew not found. Please install Homebrew first."
    exit 1
fi

# Ensure configs directory exists
mkdir -p ../configs

log_info "Saving current Homebrew cask applications..."

# Get list of installed cask applications
cask_apps=$(brew list --cask 2>/dev/null | sort)

if [ -z "$cask_apps" ]; then
    log_warning "No cask applications found. Creating empty config file."
    echo "# Homebrew Cask Applications" > ../configs/brew_cask_apps.txt
    echo "# Saved on: $(date)" >> ../configs/brew_cask_apps.txt
    echo "# No applications installed" >> ../configs/brew_cask_apps.txt
else
    # Save to config file with timestamp and comments
    {
        echo "# Homebrew Cask Applications"
        echo "# Saved on: $(date)"
        echo "# Run: ./scripts/install_brew_apps.sh to install these applications"
        echo ""
        echo "$cask_apps"
    } > ../configs/brew_cask_apps.txt
    
    log_success "Saved $(echo "$cask_apps" | wc -l | tr -d ' ') cask applications to configs/brew_cask_apps.txt"
fi

# Also create a Brewfile for complete Homebrew state
log_info "Creating complete Brewfile..."
brew bundle dump --file=../configs/Brewfile --force

log_success "Current Homebrew applications saved to:"
echo "  • configs/brew_cask_apps.txt - Cask applications only"
echo "  • configs/Brewfile - Complete Homebrew state (formulae + casks)"
echo ""
log_info "To install these applications on another machine:"
echo "  Run: ./scripts/install_brew_apps.sh" 