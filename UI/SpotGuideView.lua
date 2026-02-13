local _, ns = ...

-------------------------------------------------------------------------------
-- SpotGuideView — zone tree (left) + fish list (right)
-- Narrator changes per zone selection.
-------------------------------------------------------------------------------
local SpotGuideView = {}
ns.SpotGuideView = SpotGuideView

local view = nil
local selectedMapID = nil
local zoneButtons = {}
local isPopulated = false
local filterText = nil

local function MatchesFilter(text, filter)
    if not filter or filter == "" then return true end
    if not text then return false end
    return text:lower():find(filter:lower(), 1, true) ~= nil
end

-------------------------------------------------------------------------------
-- Create
-------------------------------------------------------------------------------
function SpotGuideView:Create(parent)
    view = CreateFrame("Frame", nil, parent)
    view:SetAllPoints()

    -- Left panel: zone tree
    local leftPanel = CreateFrame("Frame", nil, view)
    leftPanel:SetWidth(220)
    leftPanel:SetPoint("TOPLEFT", 0, 0)
    leftPanel:SetPoint("BOTTOMLEFT", 0, 0)

    local leftBg = leftPanel:CreateTexture(nil, "BACKGROUND")
    leftBg:SetAllPoints()
    leftBg:SetColorTexture(0.0, 0.0, 0.0, 0.25)
    view.leftPanel = leftPanel

    -- Zone scroll area
    local zoneScroll = CreateFrame("Frame", nil, leftPanel, "WowScrollBoxList")
    zoneScroll:SetPoint("TOPLEFT", 2, -2)
    zoneScroll:SetPoint("BOTTOMRIGHT", -2, 2)

    local zoneScrollBar = CreateFrame("EventFrame", nil, leftPanel, "MinimalScrollBar")
    zoneScrollBar:SetPoint("TOPLEFT", zoneScroll, "TOPRIGHT", 2, 0)
    zoneScrollBar:SetPoint("BOTTOMLEFT", zoneScroll, "BOTTOMRIGHT", 2, 0)

    local zoneView = CreateScrollBoxListLinearView()
    zoneView:SetElementExtent(22)
    zoneView:SetElementInitializer("Frame", function(row, data)
        if not row.isInitialized then
            row.btn = CreateFrame("Button", nil, row)
            row.btn:SetAllPoints()
            row.btn:RegisterForClicks("AnyUp")

            row.hl = row.btn:CreateTexture(nil, "HIGHLIGHT")
            row.hl:SetAllPoints()
            row.hl:SetColorTexture(ns.COLORS.HIGHLIGHT:GetRGBA())

            row.label = row.btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            row.label:SetPoint("LEFT", 4, 0)
            row.label:SetPoint("RIGHT", -4, 0)
            row.label:SetJustifyH("LEFT")
            row.label:SetWordWrap(false)

            row.selected = row.btn:CreateTexture(nil, "BACKGROUND")
            row.selected:SetAllPoints()
            row.selected:SetColorTexture(0.4, 0.35, 0.2, 0.35)
            row.selected:Hide()

            row.caughtDot = row.btn:CreateTexture(nil, "ARTWORK")
            row.caughtDot:SetSize(8, 8)
            row.caughtDot:SetPoint("RIGHT", -6, 0)
            row.caughtDot:SetColorTexture(0.2, 0.8, 0.2, 0.8)
            row.caughtDot:Hide()

            row.isInitialized = true
        end

        if data.isHeader then
            -- Continent header — bold readable font, not decorative MORPHEUS
            row.label:SetText(data.name)
            row.label:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
            row.label:SetTextColor(0.85, 0.70, 0.40, 1)  -- warm gold, visible on dark bg
            row.btn:SetScript("OnClick", nil)
            row.selected:Hide()
            row.caughtDot:Hide()
        else
            -- Zone entry
            row.label:SetText("  " .. data.name)
            row.label:SetFont("Fonts\\FRIZQT__.TTF", 11, "")

            local isSelected = selectedMapID == data.mapID
            if isSelected then
                row.label:SetTextColor(1, 0.82, 0, 1)  -- bright gold
                row.selected:Show()
            else
                row.label:SetTextColor(0.80, 0.75, 0.60, 1)  -- light tan on dark bg
                row.selected:Hide()
            end

            -- Check if player has caught anything here
            local hasCatches = false
            if ns.db and ns.db.totals then
                for _, entry in pairs(ns.db.totals) do
                    if entry.zones and entry.zones[data.mapID] then
                        hasCatches = true
                        break
                    end
                end
            end
            if hasCatches then
                row.caughtDot:Show()
            else
                row.caughtDot:Hide()
            end

            row.btn:SetScript("OnClick", function()
                self:SelectZone(data.mapID)
            end)
        end
    end)

    ScrollUtil.InitScrollBoxListWithScrollBar(zoneScroll, zoneScrollBar, zoneView)
    local zoneDP = CreateDataProvider()
    zoneScroll:SetDataProvider(zoneDP)

    view.zoneScroll = zoneScroll
    view.zoneDP = zoneDP

    -- Right panel: fish details for selected zone
    local rightPanel = CreateFrame("Frame", nil, view)
    rightPanel:SetPoint("TOPLEFT", leftPanel, "TOPRIGHT", 4, 0)
    rightPanel:SetPoint("BOTTOMRIGHT", 0, 0)
    view.rightPanel = rightPanel

    -- Zone title
    local zoneTitle = rightPanel:CreateFontString(nil, "OVERLAY")
    zoneTitle:SetFont(ns.HEADER_FONT, 16, "")
    zoneTitle:SetTextColor(ns.COLORS.HEADER_TEXT:GetRGBA())
    zoneTitle:SetPoint("TOPLEFT", 8, -4)
    view.zoneTitle = zoneTitle

    -- Zone notes
    local zoneNotes = rightPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    zoneNotes:SetPoint("TOPLEFT", zoneTitle, "BOTTOMLEFT", 0, -4)
    zoneNotes:SetPoint("RIGHT", -8, 0)
    zoneNotes:SetJustifyH("LEFT")
    zoneNotes:SetWordWrap(true)
    zoneNotes:SetTextColor(0.75, 0.70, 0.55)
    view.zoneNotes = zoneNotes

    -- Fish list header
    local fishHeader = ns.Widgets:CreateSectionHeader(rightPanel, "Available Fish")
    fishHeader:SetPoint("TOPLEFT", zoneNotes, "BOTTOMLEFT", -8, -8)
    fishHeader:SetPoint("RIGHT", -4, 0)
    view.fishHeader = fishHeader

    -- Fish scroll list
    local fishList = ns.Widgets:CreateScrollList(rightPanel, 28, function(row, data)
        if not row.isInitialized then
            local fishRow = ns.Widgets:CreateFishRow(row)
            fishRow:SetAllPoints()
            row.fishRow = fishRow
            row.isInitialized = true
        end

        local fr = row.fishRow
        local static = ns.FishData[data.itemID]
        local name = static and static.name or ("Item #" .. data.itemID)
        local quality = static and static.quality or Enum.ItemQuality.Common

        -- Try to get icon from cache/API
        local _, _, _, _, _, _, _, _, _, icon = GetItemInfo(data.itemID)
        fr.icon:SetTexture(icon or "Interface\\Icons\\INV_Misc_Fish_02")
        fr.name:SetText(name)

        local color = ns.Util.GetItemQualityColor(quality)
        fr.name:SetTextColor(color:GetRGBA())

        -- Show caught count if any
        local caughtTotal = 0
        local caughtHere = 0
        if ns.db and ns.db.totals and ns.db.totals[data.itemID] then
            local entry = ns.db.totals[data.itemID]
            caughtTotal = entry.count
            if entry.zones and selectedMapID then
                caughtHere = entry.zones[selectedMapID] or 0
            end
        end

        if caughtTotal > 0 then
            fr.count:SetText(ns.Util.FormatCount(caughtHere))
            fr.count:SetTextColor(ns.COLORS.CAUGHT:GetRGBA())
            fr.zone:SetText("(" .. ns.Util.FormatCount(caughtTotal) .. " total)")
        else
            fr.count:SetText("\226\128\148")
            fr.count:SetTextColor(ns.COLORS.UNCAUGHT:GetRGBA())
            fr.zone:SetText("Not yet caught")
            fr.zone:SetTextColor(ns.COLORS.UNCAUGHT:GetRGBA())
        end

        -- Tooltip
        fr:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetItemByID(data.itemID)
            if caughtTotal > 0 then
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine(format("Caught here: %d | Total: %d", caughtHere, caughtTotal), 0.2, 0.8, 0.2)
            end
            GameTooltip:Show()
        end)
        fr:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
    end)
    fishList:SetPoint("TOPLEFT", fishHeader, "BOTTOMLEFT", 0, -2)
    fishList:SetPoint("BOTTOMRIGHT", 0, 0)
    view.fishList = fishList

    -- Empty state for right panel
    local emptyRight = rightPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    emptyRight:SetPoint("CENTER")
    emptyRight:SetText("Select a zone to see available fish.")
    emptyRight:SetTextColor(ns.COLORS.UNCAUGHT:GetRGBA())
    view.emptyRight = emptyRight

    self.frame = view
    return view
