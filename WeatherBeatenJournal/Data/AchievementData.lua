local _, ns = ...

-------------------------------------------------------------------------------
-- AchievementData — Fishing achievements, collectibles, special content
-------------------------------------------------------------------------------
local AchievementData = {}
ns.AchievementData = AchievementData

-------------------------------------------------------------------------------
-- Achievement IDs
-------------------------------------------------------------------------------
AchievementData.ACHIEVEMENTS = {
    -- ================================================================
    -- "Salty" meta-achievement
    -- ================================================================
    {
        id = 1516,
        name = "Accomplished Angler",
        description = 'Complete the fishing achievements listed below. Rewards the "Salty" title.',
        isMeta = true,
        category = "meta",
    },

    -- Sub-achievements for Accomplished Angler
    { id = 878,  name = "The Oceanographer",              description = "Catch every type of ocean fish.", category = "salty" },
    { id = 879,  name = "The Limnologist",                description = "Catch every type of lake and river fish.", category = "salty" },
    { id = 1257, name = "The One That Didn't Get Away",   description = "Catch one of the rare fish in the list.", category = "salty" },
    { id = 1258, name = "The Fishing Diplomat",           description = "Fish in Orgrimmar and Stormwind.", category = "salty" },
    { id = 1836, name = "Old Crafty",                     description = "Fish up Old Crafty from Orgrimmar.", category = "salty" },
    { id = 1837, name = "Old Ironjaw",                    description = "Fish up Old Ironjaw from Ironforge.", category = "salty" },
    { id = 905,  name = "Old Man Barlowned",              description = "Complete each of Old Man Barlo's fishing daily quests.", category = "salty" },
    { id = 144,  name = "The Lurker Above",               description = "Fish up The Lurker Below in Serpentshrine Cavern.", category = "salty" },
    { id = 726,  name = "Mr. Pinchy's Magical Crawdad Box", description = "Fish up Mr. Pinchy in Terokkar Forest and grant a wish.", category = "salty" },
    { id = 1243, name = "Fish Don't Leave Footprints",    description = "Learn the Find Fish ability.", category = "salty" },
    { id = 130,  name = "Grand Master Fisherman",         description = "Reach 450 fishing skill.", category = "salty" },
    { id = 306,  name = "Master Angler of Azeroth",       description = "Win the Stranglethorn Fishing Extravaganza.", category = "salty" },

    -- ================================================================
    -- Skill Rank Achievements
    -- ================================================================
    { id = 126,   name = "Journeyman Fisherman",          description = "Become a Journeyman Fisherman.", category = "skill" },
    { id = 127,   name = "Expert Fisherman",              description = "Become an Expert Fisherman.", category = "skill" },
    { id = 128,   name = "Artisan Fisherman",             description = "Become an Artisan Fisherman.", category = "skill" },
    { id = 129,   name = "Outland Fisherman",             description = "Become an Outland Fisherman.", category = "skill" },
    { id = 4917,  name = "Cataclysmic Fisherman",         description = "Become a Cataclysm Fisherman.", category = "skill" },
    { id = 6839,  name = "Zen Master Fisherman",          description = "Become a Zen Master Fisherman.", category = "skill" },
    { id = 9503,  name = "Draenor Fisherman",             description = "Become a Draenor Fisherman.", category = "skill" },
    { id = 10594, name = "Legion Fisherman",              description = "Become a Legion Fisherman.", category = "skill" },
    { id = 12753, name = "Kul Tiran Fisherman",           description = "Become a Kul Tiran Fisherman.", category = "skill" },
    { id = 12754, name = "Zandalari Fisherman",           description = "Become a Zandalari Fisherman.", category = "skill" },

    -- ================================================================
    -- Fish Count Milestones
    -- ================================================================
    { id = 1556, name = "25 Fish",                        description = "Catch 25 fish.", category = "catch_count" },
    { id = 1557, name = "50 Fish",                        description = "Catch 50 fish.", category = "catch_count" },
    { id = 1558, name = "100 Fish",                       description = "Catch 100 fish.", category = "catch_count" },
    { id = 1559, name = "250 Fish",                       description = "Catch 250 fish.", category = "catch_count" },
    { id = 1560, name = "500 Fish",                       description = "Catch 500 fish.", category = "catch_count" },
    { id = 1561, name = "1000 Fish",                      description = "Catch 1000 fish.", category = "catch_count" },

    -- ================================================================
    -- Fishing Daily Quests
    -- ================================================================
    { id = 5476,  name = "Fish or Cut Bait: Stormwind",   description = "Complete the Stormwind fishing daily.", category = "daily" },
    { id = 5477,  name = "Fish or Cut Bait: Orgrimmar",   description = "Complete the Orgrimmar fishing daily.", category = "daily" },
    { id = 5847,  name = "Fish or Cut Bait: Ironforge",   description = "Complete the Ironforge fishing daily.", category = "daily" },
    { id = 5848,  name = "Fish or Cut Bait: Darnassus",   description = "Complete the Darnassus fishing daily.", category = "daily" },
    { id = 5849,  name = "Fish or Cut Bait: Thunder Bluff", description = "Complete the Thunder Bluff fishing daily.", category = "daily" },
    { id = 5850,  name = "Fish or Cut Bait: Undercity",   description = "Complete the Undercity fishing daily.", category = "daily" },
    { id = 3217,  name = "Chasing Marcia",                description = "Complete each of Marcia Chase's fishing daily quests.", category = "daily" },
    { id = 7614,  name = "Locking Down the Docks",        description = "Complete the Anglers fishing dailies in Pandaria.", category = "daily" },
    { id = 10598, name = "Fishing 'Round the Isles",      description = "Complete the Legion fishing world quests.", category = "daily" },

    -- ================================================================
    -- Dalaran Fountain Coins
    -- ================================================================
    { id = 2094,  name = "A Penny For Your Thoughts",     description = "Fish up all copper coins from the Dalaran fountain.", category = "fountain" },
    { id = 2095,  name = "Silver in the City",            description = "Fish up all silver coins from the Dalaran fountain.", category = "fountain" },
    { id = 1957,  name = "There's Gold In That There Fountain", description = "Fish up all gold coins from the Dalaran fountain.", category = "fountain" },
    { id = 2096,  name = "The Coin Master",               description = "Complete the copper, silver, and gold coin achievements.", category = "fountain" },

    -- ================================================================
    -- Rare Catches & Mounts
    -- ================================================================
    { id = 1958,  name = "I Smell A Giant Rat",           description = "Fish up the Giant Sewer Rat from the Dalaran sewers.", category = "rare" },
    { id = 3218,  name = "Turtles All the Way Down",      description = "Fish up the Sea Turtle mount.", category = "rare" },
    { id = 12990, name = "Catchin' Some Rays",            description = "Fish up the Great Sea Ray mount.", category = "rare" },

    -- ================================================================
    -- Expansion Achievements — Cataclysm
    -- ================================================================
    { id = 5478,  name = "The Limnologist",               description = "Catch 42 different freshwater fish.", category = "expansion", expansion = "Cataclysm" },
    { id = 5479,  name = "The Oceanographer",             description = "Catch 42 different saltwater fish.", category = "expansion", expansion = "Cataclysm" },

    -- ================================================================
    -- Expansion Achievements — MoP
    -- ================================================================
    { id = 7611,  name = "Pandaren Angler",               description = "Catch all Pandaria native fish types.", category = "expansion", expansion = "MoP" },
    { id = 7274,  name = "Learning from the Best",        description = "Become best friends with Nat Pagle.", category = "expansion", expansion = "MoP" },

    -- ================================================================
    -- Expansion Achievements — WoD (Draenor zone anglers)
    -- ================================================================
    { id = 9462,  name = "Draenor Angler",                description = "Complete all Draenor zone angler achievements.", category = "expansion", expansion = "WoD" },
    { id = 9455,  name = "Fire Ammonite Angler",          description = "Catch 100 enormous Fire Ammonite in Frostfire Ridge.", category = "draenor_zone", expansion = "WoD" },
    { id = 9456,  name = "Abyssal Gulper Eel Angler",     description = "Catch 100 enormous Abyssal Gulper Eel in Spires of Arak.", category = "draenor_zone", expansion = "WoD" },
    { id = 9457,  name = "Blackwater Whiptail Angler",    description = "Catch 100 enormous Blackwater Whiptail in Talador.", category = "draenor_zone", expansion = "WoD" },
    { id = 9458,  name = "Blind Lake Sturgeon Angler",    description = "Catch 100 enormous Blind Lake Sturgeon in Shadowmoon Valley.", category = "draenor_zone", expansion = "WoD" },
    { id = 9459,  name = "Fat Sleeper Angler",            description = "Catch 100 enormous Fat Sleeper in Nagrand.", category = "draenor_zone", expansion = "WoD" },
    { id = 9460,  name = "Jawless Skulker Angler",        description = "Catch 100 enormous Jawless Skulker in Gorgrond.", category = "draenor_zone", expansion = "WoD" },
    { id = 9461,  name = "Sea Scorpion Angler",           description = "Catch 100 enormous Sea Scorpion in coastal waters.", category = "draenor_zone", expansion = "WoD" },

    -- ================================================================
    -- Expansion Achievements — Legion
    -- ================================================================
    { id = 10596, name = "Bigger Fish to Fry",            description = "Catch all 18 rare Broken Isles fish.", category = "expansion", expansion = "Legion" },
    { id = 10595, name = "A Cast Above the Rest",         description = "Catch rare fish in the Broken Isles.", category = "expansion", expansion = "Legion" },
    { id = 10597, name = "Legion Aquaculture",            description = "Catch 100 of each type of Legion fish.", category = "expansion", expansion = "Legion" },
    { id = 10722, name = "The Wish Remover",              description = "Fish up the Underlight Emerald from the Dalaran fountain.", category = "expansion", expansion = "Legion" },
    { id = 11725, name = "Fisherfriend of the Isles",     description = "Earn Best Friend status with all Broken Isles fishing NPCs.", category = "expansion", expansion = "Legion" },

    -- ================================================================
    -- Expansion Achievements — BFA
    -- ================================================================
    { id = 12756, name = "Fish Me In the Moonlight",      description = "Catch Midnight Salmon during nighttime.", category = "expansion", expansion = "BFA" },
    { id = 12757, name = "Angling for Battle",            description = "Catch 100 fish in Kul Tiras or Zandalar.", category = "expansion", expansion = "BFA" },
    { id = 12755, name = "Scent of the Sea",              description = "Convert 100 fish to Aromatic Fish Oil.", category = "expansion", expansion = "BFA" },
    { id = 13489, name = "Secret Fish of Mechagon",       description = "Catch and deliver all secret fish of Mechagon to Danielle Anglers.", category = "expansion", expansion = "BFA" },
    { id = 13502, name = "Secret Fish and Where to Find Them", description = "Use the Secret Fish Goggles to collect all the secret fish.", category = "expansion", expansion = "BFA" },

    -- ================================================================
    -- Expansion Achievements — Dragonflight
    -- ================================================================
    { id = 16553, name = "Working Smarter, Not Harder",   description = "Catch 100 fish using Iskaara Tuskarr techniques.", category = "expansion", expansion = "Dragonflight" },
    { id = 16561, name = "Lunkers, Lunkers Everywhere",   description = "Catch lunkers in each Dragon Isles zone.", category = "expansion", expansion = "Dragonflight" },
    { id = 15889, name = "River Rapids Wrangler",         description = "Successfully navigate the river rapids.", category = "expansion", expansion = "Dragonflight" },

    -- ================================================================
    -- Miscellaneous
    -- ================================================================
    { id = 153,   name = "The Old Gnome and the Sea",     description = "Successfully catch fish from fishing pools.", category = "misc" },
    { id = 1225,  name = "Outland Angler",                description = "Catch from six Outland-specific fishing pools.", category = "misc" },
    { id = 1517,  name = "Northrend Angler",              description = "Catch from ten Northrend-specific fishing pools.", category = "misc" },
    { id = 9547,  name = "Everything Is Awesome!",        description = "Throw 20 Awesomefish items.", category = "misc" },
}

