#------------------------------------------------
# Aliases spoiling me
#------------------------------------------------

# Suffixes
alias -s pdf='zathura'
alias -s {md,rst,tex,txt}='vim'
alias -s {odt,doc,xlst,docx,xlsxtx,csv}='libreoffice'
alias -s {png,jpg}='meh'
alias -s {mkv,avi,webm,mov,mp4}="mplayer"

# Global alias
alias -g g="| grep"
alias -g l="| less"
alias -g t="| tail"
alias -g h="| head"
alias -g S='| curl -F "sprunge=<-" http://sprunge.us'
alias -g dn="&> /dev/null &"

# Aliases
alias grep="/usr/bin/grep $GREP_OPTIONS"
alias tree='tree -Ch'
alias less='less -FRNX'
alias ls='ls -h --color=auto'
alias matrix='cmatrix'
#alias myip="curl icanhazip.com"
#alias ls='ls -h --color=auto --group-directories-first'
alias emosh='mosh -p 42137 --ssh="ssh -p 1337" me@12.34.56.789'
alias ls='ls -x -L -h --color=auto --group-directories-first'
alias matrix='cmatrix -f -l -a'

alias ..='cd ..'            # Go up one directory
alias ...='cd ../..'        # Go up two directories
alias ....='cd ../../..'    # And for good measure
alias l='ls -lah'           # Long view, show hidden
alias la='ls -AF'           # Compact view, show hidden
alias ll='ls -lFh'          # Long view, no hidden
alias todo='vim ~/todo'     # todo list
alias fizika='cd ~/code/web/fizika'
# Curl for useragents
alias iecurl="curl -H \"User-Agent: Mozilla/5.0 (Windows; U; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)\""
alias ffcurl="curl -H \"User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.8) Gecko/2009032609 Firefox/3.0.0 (.NET CLR 3.5.30729)\""
alias ptpb='curl -F c=@- https://ptpb.pw'
alias disk='udiskie --tray'
alias rick="curl -s -L 'http://bit.ly/10hA8iC' | bash"
alias pong='ping -c 5 8.8.8.8'
alias openports='netstat -nape --inet'
alias diskspace='du -h --max-depth=1'
alias cower='cower --color=always'
alias pacman='pacman --color=always'
alias count='wc -l'
alias gv='gifview -a'
alias :q='exit'
alias ytdl='youtube-dl --title --continue --retries 4 --write-info-json --write-description --write-thumbnail --write-annotations --all-subs --ignore-errors --merge-output-format mkv -f bestvideo+bestaudio $1'
alias vdeck='vimdeck generate $1 && vim presentation/*.md -S script.vim'
alias vimb='tabbed -c vimb -e'
alias iotop='sudo iotop -Pao'
alias info="command info --vi-keys"
alias most_used="print -l -- ${(o)history%% *} | uniq -c | sort -nr | head -n 10"
alias gr='find . -iname "*$@*" | less'
alias yt3='cd $HOME/media/music; youtube-dl --verbose --extract-audio --audio-format mp3 '
alias music='mplayer -ao pulse -shuffle ~/media/music/*/./*'
alias open="sudo netstat -tulpn"
alias opena="sudo netstat -antup"
alias sucs='sort | uniq -c | sort -n'
alias c='noglob perl -e '\''shift; $x = eval qq(@ARGV); print $x; printf " 0x%x 0%o %b\n", $x, $x, $x'\'' _' ' "'
alias gl="git log -n 15 --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias nope="git commit -m 'ಠ_ಠ'"
alias please='sudo'
alias grep='grep --color=auto'
alias siteget="wget --recursive --page-requisites --convert-links --html-extension --no-parent --wait=10 --limit-rate=20K -U Mozilla -l"
alias l33t='beep -c -f 400 -D 50 -l 10' # usage cat file | l33t
alias beep='beep -f 1000 -r 2 -n -r 5 -l 10 --new'
alias timeunix='date +%s'
alias unixtime='date -d' # usage unixtime @1438535438
alias select-wallpaper='feh --action "feh --bg-fill %f && kill %V" --title "FEH - WALLPAPER" --auto-zoom --geometry 1920x1080 --recursive $HOME/Pictures/wallpapers' # select wallpaper and set with enter
alias wis='grep -rnw $PWD -e' # search files for a string

# vim:fenc=utf-8:nu:ai:si:et:ts=4:sw=4:ft=zsh:
