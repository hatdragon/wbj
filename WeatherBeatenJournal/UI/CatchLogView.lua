local _, ns = ...

-------------------------------------------------------------------------------
-- CatchLogView — scrollable catch list with sorting and summary stats
-------------------------------------------------------------------------------
local CatchLogView = {}
ns.CatchLogView = CatchLogView

local view = nil
local sortedList = {}
local itemCache = {} -- itemID -> { name, quality, icon }
local isPopulated = false
local filterText = nil
local fishOnly = false

local function MatchesFilter(text, filter)
    if not filter or filter == "" then return true end
    if not text then return false end
    return text:lower():find(filter:lower(), 1, true) ~= nil
end

-------------------------------------------------------------------------------
-- Item info cache (async-friendly)
-------------------------------------------------------------------------------
local function CacheItemInfo(itemID)
    if itemCache[itemID] then return itemCache[itemID] end

    local name, _, quality, _, _, _, _, _, _, icon = GetItemInfo(itemID)
    if name then
        itemCache[itemID] = {
            name = name,
            quality = quality,
            icon = icon,
        }
    else
        -- Queue async load — Item:CreateFromItemID handles the server query
        local item = Item:CreateFromItemID(itemID)
        item:ContinueOnItemLoad(function()
            local n, _, q, _, _, _, _, _, _, tex = GetItemInfo(itemID)
            if n then
                itemCache[itemID] = { name = n, quality = q, icon = tex }
            end
        end)

        -- Use static data as immediate fallback
        local static = ns.FishData[itemID]
        itemCache[itemID] = {
            name = static and static.name or ("Item #" .. itemID),
            quality = static and static.quality or Enum.ItemQuality.Common,
            icon = "Interface\\Icons\\INV_Misc_Fish_02",
        }
    end

    return itemCache[itemID]
end

-------------------------------------------------------------------------------
-- Sort the totals into a flat list
-------------------------------------------------------------------------------
local function BuildSortedList()
    wipe(sortedList)

    local db = ns.db
    if not db then return end

    for itemID, entry in pairs(db.totals) do
        local info = CacheItemInfo(itemID)
        table.insert(sortedList, {
            itemID = itemID,
            name = info.name,
            quality = info.quality or Enum.ItemQuality.Common,
            icon = info.icon,
            count = entry.count,
            firstCaught = entry.firstCaught,
            lastCaught = entry.lastCaught,
            zones = entry.zones,
        })
    end

    local sortMode = db.catchLogSort or ns.SORT_RECENT

    if sortMode == ns.SORT_RECENT then
        table.sort(sortedList, function(a, b) return (a.lastCaught or 0) > (b.lastCaught or 0) end)
    elseif sortMode == ns.SORT_COUNT then
        table.sort(sortedList, function(a, b) return a.count > b.count end)
    elseif sortMode == ns.SORT_NAME then
        table.sort(sortedList, function(a, b) return (a.name or "") < (b.name or "") end)
    elseif sortMode == ns.SORT_RARITY then
        table.sort(sortedList, function(a, b)
            local qa = ns.QUALITY_ORDER[a.quality] or 1
            local qb = ns.QUALITY_ORDER[b.quality] or 1
            if qa ~= qb then return qa > qb end
            return a.count > b.count
        end)
    end
end

-------------------------------------------------------------------------------
-- Primary zone for display
-------------------------------------------------------------------------------
local function GetPrimaryZone(zones)
    if not zones then return "" end
    local bestMap, bestCount = nil, 0
    for mapID, count in pairs(zones) do
        if count > bestCount then
            bestMap = mapID
            bestCount = count
        end
    end
    return bestMap and ns.Util.GetMapName(bestMap) or ""
end

