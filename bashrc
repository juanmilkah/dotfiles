# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set environment variables
export EDITOR=helix
export TERM=screen-256color
export LANG='en_US.UTF-8'

# Add directories to PATH
export PATH="$PATH:$HOME/dev/dotfiles"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.zig"
export PATH="$PATH:$HOME/.zls"

# Aliases
alias ..='cd ../'
alias new='todo new'
alias get='todo get'
alias list='todo list'

alias x='exit'
alias c='clear'
alias g='git'
alias gs='git status'
alias ca='cargo'
alias ls='ls --color=never'
alias ll='ls -lh --color=never'
alias grep='grep --color=auto'
alias tm='tmux-sessionizer'
alias open='handlr open'
alias install='sudo-rs pacman -S --needed'
alias update='sudo-rs pacman -Syu'
alias remove='sudo-rs pacman -Rnsc'
alias unused='sudo-rs pacman -Qtdq'
alias grep='grep --color=auto'
# alias vim='helix'
alias sudo='sudo-rs'
alias hx='helix'

parse_git_branch() {
    git rev-parse --abbrev-ref HEAD 2>/dev/null | sed 's/.*/ (\x1b[32m&\x1b[0m)/'
 }

 # Custom PS1 prompt
export PS1="(\h) (\u) (\W)\$(parse_git_branch)\n** "

. "$HOME/.cargo/env"
