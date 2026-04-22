local _, ns = ...

-------------------------------------------------------------------------------
-- DiveHUD — floating overlay shown during Abyss Anglers dives
-------------------------------------------------------------------------------
local DiveHUD = {}
ns.DiveHUD = DiveHUD

local frame, statsPanel, achievePanel, summaryFrame
local scoreText, catchText, relicText, pearlText, breathTimer
local gearLine1, gearLine2
local achieveRows = {}

local HUD_WIDTH = 260
local ROW_HEIGHT = 18
local PADDING = 8
local MAX_ACHIEVE_ROWS = 8

local PEARL_ICON = "|T348545:0|t"

-------------------------------------------------------------------------------
-- Create the HUD frame
-------------------------------------------------------------------------------
local function CreateHUD()
    frame = CreateFrame("Frame", "WBJ_DiveHUD", UIParent, "BackdropTemplate")
    frame:SetSize(HUD_WIDTH, 10) -- height set dynamically
    frame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -200, -200)
    frame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    frame:SetBackdropColor(0.05, 0.05, 0.08, 0.85)
    frame:SetBackdropBorderColor(0.3, 0.5, 0.7, 0.8)
    frame:SetFrameStrata("HIGH")
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        -- Save position
        if ns.db then
            local point, _, relPoint, x, y = self:GetPoint()
            ns.db.diveHUDPos = { point, relPoint, x, y }
        end
    end)
    frame:Hide()

    -- Title bar
    local title = frame:CreateFontString(nil, "OVERLAY")
    title:SetFont("Fonts\\MORPHEUS.TTF", 14, "")
    title:SetPoint("TOP", 0, -PADDING)
    title:SetText("Abyss Anglers")
    title:SetTextColor(0.4, 0.75, 1)

    -- Close button
    local closeBtn = CreateFrame("Button", nil, frame)
    closeBtn:SetSize(14, 14)
    closeBtn:SetPoint("TOPRIGHT", -4, -4)
    closeBtn:SetNormalAtlas("common-search-clearbutton")
    closeBtn:RegisterForClicks("AnyUp")
    closeBtn:SetScript("OnClick", function() frame:Hide() end)

    ---------------------------------------------------------------------------
    -- Stats section
    ---------------------------------------------------------------------------
    statsPanel = CreateFrame("Frame", nil, frame)
    statsPanel:SetPoint("TOPLEFT", PADDING, -(PADDING + 18))
    statsPanel:SetPoint("RIGHT", -PADDING, 0)
    statsPanel:SetHeight(ROW_HEIGHT * 4 + 4)

    -- Score
    scoreText = statsPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    scoreText:SetPoint("TOPLEFT", 0, 0)
    scoreText:SetPoint("RIGHT")
    scoreText:SetJustifyH("LEFT")
    scoreText:SetText("Score: 0")
    scoreText:SetTextColor(1, 0.82, 0)

    -- Catches
    catchText = statsPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    catchText:SetPoint("TOPLEFT", scoreText, "BOTTOMLEFT", 0, -2)
    catchText:SetJustifyH("LEFT")
    catchText:SetText("Catches: 0")
    catchText:SetTextColor(0.8, 0.9, 1)

    -- Relics
    relicText = statsPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    relicText:SetPoint("TOPLEFT", catchText, "BOTTOMLEFT", 0, -2)
    relicText:SetJustifyH("LEFT")
    relicText:SetText("Relics: 0")
    relicText:SetTextColor(0.8, 0.9, 1)

    -- Pearls + Breath on same row
    pearlText = statsPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    pearlText:SetPoint("TOPLEFT", relicText, "BOTTOMLEFT", 0, -2)
    pearlText:SetJustifyH("LEFT")
    pearlText:SetText(PEARL_ICON .. " Pearls: 0")
    pearlText:SetTextColor(0.7, 0.85, 1)

    breathTimer = statsPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    breathTimer:SetPoint("RIGHT", statsPanel, "RIGHT", 0, 0)
    breathTimer:SetPoint("TOP", pearlText, "TOP", 0, 0)
    breathTimer:SetJustifyH("RIGHT")
    breathTimer:SetTextColor(0.5, 0.8, 1)
    breathTimer:SetText("")

    ---------------------------------------------------------------------------
    -- Power bar spacer (PlayerPowerBarAlt is ~40px visible height at our scale)
    ---------------------------------------------------------------------------
    local powerBarSpacer = CreateFrame("Frame", nil, frame)
    powerBarSpacer:SetHeight(36)
    powerBarSpacer:SetPoint("TOPLEFT", statsPanel, "BOTTOMLEFT", 0, 0)
    powerBarSpacer:SetPoint("RIGHT", frame, "RIGHT", -PADDING, 0)

    ---------------------------------------------------------------------------
    -- Separator 1
    ---------------------------------------------------------------------------
    local sep1 = frame:CreateTexture(nil, "ARTWORK")
    sep1:SetHeight(1)
    sep1:SetPoint("TOPLEFT", powerBarSpacer, "BOTTOMLEFT", 0, -4)
    sep1:SetPoint("RIGHT", frame, "RIGHT", -PADDING, 0)
    sep1:SetColorTexture(0.3, 0.5, 0.7, 0.5)

    ---------------------------------------------------------------------------
    -- Gear summary
    ---------------------------------------------------------------------------
    local gearHeader = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    gearHeader:SetPoint("TOPLEFT", sep1, "BOTTOMLEFT", 0, -4)
    gearHeader:SetText("Gear")
    gearHeader:SetTextColor(0.6, 0.6, 0.6)

    gearLine1 = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    gearLine1:SetPoint("TOPLEFT", gearHeader, "BOTTOMLEFT", 0, -2)
    gearLine1:SetPoint("RIGHT", frame, "RIGHT", -PADDING, 0)
    gearLine1:SetJustifyH("LEFT")
    gearLine1:SetTextColor(0.8, 0.85, 0.9)

    gearLine2 = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    gearLine2:SetPoint("TOPLEFT", gearLine1, "BOTTOMLEFT", 0, -1)
    gearLine2:SetPoint("RIGHT", frame, "RIGHT", -PADDING, 0)
    gearLine2:SetJustifyH("LEFT")
    gearLine2:SetTextColor(0.8, 0.85, 0.9)

    ---------------------------------------------------------------------------
    -- Separator 2
    ---------------------------------------------------------------------------
    local sep2 = frame:CreateTexture(nil, "ARTWORK")
    sep2:SetHeight(1)
    sep2:SetPoint("TOPLEFT", gearLine2, "BOTTOMLEFT", 0, -4)
    sep2:SetPoint("RIGHT", frame, "RIGHT", -PADDING, 0)
    sep2:SetColorTexture(0.3, 0.5, 0.7, 0.5)

    ---------------------------------------------------------------------------
    -- Achievement tracker section
    ---------------------------------------------------------------------------
    local achieveHeader = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    achieveHeader:SetPoint("TOPLEFT", sep2, "BOTTOMLEFT", 0, -4)
    achieveHeader:SetText("Achievement Progress")
    achieveHeader:SetTextColor(0.6, 0.6, 0.6)

    achievePanel = CreateFrame("Frame", nil, frame)
    achievePanel:SetPoint("TOPLEFT", achieveHeader, "BOTTOMLEFT", 0, -2)
    achievePanel:SetPoint("RIGHT", frame, "RIGHT", -PADDING, 0)
    achievePanel:SetHeight(1) -- sized dynamically

    -- Pre-create achievement rows
    for i = 1, MAX_ACHIEVE_ROWS do
        local row = CreateFrame("Frame", nil, achievePanel)
        row:SetHeight(ROW_HEIGHT)
        if i == 1 then
            row:SetPoint("TOPLEFT", 0, 0)
        else
            row:SetPoint("TOPLEFT", achieveRows[i - 1], "BOTTOMLEFT", 0, 0)
        end
        row:SetPoint("RIGHT")

        local name = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        name:SetPoint("LEFT", 0, 0)
        name:SetPoint("RIGHT", -50, 0)
        name:SetJustifyH("LEFT")
        name:SetWordWrap(false)
        name:SetTextColor(0.85, 0.85, 0.85)
        row.name = name

        local progress = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        progress:SetPoint("RIGHT", 0, 0)
        progress:SetWidth(48)
        progress:SetJustifyH("RIGHT")
        progress:SetTextColor(0.6, 0.8, 1)
        row.progress = progress

        row:Hide()
        achieveRows[i] = row
    end

    ---------------------------------------------------------------------------
    -- Summary popup (shown briefly after dive ends)
    ---------------------------------------------------------------------------
    summaryFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    summaryFrame:SetSize(280, 120)
    summaryFrame:SetPoint("CENTER", 0, 100)
    summaryFrame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 14,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    })
    summaryFrame:SetBackdropColor(0.05, 0.05, 0.08, 0.92)
    summaryFrame:SetBackdropBorderColor(0.3, 0.5, 0.7, 0.9)
    summaryFrame:SetFrameStrata("DIALOG")
    summaryFrame:Hide()

    local sumTitle = summaryFrame:CreateFontString(nil, "OVERLAY")
    sumTitle:SetFont("Fonts\\MORPHEUS.TTF", 16, "")
    sumTitle:SetPoint("TOP", 0, -10)
    sumTitle:SetText("Dive Complete")
    sumTitle:SetTextColor(0.4, 0.75, 1)

    summaryFrame.scoreText = summaryFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    summaryFrame.scoreText:SetPoint("TOPLEFT", 14, -34)
    summaryFrame.scoreText:SetTextColor(1, 0.82, 0)

    summaryFrame.detailText = summaryFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    summaryFrame.detailText:SetPoint("TOPLEFT", summaryFrame.scoreText, "BOTTOMLEFT", 0, -4)
    summaryFrame.detailText:SetPoint("RIGHT", -14, 0)
    summaryFrame.detailText:SetJustifyH("LEFT")
    summaryFrame.detailText:SetTextColor(0.8, 0.85, 0.9)
    summaryFrame.detailText:SetWordWrap(true)

    summaryFrame.pearlText = summaryFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    summaryFrame.pearlText:SetPoint("BOTTOMLEFT", 14, 12)
    summaryFrame.pearlText:SetTextColor(0.7, 0.85, 1)
