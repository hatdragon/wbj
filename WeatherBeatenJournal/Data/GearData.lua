local _, ns = ...

-------------------------------------------------------------------------------
-- GearData — Fishing gear: lures, baits, rods, hats, lines, toys
-------------------------------------------------------------------------------
local GearData = {}
ns.GearData = GearData

-------------------------------------------------------------------------------
-- Lures — Traditional skill-bonus lures
-- Format: { itemID, name, skillBonus, duration, source, expansion }
-------------------------------------------------------------------------------
GearData.LURES = {
    { itemID = 6529,   name = "Shiny Bauble",                skillBonus = 3,   duration = 10, expansion = "Classic" },
    { itemID = 6530,   name = "Nightcrawlers",               skillBonus = 5,   duration = 10, expansion = "Classic" },
    { itemID = 6811,   name = "Aquadynamic Fish Lens",       skillBonus = 5,   duration = 10, expansion = "Classic" },
    { itemID = 7307,   name = "Flesh Eating Worm",           skillBonus = 7,   duration = 10, expansion = "Classic" },
    { itemID = 6532,   name = "Bright Baubles",              skillBonus = 7,   duration = 10, expansion = "Classic" },
    { itemID = 6533,   name = "Aquadynamic Fish Attractor",  skillBonus = 9,   duration = 10, expansion = "Classic" },
    { itemID = 34861,  name = "Sharpened Fish Hook",         skillBonus = 9,   duration = 10, expansion = "TBC" },
    { itemID = 46006,  name = "Glow Worm",                   skillBonus = 9,   duration = 60, expansion = "WotLK" },
    { itemID = 62673,  name = "Feathered Lure",              skillBonus = 9,   duration = 10, expansion = "Cataclysm" },
    { itemID = 68049,  name = "Heat-Treated Spinning Lure",  skillBonus = 10,  duration = 15, expansion = "Cataclysm" },
    { itemID = 67404,  name = "Glass Fishing Bobber",        skillBonus = 2,   duration = 10, expansion = "Cataclysm" },
    { itemID = 118391, name = "Worm Supreme",                skillBonus = 10,  duration = 10, expansion = "WoD" },
}

