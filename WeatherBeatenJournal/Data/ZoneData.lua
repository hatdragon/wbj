local _, ns = ...

-------------------------------------------------------------------------------
-- ZoneData — mapID -> zone info with fish availability and narrator assignment
--
-- Format: [mapID] = {
--   name       = zone display name,
--   continent  = continent/group name,
--   expansion  = expansion tag,
--   narratorID = narrator key from ns.NARRATOR,
--   fish       = { itemID, ... },          -- available fish in this zone
--   notes      = optional flavor text,
-- }
-------------------------------------------------------------------------------
local ZoneData = {}
ns.ZoneData = ZoneData

local N = ns.NARRATOR

-------------------------------------------------------------------------------
-- Classic — Eastern Kingdoms
-------------------------------------------------------------------------------
ZoneData[37]  = { name = "Elwynn Forest",       continent = "Eastern Kingdoms", expansion = "Classic", narratorID = N.CATHERINE_LELAND,
    fish = { 6291, 6303, 6289, 6358, 6361 } }
ZoneData[52]  = { name = "Westfall",             continent = "Eastern Kingdoms", expansion = "Classic", narratorID = N.CATHERINE_LELAND,
    fish = { 6303, 6361, 6358 } }
ZoneData[84]  = { name = "Stormwind City",       continent = "Eastern Kingdoms", expansion = "Classic", narratorID = N.CATHERINE_LELAND,
    fish = { 6291, 6289, 6362, 34484 },
    notes = "Old Ironjaw lurks in the canals." }
ZoneData[49]  = { name = "Redridge Mountains",   continent = "Eastern Kingdoms", expansion = "Classic", narratorID = N.CATHERINE_LELAND,
    fish = { 6289, 6317, 6358 } }
ZoneData[47]  = { name = "Duskwood",             continent = "Eastern Kingdoms", expansion = "Classic", narratorID = N.CATHERINE_LELAND,
    fish = { 6289, 6362, 6358, 6359 } }
ZoneData[36]  = { name = "Burning Steppes",      continent = "Eastern Kingdoms", expansion = "Classic", narratorID = N.CATHERINE_LELAND,
    fish = { 13757 } }
ZoneData[50]  = { name = "Northern Stranglethorn", continent = "Eastern Kingdoms", expansion = "Classic", narratorID = N.NAT_PAGLE,
    fish = { 6358, 6359, 6361, 4603, 13754 } }
ZoneData[210] = { name = "The Cape of Stranglethorn", continent = "Eastern Kingdoms", expansion = "Classic", narratorID = N.NAT_PAGLE,
    fish = { 4603, 13754, 13755, 13756, 13757 } }
ZoneData[87]  = { name = "Ironforge",            continent = "Eastern Kingdoms", expansion = "Classic", narratorID = N.GRIMNUR_STONEBRAND,
    fish = { 6289, 6291, 6317 } }
ZoneData[48]  = { name = "Loch Modan",           continent = "Eastern Kingdoms", expansion = "Classic", narratorID = N.GRIMNUR_STONEBRAND,
    fish = { 6289, 6317, 6358 } }
ZoneData[18]  = { name = "Tirisfal Glades",      continent = "Eastern Kingdoms", expansion = "Classic", narratorID = N.ARMAND_CROMWELL,
    fish = { 6291, 6303, 6289 } }
ZoneData[90]  = { name = "Undercity",            continent = "Eastern Kingdoms", expansion = "Classic", narratorID = N.ARMAND_CROMWELL,
    fish = { 6289, 6291 } }
ZoneData[70]  = { name = "Dustwallow Marsh",     continent = "Kalimdor",         expansion = "Classic", narratorID = N.NAT_PAGLE,
    fish = { 6362, 6358, 6359, 4603 },
    notes = "Nat Pagle's home waters. Visit him on Theramore Isle." }

-------------------------------------------------------------------------------
-- Classic — Kalimdor
-------------------------------------------------------------------------------
ZoneData[1]   = { name = "Durotar",              continent = "Kalimdor", expansion = "Classic", narratorID = N.LUMAK,
    fish = { 6291, 6303, 6289 } }
