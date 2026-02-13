local _, ns = ...

-------------------------------------------------------------------------------
-- JournalPage — the content frame that sits inside the ProfessionsFrame tab
-- Must implement GetDesiredPageWidth() or the frame errors on tab click.
-------------------------------------------------------------------------------
local JournalPage = {}
ns.JournalPage = JournalPage

-- ProfessionsFrame header (portrait + title + nine-slice) is ~58px tall.
-- Our content must start BELOW that.
local PAGE_TOP_INSET = 58
local PAGE_SIDE_INSET = 8
local PAGE_BOT_INSET = 6

function JournalPage:Create(parent)
    local page = CreateFrame("Frame", "WBJJournalPage", parent)
    page:SetAllPoints()
    page:Hide()

    -- Critical: ProfessionsFrame calls this to size the page
    function page:GetDesiredPageWidth()
        return ns.JOURNAL_PAGE_WIDTH
    end

    -- Background
    local bg = page:CreateTexture(nil, "BACKGROUND")
    bg:SetAtlas("Professions-Recipe-Background-Fishing")
    bg:SetAllPoints()
    page.bg = bg

    -- Search area — sits right at the top of the page content area
    local searchArea = CreateFrame("Frame", nil, page)
    searchArea:SetPoint("TOPLEFT", PAGE_SIDE_INSET, -PAGE_TOP_INSET)
    searchArea:SetPoint("TOPRIGHT", -PAGE_SIDE_INSET, -PAGE_TOP_INSET)
    searchArea:SetHeight(ns.SEARCH_BAR_HEIGHT)
    page.searchArea = searchArea

    -- Navigation area — below the search bar
    local navArea = CreateFrame("Frame", nil, page)
    navArea:SetPoint("TOPLEFT", searchArea, "BOTTOMLEFT", 0, -2)
    navArea:SetPoint("TOPRIGHT", searchArea, "BOTTOMRIGHT", 0, -2)
    navArea:SetHeight(ns.SECTION_NAV_HEIGHT)
    page.navArea = navArea

    -- Content area — between nav and narrator
    local content = CreateFrame("Frame", nil, page)
    content:SetPoint("TOPLEFT", navArea, "BOTTOMLEFT", 0, -4)
    content:SetPoint("BOTTOMRIGHT", -PAGE_SIDE_INSET, ns.NARRATOR_PANEL_HEIGHT + PAGE_BOT_INSET)
    page.content = content

    -- Narrator area — anchored to the bottom
    local narratorArea = CreateFrame("Frame", nil, page)
    narratorArea:SetPoint("BOTTOMLEFT", PAGE_SIDE_INSET, PAGE_BOT_INSET)
    narratorArea:SetPoint("BOTTOMRIGHT", -PAGE_SIDE_INSET, PAGE_BOT_INSET)
    narratorArea:SetHeight(ns.NARRATOR_PANEL_HEIGHT)
    page.narratorArea = narratorArea

    -- When the tab system shows our page, trigger a deferred refresh.
    -- Two-frame delay lets the ProfessionsFrame finish sizing the page.
    page:SetScript("OnShow", function()
        C_Timer.After(0.05, function()
            if ns.JournalFrame and ns.JournalFrame.Refresh then
                ns.JournalFrame:Refresh()
            end
        end)
    end)

    self.frame = page
    return page
end

function JournalPage:Show()
    if self.frame then
        self.frame:Show()
        if ns.JournalFrame and ns.JournalFrame.Refresh then
            ns.JournalFrame:Refresh()
        end
    end
end

function JournalPage:Hide()
    if self.frame then
        self.frame:Hide()
    end
end
