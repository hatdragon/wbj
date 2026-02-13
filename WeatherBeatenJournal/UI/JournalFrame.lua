local _, ns = ...

-------------------------------------------------------------------------------
-- JournalFrame — composes section navigation + views + narrator panel
-------------------------------------------------------------------------------
local JournalFrame = {}
ns.JournalFrame = JournalFrame

local frame = nil
local contentParent = nil
local currentSection = nil
local navButtons = {}
local searchBox = nil
local searchText = ""
-- Module table + lazy-created flag per section
local sectionModules = {}
local sectionCreated = {}

-- Map section IDs to their module tables (registered at file load, created on demand)
local SECTION_MODULE_MAP = {
    [1] = function() return ns.CatchLogView end,   -- SECTION_CATCH_LOG
    [2] = function() return ns.SpotGuideView end,   -- SECTION_SPOT_GUIDE
    [3] = function() return ns.CollectionView end,  -- SECTION_COLLECTIONS
}

local function EnsureSectionCreated(sectionID)
    if sectionCreated[sectionID] then return end

    local getter = SECTION_MODULE_MAP[sectionID]
    if not getter then return end

    local mod = getter()
    mod:Create(contentParent)
    sectionModules[sectionID] = mod
    sectionCreated[sectionID] = true
end

function JournalFrame:Create(page)
    local navArea = page.navArea
    local narratorArea = page.narratorArea
    contentParent = page.content

    -- Don't create section views yet — they are lazy-loaded on first visit

    -- Create search box
    searchBox = ns.Widgets:CreateSearchBox(page.searchArea, function(text)
        searchText = text or ""
        if currentSection and sectionModules[currentSection] then
            sectionModules[currentSection]:SetFilter(searchText)
        end
    end)
    searchBox:SetPoint("TOPLEFT", 0, 0)
    searchBox:SetPoint("TOPRIGHT", 0, 0)
    searchBox:SetHeight(ns.SEARCH_BAR_HEIGHT)

    -- Create narrator panel
    ns.NarratorPanel:Create(narratorArea)

    -- Create navigation buttons
    for i, name in ipairs(ns.SECTION_NAMES) do
        local btn = ns.Widgets:CreateNavButton(navArea, name, function()
            self:SetSection(i)
        end)
        navButtons[i] = btn
    end

    -- Layout nav buttons evenly across the navArea
    local function LayoutNavButtons(width)
        if width <= 0 then width = 900 end
        local bw = width / #navButtons
        for i, btn in ipairs(navButtons) do
            btn:ClearAllPoints()
            btn:SetPoint("TOPLEFT", (i - 1) * bw, 0)
            btn:SetPoint("BOTTOMLEFT", (i - 1) * bw, 0)
            btn:SetWidth(bw)
        end
    end

    LayoutNavButtons(navArea:GetWidth())
    navArea:SetScript("OnSizeChanged", function(_, width)
        LayoutNavButtons(width)
    end)

    frame = page
    self.isCreated = true

    -- Default to Spot Guide for fresh installs, otherwise respect saved state
    local startSection = ns.db and ns.db.lastSection or ns.SECTION_SPOT_GUIDE
    self:SetSection(startSection)
end

function JournalFrame:SetSection(sectionID)
    if not self.isCreated then return end

    -- No-op if already on this section
    if currentSection == sectionID then return end

    -- Clear search on section change
    if searchBox then
        searchText = ""
        searchBox:ClearText()
    end

    -- Hide all created section modules
    for _, mod in pairs(sectionModules) do
        mod:Hide()
    end

    -- Deactivate all nav buttons
    for _, btn in pairs(navButtons) do
        btn:SetActive(false)
    end

    -- Lazy-create the view if needed, then show it
    currentSection = sectionID
    EnsureSectionCreated(sectionID)
    if sectionModules[sectionID] then
        sectionModules[sectionID]:Show()
    end
    if navButtons[sectionID] then
        navButtons[sectionID]:SetActive(true)
    end

    -- Update narrator
    ns.NarratorPanel:SetForSection(sectionID)

    -- Save state
    if ns.db then
        ns.db.lastSection = sectionID
    end
end

function JournalFrame:Refresh()
    if not self.isCreated then
        -- First time: create everything
        if ns.JournalPage and ns.JournalPage.frame then
            self:Create(ns.JournalPage.frame)
        end
    end

    if not self.isCreated then return end

    -- Force re-display by clearing currentSection so SetSection isn't a no-op.
    -- This handles both first-create (layout may not be settled yet) and
    -- tab-switch-back (need to re-show the active section).
    local section = currentSection or ns.SECTION_SPOT_GUIDE
    currentSection = nil
    self:SetSection(section)
end

function JournalFrame:GetCurrentSection()
    return currentSection
end
