local _, ns = ...

-------------------------------------------------------------------------------
-- DiveTracker — tracks Abyss Anglers dive state, catches, and scoring
-------------------------------------------------------------------------------
local DiveTracker = {}
ns.DiveTracker = DiveTracker

local DIVE_VEHICLE_NPC = 251170
local PEARLS_CURRENCY = 3373
local SCORE_WIDGET = 8014

-- Abyss Anglers achievement IDs (all 38)
local ABYSS_ACHIEVEMENTS = {
    -- Diving (11)
    62218, 62220, 62774, 62221, 62762, 62222, 62219, 62829, 62777, 62272, 62761,
    -- Fish (12)
    62207, 62208, 62271, 62209, 62760, 62117, 62118, 62119, 62772, 62776, 62778, 62832,
    -- Creatures (9)
    62215, 62216, 62775, 62210, 62211, 62212, 62506, 62342, 62343,
    -- Relics (6)
    62759, 62213, 62214, 62763, 62773, 62217,
}

-------------------------------------------------------------------------------
-- State
-------------------------------------------------------------------------------
local isDiving = false
local diveStart = 0
local diveCatches = 0
local diveRelics = 0
local diveScore = 0
local pearlsBefore = 0

-------------------------------------------------------------------------------
-- Helpers
-------------------------------------------------------------------------------
local function GetNPCFromGUID(guid)
    if not guid then return nil end
    local _, _, _, _, _, npcID = strsplit("-", guid)
    return tonumber(npcID)
end

local function GetPearlCount()
    local info = C_CurrencyInfo.GetCurrencyInfo(PEARLS_CURRENCY)
    return info and info.quantity or 0
end

local function ReadScore()
    local info = C_UIWidgetManager.GetTextWithStateWidgetVisualizationInfo(SCORE_WIDGET)
    if info and info.text then
        -- Score text contains WoW color escapes, e.g. "|cnHIGHLIGHT_FONT_COLOR:675|"
        -- Strip all escape sequences and grab the last number
        local clean = info.text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|cn[^:]*:", ""):gsub("|r", ""):gsub("|", "")
        local score = tonumber(clean:match("(%d+)%s*$"))
        if score then return score end
    end
    return 0
end

--- Get progress for all incomplete Abyss Anglers achievements
function DiveTracker:GetAchievementProgress()
    local results = {}
    for _, id in ipairs(ABYSS_ACHIEVEMENTS) do
        local _, name, _, completed, _, _, _, description = GetAchievementInfo(id)
        if name and not completed then
            local numCriteria = GetAchievementNumCriteria(id)
            local criteria = {}
            local hasProgress = false
            for c = 1, numCriteria do
                local cName, _, cCompleted, cQuantity, cReqQuantity = GetAchievementCriteriaInfo(id, c)
                if cName and cName ~= "" then
                    criteria[#criteria + 1] = {
                        name = cName,
                        completed = cCompleted,
                        current = cQuantity,
                        required = cReqQuantity,
                    }
                    if cReqQuantity and cReqQuantity > 1 then
                        hasProgress = true
                    end
                end
            end
            results[#results + 1] = {
                id = id,
                name = name,
                description = description,
                criteria = criteria,
                hasProgress = hasProgress,
            }
        end
    end
    return results
end

-------------------------------------------------------------------------------
-- Dive lifecycle
-------------------------------------------------------------------------------
local scoreTicker = nil

local function StartDive()
    if isDiving then return end
    isDiving = true
    diveStart = GetTime()
    diveCatches = 0
    diveRelics = 0
    diveScore = 0
    pearlsBefore = GetPearlCount()

    if ns.DiveHUD then
        ns.DiveHUD:Show(pearlsBefore)
    end

    -- Poll score and breath every second
    if scoreTicker then scoreTicker:Cancel() end
    scoreTicker = C_Timer.NewTicker(1, function()
        if not isDiving then
            if scoreTicker then scoreTicker:Cancel(); scoreTicker = nil end
            return
        end
        -- Score
        local newScore = ReadScore()
        if newScore ~= diveScore then
            diveScore = newScore
            if ns.DiveHUD then
                ns.DiveHUD:UpdateStats(diveCatches, diveRelics, diveScore)
            end
        end
    end)
end

