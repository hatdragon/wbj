local _, ns = ...

-------------------------------------------------------------------------------
-- CatchTracker — records fish catches via LOOT_OPENED + IsFishingLoot()
-------------------------------------------------------------------------------
local CatchTracker = {}
ns.CatchTracker = CatchTracker

local isTracking = false

local function OnLootOpened()
    if not ns.db or not ns.db.settings.trackCatches then return end
    if not IsFishingLoot() then return end

    local mapID = ns.Util.GetPlayerMapID()
    local subZone = ns.Util.GetPlayerSubZone()
    local now = time()

    for i = 1, GetNumLootItems() do
        local link = GetLootSlotLink(i)
        local itemID = ns.Util.ParseItemID(link)
        if itemID then
            local _, _, quantity = GetLootSlotInfo(i)
            quantity = quantity or 1

            -- Raw record: { itemID, count, mapID, subZone, timestamp }
            table.insert(ns.db.catches, { itemID, quantity, mapID, subZone, now })

            -- Update totals inline
            if not ns.db.totals[itemID] then
                ns.db.totals[itemID] = {
                    count = 0,
                    firstCaught = now,
                    lastCaught = now,
                    zones = {},
                }
                ns.db.sessions.uniqueSpecies = ns.db.sessions.uniqueSpecies + 1
            end

            local entry = ns.db.totals[itemID]
            entry.count = entry.count + quantity
            entry.lastCaught = now
            if mapID then
                entry.zones[mapID] = (entry.zones[mapID] or 0) + quantity
            end

            ns.db.sessions.totalCatches = ns.db.sessions.totalCatches + quantity

            -- Check for rare catch sound
            if ns.db.settings.soundOnRareCatch then
                local _, _, quality = GetItemInfo(itemID)
                if quality and quality >= Enum.ItemQuality.Rare then
                    PlaySound(SOUNDKIT.ALARM_CLOCK_WARNING_3)
                end
            end
        end
    end

    -- Increment session count (once per fishing session opening)
    ns.db.sessions.totalSessions = ns.db.sessions.totalSessions + 1

    -- Live-update the Catch Log if it's currently visible
    if ns.CatchLogView and ns.CatchLogView.frame and ns.CatchLogView.frame:IsShown() then
        ns.CatchLogView:Refresh()
    end
end

-- Substring patterns that indicate a fishing failure.
-- We match substrings (case-insensitive) because exact message text varies by
-- locale and WoW version.  These are checked against every UIErrorsFrame message,
-- so we keep the patterns fishing-specific to avoid false positives.
local FISHING_FAIL_PATTERNS = {
    "no fish are hooked",
    "fish got away",
    "didn't land in fishable water",
    "too shallow",
    "not in line of sight",
}

local function IsFishingFail(msg)
    if not msg then return false end
    local lower = msg:lower()
    for _, pattern in ipairs(FISHING_FAIL_PATTERNS) do
        if lower:find(pattern, 1, true) then
            return true
        end
    end
    return false
end

local function OnFishingFail()
    if not ns.db or not ns.db.settings.trackCatches then return end
    ns.db.sessions.missedCatches = ns.db.sessions.missedCatches + 1
    if ns.CatchLogView and ns.CatchLogView.frame and ns.CatchLogView.frame:IsShown() then
        ns.CatchLogView:Refresh()
    end
end

function CatchTracker:Start()
    if isTracking then return end
    isTracking = true
    ns:RegisterCallback("LOOT_OPENED", function()
        local ok, err = pcall(OnLootOpened)
        if not ok then
            print("|cffff4444WBJ CatchTracker error:|r " .. tostring(err))
        end
    end)

    -- "No fish are hooked" / "fish got away" come via UI_INFO_MESSAGE
    -- "Water too shallow" / "line of sight" come via UI_ERROR_MESSAGE
    local function CheckFishingFail(_, _, msg)
        if IsFishingFail(msg) then
            pcall(OnFishingFail)
        end
    end
    ns:RegisterCallback("UI_INFO_MESSAGE", CheckFishingFail)
    ns:RegisterCallback("UI_ERROR_MESSAGE", CheckFishingFail)
end

-- Auto-start on addon load
ns:RegisterCallback("ADDON_LOADED", function()
    CatchTracker:Start()
end)
