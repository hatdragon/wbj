local _, ns = ...

-------------------------------------------------------------------------------
-- NarratorPanel — NPC portrait + context-sensitive quote at bottom of journal
-------------------------------------------------------------------------------
local NarratorPanel = {}
ns.NarratorPanel = NarratorPanel

local panel = nil
local currentNarratorID = nil

function NarratorPanel:Create(parent)
    panel = CreateFrame("Frame", nil, parent)
    panel:SetAllPoints()

    -- Separator line at top
    local sep = panel:CreateTexture(nil, "ARTWORK")
    sep:SetHeight(2)
    sep:SetPoint("TOPLEFT", 0, 0)
    sep:SetPoint("TOPRIGHT", 0, 0)
    sep:SetColorTexture(0.50, 0.45, 0.30, 0.6)

    -- Portrait (simple texture — reliable across all clients)
    local portraitBg = CreateFrame("Frame", nil, panel)
    portraitBg:SetSize(52, 52)
    portraitBg:SetPoint("LEFT", 6, 0)

    local portrait = portraitBg:CreateTexture(nil, "ARTWORK")
    portrait:SetAllPoints()
    portrait:SetTexCoord(0, 1, 0, 1)
    portrait:SetTexture("Interface\\Icons\\Trade_Fishing")
    panel.portrait = portrait

    local ring = portraitBg:CreateTexture(nil, "OVERLAY")
    ring:SetSize(72, 72)
    ring:SetPoint("CENTER")
    ring:SetAtlas("auctionhouse-itemicon-border-gray")
    panel.ring = ring

    -- NPC name — prominent, larger font
    local nameText = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    nameText:SetPoint("TOPLEFT", portraitBg, "TOPRIGHT", 10, -2)
    nameText:SetJustifyH("LEFT")
    nameText:SetTextColor(0.95, 0.85, 0.55)  -- warm gold, readable on parchment
    panel.nameText = nameText

    -- NPC title — smaller, below name
    local titleText = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    titleText:SetPoint("TOPLEFT", nameText, "BOTTOMLEFT", 0, -1)
    titleText:SetJustifyH("LEFT")
    titleText:SetTextColor(0.75, 0.65, 0.45)
    panel.titleText = titleText

    -- Quote text — italic feel, brighter for readability on parchment
    local quoteText = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    quoteText:SetPoint("TOPLEFT", titleText, "BOTTOMLEFT", 0, -3)
    quoteText:SetPoint("RIGHT", panel, "RIGHT", -12, 0)
    quoteText:SetJustifyH("LEFT")
    quoteText:SetWordWrap(true)
    quoteText:SetTextColor(0.85, 0.80, 0.65, 1)  -- warm cream, readable on dark bg
    panel.quoteText = quoteText

    self.frame = panel
    return panel
end

-- Expansion-themed portrait icons (fishing poles/tools, NOT fish items)
local EXPANSION_ICONS = {
    Classic       = "Interface\\Icons\\Trade_Fishing",
    TBC           = "Interface\\Icons\\INV_Fishingpole_02",
    WotLK         = "Interface\\Icons\\INV_Fishingpole_03",
    Cataclysm     = "Interface\\Icons\\INV_Fishingpole_03",
    MoP           = "Interface\\Icons\\INV_Fishingpole_02",
    WoD           = "Interface\\Icons\\INV_Fishing_Lure_Worm",
    Legion        = "Interface\\Icons\\INV_Fishingpole_04",
    BFA           = "Interface\\Icons\\Trade_Fishing",
    Shadowlands   = "Interface\\Icons\\INV_Fishingpole_03",
    Dragonflight  = "Interface\\Icons\\Trade_Fishing",
    TWW           = "Interface\\Icons\\Trade_Fishing",
}

function NarratorPanel:SetNarrator(narratorID, context)
    if not panel then return end
    if not ns.db or not ns.db.settings.showNarrator then
        panel:Hide()
        return
    end

    local narrator = ns.Narrators[narratorID]
    if not narrator then
        panel:Hide()
        return
    end

    panel:Show()

    -- Set NPC portrait from creature display ID
    if narrator.displayID then
        panel.portrait:SetTexCoord(0, 1, 0, 1)
        SetPortraitTextureFromCreatureDisplayID(panel.portrait, narrator.displayID)
    else
        local icon = EXPANSION_ICONS[narrator.expansion] or "Interface\\Icons\\Trade_Fishing"
        panel.portrait:SetTexture(icon)
        panel.portrait:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    end

    -- Set name and title
    panel.nameText:SetText(narrator.name or "")
    panel.titleText:SetText(narrator.title or "")

    -- Pick a quote
    local quote = ns.GetNarratorQuote(narratorID, context)
    if quote then
        panel.quoteText:SetText("\226\128\156" .. quote .. "\226\128\157")
    else
        panel.quoteText:SetText("")
    end

    currentNarratorID = narratorID
end

function NarratorPanel:SetForSection(sectionID)
    local narratorID = ns.SECTION_NARRATORS[sectionID] or ns.NARRATOR.NAT_PAGLE
    local context = sectionID == ns.SECTION_CATCH_LOG and "catchLog"
                 or sectionID == ns.SECTION_SPOT_GUIDE and "spotGuide"
                 or sectionID == ns.SECTION_COLLECTIONS and "collections"
                 or "default"
    self:SetNarrator(narratorID, context)
end

function NarratorPanel:SetForZone(mapID)
    local narratorID = ns.GetZoneNarrator(mapID)
    self:SetNarrator(narratorID, "spotGuide")
end
