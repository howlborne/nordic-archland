#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run as root (use sudo)"
  exit 1
fi

# List of packages to install
packages=(
    waybar
    alacritty
    dolphin
    ark
    ntfs-3g
    fastfetch
    noto-fonts
    pipewire
    wireplumber
    pipewire-audio
    pipewire-alsa
    pipewire-pulse
    pipewire-jack
    pamixer
    hyprpaper
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-desktop-portal-kde
    systemsettings
    qt5-wayland
    qt6-wayland
    nerd-fonts
    mako
    power-profiles-daemon
    libnotify
    celluloid
    cargo
    ttf-jetbrains-mono
    xdg-user-dirs
    man-db
    man-pages
    texinfo
    hyprpolkitagent
    gnome-keyring
    libsecret
    qtkeychain-qt6
    btop
    ddcutil
)

echo "📦 Installing packages: ${packages[*]}"

# Update system and install packages
pacman -Syu --noconfirm

for pkg in "${packages[@]}"; do
  if pacman -Qi "$pkg" &>/dev/null; then
    echo "✅ $pkg is already installed"
  else
    echo "⬇️ Installing $pkg..."
    pacman -S --noconfirm "$pkg"
  fi
done

echo "✅ All packages processed."
























