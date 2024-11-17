-----------------------------
-- Lacerda's awesome theme --
-----------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local themes_path = "~/.config/awesome/themes/"

local theme = {}

theme.font = "JetBrainsMono NFM"

theme.useless_gap = dpi(3)
theme.border_width = dpi(1)

theme.bg_normal = os.getenv("BASE16_00") or "#282828"
theme.bg_focus = os.getenv("BASE16_03") or "#bdae93"
theme.bg_urgent = os.getenv("BASE16_08") or "#ea6962"
theme.bg_minimize = os.getenv("BASE16_04") or "#282828"
theme.bg_systray = theme.bg_normal

theme.fg_normal = os.getenv("BASE16_07") or "#ddc7a1"
theme.fg_focus = os.getenv("BASE16_07") or "#282828"
theme.fg_urgent = os.getenv("BASE16_07") or "#e78a4e"
theme.fg_minimize = os.getenv("BASE16_07") or "#d4be98"

theme.border_normal = os.getenv("BASE16_00") or "#282828"
theme.border_focus = os.getenv("BASE16_02") or "#bdae93"
theme.border_marked = os.getenv("BASE16_00") or "#282828"

theme.tasklist_bg_focus = os.getenv("BASE16_00") or "#282828"

theme.titlebar_bg_normal = os.getenv("BASE16_00") or "#282828"
theme.titlebar_bg_focus = os.getenv("BASE16_00") or "#282828"

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
