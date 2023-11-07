-- Standard awesome library
local gears            = require("gears")
local awful            = require("awful")

-- Wibox handling library
local wibox            = require("wibox")

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
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

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
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the bottom  wibox
    s.mywibox = wibox({
        screen = s,
        height = 30,
        opacity = 1,
        width = 250,
        y = sgeo.height - 40,
        x = sgeo.width - sgeo.width / 1.75,
        ontop = true,
    })
    s.mywibox.visible = true

    s.myinvisiblewibar = awful.wibar({ screen = s, height = 35, opacity = 0, position = "bottom" })

    -- Create the top wibar
    s.mywibar = awful.wibar({ screen = s, height = 30, opacity = 1, position = "top" })


    -- Add widgets to the wibar
    s.mywibar:setup {
        layout = wibox.layout.align.horizontal,
        expand = 'outside',
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            -- RC.launcher,
            -- s.mytaglist,
        },
        -- s.mytasklist, -- Middle widget
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
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            RC.launcher,
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