ZoneData[85]  = { name = "Orgrimmar",            continent = "Kalimdor", expansion = "Classic", narratorID = N.LUMAK,
    fish = { 6291, 6289, 34486 },
    notes = "Old Crafty hides in the Valley of Honor." }
ZoneData[63]  = { name = "Ashenvale",            continent = "Kalimdor", expansion = "Classic", narratorID = N.ASTAIA,
    fish = { 6289, 6358, 6359, 6362 } }
ZoneData[69]  = { name = "Feralas",              continent = "Kalimdor", expansion = "Classic", narratorID = N.NAT_PAGLE,
    fish = { 6362, 4603, 13760, 6358 } }
ZoneData[71]  = { name = "Tanaris",              continent = "Kalimdor", expansion = "Classic", narratorID = N.NAT_PAGLE,
    fish = { 4603, 13754, 13755, 13756 } }
ZoneData[10]  = { name = "Northern Barrens",     continent = "Kalimdor", expansion = "Classic", narratorID = N.LUMAK,
    fish = { 6289, 6291, 6522 },
    notes = "The Wailing Caverns oasis holds the elusive Deviate Fish." }
ZoneData[199] = { name = "Southern Barrens",     continent = "Kalimdor", expansion = "Classic", narratorID = N.LUMAK,
    fish = { 6289, 6358, 6359 } }
ZoneData[57]  = { name = "Teldrassil",           continent = "Kalimdor", expansion = "Classic", narratorID = N.ASTAIA,
    fish = { 6291, 6303, 6289 } }

-------------------------------------------------------------------------------
-- TBC — Outland
-------------------------------------------------------------------------------
ZoneData[100] = { name = "Hellfire Peninsula",   continent = "Outland", expansion = "TBC", narratorID = N.OLD_MAN_BARLO,
    fish = { 27422, 27425 } }
ZoneData[102] = { name = "Zangarmarsh",          continent = "Outland", expansion = "TBC", narratorID = N.JUNO_DUFRAIN,
    fish = { 27422, 27425, 27429, 33823 } }
ZoneData[104] = { name = "Shadowmoon Valley",    continent = "Outland", expansion = "TBC", narratorID = N.OLD_MAN_BARLO,
    fish = { 27422, 27437 } }
ZoneData[108] = { name = "Terokkar Forest",      continent = "Outland", expansion = "TBC", narratorID = N.OLD_MAN_BARLO,
    fish = { 27425, 27435, 27438, 27439, 27442, 27388 },
    notes = "Highland Mixed Schools near Allerian Stronghold hold Mr. Pinchy." }
ZoneData[107] = { name = "Nagrand",              continent = "Outland", expansion = "TBC", narratorID = N.OLD_MAN_BARLO,
    fish = { 27422, 27425, 27435, 27516 } }
ZoneData[109] = { name = "Netherstorm",          continent = "Outland", expansion = "TBC", narratorID = N.OLD_MAN_BARLO,
    fish = { 27422, 27437 } }

-------------------------------------------------------------------------------
-- WotLK — Northrend
-------------------------------------------------------------------------------
ZoneData[117] = { name = "Howling Fjord",        continent = "Northrend", expansion = "WotLK", narratorID = N.OLD_MAN_ROBERT,
    fish = { 41806, 41808, 41813, 44703 },
    notes = "Dark Herring is a rare catch from Fangtooth Herring schools." }
ZoneData[114] = { name = "Borean Tundra",        continent = "Northrend", expansion = "WotLK", narratorID = N.MARCIA_CHASE,
    fish = { 41805, 41806, 41808, 41813, 40199 } }
ZoneData[115] = { name = "Dragonblight",         continent = "Northrend", expansion = "WotLK", narratorID = N.MARCIA_CHASE,
    fish = { 41807, 41808, 41809, 41810, 40199 } }
ZoneData[116] = { name = "Grizzly Hills",        continent = "Northrend", expansion = "WotLK", narratorID = N.MARCIA_CHASE,
    fish = { 41808, 41809, 41810, 41812, 40199 } }
