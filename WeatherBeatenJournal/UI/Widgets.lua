local _, ns = ...

-------------------------------------------------------------------------------
-- Widgets — shared UI primitives
-------------------------------------------------------------------------------
local Widgets = {}
ns.Widgets = Widgets

-------------------------------------------------------------------------------
-- Scrollable container using the DataProvider/ScrollBox pattern
-------------------------------------------------------------------------------
function Widgets:CreateScrollList(parent, rowHeight, initFunc)
    local container = CreateFrame("Frame", nil, parent)
    -- NOTE: Do NOT SetAllPoints here. Callers provide their own anchoring.

    local scrollBar = CreateFrame("EventFrame", nil, container, "MinimalScrollBar")
    scrollBar:SetPoint("TOPRIGHT", 0, 0)
    scrollBar:SetPoint("BOTTOMRIGHT", 0, 0)

    local scrollBox = CreateFrame("Frame", nil, container, "WowScrollBoxList")
    scrollBox:SetPoint("TOPLEFT", 0, 0)
    scrollBox:SetPoint("BOTTOMLEFT", 0, 0)
    scrollBox:SetPoint("RIGHT", scrollBar, "LEFT", -4, 0)

    local view = CreateScrollBoxListLinearView()
    view:SetElementExtent(rowHeight)
    view:SetElementInitializer("Frame", initFunc)

    ScrollUtil.InitScrollBoxListWithScrollBar(scrollBox, scrollBar, view)

    local dataProvider = CreateDataProvider()
    scrollBox:SetDataProvider(dataProvider)

    container.scrollBox = scrollBox
    container.scrollBar = scrollBar
    container.dataProvider = dataProvider

    return container
end

-------------------------------------------------------------------------------
-- Section header bar
-------------------------------------------------------------------------------
function Widgets:CreateSectionHeader(parent, text)
    local header = CreateFrame("Frame", nil, parent)
    header:SetHeight(28)

    local bg = header:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(0.0, 0.0, 0.0, 0.25)

    local label = header:CreateFontString(nil, "OVERLAY")
    label:SetFont(ns.HEADER_FONT, 16, "")
    label:SetTextColor(ns.COLORS.HEADER_TEXT:GetRGBA())
    label:SetPoint("LEFT", 8, 0)
    label:SetText(text)
    header.label = label

    local line = header:CreateTexture(nil, "ARTWORK")
    line:SetHeight(1)
    line:SetPoint("BOTTOMLEFT", 0, 0)
    line:SetPoint("BOTTOMRIGHT", 0, 0)
    line:SetColorTexture(0.50, 0.45, 0.30, 0.5)

    return header
end

-------------------------------------------------------------------------------
-- Fish row (icon + name + count + zone)
-------------------------------------------------------------------------------
function Widgets:CreateFishRow(parent)
    local row = CreateFrame("Button", nil, parent)
    row:SetHeight(28)
    row:RegisterForClicks("AnyUp")

    -- Hover highlight
    local hl = row:CreateTexture(nil, "HIGHLIGHT")
    hl:SetAllPoints()
    hl:SetColorTexture(ns.COLORS.HIGHLIGHT:GetRGBA())

    -- Icon
    local icon = row:CreateTexture(nil, "ARTWORK")
    icon:SetSize(24, 24)
    icon:SetPoint("LEFT", 4, 0)
    row.icon = icon

    -- Name
    local name = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    name:SetPoint("LEFT", icon, "RIGHT", 6, 0)
    name:SetWidth(220)
    name:SetJustifyH("LEFT")
    name:SetWordWrap(false)
    row.name = name

    -- Count
    local count = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    count:SetPoint("LEFT", name, "RIGHT", 8, 0)
    count:SetWidth(60)
    count:SetJustifyH("CENTER")
    row.count = count

    -- Zone
    local zone = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    zone:SetPoint("LEFT", count, "RIGHT", 8, 0)
    zone:SetPoint("RIGHT", -4, 0)
    zone:SetJustifyH("LEFT")
    zone:SetWordWrap(false)
    zone:SetTextColor(0.7, 0.7, 0.7)
    row.zone = zone

    return row
end

