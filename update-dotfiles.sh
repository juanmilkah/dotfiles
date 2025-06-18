#! /bin/bash
set -e

cp ~/.config/nvim/init.lua init.lua
cp ~/.vimrc vimrc
cp ~/.config/helix/config.toml helix.config.toml
cp ~/.config/helix/languages.toml languages.toml

# cp ~/.config/sway/config sway-config
cp ~/.config/i3/config i3-config
# cp ~/.config/swaylock/config swaylock-config

cp ~/.config/tmux/tmux.conf tmux.conf

# cp ~/.config/alacritty/alacritty.toml alacritty.toml
cp ~/.config/ghostty/config ghostty-config

cp ~/.bashrc bashrc

echo "Done!"
