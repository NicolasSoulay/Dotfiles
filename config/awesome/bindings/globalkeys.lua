-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
-- local hotkeys_popup = require("awful.hotkeys_popup").widget
local hotkeys_popup = require("awful.hotkeys_popup")
-- Menubar library
local menubar = require("menubar")

-- Resource Configuration
local modkey = RC.vars.modkey
local terminal = RC.vars.terminal
local file_manager = RC.vars.file_manager
local mail_client = RC.vars.mail_client
local browser = RC.vars.browser
local xrandr = require("xrandr")

local _M = {}

-- reading
-- https://awesomewm.org/wiki/Global_Keybindings

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get()
    local globalkeys = gears.table.join(
        awful.key({ modkey, }, "s", hotkeys_popup.show_help,
            { description = "show help", group = "awesome" }),
        awful.key({ modkey, "Control" }, "h", awful.tag.viewprev,
            { description = "view previous", group = "tag" }),
        awful.key({ modkey, "Control" }, "l", awful.tag.viewnext,
            { description = "view next", group = "tag" }),
        awful.key({ modkey, "Control" }, "Left", awful.tag.viewprev,
            { description = "view previous", group = "tag" }),
        awful.key({ modkey, "Control" }, "Right", awful.tag.viewnext,
            { description = "view next", group = "tag" }),
        awful.key({ modkey, }, "Escape", awful.tag.history.restore,
            { description = "go back", group = "tag" }),

        awful.key({ modkey, }, "l",
            function()
                awful.client.focus.byidx(1)
            end,
            { description = "focus next by index", group = "client" }
        ),
        awful.key({ modkey, }, "h",
            function()
                awful.client.focus.byidx(-1)
            end,
            { description = "focus previous by index", group = "client" }
        ),

        -- Layout manipulation
        awful.key({ modkey, "Shift" }, "l", function() awful.client.swap.byidx(1) end,
            { description = "swap with next client by index", group = "client" }),
        awful.key({ modkey, "Shift" }, "h", function() awful.client.swap.byidx(-1) end,
            { description = "swap with previous client by index", group = "client" }),
        awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end,
            { description = "focus the next screen", group = "screen" }),
        awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
            { description = "focus the previous screen", group = "screen" }),
        awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
            { description = "jump to urgent client", group = "client" }),

        -- Standard program
        awful.key({ modkey, }, "Return", function() awful.spawn(terminal) end,
            { description = "open a terminal", group = "launcher" }),
        awful.key({ modkey, "Control" }, "r", awesome.restart,
            { description = "reload awesome", group = "awesome" }),
        awful.key({ modkey, "Shift" }, "q", awesome.quit,
            { description = "quit awesome", group = "awesome" }),
        awful.key({ modkey, }, "Right", function() awful.tag.incmwfact(0.05) end,
            { description = "increase master width factor", group = "layout" }),
        awful.key({ modkey, }, "Left", function() awful.tag.incmwfact(-0.05) end,
            { description = "decrease master width factor", group = "layout" }),
        awful.key({ modkey, "Shift" }, "k", function() awful.tag.incnmaster(1, nil, true) end,
            { description = "increase the number of master clients", group = "layout" }),
        awful.key({ modkey, "Shift" }, "j", function() awful.tag.incnmaster(-1, nil, true) end,
            { description = "decrease the number of master clients", group = "layout" }),

        -- Rofi
        awful.key({ modkey }, "r", function()
                awful.util.spawn("rofi -show run")
            end,
            { description = "run rofi", group = "launcher" }),

        -- Rofi window
        awful.key({ "Mod1", }, "Tab", function()
                awful.util.spawn("rofi -show window")
            end,
            { description = "run rofi window", group = "launcher" }),


        -- File manager
        awful.key({ modkey }, "f", function()
                awful.util.spawn(terminal .. "-e " .. file_manager)
            end,
            { description = "open file manager", group = "launcher" }),

        -- Browser
        awful.key({ modkey }, "b", function()
                awful.util.spawn(browser)
            end,
            { description = "open your web browser", group = "launcher" }),

        -- Mail
        awful.key({ modkey }, "m", function()
                awful.util.spawn(mail_client)
            end,
            { description = "open your mail client", group = "launcher" }),

        -- Display configuration
        awful.key({ modkey }, "c", function()
                xrandr.xrandr()
            end,
            { description = "open your the display configuration", group = "launcher" }),
    )

    return globalkeys
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