-------------------------------------------------------------------------------
-- Navigation button (for section nav bar)
-------------------------------------------------------------------------------
function Widgets:CreateNavButton(parent, text, onClick)
    local btn = CreateFrame("Button", nil, parent)
    btn:SetHeight(ns.SECTION_NAV_HEIGHT)
    btn:RegisterForClicks("AnyUp")

    -- Visible background strip
    local bg = btn:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(0.0, 0.0, 0.0, 0.3)
    btn.bg = bg

    -- Border lines top and bottom
    local topLine = btn:CreateTexture(nil, "BORDER")
    topLine:SetHeight(1)
    topLine:SetPoint("TOPLEFT", 0, 0)
    topLine:SetPoint("TOPRIGHT", 0, 0)
    topLine:SetColorTexture(0.50, 0.45, 0.30, 0.5)

    local botLine = btn:CreateTexture(nil, "BORDER")
    botLine:SetHeight(1)
    botLine:SetPoint("BOTTOMLEFT", 0, 0)
    botLine:SetPoint("BOTTOMRIGHT", 0, 0)
    botLine:SetColorTexture(0.50, 0.45, 0.30, 0.5)

    -- Use GameFontNormal (FRIZQT) which is readable on parchment, not MORPHEUS
    local label = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("CENTER", 0, 1)
    label:SetText(text)
    btn.label = label

    -- Underline indicator for active tab
    local indicator = btn:CreateTexture(nil, "OVERLAY")
    indicator:SetHeight(3)
    indicator:SetPoint("BOTTOMLEFT", 2, 1)
    indicator:SetPoint("BOTTOMRIGHT", -2, 1)
    indicator:SetColorTexture(0.85, 0.65, 0.13, 1)  -- gold
    indicator:Hide()
    btn.indicator = indicator

    -- Highlight on hover
    local hl = btn:CreateTexture(nil, "HIGHLIGHT")
    hl:SetAllPoints()
    hl:SetColorTexture(1, 1, 1, 0.06)

    btn:SetScript("OnClick", function()
        if onClick then onClick() end
    end)

    function btn:SetActive(active)
        self.isActive = active
        if active then
            self.label:SetTextColor(1, 0.82, 0)  -- bright gold
            self.indicator:Show()
            self.bg:SetColorTexture(0.15, 0.12, 0.05, 0.45)
        else
            self.label:SetTextColor(0.75, 0.70, 0.55)  -- muted but readable on dark
            self.indicator:Hide()
            self.bg:SetColorTexture(0.0, 0.0, 0.0, 0.3)
        end
    end

    btn:SetActive(false)
    return btn
end

-------------------------------------------------------------------------------
-- Checklist row (checkbox + label + status)
-------------------------------------------------------------------------------
function Widgets:CreateChecklistRow(parent)
    local row = CreateFrame("Frame", nil, parent)
    row:SetHeight(24)

    local check = row:CreateTexture(nil, "ARTWORK")
    check:SetSize(16, 16)
    check:SetPoint("LEFT", 4, 0)
    row.check = check

    local label = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("LEFT", check, "RIGHT", 6, 0)
    label:SetPoint("RIGHT", -80, 0)
    label:SetJustifyH("LEFT")
    label:SetWordWrap(false)
    row.label = label

    local status = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    status:SetPoint("RIGHT", -4, 0)
    status:SetWidth(72)
    status:SetJustifyH("RIGHT")
    row.status = status

    function row:SetCompleted(completed)
        if completed then
            self.check:SetAtlas("common-icon-checkmark")
            self.label:SetTextColor(ns.COLORS.CAUGHT:GetRGBA())
            self.status:SetText("Completed")
            self.status:SetTextColor(ns.COLORS.CAUGHT:GetRGBA())
        else
            self.check:SetAtlas("common-icon-redx")
            self.label:SetTextColor(ns.COLORS.UNCAUGHT:GetRGBA())
            self.status:SetText("Incomplete")
            self.status:SetTextColor(ns.COLORS.UNCAUGHT:GetRGBA())
        end
    end

    return row
end

-------------------------------------------------------------------------------
-- Progress bar
-------------------------------------------------------------------------------
function Widgets:CreateProgressBar(parent, width, height)
    local bar = CreateFrame("StatusBar", nil, parent)
    bar:SetSize(width or 200, height or 16)
    bar:SetMinMaxValues(0, 1)
    bar:SetValue(0)
    bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    bar:SetStatusBarColor(0.2, 0.6, 0.2, 0.8)

    local bgTex = bar:CreateTexture(nil, "BACKGROUND")
    bgTex:SetAllPoints()
    bgTex:SetColorTexture(0, 0, 0, 0.4)

    local text = bar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    text:SetPoint("CENTER")
    bar.text = text

    function bar:SetProgress(current, total)
        if total == 0 then total = 1 end
        self:SetMinMaxValues(0, total)
        self:SetValue(current)
        self.text:SetText(current .. " / " .. total)
    end

    return bar
end

