local ADDON_NAME, ns = ...

-------------------------------------------------------------------------------
-- Public namespace
-------------------------------------------------------------------------------
WeatherBeatenJournal = ns

-------------------------------------------------------------------------------
-- Event frame
-------------------------------------------------------------------------------
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
ns.eventFrame = eventFrame

local callbacks = {}

function ns:RegisterCallback(event, fn)
    if not callbacks[event] then
        callbacks[event] = {}
        if event ~= "ADDON_LOADED" then
            eventFrame:RegisterEvent(event)
        end
    end
    table.insert(callbacks[event], fn)
end

eventFrame:SetScript("OnEvent", function(_, event, ...)
    if event == "ADDON_LOADED" then
        local loadedAddon = ...
        if loadedAddon == ADDON_NAME then
            ns.Schema:InitDB()
            ns.Schema:RebuildTotals()
            ns.db = WeatherBeatenJournalDB
            eventFrame:UnregisterEvent("ADDON_LOADED")

            -- Fire any ADDON_LOADED callbacks
            if callbacks["ADDON_LOADED"] then
                for _, fn in ipairs(callbacks["ADDON_LOADED"]) do
                    fn()
                end
            end
        end
        return
    end

    if callbacks[event] then
        for _, fn in ipairs(callbacks[event]) do
            fn(event, ...)
        end
    end
end)

-------------------------------------------------------------------------------
-- Slash command
-------------------------------------------------------------------------------
SLASH_WBJ1 = "/wbj"
SLASH_WBJ2 = "/weatherbeatenjournal"
SlashCmdList["WBJ"] = function(msg)
    msg = strtrim(msg):lower()
    if msg == "reset" then
        WeatherBeatenJournalDB = nil
        ns.Schema:InitDB()
        ns.db = WeatherBeatenJournalDB
        print("|cff88ccffWeather-Beaten Journal:|r Data reset.")
    elseif msg == "stats" then
        local db = ns.db
        if db then
            print("|cff88ccffWeather-Beaten Journal:|r Stats:")
            print(format("  Total catches: %d", db.sessions.totalCatches))
            print(format("  Unique species: %d", db.sessions.uniqueSpecies))
            print(format("  Sessions: %d", db.sessions.totalSessions))
        end
    else
        print("|cff88ccffWeather-Beaten Journal|r v" .. ns.VERSION)
        print("  /wbj stats  — Show fishing statistics")
        print("  /wbj reset  — Reset all data")
    end
end
