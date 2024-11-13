if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export BASE16_00="#282828"
export BASE16_01="#3c3836"
export BASE16_02="#504945"
export BASE16_03="#665c54"
export BASE16_04="#bdae93"
export BASE16_05="#d5c4a1"
export BASE16_06="#fbf1c7"
export BASE16_07="#D4BE98"
export BASE16_08="#ea6962"
export BASE16_09="#d3869b"
export BASE16_0A="#fabd2f"
export BASE16_0B="#a9b665"
export BASE16_0C="#89b482"
export BASE16_0D="#7daea3"
export BASE16_0E="#fe8019"
export BASE16_0F="#e78a4e"

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# XDG ninja recomendation
export EDITOR="/usr/bin/nvim"
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

PATH="/usr/sbin:$PATH"
. "$HOME/.local/share/cargo/env"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init bash)"
eval "$(zoxide init bash)"

# Load Angular CLI autocompletion.
source <(ng completion script)

if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi
