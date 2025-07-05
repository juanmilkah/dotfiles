set -U fish_greeting
# fish_config prompt choose minimalist
# fish_config prompt choose simple
fish_config prompt choose terlar

if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_config theme choose None

set -x EDITOR helix
set -x TERM screen-256color
set -x LANG 'en_US.UTF-8'

set PATH $PATH ~/dotfiles
set PATH $PATH /usr/local/go/bin:
set PATH $PATH ~/go/bin
set PATH $PATH ~/.local/bin

alias x='exit'
alias c='clear'
alias g='git'
alias diff='git diff'
alias gs='git status'
alias ca='cargo'
alias ls='ls --color=never'
alias ll='ls -lh --color=never'
alias grep='grep --color=auto'
alias tm='tmux-sessionizer'
alias open='handlr open'
alias install='sudo pacman -S --needed'
alias update='sudo pacman -Syu'
alias remove='sudo pacman -Rnsc'
alias unused='sudo pacman -Qtdq'
alias vim='helix'
alias copy='xclip -sel clip'
