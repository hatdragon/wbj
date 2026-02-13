local _, ns = ...

-------------------------------------------------------------------------------
-- CollectionView — achievements, mounts, pets, toys, Underlight Angler,
-- Garrison Fishing Shack, Anglers rep
-------------------------------------------------------------------------------
local CollectionView = {}
ns.CollectionView = CollectionView

local view = nil
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
function CollectionView:Create(parent)
    view = CreateFrame("Frame", nil, parent)
    view:SetAllPoints()

    -- Main scroll area
    local scrollBox = CreateFrame("Frame", nil, view, "WowScrollBoxList")
    scrollBox:SetPoint("TOPLEFT", 0, 0)
    scrollBox:SetPoint("BOTTOMRIGHT", -20, 0)

    local scrollBar = CreateFrame("EventFrame", nil, view, "MinimalScrollBar")
    scrollBar:SetPoint("TOPLEFT", scrollBox, "TOPRIGHT", 4, 0)
    scrollBar:SetPoint("BOTTOMLEFT", scrollBox, "BOTTOMRIGHT", 4, 0)

    local listView = CreateScrollBoxListLinearView()
    listView:SetElementExtent(28)
    listView:SetElementInitializer("Frame", function(row, data)
        if not row.isInitialized then
            -- Reusable row setup
            row.icon = row:CreateTexture(nil, "ARTWORK")
            row.icon:SetSize(22, 22)
            row.icon:SetPoint("LEFT", 4, 0)

            row.label = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            row.label:SetPoint("LEFT", row.icon, "RIGHT", 6, 0)
            row.label:SetPoint("RIGHT", -80, 0)
            row.label:SetJustifyH("LEFT")
            row.label:SetWordWrap(false)

            row.status = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            row.status:SetPoint("RIGHT", -4, 0)
            row.status:SetWidth(72)
            row.status:SetJustifyH("RIGHT")

            row.hl = row:CreateTexture(nil, "HIGHLIGHT")
            row.hl:SetAllPoints()
            row.hl:SetColorTexture(ns.COLORS.HIGHLIGHT:GetRGBA())

            row.isInitialized = true
        end

        -- Render based on data type
        if data.type == "header" then
            row.icon:Hide()
            row.label:SetPoint("LEFT", 4, 0)
            row.label:SetFont(ns.HEADER_FONT, 14, "")
            row.label:SetTextColor(ns.COLORS.HEADER_TEXT:GetRGBA())
            row.label:SetText(data.text)
            row.status:SetText(data.progress or "")
            row.status:SetTextColor(ns.COLORS.HEADER_TEXT:GetRGBA())
            row.hl:Hide()
        elseif data.type == "achievement" then
            row.icon:Show()
            row.icon:SetTexture("Interface\\Icons\\Achievement_General")
            row.label:SetPoint("LEFT", row.icon, "RIGHT", 6, 0)
            row.label:SetFont("Fonts\\FRIZQT__.TTF", 11, "")
            row.label:SetText(data.name)
            row.hl:Show()

            if data.completed then
                row.label:SetTextColor(ns.COLORS.CAUGHT:GetRGBA())
                row.status:SetText("Earned")
                row.status:SetTextColor(ns.COLORS.CAUGHT:GetRGBA())
            else
                row.label:SetTextColor(ns.COLORS.PARCHMENT_TEXT:GetRGBA())
                row.status:SetText("In Progress")
                row.status:SetTextColor(ns.COLORS.UNCAUGHT:GetRGBA())
            end

            -- Tooltip
            row:SetScript("OnEnter", function(self)
                if data.achievementID then
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    GameTooltip:SetHyperlink(format("achievement:%d", data.achievementID))
                    GameTooltip:Show()
                end
            end)
            row:SetScript("OnLeave", function() GameTooltip:Hide() end)
        elseif data.type == "mount" then
            row.icon:Show()
            local mIcon = data.icon and data.icon ~= 0 and data.icon or "Interface\\Icons\\Trade_Fishing"
            row.icon:SetTexture(mIcon)
            row.label:SetPoint("LEFT", row.icon, "RIGHT", 6, 0)
            row.label:SetFont("Fonts\\FRIZQT__.TTF", 11, "")
            row.label:SetText(data.name)
            row.hl:Show()

            if data.collected then
                row.label:SetTextColor(ns.COLORS.CAUGHT:GetRGBA())
                row.status:SetText("Collected")
                row.status:SetTextColor(ns.COLORS.CAUGHT:GetRGBA())
            else
                row.label:SetTextColor(ns.COLORS.PARCHMENT_TEXT:GetRGBA())
                row.status:SetText(data.source or "")
                row.status:SetTextColor(ns.COLORS.UNCAUGHT:GetRGBA())
            end

            row:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(data.name, 1, 1, 1)
                GameTooltip:AddLine(data.zones or data.source or "", 0.7, 0.7, 0.7, true)
                GameTooltip:Show()
            end)
            row:SetScript("OnLeave", function() GameTooltip:Hide() end)
        elseif data.type == "pet" then
            row.icon:Show()
            local pIcon = data.icon and data.icon ~= 0 and data.icon or "Interface\\Icons\\INV_Pet_BabyBlizzardBear"
            row.icon:SetTexture(pIcon)
            row.label:SetPoint("LEFT", row.icon, "RIGHT", 6, 0)
            row.label:SetFont("Fonts\\FRIZQT__.TTF", 11, "")
            row.label:SetText(data.name)
            row.hl:Show()

            if data.collected then
                row.label:SetTextColor(ns.COLORS.CAUGHT:GetRGBA())
                row.status:SetText("Collected")
                row.status:SetTextColor(ns.COLORS.CAUGHT:GetRGBA())
            else
                row.label:SetTextColor(ns.COLORS.PARCHMENT_TEXT:GetRGBA())
                row.status:SetText(data.source or "")
                row.status:SetTextColor(ns.COLORS.UNCAUGHT:GetRGBA())
            end

            row:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(data.name, 1, 1, 1)
                GameTooltip:AddLine(data.source or "", 0.7, 0.7, 0.7, true)
                GameTooltip:Show()
            end)
            row:SetScript("OnLeave", function() GameTooltip:Hide() end)
        elseif data.type == "toy" then
            row.icon:Show()
            row.icon:SetTexture("Interface\\Icons\\Trade_Fishing")
            row.label:SetPoint("LEFT", row.icon, "RIGHT", 6, 0)
            row.label:SetFont("Fonts\\FRIZQT__.TTF", 11, "")
            row.label:SetText(data.name)
            row.hl:Show()

            if data.collected then
                row.label:SetTextColor(ns.COLORS.CAUGHT:GetRGBA())
                row.status:SetText("Collected")
                row.status:SetTextColor(ns.COLORS.CAUGHT:GetRGBA())
            else
                row.label:SetTextColor(ns.COLORS.PARCHMENT_TEXT:GetRGBA())
                row.status:SetText(data.source or "")
                row.status:SetTextColor(ns.COLORS.UNCAUGHT:GetRGBA())
            end

            row:SetScript("OnEnter", function(self)
                if data.itemID then
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    GameTooltip:SetItemByID(data.itemID)
                    GameTooltip:Show()
                end
            end)
            row:SetScript("OnLeave", function() GameTooltip:Hide() end)
        elseif data.type == "quest" then
            row.icon:Show()
            row.icon:SetTexture("Interface\\Icons\\INV_Misc_Book_11")
            row.label:SetPoint("LEFT", row.icon, "RIGHT", 6, 0)
            row.label:SetFont("Fonts\\FRIZQT__.TTF", 11, "")
            row.label:SetText(data.name)
            row.hl:Show()

            if data.completed then
                row.label:SetTextColor(ns.COLORS.CAUGHT:GetRGBA())
                row.status:SetText("Done")
                row.status:SetTextColor(ns.COLORS.CAUGHT:GetRGBA())
            else
                row.label:SetTextColor(ns.COLORS.PARCHMENT_TEXT:GetRGBA())
                row.status:SetText("Incomplete")
                row.status:SetTextColor(ns.COLORS.UNCAUGHT:GetRGBA())
            end

            row:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(data.name, 1, 1, 1)
                if data.description then
                    GameTooltip:AddLine(data.description, 0.7, 0.7, 0.7, true)
                end
                GameTooltip:Show()
            end)
            row:SetScript("OnLeave", function() GameTooltip:Hide() end)
        elseif data.type == "info" then
            row.icon:Hide()
            row.label:SetPoint("LEFT", 24, 0)
            row.label:SetFont("Fonts\\FRIZQT__.TTF", 10, "")
            row.label:SetTextColor(0.75, 0.70, 0.58)
            row.label:SetText(data.text)
            row.status:SetText("")
            row.hl:Hide()
            row:SetScript("OnEnter", nil)
            row:SetScript("OnLeave", nil)
        end
    end)

    ScrollUtil.InitScrollBoxListWithScrollBar(scrollBox, scrollBar, listView)
    local dp = CreateDataProvider()
    scrollBox:SetDataProvider(dp)

    view.scrollBox = scrollBox
    view.dataProvider = dp

    self.frame = view
    return view
