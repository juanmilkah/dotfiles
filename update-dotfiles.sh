#! /bin/bash
set -e

cp ~/.config/helix/config.toml helix.config.toml
cp ~/.config/helix/languages.toml languages.toml
cp ~/.vimrc vimrc
cp ~/.config/nvim/init.lua init.lua

cp ~/.config/sway/config sway-config
cp ~/.config/wayfire.ini wayfire.ini
cp ~/.config/i3/config i3-config
cp ~/.config/hypr/hyprland.conf hyprland.conf

cp ~/.config/tmux/tmux.conf tmux.conf

cp ~/.config/ghostty/config ghostty-config
cp ~/.config/kitty/kitty.conf kitty.conf
cp ~/.config/alacritty/alacritty.toml alacritty.toml
cp ~/.config/alacritty/themes/terminal_app.toml terminal_app.toml

cp ~/.bashrc bashrc
# cp ~/.zshrc zshrc
# cp ~/.config/fish/config.fish config.fish

echo "Done!"
