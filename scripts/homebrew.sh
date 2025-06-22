#!/bin/bash

# Streamlined Homebrew Setup for Universal macOS Development Environment

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[HOMEBREW]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[HOMEBREW]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[HOMEBREW]${NC} $1"
}

log_error() {
    echo -e "${RED}[HOMEBREW]${NC} $1"
}

# Install Homebrew
if ! command -v brew &>/dev/null; then
    log_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Configure Homebrew environment
log_info "Configuring Homebrew environment..."
if [[ $(uname -m) == "arm64" ]]; then
    # Apple Silicon Mac
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
else
    # Intel Mac
    eval "$(/usr/local/bin/brew shellenv)"
    echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
fi

# Verify Homebrew is accessible
if ! command -v brew &>/dev/null; then
    log_error "Failed to configure Homebrew in PATH"
    exit 1
fi

log_info "Updating Homebrew..."
brew update

# Install CLI tools (no --cask needed)
log_info "Installing CLI tools..."
brew install \
    git \
    curl \
    wget \
    tree \
    htop \
    jq \
    z \
    fzf \
    ripgrep \
    bat \
    eza \
    fd \
    tldr \
    ncdu \
    node \
    python3 \
    go \
    postgresql@16 \ 
    flutter \
    fvm 

# Install GUI applications (requires --cask)
log_info "Installing GUI applications..."

# All GUI applications with category comments
gui_apps=(
    # Browsers
    "google-chrome"
    "yandex"
    
    # Development Tools
    "cursor"
    "visual-studio-code"
    "docker"
    "postman"
    "postgres-unofficial"
    
    # Terminal & System
    "iterm2"
    "karabiner-elements"
    "raycast"
    "rectangle"
    "stats"
    "jordanbaird-ice"
    
    # Media & Entertainment
    "iina"
    "vlc"
    
    # Productivity
    "obsidian"
    "telegram"
    "zoom"
    
    # Utilities
    "the-unarchiver"
    "utm"
    "plash"
    "stretchy"
    
    # Design & Graphics
)

# Install GUI applications
installed_apps=()
failed_apps=()

for app in "${gui_apps[@]}"; do
    # Skip comment lines
    if [[ "$app" =~ ^#.* ]]; then
        continue
    fi
    
    log_info "Installing $app..."
    if brew install --cask "$app" 2>/dev/null; then
        log_success "$app installed successfully"
        installed_apps+=("$app")
    else
        log_info "$app not available via Homebrew - will be added to manual download list"
        failed_apps+=("$app")
    fi
done

# Report installation results
if [ ${#installed_apps[@]} -gt 0 ]; then
    log_success "Successfully installed GUI applications:"
    printf '  • %s\n' "${installed_apps[@]}"
fi

if [ ${#failed_apps[@]} -gt 0 ]; then
    log_info "Applications not available via Homebrew (added to manual download):"
    printf '  • %s\n' "${failed_apps[@]}"
fi

# Clean up
log_info "Cleaning up Homebrew cache..."
brew cleanup

# Create Brewfile for future reference
log_info "Creating Brewfile for future installations..."
mkdir -p ../configs
brew bundle dump --file=../configs/Brewfile --force

# Verify essential tools are accessible
log_info "Verifying essential tools..."
essential_tools=("git" "node" "python3" "brew" "code" "cursor")
failed_tools=()

for tool in "${essential_tools[@]}"; do
    if command -v "$tool" &>/dev/null; then
        log_success "$tool is accessible"
    else
        # Some tools might have different command names
        case "$tool" in
            "code")
                if command -v "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" &>/dev/null; then
                    log_success "$tool is accessible (VS Code)"
                else
                    failed_tools+=("$tool")
                fi
                ;;
            "cursor")
                if [[ -d "/Applications/Cursor.app" ]]; then
                    log_success "$tool is accessible (Cursor app installed)"
                else
                    failed_tools+=("$tool")
                fi
                ;;
            *)
                failed_tools+=("$tool")
                ;;
        esac
    fi
done

if [ ${#failed_tools[@]} -gt 0 ]; then
    log_warning "The following tools are not accessible in PATH (may need terminal restart):"
    printf '  • %s\n' "${failed_tools[@]}"
else
    log_success "All essential tools verified and accessible"
fi

log_success "Homebrew setup completed successfully!"
log_info "Brewfile created at configs/Brewfile" 