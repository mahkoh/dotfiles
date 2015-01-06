# history
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt inc_append_history
setopt share_history
setopt hist_ignore_dups

fpath=(~/.zsh/completion $fpath)
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
alias ls='ls --color=auto --time-style=+"%Y %b %d"'
alias grep='grep --color=auto'
alias l=ls
#alias grep='grep -r -n'
alias :q=exit
alias ra=ranger
alias rename=perl-rename
alias easytag='easytag .'
alias cvpn='ssh -D 1111 fedora'
alias lame='lame -h -b 320'
alias date='date +"%Y-%m-%d %H:%M:%S %Z"'
alias unrar='unrar x'
alias ev='evince'
alias node='node --harmony --use-strict'
alias autocommit='git commit -am "autocommit $(date)"'

export PROMPT="%{$fg[green]%}%B%~$%b%{$reset_color%} "

# vi sucks. use vim
export SUDO_EDITOR="/usr/bin/vim -p -X"
export VISUAL=vim
export EDITOR=vim
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma hlsearch' -\""

export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"

export GOPATH=/home/julian/go
path+=~/go/bin

# set path
path+=~/bin
path+=~/.cabal/bin

function mkcd() {
    mkdir -p $1 && cd $1
}

function mkmvcd() {
    mkdir -p $1 && mv $2 $1 && cd $1
}

function mkmv() {
    mkdir -p $1 && mv $2 $1
}

if [ "$TERM" = "linux" ]; then
    _SEDCMD='s/.*\*color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p'
    for i in $(sed -n "$_SEDCMD" $HOME/.Xdefaults | awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}'); do
        echo -en "$i"
    done
    clear
fi

setopt autocontinue
