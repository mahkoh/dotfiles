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
alias ls='ls --color=auto --time-style=+"%Y %b %d" -N'
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
alias cdp='cd -P'
alias vim='vim -p'
alias cal='cal -m'
alias nano='echo "kill yourself"'
alias mpv='mpv --volume-max=100'

export PROMPT="%{$fg[green]%}%B%~$%b%{$reset_color%} "

# vi sucks. use vim
export SUDO_EDITOR="/usr/bin/vim -p -X"
export VISUAL=vim
export EDITOR=vim
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nonu nomod hlsearch' -\""

export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"

export KEYTIMEOUT=1

export NO_AT_BRIDGE=1

export GOPATH=/home/julian/go
export LRS_OBJ_PATH=/home/julian/lrs/lib/obj

export ESCDELAY=25

export XDG_DOCUMENTS_DIR="$HOME/dcs"
export XDG_DOWNLOAD_DIR="$HOME/downloads"
export XDG_MUSIC_DIR="$HOME/music"
export XDG_PICTURES_DIR="$HOME/pictures"
export XDG_VIDEOS_DIR="$HOME/videos"

export FREETYPE_PROPERTIES="truetype:interpreter-version=35"

export MAVEN_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1"

# set path
path+=~/go/bin
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

function back() {
    if pars | grep -q vim; then
        exit
    else
        echo "I got nothing"
    fi
}
alias bk=back

function pp() {
    script=$(xclip -o)
    cat -A <<< $script
    echo -ne "\nExecute? (y/N): "
    read execute
    if [[ $execute == "y" ]]; then
        eval $script
    fi
}

if [ "$TERM" = "linux" ]; then
    _SEDCMD='s/.*\*color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p'
    for i in $(sed -n "$_SEDCMD" $HOME/.Xdefaults | awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}'); do
        echo -en "$i"
    done
    clear
fi

setopt autocontinue