-------------------------------------------------------------------------------
-- Baits — Expansion-specific targeted baits
-- Format: { itemID, name, targetFish, zone, expansion, usage }
-- usage: "bait" (apply to pole, default), "summon" (use near water to attract)
-------------------------------------------------------------------------------
GearData.BAITS = {
    -- WoD
    { itemID = 110274, name = "Jawless Skulker Bait",        targetFish = "Jawless Skulker",        expansion = "WoD" },
    { itemID = 110289, name = "Fat Sleeper Bait",            targetFish = "Fat Sleeper",            expansion = "WoD" },
    { itemID = 110290, name = "Blind Lake Sturgeon Bait",    targetFish = "Blind Lake Sturgeon",    expansion = "WoD" },
    { itemID = 110291, name = "Fire Ammonite Bait",          targetFish = "Fire Ammonite",          expansion = "WoD" },
    { itemID = 110292, name = "Sea Scorpion Bait",           targetFish = "Sea Scorpion",           expansion = "WoD" },
    { itemID = 110293, name = "Abyssal Gulper Eel Bait",     targetFish = "Abyssal Gulper Eel",     expansion = "WoD" },
    { itemID = 110294, name = "Blackwater Whiptail Bait",    targetFish = "Blackwater Whiptail",    expansion = "WoD" },
    { itemID = 128229, name = "Felmouth Frenzy Bait",        targetFish = "Felmouth Frenzy",        expansion = "WoD" },

    -- Legion (rare fish summoning items — use near water to attract the rare fish)
    { itemID = 139175, name = "Arcane Lure",                 targetFish = "All rare fish",          zone = "All zones",    expansion = "Legion", usage = "summon" },
    { itemID = 133701, name = "Skrog Toenail",               targetFish = "Leyshimmer Blenny",      zone = "Azsuna",       expansion = "Legion", usage = "summon" },
    { itemID = 133703, name = "Pearlescent Conch",           targetFish = "Nar'thalas Hermit",      zone = "Azsuna",       expansion = "Legion", usage = "summon" },
    { itemID = 133704, name = "Rusty Queenfish Brooch",      targetFish = "Ghostly Queenfish",      zone = "Azsuna",       expansion = "Legion", usage = "summon" },
    { itemID = 133705, name = "Rotten Fishbone",             targetFish = "Ancient Mossgill",       zone = "Val'sharah",   expansion = "Legion", usage = "summon" },
    { itemID = 133707, name = "Nightmare Nightcrawler",      targetFish = "Terrorfin",              zone = "Val'sharah",   expansion = "Legion", usage = "summon" },
    { itemID = 133708, name = "Drowned Thistleleaf",         targetFish = "Thorned Flounder",       zone = "Val'sharah",   expansion = "Legion", usage = "summon" },
    { itemID = 133709, name = "Funky Sea Snail",             targetFish = "Ancient Highmountain Salmon", zone = "Highmountain", expansion = "Legion", usage = "summon" },
    { itemID = 133710, name = "Salmon Lure",                 targetFish = "Ancient Highmountain Salmon", zone = "Highmountain", expansion = "Legion", usage = "summon" },
    { itemID = 133711, name = "Swollen Murloc Egg",          targetFish = "Mountain Puffer",        zone = "Highmountain", expansion = "Legion", usage = "summon" },
    { itemID = 133712, name = "Frost Worm",                  targetFish = "Coldriver Carp",         zone = "Highmountain", expansion = "Legion", usage = "summon" },
    { itemID = 133713, name = "Moosehorn Hook",              targetFish = "Thundering Stormray",    zone = "Stormheim",    expansion = "Legion", usage = "summon" },
    { itemID = 133714, name = "Silverscale Minnow",          targetFish = "Thundering Stormray",    zone = "Stormheim",    expansion = "Legion", usage = "summon" },
    { itemID = 133715, name = "Ancient Vrykul Ring",         targetFish = "Oodelfjisk",             zone = "Stormheim",    expansion = "Legion", usage = "summon" },
    { itemID = 133716, name = "Soggy Drakescale",            targetFish = "Graybelly Lobster",      zone = "Stormheim",    expansion = "Legion", usage = "summon" },
    { itemID = 133717, name = "Enchanted Lure",              targetFish = "Magic-Eater Frog",       zone = "Suramar",      expansion = "Legion", usage = "summon" },
    { itemID = 133720, name = "Demonic Detritus",            targetFish = "Tainted Runescale Koi",  zone = "Suramar",      expansion = "Legion", usage = "summon" },
    { itemID = 133721, name = "Message in a Beer Bottle",    targetFish = "Axefish",                zone = "Ocean",        expansion = "Legion", usage = "summon" },
    { itemID = 133722, name = "Axefish Lure",                targetFish = "Axefish",                zone = "Ocean",        expansion = "Legion", usage = "summon" },
    { itemID = 133724, name = "Decayed Whale Blubber",       targetFish = "Ancient Black Barracuda", zone = "Ocean",       expansion = "Legion", usage = "summon" },

    -- BFA
    { itemID = 165699, name = "Scarlet Herring Lure",        targetFish = "Midnight Salmon",        expansion = "BFA" },
    { itemID = 167649, name = "Hundred-Fathom Lure",         targetFish = "Deepwater Maw",          expansion = "BFA", usage = "summon", mapIDs = { [1462] = true } },
    { itemID = 167698, name = "Secret Fish Goggles",         targetFish = "Secret fish",            expansion = "BFA", mapIDs = { [1462] = true, [895] = true, [896] = true, [942] = true, [862] = true, [863] = true, [864] = true, [1355] = true } },

    -- Shadowlands
    { itemID = 173038, name = "Lost Sole Bait",              targetFish = "Lost Sole",              expansion = "Shadowlands" },
    { itemID = 173039, name = "Iridescent Amberjack Bait",   targetFish = "Iridescent Amberjack",   expansion = "Shadowlands" },
    { itemID = 173040, name = "Silvergill Pike Bait",        targetFish = "Silvergill Pike",        expansion = "Shadowlands" },
    { itemID = 173041, name = "Pocked Bonefish Bait",        targetFish = "Pocked Bonefish",        expansion = "Shadowlands" },
    { itemID = 173042, name = "Spinefin Piranha Bait",       targetFish = "Spinefin Piranha",       expansion = "Shadowlands" },
    { itemID = 173043, name = "Elysian Thade Bait",          targetFish = "Elysian Thade",          expansion = "Shadowlands" },

    -- Dragonflight
    { itemID = 193893, name = "Scalebelly Mackerel Lure",    targetFish = "Scalebelly Mackerel",    expansion = "Dragonflight" },
    { itemID = 193894, name = "Thousandbite Piranha Lure",   targetFish = "Thousandbite Piranha",   expansion = "Dragonflight" },
    { itemID = 193895, name = "Temporal Dragonhead Lure",    targetFish = "Temporal Dragonhead",    expansion = "Dragonflight" },
    { itemID = 193896, name = "Cerulean Spinefish Lure",     targetFish = "Cerulean Spinefish",     expansion = "Dragonflight" },
    { itemID = 198401, name = "Aileron Seamoth Lure",        targetFish = "Aileron Seamoth",        expansion = "Dragonflight" },
    { itemID = 198403, name = "Islefin Dorado Lure",         targetFish = "Islefin Dorado",         expansion = "Dragonflight" },

    -- Midnight (rare fish summoning items)
    { itemID = 241145, name = "Lucky Loa Lure",              targetFish = "Lucky Loa",              expansion = "Midnight", usage = "summon" },
    { itemID = 241147, name = "Blood Hunter Lure",           targetFish = "Blood Hunter",           expansion = "Midnight", usage = "summon" },
    { itemID = 241148, name = "Amani Angler's Ward",         targetFish = "Blood Hunter",           expansion = "Midnight", usage = "summon" },
    { itemID = 241149, name = "Ominous Octopus Lure",        targetFish = "Ominous Octopus",        expansion = "Midnight", usage = "summon" },
}

