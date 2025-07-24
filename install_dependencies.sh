#!/bin/bash
# This script is going to install all the needed dependencies and copy all the .config files into proper folders.

# Installing needed dependencies
echo "Installing git, base-devel..."
sudo pacman -Syu --needed --noconfirm git base-devel
echo "Needed dependencies installed succesfully!"

# Install needed packages
# Installing yay (AUR Helper)
echo "Installing yay (AUR Helper)..."
mkdir ~/yay-temp
git clone https://aur.archlinux.org/yay.git ~/yay-temp
cd ~/yay-temp
makepkg -si
echo "Yay installed succesfully!"
rm -rf ~/yay-temp

# Installing software dependencies
# AwesomeWM
echo "Installing AwesomeWM..."
yay -Sy --needed --noconfirm awesome
echo "AwesomeWM installed successfully!"

# Picom
yay -S --needed --noconfirm picom

# SDDM
echo "Installing SDDM..."
yay -S --needed --noconfirm sddm
sudo systemctl enable sddm

# Brave Browser
echo "Installing Brave Browser..."
yay -S --needed --noconfirm brave-bin
echo "Brave Browser installed successfully!"

# Discord
echo "Installing Discord..."
yay -S --needed --noconfirm discord
echo "Discord installed successfully!"

# Steam
echo "Installing Steam..."
yay -S --needed --noconfirm steam
echo "Steam installed successfully!"

# Virt-manager
echo "Installing virt-manager..."
yay -S --needed --noconfirm virt-manager qemu vde2 ebtables iptables-nft nftables dnsmasq bridge-utils ovmf
echo "Virt-manager and all it's dependencies installed successfully!"

# Polybar
echo "Installing Polybar..."
yay -S --needed --noconfirm polybar 
echo "Polybar installed successfully!"

# Nitrogen
echo "Installing Nitrogen..."
yay -S --needed --noconfirm nitrogen
echo "Nitrogen installed successfully!"

# Rofi
echo "Installing Rofi..."
yay -S --needed --noconfirm rofi
echo "Rofi installed successfully!"

# NVIM
echo "Installing NVIM..."
yay -S --needed --noconfirm nvim
echo "NVIM installed successfully!"

# Alacritty
echo "Installing Alacritty..."
yay -S --needed --noconfirm alacritty
echo "Alacritty successfully installed!"


# Wallpapers
mkdir ~/Wallpapers
echo "Cloning most recent makc wallpapers..."
git clone --depth 1 https://github.com/makccr/wallpapers ~/Wallpapers
echo "Successfully cloned wallpapers!"


# Copy all .config and .local files to correct folders
# Rofi theme
echo "Installing Rofi theme..."
mkdir -p ~/.local/share/rofi/themes
cp .local/share/rofi/themes/nord.rasi ~/.local/share/rofi/themes
echo "Rofi theme installed successfully!"

# Polybar config
echo "Installing Polybar config..."
mkdir -p ~/.config/polybar
cp .config/polybar/config ~/.config/polybar/config
echo "Polybar config installed successfully!"

# Awesome config
echo "Installing AwesomeWM config..."
mkdir -p ~/.config/awesome/
cp .config/awesome/rc.lua ~/.config/awesome/rc.lua
echo "Awesome config installed successfully!"

# NVIM config
echo "Installing NVIM config..."
mkdir -p ~/.config/nvim
cp -r .config/nvim/ ~/.config/nvim/
echo "NVIM config installed successfully!"

# Alacritty config
echo "Installing Alacritty config..."
mkdir -p ~/.config/alacritty
cp .config/alacritty/alacritty.toml ~/.config/alacritty
echo "Alacritty config successfully installed!"

read -p "Reboot is recommended. Reboot now? (Y/N) " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
    echo "Rebooting now..."
    reboot
else
    echo "Reboot skipped."
fi
