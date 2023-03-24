#!/usr/bin/env lua
-- Load module (requires ubox-lua)
require "ubus"
require "uloop"

uloop.init()

-- Establish connection
local conn = ubus.connect()
if not conn then
    error("Failed to connect to ubusd")
end

local timer

function t()
    local ap = conn:call("iwinfo", "info", { device = "yiffyi-ap" })
    local sta = conn:call("iwinfo", "info", { device = "westlake-sta" })
    print(os.date("@%Y/%m/%d %X"))
    if sta ~= nil then
        -- STA exists
        if sta["htmode"] == "NOHT" then
            io.stderr:write("-- STA offline\n")
            if ap ~= nil then
                -- but AP exists, we will disable it
                conn:call("uci", "set", { config = "wireless", match = { ssid = "Yiffyi" }, values = { disabled = 1 } })
                conn:call("uci", "commit", { config = "wireless" })
                -- after commit: driver reload, STA disappears & offline for a while, AP disappears completely
            end
            print("+3000ms")
            timer:set(3000)
        elseif ap == nil or ap["htmode"] == "NOHT" then
            -- STA is online already, but AP is offline or disabled
            io.stderr:write("-- AP disabled OR offline\n")
            conn:call("uci", "set", { config = "wireless", section = "radio1", values = { channel = sta["channel"] } })
            conn:call("uci", "delete", { config = "wireless", match = { ssid = "Yiffyi" }, option = "disabled" })
            conn:call("uci", "commit", { config = "wireless" })
            -- after commit: driver reload, STA & AP both disappears & offline for a while
            -- we need to give STA more time to scan and associate, otherwise AP will got disabled again
            print("+30000ms")
            timer:set(30000)
        else
            print("-- seems NORMAL")
            print("+10000ms")
            timer:set(10000)
        end
    else
        io.stderr:write("-- STA not exist\n")
        print("+1000ms")
        timer:set(3000)
    end
end

timer = uloop.timer(t)
io.stderr:write("-- STA-AP-Fix script started. Sleep 40s...\n")
-- don't be panic if the system just booted
timer:set(40000)

uloop.run()
conn:close()
