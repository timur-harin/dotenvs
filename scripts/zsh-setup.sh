#!/bin/bash

# Streamlined Zsh and Terminal Setup

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[ZSH]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[ZSH]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[ZSH]${NC} $1"
}

# Set Zsh as default shell
if [[ "$SHELL" != *"zsh"* ]]; then
    log_info "Setting Zsh as default shell..."
    chsh -s $(which zsh)
fi

# Install Oh My Zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    log_info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Powerlevel10k theme
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
    log_info "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Install Zsh plugins
log_info "Installing Zsh plugins..."

plugins_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

# zsh-autosuggestions
if [[ ! -d "$plugins_dir/zsh-autosuggestions" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$plugins_dir/zsh-autosuggestions"
fi

# zsh-syntax-highlighting
if [[ ! -d "$plugins_dir/zsh-syntax-highlighting" ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$plugins_dir/zsh-syntax-highlighting"
fi

# zsh-completions
if [[ ! -d "$plugins_dir/zsh-completions" ]]; then
    git clone https://github.com/zsh-users/zsh-completions "$plugins_dir/zsh-completions"
fi

# Create optimized .zshrc configuration
log_info "Creating optimized .zshrc configuration..."
cat > ~/.zshrc << 'EOF'
# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
    git
    brew
    macos
    node
    npm
    python
    docker
    z
    fzf
    colored-man-pages
    command-not-found
    common-aliases
    history
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Custom aliases for better development experience
alias ll='eza -la --git'
alias la='eza -a'
alias l='eza -l'
alias tree='eza --tree'
alias cat='bat'
alias find='fd'
alias grep='rg'
alias top='htop'
alias du='ncdu'

# Homebrew environment
if [[ $(uname -m) == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

# FZF integration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
EOF

# Create configs backup
mkdir -p ../configs
cp ~/.zshrc ../configs/.zshrc

# Verify zsh setup
log_info "Verifying Zsh setup..."
if [[ -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]]; then
    log_success "Oh My Zsh installation verified"
else
    log_error "Oh My Zsh installation failed"
    exit 1
fi

if [[ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
    log_success "Powerlevel10k installation verified"
else
    log_error "Powerlevel10k installation failed"
    exit 1
fi

log_success "Zsh setup completed successfully!"
log_info "Configuration backed up to configs/.zshrc"
log_warning "To complete setup:"
echo "  1. Restart your terminal"
echo "  2. Run 'p10k configure' to customize your prompt" 