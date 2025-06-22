#!/bin/bash

# Streamlined Karabiner Elements Setup

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[KARABINER]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[KARABINER]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[KARABINER]${NC} $1"
}

log_error() {
    echo -e "${RED}[KARABINER]${NC} $1"
}

# Create Karabiner config directory
KARABINER_CONFIG_DIR="$HOME/.config/karabiner"
mkdir -p "$KARABINER_CONFIG_DIR"

log_info "Setting up Karabiner Elements configuration..."

# Check if config file exists
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
CONFIG_SOURCE="$PROJECT_ROOT/configs/karabiner.json"

if [[ ! -f "$CONFIG_SOURCE" ]]; then
    log_error "Configuration file not found: $CONFIG_SOURCE"
    log_info "Please ensure the karabiner.json file exists in the configs directory"
    exit 1
fi

log_info "Using configuration from: $CONFIG_SOURCE"

# Copy configuration from configs directory
log_info "Copying Karabiner configuration from configs/karabiner.json..."
cp -f "$CONFIG_SOURCE" "$KARABINER_CONFIG_DIR/karabiner.json"

# Verify configuration exists
if [[ -f "$KARABINER_CONFIG_DIR/karabiner.json" ]]; then
    log_success "Karabiner Elements configuration copied successfully"
    
    # Verify file size to ensure it was copied correctly
    SOURCE_SIZE=$(stat -f%z "$CONFIG_SOURCE" 2>/dev/null || stat -c%s "$CONFIG_SOURCE" 2>/dev/null)
    TARGET_SIZE=$(stat -f%z "$KARABINER_CONFIG_DIR/karabiner.json" 2>/dev/null || stat -c%s "$KARABINER_CONFIG_DIR/karabiner.json" 2>/dev/null)
    
    if [[ "$SOURCE_SIZE" == "$TARGET_SIZE" ]]; then
        log_success "Configuration file verified (${SOURCE_SIZE} bytes)"
    else
        log_warning "File size mismatch - configuration may not have copied correctly"
        log_info "Source: ${SOURCE_SIZE} bytes, Target: ${TARGET_SIZE} bytes"
    fi
else
    log_error "Failed to copy Karabiner configuration"
    exit 1
fi

log_info "Key mappings configured:"
# TODO: add key mappings

log_warning "Required: Grant permissions in System Preferences > Security & Privacy > Privacy:"
echo "  • Input Monitoring: Karabiner Elements"
echo "  • Accessibility: Karabiner Elements"

log_success "Karabiner Elements setup completed!" 