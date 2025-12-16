#!/usr/bin/env bash

echo "Starting Setup for Fedora in mangowc...."
echo " "

# Clean garbage
echo "Clearing garbage...."
sudo dnf clean all -y


echo " "

echo "Installing terra...."
sudo dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release

#update fedora
echo "Updating system....."
sudo dnf update -y


echo "Making your internet fast...."

sudo cp -r dnf.conf /etc/dnf/

echo ""


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
    libxcb
    
    sudo dnf install -y \
    dnf-plugins-core \
    mate-polkit foot kitty nemo nemo-fileroller gnome-text-editor firefox
    
    
    sudo dnf install -y \
     xdg-user-dirs
     xdg-user-dirs-update
     
     
     echo "installing noctalia-shell...."
     
     sudo dnf copr enable zhangyi6324/noctalia-shell
     sudo dnf install noctalia-shell

echo "Your quickshell is ready!"

sudo dnf copr enable sneexy/zen-browser
sudo dnf install zen-browser


     echo "Installing rpmfusion..."
     
     sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
     
     echo "Installing codecs and drivers...."

sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1
sudo dnf install mesa-va-drivers mesa-vdpau-drivers
sudo dnf5 group install multimedia --allowerasing
sudo dnf5 group install sound-and-video --allowerasing
sudo dnf5 install mesa-va-drivers-freeworld
sudo dnf5 install libva-utils
sudo dnf install gstreamer1-plugins-{bad-*,good-*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf install libavcodec-freeworld
sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld
sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld

echo "Installing fonts...."

sudo dnf install google-noto-fonts-all.noarch google-noto-fonts-all-static.noarch google-noto-fonts-all-vf.noarch google-noto-fonts-common.noarch
sudo dnf install google-noto-sans-fonts
sudo dnf install google-noto-emoji-fonts
sudo dnf install google-noto-cjk-fonts
sudo dnf install lohit-bengali-fonts

echo "Fonts installed succesfully!"

sudo dnf copr enable sdegler/hyprland 
sudo dnf install nwg-look


install_mango() {
    echo "Installing MangoWM dependencies..."

    sudo dnf install -y \
            xdg-desktop-portal-wlr xdg-desktop-portal
            
            sudo cp -r mango ~/.config/
            
            echo "Mango setup done"

install_niri() {
    echo "Installing NiriWM dependencies..."

    sudo dnf install -y \
        sudo cp -r niri ~/.config/
          sudo dnf copr enable yalter/niri-git   
          sudo dnf install niri
          sudo dnf remove fuzzel swaylock waybar 
          
          echo "Niri setup done!"
}

# Ask user for choice
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

echo "Making your terminal beautiful..."

curl -sS https://starship.rs/install.sh | sh

sudo dnf install fastfetch ImageMagick

sudo cp -r bin  ~/.local/
sudo cp -r .zshrc ~/
sudo cp -r fastfetch ~/.config/
sudo cp -r kitty ~/.config/


echo "Your setup is done.Enjoy!"

echo "Installing sddm...."

sudo systemctl set-default graphical.target
sudo dnf install sddm
sudo systemctl enable sddm.service
sudo systemctl start sddm.service


