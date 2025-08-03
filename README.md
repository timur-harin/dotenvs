# macOS Development Environment Setup

A comprehensive setup script for configuring a macOS development environment with all essential tools and applications.

## 🚀 Quick Start

```bash
# Clone the repository
git clone <repository-url>
cd setup

# Run the complete setup
./setup.sh
```

## 📦 What's Included

### Core Development Tools
- **Homebrew** - Package manager for macOS
- **Git** - Version control
- **Go** - Go programming language
- **PostgreSQL 16** - Database server
- **Flutter** - Mobile app development framework
- **Node.js** - JavaScript runtime
- **Python 3.13** - Python programming language

### Terminal & Shell
- **iTerm2** - Advanced terminal emulator
- **Oh My Zsh** - Zsh configuration framework
- **Powerlevel10k** - Fast and feature-rich Zsh theme
- **Zsh plugins** - Autosuggestions, syntax highlighting, completions

### Development Applications
- **Cursor** - AI-powered code editor
- **Visual Studio Code** - Code editor
- **Android Studio** - Android development IDE
- **Docker Desktop** - Container platform
- **Postman** - API development platform
- **Raycast** - Productivity launcher
- **Rectangle** - Window management
- **Stats** - System monitoring

### System Utilities
- **Karabiner-Elements** - Keyboard customizer
- **The Unarchiver** - Archive extractor
- **UTM** - Virtual machine manager
- **Cyberduck** - File transfer client
- **iMazing** - iOS device manager
- **LM Studio** - Local AI models
- **Motrix** - Download manager

### Media & Entertainment
- **IINA** - Video player
- **VLC** - Media player
- **WebTorrent** - Torrent client
- **Yandex Music** - Music streaming

### Communication
- **Telegram** - Messaging app
- **WhatsApp** - Messaging app
- **Zoom** - Video conferencing

### Browsers & Web
- **Google Chrome** - Web browser
- **Yandex Browser** - Web browser
- **Figma** - Design tool

### Productivity
- **Obsidian** - Note-taking app
- **Outline Manager** - VPN manager
- **Stretchly** - Break reminder
- **PearCleaner** - System cleaner

### Database Tools
- **PostgreSQL Unofficial** - Database GUI
- **OpenLens** - Kubernetes IDE
- **OpenInTerminal** - Terminal integration

## 📋 Current Application List (37 Total)

### Homebrew Cask Applications
- android-studio
- crystalfetch
- cursor
- cyberduck
- docker
- docker-desktop
- figma
- flutter
- google-chrome
- iina
- imazing
- iterm2
- jordanbaird-ice
- karabiner-elements
- lm-studio
- motrix
- obsidian
- openinterminal
- openlens
- outline-manager
- pearcleaner
- postgres-unofficial
- raycast
- rectangle
- stats
- stretchly
- telegram
- the-unarchiver
- utm
- visual-studio-code
- vlc
- webtorrent
- whatsapp
- windows-app
- yandex
- yandex-disk
- zoom

### Homebrew Formulae
- bat (better cat)
- curl
- eza (better ls)
- fd (better find)
- fzf (fuzzy finder)
- git
- go
- htop (better top)
- jq (JSON processor)
- ncdu (disk usage)
- node
- postgresql@14
- postgresql@16
- python@3.13
- ripgrep (better grep)
- tldr (simplified man pages)
- tree
- wget
- z (smart cd)
- fvm (Flutter version manager)

## 🛠️ Scripts

### Main Setup Scripts
- `setup.sh` - Complete environment setup
- `scripts/homebrew.sh` - Homebrew installation and configuration
- `scripts/applications.sh` - Application installation and management
- `scripts/zsh-setup.sh` - Zsh and terminal configuration
- `scripts/macos-defaults.sh` - macOS system preferences optimization
- `scripts/karabiner.sh` - Keyboard customization

### Management Scripts
- `scripts/save_brew_apps.sh` - Save current Homebrew applications to config
- `scripts/install_brew_apps.sh` - Install applications from saved config
- `verify_apps.sh` - Check which applications are installed
- `download_manual_apps.sh` - Open download pages for manual installation

## 🔧 Configuration Files

### System Configuration
- `configs/.zshrc` - Zsh configuration
- `configs/karabiner.json` - Keyboard mapping configuration
- `configs/RectangleConfig.json` - Window management configuration
- `configs/Stats.plist` - System monitoring configuration

### Application Lists
- `configs/brew_cask_apps.txt` - Homebrew cask applications list
- `configs/Brewfile` - Complete Homebrew state (formulae + casks)

## 📝 Manual Installation

Some applications are not available via Homebrew and need to be installed manually

## 🔄 Updating Applications

```bash
# Update Homebrew and all packages
brew update && brew upgrade

# Save current application state
./scripts/save_brew_apps.sh

# Verify installed applications
./verify_apps.sh
```

## 🎯 Features

- **Automated Setup** - One-command installation of all development tools
- **Configuration Management** - All settings backed up and version controlled
- **Application Tracking** - Comprehensive list of installed applications
- **Easy Updates** - Simple scripts for updating and managing applications
- **Cross-Platform Ready** - Works on both Intel and Apple Silicon Macs
- **Developer Optimized** - macOS settings optimized for development workflow

## 🚨 Requirements

- macOS 10.15 (Catalina) or later
- Administrator privileges
- Internet connection

## 🔄 Maintenance

Regular maintenance tasks:

```bash
# Update all packages
brew update && brew upgrade

# Clean up old packages
brew cleanup

# Save current state
./scripts/save_brew_apps.sh

# Verify everything is working
./verify_apps.sh
```

## 📊 Statistics

- **Total Applications**: 37 Homebrew cask applications
- **Total Formulae**: 20 Homebrew formulae
- **Configuration Files**: 6 system configuration files
- **Scripts**: 8 management and setup scripts
- **Manual Applications**: 50+ additional applications available

## 🎉 Getting Started

After running the setup:

1. **Restart your terminal** to load new Zsh configuration
2. **Run `p10k configure`** to customize your terminal prompt
3. **Grant permissions** for Karabiner-Elements in System Preferences
4. **Install manual applications** using `./download_manual_apps.sh`
5. **Verify installation** with `./verify_apps.sh`

Your development environment is now ready! 🚀 