end

-------------------------------------------------------------------------------
-- Build data list
-------------------------------------------------------------------------------
-- Helper: count completed in a category
local function CountCategory(category)
    local done, total = 0, 0
    for _, ach in ipairs(ns.AchievementData.ACHIEVEMENTS) do
        if ach.category == category then
            total = total + 1
            if ns.IsAchievementCompleted(ach.id) then done = done + 1 end
        end
    end
    return done, total
end

-- Helper: add all achievements in a category to items list
local function AddCategoryAchievements(items, category, showExpansion)
    for _, ach in ipairs(ns.AchievementData.ACHIEVEMENTS) do
        if ach.category == category then
            local name = ach.name
            if showExpansion and ach.expansion then
                name = format("%s (%s)", name, ach.expansion)
            end
            table.insert(items, {
                type = "achievement",
                name = name,
                achievementID = ach.id,
                completed = ns.IsAchievementCompleted(ach.id),
            })
        end
    end
end

local function BuildCollectionData()
    local items = {}

    -- === "Salty" Meta Achievement ===
    local saltyDone, saltyTotal = CountCategory("salty")
    table.insert(items, {
        type = "header",
        text = "\"Salty\" — Accomplished Angler",
        progress = format("%d/%d", saltyDone, saltyTotal),
    })
    AddCategoryAchievements(items, "salty")

    -- === Rare Catches & Mount Achievements ===
    local rareDone, rareTotal = CountCategory("rare")
    table.insert(items, {
        type = "header",
        text = "Rare Catches",
        progress = format("%d/%d", rareDone, rareTotal),
    })
    AddCategoryAchievements(items, "rare")

    -- === Mounts ===
    local mountCount, mountTotal = 0, #ns.AchievementData.MOUNTS
    for _, m in ipairs(ns.AchievementData.MOUNTS) do
        local collected = ns.IsMountCollected(m.spellID)
        if collected then mountCount = mountCount + 1 end
    end
    table.insert(items, {
        type = "header",
        text = "Fishing Mounts",
        progress = format("%d/%d", mountCount, mountTotal),
    })
    for _, m in ipairs(ns.AchievementData.MOUNTS) do
        local collected, icon = ns.IsMountCollected(m.spellID)
        table.insert(items, {
            type = "mount",
            name = m.name,
            source = m.source,
            zones = m.zones,
            collected = collected,
            icon = icon,
        })
    end

    -- === Pets ===
    local petCount, petTotal = 0, #ns.AchievementData.PETS
    for _, p in ipairs(ns.AchievementData.PETS) do
        if ns.IsPetCollected(p.speciesID) then petCount = petCount + 1 end
    end
    table.insert(items, {
        type = "header",
        text = "Fishing Pets",
        progress = format("%d/%d", petCount, petTotal),
    })
    for _, p in ipairs(ns.AchievementData.PETS) do
        table.insert(items, {
            type = "pet",
            name = p.name,
            source = p.source,
            collected = ns.IsPetCollected(p.speciesID),
            icon = ns.GetPetIcon(p.speciesID, p.itemID),
        })
    end

    -- === Toys ===
    local toyCount, toyTotal = 0, #ns.AchievementData.TOYS
    for _, t in ipairs(ns.AchievementData.TOYS) do
        if ns.IsToyCollected(t.itemID) then toyCount = toyCount + 1 end
    end
    table.insert(items, {
        type = "header",
        text = "Fishing Toys",
        progress = format("%d/%d", toyCount, toyTotal),
    })
    for _, t in ipairs(ns.AchievementData.TOYS) do
        table.insert(items, {
            type = "toy",
            name = t.name,
            itemID = t.itemID,
            source = t.source,
            collected = ns.IsToyCollected(t.itemID),
        })
    end

    -- === Expansion Achievements ===
    table.insert(items, { type = "header", text = "Expansion Fishing Achievements" })
    AddCategoryAchievements(items, "expansion", true)

    -- === Draenor Zone Anglers ===
    local drDone, drTotal = CountCategory("draenor_zone")
    table.insert(items, {
        type = "header",
        text = "Draenor Zone Anglers",
        progress = format("%d/%d", drDone, drTotal),
    })
    AddCategoryAchievements(items, "draenor_zone")

    -- === Fishing Dailies ===
    local dailyDone, dailyTotal = CountCategory("daily")
    table.insert(items, {
        type = "header",
        text = "Fishing Daily Quests",
        progress = format("%d/%d", dailyDone, dailyTotal),
    })
    AddCategoryAchievements(items, "daily")

    -- === Dalaran Fountain Coins ===
    local coinDone, coinTotal = CountCategory("fountain")
    table.insert(items, {
        type = "header",
        text = "Dalaran Fountain Coins",
        progress = format("%d/%d", coinDone, coinTotal),
    })
    AddCategoryAchievements(items, "fountain")

    -- === Skill Ranks ===
    local skillDone, skillTotal = CountCategory("skill")
    table.insert(items, {
        type = "header",
        text = "Fishing Skill Ranks",
        progress = format("%d/%d", skillDone, skillTotal),
    })
    AddCategoryAchievements(items, "skill")

    -- === Fish Count Milestones ===
    local catchDone, catchTotal = CountCategory("catch_count")
    table.insert(items, {
        type = "header",
        text = "Fish Count Milestones",
        progress = format("%d/%d", catchDone, catchTotal),
    })
    AddCategoryAchievements(items, "catch_count")

    -- === Underlight Angler ===
    table.insert(items, { type = "header", text = "Underlight Angler (Legion)" })
    table.insert(items, {
        type = "achievement",
        name = "Bigger Fish to Fry (Prerequisite)",
        achievementID = ns.AchievementData.UNDERLIGHT_ANGLER.achievementID,
        completed = ns.IsAchievementCompleted(ns.AchievementData.UNDERLIGHT_ANGLER.achievementID),
    })
    for _, quest in ipairs(ns.AchievementData.UNDERLIGHT_ANGLER.questline) do
        table.insert(items, {
            type = "quest",
            name = quest.name,
            description = quest.description,
            completed = ns.IsQuestCompleted(quest.questID),
        })
    end
    table.insert(items, { type = "info", text = "Traits:" })
    for _, trait in ipairs(ns.AchievementData.UNDERLIGHT_ANGLER.traits) do
        table.insert(items, {
            type = "info",
            text = format("  %s — %s", trait.name, trait.description),
        })
    end

    -- === Garrison Fishing Shack ===
    table.insert(items, { type = "header", text = "Garrison Fishing Shack (WoD)" })
    for _, bldg in ipairs(ns.AchievementData.GARRISON_FISHING.building) do
        table.insert(items, {
            type = "info",
            text = format("Level %d: %s", bldg.level, bldg.description),
        })
    end

    -- === Anglers ===
    table.insert(items, { type = "header", text = "The Anglers (MoP)" })
    table.insert(items, { type = "info", text = "Friendship rewards from Nat Pagle:" })
    for _, item in ipairs(ns.AchievementData.ANGLERS.friendshipItems) do
        table.insert(items, {
            type = "toy",
            name = item.name,
            itemID = item.itemID,
            source = format("Requires: %s", item.repRequired),
            collected = ns.IsToyCollected(item.itemID),
        })
    end

    return items
