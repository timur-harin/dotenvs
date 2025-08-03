#!/bin/bash

# Verify installed applications

echo "Checking installed applications..."

# Get applications from brew cask list
if [[ -f "configs/brew_cask_apps.txt" ]]; then
    echo "Loading applications from brew_cask_apps.txt..."
    brew_apps=()
    while IFS= read -r line; do
        # Skip comments and empty lines
        if [[ ! "$line" =~ ^[[:space:]]*# ]] && [[ -n "$line" ]]; then
            brew_apps+=("$line")
        fi
    done < "configs/brew_cask_apps.txt"
else
    echo "brew_cask_apps.txt not found, using default list..."
    brew_apps=(
        "cursor"
        "visual-studio-code"
        "iterm2"
        "docker"
        "docker-desktop"
        "postman"
        "iina"
        "obsidian"
        "raycast"
        "rectangle"
        "stats"
        "telegram"
        "the-unarchiver"
        "karabiner-elements"
        "google-chrome"
        "figma"
        "android-studio"
        "flutter"
        "cyberduck"
        "imazing"
        "jordanbaird-ice"
        "lm-studio"
        "motrix"
        "outline-manager"
        "pearcleaner"
        "postgres-unofficial"
        "stretchly"
        "utm"
        "vlc"
        "webtorrent"
        "whatsapp"
        "windows-app"
        "yandex"
        "yandex-disk"
        "zoom"
        "openinterminal"
        "openlens"
        "crystalfetch"
    )
fi

# Combine all apps to check
all_apps=("${brew_apps[@]}" "${additional_apps[@]}")

installed=()
missing=()
brew_installed=()
brew_missing=()

echo ""
echo "=== Checking Homebrew Cask Applications ==="

for app in "${brew_apps[@]}"; do
    # Convert app name to display name (remove hyphens, capitalize)
    display_name=$(echo "$app" | sed 's/-/ /g' | sed 's/\b\w/\U&/g')
    
    # Check if app is installed via Homebrew
    if brew list --cask "$app" &>/dev/null; then
        brew_installed+=("$display_name")
        echo "✅ $display_name (Homebrew)"
    else
        # Check if app exists in Applications folder
        app_name=$(echo "$app" | sed 's/-/ /g' | sed 's/\b\w/\U&/g')
        if [[ -d "/Applications/${app_name}.app" ]]; then
            installed+=("$display_name")
            echo "✅ $display_name (Applications)"
        else
            brew_missing+=("$display_name")
            echo "❌ $display_name"
        fi
    fi
done


echo ""
echo "=== SUMMARY ==="
echo "✅ Homebrew Cask Applications Installed:"
if [[ ${#brew_installed[@]} -gt 0 ]]; then
    printf '  • %s\n' "${brew_installed[@]}"
else
    echo "  None found"
fi

echo ""
echo "✅ Additional Applications Installed:"
if [[ ${#installed[@]} -gt 0 ]]; then
    printf '  • %s\n' "${installed[@]}"
else
    echo "  None found"
fi

if [[ ${#brew_missing[@]} -gt 0 ]]; then
    echo ""
    echo "❌ Missing Homebrew Applications:"
    printf '  • %s\n' "${brew_missing[@]}"
    echo ""
    echo "Run './scripts/install_brew_apps.sh' to install missing Homebrew applications"
fi


echo ""
echo "Applications verification completed!"
echo "Total Homebrew apps checked: ${#brew_apps[@]}"
echo "Total installed: $((${#brew_installed[@]} + ${#installed[@]}))"
echo "Total missing: $((${#brew_missing[@]} + ${#missing[@]}))"
