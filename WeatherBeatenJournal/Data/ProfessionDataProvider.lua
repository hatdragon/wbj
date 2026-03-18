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
    [2705] = true, -- Appendix
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
    -- Remove |r reset codes
    text = text:gsub("|r", "")
    -- Remove |n newlines (convert to actual newlines)
    text = text:gsub("|n", "\n")
    -- Trim whitespace
    text = strtrim(text)
    return text
end

-- Parse a recipe description into structured data
local function ParseDescription(rawText)
    if not rawText or rawText == "" then return nil end

    local result = {
        flavorText = nil,
        special = nil,     -- { name, effect }
        zones = nil,       -- { "Zone1", "Zone2" }
        pools = nil,       -- { "Pool1", "Pool2" }
    }

    -- Split on |cnGREEN_FONT_COLOR: markers
    -- Format: [flavor] |cnGREEN_FONT_COLOR:Header:|r [content] |cnGREEN_FONT_COLOR:Header:|r [content]
    local sections = {}
    local lastEnd = 1

    -- Find all section markers
    local pattern = "|cnGREEN_FONT_COLOR:(.-):|r"
    for header, pos in rawText:gmatch("|cnGREEN_FONT_COLOR:(.-):|r()") do
        -- Everything before this marker belongs to previous section
        local startOfMarker = rawText:find("|cnGREEN_FONT_COLOR:" .. header:gsub("([%(%)%.%%%+%-%*%?%[%^%$])", "%%%1") .. ":|r")
        if startOfMarker then
            local before = rawText:sub(lastEnd, startOfMarker - 1)
            if #sections == 0 then
                -- Text before first marker = flavor text
                local cleaned = StripEscapes(before)
                if cleaned ~= "" then
                    result.flavorText = cleaned
                end
            else
                sections[#sections].content = before
            end
            table.insert(sections, { header = header, startPos = pos, content = "" })
            lastEnd = pos
        end
    end

    -- Last section gets remaining text
    if #sections > 0 then
        sections[#sections].content = rawText:sub(lastEnd)
    elseif lastEnd == 1 then
        -- No markers at all — entire text is flavor
        local cleaned = StripEscapes(rawText)
        if cleaned ~= "" then
            result.flavorText = cleaned
        end
        return result
    end

    -- Process each section
    for _, section in ipairs(sections) do
        local headerLower = section.header:lower()
        local content = section.content

        if headerLower:find("special") then
            -- Special ability: first non-empty line = name, rest = effect
            local lines = {}
            for line in content:gmatch("[^\r\n]+") do
                local cleaned = StripEscapes(line)
                if cleaned ~= "" then
                    table.insert(lines, cleaned)
                end
            end
            if #lines > 0 then
                result.special = {
                    name = lines[1],
                    effect = table.concat(lines, "\n", 2),
                }
            end

        elseif headerLower:find("areas") or headerLower:find("find this fish") then
            -- Zone list: lines starting with "- "
            result.zones = {}
            for line in content:gmatch("[^\r\n]+") do
                local cleaned = StripEscapes(line)
                local zone = cleaned:match("^%-%s*(.+)") or cleaned:match("^•%s*(.+)")
                if zone and zone ~= "" then
                    table.insert(result.zones, strtrim(zone))
                end
            end
            if #result.zones == 0 then result.zones = nil end

        elseif headerLower:find("pool") then
            -- Pool list: lines starting with "- "
            result.pools = {}
            for line in content:gmatch("[^\r\n]+") do
                local cleaned = StripEscapes(line)
                local pool = cleaned:match("^%-%s*(.+)") or cleaned:match("^•%s*(.+)")
                if pool and pool ~= "" then
                    table.insert(result.pools, strtrim(pool))
                end
            end
            if #result.pools == 0 then result.pools = nil end
        end
    end

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

            print("|cff88ccffWBJ ProfData:|r Scan results:")
            print(format("  Recipes: %d | Matched to FishData: %d | Unmatched: %d", total, matchCount, #unmatched))
            if #unmatched > 0 then
                print("  Unmatched names: " .. table.concat(unmatched, ", "))
            end

            -- Sample entry: Shimmer Spinefish (238370)
            local sampleID = 238370
            local sample = ns.FishData[sampleID]
            if sample and sample.recipeID then
                print(format("  Sample — %s (itemID %d):", sample.name, sampleID))
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
