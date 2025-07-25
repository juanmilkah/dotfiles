#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set environment variables
export EDITOR=nvim
# export TERM=screen-256color
export TERM=xterm-kitty
export LANG='en_US.UTF-8'

# Add directories to PATH
export PATH="$PATH:$HOME/dotfiles"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.zig"

# Aliases
alias ..='cd ../'
alias new='todo new'
alias get='todo get'
alias list='todo list'
alias x='exit'
alias c='clear'
alias cd='z'
alias g='git'
alias diff='git diff'
alias gs='git status'
alias cg='cargo'
alias ls='ls --color=never'
alias ll='ls -lh --color=never'
alias grep='grep --color=auto'
alias tm='tmux-sessionizer'
alias open='handlr open'
alias install='sudo pacman -S --needed'
alias update='sudo pacman -Syu'
alias remove='sudo pacman -Rnsc'
alias unused='sudo pacman -Qtdq'
alias grep='grep --color=auto'
alias vim='nvim'

# PS1='[\u@\h \W]\$ '
parse_git_branch() {
    git rev-parse --abbrev-ref HEAD 2>/dev/null | sed 's/.*/ (\x1b[32m&\x1b[0m)/'
 }

 # Custom PS1 prompt
 export PS1="\u@\h \w\$(parse_git_branch)\[\e[0m\n\$ "

 . "$HOME/.cargo/env"

eval "$(zoxide init bash)"


# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