end

function SpotGuideView:PopulateZoneTree(preserveScroll)
    if not view then return end

    -- Save scroll position before rebuilding
    local scrollPct = preserveScroll and view.zoneScroll:GetScrollPercentage() or 0

    local continents, order = ns.GetZonesByContinent()
    local dp = view.zoneDP
    dp:Flush()

    local firstMatchMapID = nil
    for _, contName in ipairs(order) do
        local cont = continents[contName]
        -- When filtering, only show continents that have matching zones
        if filterText and filterText ~= "" then
            local matchingZones = {}
            for _, zone in ipairs(cont.zones) do
                if MatchesFilter(zone.name, filterText) then
                    table.insert(matchingZones, zone)
                    if not firstMatchMapID then
                        firstMatchMapID = zone.mapID
                    end
                end
            end
            if #matchingZones > 0 then
                dp:Insert({ isHeader = true, name = cont.name })
                for _, zone in ipairs(matchingZones) do
                    dp:Insert({ isHeader = false, name = zone.name, mapID = zone.mapID })
                end
            end
        else
            dp:Insert({ isHeader = true, name = cont.name })
            for _, zone in ipairs(cont.zones) do
                dp:Insert({ isHeader = false, name = zone.name, mapID = zone.mapID })
            end
        end
    end

    -- Auto-select first matching zone when filtering
    if filterText and filterText ~= "" and firstMatchMapID then
        if selectedMapID ~= firstMatchMapID then
            selectedMapID = firstMatchMapID
            self:RefreshRightPanel()
        end
    end

    -- Restore scroll position
    if preserveScroll then
        C_Timer.After(0, function()
            if view and view.zoneScroll then
                view.zoneScroll:SetScrollPercentage(scrollPct)
            end
        end)
    end
