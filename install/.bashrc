# Color prompt

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi


# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Environment Variables
if [ -f ~/.bash_env ]; then
   . ~/.bash_env
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

# I don't remember why, but I need this
shopt -s globstar

