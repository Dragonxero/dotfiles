#------------------------------------------------
# My precious functions
# Gathered from ArchWiki,  jfrazelle, nixers...
#------------------------------------------------

# Show vim help
:h () {
    vim +"h $1" +only +'map q ZQ'
}

# Native function for showing 256 colors, properly formatted:
256co() {
#  if [[ ${TERM} != linux ]]; then
  for line in {0..15}; do for col in {0..15}; do
      local code=$(( $col * 16 + ${line} ))
      printf $'\e[38;05;%dm %03d' ${code} ${code}
    done
  print ; done
#  fi
}

# Simple note taker
atodo() {
    if [[ ! -f $HOME/.todo ]]; then
        touch "$HOME/.todo"
    fi

    if ! (($#)); then
        cat "$HOME/.todo"
    elif [[ "$1" == "-l" ]]; then
        nl -b a "$HOME/.todo"
    elif [[ "$1" == "-c" ]]; then
        > $HOME/.todo
    elif [[ "$1" == "-r" ]]; then
        nl -b a "$HOME/.todo"
        eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo
        read -p "Type a number to remove: " number
        sed -i ${number}d $HOME/.todo "$HOME/.todo"
    else
        printf "%s\n" "$*" >> "$HOME/.todo"
    fi
}

# Bash color codes, not properly formatted:
bcolors() {
    for code in {0..255}; do echo -e "\e[38;05;${code}m $code: Test"; done
}

# Simple calculator
calc() {
	local result=""
	result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')"
	#						└─ default (when `--mathlib` is used) is 20

	if [[ "$result" == *.* ]]; then
		# improve the output for decimal numbers
		printf "$result" |
		sed -e 's/^\./0./'		  `# add "0" for cases like ".5"` \
			-e 's/^-\./-0./'	  `# add "0" for cases like "-.5"`\
			-e 's/0*$//;s/\.$//';  # remove trailing zeros
	else
		printf "$result"
	fi
	printf "\n"
}

# Cd and ls in one
cl() {
    local dir="$1"
    local dir="${dir:=$HOME}"
    if [[ -d "$dir" ]]; then
        cd "$dir" >/dev/null; ls
    else
        echo "bash: cl: $dir: Directory not found"
    fi
}

# Count dirs in dir
cnt() {
    tree -i -L 1
}

# Get a character’s Unicode code point
codepoint() {
	perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))"
	# print a newline unless we’re piping the output to another program
	if [ -t 1 ]; then
		echo ""; # newline
	fi
}

