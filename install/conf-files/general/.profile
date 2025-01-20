# XDG Base Directories
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Tool-specific directories
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
export GCM_PLAINTEXT_STORE_PATH="$XDG_DATA_HOME/gcm/store"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export HISTFILE="$XDG_STATE_HOME/bash/history"
export ICEAUTHORITY="$XDG_CACHE_HOME/ICEauthority"
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql_history"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_INIT_MODULE="$XDG_CONFIG_HOME/npm/config/npm-init.js"
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR/npm"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
export WINEPREFIX="$XDG_DATA_HOME/wine"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XCURSOR_PATH=/usr/share/icons:$XDG_DATA_HOME/icons

# PATH configuration
export PATH="$HOME/.local/bin:/usr/sbin:$PATH"

# Editor
export EDITOR="/usr/local/bin/nvim"

# Load Cargo environment
[ -f "$HOME/.local/share/cargo/env" ] && . "$HOME/.local/share/cargo/env"

# NVM configuration
export NVM_DIR="$HOME/.config/nvm"
