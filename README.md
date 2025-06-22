# Universal macOS Development Environment Setup

A streamlined, automated setup script for any macOS device that installs and configures a complete development environment with essential tools, applications, and optimizations.

## 🚀 Quick Start

```bash
git clone <this-repo>
cd setup
chmod +x setup.sh
./setup.sh
```

That's it! The script will handle everything automatically.

## 📋 What Gets Installed & Configured

### Essential Development Tools
- **Homebrew** - Package manager for macOS
- **Git** - Version control system
- **Node.js** - JavaScript runtime
- **Python 3** - Programming language
- **Go** - Programming language
- **PostgreSQL** - Database system
- **Flutter** - Framework

### CLI Tools & Utilities
- `curl`, `wget` - Download tools
- `tree` - Directory visualization
- `htop` - System monitor
- `jq` - JSON processor
- `z` - Smart directory jumping
- `fzf` - Fuzzy finder
- `ripgrep` (rg) - Fast text search
- `bat` - Better cat with syntax highlighting
- `eza` - Modern ls replacement
- `fd` - Better find
- `tldr` - Simplified man pages
- `ncdu` - Disk usage analyzer

### GUI Applications
- **Cursor** - AI-powered code editor
- **Visual Studio Code** - Code editor
- **iTerm2** - Terminal emulator
- **Docker Desktop** - Containerization platform
- **Postman** - API testing tool
- **IINA** - Modern media player
- **Obsidian** - Knowledge management
- **Raycast** - Spotlight replacement
- **Rectangle** - Window management
- **Stats** - System monitor in menu bar
- **Telegram** - Messaging app
- **The Unarchiver** - Archive utility
- **Karabiner Elements** - Keyboard customization

### Terminal & Shell Setup
- **Zsh** as default shell
- **Oh My Zsh** - Zsh framework
- **Powerlevel10k** - Modern terminal theme
- **Zsh plugins**:
  - autosuggestions
  - syntax highlighting
  - completions
  - git integration
  - brew integration
  - and more...

### System Optimizations
- Keyboard repeat rate optimization
- Finder enhancements (show hidden files, extensions)
- Dock optimization (faster animations)
- Safari development settings
- Security improvements
- Developer-friendly defaults

### Keyboard Enhancements (Karabiner)
- **Left Shift + P** → Backspace (development friendly)
- **Caps Lock ↔ Escape** (swap keys)
- **Cmd + HJKL** → Arrow Keys (Vim-style navigation)

## 📁 Project Structure

```
setup/
├── setup.sh                 # Main setup script
├── scripts/
│   ├── homebrew.sh          # Homebrew & package installation
│   ├── zsh-setup.sh         # Terminal & shell configuration  
│   ├── karabiner.sh         # Keyboard customization
│   ├── macos-defaults.sh    # System preferences
│   └── applications.sh      # Additional applications
├── configs/                 # Backup of all configurations
├── download_manual_apps.sh  # Manual download helper
├── verify_apps.sh          # Installation verification
└── README.md
```

## 🔧 Script Details

### `setup.sh` - Main Orchestrator
- Verifies macOS compatibility
- Installs Xcode Command Line Tools
- Runs all setup scripts in order
- Verifies installations
- Provides next steps

### `scripts/homebrew.sh` - Package Management
- Installs Homebrew for both Intel and Apple Silicon Macs
- Installs essential CLI tools and development packages
- Installs GUI applications via Homebrew Cask
- Creates Brewfile for future installations
- Verifies all tools are accessible

### `scripts/zsh-setup.sh` - Terminal Setup
- Sets Zsh as default shell
- Installs Oh My Zsh framework
- Installs Powerlevel10k theme
- Configures useful plugins
- Creates optimized .zshrc with aliases
- Verifies installation

### `scripts/karabiner.sh` - Keyboard Customization
- Creates Karabiner Elements configuration
- Sets up development-friendly key mappings
- Configures function keys
- Creates backup of configuration

