-- Standard awesome library
local gears            = require("gears")
local awful            = require("awful")

-- Wibox handling library
local wibox            = require("wibox")
local beautiful        = require("beautiful")
-- Custom Local Library: Common Functional Decoration
local boxes            = {
    taglist  = require("boxes.taglist"),
    tasklist = require("boxes.tasklist")
}

local taglist_buttons  = boxes.taglist()
local tasklist_buttons = boxes.tasklist()

local _M               = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Wibar
-- Create a textclock widget
mytextclock            = wibox.widget.textclock("%H:%M")

awful.screen.connect_for_each_screen(function(s)
    local sgeo = s.geometry
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)
    ))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen          = s,
        filter          = awful.widget.tasklist.filter.currenttags,
        buttons         = tasklist_buttons,
        widget_template = {
            {
                {
                    {
                        {
                            id     = 'icon_role',
                            widget = wibox.widget.imagebox,
                            resize = true,
                        },
                        margins = 5,
                        widget  = wibox.container.margin,
                    },
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left   = 10,
                right  = 10,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
        },
    }

    -- Create a menu widget
    s.mainmenu = wibox.widget {
        {
            image = beautiful.debian_icon,
            resize = true,
            forced_height = 20,
            widget = wibox.widget.imagebox,
        },
        top = 2, bottom = 2, left = 8,
        widget = wibox.container.margin,
    }

    s.mainmenu:connect_signal("button::press", function() awful.util.spawn("xfce4-popup-whiskermenu -p") end)

    -- Create the bottom  wibox

    s.myinvisiblewibar = awful.wibar({ screen = s, height = 40, opacity = 0, position = "bottom" })
    s.mywibox = wibox({
        screen  = s,
        height  = 30,
        opacity = 1,
        width   = 250,
        y       = sgeo.height - 40,
        x       = sgeo.width - sgeo.width / 2 - 125, -- width of screen/2 - half the wibox width
        ontop   = false,
    })
    s.mywibox.visible = true

    -- Create the top wibar
    s.mywibar = awful.wibar({ screen = s, height = 30, opacity = 1, position = "top" })


    -- Add widgets to the wibar
    s.mywibar:setup {
        layout = wibox.layout.align.horizontal,
        expand = 'outside',
        { -- Left widgets
            layout = wibox.layout.flex.horizontal,
            s.mytasklist,
        },
        {
            layout = wibox.layout.flex.horizontal,
            wibox.container.place(mytextclock, "center", "center"),
        },
        { -- Right widgets
            layout = wibox.layout.flex.horizontal,
            wibox.container.place(wibox.widget.systray(), "right", "center"),
        },
    }
    -- wibox.widget.systray:set_base_size(10)

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = 'outside',
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 5)
        end,

        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mainmenu,
        },
        {
            s.mytaglist,
            layout = wibox.layout.flex.horizontal,
        },
        { -- Right widgets
            wibox.container.place(s.mylayoutbox, "right", "center"),
            layout = wibox.layout.flex.horizontal,
        },
    }
end)
-- }}}