ZoneData[119] = { name = "Sholazar Basin",       continent = "Northrend", expansion = "WotLK", narratorID = N.MARCIA_CHASE,
    fish = { 41807, 41810, 41812, 41813, 40199 } }
ZoneData[120] = { name = "The Storm Peaks",      continent = "Northrend", expansion = "WotLK", narratorID = N.MARCIA_CHASE,
    fish = { 41809, 41810, 40199 } }
ZoneData[125] = { name = "Dalaran",              continent = "Northrend", expansion = "WotLK", narratorID = N.MARCIA_CHASE,
    fish = { 41814, 43646, 43647, 43571, 43572, 43652, 43698 },
    notes = "Glassfin Minnow and Fountain Goldfish from the fountain. Giant Sewer Rat, Magic Eater, and Sewer Carp from the Underbelly." }
ZoneData[118] = { name = "Icecrown",             continent = "Northrend", expansion = "WotLK", narratorID = N.MARCIA_CHASE,
    fish = { 41809, 41810, 40199 } }
ZoneData[121] = { name = "Zul'Drak",             continent = "Northrend", expansion = "WotLK", narratorID = N.MARCIA_CHASE,
    fish = { 41808, 41809, 41810, 40199 } }
ZoneData[123] = { name = "Wintergrasp",          continent = "Northrend", expansion = "WotLK", narratorID = N.MARCIA_CHASE,
    fish = { 41808, 41809, 41810, 40199 } }

-------------------------------------------------------------------------------
-- Cataclysm
-------------------------------------------------------------------------------
ZoneData[241] = { name = "Twilight Highlands",   continent = "Eastern Kingdoms", expansion = "Cataclysm", narratorID = N.RAZGAR,
    fish = { 53063, 53067 } }
ZoneData[244] = { name = "Tol Barad Peninsula",  continent = "Eastern Kingdoms", expansion = "Cataclysm", narratorID = N.RAZGAR,
    fish = { 53070, 53071 } }
ZoneData[198] = { name = "Mount Hyjal",          continent = "Kalimdor",         expansion = "Cataclysm", narratorID = N.RAZGAR,
    fish = { 53066, 53063 } }
ZoneData[207] = { name = "Deepholm",             continent = "Maelstrom",        expansion = "Cataclysm", narratorID = N.RAZGAR,
    fish = { 53064 } }
ZoneData[249] = { name = "Uldum",                continent = "Kalimdor",         expansion = "Cataclysm", narratorID = N.RAZGAR,
    fish = { 53065, 53068 } }
ZoneData[205] = { name = "Vashj'ir",             continent = "Eastern Kingdoms", expansion = "Cataclysm", narratorID = N.RAZGAR,
    fish = { 53070, 53071 } }

-------------------------------------------------------------------------------
-- MoP — Pandaria
-------------------------------------------------------------------------------
ZoneData[371] = { name = "The Jade Forest",      continent = "Pandaria", expansion = "MoP", narratorID = N.ELDER_CLEARWATER,
    fish = { 74856, 74866 } }
ZoneData[376] = { name = "Valley of the Four Winds", continent = "Pandaria", expansion = "MoP", narratorID = N.ELDER_CLEARWATER,
    fish = { 74856, 74859, 74866 } }
ZoneData[379] = { name = "Kun-Lai Summit",       continent = "Pandaria", expansion = "MoP", narratorID = N.ELDER_CLEARWATER,
    fish = { 74864, 74866, 86544 } }
ZoneData[388] = { name = "Townlong Steppes",     continent = "Pandaria", expansion = "MoP", narratorID = N.ELDER_CLEARWATER,
    fish = { 74865, 74866 } }
ZoneData[390] = { name = "Vale of Eternal Blossoms", continent = "Pandaria", expansion = "MoP", narratorID = N.ELDER_CLEARWATER,
    fish = { 74861, 74866, 86542 } }
ZoneData[418] = { name = "Krasarang Wilds",      continent = "Pandaria", expansion = "MoP", narratorID = N.ELDER_CLEARWATER,
    fish = { 74863, 74857, 74866, 86545 },
    notes = "Home of the Anglers faction. Daily quests available at the wharf." }
ZoneData[422] = { name = "Dread Wastes",         continent = "Pandaria", expansion = "MoP", narratorID = N.ELDER_CLEARWATER,
    fish = { 74860, 74866 } }

-------------------------------------------------------------------------------
-- WoD — Draenor
-------------------------------------------------------------------------------
ZoneData[525] = { name = "Frostfire Ridge",      continent = "Draenor", expansion = "WoD", narratorID = N.NAT_PAGLE_GARRISON,
    fish = { 111595, 111669, 116818 } }
ZoneData[534] = { name = "Tanaan Jungle",        continent = "Draenor", expansion = "WoD", narratorID = N.NAT_PAGLE_GARRISON,
    fish = { 111595, 127991 },
    notes = "Felmouth Frenzy is unique to Tanaan waters." }
ZoneData[535] = { name = "Talador",              continent = "Draenor", expansion = "WoD", narratorID = N.NAT_PAGLE_GARRISON,
    fish = { 111595, 111666, 116821 } }
ZoneData[539] = { name = "Shadowmoon Valley (Draenor)", continent = "Draenor", expansion = "WoD", narratorID = N.NAT_PAGLE_GARRISON,
    fish = { 111595, 111668, 116819 } }
ZoneData[542] = { name = "Spires of Arak",       continent = "Draenor", expansion = "WoD", narratorID = N.NAT_PAGLE_GARRISON,
    fish = { 111595, 111664, 116823 } }
ZoneData[543] = { name = "Gorgrond",             continent = "Draenor", expansion = "WoD", narratorID = N.NAT_PAGLE_GARRISON,
    fish = { 111595, 111667, 116820 } }
ZoneData[550] = { name = "Nagrand (Draenor)",    continent = "Draenor", expansion = "WoD", narratorID = N.NAT_PAGLE_GARRISON,
    fish = { 111595, 111665, 116822 } }

-------------------------------------------------------------------------------
-- Legion — Broken Isles
-------------------------------------------------------------------------------
ZoneData[630] = { name = "Azsuna",               continent = "Broken Isles", expansion = "Legion", narratorID = N.CONJURER_MARGOSS,
    fish = { 124112, 124108, 133725, 133726, 133727 },
    notes = "Home to Leyshimmer Blenny, Nar'thalas Hermit, and Ghostly Queenfish for Bigger Fish to Fry." }
ZoneData[634] = { name = "Stormheim",            continent = "Broken Isles", expansion = "Legion", narratorID = N.CONJURER_MARGOSS,
    fish = { 124107, 124109, 133734, 133735, 133736 },
    notes = "Oodelfjisk, Graybelly Lobster, and Thundering Stormray for Bigger Fish to Fry." }
ZoneData[641] = { name = "Val'sharah",           continent = "Broken Isles", expansion = "Legion", narratorID = N.CONJURER_MARGOSS,
    fish = { 124108, 124110, 133728, 133729, 133730 } }
ZoneData[650] = { name = "Highmountain",         continent = "Broken Isles", expansion = "Legion", narratorID = N.CONJURER_MARGOSS,
    fish = { 124107, 124110, 133731, 133732, 133733 },
    notes = "Mountain Puffer, Coldriver Carp, and Ancient Highmountain Salmon for Bigger Fish to Fry." }
ZoneData[680] = { name = "Suramar",              continent = "Broken Isles", expansion = "Legion", narratorID = N.SHALETH,
    fish = { 124110, 124111, 124112, 133737, 133738, 133739 },
    notes = "Magic-Eater Frog, Seerspine Puffer, and Tainted Runescale Koi for Bigger Fish to Fry." }
ZoneData[627] = { name = "Dalaran (Broken Isles)", continent = "Broken Isles", expansion = "Legion", narratorID = N.MARCIA_CHASE_LEGION,
    fish = { 124111, 124112, 138967 },
    notes = "Conjurer Margoss's island is accessible from the Underbelly." }

-------------------------------------------------------------------------------
-- BFA
-------------------------------------------------------------------------------
ZoneData[895] = { name = "Tiragarde Sound",      continent = "Kul Tiras", expansion = "BFA", narratorID = N.ALAN,
    fish = { 152548, 152547, 152549, 162515 } }
ZoneData[896] = { name = "Drustvar",             continent = "Kul Tiras", expansion = "BFA", narratorID = N.ALAN,
    fish = { 152544, 152547, 162515 } }
ZoneData[942] = { name = "Stormsong Valley",     continent = "Kul Tiras", expansion = "BFA", narratorID = N.ALAN,
    fish = { 152543, 152547, 152549, 162515 } }
ZoneData[862] = { name = "Zuldazar",             continent = "Zandalar",  expansion = "BFA", narratorID = N.ALAN,
    fish = { 152547, 152545, 162515 } }
ZoneData[863] = { name = "Nazmir",               continent = "Zandalar",  expansion = "BFA", narratorID = N.ALAN,
    fish = { 152544, 152547, 162515 } }
ZoneData[864] = { name = "Vol'dun",              continent = "Zandalar",  expansion = "BFA", narratorID = N.ALAN,
    fish = { 152543, 152546, 152547, 162515 } }
ZoneData[1355] = { name = "Nazjatar",             continent = "Zandalar",  expansion = "BFA", narratorID = N.ALAN,
    fish = { 168302, 168646 },
    notes = "Viper Fish and Mauve Stinger are unique to Nazjatar waters." }
ZoneData[1462] = { name = "Mechagon Island",      continent = "Kul Tiras", expansion = "BFA", narratorID = N.ALAN,
    fish = { 167562, 167655, 167661, 167662, 167663, 167654, 167656, 167657, 167658, 167659, 167660 },
    notes = "Ionized Minnow and 10 secret fish for the Secret Fish of Mechagon achievement." }

-------------------------------------------------------------------------------
-- Shadowlands
-------------------------------------------------------------------------------
ZoneData[1525] = { name = "Revendreth",          continent = "Shadowlands", expansion = "Shadowlands", narratorID = N.AULARRYNAR,
    fish = { 173032, 173034 } }
ZoneData[1533] = { name = "Bastion",             continent = "Shadowlands", expansion = "Shadowlands", narratorID = N.AULARRYNAR,
    fish = { 173032, 173037 } }
ZoneData[1536] = { name = "Maldraxxus",          continent = "Shadowlands", expansion = "Shadowlands", narratorID = N.AULARRYNAR,
    fish = { 173032, 173035 } }
ZoneData[1565] = { name = "Ardenweald",          continent = "Shadowlands", expansion = "Shadowlands", narratorID = N.AULARRYNAR,
    fish = { 173032, 173033 } }
ZoneData[1543] = { name = "The Maw",             continent = "Shadowlands", expansion = "Shadowlands", narratorID = N.AULARRYNAR,
    fish = { 173032, 173036 } }
ZoneData[1970] = { name = "Zereth Mortis",        continent = "Shadowlands", expansion = "Shadowlands", narratorID = N.AULARRYNAR,
    fish = { 173032, 173034, 187702, 187872 },
    notes = "The Pond Nettle mount can be fished here." }

-------------------------------------------------------------------------------
-- Dragonflight — Dragon Isles
-------------------------------------------------------------------------------
ZoneData[2022] = { name = "The Waking Shores",   continent = "Dragon Isles", expansion = "Dragonflight", narratorID = N.TUSKARR_ELDER,
    fish = { 194730, 194967, 194970, 198395, 199344 },
    notes = "Magma Thresher found in lava pools near the Obsidian Citadel (requires Iskaara Renown 15)." }
ZoneData[2023] = { name = "Ohn'ahran Plains",    continent = "Dragon Isles", expansion = "Dragonflight", narratorID = N.TUSKARR_ELDER,
    fish = { 194730, 194966, 194968, 194970, 198395 } }
ZoneData[2024] = { name = "The Azure Span",      continent = "Dragon Isles", expansion = "Dragonflight", narratorID = N.TUSKARR_ELDER,
    fish = { 194730, 194969, 194970, 198395, 200061, 200074 },
    notes = "Iskaara Tuskarr community feasts include fishing contributions. Prismatic Leaper in highland pools (Renown 6), Frosted Rimefin Tuna in ice holes (Renown 10)." }