### `scripts/macos-defaults.sh` - System Optimization
- Optimizes Finder settings
- Configures keyboard and trackpad
- Sets up Dock preferences
- Applies security settings
- Enables developer-friendly defaults

### `scripts/applications.sh` - Additional Apps
- Attempts to install additional apps via Homebrew
- Creates manual download script for unavailable apps
- Creates verification script

## 🔍 Verification

After installation, verify everything is working:

```bash
# Check installed applications
./verify_apps.sh

# Verify essential tools
which brew git node python3 zsh

# Check Homebrew packages
brew list
```

## 📱 Manual Installation Required

Some applications require manual installation:

```bash
# Open download pages for manual installation
./download_manual_apps.sh
```

### App Store Applications
- DaisyDisk
- Amphetamine  
- Magnet
- 1Password

### Commercial Software (Purchase Required)
- CleanMyMac
- Microsoft Office
- Screen Studio

## ⚡ Post-Installation Steps

1. **Restart your terminal** or run:
   ```bash
   source ~/.zshrc
   ```

2. **Configure Powerlevel10k**:
   ```bash
   p10k configure
   ```

3. **Grant Karabiner permissions**:
   - System Preferences → Security & Privacy → Privacy
   - Add Karabiner Elements to Input Monitoring and Accessibility

4. **Configure applications** as needed

##  Customization

### Homebrew Application Management

The setup includes two scripts for managing Homebrew applications:

#### `scripts/save_brew_apps.sh` - Save Current Applications
Saves your current Homebrew cask applications to a config file for future use:

```bash
./scripts/save_brew_apps.sh
```

This creates:
- `configs/brew_cask_apps.txt` - List of cask applications
- `configs/Brewfile` - Complete Homebrew state (formulae + casks)

#### `scripts/install_brew_apps.sh` - Install from Config
Installs applications from your saved configuration:

```bash
./scripts/install_brew_apps.sh
```

This script:
- First tries to use the Brewfile (recommended)
- Falls back to the cask applications list
- Skips already installed applications
- Reports success/failure for each application

#### Usage Workflow
1. **On your current machine**: Run `./scripts/save_brew_apps.sh` to save your applications
2. **On a new machine**: Run `./scripts/install_brew_apps.sh` to install the same applications
3. **Update config**: Re-run `save_brew_apps.sh` whenever you install new applications

### Adding More Packages
Edit `scripts/homebrew.sh` and add to the appropriate arrays:
- `essential_apps=()` for GUI applications
- `optional_apps=()` for region-specific apps

### Modifying Zsh Configuration
Edit `scripts/zsh-setup.sh` or modify `~/.zshrc` after installation.

### Changing System Preferences
Edit `scripts/macos-defaults.sh` to add or modify macOS defaults.

### Keyboard Mappings
Edit `scripts/karabiner.sh` to modify key mappings.

## 🔄 Updating

To update packages:
```bash
brew update && brew upgrade
brew cleanup
```

To reinstall everything:
```bash
./setup.sh
```

## 🆘 Troubleshooting

### Command Line Tools Installation Hangs
- Cancel and manually install: `xcode-select --install`
- Re-run the setup script

### Homebrew Not in PATH
```bash
# Apple Silicon
eval "$(/opt/homebrew/bin/brew shellenv)"

# Intel
eval "$(/usr/local/bin/brew shellenv)"
```

### Zsh Not Default Shell
```bash
chsh -s $(which zsh)
```

### Permission Denied Errors
Some applications may need additional permissions in System Preferences.

## 🌟 Features

- **Universal**: Works on both Intel and Apple Silicon Macs
- **Streamlined**: Minimal user interaction required
- **Verified**: Checks that installations are accessible
- **Recoverable**: All configurations backed up
- **Documented**: Clear logging of all operations
- **Flexible**: Easy to customize and extend

## 📝 License

This setup script is provided as-is for personal use. Individual software packages are subject to their respective licenses.

---

**Ready to transform your Mac into a powerful development machine? Run `./setup.sh` and get coding! 🚀** 
