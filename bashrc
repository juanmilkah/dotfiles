# ~/.bashrc
# If not running interactively, don't do anything
[[ $- != *i* ]] && return


alias x='exit'
alias c='clear'
alias g='git'
alias diff='git diff'
alias gs='git status'
alias ca='cargo'
alias ll='ls -lh'
alias grep='grep --color=auto'
alias tm='tmux-sessionizer'
alias open='handlr open'
alias install='sudo pacman -S --needed'
alias update='sudo pacman -Syu'
alias remove='sudo pacman -Rnsc'
alias unused='sudo pacman -Qtdq'
alias vim='helix'
alias copy='xclip -sel clip'

PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH="~/dotfiles:$PATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Go configuration
export PATH="/usr/local/go/bin:$PATH"
export PATH="~/go/bin:$PATH"

# Add user's local bin directory to PATH
export PATH="$HOME/.local/bin:$PATH"

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

export EDITOR="helix"
export TERM="screen-256color"

