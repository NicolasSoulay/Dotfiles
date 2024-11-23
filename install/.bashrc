# Color prompt
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# XDG ninja recomendation
export EDITOR="/usr/local/bin/nvim"
export HISTFILE="$XDG_STATE_HOME"/bash/history
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export XCURSOR_PATH=/usr/share/icons:$XDG_DATA_HOME/icons
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mysql_history
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export WINEPREFIX="$XDG_DATA_HOME"/wine
export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export GCM_PLAINTEXT_STORE_PATH="$XDG_DATA_HOME"/gcm/store
export DOTNET_CLI_HOME="$XDG_DATA_HOME"/dotnet
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export STARSHIP_CONFIG="$XDG_CONFIG_HOME"/starship/starship.toml

export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/sbin:$PATH"
. "$HOME/.local/share/cargo/env"

export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
export MANROFFOPT="-c"

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
alias gog='lgogdownloader'
alias grep='rg --color=auto'
alias fgrep='rg -F --color=auto'
alias egrep='egrep --color=auto'
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
alias cd='z'
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

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init bash)"
eval "$(zoxide init bash)"

