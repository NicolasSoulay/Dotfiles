local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local beautiful = require("beautiful") -- for awesome.icon

local M = {}                           -- menu
local _M = {}                          -- module

local terminal = RC.vars.terminal
local editor = os.getenv("EDITOR") or "nvim"
local editor_cmd = terminal .. " -e " .. editor

local has_fdo, freedesktop = pcall(require, "freedesktop")


M.awesome = {
    { "hotkeys", function()
        hotkeys_popup.show_help(nil, awful.screen.focused())
    end },
    { "manual",          terminal .. " -e man awesome" },
    { "edit config",     editor_cmd .. " " .. awesome.conffile },
    { "Shutdown/Logout", "oblogout" },
    { "restart",         awesome.restart },
    { "quit",            function() awesome.quit() end }
}


function _M.get()
    -- Main Menu
    local menu_items = {
        { "awesome",       M.awesome, beautiful.awesome_subicon },
        { "open terminal", terminal },
    }
    local mymainmenu = freedesktop.menu.build({
        before = { menu_awesome },
        after = { menu_terminal }
    })

    return menu_items
end

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
