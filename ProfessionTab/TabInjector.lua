local _, ns = ...

-------------------------------------------------------------------------------
-- TabInjector — hooks Blizzard_Professions to add a Journal tab for Fishing
--
-- AddNamedTab registers the page with the internal tab tracker, which
-- automatically shows/hides it on tab switch. We only need hooks for:
--   1. UpdateTabs — show/hide our tab BUTTON based on fishing profession
--   2. SetTab     — trigger our content refresh when tab is selected
-------------------------------------------------------------------------------
local TabInjector = {}
ns.TabInjector = TabInjector

local journalTabID = nil
local injected = false

-- Blizzard's specializations page calls C_Traits.StageConfig(configID) on hide,
-- which errors when configID is nil (fishing has no specialization tree).
-- Wrap SetTab in pcall so the tab switch completes despite the Blizzard error.
local function SafeSetTab(frame, tabID)
    pcall(frame.SetTab, frame, tabID)
end

local function IsFishingProfession()
    local frame = ProfessionsFrame
    if not frame then return false end

    local profInfo = frame.professionInfo
    if profInfo and profInfo.profession == ns.FISHING_PROFESSION then
        return true
    end

    -- Fallback: check via the skill line
    if profInfo and profInfo.professionID then
        for _, id in ipairs(ns.FISHING_VARIANT_SKILL_LINES) do
            if profInfo.professionID == id then
                return true
            end
        end
        if profInfo.professionID == ns.FISHING_SKILL_LINE then
            return true
        end
    end

    return false
end

local function InjectTab()
    if injected then return end
    injected = true

    local frame = ProfessionsFrame
    if not frame then return end

    -- Create the journal page
    local page = ns.JournalPage:Create(frame)

    -- AddNamedTab registers the page so the tab system auto-shows/hides it.
    -- Signature: AddNamedTab(tabName, page, ...) -> tabID
    journalTabID = frame:AddNamedTab("Weather-Beaten", page)

    -- Hook UpdateTabs: show/hide our tab BUTTON based on fishing detection.
    -- If we're leaving fishing while on the Journal tab, switch to Recipes.
    hooksecurefunc(frame, "UpdateTabs", function(self)
        if not journalTabID then return end

        local isFishing = IsFishingProfession()
        self.TabSystem:SetTabShown(journalTabID, isFishing)

        -- If switching away from fishing while on Journal tab, go to Recipes
        if not isFishing and self:GetTab() == journalTabID then
            local recipesTabID = self.recipesTabID or 1
            SafeSetTab(self, recipesTabID)
        end
    end)

    -- NOTE: Refresh is triggered by the page's OnShow script (in JournalPage.lua)
    -- with a small delay to let the ProfessionsFrame finish sizing the page.
    -- No SetTab hook needed — the tab system shows/hides the page automatically.
end

-- Wait for Blizzard_Professions to load, then inject
EventUtil.ContinueOnAddOnLoaded("Blizzard_Professions", InjectTab)
