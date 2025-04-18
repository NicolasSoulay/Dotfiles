local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local gears = require("gears")
local dpi = xresources.apply_dpi

return {
	font = "JetBrainsMono NFP 16",

	useless_gap = dpi(11),
	border_width = dpi(2),

	master_width_factor = 0.72,
	master_fill_policy = "master_width_factor",

    wibar_heigth = 38,
    wibar_position = "top",

	bg_systray = "#282828",

	bg_normal = "#282828",
	fg_normal = "#d4be98",

	bg_focus = "#bdae93",
	fg_focus = "#282828",

	bg_urgent = "#ea6962",
	fg_urgent = "#282828",

	bg_minimize = "#282828",
	fg_minimize = "#d4be98",

	border_normal = "#282828",
	border_focus = "#d4be98",
	border_marked = "#282828",

    tasklist_bg_normal = "#282828",
    tasklist_fg_normal = "#d4be98",
	tasklist_bg_focus = "#504945",
    tasklist_fg_focus = "#d4be98",

    tasklist_shape_border_color = "#282828",
    tasklist_shape_border_color_focus = "#d4be98",

    hotkeys_modifiers_fg = "#d8a657",
    hotkeys_shape = gears.shape.rounded_rect,

	taglist_squares_sel = theme_assets.taglist_squares_sel(dpi(5), "#282828"),
	taglist_squares_unsel = theme_assets.taglist_squares_unsel(dpi(5), "#ddc7a1"),

	icon_theme = nil,
}
