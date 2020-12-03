#==============================================================#
##          Aliases                                           ##
#==============================================================#

# ls
alias la='ls -aF -G'
alias lla='ls -alF -G'
alias lal='ls -alF -G'
alias ls='ls -G'
alias ll='ls -l -G'
alias l.='ls -d .[a-zA-Z]* -G'

alias gre='grep -H -n -I -G'

## application ##
# vi
alias vi="$EDITOR"
alias v="$EDITOR"
alias sv="sudo $EDITOR"

# man
alias man-ascii-color-code="man 4 console_codes"

#==============================================================#
##          Global alias                                      ##
#==============================================================#

alias -g G='| grep '  # e.x. dmesg lG CPU
alias -g L='| $PAGER '
alias -g W='| wc'
alias -g H='| head'
alias -g T='| tail'

#==============================================================#
##          Suffix                                            ##
#==============================================================#

alias -s {md,markdown,txt}="$EDITOR"
alias -s {html,gif,mp4}='x-www-browser'
alias -s rb='ruby'
alias -s py='python'
alias -s hs='runhaskell'
alias -s php='php -f'
alias -s {jpg,jpeg,png,bmp}='feh'
function extract() {
  case $1 in
    *.tar.gz|*.tgz) tar xzvf "$1";;
    *.tar.xz) tar Jxvf "$1";;
    *.zip) unzip "$1";;
    *.lzh) lha e "$1";;
    *.tar.bz2|*.tbz) tar xjvf "$1";;
    *.tar.Z) tar zxvf "$1";;
    *.gz) gzip -d "$1";;
    *.bz2) bzip2 -dc "$1";;
    *.Z) uncompress "$1";;
    *.tar) tar xvf "$1";;
    *.arj) unarj "$1";;
  esac
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract


#==============================================================#
##          App                                               ##
#==============================================================#

# generate password
alias generate-pw='openssl rand -base64 20'

#==============================================================#
##          Misc                                              ##
#==============================================================#

alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'
alias gist='gist -p -o -c'
alias z3noServer='mpssh  -f ~/.ssh/z3noServer'
# alias zgource='gource --hide dirnames,filenames --seconds-per-day 0.1 --auto-skip-seconds 1 -1280x720 -o - | ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i - -vcodec libx264 -preset ultrafast -pix_fmt yuv420p -crf 1 -threads 0 -bf 0 ~/gource.mp4'
alias weather='ansiweather -l Holzminden,DE -u metric -F -s true -a false'
# alias not='terminal-notifier -title "Execution done" -message "Huray"'
# alias htop='_ htop'
alias topgrade='topgrade && zinit self-update && zinit update --all'

#==============================================================#
##          DDEV                                              ##
#==============================================================#

alias dcomposer='ddev composer $*'
alias mr2='ddev mr2 $*'
alias unit-test='ddev unit-test $*'
alias qa='ddev qa $*'
alias rector='ddev rector $*'
alias composer-normalize='ddev composer-normalize $*'

#==============================================================#
##          FOSH stuff EB                                     ##
#==============================================================#

alias eurobaustoffRun='fosh run "@eurobaustoff"'
alias b2bRun='fosh run "@b2b"'
alias b2cRun='fosh run "@b2c"'
alias coRun='fosh run "@co"'
alias stagingRun='fosh run "@staging"'
alias liveRun='fosh run "@live"'
alias deadRun='fosh run "@dead"'
alias cphpstorm='dcomposer n98:phpstorm:register-source-folders --vendor=n98 --vendor=euro && dcomposer n98:phpstorm:register-vcs --vendor=n98 --vendor=euro'

#==============================================================#
##          improvement command                               ##
#==============================================================#

function alias-improve() {
  if builtin command -v $(echo $2 | cut -d ' ' -f 1) > /dev/null 2>&1; then
    alias $1=$2
  fi
}
