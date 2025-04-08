local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

return {
	font = "JetBrainsMono NFP",

	useless_gap = dpi(11),
	gap_single_client = dpi(31),
	border_width = dpi(1),
	master_width_factor = 0.75,
	master_fill_policy = "master_width_factor",

	bg_systray = "#282828",

	bg_normal = "#282828",
	fg_normal = "#ddc7a1",

	bg_focus = "#bdae93",
	fg_focus = "#282828",

	bg_urgent = "#ea6962",
	fg_urgent = "#282828",

	bg_minimize = "#282828",
	fg_minimize = "#d4be98",

	border_normal = "#282828",
	border_focus = "#bdae93",
	border_marked = "#282828",

	tasklist_bg_focus = "#282828",
	tasklist_fg_focus = "#ddc7a1",

	taglist_squares_sel = theme_assets.taglist_squares_sel(dpi(5), "#282828"),
	taglist_squares_unsel = theme_assets.taglist_squares_unsel(dpi(5), "#ddc7a1"),

	icon_theme = nil,
}
