local wibox = require("wibox")
local beautiful = require("beautiful")

local function script_path()
	local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*/)")
end

local widget_dir = script_path()
local icon_dir = widget_dir .. "../icons/"

local widget = {}

function widget.get_widget(widgets_args)
	local args = widgets_args or {}

	local thickness = args.thickness or 3
	local main_color = args.main_color or beautiful.fg_color
	local bg_color = args.bg_color or "#504945"
	local mute_color = args.mute_color or "#504945"
	local size = args.size or 28

	return wibox.widget({
		{
			id = "icon",
			resize = true,
			widget = wibox.widget.imagebox,
		},
		max_value = 100,
		thickness = thickness,
		start_angle = 4.71238898, -- 2pi*3/4
		forced_height = size,
		forced_width = size,
		bg = bg_color,
		paddings = 3,
		widget = wibox.container.arcchart,
		set_volume_level = function(self, new_value)
            local volume_icon_name
			self.value = new_value
			if self.is_muted then
				volume_icon_name = "audio-volume-muted-symbolic"
			else
				if new_value == 0 then
					volume_icon_name = "audio-volume-muted-symbolic"
				elseif new_value > 0 and new_value < 33 then
					volume_icon_name = "audio-volume-low-symbolic"
				elseif new_value < 66 then
					volume_icon_name = "audio-volume-medium-symbolic"
				else
					volume_icon_name = "audio-volume-high-symbolic"
				end
			end
			self:get_children_by_id("icon")[1]:set_image(icon_dir .. volume_icon_name .. ".svg")
		end,
		mute = function(self)
            self.is_muted = true
			self.colors = { mute_color }
		end,
		unmute = function(self)
            self.is_muted = false
			self.colors = { main_color }
		end,
	})
end

return widget