# Copy and follow file to new dir:
cpf() {
  if [[ -d $*[-1] ]]; then
    cp $* && cd $*[-1]
  elif [[ -d ${*[-1]%/*} ]]; then
    cp $* && cd ${*[-1]%/*}
  fi
}

# Colored pstree
cpstree () {
    pstree -U "$@" | sed '
	s/[-._a-zA-Z]\+/\x1B[32m&\x1B[0m/g
	s/[{}]/\x1B[31m&\x1B[0m/g
	s/[─┬─├─└│]/\x1B[34m&\x1B[0m/g'   
}

# Compile and execute a C source on the fly
csource() {
    [[ $1 ]]    || { echo "Missing operand" >&2; return 1; }
    [[ -r $1 ]] || { printf "File %s does not exist or is not readable\n" "$1" >&2; return 1; }
    local output_path=${TMPDIR:-/tmp}/${1##*/};
    gcc "$1" -o "$output_path" && "$output_path";
    rm "$output_path";
    return 0;
} 

# Create a data URL from a file
dataurl() {
	local mimeType=$(file -b --mime-type "$1")
	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8"
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Create a data URL from svg
datasvg() {
	local mimeType=$(file -b --mime-type "$1")
	if [[ $mimeType == text/* ]]; then
		mimeType="image/svg+xml"
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Get dbus session
dbs() {
	local t=$1
	if [[  -z "$t" ]]; then
		local t="session"
	fi

	dbus-send --$t --dest=org.freedesktop.DBus \
		--type=method_call	--print-reply \
		/org/freedesktop/DBus org.freedesktop.DBus.ListNames
}

# Get StarDict definitions
define() {
  sdcv "$1"; espeak "$1"
}

# Run `dig` and display the most useful info
digga() {
	dig +nocmd "$1" any +multiline +noall +answer
}

# UTF-8-encode a string of Unicode symbols
escape() {
	printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
	# print a newline unless we’re piping the output to another program
	if [ -t 1 ]; then
		echo ""; # newline
	fi
}

# Extract
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

# Determine size of a file or total size of a directory
fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh
	else
		local arg=-sh
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@"
	else
		du $arg .[^.]* *
	fi
}

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
getcertnames() {
	if [ -z "${1}" ]; then
		echo "ERROR: No domain specified."
		return 1
	fi

	local domain="${1}"
	echo "Testing ${domain}…"
	echo ""; # newline

	local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
		| openssl s_client -connect "${domain}:443" 2>&1)

	if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
		local certText=$(echo "${tmp}" \
			| openssl x509 -text -certopt "no_header, no_serial, no_version, \
			no_signame, no_validity, no_issuer, no_pubkey, no_sigdump, no_aux")
		echo "Common Name:"
		echo ""; # newline
		echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//"
		echo ""; # newline
		echo "Subject Alternative Name(s):"
		echo ""; # newline
		echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
			| sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2
		return 0
	else
		echo "ERROR: Certificate not found."
		return 1
	fi
}

# Create a gif out of a movie
gifify() {
  if [[ -n "$1" && -n "$2" ]]; then
        mkdir gif-tmp
        ffmpeg -i $1 -r 1 -f image2 gif-tmp/%05d.jpg
        convert -delay 100 gif-tmp/*.jpg $2
        rm -rf gif-tmp/
    else
        echo "proper usage: gif-ify <input_movie.mov> <output_file.gif>"
        echo "You DO need to include extensions."
    fi
}

# Create a git.io short URL
gitio() {
	if [ -z "${1}" -o -z "${2}" ]; then
		echo "Usage: \`gitio slug url\`"
		return 1
	fi
	curl -i http://git.io/ -F "url=${2}" -F "code=${1}"
}

# Build go static binary from root of project
gostatic(){
	local dir=$1

	if [[ -z $dir ]]; then
		dir=$(pwd)
	fi

	local name=$(basename "$dir")
	(
	cd $dir
	echo "Building static binary for $name in $dir"
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o "$name" .
	)
}

# Go to a folder easily in your gopath
gogo(){
	local d=$1

	if [[ -z $d ]]; then
		echo "You need to specify a project name."
		return 1
	fi

	# search for the project dir in the GOPATH
	local path=( `find "${GOPATH}/src" -iname "$d" -type d` )

	if [[ "$path" == "" ]]; then
		echo "Could not find a directory named $d in $GOPATH"
		echo "Maybe you need to 'go get' it ;)"
		return 1
	fi

	# enter the first path found
	cd "${path[0]}"
}

# Compare original and gzipped file size
gz() {
	local origsize=$(wc -c < "$1")
	local gzipsize=$(gzip -c "$1" | wc -c)
	local ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l)
	printf "orig: %d bytes\n" "$origsize"
	printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio"
}

# Use Git’s colored diff when available
hash git &>/dev/null
if [ $? -eq 0 ]; then
	diff() {
		git diff --no-index --color-words "$@"
	}
fi

# Get info of an IP
ipinfo() { 
    if grep -P "(([1-9]\d{0,2})\.){3}(?2)" <<< "$1"; then
	curl ipinfo.io/"$1"
    else
	ipawk=($(host "$1" | awk '/address/ { print $NF }'))
	curl ipinfo.io/${ipawk[1]}
    fi
    echo
}

# Determine local IP address
ips () {
    # determine local IP address
    ifconfig | grep "inet " | awk '{ print $2 }'
}

# Check if uri is up
isup() {
	local uri=$1

	if curl -s --head  --request GET "$uri" | grep "200 OK" > /dev/null ; then
		notify-send --urgency=critical "$uri is down"
	else
		notify-send --urgency=low "$uri is up"
	fi
}

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
json() {
	if [ -t 0 ]; then # argument
		python -mjson.tool <<< "$*" | pygmentize -l javascript
	else # pipe
		python -mjson.tool | pygmentize -l javascript
	fi
}

# Colored manpages
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		man "$@"
}

# pastel alternative
#man() {
#  env \
#    LESS_TERMCAP_mb=$(printf "\e[01;31m") \
#    LESS_TERMCAP_md=$(printf "\e[01;38;5;74m") \
#    LESS_TERMCAP_me=$(printf "\e[0m") \
#    LESS_TERMCAP_se=$(printf "\e[0m") \
#    LESS_TERMCAP_so=$(printf "\e[38;33;246m") \
#    LESS_TERMCAP_ue=$(printf "\e[0m") \
#    LESS_TERMCAP_us=$(printf "\e[04;38;5;146m") \
#    man "$@"
#}

# Create a new directory and enter it
mkd() {
	mkdir -p "$@" && cd "$@"
}

# move and follow file to new dir:
mvf() {
  if [[ -d $*[-1] ]]; then
    mv $* && cd $*[-1]
  elif [[ -d ${*[-1]%/*} ]]; then
    mv $* && cd ${*[-1]%/*}
  fi
}

# Query Wikipedia via console over DNS
mwiki() {
	dig +short txt "$*".wp.dg.cx
}

# Get my extertnal ip
myip() {
    dig myip.opendns.com @resolver1.opendns.com +short
    #dig myip.opendns.com @resolver2.opendns.com +short
    #dig o-o.myaddr.l.google.com @ns1.google.com TXT +short
    #dig o-o.myaddr.l.google.com @ns2.google.com TXT +short
    #dig o-o.myaddr.l.google.com @ns3.google.com TXT +short
    #dig o-o.myaddr.l.google.com @ns4.google.com TXT +short
    #curl icanhazip.com
}

# Simple note taker
note () {
    # if file doesn't exist, create it
    if [[ ! -f $HOME/.notes ]]; then
        touch "$HOME/.notes"
    fi

    if ! (($#)); then
        # no arguments, print file
        cat "$HOME/.notes"
    elif [[ "$1" == "-c" ]]; then
        # clear file
        printf "%s" > "$HOME/.notes"
    else
        # add all arguments to file
        printf "%s\n" "$*" >> "$HOME/.notes"
    fi
}

# `o` with no arguments opens the current directory in the browser, 
# otherwise opens the given location
o() {
	if [ $# -eq 0 ]; then
		xdg-open .	> /dev/null 2>&1
	else
		xdg-open "$@" > /dev/null 2>&1
	fi
}

# Use feh to nicely view images
openimage() {
	local types='*.jpg *.JPG *.png *.PNG *.gif *.GIF *.jpeg *.JPEG'

	cd $(dirname "$1")
	local file=$(basename "$1")

	feh -q $types --auto-zoom \
		--sort filename --borderless \
		--scale-down --draw-filename \
		--image-bg black \
		--start-at "$file"
}

# `ov` with no arguments opens the current directory in Vim, otherwise opens the
# given location
ov() {
	if [ $# -eq 0 ]; then
		vim .
	else
		vim "$@"
	fi
}

# Check ownership of given argument, as determined by pacman:
owns() {
  if [[ -n $(for each in $(print ${PATH}|tr ':' '\n'); do
             find ${each}/$1 2>/dev/null ; done) ]]
  then command pacman -Qo $(which -p $1)
  else command pacman -Qo $1 ; fi
}

# Function to create archives
# EXAMPLE: pack tar file
pack () {
  if [ $1 ]; then
    case $1 in
      tar.bz2)     tar -cjvf $2.tar.bz2 $2                 ;;
      tar.gz)      tar -czvf $2.tar.gz $2                 ;;
      tar.xz)      tar -cf - $2 | xz -9 -c - > $2.tar.xz   ;;
      bz2)         bzip $2                                 ;;
      gz)          gzip -c -9 -n $2 > $2.gz                ;;
      tar)         tar cpvf $2.tar  $2                     ;;
      tbz)         tar cjvf $2.tar.bz2 $2                  ;;
      tgz)         tar czvf $2.tar.gz  $2                  ;;
      zip)         zip -r $2.zip $2                        ;;
      7z)          7z a $2.7z $2                           ;;
      *help)       echo "Usage: pack TYPE FILES"           ;;
      *)           echo "'$1' cannot be packed via pack()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Record screen 
rec() {
    GEOM=$(xwininfo -root |grep geom|awk '{print $2}'|cut -d+ -f1)
    OUTP=$1

    test -z "$OUTP" && OUTP=out.webm

    ffmpeg -y -f x11grab -s $GEOM -r 25 -i :0.0 $OUTP
}

# Call from a local repo to open the repository on github in browser
repo() {
	local giturl=$(git config --get remote.origin.url | sed 's/git@/\/\//g' | sed 's/.git$//' | sed 's/https://g' | sed 's/:/\//g')
	if [[ $giturl == "" ]]; then
		echo "Not a git repository or no remote.origin.url is set."
	else
		local gitbranch=$(git rev-parse --abbrev-ref HEAD)
		local giturl="http:${giturl}"

		if [[ $gitbranch != "master" ]]; then
			local giturl="${giturl}/tree/${gitbranch}"
		fi

		echo $giturl
		o $giturl
	fi
}

# Start an HTTP server from a directory, optionally specifying the port
server() {
	local port="${1:-8000}"
	sleep 1 && open "http://localhost:${port}/" &
# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# Check swap
swaphuh() {
  sed -n '/^Name:/{s/Name:\s*//;h};/^Pid:/{s/Pid:\s*/(/;s/$/)/;H};/^VmSwap:/{s/VmSwap:\s*//;G;s/\n/\t/;s/\n/ /;p}' /proc/[0-9]*/status | sort -h -r | less
}

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
targz() {
	local tmpFile="${@%/}.tar"
	tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1

	size=$(
	stat -f"%z" "${tmpFile}" 2> /dev/null; # OS X `stat`
	stat -c"%s" "${tmpFile}" 2> /dev/null # GNU `stat`
	)

	local cmd=""
	if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
		# the .tar file is smaller than 50 MB and Zopfli is available; use it
		cmd="zopfli"
	else
		if hash pigz 2> /dev/null; then
			cmd="pigz"
		else
			cmd="gzip"
		fi
	fi

	echo "Compressing .tar using \`${cmd}\`…"
	"${cmd}" -v "${tmpFile}" || return 1
	[ -f "${tmpFile}" ] && rm "${tmpFile}"
	echo "${tmpFile}.gz created successfully."
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
tre() {
	tree -aC -I '.git' --dirsfirst "$@" | less -FRNX
}

# Decode \x{ABCD}-style Unicode escape sequences
unidecode() {
	perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
	# print a newline unless we’re piping the output to another program
	if [ -t 1 ]; then
		echo ""; # newline
	fi
}

# Go up Nth amount of directories:
up(){
  local arg=${1:-1};
  while [ ${arg} -gt 0 ]; do
    cd .. >&/dev/null;
    arg=$((${arg} - 1));
  done
}

# Vim encrypt
vime () { 
    FILE="$1";
    if [ -f "$FILE" ];
    then
    vim -u ~/.vimencrypt "$FILE"
    else
    vim -u ~/.vimencrypt -x "$FILE"
    fi 
}

# Calculates the penis length of your computer
vpenis() {
    echo `uptime|grep days|sed 's/.*up \([0-9]*\) day.*/\1\/10+/'; cat \
    /proc/cpuinfo|grep '^cpu MHz'|awk '{print $4"/30 +";}';free|grep \
    '^Mem'|awk '{print $3"/1024/3+"}'; df -P -k -x nfs | grep -v \
    1k | awk '{if ($1 ~ "/dev/(scsi|sd|md)"){ s+= $2} s+= $2;} END \
    {print s/1024/50"/15+70";}'`|bc|sed 's/\(.$\)/.\1cm/'
}

# Get the name of a x window
xname(){
	local window_id=$1

	if [[ -z $window_id ]]; then
		echo "Please specifiy a window id, you find this with 'xwininfo'"

		return 1
	fi

	local match_string='".*"'
	local match_int='[0-9][0-9]*'
	local match_qstring='"[^"\\]*(\\.[^"\\]*)*"' # NOTE: Adds 1 backreference

	# get the name
	xprop -id $window_id | \
		sed -nr \
		-e "s/^WM_CLASS\(STRING\) = ($match_qstring), ($match_qstring)$/instance=\1\nclass=\3/p" \
		-e "s/^WM_WINDOW_ROLE\(STRING\) = ($match_qstring)$/window_role=\1/p" \
		-e "/^WM_NAME\(STRING\) = ($match_string)$/{s//title=\1/; h}" \
		-e "/^_NET_WM_NAME\(UTF8_STRING\) = ($match_qstring)$/{s//title=\1/; h}" \
		-e '${g; p}'
}

# vim:fenc=utf-8:nu:ai:si:et:ts=4:sw=4:ft=zsh:
