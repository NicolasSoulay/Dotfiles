local wibox = require("wibox")
local awful = require("awful")

local weather_widget = wibox.widget({
	widget = wibox.container.background,
	{
		id = "first",
		layout = wibox.layout.fixed.horizontal,
		{
			id = "second",
			widget = wibox.container.background,
			{
				id = "weather",
				widget = wibox.widget.textbox,
				text = "?",
				font = "JetBrainsMono NFP 30",
			},
		},
		{
			id = "temp",
			widget = wibox.widget.textbox,
			text = "?",
		},
	},
})

return awful.widget.watch('bash -c "forecaster"', 300, function(widget, stdout)
	local i = 0
	local temp = ""
	local color = "#d8a657"
	local icon = ""
	for line in string.gmatch(stdout, "[^ ]+") do
		if i == 0 then
			temp = " " .. line .. " |"
		end
		if i == 1 then
			icon = line
		end
		if i == 2 then
			color = "#7daea3"
		end
		i = i + 1
	end
	widget.first.temp.text = temp
	widget.first.second.weather.text = icon
	widget.first.second.fg = color
end, weather_widget)
