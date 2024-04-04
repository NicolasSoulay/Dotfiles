pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

local has_fdo, freedesktop = pcall(require, "freedesktop")

RC = {} -- global namespace, on top before require any modules
RC.vars = require("main.user-variables")

require("main.error-handling")

require("main.theme")

local main = {
    layouts = require("main.layouts"),
    tags    = require("main.tags"),
    menu    = require("main.menu"),
    rules   = require("main.rules"),
}

local binding = {
    globalbuttons = require("bindings.globalbuttons"),
    clientbuttons = require("bindings.clientbuttons"),
    globalkeys    = require("bindings.globalkeys"),
    bindtotags    = require("bindings.bindtotags"),
    clientkeys    = require("bindings.clientkeys")
}

RC.layouts = main.layouts()
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.fair,
    awful.layout.suit.floating,
}
RC.tags = main.tags()
RC.mainmenu = awful.menu({ items = main.menu() }) -- in globalkeys

RC.launcher = awful.widget.launcher(
    { image = beautiful.awesome_icon, menu = RC.mainmenu }
)

menubar.utils.terminal = RC.vars.terminal

RC.globalkeys = binding.globalkeys()
RC.globalkeys = binding.bindtotags(RC.globalkeys)

root.buttons(binding.globalbuttons())
root.keys(RC.globalkeys)

mykeyboardlayout = awful.widget.keyboardlayout()

require("boxes.statusbar")

awful.rules.rules = main.rules(
    binding.clientkeys(),
    binding.clientbuttons()
)

require("main.signals")

-- Autostart Applications
awful.spawn.with_shell("nitrogen --restore")
awful.spawn.with_shell("picom")
awful.spawn.with_shell("dbus-run-session")
