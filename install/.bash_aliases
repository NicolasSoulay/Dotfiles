# ls with exa
alias ls='exa -lah --icons --group-directories-first --sort=ext'
alias lst='exa -a --tree --icons --group-directories-first --sort=ext --ignore-glob=".git|vendor|var|config|bin|migrations"'
alias lsd='exa -lah --icons --sort=mod' 
alias lss='exa -lah --icons --sort=size'

# neovim
alias v='nvim'
 
# grep color
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
