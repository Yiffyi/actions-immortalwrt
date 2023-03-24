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
local cached_ifnames = {}

function t()
    local commit = false
    local delay = 10000
    for k, v in pairs(cached_ifnames) do
        local radio = k
        local sta_ifname = v.sta
        local ap_ifname = v.ap
        local ap = conn:call("iwinfo", "info", { device = ap_ifname })
        local sta = conn:call("iwinfo", "info", { device = sta_ifname })
        print(os.date("@%Y/%m/%d %X"))
        if sta ~= nil then
            -- STA exists
            if sta["htmode"] == "NOHT" then
                io.stderr:write("-- STA offline\n")
                if ap ~= nil then
                    -- but AP exists, we will disable it
                    conn:call("uci", "set", { config = "wireless", match = { mode = "ap", device = radio }, values = { disabled = 1 } })
                    commit = true
                    -- after commit: driver reload, STA disappears & offline for a while, AP disappears completely
                end
                print("+10000ms")
                delay = 10000
            elseif ap == nil or ap["htmode"] == "NOHT" then
                -- STA is online already, but AP is offline or disabled
                io.stderr:write("-- AP disabled OR offline\n")
                conn:call("uci", "set", { config = "wireless", section = "radio1", values = { channel = sta["channel"] } })
                conn:call("uci", "delete", { config = "wireless", match = { mode = "ap", device = radio }, option = "disabled" })
                commit = true
                -- after commit: driver reload, STA & AP both disappears & offline for a while
                -- we need to give STA more time to scan and associate, otherwise AP will got disabled again
                print("+30000ms")
                delay = 30000
            else
                print("-- seems NORMAL")
                print("+10000ms")
                delay = 10000
            end
        else
            io.stderr:write("-- STA not exist\n")
            print("+10000ms")
            delay = 10000
        end
    end
    if commit then
        conn:call("uci", "commit", { config = "wireless" })
    end
    timer:set(delay)
end

timer = uloop.timer(t)

-- function get_ifname(radio, section)
--     local r = conn:call("network.wireless", "status")
--     for i, v in ipairs(r[radio]["interfaces"]) do
--         if v["section"] == section then
--             return v["ifname"]
--         end
--     end
-- end

-- You must explicitly assign an ifname for all networks
function init()
    local r = conn:call("uci", "get", { config = "wireless", match = { mode = "sta" }})["values"]
    cached_ifnames = {}
    local total = 0
    for section, v in pairs(r) do
        if v["ifname"] ~= nil then
            local a = conn:call("uci", "get", { config = "wireless", match = { mode = "ap", device = v["device"] }})["values"]
            local ap_ifname
            for section, v in pairs(a) do
                -- we just pick one ap, it's enough
                ap_ifname = v["ifname"]
                break
            end
            if ap_ifname ~= nil then
                total = total + 1
                cached_ifnames[v["device"]] = { ap = ap_ifname, sta = v["ifname"] }
            end
        end
    end
    uloop.timer(init, 60000)
    if total == 0 then
        io.stderr:write("-- No STA & AP found\n")
        -- os.exit(1)
    else
        io.stderr:write(string.format("-- Found %d radio(s) with STA & AP\n", total))
        timer:set(1000)
    end
end

-- don't be panic if the system just booted
uloop.timer(init, 30000)
-- timer:set(40000)

uloop.run()
conn:close()