-------------------------------------------------------------------------------
-- Fishing Mounts
-------------------------------------------------------------------------------
AchievementData.MOUNTS = {
    {
        itemID = 46109,
        name = "Sea Turtle",
        spellID = 64731,
        source = "Rare catch from any Northrend+ fishing pool",
        zones = "Northrend, Cataclysm, Pandaria, Draenor pools",
        expansion = "WotLK",
    },
    {
        itemID = 81354,
        name = "Reins of the Azure Water Strider",
        spellID = 118089,
        source = "The Anglers — Exalted",
        zones = "Krasarang Wilds (Anglers Wharf)",
        expansion = "MoP",
    },
    {
        itemID = 87791,
        name = "Reins of the Crimson Water Strider",
        spellID = 127271,
        source = "Nat Pagle — Best Friend (MoP)",
        zones = "Krasarang Wilds (Anglers Wharf)",
        expansion = "MoP",
    },
    {
        itemID = 142398,
        name = "Darkwater Skate",
        spellID = 228919,
        source = "Conjurer Margoss — Best Friend",
        zones = "Dalaran (Broken Isles) Underbelly",
        expansion = "Legion",
    },
    {
        itemID = 138811,
        name = "Brinedeep Bottom-Feeder",
        spellID = 214791,
        source = "Fisherfriend of the Isles — Best Friend with any NPC",
        zones = "Broken Isles coastal waters",
        expansion = "Legion",
    },
    {
        itemID = 163131,
        name = "Great Sea Ray",
        spellID = 278803,
        source = "Rare catch from BFA coastal zones",
        zones = "Kul Tiras and Zandalar coastal waters",
        expansion = "BFA",
    },
    {
        itemID = 169194,
        name = "Snapback Scuttler",
        spellID = 300153,
        source = "Rare catch from crab pots in Mechagon and Nazjatar",
        zones = "Mechagon, Nazjatar",
        expansion = "BFA",
    },
    {
        itemID = 187872,
        name = "Pond Nettle",
        spellID = 370770,
        source = "Fishing in Zereth Mortis",
        zones = "Zereth Mortis pools",
        expansion = "Shadowlands",
    },
}

-------------------------------------------------------------------------------
-- Fishing Pets
-------------------------------------------------------------------------------
AchievementData.PETS = {
    {
        itemID = 27445,
        name = "Magical Crawdad",
        speciesID = 174,
        source = "Mr. Pinchy wish (Terokkar Forest highland mixed schools)",
        expansion = "TBC",
    },
    {
        itemID = 43698,
        name = "Giant Sewer Rat",
        speciesID = 172,
        source = "Fished from Dalaran sewers (Northrend)",
        expansion = "WotLK",
    },
    {
        itemID = 35348,
        name = "Chuck",
        speciesID = 179,
        source = "Fishing daily reward bag (Shattrath)",
        expansion = "TBC",
    },
    {
        itemID = 35349,
        name = "Muckbreath",
        speciesID = 175,
        source = "Fishing daily reward bag (Shattrath)",
        expansion = "TBC",
    },
    {
        itemID = 33818,
        name = "Toothy",
        speciesID = 176,
        source = "Fishing daily reward bag (Shattrath)",
        expansion = "TBC",
    },
    {
        itemID = 35350,
        name = "Snarly",
        speciesID = 177,
        source = "Fishing daily reward bag (Shattrath)",
        expansion = "TBC",
    },
    {
        itemID = 44983,
        name = "Strand Crawler",
        speciesID = 171,
        source = "Fishing daily reward bag (Dalaran)",
        expansion = "WotLK",
    },
    {
        itemID = 94932,
        name = "Tiny Red Carp",
        speciesID = 1173,
        source = "Rare catch from Townlong Steppes / Dread Wastes",
        expansion = "MoP",
    },
    {
        itemID = 94933,
        name = "Tiny Blue Carp",
        speciesID = 1174,
        source = "Rare catch from Vale of Eternal Blossoms",
        expansion = "MoP",
    },
    {
        itemID = 94934,
        name = "Tiny Green Carp",
        speciesID = 1175,
        source = "Rare catch from Jade Forest / Valley of Four Winds / Krasarang Wilds",
        expansion = "MoP",
    },
    {
        itemID = 94935,
        name = "Tiny White Carp",
        speciesID = 1176,
        source = "Rare catch from Kun-Lai Summit",
        expansion = "MoP",
    },
    {
        itemID = 117404,
        name = "Land Shark",
        speciesID = 1598,
        source = "Nat Pagle — Garrison Fishing Shack (Nat's Lucky Coins)",
        expansion = "WoD",
    },
    {
        itemID = 114919,
        name = "Sea Calf",
        speciesID = 1585,
        source = "Nat Pagle — Garrison Fishing Shack (Nat's Lucky Coins)",
        expansion = "WoD",
    },
}

-------------------------------------------------------------------------------
-- Fishing Toys
-------------------------------------------------------------------------------
AchievementData.TOYS = {
    {
        itemID = 88535,
        name = "Nat's Fishing Chair",
        source = "Nat Pagle — Best Friend (MoP Anglers)",
        expansion = "MoP",
    },
    {
        itemID = 33461,
        name = "Weathered Fishing Hat",
        source = "Fishing daily reward bags",
        expansion = "TBC",
    },
    {
        itemID = 119215,
        name = "Ethereal Fishing Line",
        source = "Nat Pagle — Garrison Fishing Shack",
        expansion = "WoD",
    },
    {
        itemID = 86596,
        name = "Nat's Hat",
        source = "Nat Pagle — Best Friend (MoP Anglers)",
        expansion = "MoP",
    },
    {
        itemID = 85500,
        name = "Anglers Fishing Raft",
        source = "The Anglers — Revered",
        expansion = "MoP",
    },
    {
        itemID = 152556,
        name = "Trawler Totem",
        source = "Fishing from pools in Kul Tiras and Zandalar",
        expansion = "BFA",
    },
}

-------------------------------------------------------------------------------
-- Underlight Angler (Legion Artifact Fishing Pole)
-------------------------------------------------------------------------------
AchievementData.UNDERLIGHT_ANGLER = {
    questline = {
        { questID = 40960, name = "Luminous Pearl",           description = "Obtain the Luminous Pearl from rare Broken Isles fish" },
        { questID = 40961, name = "The Dalaran Fountain",     description = "Bring the pearl to the Dalaran fountain" },
        { questID = 41010, name = "Fish Frenzy",              description = "Complete the Fish Frenzy scenario" },
    },
    itemID = 133755,
    achievementID = 10596,  -- Bigger Fish to Fry (prerequisite)
    traits = {
        { name = "Undercurrent",          description = "Chance to swim faster while fishing" },
        { name = "Better Lucky Than Good", description = "Chance to find rare fish" },
        { name = "Wish Upon a Fish",       description = "Chance to catch additional fish" },
        { name = "Ancient Vrykul Ring",    description = "Stormheim rare catch chance" },
        { name = "Ghostly Queenfish Brooch", description = "Azsuna rare catch chance" },
    },
}

