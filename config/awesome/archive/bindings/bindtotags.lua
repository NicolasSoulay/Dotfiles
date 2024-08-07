-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

local _M = {}
local modkey = RC.vars.modkey

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Key bindings

function _M.get(globalkeys)
    -- Bind all key numbers to tags.
    -- Be careful: we use keycodes to make it work on any keyboard layout.
    -- This should map on the top row of your keyboard, usually 1 to 9.
    for i = 1, 9 do
        globalkeys = gears.table.join(globalkeys,

            --  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
            -- View tag only.
            awful.key({ modkey }, "#" .. i + 9,
                function()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[i]
                    if tag then
                        tag:view_only()
                    end
                end,
                { description = "view tag #" .. i, group = "tag" }),

            --  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
            -- Move client to tag.
            awful.key({ modkey, "Shift" }, "#" .. i + 9,
                function()
                    if client.focus then
                        local tag = client.focus.screen.tags[i]
                        if tag then
                            client.focus:move_to_tag(tag)
                        end
                    end
                end,
                { description = "move focused client to tag #" .. i, group = "tag" }),


            --  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
            awful.key({ modkey, "Control", "Mod1" }, "Right", function()
                    local screen = awful.screen.focused()
                    local t = screen.selected_tag
                    if t then
                        local idx = t.index + 1
                        if idx > #screen.tags then idx = 1 end
                        if client.focus then
                            client.focus:move_to_tag(screen.tags[idx])
                            screen.tags[idx]:view_only()
                        end
                    end
                end,
                { description = "move focused client to next tag and view tag", group = "tag" }),
            awful.key({ modkey, "Control", "Mod1" }, "Left", function()
                    local screen = awful.screen.focused()
                    local t = screen.selected_tag
                    if t then
                        local idx = t.index - 1
                        if idx == 0 then idx = #screen.tags end
                        if client.focus then
                            client.focus:move_to_tag(screen.tags[idx])
                            screen.tags[idx]:view_only()
                        end
                    end
                end,
                { description = "move focused client to previous tag and view tag", group = "tag" }),
            awful.key({ modkey, "Control", "Mod1" }, "l", function()
                    local screen = awful.screen.focused()
                    local t = screen.selected_tag
                    if t then
                        local idx = t.index + 1
                        if idx > #screen.tags then idx = 1 end
                        if client.focus then
                            client.focus:move_to_tag(screen.tags[idx])
                            screen.tags[idx]:view_only()
                        end
                    end
                end,
                { description = "move focused client to next tag and view tag", group = "tag" }),
            awful.key({ modkey, "Control", "Mod1" }, "h", function()
                    local screen = awful.screen.focused()
                    local t = screen.selected_tag
                    if t then
                        local idx = t.index - 1
                        if idx == 0 then idx = #screen.tags end
                        if client.focus then
                            client.focus:move_to_tag(screen.tags[idx])
                            screen.tags[idx]:view_only()
                        end
                    end
                end,
                { description = "move focused client to previous tag and view tag", group = "tag" })
        )
    end

    return globalkeys
end

-- }}}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