-------------------------------------------------------------------------------
-- Search box (EditBox with icon, clear button, debounced callback)
-------------------------------------------------------------------------------
function Widgets:CreateSearchBox(parent, onTextChanged)
    local container = CreateFrame("Frame", nil, parent)
    container:SetHeight(ns.SEARCH_BAR_HEIGHT)

    -- Background
    local bg = container:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(0.0, 0.0, 0.0, 0.25)

    -- Border (bottom line)
    local border = container:CreateTexture(nil, "BORDER")
    border:SetHeight(1)
    border:SetPoint("BOTTOMLEFT", 0, 0)
    border:SetPoint("BOTTOMRIGHT", 0, 0)
    border:SetColorTexture(0.50, 0.45, 0.30, 0.5)

    -- Magnifying glass icon
    local searchIcon = container:CreateTexture(nil, "ARTWORK")
    searchIcon:SetSize(14, 14)
    searchIcon:SetPoint("LEFT", 8, 0)
    searchIcon:SetAtlas("common-search-magnifyingglass")
    searchIcon:SetVertexColor(0.6, 0.5, 0.35)

    -- Clear button (X)
    local clearBtn = CreateFrame("Button", nil, container)
    clearBtn:SetSize(16, 16)
    clearBtn:SetPoint("RIGHT", -6, 0)
    clearBtn:Hide()

    local clearIcon = clearBtn:CreateTexture(nil, "ARTWORK")
    clearIcon:SetAllPoints()
    clearIcon:SetAtlas("common-search-clearbutton")
    clearIcon:SetVertexColor(0.6, 0.5, 0.35)
    clearBtn:SetScript("OnEnter", function() clearIcon:SetVertexColor(1, 0.82, 0) end)
    clearBtn:SetScript("OnLeave", function() clearIcon:SetVertexColor(0.6, 0.5, 0.35) end)

    -- EditBox
    local editBox = CreateFrame("EditBox", nil, container)
    editBox:SetPoint("LEFT", searchIcon, "RIGHT", 6, 0)
    editBox:SetPoint("RIGHT", clearBtn, "LEFT", -4, 0)
    editBox:SetHeight(20)
    editBox:SetFont("Fonts\\FRIZQT__.TTF", 12, "")
    editBox:SetTextColor(ns.COLORS.PARCHMENT_TEXT:GetRGBA())
    editBox:SetAutoFocus(false)
    editBox:SetMaxLetters(50)

    -- Placeholder text
    local placeholder = editBox:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    placeholder:SetPoint("LEFT", 2, 0)
    placeholder:SetText("Search...")
    placeholder:SetTextColor(0.6, 0.6, 0.5, 0.5)

    -- Debounce timer handle
    local debounceTimer = nil

    local function FireCallback(text)
        if debounceTimer then
            debounceTimer:Cancel()
            debounceTimer = nil
        end
        debounceTimer = C_Timer.NewTimer(0.15, function()
            debounceTimer = nil
            if onTextChanged then
                onTextChanged(text)
            end
        end)
    end

    editBox:SetScript("OnTextChanged", function(self, userInput)
        local text = self:GetText()
        if text and text ~= "" then
            placeholder:Hide()
            clearBtn:Show()
        else
            placeholder:Show()
            clearBtn:Hide()
        end
        if userInput then
            FireCallback(text)
        end
    end)

    editBox:SetScript("OnEscapePressed", function(self)
        self:SetText("")
        self:ClearFocus()
        if onTextChanged then
            if debounceTimer then debounceTimer:Cancel(); debounceTimer = nil end
            onTextChanged("")
        end
    end)

    editBox:SetScript("OnEnterPressed", function(self)
        self:ClearFocus()
    end)

    clearBtn:SetScript("OnClick", function()
        editBox:SetText("")
        editBox:ClearFocus()
        if onTextChanged then
            if debounceTimer then debounceTimer:Cancel(); debounceTimer = nil end
            onTextChanged("")
        end
    end)

    container.editBox = editBox

    function container:SetText(text)
        self.editBox:SetText(text or "")
    end

    function container:GetText()
        return self.editBox:GetText()
    end

    function container:ClearText()
        self.editBox:SetText("")
        if onTextChanged then
            if debounceTimer then debounceTimer:Cancel(); debounceTimer = nil end
            onTextChanged("")
        end
    end

    return container
end

-------------------------------------------------------------------------------
-- Simple text label
-------------------------------------------------------------------------------
function Widgets:CreateLabel(parent, text, fontObj)
    local label = parent:CreateFontString(nil, "OVERLAY", fontObj or "GameFontNormal")
    label:SetText(text or "")
    label:SetJustifyH("LEFT")
    label:SetWordWrap(true)
    return label
end
