# General aliases
alias ls='eza -lah --icons --group-directories-first --sort=ext'
alias lst='eza -a --tree --icons --group-directories-first --sort=ext'
alias lsd='eza -lah --icons --sort=mod'
alias lss='eza -lah --icons --sort=size'
alias grep='rg --color=auto'
alias fgrep='rg -F --color=auto'
alias egrep='egrep --color=auto'
alias cat='batcat --paging=never'
alias cd='z'

# Specialized aliases
alias v='nvim'
alias gog='lgogdownloader'
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
alias fd='fdfind'
alias fzf='sk'
alias ps='procs --tree'
alias htop='btm'

# Custom copy command
alias cp='cpz'