-------------------------------------------------------------------------------
-- Create the view
-------------------------------------------------------------------------------
function CatchLogView:Create(parent)
    view = CreateFrame("Frame", nil, parent)
    view:SetAllPoints()

    -- Summary stats bar
    local statsBar = CreateFrame("Frame", nil, view)
    statsBar:SetHeight(36)
    statsBar:SetPoint("TOPLEFT", 0, 0)
    statsBar:SetPoint("TOPRIGHT", 0, 0)

    local statsBg = statsBar:CreateTexture(nil, "BACKGROUND")
    statsBg:SetAllPoints()
    statsBg:SetColorTexture(0.0, 0.0, 0.0, 0.25)

    local totalLabel = statsBar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    totalLabel:SetPoint("LEFT", 12, 0)
    totalLabel:SetTextColor(ns.COLORS.PARCHMENT_TEXT:GetRGBA())
    view.totalLabel = totalLabel

    local uniqueLabel = statsBar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    uniqueLabel:SetPoint("LEFT", totalLabel, "RIGHT", 24, 0)
    uniqueLabel:SetTextColor(ns.COLORS.PARCHMENT_TEXT:GetRGBA())
    view.uniqueLabel = uniqueLabel

    local missedLabel = statsBar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    missedLabel:SetPoint("LEFT", uniqueLabel, "RIGHT", 24, 0)
    missedLabel:SetTextColor(0.7, 0.4, 0.4, 1)
    view.missedLabel = missedLabel

    -- Sort buttons
    local sortFrame = CreateFrame("Frame", nil, view)
    sortFrame:SetHeight(24)
    sortFrame:SetPoint("TOPLEFT", statsBar, "BOTTOMLEFT", 0, -2)
    sortFrame:SetPoint("TOPRIGHT", statsBar, "BOTTOMRIGHT", 0, -2)

    local sortModes = {
        { key = ns.SORT_RECENT, label = "Recent" },
        { key = ns.SORT_COUNT,  label = "Count" },
        { key = ns.SORT_NAME,   label = "Name" },
        { key = ns.SORT_RARITY, label = "Rarity" },
    }

    local sortButtons = {}
    local lastBtn = nil
    for _, mode in ipairs(sortModes) do
        local btn = CreateFrame("Button", nil, sortFrame)
        btn:SetHeight(20)
        btn:RegisterForClicks("AnyUp")

        local btnLabel = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        btnLabel:SetPoint("CENTER")
        btnLabel:SetText(mode.label)
        btn.label = btnLabel
        btn.sortKey = mode.key

        if lastBtn then
            btn:SetPoint("LEFT", lastBtn, "RIGHT", 4, 0)
        else
            btn:SetPoint("LEFT", 8, 0)
        end
        btn:SetWidth(btnLabel:GetStringWidth() + 16)

        btn:SetScript("OnClick", function()
            if ns.db then
                ns.db.catchLogSort = mode.key
                self:Refresh()
            end
        end)

        btn:SetScript("OnEnter", function(self)
            self.label:SetTextColor(1, 1, 1)
        end)

        btn:SetScript("OnLeave", function(self)
            local isActive = ns.db and ns.db.catchLogSort == self.sortKey
            if isActive then
                self.label:SetTextColor(ns.COLORS.NAV_ACTIVE:GetRGBA())
            else
                self.label:SetTextColor(0.7, 0.7, 0.7)
            end
        end)

        table.insert(sortButtons, btn)
        lastBtn = btn
    end
    view.sortButtons = sortButtons

    -- "Fish Only" toggle — filters out non-fish items (junk, containers, etc.)
    local fishBtn = CreateFrame("Button", nil, sortFrame)
    fishBtn:SetHeight(20)
    fishBtn:RegisterForClicks("AnyUp")
    fishBtn:SetPoint("RIGHT", -8, 0)

    local fishLabel = fishBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    fishLabel:SetPoint("CENTER")
    fishLabel:SetText("Fish Only")
    fishBtn.label = fishLabel
    fishBtn:SetWidth(fishLabel:GetStringWidth() + 16)

    local function UpdateFishBtnColor()
        if fishOnly then
            fishLabel:SetTextColor(ns.COLORS.NAV_ACTIVE:GetRGBA())
        else
            fishLabel:SetTextColor(0.7, 0.7, 0.7)
        end
    end

    fishBtn:SetScript("OnClick", function()
        fishOnly = not fishOnly
        if ns.db then
            ns.db.catchLogFishOnly = fishOnly
        end
        UpdateFishBtnColor()
        self:Refresh()
    end)

    fishBtn:SetScript("OnEnter", function()
        fishLabel:SetTextColor(1, 1, 1)
    end)

    fishBtn:SetScript("OnLeave", function()
        UpdateFishBtnColor()
    end)

    -- Restore saved state
    fishOnly = ns.db and ns.db.catchLogFishOnly or false
    UpdateFishBtnColor()
    view.fishBtn = fishBtn

    -- Column headers
    local headerBar = CreateFrame("Frame", nil, view)
    headerBar:SetHeight(20)
    headerBar:SetPoint("TOPLEFT", sortFrame, "BOTTOMLEFT", 0, -2)
    headerBar:SetPoint("TOPRIGHT", sortFrame, "BOTTOMRIGHT", 0, -2)

    local hdrBg = headerBar:CreateTexture(nil, "BACKGROUND")
    hdrBg:SetAllPoints()
    hdrBg:SetColorTexture(0.0, 0.0, 0.0, 0.3)

    local hdrIcon = headerBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    hdrIcon:SetPoint("LEFT", 4, 0)
    hdrIcon:SetWidth(28)
    hdrIcon:SetText("")

    local hdrName = headerBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    hdrName:SetPoint("LEFT", 34, 0)
    hdrName:SetText("Fish")
    hdrName:SetTextColor(ns.COLORS.HEADER_TEXT:GetRGBA())

    local hdrCount = headerBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    hdrCount:SetPoint("LEFT", 260, 0)
    hdrCount:SetText("Caught")
    hdrCount:SetTextColor(ns.COLORS.HEADER_TEXT:GetRGBA())

    local hdrZone = headerBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    hdrZone:SetPoint("LEFT", 328, 0)
    hdrZone:SetText("Top Zone")
    hdrZone:SetTextColor(ns.COLORS.HEADER_TEXT:GetRGBA())

    -- Scrollable fish list
    local listContainer = ns.Widgets:CreateScrollList(view, 28, function(row, data)
        if not row.isInitialized then
            local fishRow = ns.Widgets:CreateFishRow(row)
            fishRow:SetAllPoints()
            row.fishRow = fishRow
            row.isInitialized = true
        end

        local fr = row.fishRow
        local info = CacheItemInfo(data.itemID)

        fr.icon:SetTexture(info.icon or "Interface\\Icons\\INV_Misc_Fish_02")
        fr.name:SetText(info.name or ("Item #" .. data.itemID))

        local color = ns.Util.GetItemQualityColor(info.quality)
        fr.name:SetTextColor(color:GetRGBA())

        fr.count:SetText(ns.Util.FormatCount(data.count))
        fr.count:SetTextColor(ns.COLORS.PARCHMENT_TEXT:GetRGBA())

        fr.zone:SetText(GetPrimaryZone(data.zones))

        -- Tooltip on enter
        fr:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetItemByID(data.itemID)
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine(format("Total caught: %d", data.count), 1, 1, 1)
            if data.firstCaught then
                GameTooltip:AddLine("First caught: " .. ns.Util.FormatTimestamp(data.firstCaught), 0.7, 0.7, 0.7)
            end
            if data.lastCaught then
                GameTooltip:AddLine("Last caught: " .. ns.Util.FormatRelativeTime(data.lastCaught), 0.7, 0.7, 0.7)
            end
            GameTooltip:Show()
        end)
        fr:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
    end)
    listContainer:SetPoint("TOPLEFT", headerBar, "BOTTOMLEFT", 0, -2)
    listContainer:SetPoint("BOTTOMRIGHT", 0, 0)
    view.listContainer = listContainer

    self.frame = view
    return view
