#! /bin/bash
set -e

cp ~/.config/nvim/init.lua init.lua
cp ~/.vimrc vimrc
cp ~/.config/sway/config sway-config
cp ~/.config/swaylock/config swaylock-config
cp ~/.config/tmux/tmux.conf tmux.conf
cp ~/.config/alacritty/alacritty.toml alacritty.toml
cp ~/.bashrc bashrc
cp ~/.config/hypr/scripts/battery_notify.sh battery_notify.sh
cp ~/.config/foot/foot.ini foot.ini
cp ~/.config/helix/config.toml helix.config.toml
cp ~/.config/helix/languages.toml languages.toml


echo "Done!"
