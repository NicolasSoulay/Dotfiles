# Color prompt
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# Don't put duplicate lines in the history
export HISTCONTROL=ignoredups
#... and ignore same successive entries
export HISTCONTROL=ignoreboth

# Make sure all terminals save history
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Increase history size
export HISTSIZE=1000
export HISTFILESIZE=1000

# ls with exa
alias ls='exa -lah --icons --group-directories-first --sort=ext'
alias lst='exa -a --tree --icons --group-directories-first --sort=ext'
alias lsd='exa -lah --icons --sort=mod' 
alias lss='exa -lah --icons --sort=size'

# neovim
alias v='nvim'
 
alias grep='rg --color=auto'
alias fgrep='rg -F --color=auto'
alias egrep='egrep --color=auto'
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
alias cd="z"
alias cat='batcat --paging=never'
alias bat='batcat'
alias fd='fdfind'
alias rm='rmz'
alias cp='cpz'
alias fzf='sk'
alias ps='procs --tree'
alias htop='btm'

# I don't remember why, but I need this
shopt -s globstar

# case insensitive auto complete
bind 'set completion-ignore-case on'