-------------------------------------------------------------------------------
-- Rods — Fishing poles
-- Format: { itemID, name, quality, source, expansion }
-------------------------------------------------------------------------------
GearData.RODS = {
    { itemID = 6256,   name = "Fishing Pole",                       quality = "COMMON",   expansion = "Classic" },
    { itemID = 6365,   name = "Strong Fishing Pole",                quality = "COMMON",   expansion = "Classic" },
    { itemID = 6366,   name = "Darkwood Fishing Pole",              quality = "COMMON",   expansion = "Classic" },
    { itemID = 6367,   name = "Big Iron Fishing Pole",              quality = "COMMON",   expansion = "Classic" },
    { itemID = 19022,  name = "Nat Pagle's Extreme Angler FC-5000", quality = "RARE",     expansion = "Classic" },
    { itemID = 19970,  name = "Arcanite Fishing Pole",              quality = "RARE",     expansion = "Classic" },
    { itemID = 25978,  name = "Seth's Graphite Fishing Pole",       quality = "UNCOMMON", expansion = "TBC" },
    { itemID = 44050,  name = "Mastercraft Kalu'ak Fishing Pole",   quality = "EPIC",     expansion = "WotLK" },
    { itemID = 45858,  name = "Nat's Lucky Fishing Pole",           quality = "RARE",     expansion = "WotLK" },
    { itemID = 45992,  name = "Jeweled Fishing Pole",               quality = "RARE",     expansion = "WotLK" },
    { itemID = 45991,  name = "Bone Fishing Pole",                  quality = "RARE",     expansion = "WotLK" },
    { itemID = 46337,  name = "Staats' Fishing Pole",               quality = "RARE",     expansion = "WotLK" },
    { itemID = 84660,  name = "Pandaren Fishing Pole",             quality = "UNCOMMON", expansion = "MoP" },
    { itemID = 84661,  name = "Dragon Fishing Pole",               quality = "RARE",     expansion = "MoP" },
    { itemID = 116825, name = "Savage Fishing Pole",                quality = "RARE",     expansion = "WoD" },
    { itemID = 116826, name = "Draenic Fishing Pole",               quality = "RARE",     expansion = "WoD" },
    { itemID = 118381, name = "Ephemeral Fishing Pole",             quality = "RARE",     expansion = "WoD" },
    { itemID = 120163, name = "Thruk's Fishing Rod",                quality = "COMMON",   expansion = "WoD" },
    { itemID = 133755, name = "Underlight Angler",                  quality = "EPIC",     expansion = "Legion" },
    { itemID = 168804, name = "Powered Piscine Procurement Pole",   quality = "RARE",     expansion = "BFA" },
    { itemID = 244711, name = "Farstrider Hobbyist Rod",            quality = "UNCOMMON", expansion = "Midnight" },
    { itemID = 244712, name = "Sin'dorei Angler's Rod",             quality = "RARE",     expansion = "Midnight" },
    { itemID = 259179, name = "Sin'dorei Reeler's Rod",             quality = "EPIC",     expansion = "Midnight" },
}

-------------------------------------------------------------------------------
-- Hats — Fishing headgear
-- Format: { itemID, name, source, expansion }
-------------------------------------------------------------------------------
GearData.HATS = {
    { itemID = 19972,  name = "Lucky Fishing Hat",        expansion = "Classic" },
    { itemID = 33820,  name = "Weather-Beaten Fishing Hat", expansion = "TBC" },
    { itemID = 88710,  name = "Nat's Hat",                expansion = "MoP" },
    { itemID = 93732,  name = "Darkmoon Fishing Cap",     expansion = "MoP" },
    { itemID = 117405, name = "Nat's Drinking Hat",       expansion = "WoD" },
    { itemID = 118393, name = "Tentacled Hat",            expansion = "WoD" },
    { itemID = 118380, name = "Hightfish Cap",            expansion = "WoD" },
}