end

function CatchLogView:Refresh()
    if not view or not ns.db then return end

    -- Save scroll position
    local scrollPct = view.listContainer.scrollBox:GetScrollPercentage() or 0

    -- Update stats
    view.totalLabel:SetText("Total: " .. ns.Util.FormatCount(ns.db.sessions.totalCatches))
    view.uniqueLabel:SetText("Species: " .. ns.db.sessions.uniqueSpecies)
    view.missedLabel:SetText("Missed: " .. (ns.db.sessions.missedCatches or 0))

    -- Update sort button highlighting
    for _, btn in ipairs(view.sortButtons) do
        local isActive = ns.db.catchLogSort == btn.sortKey
        if isActive then
            btn.label:SetTextColor(ns.COLORS.NAV_ACTIVE:GetRGBA())
        else
            btn.label:SetTextColor(0.7, 0.7, 0.7)
        end
    end

    -- Rebuild and display list
    BuildSortedList()

    -- Apply "Fish Only" filter — keep only items in FishData
    if fishOnly then
        local filtered = {}
        for _, entry in ipairs(sortedList) do
            if ns.FishData[entry.itemID] then
                table.insert(filtered, entry)
            end
        end
        sortedList = filtered
    end

    -- Apply search filter
    if filterText and filterText ~= "" then
        local filtered = {}
        for _, entry in ipairs(sortedList) do
            if MatchesFilter(entry.name, filterText) then
                table.insert(filtered, entry)
            end
        end
        sortedList = filtered
    end

    local dp = view.listContainer.dataProvider
    dp:Flush()
    for _, entry in ipairs(sortedList) do
        dp:Insert(entry)
    end
    isPopulated = true

    -- Restore scroll position
    C_Timer.After(0, function()
        if view and view.listContainer and view.listContainer.scrollBox then
            view.listContainer.scrollBox:SetScrollPercentage(scrollPct)
        end
    end)

    -- Empty state
    if #sortedList == 0 then
        if not view.emptyText then
            local empty = view:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            empty:SetPoint("CENTER", view.listContainer)
            empty:SetText("No fish caught yet.\nGrab your pole and find some water!")
            empty:SetTextColor(ns.COLORS.UNCAUGHT:GetRGBA())
            empty:SetJustifyH("CENTER")
            view.emptyText = empty
        end
        view.emptyText:Show()
    elseif view.emptyText then
        view.emptyText:Hide()
    end
end

function CatchLogView:Show()
    if self.frame then
        self.frame:Show()
        self:Refresh()
    end
end

function CatchLogView:SetFilter(text)
    filterText = (text and text ~= "") and text or nil
    if isPopulated then
        self:Refresh()
    end
end

function CatchLogView:Hide()
    if self.frame then self.frame:Hide() end
end
