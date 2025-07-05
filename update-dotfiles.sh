#! /bin/bash
set -e

cp ~/.config/helix/config.toml helix.config.toml
cp ~/.config/helix/languages.toml languages.toml
cp ~/.config/nvim/init.lua init.lua
cp ~/.vimrc vimrc

# cp ~/.config/i3/config i3-config

cp ~/.config/tmux/tmux.conf tmux.conf

cp ~/.config/ghostty/config ghostty-config

cp ~/.bashrc bashrc
# cp ~/.config/fish/config.fish config.fish
echo "Done!"