end

function SpotGuideView:SelectZone(mapID)
    selectedMapID = mapID
    self:RefreshRightPanel()
    self:PopulateZoneTree(true) -- refresh selection highlight, keep scroll

    -- Update narrator
    if ns.NarratorPanel then
        ns.NarratorPanel:SetForZone(mapID)
    end
end

function SpotGuideView:RefreshRightPanel()
    if not view then return end

    if not selectedMapID then
        view.zoneTitle:SetText("")
        view.zoneNotes:SetText("")
        view.fishHeader:Hide()
        view.fishList:Hide()
        view.emptyRight:Show()
        return
    end

    view.emptyRight:Hide()
    view.fishHeader:Show()
    view.fishList:Show()

    local zone = ns.ZoneData[selectedMapID]
    if zone then
        view.zoneTitle:SetText(zone.name)
        view.zoneNotes:SetText(zone.notes or "")
    else
        view.zoneTitle:SetText(ns.Util.GetMapName(selectedMapID))
        view.zoneNotes:SetText("")
    end

    -- Populate fish list (with optional filter)
    local fishIDs = ns.GetZoneFish(selectedMapID)
    local dp = view.fishList.dataProvider
    dp:Flush()
    local visibleCount = 0
    for _, itemID in ipairs(fishIDs) do
        local static = ns.FishData[itemID]
        local fishName = static and static.name or nil
        if MatchesFilter(fishName, filterText) then
            dp:Insert({ itemID = itemID })
            visibleCount = visibleCount + 1
        end
    end

    if visibleCount == 0 then
        if filterText and filterText ~= "" then
            view.emptyRight:SetText("No fish matching your search.")
        else
            view.emptyRight:SetText("No fish data for this zone yet.")
        end
        view.emptyRight:Show()
        view.fishList:Hide()
    end
end

function SpotGuideView:Refresh()
    self:PopulateZoneTree()

    -- Auto-select the player's current zone if nothing is selected
    if not selectedMapID then
        local playerMapID = ns.Util.GetPlayerMapID()
        if playerMapID and ns.ZoneData[playerMapID] then
            selectedMapID = playerMapID
        else
            -- Fallback: select first zone in tree
            for mapID, _ in pairs(ns.ZoneData) do
                selectedMapID = mapID
                break
            end
        end
        -- Re-populate tree with selection state
        if selectedMapID then
            self:PopulateZoneTree()
        end
    end

    self:RefreshRightPanel()
    isPopulated = true
end

function SpotGuideView:SetFilter(text)
    filterText = (text and text ~= "") and text or nil
    if isPopulated then
        self:PopulateZoneTree()
        self:RefreshRightPanel()
    end
end

function SpotGuideView:Show()
    if self.frame then
        self.frame:Show()
        if not isPopulated then
            self:Refresh()
        end
    end
end

function SpotGuideView:Hide()
    if self.frame then self.frame:Hide() end
end
