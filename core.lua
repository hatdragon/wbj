local wbjName, WBJ = ...
local L = WBJ.L

-- setup Binding Header color
_G.BINDING_HEADER_WBJ2UI = GetAddOnMetadata(..., "Title")

if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
    DEFAULT_CHAT_FRAME:AddMessage("|cffffedbaWBJ UI:|r You have installed WBJ retail version. We don't currently support classic. Thar may be dragons here.")
    return
end


local function LoadSlashCommands()
    _G["SLASH_WBJSLASH1"] = "/wbj"

    SlashCmdList["WBJSLASH"] = function(msg)
        if msg == "" then
            DEFAULT_CHAT_FRAME:AddMessage("|cffffedbaWBJ UI:|r Slash commands:")
            DEFAULT_CHAT_FRAME:AddMessage("|cffffedbaWBJ UI:|r   /wbj show           -> To open the the journal")
            DEFAULT_CHAT_FRAME:AddMessage("|cffffedbaWBJ UI:|r   /wbj settings       -> To open the settings window")
            DEFAULT_CHAT_FRAME:AddMessage("|cffffedbaWBJ UI:|r   /wbj reset profile  -> To reset the current profile to default settings")
        elseif msg == "show" then
           -- local WbjBookFrame = CreateFrame("FRAME", "WeatherBeatenJournal", UIParent, "PortraitFrameTemplate");

            ShowUIPanel(WeatherBeatenJournal)
            -- WeatherBeatenJournal:Show()
            --UIFrameFadeIn(WbjBookFrame, 0.2, 0, 1)
        elseif msg == "settings" then
            ShowUIPanel(WbjSettingsFrame)
            UIFrameFadeIn(WbjSettingsFrame, 0.2, 0, 1)
        elseif msg == "reset profile" then
             --   GW.WarningPrompt(
             --       GW.L["Are you sure you want to load the default settings?\n\nAll previous settings will be lost."],
             --       function()
             --           GW.ResetToDefault()
             --           C_UI.Reload()
             --       end
             --   )
        else
            DEFAULT_CHAT_FRAME:AddMessage("|cffffedbaWBJ UI:|r \"" .. msg .. "\" is not a valid WBJ UI slash command.")
        end
    end
end
WBJ.LoadSlashCommands = LoadSlashCommands





WBJ.LoadSlashCommands()