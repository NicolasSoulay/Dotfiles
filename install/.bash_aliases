# ls with exa
alias ls='exa -lah --icons --group-directories-first --sort=ext'
alias lst='exa -a --tree --icons --group-directories-first --sort=ext'
alias lsd='exa -lah --icons --sort=mod' 
alias lss='exa -lah --icons --sort=size'

# neovim
alias v='nvim'
 
# grep color
alias grep='rg --color=auto'
alias fgrep='rg -F --color=auto'
alias egrep='egrep --color=auto'

alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"

alias cd="z"

alias cat='batcat --paging=never'
alias bat='batcat'

alias fzf='sk'

alias bathelp='batcat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}
