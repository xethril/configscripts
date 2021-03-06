#!/bin/zsh
export CONFIG_SCRIPTS_DIR="$(readlink -f "$(dirname "$(readlink -f "$HOME/.zshrc")")/..")"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

setopt appendhistory extendedglob nomatch
unsetopt autocd beep notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "" || eval "LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# No more awful control-s freeze
stty ixany
stty ixoff -ixon

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# User specific aliases and functions
export PATH="$CONFIG_SCRIPTS_DIR/bin/git-compile/bin:$PATH"
export PATH="$CONFIG_SCRIPTS_DIR/bin/python2/bin:$PATH"
export PATH="$CONFIG_SCRIPTS_DIR/bin/python3/bin:$PATH"
export PATH="$CONFIG_SCRIPTS_DIR/bin/vim-compile/bin:$PATH"
export PATH="$CONFIG_SCRIPTS_DIR/bin/gdb-compile/bin:$PATH"
export PATH="$CONFIG_SCRIPTS_DIR/bin:$PATH"
export PATH="$HOME/bin:$PATH"
if [[ "$LD_LIBRARY_PATH " == " " ]]; then
	export LD_LIBRARY_PATH="$CONFIG_SCRIPTS_DIR/bin/python2/lib"
else
	export LD_LIBRARY_PATH="$CONFIG_SCRIPTS_DIR/bin/python2/lib:$LD_LIBRARY_PATH"
fi

alias mv='mv -i'
alias cp='cp -i'
alias tree='tree --charset=X'
alias less='~/configscripts/bin/vim-compile/share/vim/vim74/macros/less.sh'
alias wine32='WINEARCH=win32 WINEPREFIX=~/.wine32 wine'
alias winecfg32='WINEARCH=win32 WINEPREFIX=~/.wine32 winecfg'
alias winetricks32='WINEARCH=win32 WINEPREFIX=~/.wine32 winetricks'
alias astylelinux='astyle --style=linux --indent=tab=8 --convert-tabs --indent-preprocessor --min-conditional-indent=3 --max-instatement-indent=40 --pad-oper --unpad-paren --pad-header --align-pointer=name --indent-namespaces --add-one-line-brackets --max-code-length=100'
alias astyleallman='astyle --style=allman --indent=tab=4 --convert-tabs --indent-preprocessor --min-conditional-indent=3 --max-instatement-indent=40 --pad-oper --unpad-paren --pad-header --align-pointer=name --indent-namespaces --add-one-line-brackets --max-code-length=100'
alias scite='SciTE'
unset SSH_ASKPASS

fixwhitespace() {
    sed -i -e's|[ \t]*\([\r\n]*\)$|\1|g' "$1"
}

# Scanner macros
scs() (
	if [[ ! "$1" == "" ]]; then
		mkdir -p "$1" && cd "$1"
	fi
	scanimage -d epkowa --mode Color --depth 8 --resolution 300 --scan-area Maximum --adf-mode Simplex --adf-auto-scan=yes --format=tiff --batch="scan%d.tiff" --batch-start=$( echo $(( 100 + `cat ~/.local/last_scan` )) | tee ~/.local/last_scan )
	if [[ ! "$1" == "" ]]; then
		cd ..
	fi
)
scd() (
	if [[ ! "$1" == "" ]]; then
		mkdir -p "$1" && cd "$1"
	fi
	scanimage -d epkowa --mode Color --depth 8 --resolution 300 --scan-area Maximum --adf-mode Duplex --adf-auto-scan=yes --format=tiff --batch="scan%d.tiff" --batch-start=$( echo $(( 100 + `cat ~/.local/last_scan` )) | tee ~/.local/last_scan )
	if [[ ! "$1" == "" ]]; then
		cd ..
	fi
)
sgs() (
	if [[ ! "$1" == "" ]]; then
		mkdir -p "$1" && cd "$1"
	fi
	scanimage -d epkowa --mode Gray --depth 8 --resolution 300 --scan-area Maximum --adf-mode Simplex --adf-auto-scan=yes --format=tiff --batch="scan%d.tiff" --batch-start=$( echo $(( 100 + `cat ~/.local/last_scan` )) | tee ~/.local/last_scan )
	if [[ ! "$1" == "" ]]; then
		cd ..
	fi
)
sgd() (
	if [[ ! "$1" == "" ]]; then
		mkdir -p "$1" && cd "$1"
	fi
	scanimage -d epkowa --mode Gray --depth 8 --resolution 300 --scan-area Maximum --adf-mode Duplex --adf-auto-scan=yes --format=tiff --batch="scan%d.tiff" --batch-start=$( echo $(( 100 + `cat ~/.local/last_scan` )) | tee ~/.local/last_scan )
	if [[ ! "$1" == "" ]]; then
		cd ..
	fi
)


old_aliases() {
	alias vncdock='vncserver -localhost -geometry 1900x1140'
	alias vnclaptop='vncserver -localhost -geometry 1920x1020'
	alias vncroot='x11vnc -xkb -noxrecord -noxfixes -noxdamage -localhost -display :0 -auth /var/run/lightdm/root/:0 -forever -bg -o /var/log/x11vnc.log'
	alias wakelaptop='wakeonlan 00:1c:25:b8:f6:5b'
	alias vnclaptop='vncviewer 192.168.0.3'
	alias steam='WINEPREFIX=~/.wine-steam WINEARCH=win32 wine "C:\\Program Files\\Steam\\Steam.exe" -no-dwrite'
	alias steam-giana='WINEPREFIX=~/.wine-giana WINEARCHCRAP=win32 wine "C:\\Program Files (x86)\\Steam\\Steam.exe" -no-dwrite'
	alias wine-diablo3='WINEPREFIX=~/.wine-diablo3 wine'
	alias winecfg-diablo3='WINEPREFIX=~/.wine-diablo3 winecfg'
	alias wine-d2-1='WINEPREFIX=~/.wine-d2-1 WINEARCH=win32 wine'
	alias d2-1='WINEPREFIX=~/.wine-d2-1 WINEARCH=win32 wine "C:\\Program Files\\Diablo II\\Game.exe" -w &>/dev/null &'
}