end

function CollectionView:Refresh()
    if not view then return end

    -- Save scroll position before rebuilding
    local scrollPct = view.scrollBox:GetScrollPercentage() or 0

    local data = BuildCollectionData()

    -- Apply search filter: keep items that match, and headers that have matching children
    if filterText and filterText ~= "" then
        local filtered = {}
        for i, entry in ipairs(data) do
            if entry.type == "header" then
                -- Scan ahead: keep header if any non-header child matches
                local hasMatch = false
                for j = i + 1, #data do
                    if data[j].type == "header" then break end
                    if MatchesFilter(data[j].name or data[j].text, filterText) then
                        hasMatch = true
                        break
                    end
                end
                if hasMatch then
                    table.insert(filtered, entry)
                end
            else
                if MatchesFilter(entry.name or entry.text, filterText) then
                    table.insert(filtered, entry)
                end
            end
        end
        data = filtered
    end

    local dp = view.dataProvider
    dp:Flush()
    for _, entry in ipairs(data) do
        dp:Insert(entry)
    end
    isPopulated = true

    -- Restore scroll position after rebuild
    C_Timer.After(0, function()
        if view and view.scrollBox then
            view.scrollBox:SetScrollPercentage(scrollPct)
        end
    end)
end

function CollectionView:SetFilter(text)
    filterText = (text and text ~= "") and text or nil
    if isPopulated then
        self:Refresh()
    end
end

function CollectionView:Show()
    if self.frame then
        self.frame:Show()
        if not isPopulated then
            self:Refresh()
        end
    end
end

function CollectionView:Hide()
    if self.frame then self.frame:Hide() end
end
