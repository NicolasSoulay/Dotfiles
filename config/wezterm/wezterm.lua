local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Gruvbox Material (Gogh)'
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font 'JetBrainsMono NFM'

return config
