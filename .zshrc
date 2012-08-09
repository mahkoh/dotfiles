# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/julian/.zshrc'

autoload -Uz compinit promptinit colors
compinit
promptinit
colors
zstyle ':completion:*' menu select
# End of lines added by compinstall

alias ls='ls --color=auto'
alias :q=exit
alias ra=ranger

export PROMPT="%{$fg[green]%}%B%~$%b%{$reset_color%} "
export SUDO_EDITOR="/usr/bin/vim -p -X"
export VISUAL=vim
export EDITOR=vim
