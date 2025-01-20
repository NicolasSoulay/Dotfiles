# Load environment variables from .profile
[ -f ~/.profile ] && . ~/.profile

# Color prompt handled by Starship
if [ -x "$(command -v starship)" ]; then
    eval "$(starship init bash)"
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# History configuration
shopt -s histappend
PROMPT_COMMAND="history -a"

# Increase history size
export HISTSIZE=5000
export HISTFILESIZE=10000

# Aliases (sourced from ~/.bash_aliases)
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# Case-insensitive autocomplete
bind 'set completion-ignore-case on'

# Enable recursive globbing
shopt -s globstar

# Lazy load tools
command -v zoxide &>/dev/null && eval "$(zoxide init bash)"
command -v fzf &>/dev/null && export FZF_DEFAULT_COMMAND='fd --type f'

# Load NVM
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
