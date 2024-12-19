local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local themes_path = "~/.config/awesome/themes/"

local theme = {}

theme.font = "JetBrainsMono NFP"

theme.useless_gap = dpi(31)
theme.gap_single_client = dpi(31)
theme.border_width = dpi(1)
theme.master_width_factor = 0.74
theme.master_fill_policy = "master_width_factor"

theme.bg_systray = theme.bg_normal

theme.bg_normal = "#282828"
theme.fg_normal = "#ddc7a1"

theme.bg_focus = "#bdae93"
theme.fg_focus = "#282828"

theme.bg_urgent = "#ea6962"
theme.fg_urgent = "#282828"

theme.bg_minimize = "#282828"
theme.fg_minimize = "#d4be98"

theme.border_normal = "#282828"
theme.border_focus = "#bdae93"
theme.border_marked = "#282828"

theme.tasklist_bg_focus = "#282828"
theme.tasklist_fg_focus = "#ddc7a1"

theme.titlebar_bg_normal = "#282828"
theme.titlebar_bg_focus = "#282828"

-- Generate taglist squares:
local taglist_square_size = dpi(5)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_focus)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv = themes_path .. "default/layouts/fairvw.png"
theme.layout_floating = themes_path .. "default/layouts/floatingw.png"
theme.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
theme.layout_max = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile = themes_path .. "default/layouts/tilew.png"
theme.layout_tiletop = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse = themes_path .. "default/layouts/cornersew.png"

theme.icon_theme = nil

return theme
