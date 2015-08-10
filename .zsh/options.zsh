#------------------------------------------------
# Zsh options
# Taken from KittyKat
#------------------------------------------------

setopt autocd

# History

setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
#setopt share_history
setopt appendhistory
setopt banghist

# Change dirs
setopt autocd
setopt autopushd
unsetopt cdablevars
unsetopt chasedots
setopt chaselinks
setopt pushdignoredups
unsetopt pushdminus
unsetopt pushdsilent
unsetopt pushdtohome

# Completition
setopt alwayslastprompt
setopt alwaystoend
setopt autolist
setopt automenu
setopt autonamedirs
setopt autoparamkeys
setopt autoparamslash
setopt autoremoveslash
unsetopt bashautolist
setopt completealiases
#setopt completeinword
setopt globcomplete
setopt hashlistall
setopt listambiguous
setopt listpacked
unsetopt listrowsfirst
setopt listtypes
unsetopt menucomplete
unsetopt recexact

#Expansion
setopt badpattern
setopt bareglobqual
unsetopt braceccl
setopt caseglob
setopt casematch
unsetopt cshnullglob
setopt equals
setopt extendedglob
setopt glob
unsetopt globassign
setopt globdots
unsetopt globsubst
unsetopt histsubstpattern
unsetopt ignorebraces
unsetopt kshglob
unsetopt magicequalsubst
setopt markdirs
setopt multibyte
setopt nomatch
unsetopt nullglob
setopt numericglobsort
unsetopt rcexpandparam
unsetopt rematchpcre
unsetopt shglob
#  setopt warncreateglobal
unsetopt warncreateglobal

# I/O

setopt correct correctall
setopt flowcontrol
setopt shortloops

# Job control
setopt checkjobs
setopt hup
setopt longlistjobs
setopt notify
setopt monitor

# Prompt
setopt prompt_subst

# Scripts and functions
setopt debugbeforecmd

# zle: us the bellow insted of bindkey v
setopt vi
setopt zle

# Unset the annoying beep
unsetopt beep

# vim:fenc=utf-8:nu:ai:si:et:ts=4:sw=4:ft=zsh:
