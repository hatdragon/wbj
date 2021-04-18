local wbjName, WBJ = ...;
local L = WBJ.L;

local credits = {};
local isDebug = true;

--analogous color palette
local wbjTitleColor = "0093E9BE";
local wbjMessageColor = "0093BEE9";
local wbjDebugColor = "00A9E993";

_G.BINDING_HEADER_WBJ2UI = GetAddOnMetadata(..., "Title")

if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
    DEFAULT_CHAT_FRAME:AddMessage("|c" .. wbjTitleColor .. " WBJ UI:|r You have installed WBJ retail version. We don't currently support classic. Thar may be dragons here.")
    return
end

local function log(msg) 
    if msg == "" then
        return;
    else
        DEFAULT_CHAT_FRAME:AddMessage("|c" .. wbjTitleColor .. " WBJ UI:|r " .. msg)
    end
end
WBJ.Log = log;

local function message(msg) 
    if msg == "" then
        return;
    else
        DEFAULT_CHAT_FRAME:AddMessage("|c" .. wbjMessageColor .. " WBJ UI:|r " .. msg)
    end
end
WBJ.Message = message;

local function debug(msg) 
    if msg == "" or not isDebug then
        return;
    else
        DEFAULT_CHAT_FRAME:AddMessage("|c" .. wbjDebugColor .. "  WBJ DEBUG:|r " .. msg)
    end
end
WBJ.Debug = debug;


local function LoadSlashCommands()
    WBJ.Debug("Loading AddOn Slash Commands.");

    _G["SLASH_WBJSLASH1"] = "/wbj"

    SlashCmdList["WBJSLASH"] = function(msg)
        if msg == "" then
            
            ToggleEncounterJournal();
            local wbjFishingTab = CreateFrame("FRAME", "wbjFishingTab", EncounterJournal);
            EncounterJournal.FishingTab = wbjFishingTab;

        elseif msg == "settings" then
            ShowUIPanel(WbjSettingsFrame);
            UIFrameFadeIn(WbjSettingsFrame, 0.2, 0, 1);

        elseif msg == "reset profile" then

        else
            WBJ.Log("Slash commands:");
            WBJ.Log(" /wbj                -> To open the the journal");
            WBJ.Log(" /wbj settings       -> To open the settings window");
            WBJ.Log(" /wbj reset profile  -> To reset the current profile to default settings");
        end
    end
    WBJ.Debug("Finished Loading AddOn Slash Commands.");
end
WBJ.LoadSlashCommands = LoadSlashCommands;

local function ContentTab_OnClick(self) 
    WBJ.Debug("Content Tab onclick");

    EJ_HideSuggestPanel();
    EJ_HideNonInstancePanels();
    EJ_HideInstances();
    EJ_HideLootJournalPanel();
    EncounterJournal_DisableTierDropDown(true);

end
WBJ.ContentTab_OnClick = ContentTab_OnClick



WBJ.LoadSlashCommands()