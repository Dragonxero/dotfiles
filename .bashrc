# -----------------------------------------------------------------------------
# wrappers for color esc sequences
# -----------------------------------------------------------------------------

# Reset
Color_Off='\e[0m' # Text Reset

# Regular Colors
Black='\e[0;30m' # Black
Red='\e[0;31m' # Red
Green='\e[0;32m' # Green
Yellow='\e[0;33m' # Yellow
Blue='\e[0;34m' # Blue
Purple='\e[0;35m' # Purple
Cyan='\e[0;36m' # Cyan
White='\e[0;37m' # White

# Bold
BBlack='\e[1;30m' # Black
BRed='\e[1;31m' # Red
BGreen='\e[1;32m' # Green
BYellow='\e[1;33m' # Yellow
BBlue='\e[1;34m' # Blue
BPurple='\e[1;35m' # Purple
BCyan='\e[1;36m' # Cyan
BWhite='\e[1;37m' # White

# Underline
UBlack='\e[4;30m' # Black
URed='\e[4;31m' # Red
UGreen='\e[4;32m' # Green
UYellow='\e[4;33m' # Yellow
UBlue='\e[4;34m' # Blue
UPurple='\e[4;35m' # Purple
UCyan='\e[4;36m' # Cyan
UWhite='\e[4;37m' # White

# Background
On_Black='\e[40m' # Black
On_Red='\e[41m' # Red
On_Green='\e[42m' # Green
On_Yellow='\e[43m' # Yellow
On_Blue='\e[44m' # Blue
On_Purple='\e[45m' # Purple
On_Cyan='\e[46m' # Cyan
On_White='\e[47m' # White

# High Intensity
IBlack='\e[0;90m' # Black
IRed='\e[0;91m' # Red
IGreen='\e[0;92m' # Green
IYellow='\e[0;93m' # Yellow
IBlue='\e[0;94m' # Blue
IPurple='\e[0;95m' # Purple
ICyan='\e[0;96m' # Cyan
IWhite='\e[0;97m' # White

# Bold High Intensity
BIBlack='\e[1;90m' # Black
BIRed='\e[1;91m' # Red
BIGreen='\e[1;92m' # Green
BIYellow='\e[1;93m' # Yellow
BIBlue='\e[1;94m' # Blue
BIPurple='\e[1;95m' # Purple
BICyan='\e[1;96m' # Cyan
BIWhite='\e[1;97m' # White

# High Intensity backgrounds
On_IBlack='\e[0;100m' # Black
On_IRed='\e[0;101m' # Red
On_IGreen='\e[0;102m' # Green
On_IYellow='\e[0;103m' # Yellow
On_IBlue='\e[0;104m' # Blue
On_IPurple='\e[10;95m' # Purple
On_ICyan='\e[0;106m' # Cyan
On_IWhite='\e[0;107m' # White



#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
#python2.7 welcome.py | lolcat
welcome

PATH="$HOME/bin:$PATH"

shopt -s autocd

export GREP_OPTIONS="--color=auto"
alias tree='tree -Ch'
alias ls='ls -h --color=auto'
alias matrix='cmatrix'
alias myip="curl icanhazip.com"
export EDITOR=vim
alias ls='ls -h --color=auto --group-directories-first'
alias emosh='mosh -p 7777 --ssh="ssh -p 333" me@12.34.567.89'
#PS1='\n\[\e[30;1m\]┌─[\[\e[0m\]\[\e[34;1m\]\u@\h\[\e[0m\]\[\e[30;1m\]]──[\[\e[0m\]\[\e[35;1m\]\w\[\[\e[0m\]\[\e[30;1m\]]\[\[\e[0m\]\n\[\e[30;1m\]└─[\[\e[0m\]\[\e[34;2m\]\D{%d %b} \[\e[30;1m\]■\[\e[0m\] \[\e[34;2m\]\A\[\e[0m\]\[\e[30;1m\]]──■\[\[\e[0m\] '
PS1="\[$Blue\]\w ────\[\e[0m\] "
#PS1="\[$Blue\][\T]\[$IGreen\][\u@\h]\[$Cyan\][\w]\[$BIPurple\]\$\[$BIYellow\] "
trap 'echo -ne "\e[0m"' DEBUG

PATH="/usr/local/heroku/bin:$PATH"

eval `dircolors -b ~/xcolors/dir_colors/dir_colors_MikereDD`

# Filesystem
alias ..='cd ..'            # Go up one directory
alias ...='cd ../..'        # Go up two directories
alias ....='cd ../../..'    # And for good measure
alias l='ls -lah'           # Long view, show hidden
alias la='ls -AF'           # Compact view, show hidden
alias ll='ls -lFh'          # Long view, no hidden
alias todo='vim ~/todo'     # todo list
alias fizika='cd $HOME/code/web/fizika'
# curl for useragents
alias iecurl="curl -H \"User-Agent: Mozilla/5.0 (Windows; U; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)\""
alias ffcurl="curl -H \"User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.8) Gecko/2009032609 Firefox/3.0.0 (.NET CLR 3.5.30729)\""
alias ptpb='curl -F c=@- https://ptpb.pw'
alias disk='udiskie --tray'
alias fuck='$(thefuck $(fc -ln -1))'
alias vdeck='vimdeck generate $1 && vim presentation/*.md -S script.vim'

# extract
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.7z)             7z x $1           ;;
            *.xz)             unxz $1           ;;
            *.tar.bz2)        tar xjf $1        ;;
            *.tar.gz)         tar xzf $1        ;;
            *.bz2)            bunzip2 $1        ;;
            *.rar)            unrar x $1        ;;
            *.gz)             gunzip $1         ;;
            *.tar)            tar xf $1         ;;
            *.tbz2)           tar xjf $1        ;;
            *.tgz)            tar xzf $1        ;;
            *.zip)            unzip $1          ;;
            *.Z)              uncompress $1     ;;
            *)                echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# list your external ip
#exip () {
#    # gather external ip address
#    echo -n "Current External IP: "
#    curl -s -m 5 http://myip.dk | grep "ha4" | sed -e 's/.*ha4">//g' -e 's/<\/span>.*//g'
#}

# ips will list what your NIC things your IP addresses are. 
ips () {
    # determine local IP address
    ifconfig | grep "inet " | awk '{ print $2 }'
}

#EC() {
#    echo -e '\e[1;33m'code $?'\e[m\n'
#}
#trap EC ERR


alias grep="/usr/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS
export LANG=en_US.UTF-8
export LC_MESSAGES="C"

#--------------------
vime () { FILE="$1";
if [ -f "$FILE" ];
then
vim -u ~/.vimencrypt "$FILE"
else
vim -u ~/.vimencrypt -x "$FILE"
fi }
#--------------------

BASE16_SHELL="$HOME/.config/base16-shell/base16-summerfruit.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

