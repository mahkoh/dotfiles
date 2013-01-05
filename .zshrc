# history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# advanced autocomplete
zstyle :compinstall filename '/home/julian/.zshrc'

# technical stuff I don't understand yet
autoload -Uz compinit promptinit colors
compinit
promptinit
colors

# autocomplete menu
zstyle ':completion:*' menu select

# colorful emotions
alias ls='ls --color=auto'
alias l='ls --color=auto'
#alias grep='grep -r -n'
alias :q=exit
alias ra=ranger
alias rename=perl-rename
alias easytag='easytag .'
alias cvpn='ssh -D 1111 away'

export PROMPT="%{$fg[green]%}%B%~$%b%{$reset_color%} "

# vi sucks. use vim
export SUDO_EDITOR="/usr/bin/vim -p -X"
export VISUAL=vim
export EDITOR=vim
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma hlsearch' -\""
