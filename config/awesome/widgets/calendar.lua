-------------------------------------------------
-- Calendar Widget for Awesome Window Manager
-- Shows the current month and supports scroll up/down to switch month
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/calendar-widget

-- @author Pavel Makhov
-- @copyright 2019 Pavel Makhov
-------------------------------------------------

local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")

local calendar_widget = {}

local function worker()
	local calendar_themes = {
		naughty = {
			bg = beautiful.notification_bg or beautiful.bg or beautiful.bg_normal,
			fg = beautiful.notification_fg or beautiful.fg or beautiful.fg_normal,
			focus_date_bg = beautiful.notification_fg or beautiful.fg or beautiful.fg_normal,
			focus_date_fg = beautiful.notification_bg or beautiful.bg or beautiful.bg_normal,
			weekend_day_bg = beautiful.bg_focus,
			weekday_fg = beautiful.fg,
			header_fg = beautiful.fg,
			border = beautiful.border_focus,
		},
	}

	local theme = "naughty"
	local radius = 8
	local next_month_button = 1
	local previous_month_button = 3
	local start_sunday = false
	local week_numbers = false

	local styles = {}
	local function rounded_shape(size)
		return function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, size)
		end
	end

	styles.month = {
		padding = 4,
		bg_color = calendar_themes[theme].bg,
		border_width = 0,
	}

	styles.normal = {
		markup = function(t)
			return t
		end,
		shape = rounded_shape(4),
	}

	styles.focus = {
		fg_color = calendar_themes[theme].focus_date_fg,
		bg_color = calendar_themes[theme].focus_date_bg,
		markup = function(t)
			return "<b>" .. t .. "</b>"
		end,
		shape = rounded_shape(4),
	}

	styles.header = {
		fg_color = calendar_themes[theme].header_fg,
		bg_color = calendar_themes[theme].bg,
		markup = function(t)
			return "<b>" .. t .. "</b>"
		end,
	}

	styles.weekday = {
		fg_color = calendar_themes[theme].weekday_fg,
		bg_color = calendar_themes[theme].bg,
		markup = function(t)
			return "<b>" .. t .. "</b>"
		end,
	}

	local function decorate_cell(widget, flag, date)
		if flag == "monthheader" and not styles.monthheader then
			flag = "header"
		end

		-- highlight only today's day
		if flag == "focus" then
			local today = os.date("*t")
			if not (today.month == date.month and today.year == date.year) then
				flag = "normal"
			end
		end

		local props = styles[flag] or {}
		if props.markup and widget.get_text and widget.set_markup then
			widget:set_markup(props.markup(widget:get_text()))
		end
		-- Change bg color for weekends
		local default_bg
		if flag == "normal" then
			local d = { year = date.year, month = (date.month or 1), day = (date.day or 1) }
			local weekday = tonumber(os.date("%w", os.time(d)))
			default_bg = (weekday == 0 or weekday == 6) and calendar_themes[theme].weekend_day_bg
				or calendar_themes[theme].bg
		end
		local ret = wibox.widget({
			{
				{
					widget,
					halign = "center",
					widget = wibox.container.place,
				},
				margins = (props.padding or 2) + (props.border_width or 0),
				widget = wibox.container.margin,
			},
			shape = props.shape,
			shape_border_color = props.border_color or "#000000",
			shape_border_width = props.border_width or 0,
			fg = props.fg_color or calendar_themes[theme].fg,
			bg = props.bg_color or default_bg,
			widget = wibox.container.background,
		})

		return ret
	end

	local cal = wibox.widget({
		date = os.date("*t"),
		font = beautiful.get_font(),
		fn_embed = decorate_cell,
		long_weekdays = true,
		start_sunday = start_sunday,
		week_numbers = week_numbers,
		widget = wibox.widget.calendar.month,
	})

	local popup = awful.popup({
		ontop = true,
		visible = false,
		shape = rounded_shape(radius),
		offset = { y = 5 },
		border_width = 1,
		border_color = calendar_themes[theme].border,
		widget = cal,
	})

	popup:buttons(awful.util.table.join(
		awful.button({}, next_month_button, function()
			local a = cal:get_date()
			a.month = a.month + 1
			cal:set_date(nil)
			cal:set_date(a)
			popup:set_widget(cal)
		end),
		awful.button({}, previous_month_button, function()
			local a = cal:get_date()
			a.month = a.month - 1
			cal:set_date(nil)
			cal:set_date(a)
			popup:set_widget(cal)
		end)
	))

	function calendar_widget.toggle()
		if popup.visible then
			-- to faster render the calendar refresh it and just hide
			cal:set_date(nil) -- the new date is not set without removing the old one
			cal:set_date(os.date("*t"))
			popup:set_widget(nil) -- just in case
			popup:set_widget(cal)
			popup.visible = not popup.visible
		else
			awful.placement.bottom(popup, {
				margins = {left = 3000, bottom = 50 },
				parent = awful.screen.focused(),
			})

			popup.visible = true
		end
	end

	return calendar_widget
end

return setmetatable(calendar_widget, {
	__call = function(_, ...)
		return worker(...)
	end,
})