local function EndDive()
    if not isDiving then return end
    isDiving = false
    if scoreTicker then scoreTicker:Cancel(); scoreTicker = nil end

    diveScore = ReadScore()
    local duration = GetTime() - diveStart

    -- Pearl delta comes via CURRENCY_DISPLAY_UPDATE shortly after exit
    -- We store the pre-dive count; the HUD reads the delta on currency event
    if ns.DiveHUD then
        ns.DiveHUD:OnDiveEnd(diveScore, diveCatches, diveRelics, duration)
    end

    -- Store dive history
    if ns.db then
        if not ns.db.diveHistory then ns.db.diveHistory = {} end
        table.insert(ns.db.diveHistory, {
            timestamp = time(),
            duration = math.floor(duration),
            catches = diveCatches,
            relics = diveRelics,
            score = diveScore,
            pearlsBefore = pearlsBefore,
        })
        -- Keep last 50 dives
        while #ns.db.diveHistory > 50 do
            table.remove(ns.db.diveHistory, 1)
        end
    end
end


-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------
function DiveTracker:IsDiving()
    return isDiving
end

function DiveTracker:GetCurrentStats()
    return {
        catches = diveCatches,
        relics = diveRelics,
        score = diveScore,
        elapsed = isDiving and (GetTime() - diveStart) or 0,
        pearlsBefore = pearlsBefore,
    }
end

-------------------------------------------------------------------------------
-- Event registration
-------------------------------------------------------------------------------
ns:RegisterCallback("ADDON_LOADED", function()
    -- Vehicle enter for dive detection
    -- UNIT_ENTERING_VEHICLE args: unit, showVehicleUI, isControlSeat, vehicleUIIndicatorID, vehicleGUID, ...
    ns:RegisterCallback("UNIT_ENTERING_VEHICLE", function(_, unit, _, _, _, vehicleGUID)
        if unit ~= "player" then return end
        local npcID = GetNPCFromGUID(vehicleGUID)
        if npcID == DIVE_VEHICLE_NPC then
            StartDive()
        end
    end)

    -- Vehicle exit
    ns:RegisterCallback("UNIT_EXITING_VEHICLE", function(_, unit)
        if unit ~= "player" then return end
        if isDiving then
            -- Grab final score before vehicle teardown
            diveScore = ReadScore()
            EndDive()
        end
    end)

    -- Catch detection: CRITERIA_UPDATE fires on fish kills, relic pickups, and bubble catches.
    -- We distinguish by tracking spells that fire on "player" shortly before CRITERIA_UPDATE:
    --   Relic pickup: spell 1257185
    --   Bubble catch: spell 1286830
    --   Fish kill: neither (harpoon kills have no player spell marker)
    local RELIC_PICKUP_SPELL = 1257185
    local BUBBLE_CATCH_SPELL = 1286830
    local lastRelicSpellTime = 0
    local lastBubbleSpellTime = 0
    local lastCriteriaFrame = 0

    ns:RegisterCallback("UNIT_SPELLCAST_SUCCEEDED", function(_, unit, _, spellID)
        if not isDiving then return end
        if unit ~= "player" then return end
        if spellID == RELIC_PICKUP_SPELL then
            lastRelicSpellTime = GetTime()
        elseif spellID == BUBBLE_CATCH_SPELL then
            lastBubbleSpellTime = GetTime()
        end
    end)

    ns:RegisterCallback("CRITERIA_UPDATE", function()
        if not isDiving then return end
        local now = GetTime()
        if now - lastCriteriaFrame < 0.5 then return end
        lastCriteriaFrame = now

        if now - lastRelicSpellTime < 1.0 then
            diveRelics = diveRelics + 1
            lastRelicSpellTime = 0
        else
            -- Both harpoon kills and bubble catches count as fish catches
            diveCatches = diveCatches + 1
        end
        diveScore = ReadScore()
        if ns.DiveHUD then
            ns.DiveHUD:UpdateStats(diveCatches, diveRelics, diveScore)
        end
    end)

    -- Pearl currency updates
    ns:RegisterCallback("CURRENCY_DISPLAY_UPDATE", function(_, currencyID, quantity, quantityChange)
        if currencyID ~= PEARLS_CURRENCY then return end
        if ns.DiveHUD then
            ns.DiveHUD:UpdatePearls(quantity, quantityChange)
        end
    end)
end)
