# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set environment variables
export EDITOR=nvim
export TERM=screen-256color
export LANG='en_US.UTF-8'

# Add directories to PATH
export PATH="$PATH:$HOME/dev/dotfiles"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.zig"
export PATH="$PATH:$HOME/.zls"

# Aliases
alias x='exit'
alias c='clear'
alias ls='ls --color --group-directories-first'
alias ll='ls -lh'
alias grep='grep --color=auto --ignore-case'

alias g='git'
alias gs='git status'

alias ca='cargo'
alias tm='tmux-sessionizer'
alias open='handlr open'
alias hx='helix'

alias install='sudo-rs pacman -S --needed'
alias update='sudo-rs pacman -Syu'
alias remove='sudo-rs pacman -Rnsc'
alias unused='sudo-rs pacman -Qtdq'
alias sudo='sudo-rs'

parse_git_branch() {
    git rev-parse --abbrev-ref HEAD 2>/dev/null | sed 's/.*/ (\x1b[32m&\x1b[0m)/'
 }

 # Custom PS1 prompt
 export PS1="(\h) (\u) (\w)\$(parse_git_branch) (\t)\n** "

. "$HOME/.cargo/env"