-------------------------------------------------------------------------------
-- Lines — Fishing line attachments
-- Format: { itemID, name, source, expansion }
-------------------------------------------------------------------------------
GearData.LINES = {
    { itemID = 19971,  name = "High Test Eternium Fishing Line",  expansion = "Classic" },
    { itemID = 34863,  name = "Spun Truesilver Fishing Line",     expansion = "TBC" },
    { itemID = 68795,  name = "Reinforced Fishing Line",          expansion = "Cataclysm" },
    { itemID = 116117, name = "Rook's Lucky Fishin' Line",        expansion = "WoD" },
    { itemID = 153203, name = "Ancient Fishing Line",             expansion = "Legion" },
    { itemID = 262796, name = "Midnight Angler's Grand Line",     expansion = "Midnight" },
}

-------------------------------------------------------------------------------
-- Toys — Fishing-related toys
-- Format: { itemID, name, source, expansion }
-------------------------------------------------------------------------------
GearData.TOYS = {
    -- General fishing toys
    { itemID = 33223,  name = "Fishing Chair",            expansion = "Classic" },
    { itemID = 86596,  name = "Nat's Fishing Chair",      expansion = "MoP" },
    { itemID = 85500,  name = "Anglers Fishing Raft",     expansion = "MoP" },
    { itemID = 152556, name = "Trawler Totem",            expansion = "BFA" },
    { itemID = 168016, name = "Hyper-Compressed Ocean",   expansion = "BFA" },
    { itemID = 235801, name = "Personal Fishing Barge",   expansion = "TWW" },

    -- Bobber crate toys (Legion)
    { itemID = 142528, name = "Crate of Bobbers: Can of Worms",      expansion = "Legion" },
    { itemID = 142529, name = "Crate of Bobbers: Cat Head",          expansion = "Legion" },
    { itemID = 142530, name = "Crate of Bobbers: Tugboat",           expansion = "Legion" },
    { itemID = 142531, name = "Crate of Bobbers: Squeaky Duck",      expansion = "Legion" },
    { itemID = 142532, name = "Crate of Bobbers: Murloc Head",       expansion = "Legion" },
    { itemID = 143662, name = "Crate of Bobbers: Wooden Pepe",       expansion = "Legion" },
    { itemID = 147307, name = "Crate of Bobbers: Carved Wooden Helm", expansion = "Legion" },
    { itemID = 147308, name = "Crate of Bobbers: Enchanted Bobber",  expansion = "Legion" },
    { itemID = 147309, name = "Crate of Bobbers: Face of the Forest", expansion = "Legion" },
    { itemID = 147310, name = "Crate of Bobbers: Floating Totem",    expansion = "Legion" },
    { itemID = 147311, name = "Crate of Bobbers: Replica Gondola",   expansion = "Legion" },
    { itemID = 147312, name = "Crate of Bobbers: Demon Noggin",      expansion = "Legion" },
}

-------------------------------------------------------------------------------
-- Accessories — Equippable fishing gear (boots, trinkets, charms)
-- Format: { itemID, name, expansion }
-------------------------------------------------------------------------------
GearData.ACCESSORIES = {
    { itemID = 19979, name = "Hook of the Master Angler",      expansion = "Classic" },
    { itemID = 19969, name = "Nat's Extreme Anglin' Boots",    expansion = "Classic" },
    { itemID = 50287, name = "Boots of the Bay",               expansion = "WotLK" },
    { itemID = 85973, name = "Ancient Pandaren Fishing Charm", expansion = "MoP" },
    { itemID = 167698, name = "Secret Fish Goggles",             expansion = "BFA" },
}

-------------------------------------------------------------------------------
-- Consumables — Items that grant a fishing skill bonus when consumed
-- Format: { itemID, name, skillBonus, duration, expansion }
-------------------------------------------------------------------------------
GearData.CONSUMABLES = {
    { itemID = 34832, name = "Captain Rumsey's Lager", skillBonus = 5, duration = 3, expansion = "TBC" },
}

-------------------------------------------------------------------------------
-- Vanity — Novelty weapons caught while fishing
-- Format: { itemID, name, source, expansion }
-------------------------------------------------------------------------------
GearData.VANITY = {
    { itemID = 19944, name = "Nat Pagle's Fish Terminator", source = "Fishing in Zul'Gurub",                    expansion = "Classic" },
    { itemID = 6360,  name = "Steelscale Crushfish",        source = "Rare catch from Classic waters",           expansion = "Classic" },
    { itemID = 19808, name = "Rockhide Strongfish",         source = "STV Fishing Extravaganza (rare)",          expansion = "Classic" },
    { itemID = 44703, name = "Dark Herring",                source = "Fangtooth Herring School (Howling Fjord)", expansion = "WotLK" },
}
