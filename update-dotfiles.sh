#! /bin/bash
set -e

cp ~/.config/helix/config.toml helix.config.toml
cp ~/.config/helix/languages.toml languages.toml

cp ~/.config/i3/config i3-config

cp ~/.config/tmux/tmux.conf tmux.conf

cp ~/.config/ghostty/config ghostty-config

cp ~/.bashrc bashrc

echo "Done!"
