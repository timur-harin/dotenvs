#!/bin/bash

# Streamlined macOS System Preferences for Development

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[MACOS]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[MACOS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[MACOS]${NC} $1"
}

# Close System Preferences to prevent conflicts
osascript -e 'tell application "System Preferences" to quit' 2>/dev/null || true

log_info "Optimizing macOS system preferences for development..."

# === GENERAL SYSTEM SETTINGS ===
log_info "Configuring general system settings..."

# Show hidden files and extensions
chflags nohidden ~/Library
defaults write com.apple.finder AppleShowAllFiles YES
defaults write -g AppleShowAllExtensions true

# Disable app quarantine dialog
defaults write com.apple.LaunchServices LSQuarantine false

# Save to disk by default (not iCloud)
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud false

# === KEYBOARD & INPUT ===
log_info "Optimizing keyboard and input settings..."

# Disable press-and-hold for accented characters (enable key repeat)
defaults write -g ApplePressAndHoldEnabled false
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable auto-correct and auto-substitutions
defaults write -g NSAutomaticCapitalizationEnabled false
defaults write -g NSAutomaticDashSubstitutionEnabled false
defaults write -g NSAutomaticPeriodSubstitutionEnabled false
defaults write -g NSAutomaticQuoteSubstitutionEnabled false
defaults write -g NSAutomaticSpellingCorrectionEnabled false

# Increase trackpad tracking speed
defaults write -g com.apple.trackpad.scaling 3

# Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# === FINDER SETTINGS ===
log_info "Optimizing Finder..."

# Keep folders on top when sorting
defaults write com.apple.finder _FXSortFoldersFirst true

# Disable extension change warnings
defaults write com.apple.finder FXEnableExtensionChangeWarning false

# Prevent .DS_Store files on network and USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
defaults write com.apple.desktopservices DSDontWriteUSBStores true

# Show path and status bars
defaults write com.apple.finder ShowPathbar true
defaults write com.apple.finder ShowStatusBar true

# Use list view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable empty trash warning
defaults write com.apple.finder WarnOnEmptyTrash false

# === DOCK SETTINGS ===
log_info "Optimizing Dock..."

# Faster dock auto-hide
defaults write com.apple.dock autohide-delay -float 0.1
defaults write com.apple.dock autohide-time-modifier -float 0.3

# Hide recent applications
defaults write com.apple.dock show-recents false

# Faster minimize effect
defaults write com.apple.dock "mineffect" -string "scale"

# Disable launch animation
defaults write com.apple.dock launchanim -bool false

# === SECURITY ===
log_info "Configuring security settings..."

# Require password immediately after sleep
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# === SAFARI ===
log_info "Optimizing Safari..."

# Show full URL in address bar
defaults write com.apple.Safari ShowFullURLInSmartSearchField true 2>/dev/null || true

# Don't auto-open downloads
defaults write com.apple.Safari AutoOpenSafeDownloads false 2>/dev/null || true

# Enable debug and develop menus
defaults write com.apple.Safari IncludeInternalDebugMenu true 2>/dev/null || true
defaults write com.apple.Safari IncludeDevelopMenu true 2>/dev/null || true

# === DEVELOPER OPTIMIZATIONS ===
log_info "Applying developer-friendly settings..."

# Expand save and print panels by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Show battery percentage in menu bar
defaults write com.apple.menuextra.battery ShowPercent YES

# Disable automatic app termination
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Disable sound effects
defaults write -g "com.apple.sound.beep.feedback" -bool false

# Mail: Copy email without names
defaults write com.apple.mail AddressesIncludeNameOnPasteboard false

log_info "Restarting affected services..."

# Restart services to apply changes
killall Finder 2>/dev/null || true
killall Dock 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

log_success "macOS system preferences optimized for development!"
log_warning "Some changes may require a restart to take full effect." 