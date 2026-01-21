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
    hyprpolkitagent
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-desktop-portal-kde
    systemsettings
    qt5-wayland
    qt6-wayland
    power-profiles-daemon
    libnotify
    ttf-jetbrains-mono
    ttf-0xproto-nerd
    xdg-user-dirs
    man-db
    man-pages
    texinfo
    libsecret
    qtkeychain-qt6
    btop
    ddcutil
    kate
    dosfstools
    firewalld
    kde-gtk-config
    mesa
#    lib32-mesa
    opencl-mesa
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
    satty
    dunst
    mpv-mpris
    github-cli
    uv
    starship
    obs-studio
    yt-dlp
    kio-admin
    xorg-xhost
    eza
    okular
    hyprshot
    cmake
    usbutils
    lshw
    kcalc
    libreoffice-still
    docker
    lm_sensors
    unrar
    exfat-utils
    kwallet
    kwalletmanager
    kwallet-pam
    ksshaskpass
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
