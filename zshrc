# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob notify
unsetopt beep nomatch
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/juan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
# Aliases
alias new='todo new'
alias get='todo get'
alias list='todo list'

alias x='exit'
alias c='clear'

alias g='git'
alias gs='git status'
alias ca='cargo'
alias vim='helix'

alias ls='ls --color=never'
alias ll='ls -lh --color=never'
alias grep='grep --color=auto'
alias tm='tmux-sessionizer'
alias open='handlr open'

alias install='sudo-rs pacman -S --needed'
alias update='sudo-rs pacman -Syu'
alias remove='sudo-rs pacman -Rnsc'
alias unused='sudo-rs pacman -Qtdq'
alias sudo='sudo-rs'

# Add custom to path
export PATH=~/dev/dotfiles:$PATH

# Prompt
export PROMPT="(%m %n) (%1~) # "

. "$HOME/.cargo/env"
