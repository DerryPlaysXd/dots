#!/bin/bash
# This script is going to install all the needed dependencies and copy all the .config files into proper folders.

# Installing needed dependencies
echo "Installing git, base-devel..."
sudo pacman -Syu --needed --noconfirm git base-devel
echo "Needed dependencies installed succesfully!"

# Install needed packages
# Installing paru (AUR Helper)
echo "Installing paru (AUR Helper)..."
mkdir ~/paru-temp
git clone https://aur.archlinux.org/paru.git ~/paru-temp
cd ~/paru-temp
makepkg -si
echo "Paru installed succesfully!"
rm -rf ~/paru-temp
cd ~/dots

# Installing software dependencies
# AwesomeWM
echo "Installing AwesomeWM..."
paru -Sy --needed --noconfirm awesome
echo "AwesomeWM installed successfully!"

# Picom
echo "Installing Picom..."
paru -S --needed --noconfirm picom

# SDDM
echo "Installing SDDM..."
paru -S --needed --noconfirm sddm
sudo systemctl enable sddm
echo "SDDM installed successfully!"

# Brave Browser
echo "Installing Brave Browser..."
paru -S --needed --noconfirm brave-bin
echo "Brave Browser installed successfully!"

# Discord
echo "Installing Discord..."
paru -S --needed --noconfirm discord
echo "Discord installed successfully!"

# Steam
echo "Installing Steam..."
paru -S --needed --noconfirm steam
echo "Steam installed successfully!"

# Polybar
echo "Installing Polybar..."
paru -S --noconfirm polybar 
echo "Polybar installed successfully!"

# Nitrogen
echo "Installing Nitrogen..."
paru -S --needed --noconfirm nitrogen
echo "Nitrogen installed successfully!"

# Rofi
echo "Installing Rofi..."
paru -S --needed --noconfirm rofi
echo "Rofi installed successfully!"

# Fish
echo "Installing Fish..."
paru -S --needed --noconfirm fish
echo "Fish installed successfully!"

# NVIM
echo "Installing NVIM..."
paru -S --needed --noconfirm nvim
echo "NVIM installed successfully!"

# Alacritty
echo "Installing Alacritty..."
paru -S --needed --noconfirm alacritty
echo "Alacritty successfully installed!"


# Wallpapers
mkdir ~/Wallpapers
echo "Cloning most recent makc wallpapers..."
git clone --depth 1 https://github.com/makccr/wallpapers ~/Wallpapers
echo "Successfully cloned wallpapers!"


# Copy all .config and .local files to correct folders
# Rofi theme
echo "Installing Rofi theme..."
cd ~/dots
mkdir -p ~/.local/share/rofi/themes
cp .local/share/rofi/themes/nord.rasi ~/.local/share/rofi/themes
echo "Rofi theme installed successfully!"

# Fish config
echo "Installing Fish config"
cd ~/dots
mkdir -p ~/.config/fish
cp -r .config/fish/* ~/.config/fish
read -p "It's recommended to download mesloNF fonts for compatibility reasons. Download now? (Y/N) " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
	echo "Downloading and setting up mesloNF..."
	mkdir ~/fonts-temp
	cd ~/fonts-temp
	paru -S --noconfirm --neded wget
	wget "https://github.com/IlanCosman/tide/blob/assets/fonts/mesloLGS_NF_regular.ttf?raw=true"
	wget "https://github.com/IlanCosman/tide/blob/assets/fonts/mesloLGS_NF_bold.ttf?raw=true"
	wget "https://github.com/IlanCosman/tide/blob/assets/fonts/mesloLGS_NF_italic.ttf?raw=true"
	wget "https://github.com/IlanCosman/tide/blob/assets/fonts/mesloLGS_NF_bold_italic.ttf?raw=true"
	sudo mkdir -p /usr/share/fonts/TTF
	sudo mv mesloLGS_NF_regular.ttf /usr/share/fonts/TTF
	sudo mv mesloLGS_NF_bold.ttf /usr/share/fonts/TTF
	sudo mv mesloLGS_NF_italic.ttf /usr/share/fonts/TTF
	sudo mv mesloLGS_NF_bold_italic./usr/share/fonts/TTF
	fc-cache -fv
	echo "MesloNF fonts successfully installed!"
	cd ~/dots
else
	echo "Font installation skipped."
fi
cd ~/dots
sudo chsh /usr/bin/fish root
chsh /usr/bin/fish $whoami
echo "Fish config installed successfully!"

# Polybar config
echo "Installing Polybar config..."
cd ~/dots
mkdir -p ~/.config/polybar
cp .config/polybar/config ~/.config/polybar/config
echo "Polybar config installed successfully!"

# Awesome config
echo "Installing AwesomeWM config..."
cd ~/dots
mkdir -p ~/.config/awesome/
cp .config/awesome/rc.lua ~/.config/awesome/rc.lua
cp .config/awesome/autorun.sh ~/.config/awesome/
chmod +x ~/.config/awesome/autorun.sh
echo "Awesome config installed successfully!"

# NVIM config
echo "Installing NVIM config..."
cd ~/dots
mkdir -p ~/.config/nvim
cp -r .config/nvim/ ~/.config/nvim/
echo "NVIM config installed successfully!"

# Alacritty config
echo "Installing Alacritty config..."
cd ~/dots
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
