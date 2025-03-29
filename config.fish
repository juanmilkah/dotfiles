set fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Fish shell configuration

# Aliases
alias x='exit'
alias c='clear'
alias vim='nvim'
alias tm='tmux-sessionizer'
alias ca='cargo'
alias g='git'
alias commit='git commit .'
alias gs='git status'
alias nvim-config='nvim ~/.config/nvim/init.lua'
alias tree='eza --tree --color'
alias ls='eza'

# Add scripts directory to PATH
fish_add_path ~/bash-scripts

# Bun completions and path
if test -s "$HOME/.bun/_bun"
    source "$HOME/.bun/_bun"
end

set -gx BUN_INSTALL "$HOME/.bun"
fish_add_path "$BUN_INSTALL/bin"

# Go configuration
fish_add_path /usr/local/go/bin
set -gx GOPATH "$HOME/go"
fish_add_path "$GOPATH/bin"

# Local bin directory
fish_add_path "$HOME/.local/bin"

