#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run as root (use sudo)"
  exit 1
fi

# List of packages to install
packages=(
    linux-lts-headers
    waybar
    kitty
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
    pamixer
    hyprpaper
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-desktop-portal-kde
    systemsettings
    qt5-wayland
    qt6-wayland
    power-profiles-daemon
    libnotify
    cargo
    ttf-jetbrains-mono
    ttf-0xproto-nerd
    xdg-user-dirs
    man-db
    man-pages
    texinfo
    gnome-keyring
    libsecret
    qtkeychain-qt6
    btop
    ddcutil
    kate
    broadcom-wl-dkms
    dosfstools
    firewalld
    intel-media-driver
    kde-gtk-config
    vulkan-intel
    mesa
    vulkan-radeon
    bluez
    bluez-utils
    bluez-deprecated-tools
    hyprlock
    rofi
    nwg-look
    greetd
    fzf
    wl-clipboard
    hypridle
    cava
    wl-clip-persist
    dunst
    mpv-mpris
    github-cli
    uv
    starship
    obs-studio
    yt-dlp
    kio-admin
    xorg-xhost
    timeshift
    eza
    okular
    satty
    hyprshot
    lib32-mesa
    xf86-video-amdgpu
    lib32-vulkan-radeon
    cmake
)

echo "📦 Installing packages: ${packages[*]}"

# Update system and install packages
pacman -Syu --noconfirm

for pkg in "${packages[@]}"; do
  if pacman -Qi "$pkg" &>/dev/null; then
    echo "📥 $pkg is already installed"
  else
    echo "⬇️ Installing $pkg..."
    yes | pacman -S --noconfirm "$pkg"
  fi
done

echo "✔️ All packages processed."
























