local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local home = os.getenv("HOME")

beautiful.init(home .. "/.config/awesome/theme/init.lua")
beautiful.useless_gap = 5
