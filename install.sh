#!/usr/bin/env bash

echo "Starting Setup for Fedora...."
echo " "

# Clean garbage
echo "Clearing garbage...."
sudo dnf clean all -y
echo " "

# Install terra repo
echo "Installing terra...."
sudo dnf install --nogpgcheck --repofrompath "terra,https://repos.fyralabs.com/terra\$releasever" terra-release

# Update Fedora
echo "Updating system....."
sudo dnf update -y

# Make internet fast
echo "Making your internet fast...."
sudo cp -r dnf.conf /etc/dnf/
echo ""

# Install core packages
echo "Installing packages...."
sudo dnf install -y \
    glibc \
    wayland-devel \
    wayland-protocols-devel \
    libinput \
    libdrm \
    libxkbcommon \
    pixman \
    git \
    meson \
    ninja-build \
    libdisplay-info \
    libliftoff \
    hwdata \
    libseat \
    pcre2 \
    xorg-x11-server-Xwayland \
    libxcb \
    dnf-plugins-core \
    mate-polkit \
    foot \
    kitty \
    nemo \
    nemo-fileroller \
    gnome-text-editor \
    firefox \
    xdg-user-dirs

# Update xdg-user-dirs
xdg-user-dirs-update

# Install Noctalia Shell
echo "Installing noctalia-shell...."
sudo dnf copr enable zhangyi6324/noctalia-shell -y
sudo dnf install -y noctalia-shell

echo "Your quickshell is ready!"

# Install Zen Browser
sudo dnf copr enable sneexy/zen-browser -y
sudo dnf install -y zen-browser

# Install RPM Fusion repos
echo "Installing rpmfusion..."
sudo dnf install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Install codecs and drivers
echo "Installing codecs and drivers...."
sudo dnf config-manager --set-enabled fedora-cisco-openh264
sudo dnf install -y mesa-va-drivers mesa-vdpau-drivers
sudo dnf group install -y multimedia --allowerasing
sudo dnf group install -y "sound-and-video" --allowerasing
sudo dnf install -y mesa-va-drivers-freeworld libva-utils
sudo dnf install -y gstreamer1-plugins-{bad-*,good-*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf install -y libavcodec-freeworld
sudo dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
sudo dnf swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld

# Install fonts
echo "Installing fonts...."
sudo dnf install -y \
    google-noto-fonts-all.noarch \
    google-noto-fonts-all-static.noarch \
    google-noto-fonts-all-vf.noarch \
    google-noto-fonts-common.noarch \
    google-noto-sans-fonts \
    google-noto-emoji-fonts \
    google-noto-cjk-fonts \
    lohit-bengali-fonts

echo "Fonts installed successfully!"

# Install NWG-Look
sudo dnf copr enable sdegler/hyprland -y
sudo dnf install -y nwg-look

# --- Window Manager Install Functions ---
install_mango() {
    echo "Installing MangoWM dependencies..."
    sudo dnf insall mangowc
    sudo dnf install -y xdg-desktop-portal-wlr xdg-desktop-portal
     cp -r mango ~/.config/
    echo "Mango setup done!"
}

install_niri() {
    echo "Installing NiriWM dependencies..."
    sudo dnf copr enable yalter/niri-git -y
    sudo dnf install -y niri
    cp -r niri ~/.config/
    sudo dnf remove -y fuzzel swaylock waybar
    echo "Niri setup done!"
}

# Ask user for WM choice
echo "Which WM do you want to install?"
echo "1) MangoWM"
echo "2) NiriWM"
read -p "Enter 1 or 2: " choice

case $choice in
    1)
        install_mango
        ;;
    2)
        install_niri
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

# Make terminal beautiful
echo "Making your terminal beautiful..."
curl -sS https://starship.rs/install.sh | sh
sudo dnf install -y fastfetch ImageMagick
 cp -r bin ~/.local/
 cp -r .zshrc ~/
 cp -r fastfetch ~/.config/
 cp -r kitty ~/.config/
 cp -r starship ~/.config

echo "Your setup is done. Enjoy!"

# Install SDDM and enable graphical target
echo "Installing sddm...."
sudo dnf install -y sddm
sudo systemctl set-default graphical.target
sudo systemctl enable sddm.service
sudo systemctl start sddm.service