end

-------------------------------------------------------------------------------
-- Resize the HUD to fit content
-------------------------------------------------------------------------------
local function ResizeHUD()
    if not frame then return end
    -- Count visible achieve rows
    local visibleRows = 0
    for _, row in ipairs(achieveRows) do
        if row:IsShown() then visibleRows = visibleRows + 1 end
    end
    achievePanel:SetHeight(math.max(1, visibleRows * ROW_HEIGHT))

    local totalHeight = PADDING        -- top padding
        + 18                           -- title
        + (ROW_HEIGHT * 4 + 4)         -- stats
        + 36                           -- power bar spacer
        + 4 + 1                        -- separator 1
        + 14                           -- gear header
        + 2 + ROW_HEIGHT               -- gear line 1
        + 1 + ROW_HEIGHT               -- gear line 2
        + 4 + 1                        -- separator 2
        + 14                           -- achieve header
        + 2                            -- gap
        + (visibleRows * ROW_HEIGHT)   -- achieve rows
        + PADDING                      -- bottom padding
    frame:SetHeight(totalHeight)
end

-------------------------------------------------------------------------------
-- Refresh gear summary
-------------------------------------------------------------------------------
local function RefreshGear()
    local GEAR_TRACKS = {
        { label = "Suit",    ids = { 62207, 62208, 62209 } },
        { label = "O2",      ids = { 62210, 62211, 62212 } },
        { label = "Harpoon", ids = { 62215, 62216 } },
        { label = "Net",     ids = { 62213, 62214 } },
        { label = "Bait",    ids = { 62117, 62118, 62119 } },
        { label = "Special", ids = { 62506 } },
    }
    local parts1, parts2 = {}, {}
    for i, track in ipairs(GEAR_TRACKS) do
        local done = 0
        for _, id in ipairs(track.ids) do
            if ns.IsAchievementCompleted(id) then done = done + 1 end
        end
        local text = done == #track.ids
            and format("%s: |cff00cc00MAX|r", track.label)
            or format("%s: %d/%d", track.label, done, #track.ids)
        if i <= 3 then
            parts1[#parts1 + 1] = text
        else
            parts2[#parts2 + 1] = text
        end
    end
    gearLine1:SetText(table.concat(parts1, "  |  "))
    gearLine2:SetText(table.concat(parts2, "  |  "))
end

-------------------------------------------------------------------------------
-- Refresh achievement progress rows
-------------------------------------------------------------------------------
local function RefreshAchievements()
    if not ns.DiveTracker then return end
    local achievements = ns.DiveTracker:GetAchievementProgress()

    -- Sort: achievements with numeric progress first, then alphabetical
    table.sort(achievements, function(a, b)
        if a.hasProgress ~= b.hasProgress then
            return a.hasProgress
        end
        return a.name < b.name
    end)

    local shown = 0
    for i, ach in ipairs(achievements) do
        if shown >= MAX_ACHIEVE_ROWS then break end
        shown = shown + 1
        local row = achieveRows[shown]

        -- Strip "Abyss Anglers: " prefix for compact display
        local displayName = ach.name:gsub("^Abyss Anglers:%s*", "")
        row.name:SetText(displayName)

        -- Show progress for first criterion with a quantity requirement
        local progressStr = ""
        for _, crit in ipairs(ach.criteria) do
            if crit.required and crit.required > 1 then
                progressStr = format("%d/%d", crit.current, crit.required)
                if crit.current > 0 then
                    row.progress:SetTextColor(0.4, 0.85, 1)
                else
                    row.progress:SetTextColor(0.5, 0.5, 0.5)
                end
                break
            elseif crit.required == 1 then
                progressStr = crit.completed and "|cff00cc00Done|r" or ""
            end
        end
        if progressStr == "" and #ach.criteria == 0 then
            -- Single-criterion achievement with no sub-criteria (just do the thing)
            progressStr = ""
        end
        row.progress:SetText(progressStr)
        row:Show()
    end

    -- Hide unused rows
    for i = shown + 1, MAX_ACHIEVE_ROWS do
        achieveRows[i]:Hide()
    end

    ResizeHUD()
end

-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------
function DiveHUD:Show(pearlsBefore)
    if not frame then CreateHUD() end

    -- Restore saved position
    if ns.db and ns.db.diveHUDPos then
        local pos = ns.db.diveHUDPos
        frame:ClearAllPoints()
        frame:SetPoint(pos[1], UIParent, pos[2], pos[3], pos[4])
    end

    scoreText:SetText("Score: 0")
    catchText:SetText("Catches: 0")
    relicText:SetText("Relics: 0")
    pearlText:SetText(format("%s Pearls: %s", PEARL_ICON, ns.Util.FormatCount(pearlsBefore)))
    breathTimer:SetText("")

    RefreshGear()
    RefreshAchievements()
    frame:Show()

    -- Anchor Blizzard's power bar (oxygen/score) into our HUD
    -- Delay slightly to ensure the bar exists after vehicle entry
    C_Timer.After(0.5, function()
        if PlayerPowerBarAlt and PlayerPowerBarAlt:IsShown() then
            PlayerPowerBarAlt:SetParent(frame)
            PlayerPowerBarAlt:ClearAllPoints()
            PlayerPowerBarAlt:SetPoint("TOP", frame, "TOP", 0, -(PADDING + 18 + ROW_HEIGHT * 3 - 6))
            PlayerPowerBarAlt:SetScale(HUD_WIDTH / PlayerPowerBarAlt:GetWidth())
        end
    end)
end

function DiveHUD:UpdateStats(catches, relics, score)
    if not frame or not frame:IsShown() then return end
    scoreText:SetText(format("Score: %s", ns.Util.FormatCount(score)))
    catchText:SetText(format("Catches: %d", catches))
    relicText:SetText(format("Relics: %d", relics))
end

function DiveHUD:UpdatePearls(quantity, change)
    if not frame then return end
    if change and change > 0 then
        pearlText:SetText(format("%s Pearls: %s |cff00cc00(+%d)|r", PEARL_ICON, ns.Util.FormatCount(quantity), change))
    else
        pearlText:SetText(format("%s Pearls: %s", PEARL_ICON, ns.Util.FormatCount(quantity)))
    end
end

function DiveHUD:UpdateBreath(remaining, duration)
    if not frame or not breathTimer then return end
    if remaining and remaining > 0 then
        local mins = math.floor(remaining / 60)
        local secs = math.floor(remaining % 60)
        local pct = duration > 0 and (remaining / duration) or 1
        if pct < 0.25 then
            breathTimer:SetTextColor(1, 0.3, 0.3)
        elseif pct < 0.5 then
            breathTimer:SetTextColor(1, 0.7, 0.3)
        else
            breathTimer:SetTextColor(0.5, 0.8, 1)
        end
        breathTimer:SetText(format("O2 %d:%02d", mins, secs))
    else
        breathTimer:SetText("")
    end
end

function DiveHUD:OnDiveEnd(score, catches, relics, duration)
    -- Restore power bar to its original parent
    if PlayerPowerBarAlt then
        PlayerPowerBarAlt:SetParent(EncounterBar or UIParent)
        PlayerPowerBarAlt:ClearAllPoints()
        PlayerPowerBarAlt:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 150)
        PlayerPowerBarAlt:SetScale(1)
    end

    -- Hide the live HUD
    if frame then frame:Hide() end

    -- Show summary popup
    if not summaryFrame then return end
    summaryFrame.scoreText:SetText(format("Angler Score: %s", ns.Util.FormatCount(score)))

    local mins = math.floor(duration / 60)
    local secs = math.floor(duration % 60)
    summaryFrame.detailText:SetText(format(
        "Catches: %d    Relics: %d\nDuration: %d:%02d",
        catches, relics, mins, secs
    ))
    -- Pearl text updates via CURRENCY_DISPLAY_UPDATE callback
    summaryFrame.pearlText:SetText(format("%s Awaiting pearl tally...", PEARL_ICON))
    summaryFrame:Show()

    -- Auto-hide after 8 seconds
    C_Timer.After(8, function()
        if summaryFrame:IsShown() then
            summaryFrame:Hide()
        end
    end)
end

-- Hook pearl updates into summary popup too
local origUpdatePearls = DiveHUD.UpdatePearls
function DiveHUD:UpdatePearls(quantity, change)
    origUpdatePearls(self, quantity, change)
    if summaryFrame and summaryFrame:IsShown() and change and change > 0 then
        summaryFrame.pearlText:SetText(format("%s Pearls earned: |cff00cc00+%d|r  (Total: %s)",
            PEARL_ICON, change, ns.Util.FormatCount(quantity)))
    end
end

function DiveHUD:Hide()
    if frame then frame:Hide() end
end