-------------------------------------------------------------------------------
-- Garrison Fishing Shack (WoD)
-------------------------------------------------------------------------------
AchievementData.GARRISON_FISHING = {
    building = {
        { level = 1, description = "Allows small catch of fish from Garrison waters" },
        { level = 2, description = "Allows follower: Nat Pagle. Access to Lunker turn-ins" },
        { level = 3, description = "Unlocks special daily fish and Nat's Lucky Coins" },
    },
    currencies = {
        { name = "Nat's Lucky Coin", itemID = 117397, description = "Currency for Nat Pagle rewards in Garrison" },
    },
}

-------------------------------------------------------------------------------
-- Anglers Reputation (MoP)
-------------------------------------------------------------------------------
AchievementData.ANGLERS = {
    factionID = 1302,
    name = "The Anglers",
    friendshipItems = {
        { itemID = 86596, name = "Nat's Hat",           repRequired = "Best Friend" },
        { itemID = 88535, name = "Nat's Fishing Chair", repRequired = "Best Friend" },
    },
}

-------------------------------------------------------------------------------
-- Helpers
-------------------------------------------------------------------------------
function ns.IsAchievementCompleted(achievementID)
    local _, _, _, completed = GetAchievementInfo(achievementID)
    return completed
end

function ns.IsMountCollected(spellID)
    for _, mountID in ipairs(C_MountJournal.GetMountIDs()) do
        local name, mSpellID, icon, _, _, _, _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(mountID)
        if mSpellID == spellID then
            return isCollected, icon
        end
    end
    return false, nil
end

function ns.IsPetCollected(speciesID)
    if not speciesID then return false end
    local numCollected = C_PetJournal.GetNumCollectedInfo(speciesID)
    return numCollected and numCollected > 0
end

function ns.GetPetIcon(speciesID, itemID)
    if speciesID then
        local _, icon = C_PetJournal.GetPetInfoBySpeciesID(speciesID)
        if icon and icon ~= 0 then return icon end
    end
    -- Fallback: use the item icon
    if itemID then
        local _, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemID)
        if icon then return icon end
    end
    return nil
end

function ns.IsToyCollected(itemID)
    return PlayerHasToy(itemID)
end

function ns.IsQuestCompleted(questID)
    return C_QuestLog.IsQuestFlaggedCompleted(questID)
end
