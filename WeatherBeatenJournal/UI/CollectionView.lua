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
            -- Reusable row setup — use Button for clickable rows
            row:EnableMouse(true)

            row.icon = row:CreateTexture(nil, "ARTWORK")
            row.icon:SetSize(22, 22)
            row.icon:SetPoint("LEFT", 4, 0)

            row.label = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            row.label:SetPoint("LEFT", row.icon, "RIGHT", 6, 0)
            row.label:SetPoint("RIGHT", -98, 0)
            row.label:SetJustifyH("LEFT")
            row.label:SetWordWrap(false)

            row.status = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            row.status:SetPoint("RIGHT", -4, 0)
            row.status:SetWidth(90)
            row.status:SetJustifyH("RIGHT")
            row.status:SetWordWrap(false)

            row.factionIcon = row:CreateTexture(nil, "OVERLAY")
            row.factionIcon:SetSize(16, 16)
            row.factionIcon:SetPoint("RIGHT", row.status, "LEFT", -4, 0)
            row.factionIcon:Hide()

            row.hl = row:CreateTexture(nil, "HIGHLIGHT")
            row.hl:SetAllPoints()
            row.hl:SetColorTexture(ns.COLORS.HIGHLIGHT:GetRGBA())

            row.isInitialized = true
        end

        -- Render based on data type
        -- Clear click handler (may be stale from recycled achievement row)
        row:SetScript("OnMouseUp", nil)
        row.factionIcon:Hide()

        -- Reset status width (may have been widened by rarefish row)
        row.status:SetWidth(90)
        row.label:SetPoint("RIGHT", -98, 0)

        if data.type == "header" then
            row.icon:Hide()
            row.label:SetPoint("LEFT", 4, 0)
            row.label:SetFont(ns.HEADER_FONT, 14, "")
            row.label:SetTextColor(ns.COLORS.HEADER_TEXT:GetRGBA())
            row.label:SetText(data.text)
            row.status:SetText(data.progress or "")
            row.status:SetTextColor(ns.COLORS.HEADER_TEXT:GetRGBA())
            if data.achievementID then
                row.hl:Show()
                row:SetScript("OnMouseUp", function(self, button)
                    if button == "LeftButton" then
                        if not AchievementFrame then
                            C_AddOns.LoadAddOn("Blizzard_AchievementUI")
                        end
                        if AchievementFrame then
                            ShowUIPanel(AchievementFrame)
                            AchievementFrame_SelectAchievement(data.achievementID, true)
                        end
                    end
                end)
                row:SetScript("OnEnter", function(self)
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    GameTooltip:SetHyperlink(format("achievement:%d", data.achievementID))
                    GameTooltip:Show()
                end)
                row:SetScript("OnLeave", function() GameTooltip:Hide() end)
            else
                row.hl:Hide()
                row:SetScript("OnEnter", nil)
                row:SetScript("OnLeave", nil)
            end
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

            -- Faction emblem
            if data.faction == "Alliance" then
                row.factionIcon:SetAtlas("questlog-questtypeicon-alliance")
                row.factionIcon:Show()
            elseif data.faction == "Horde" then
                row.factionIcon:SetAtlas("questlog-questtypeicon-horde")
                row.factionIcon:Show()
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
            -- Click to open achievement panel
            row:SetScript("OnMouseUp", function(self, button)
                if button == "LeftButton" and data.achievementID then
                    if not AchievementFrame then
                        C_AddOns.LoadAddOn("Blizzard_AchievementUI")
                    end
                    if AchievementFrame then
                        ShowUIPanel(AchievementFrame)
                        AchievementFrame_SelectAchievement(data.achievementID, true)
                    end
                end
            end)
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
                row.status:SetText("Not Collected")
                row.status:SetTextColor(ns.COLORS.UNCAUGHT:GetRGBA())
            end

            row:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(data.name, 1, 1, 1)
                GameTooltip:AddLine(data.zones or data.source or "", 0.7, 0.7, 0.7, true)
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine("Click to preview", 0.5, 0.8, 1.0)
                GameTooltip:Show()
            end)
            row:SetScript("OnLeave", function() GameTooltip:Hide() end)
            row:SetScript("OnMouseUp", function(self, button)
                if button == "LeftButton" and data.spellID then
                    local mountID = C_MountJournal.GetMountFromSpell(data.spellID)
                    if mountID then
                        DressUpMount(mountID)
                    end
                end
            end)
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
                row.status:SetText("Not Collected")
                row.status:SetTextColor(ns.COLORS.UNCAUGHT:GetRGBA())
            end

            row:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(data.name, 1, 1, 1)
                GameTooltip:AddLine(data.source or "", 0.7, 0.7, 0.7, true)
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine("Click to preview", 0.5, 0.8, 1.0)
                GameTooltip:Show()
            end)
            row:SetScript("OnLeave", function() GameTooltip:Hide() end)
            row:SetScript("OnMouseUp", function(self, button)
                if button == "LeftButton" and data.speciesID then
                    local _, _, _, creatureID, _, _, _, _, _, _, _, displayID = C_PetJournal.GetPetInfoBySpeciesID(data.speciesID)
                    if creatureID and displayID then
                        DressUpBattlePet(creatureID, displayID, data.speciesID)
                    end
                end
            end)
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
                row.status:SetText("Not Collected")
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
        elseif data.type == "rarefish" then
            row.icon:Show()
            local icon = C_Item.GetItemIconByID(data.itemID)
            row.icon:SetTexture(icon or "Interface\\Icons\\INV_Misc_Fish_02")
            row.label:SetPoint("LEFT", row.icon, "RIGHT", 6, 0)
            row.label:SetFont("Fonts\\FRIZQT__.TTF", 11, "")
            row.label:SetText(data.name)
            row.hl:Show()
            -- Wider status column for bait names
            row.status:SetWidth(160)
            row.label:SetPoint("RIGHT", -168, 0)

            if data.caught then
                row.label:SetTextColor(ns.COLORS.CAUGHT:GetRGBA())
                row.status:SetText("Caught")
                row.status:SetTextColor(ns.COLORS.CAUGHT:GetRGBA())
            else
                row.label:SetTextColor(ns.COLORS.PARCHMENT_TEXT:GetRGBA())
                if data.baitName then
                    row.status:SetText("Use: " .. data.baitName)
                else
                    row.status:SetText("Arcane Lure")
                end
                row.status:SetTextColor(ns.COLORS.UNCAUGHT:GetRGBA())
            end

            row:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetItemByID(data.itemID)
                if not data.caught then
                    GameTooltip:AddLine(" ")
                    if data.baitName then
                        GameTooltip:AddLine("Bait: " .. data.baitName, 1, 0.82, 0)
                    else
                        GameTooltip:AddLine("Use Arcane Lure to increase catch chance", 1, 0.82, 0)
                    end
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
                faction = ach.faction,
            })
        end
    end
