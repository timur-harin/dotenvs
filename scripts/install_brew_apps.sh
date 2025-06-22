#!/bin/bash

# Install Homebrew Applications from Config
# This script installs applications from the saved brew_cask_apps.txt config file

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INSTALL]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[INSTALL]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[INSTALL]${NC} $1"
}

log_error() {
    echo -e "${RED}[INSTALL]${NC} $1"
}

# Verify Homebrew is available
if ! command -v brew &>/dev/null; then
    log_error "Homebrew not found. Please install Homebrew first."
    exit 1
fi

# Check if config file exists
CONFIG_FILE="../configs/brew_cask_apps.txt"
BREWFILE="../configs/Brewfile"

if [ ! -f "$CONFIG_FILE" ] && [ ! -f "$BREWFILE" ]; then
    log_error "No configuration files found!"
    echo "Please run './scripts/save_brew_apps.sh' first to save your current applications."
    exit 1
fi

log_info "Installing Homebrew applications from config..."

# Method 1: Try using Brewfile first (recommended)
if [ -f "$BREWFILE" ]; then
    log_info "Found Brewfile - installing complete Homebrew state..."
    if brew bundle --file="$BREWFILE"; then
        log_success "Successfully installed applications from Brewfile"
        exit 0
    else
        log_warning "Brewfile installation failed, falling back to cask list..."
    fi
fi

# Method 2: Fallback to cask applications list
if [ -f "$CONFIG_FILE" ]; then
    log_info "Installing cask applications from config file..."
    
    # Read applications from config file, skipping comments and empty lines
    apps=()
    while IFS= read -r line; do
        # Skip comments and empty lines
        if [[ ! "$line" =~ ^[[:space:]]*# ]] && [[ -n "$line" ]]; then
            apps+=("$line")
        fi
    done < "$CONFIG_FILE"
    
    if [ ${#apps[@]} -eq 0 ]; then
        log_warning "No applications found in config file"
        exit 0
    fi
    
    log_info "Found ${#apps[@]} applications to install..."
    
    installed_apps=()
    failed_apps=()
    already_installed=()
    
    for app in "${apps[@]}"; do
        # Check if already installed
        if brew list --cask "$app" &>/dev/null; then
            log_info "$app is already installed"
            already_installed+=("$app")
            continue
        fi
        
        log_info "Installing $app..."
        if brew install --cask "$app" 2>/dev/null; then
            log_success "$app installed successfully"
            installed_apps+=("$app")
        else
            log_warning "$app installation failed"
            failed_apps+=("$app")
        fi
    done
    
    # Report results
    echo ""
    if [ ${#already_installed[@]} -gt 0 ]; then
        log_info "Already installed:"
        printf '  • %s\n' "${already_installed[@]}"
    fi
    
    if [ ${#installed_apps[@]} -gt 0 ]; then
        log_success "Successfully installed:"
        printf '  • %s\n' "${installed_apps[@]}"
    fi
    
    if [ ${#failed_apps[@]} -gt 0 ]; then
        log_warning "Failed to install:"
        printf '  • %s\n' "${failed_apps[@]}"
        echo ""
        log_info "These applications may not be available via Homebrew anymore"
        log_info "Check: https://formulae.brew.sh/cask/ for current availability"
    fi
else
    log_error "No configuration files found!"
    echo "Please run './scripts/save_brew_apps.sh' first to save your current applications."
    exit 1
fi

log_success "Homebrew applications installation completed!" 