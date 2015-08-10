#!/bin/zsh
#------------------------------------------------ 
# Configs of vaious authors, gathered by liara.
#
# ~/.zshrc
#
#-------------------------------------------------
#
# Lines configured by zsh-newuser-install

# Check interactive
[[ $- != *i* ]] && return

# History
HISTFILE=~/.zsh/.histfile
HISTSIZE=4000
SAVEHIST=4000

# Enable coloring
autoload -U colors && colors

autoload -U bashcompinit
autoload -U edit-command-line
zle -N edit-command-line
bashcompinit

autoload -U compinit promptinit
compinit
promptinit
# coloured manpages moved to man in functions.zsh
#export LESS_TERMCAP_mb=$'\E[01;31m'
#export LESS_TERMCAP_md=$'\E[01;38;5;74m'
#export LESS_TERMCAP_me=$'\E[0m'
#export LESS_TERMCAP_se=$'\E[0m'
#export LESS_TERMCAP_so=$'\E[38;33;246m'
#export LESS_TERMCAP_ue=$'\E[0m'
#export LESS_TERMCAP_us=$'\E[04;38;5;146m'

# Enable magic quoting of URL
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Paths
PATH="~/code/c/asciiworld:$PATH"
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
PATH="/usr/lib/ruby/gems/2.2.0/cache:$PATH"
PATH="/usr/local/heroku/bin:$PATH"
PATH="$HOME/bin:$PATH"

# Make my zsh greet me
welcome
#python.27 welcome.py | lolcat
#fortune | toilet --gay -f term | if ((RANDOM %2)); then ponysay; else ponythink; fi

# Prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%{${fg[cyan]}%}[%{${fg[green]}%}%s%{${fg[cyan]}%}][%{${fg[blue]}%}%r/%S%%{${fg[cyan]}%}][%{${fg[blue]}%}%b%{${fg[yellow]}%}%m%u%c%{${fg[cyan]}%}]%{$reset_color%}"
zstyle ':vcs_info:hg*' formats "%{${fg[cyan]}%}[%{${fg[red]}%}%s%{${fg[cyan]}%}][%{${fg[blue]}%}%r/%S%%{${fg[cyan]}%}][%{${fg[blue]}%}%b%{${fg[yellow]}%}%m%u%c%{${fg[cyan]}%}]%{$reset_color%}"

precmd() {
    vcs_info
}
RPROMPT='${vcs_info_msg_0_}'
PROMPT='%F{cyan}%~ ──── %f '

# Set dir_colors
eval $(dircolors -b ~/xcolors/dir_colors/dir_colors_MikereDD)

# Source files
. ~/.zsh/functions.zsh
. ~/.zsh/aliases.zsh
. ~/.zsh/completions.zsh
. ~/.zsh/options.zsh
. ~/.zsh/bindings.zsh
. ~/.zsh/highlighting.zsh
. ~/.zsh/exports.zsh

# Base16 shell colors

BASE16_SHELL="$HOME/.config/base16-shell/base16-summerfruit.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# vim:fenc=utf-8:nu:ai:si:et:ts=4:sw=4:ft=zsh:
