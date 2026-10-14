local _, ns = ...

-------------------------------------------------------------------------------
-- ProfessionDataProvider — Runtime fish data from C_TradeSkillUI
--
-- Scans the fishing profession journal (DF+) to extract per-fish data:
-- zone locations, fishing pool types, special abilities, flavor text, and
-- rarity via categories. Enriches ns.FishData entries with fields that would
-- otherwise require manual maintenance.
--
-- Scope: DF, TWW, and Midnight fish (~40 recipes). Pre-DF fish have no
-- recipe data in the API.
--
-- English only — description parsing relies on English section headers.
-- Session-only cache — rebuilt each login to avoid stale data across patches.
-------------------------------------------------------------------------------
local ProfessionData = {}
ns.ProfessionData = ProfessionData

-- Session cache
local recipeCache = {}   -- [recipeID] = parsed entry
local itemToRecipe = {}  -- [itemID] = recipeID (reverse lookup after enrichment)
local isLoaded = false

-- Reverse lookups (built once at file load from FishData/ZoneData)
local nameToItemID = {}     -- fish name -> itemID
local zoneNameToMapID = {}  -- zone display name -> mapID

-------------------------------------------------------------------------------
-- Build reverse lookup tables
-------------------------------------------------------------------------------
local function BuildLookups()
    for itemID, entry in pairs(ns.FishData) do
        if entry.name and not nameToItemID[entry.name] then
            nameToItemID[entry.name] = itemID
        end
    end
    for mapID, zone in pairs(ns.ZoneData) do
        if zone.name and not zoneNameToMapID[zone.name] then
            zoneNameToMapID[zone.name] = mapID
        end
    end
end

-------------------------------------------------------------------------------
-- Fish category detection
-------------------------------------------------------------------------------

-- Known fish category IDs from in-game research
local FISH_CATEGORY_IDS = {
    -- TWW
    [2068] = true, -- Common
    [2069] = true, -- Uncommon
    [2070] = true, -- Rare
    -- Midnight
    [2197] = true, -- Common
    [2233] = true, -- Uncommon
    [2234] = true, -- Rare
    [2756] = true, -- Cursed Oddities (12.1, The Coiled Isle)
    -- Dragonflight
    [1806] = true, -- Freshwater
    [1807] = true, -- Saltwater
    [1808] = true, -- Specialty
    [1809] = true, -- General
}

-- Known non-fish categories to exclude
local EXCLUDED_CATEGORY_IDS = {
    [2198] = true, -- Zones
    [2199] = true, -- Information
    [2208] = true, -- Crafting
    [2120] = true, -- Angler's Log
    [2122] = true, -- Algari Weaverline
    [2123] = true, -- Test Your Ability
    [2704] = true, -- Appendix I - Terms
    [2705] = true, -- Appendix II - Stats
}

local function IsFishCategory(categoryID, categoryName)
    if FISH_CATEGORY_IDS[categoryID] then return true end
    if EXCLUDED_CATEGORY_IDS[categoryID] then return false end
    -- Fallback: check name patterns
    if categoryName then
        local lower = categoryName:lower()
        if lower:find("fish") or lower:find("freshwater") or lower:find("saltwater") or lower:find("specialty") then
            return true
        end
    end
    return false
end

-------------------------------------------------------------------------------
-- Description parser
-------------------------------------------------------------------------------

-- Strip all WoW escape sequences from a string
local function StripEscapes(text)
    if not text then return "" end
    -- Remove texture markup |Tpath:w:h...|t
    text = text:gsub("|T[^|]*|t", "")
    -- Remove color codes |cnCOLOR_NAME: and |cffXXXXXX
    text = text:gsub("|cn[^:]*:", "")
    text = text:gsub("|c%x%x%x%x%x%x%x%x", "")
    -- Remove reset codes. 12.1 mixes |r and |R in the same description.
    text = text:gsub("|[rR]", "")
    -- Remove |n newlines (convert to actual newlines)
    text = text:gsub("|n", "\n")
    -- Trim whitespace
    text = strtrim(text)
    return text
end

-- Section headers, keyed by the lowercase text that appears before the colon.
-- Matching is done on the stripped text, so this works regardless of whether
-- the build wraps the header in |cnGREEN_FONT_COLOR: (12.0) or |cff2dae5a (12.1).
local SECTION_KEYS = {
    ["description"] = "description",
    ["special"]     = "special",
    ["rates"]       = "rates",
}

local function ClassifyHeader(header)
    local lower = header:lower()
    if SECTION_KEYS[lower] then return SECTION_KEYS[lower] end
    if lower:find("areas") or lower:find("find this fish") then return "zones" end
    if lower:find("pool") then return "pools" end
    if lower:find("special") then return "special" end
    if lower:find("rate") then return "rates" end
    if lower:find("description") then return "description" end
    return nil
end

-- Catch Rank ladder, lowest to highest. The journal renders one of these
-- names; rankIndex 5 ("Trophy") is what "Toxic Trophies" (63632) asks for.
local CATCH_RANKS = { "Guppy", "Minnow", "Pike", "Shark", "Trophy" }
ns.CATCH_RANKS = CATCH_RANKS

local CATCH_RANK_INDEX = {}
for i, name in ipairs(CATCH_RANKS) do
    CATCH_RANK_INDEX[name:lower()] = i
end

function ns.GetCatchRankIndex(rankName)
    if not rankName then return nil end
    return CATCH_RANK_INDEX[rankName:lower()]
end

-- Parse a recipe description into structured data.
--
-- The Midnight fishing journal changed shape in 12.1:
--   12.0: sections were headed with |cnGREEN_FONT_COLOR:Header:|r and the
--         flavour text sat above the first header with no header of its own.
--   12.1: headers use literal colours (|cff2dae5aHeader:|R), flavour text got
--         its own "Description:" header, a "Rates:" section was added, and a
--         stat block was prepended:
--             |cff69ccf0Anglin' Score:|r 120 points.
--             |cff69ccf0Catch Rank:|r |cffff8000Trophy|r
--
-- Rather than match either colour escape, we strip escapes first and then read
-- the plain text line by line: a line that is nothing but "Something:" opens a
-- section. That works on both builds and survives the next recolouring.
local function ParseDescription(rawText)
    if not rawText or rawText == "" then return nil end

    local result = {
        flavorText = nil,
        special = nil,     -- { name, effect }
        zones = nil,       -- { "Zone1", "Zone2" }
        pools = nil,       -- { "Pool1", "Pool2" }
        rates = nil,       -- { "line", ... }
        anglinScore = nil, -- number, this character's score for the fish
        catchRank = nil,   -- "Guppy" | "Minnow" | "Pike" | "Shark" | "Trophy"
    }

    local text = StripEscapes(rawText)
    if text == "" then return result end

    local current = nil          -- section key currently being filled
    local buckets = {}           -- key -> { line, ... }
    local preamble = {}          -- lines seen before any header (12.0 flavour)

    for rawLine in text:gmatch("[^\r\n]+") do
        local line = strtrim(rawLine)
        if line ~= "" then
            -- Stat block: "Header: value" on a single line
            local score = line:match("^Anglin'? Score:%s*([%d,]+)")
            local rank = line:match("^Catch Rank:%s*(.+)$")

            if score then
                result.anglinScore = tonumber((score:gsub(",", "")))
            elseif rank then
                result.catchRank = strtrim(rank)
            else
                -- A bare "Something:" line opens a section
                local header = line:match("^(.-):$")
                local key = header and ClassifyHeader(header) or nil
                if key then
                    current = key
                    buckets[key] = buckets[key] or {}
                elseif current then
                    table.insert(buckets[current], line)
                else
                    table.insert(preamble, line)
                end
            end
        end
    end

    -- Flavour text: an explicit Description section (12.1), else the preamble (12.0)
    local descLines = buckets.description
    if descLines and #descLines > 0 then
        result.flavorText = table.concat(descLines, "\n")
    elseif #preamble > 0 then
        result.flavorText = table.concat(preamble, "\n")
    end

    -- Special ability: first line is the name, the rest is the effect
    local specialLines = buckets.special
    if specialLines and #specialLines > 0 then
        result.special = {
            name = specialLines[1],
            effect = table.concat(specialLines, "\n", 2),
        }
    end

    -- Bulleted lists
    local function BulletList(key)
        local lines = buckets[key]
        if not lines then return nil end
        local out = {}
        for _, line in ipairs(lines) do
            local value = line:match("^%-%s*(.+)") or line:match("^\226\128%a%s*(.+)")
            if value then
                value = strtrim(value)
                if value ~= "" then table.insert(out, value) end
            end
        end
        return #out > 0 and out or nil
    end

    result.zones = BulletList("zones")
    result.pools = BulletList("pools")
    result.rates = BulletList("rates")

    return result
end

-------------------------------------------------------------------------------
-- Recipe scanning
-------------------------------------------------------------------------------
local function ScanRecipes()
    if not C_TradeSkillUI.GetFilteredRecipeIDs then return end

    local recipeIDs = C_TradeSkillUI.GetFilteredRecipeIDs()
    if not recipeIDs then return end

    local scanned, matched, skipped = 0, 0, 0

    for _, recipeID in ipairs(recipeIDs) do
        -- Skip already-cached recipes (incremental scan)
        if not recipeCache[recipeID] then
            local ok, err = pcall(function()
                local recipeInfo = C_TradeSkillUI.GetRecipeInfo(recipeID)
                if not recipeInfo then return end

                -- Check if this is a fish category
                local categoryID = recipeInfo.categoryID
                if not categoryID then return end

                local catInfo = C_TradeSkillUI.GetCategoryInfo(categoryID)
                local categoryName = catInfo and catInfo.name or nil

                if not IsFishCategory(categoryID, categoryName) then
                    skipped = skipped + 1
                    return
                end

                -- Get schematic for icon
                local schematic = C_TradeSkillUI.GetRecipeSchematic(recipeID, false)
                local icon = schematic and schematic.icon or nil

                -- Get description for zone/pool/special parsing
                local description = C_TradeSkillUI.GetRecipeDescription(recipeID, {})
                local parsed = ParseDescription(description)

                -- Build cache entry
                local entry = {
                    recipeID = recipeID,
                    name = recipeInfo.name,
                    categoryID = categoryID,
                    categoryName = categoryName,
                    icon = icon,
                    learned = recipeInfo.learned or false,
                    flavorText = parsed and parsed.flavorText or nil,
                    special = parsed and parsed.special or nil,
                    profZones = parsed and parsed.zones or nil,
                    profPools = parsed and parsed.pools or nil,
                    profRates = parsed and parsed.rates or nil,
                    anglinScore = parsed and parsed.anglinScore or nil,
                    catchRank = parsed and parsed.catchRank or nil,
                }

                recipeCache[recipeID] = entry
                scanned = scanned + 1

                -- Name-match to FishData and enrich
                local itemID = nameToItemID[recipeInfo.name]
                if itemID then
                    local fishEntry = ns.FishData[itemID]
                    if fishEntry then
                        fishEntry.recipeID = recipeID
                        fishEntry.icon = icon
                        fishEntry.flavorText = entry.flavorText
                        fishEntry.special = entry.special
                        fishEntry.profZones = entry.profZones
                        fishEntry.profPools = entry.profPools
                        fishEntry.profRates = entry.profRates
                        fishEntry.anglinScore = entry.anglinScore
                        fishEntry.catchRank = entry.catchRank
                        fishEntry.learned = entry.learned
                        fishEntry.categoryName = categoryName

                        -- Resolve zone names to mapIDs
                        if entry.profZones then
                            local mapIDs = {}
                            for _, zoneName in ipairs(entry.profZones) do
                                local mapID = zoneNameToMapID[zoneName]
                                if mapID then
                                    table.insert(mapIDs, mapID)
                                end
                            end
                            if #mapIDs > 0 then
                                fishEntry.profZoneMapIDs = mapIDs
                            end
                        end

                        entry.itemID = itemID
                        itemToRecipe[itemID] = recipeID
                        matched = matched + 1
                    end
                end
            end)

            if not ok then
                -- Silently skip — one bad recipe shouldn't abort the scan
            end
        end
    end

    if scanned > 0 or isLoaded then
        isLoaded = true
    end
end

-------------------------------------------------------------------------------
-- Event wiring
-------------------------------------------------------------------------------
local lookupsBuilt = false
local hooked = false

local function IsFishingProfession()
    local frame = ProfessionsFrame
    if not frame then return false end
    local profInfo = frame.professionInfo
    if profInfo and profInfo.profession == Enum.Profession.Fishing then
        return true
    end
    -- Fallback: check skill line IDs
    if profInfo and profInfo.professionID then
        for _, id in ipairs(ns.FISHING_VARIANT_SKILL_LINES) do
            if profInfo.professionID == id then return true end
        end
        if profInfo.professionID == ns.FISHING_SKILL_LINE then return true end
    end
    return false
end

local function TryScan()
    if not IsFishingProfession() then return end
    if not lookupsBuilt then
        BuildLookups()
        lookupsBuilt = true
    end
    ScanRecipes()
end

local function HookProfessionsFrame()
    if hooked then return end
    local frame = ProfessionsFrame
    if not frame then return end
    hooked = true

    -- UpdateTabs fires when the profession changes or the frame opens
    hooksecurefunc(frame, "UpdateTabs", function()
        C_Timer.After(0, function()
            if not isLoaded then
                TryScan()
            end
        end)
    end)
end

EventUtil.ContinueOnAddOnLoaded("Blizzard_Professions", HookProfessionsFrame)

-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------

function ProfessionData:IsLoaded()
    return isLoaded
end

function ProfessionData:GetAllRecipes()
    return recipeCache
end

function ProfessionData:GetRecipe(recipeID)
    return recipeCache[recipeID]
end

function ProfessionData:GetRecipeByItemID(itemID)
    local recipeID = itemToRecipe[itemID]
    return recipeID and recipeCache[recipeID] or nil
end

function ProfessionData:GetFishZones(itemID)
    local entry = ns.FishData[itemID]
    return entry and entry.profZones or nil
end

function ProfessionData:GetFishPools(itemID)
    local entry = ns.FishData[itemID]
    return entry and entry.profPools or nil
end

function ProfessionData:GetFishSpecial(itemID)
    local entry = ns.FishData[itemID]
    return entry and entry.special or nil
end

--- Catch Rank / Anglin' Score for a fish, as reported by the in-game journal.
--- Returns rankName, rankIndex, score — all nil until the journal has been scanned.
function ProfessionData:GetCatchRank(itemID)
    local entry = ns.FishData[itemID]
    if not entry then return nil end
    return entry.catchRank, ns.GetCatchRankIndex(entry.catchRank), entry.anglinScore
end

--- How many of the given fish have reached a rank (default Trophy, index 5).
--- Returns atRank, total, scanned — scanned is false if the journal has not
--- been opened yet, in which case atRank is meaningless rather than zero.
function ProfessionData:CountAtRank(itemIDs, minRankIndex)
    minRankIndex = minRankIndex or #ns.CATCH_RANKS
    local atRank = 0
    for _, itemID in ipairs(itemIDs) do
        local _, rankIndex = self:GetCatchRank(itemID)
        if rankIndex and rankIndex >= minRankIndex then
            atRank = atRank + 1
        end
    end
    return atRank, #itemIDs, isLoaded
end

function ProfessionData:Rescan()
    recipeCache = {}
    itemToRecipe = {}
    isLoaded = false
    lookupsBuilt = false
    TryScan()
end

-------------------------------------------------------------------------------
-- Debug slash command: /wbj profdata
-------------------------------------------------------------------------------
ns:RegisterCallback("ADDON_LOADED", function()
    local original = SlashCmdList["WBJ"]
    SlashCmdList["WBJ"] = function(msg)
        msg = strtrim(msg):lower()
        if msg == "profdata" then
            if not isLoaded then
                print("|cff88ccffWBJ ProfData:|r Not loaded yet. Open your fishing profession window first.")
                return
            end

            local total, matchCount, unmatched = 0, 0, {}
            for recipeID, entry in pairs(recipeCache) do
                total = total + 1
                if entry.itemID then
                    matchCount = matchCount + 1
                else
                    table.insert(unmatched, entry.name or "?")
                end
            end

            -- Count how many entries actually got their sections parsed. A zero
            -- here means the journal's description format has moved again.
            local withSections, withRank = 0, 0
            for _, entry in pairs(recipeCache) do
                if entry.profZones or entry.profPools then withSections = withSections + 1 end
                if entry.catchRank then withRank = withRank + 1 end
            end

            print("|cff88ccffWBJ ProfData:|r Scan results:")
            print(format("  Recipes: %d | Matched to FishData: %d | Unmatched: %d", total, matchCount, #unmatched))
            print(format("  Parsed zones/pools: %d | Parsed Catch Rank: %d", withSections, withRank))
            if #unmatched > 0 then
                print("  Unmatched names: " .. table.concat(unmatched, ", "))
            end

            -- Sample entry: Shimmer Spinefish (238370)
            local sampleID = 238370
            local sample = ns.FishData[sampleID]
            if sample and sample.recipeID then
                print(format("  Sample — %s (itemID %d):", sample.name, sampleID))
                if sample.catchRank or sample.anglinScore then
                    print(format("    Catch Rank: %s | Anglin' Score: %s",
                        tostring(sample.catchRank), tostring(sample.anglinScore)))
                end
                if sample.profZones then
                    print("    Zones: " .. table.concat(sample.profZones, ", "))
                end
                if sample.profPools then
                    print("    Pools: " .. table.concat(sample.profPools, ", "))
                end
                if sample.special then
                    print("    Special: " .. sample.special.name)
                end
                if sample.flavorText then
                    print("    Flavor: " .. sample.flavorText:sub(1, 80) .. (sample.flavorText:len() > 80 and "..." or ""))
                end
            else
                print("  Sample (Shimmer Spinefish 238370): not enriched")
            end
        else
            original(msg)
        end
    end
end)