end

local function BuildCollectionData()
    local items = {}

    -- === Abyss Anglers (Midnight 12.0.5) ===
    local PEARLS_CURRENCY = 3373
    local pearlInfo = C_CurrencyInfo.GetCurrencyInfo(PEARLS_CURRENCY)
    local pearlCount = pearlInfo and pearlInfo.quantity or 0

    local divingDone, divingTotal = CountCategory("abyss_anglers_diving")
    local fishDone, fishTotal = CountCategory("abyss_anglers_fish")
    local creaturesDone, creaturesTotal = CountCategory("abyss_anglers_creatures")
    local relicsDone, relicsTotal = CountCategory("abyss_anglers_relics")
    local totalDone = divingDone + fishDone + creaturesDone + relicsDone
    local totalAll = divingTotal + fishTotal + creaturesTotal + relicsTotal

    table.insert(items, {
        type = "header",
        text = "Abyss Anglers (Midnight)",
        progress = format("%d/%d", totalDone, totalAll),
        achievementID = 62217,
    })

    if ns.db and ns.db.diveHistory and #ns.db.diveHistory > 0 then
        local totalDives = #ns.db.diveHistory
        local totalCatches = 0
        local bestScore = 0
        for _, dive in ipairs(ns.db.diveHistory) do
            totalCatches = totalCatches + (dive.catches or 0) + (dive.relics or 0)
            if (dive.score or 0) > bestScore then bestScore = dive.score end
        end
        table.insert(items, {
            type = "info",
            text = format("  Dives: %d  |  Catches: %d  |  Best Score: %s  |  Angler Pearls: |T348545:0|t %s",
                totalDives, totalCatches, ns.Util.FormatCount(bestScore), ns.Util.FormatCount(pearlCount)),
        })
    else
        table.insert(items, {
            type = "info",
            text = format("  Angler Pearls: |T348545:0|t %s", ns.Util.FormatCount(pearlCount)),
        })
    end

    local GEAR_UPGRADES = {
        { label = "Suit",    ids = { 62207, 62208, 62209 } },
        { label = "O2",      ids = { 62210, 62211, 62212 } },
        { label = "Harpoon", ids = { 62215, 62216 } },
        { label = "Net",     ids = { 62213, 62214 } },
        { label = "Bait",    ids = { 62117, 62118, 62119 } },
        { label = "Special", ids = { 62506 } },
    }
    local line1, line2 = {}, {}
    for i, track in ipairs(GEAR_UPGRADES) do
        local trackDone = 0
        for _, id in ipairs(track.ids) do
            if ns.IsAchievementCompleted(id) then trackDone = trackDone + 1 end
        end
        local tierText = trackDone == #track.ids and "|cff00cc00MAX|r" or format("%d/%d", trackDone, #track.ids)
        local entry = format("%s: %s", track.label, tierText)
        if i <= 3 then
            line1[#line1 + 1] = entry
        else
            line2[#line2 + 1] = entry
        end
    end
    table.insert(items, { type = "info", text = "  " .. table.concat(line1, "  |  ") })
    table.insert(items, { type = "info", text = "  " .. table.concat(line2, "  |  ") })

    -- Achievements by category
    table.insert(items, {
        type = "header",
        text = "Diving",
        progress = format("%d/%d", divingDone, divingTotal),
    })
    AddCategoryAchievements(items, "abyss_anglers_diving")

    table.insert(items, {
        type = "header",
        text = "Fish",
        progress = format("%d/%d", fishDone, fishTotal),
    })
    AddCategoryAchievements(items, "abyss_anglers_fish")

    table.insert(items, {
        type = "header",
        text = "Creatures",
        progress = format("%d/%d", creaturesDone, creaturesTotal),
    })
    AddCategoryAchievements(items, "abyss_anglers_creatures")

    table.insert(items, {
        type = "header",
        text = "Relics",
        progress = format("%d/%d", relicsDone, relicsTotal),
    })
    AddCategoryAchievements(items, "abyss_anglers_relics")

    -- Rewards
    local TUNAKIT_REWARDS = {
        { itemID = 274267, name = "Fused Vitality",               cost = 750,  checkType = "item" },
        { itemID = 258535, name = "Simple Bone-Tied Charm",       cost = 750,  checkType = "item" },
        { itemID = 258536, name = "Windmark Tribal Charm",        cost = 750,  checkType = "item" },
        { itemID = 258537, name = "Amani Dreamer's Charm",        cost = 750,  checkType = "item" },
        { itemID = 258538, name = "Barebone Rope Charm",          cost = 750,  checkType = "item" },
        { itemID = 264251, name = "Depthdiver's Cooking Spit",    cost = 1000, checkType = "toy" },
        { itemID = 264252, name = "Zul'Aman Forest Hammock",      cost = 1000, checkType = "toy" },
        { itemID = 253582, name = "Fangfin Flailer",              cost = 2250, checkType = "toy" },
        { itemID = 266969, name = "Ensemble: Depthdiver Vestments", cost = 3000, checkType = "item" },
        { itemID = 223245, name = "Ensemble: Abyss Angler",       cost = 4500, checkType = "item" },
        { itemID = 265749, name = "Idol of the Depths",           cost = 1500, checkType = "item" },
        { itemID = 274266, name = "Ka'bubb",                      cost = 2500, checkType = "pet", speciesID = 5065 },
    }
    local rewardCount = 0
    for _, r in ipairs(TUNAKIT_REWARDS) do
        local owned = false
        if r.checkType == "toy" then
            owned = PlayerHasToy(r.itemID)
        elseif r.checkType == "pet" then
            owned = ns.IsPetCollected(r.speciesID)
        else
            owned = GetItemCount(r.itemID, true) > 0
        end
        if owned then rewardCount = rewardCount + 1 end
    end
    table.insert(items, {
        type = "header",
        text = "Tu'nakit Rewards",
        progress = format("%d/%d", rewardCount, #TUNAKIT_REWARDS),
    })
    for _, r in ipairs(TUNAKIT_REWARDS) do
        local owned = false
        if r.checkType == "toy" then
            owned = PlayerHasToy(r.itemID)
        elseif r.checkType == "pet" then
            owned = ns.IsPetCollected(r.speciesID)
        else
            owned = GetItemCount(r.itemID, true) > 0
        end
        table.insert(items, {
            type = "toy",
            name = format("%s (%d pearls)", r.name, r.cost),
            itemID = r.itemID,
            collected = owned,
        })
    end
    table.insert(items, { type = "info", text = "" })

    -- === "Salty" Meta Achievement ===
    local saltyDone, saltyTotal = CountCategory("salty")
    table.insert(items, {
        type = "header",
        text = "\"Salty\" — Accomplished Angler",
        progress = format("%d/%d", saltyDone, saltyTotal),
        achievementID = 1516,
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
            spellID = m.spellID,
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
            speciesID = p.speciesID,
        })
    end

    -- === Toys ===
    local toyCount, toyTotal = 0, #ns.GearData.TOYS
    for _, t in ipairs(ns.GearData.TOYS) do
        if ns.IsToyCollected(t.itemID) then toyCount = toyCount + 1 end
    end
    table.insert(items, {
        type = "header",
        text = "Fishing Toys",
        progress = format("%d/%d", toyCount, toyTotal),
    })
    for _, t in ipairs(ns.GearData.TOYS) do
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
        text = "Draenor Angler",
        progress = format("%d/%d", drDone, drTotal),
        achievementID = 9462,
    })
    AddCategoryAchievements(items, "draenor_zone")

    -- === Fishing Dailies ===
    local dailyDone, dailyTotal = CountCategory("daily")
    table.insert(items, {
        type = "header",
        text = "Gone Fishin'",
        progress = format("%d/%d", dailyDone, dailyTotal),
        achievementID = 5851,
    })
    AddCategoryAchievements(items, "daily")

    -- === Dalaran Fountain Coins ===
    local coinDone, coinTotal = CountCategory("fountain")
    table.insert(items, {
        type = "header",
        text = "The Coin Master",
        progress = format("%d/%d", coinDone, coinTotal),
        achievementID = 2096,
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
    local ua = ns.AchievementData.UNDERLIGHT_ANGLER
    local hasPole = ns.IsQuestCompleted(41010)

    -- Count total caught rare fish
    local totalCaught = 0
    for _, zoneGroup in ipairs(ua.rareFish) do
        for _, fish in ipairs(zoneGroup.fish) do
            if ns.db and ns.db.totals and ns.db.totals[fish.itemID] then
                totalCaught = totalCaught + 1
            end
        end
    end

    table.insert(items, {
        type = "header",
        text = "Underlight Angler (Legion)",
        progress = format("%d/18", totalCaught),
        achievementID = ua.achievementID,
    })

    if hasPole then
        table.insert(items, { type = "info", text = "Obtained! You own the Underlight Angler." })
    else
        -- Achievement row
        table.insert(items, {
            type = "achievement",
            name = "Bigger Fish to Fry",
            achievementID = ua.achievementID,
            completed = ns.IsAchievementCompleted(ua.achievementID),
        })

        -- Arcane Lure tip
        table.insert(items, {
            type = "info",
            text = format("  %s — doubles rare bait chance for 10 min (%s)", ua.arcaneLure.name, ua.arcaneLure.source),
        })

        -- Tips
        for _, tip in ipairs(ua.tips) do
            table.insert(items, { type = "info", text = "  " .. tip })
        end

        -- Zone-by-zone rare fish checklist
        for _, zoneGroup in ipairs(ua.rareFish) do
            local zoneCaught = 0
            for _, fish in ipairs(zoneGroup.fish) do
                if ns.db and ns.db.totals and ns.db.totals[fish.itemID] then
                    zoneCaught = zoneCaught + 1
                end
            end
            table.insert(items, {
                type = "info",
                text = format("  %s (%d/%d)", zoneGroup.zone, zoneCaught, #zoneGroup.fish),
            })
            for _, fish in ipairs(zoneGroup.fish) do
                local caught = ns.db and ns.db.totals and ns.db.totals[fish.itemID] ~= nil
                table.insert(items, {
                    type = "rarefish",
                    name = fish.name,
                    itemID = fish.itemID,
                    baitName = fish.baitName,
                    caught = caught,
                })
            end
        end

        -- Questline
        table.insert(items, { type = "info", text = "  Questline:" })
        for _, quest in ipairs(ua.questline) do
            table.insert(items, {
                type = "quest",
                name = quest.name,
                description = quest.description,
                completed = ns.IsQuestCompleted(quest.questID),
            })
        end
    end

    -- Traits (always shown)
    table.insert(items, { type = "info", text = "  Traits:" })
    for _, trait in ipairs(ua.traits) do
        table.insert(items, {
            type = "info",
            text = format("    %s — %s", trait.name, trait.description),
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
