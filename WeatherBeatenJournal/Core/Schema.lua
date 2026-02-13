local _, ns = ...

local Schema = {}
ns.Schema = Schema

Schema.DB_VERSION = 1

Schema.DEFAULTS = {
    dbVersion = Schema.DB_VERSION,
    catches = {},
    totals = {},
    sessions = {
        totalCatches = 0,
        uniqueSpecies = 0,
        totalSessions = 0,
        missedCatches = 0,
    },
    lastSection = 2,  -- Default to Spot Guide
    catchLogSort = ns.SORT_RECENT,
    catchLogFishOnly = false,
    settings = {
        trackCatches = true,
        showNarrator = true,
        soundOnRareCatch = true,
    },
}

-------------------------------------------------------------------------------
-- Initialize or migrate DB
-------------------------------------------------------------------------------
function Schema:InitDB()
    if not WeatherBeatenJournalDB then
        WeatherBeatenJournalDB = ns.Util.DeepCopy(self.DEFAULTS)
        return
    end

    local db = WeatherBeatenJournalDB

    -- Ensure all top-level keys exist
    for k, v in pairs(self.DEFAULTS) do
        if db[k] == nil then
            db[k] = ns.Util.DeepCopy(v)
        end
    end

    -- Ensure nested settings keys exist
    for k, v in pairs(self.DEFAULTS.settings) do
        if db.settings[k] == nil then
            db.settings[k] = v
        end
    end

    for k, v in pairs(self.DEFAULTS.sessions) do
        if db.sessions[k] == nil then
            db.sessions[k] = v
        end
    end

    -- Future migrations
    -- if db.dbVersion < 2 then ... end

    db.dbVersion = self.DB_VERSION
end

-------------------------------------------------------------------------------
-- Rebuild totals from raw catches
-------------------------------------------------------------------------------
function Schema:RebuildTotals()
    local db = WeatherBeatenJournalDB
    local totals = {}

    for _, record in ipairs(db.catches) do
        local itemID = record[1]
        local count = record[2]
        local mapID = record[3]
        local timestamp = record[5]

        if not totals[itemID] then
            totals[itemID] = {
                count = 0,
                firstCaught = timestamp,
                lastCaught = timestamp,
                zones = {},
            }
        end

        local entry = totals[itemID]
        entry.count = entry.count + count
        if timestamp and (not entry.firstCaught or timestamp < entry.firstCaught) then
            entry.firstCaught = timestamp
        end
        if timestamp and (not entry.lastCaught or timestamp > entry.lastCaught) then
            entry.lastCaught = timestamp
        end
        if mapID then
            entry.zones[mapID] = (entry.zones[mapID] or 0) + count
        end
    end

    db.totals = totals

    -- Update session stats
    local totalCatches = 0
    local uniqueSpecies = 0
    for _, entry in pairs(totals) do
        totalCatches = totalCatches + entry.count
        uniqueSpecies = uniqueSpecies + 1
    end
    db.sessions.totalCatches = totalCatches
    db.sessions.uniqueSpecies = uniqueSpecies
end