ZoneData[2025] = { name = "Thaldraszus",         continent = "Dragon Isles", expansion = "Dragonflight", narratorID = N.TUSKARR_ELDER,
    fish = { 194730, 194969, 194970, 198395, 200061 } }

-------------------------------------------------------------------------------
-- TWW (The War Within)
-------------------------------------------------------------------------------
ZoneData[2248] = { name = "Isle of Dorn",        continent = "Khaz Algar", expansion = "TWW", narratorID = N.NAT_PAGLE,
    fish = { 220134, 220135, 220136, 220137, 220138, 220139, 220141, 220142, 220143, 220144, 220150, 222533 } }
ZoneData[2214] = { name = "The Ringing Deeps",   continent = "Khaz Algar", expansion = "TWW", narratorID = N.NAT_PAGLE,
    fish = { 220134, 220135, 220136, 220137, 220138, 220139, 220141, 220142, 220143, 220144, 220150, 222533 } }
ZoneData[2215] = { name = "Hallowfall",          continent = "Khaz Algar", expansion = "TWW", narratorID = N.NAT_PAGLE,
    fish = { 220134, 220135, 220138, 220139, 220143, 220144, 220145, 220146, 220147, 220149, 220150, 220151, 222533 },
    notes = "Home of the Hallowfall Fishing Derby. Kah, Legend of the Deep mount from The Derby Dash achievement." }
ZoneData[2255] = { name = "Azj-Kahet",           continent = "Khaz Algar", expansion = "TWW", narratorID = N.NAT_PAGLE,
    fish = { 220138, 220144, 220146, 220147, 220148, 220149, 220151, 220153, 222533 } }
ZoneData[2339] = { name = "Siren Isle",          continent = "Khaz Algar", expansion = "TWW", narratorID = N.NAT_PAGLE,
    fish = { 220134, 220135, 220136, 220137, 220138, 220139, 220142, 220143, 220150, 222533 } }
ZoneData[2346] = { name = "Undermine",           continent = "Khaz Algar", expansion = "TWW", narratorID = N.NAT_PAGLE,
    fish = { 220148, 227673 },
    notes = "The \"Gold\" Fish is unique to Undermine waters." }

-------------------------------------------------------------------------------
-- Helpers
-------------------------------------------------------------------------------

-- Get zones grouped by continent, sorted by expansion order
local EXPANSION_ORDER = {
    Classic = 1, TBC = 2, WotLK = 3, Cataclysm = 4,
    MoP = 5, WoD = 6, Legion = 7, BFA = 8,
    Shadowlands = 9, Dragonflight = 10, TWW = 11,
}

function ns.GetZonesByContinent()
    local continents = {}
    local continentOrder = {}

    for mapID, zone in pairs(ZoneData) do
        local key = zone.continent
        if not continents[key] then
            continents[key] = {
                name = key,
                expansion = zone.expansion,
                zones = {},
            }
            table.insert(continentOrder, key)
        end
        table.insert(continents[key].zones, {
            mapID = mapID,
            name = zone.name,
            expansion = zone.expansion,
        })
    end

    -- Sort continents by expansion
    table.sort(continentOrder, function(a, b)
        local oa = EXPANSION_ORDER[continents[a].expansion] or 99
        local ob = EXPANSION_ORDER[continents[b].expansion] or 99
        return oa < ob
    end)

    -- Sort zones within each continent alphabetically
    for _, cont in pairs(continents) do
        table.sort(cont.zones, function(a, b)
            return a.name < b.name
        end)
    end

    return continents, continentOrder
end

function ns.GetZoneFish(mapID)
    local zone = ZoneData[mapID]
    if not zone then return {} end
    return zone.fish or {}
end

function ns.GetZoneNarrator(mapID)
    local zone = ZoneData[mapID]
    if zone and zone.narratorID then
        return zone.narratorID
    end
    -- Fallback to expansion narrator
    if zone then
        return ns.EXPANSION_NARRATORS[zone.expansion] or ns.NARRATOR.NAT_PAGLE
    end
    return ns.NARRATOR.NAT_PAGLE
end
