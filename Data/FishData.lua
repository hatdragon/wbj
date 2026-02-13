local _, ns = ...

-------------------------------------------------------------------------------
-- FishData — Comprehensive fish database
--
-- Format: [itemID] = { name, quality, expansion }
--
-- Data is used for the Spot Guide to show what fish are available in each
-- zone. Catches not in this table are still recorded by CatchTracker; they
-- just won't appear in zone guides until added here.
-------------------------------------------------------------------------------
local FishData = {}
ns.FishData = FishData

-- Quality constants for readability
local POOR     = Enum.ItemQuality.Poor
local COMMON   = Enum.ItemQuality.Common
local UNCOMMON = Enum.ItemQuality.Uncommon
local RARE     = Enum.ItemQuality.Rare
local EPIC     = Enum.ItemQuality.Epic

-------------------------------------------------------------------------------
-- Classic
-------------------------------------------------------------------------------
-- Raw fish (primary catches)
FishData[6291]  = { name = "Raw Brilliant Smallfish",       quality = COMMON,   expansion = "Classic" }
FishData[6303]  = { name = "Raw Slitherskin Mackerel",      quality = COMMON,   expansion = "Classic" }
FishData[6289]  = { name = "Raw Longjaw Mud Snapper",       quality = COMMON,   expansion = "Classic" }
FishData[6317]  = { name = "Raw Loch Frenzy",               quality = COMMON,   expansion = "Classic" }
FishData[6361]  = { name = "Raw Rainbow Fin Albacore",      quality = COMMON,   expansion = "Classic" }
FishData[6308]  = { name = "Raw Bristle Whisker Catfish",   quality = COMMON,   expansion = "Classic" }
FishData[21071] = { name = "Raw Sagefish",                  quality = COMMON,   expansion = "Classic" }
FishData[21153] = { name = "Raw Greater Sagefish",          quality = COMMON,   expansion = "Classic" }
FishData[8365]  = { name = "Raw Mithril Head Trout",        quality = COMMON,   expansion = "Classic" }
FishData[6362]  = { name = "Raw Rockscale Cod",             quality = COMMON,   expansion = "Classic" }
FishData[13760] = { name = "Raw Sunscale Salmon",           quality = COMMON,   expansion = "Classic" }
FishData[13759] = { name = "Raw Nightfin Snapper",          quality = COMMON,   expansion = "Classic" }
FishData[13754] = { name = "Raw Glossy Mightfish",          quality = COMMON,   expansion = "Classic" }
FishData[13893] = { name = "Large Raw Mightfish",           quality = COMMON,   expansion = "Classic" }
FishData[13755] = { name = "Winter Squid",                  quality = COMMON,   expansion = "Classic" }
FishData[13756] = { name = "Raw Summer Bass",               quality = COMMON,   expansion = "Classic" }
FishData[13758] = { name = "Raw Redgill",                   quality = COMMON,   expansion = "Classic" }
FishData[4603]  = { name = "Raw Spotted Yellowtail",        quality = COMMON,   expansion = "Classic" }
FishData[13888] = { name = "Darkclaw Lobster",              quality = COMMON,   expansion = "Classic" }
FishData[13889] = { name = "Raw Whitescale Salmon",         quality = COMMON,   expansion = "Classic" }
FishData[33824] = { name = "Crescent-Tail Skullfish",       quality = COMMON,   expansion = "Classic" }

-- Alchemy / special use fish
FishData[6358]  = { name = "Oily Blackmouth",               quality = COMMON,   expansion = "Classic" }
FishData[6359]  = { name = "Firefin Snapper",               quality = COMMON,   expansion = "Classic" }
FishData[6522]  = { name = "Deviate Fish",                  quality = COMMON,   expansion = "Classic" }
FishData[13422] = { name = "Stonescale Eel",                quality = COMMON,   expansion = "Classic" }
FishData[13757] = { name = "Lightning Eel",                 quality = COMMON,   expansion = "Classic" }

-- Rare classic fish
FishData[34486] = { name = "Old Crafty",                    quality = RARE,     expansion = "Classic" }
FishData[34484] = { name = "Old Ironjaw",                   quality = RARE,     expansion = "Classic" }

-------------------------------------------------------------------------------
-- TBC
-------------------------------------------------------------------------------
FishData[27422] = { name = "Barbed Gill Trout",             quality = COMMON,   expansion = "TBC" }
FishData[27425] = { name = "Spotted Feltail",               quality = COMMON,   expansion = "TBC" }
FishData[27429] = { name = "Zangarian Sporefish",           quality = COMMON,   expansion = "TBC" }
FishData[27438] = { name = "Golden Darter",                 quality = COMMON,   expansion = "TBC" }
FishData[27435] = { name = "Figluster's Mudfish",           quality = COMMON,   expansion = "TBC" }
FishData[27437] = { name = "Icefin Bluefish",               quality = COMMON,   expansion = "TBC" }
FishData[27439] = { name = "Furious Crawdad",               quality = COMMON,   expansion = "TBC" }
FishData[33823] = { name = "Bloodfin Catfish",              quality = COMMON,   expansion = "TBC" }

-- Large / special catches
FishData[27516] = { name = "Enormous Barbed Gill Trout",    quality = COMMON,   expansion = "TBC" }
FishData[27515] = { name = "Huge Spotted Feltail",          quality = COMMON,   expansion = "TBC" }

-- Grey quality vendor fish
FishData[27442] = { name = "Goldenscale Vendorfish",        quality = POOR,     expansion = "TBC" }

-- Rare catch
FishData[27388] = { name = "Mr. Pinchy",                    quality = RARE,     expansion = "TBC" }

-------------------------------------------------------------------------------
-- WotLK
-------------------------------------------------------------------------------
-- Inland / freshwater
FishData[41808] = { name = "Bonescale Snapper",             quality = COMMON,   expansion = "WotLK" }
FishData[41812] = { name = "Barrelhead Goby",               quality = COMMON,   expansion = "WotLK" }
FishData[41807] = { name = "Dragonfin Angelfish",           quality = COMMON,   expansion = "WotLK" }
FishData[41810] = { name = "Fangtooth Herring",             quality = COMMON,   expansion = "WotLK" }
FishData[41809] = { name = "Glacial Salmon",                quality = COMMON,   expansion = "WotLK" }
FishData[41814] = { name = "Glassfin Minnow",               quality = COMMON,   expansion = "WotLK" }
FishData[41813] = { name = "Nettlefish",                    quality = COMMON,   expansion = "WotLK" }
FishData[41806] = { name = "Musselback Sculpin",            quality = COMMON,   expansion = "WotLK" }

-- Coastal / saltwater
FishData[41805] = { name = "Borean Man O' War",             quality = COMMON,   expansion = "WotLK" }
FishData[41800] = { name = "Deep Sea Monsterbelly",         quality = COMMON,   expansion = "WotLK" }
FishData[41802] = { name = "Imperial Manta Ray",            quality = COMMON,   expansion = "WotLK" }
FishData[41801] = { name = "Moonglow Cuttlefish",           quality = COMMON,   expansion = "WotLK" }
FishData[41803] = { name = "Rockfin Grouper",               quality = COMMON,   expansion = "WotLK" }

-- By-catch / alchemy
FishData[40199] = { name = "Pygmy Suckerfish",              quality = COMMON,   expansion = "WotLK" }

-- Dalaran catches
FishData[43647] = { name = "Shimmering Minnow",             quality = COMMON,   expansion = "WotLK" }
FishData[43652] = { name = "Slippery Eel",                  quality = COMMON,   expansion = "WotLK" }
FishData[43646] = { name = "Fountain Goldfish",             quality = COMMON,   expansion = "WotLK" }
FishData[43572] = { name = "Magic Eater",                   quality = COMMON,   expansion = "WotLK" }
FishData[43571] = { name = "Sewer Carp",                    quality = COMMON,   expansion = "WotLK" }

-- Clam
FishData[36781] = { name = "Darkwater Clam",                quality = COMMON,   expansion = "WotLK" }

-- Tournament / special
FishData[50289] = { name = "Blacktip Shark",                quality = COMMON,   expansion = "WotLK" }

-- Rare WotLK catches
FishData[44703] = { name = "Dark Herring",                  quality = RARE,     expansion = "WotLK" }

-- Giant Sewer Rat (pet)
FishData[43698] = { name = "Giant Sewer Rat",               quality = RARE,     expansion = "WotLK" }

-- Mounts / Special
FishData[46109] = { name = "Sea Turtle",                    quality = EPIC,     expansion = "WotLK" }

-------------------------------------------------------------------------------
-- Cataclysm
-------------------------------------------------------------------------------
FishData[53062] = { name = "Raw Bristle Whisker Catfish",   quality = COMMON,   expansion = "Cataclysm" }
FishData[53063] = { name = "Mountain Trout",                quality = COMMON,   expansion = "Cataclysm" }
FishData[53064] = { name = "Highland Guppy",                quality = COMMON,   expansion = "Cataclysm" }
FishData[53065] = { name = "Albino Cavefish",               quality = COMMON,   expansion = "Cataclysm" }
FishData[53066] = { name = "Blackbelly Mudfish",            quality = COMMON,   expansion = "Cataclysm" }
FishData[53067] = { name = "Striped Lurker",                quality = COMMON,   expansion = "Cataclysm" }
FishData[53068] = { name = "Lavascale Catfish",             quality = COMMON,   expansion = "Cataclysm" }
FishData[53070] = { name = "Fathom Eel",                    quality = COMMON,   expansion = "Cataclysm" }
FishData[53071] = { name = "Algaefin Rockfish",             quality = COMMON,   expansion = "Cataclysm" }
FishData[53072] = { name = "Deepsea Sagefish",              quality = COMMON,   expansion = "Cataclysm" }

-------------------------------------------------------------------------------
-- MoP
-------------------------------------------------------------------------------
FishData[74866] = { name = "Golden Carp",                   quality = COMMON,   expansion = "MoP" }
FishData[74856] = { name = "Jade Lungfish",                 quality = COMMON,   expansion = "MoP" }
FishData[74857] = { name = "Giant Mantis Shrimp",           quality = COMMON,   expansion = "MoP" }
FishData[74859] = { name = "Emperor Salmon",                quality = COMMON,   expansion = "MoP" }
FishData[74860] = { name = "Redbelly Mandarin",             quality = COMMON,   expansion = "MoP" }
FishData[74861] = { name = "Tiger Gourami",                 quality = COMMON,   expansion = "MoP" }
FishData[74863] = { name = "Jewel Danio",                   quality = COMMON,   expansion = "MoP" }
FishData[74864] = { name = "Reef Octopus",                  quality = COMMON,   expansion = "MoP" }
FishData[74865] = { name = "Krasarang Paddlefish",          quality = COMMON,   expansion = "MoP" }

-- Nat Pagle dailies (rare catches)
FishData[86542] = { name = "Flying Tiger Gourami",          quality = COMMON,   expansion = "MoP" }
FishData[86544] = { name = "Spinefish Alpha",               quality = COMMON,   expansion = "MoP" }
FishData[86545] = { name = "Mimic Octopus",                 quality = COMMON,   expansion = "MoP" }

-------------------------------------------------------------------------------
-- WoD
-------------------------------------------------------------------------------
-- Flesh items (from filleting — kept for catch tracking)
FishData[109137] = { name = "Crescent Saberfish Flesh",     quality = COMMON,   expansion = "WoD" }
FishData[109138] = { name = "Jawless Skulker Flesh",        quality = COMMON,   expansion = "WoD" }
FishData[109139] = { name = "Fat Sleeper Flesh",            quality = COMMON,   expansion = "WoD" }
FishData[109140] = { name = "Blind Lake Sturgeon Flesh",    quality = COMMON,   expansion = "WoD" }
FishData[109141] = { name = "Fire Ammonite Flesh",          quality = COMMON,   expansion = "WoD" }
FishData[109142] = { name = "Sea Scorpion Flesh",           quality = COMMON,   expansion = "WoD" }
FishData[109143] = { name = "Abyssal Gulper Eel Flesh",     quality = COMMON,   expansion = "WoD" }

-- Whole fish (primary catches from fishing)
FishData[111595] = { name = "Crescent Saberfish",           quality = COMMON,   expansion = "WoD" }
FishData[111663] = { name = "Blackwater Whiptail",          quality = COMMON,   expansion = "WoD" }
FishData[111664] = { name = "Abyssal Gulper Eel",           quality = COMMON,   expansion = "WoD" }
FishData[111665] = { name = "Sea Scorpion",                 quality = COMMON,   expansion = "WoD" }
FishData[111666] = { name = "Fire Ammonite",                quality = COMMON,   expansion = "WoD" }
FishData[111667] = { name = "Blind Lake Sturgeon",          quality = COMMON,   expansion = "WoD" }
FishData[111668] = { name = "Fat Sleeper",                  quality = COMMON,   expansion = "WoD" }
FishData[111669] = { name = "Jawless Skulker",              quality = COMMON,   expansion = "WoD" }
FishData[118565] = { name = "Savage Piranha",               quality = COMMON,   expansion = "WoD" }

-- Enormous variants (Source 1)
FishData[110289] = { name = "Enormous Crescent Saberfish",  quality = UNCOMMON, expansion = "WoD" }

-- Enormous variants (Source 2)
FishData[111670] = { name = "Enormous Blackwater Whiptail", quality = COMMON,   expansion = "WoD" }
FishData[111671] = { name = "Enormous Abyssal Gulper Eel",  quality = COMMON,   expansion = "WoD" }
FishData[111672] = { name = "Enormous Sea Scorpion",        quality = COMMON,   expansion = "WoD" }
FishData[111673] = { name = "Enormous Fire Ammonite",       quality = COMMON,   expansion = "WoD" }
FishData[111674] = { name = "Enormous Blind Lake Sturgeon", quality = COMMON,   expansion = "WoD" }
FishData[111675] = { name = "Enormous Fat Sleeper",         quality = COMMON,   expansion = "WoD" }
FishData[111676] = { name = "Enormous Jawless Skulker",     quality = COMMON,   expansion = "WoD" }

-- Special / Tanaan
FishData[127991] = { name = "Felmouth Frenzy",              quality = COMMON,   expansion = "WoD" }

-- Garrison fish
FishData[116158] = { name = "Lunarfall Carp",               quality = COMMON,   expansion = "WoD" }
FishData[112633] = { name = "Frostdeep Minnow",             quality = COMMON,   expansion = "WoD" }

-- Darkmoon Island
FishData[124669] = { name = "Darkmoon Daggermaw",           quality = COMMON,   expansion = "WoD" }

-- Lunkers
FishData[116817] = { name = "Lunker",                       quality = RARE,     expansion = "WoD" }
FishData[116818] = { name = "Jawless Skulker Lunker",       quality = RARE,     expansion = "WoD" }
FishData[116819] = { name = "Fat Sleeper Lunker",           quality = RARE,     expansion = "WoD" }
FishData[116820] = { name = "Blind Lake Lunker",            quality = RARE,     expansion = "WoD" }
FishData[116821] = { name = "Fire Ammonite Lunker",         quality = RARE,     expansion = "WoD" }
FishData[116822] = { name = "Sea Scorpion Lunker",          quality = RARE,     expansion = "WoD" }
FishData[116823] = { name = "Abyssal Gulper Eel Lunker",    quality = RARE,     expansion = "WoD" }

-------------------------------------------------------------------------------
-- Legion
-------------------------------------------------------------------------------
-- Common fish
FishData[133607] = { name = "Silver Mackerel",              quality = COMMON,   expansion = "Legion" }
FishData[124107] = { name = "Cursed Queenfish",             quality = COMMON,   expansion = "Legion" }
FishData[124108] = { name = "Mossgill Perch",               quality = COMMON,   expansion = "Legion" }
FishData[124109] = { name = "Highmountain Salmon",          quality = COMMON,   expansion = "Legion" }
FishData[124110] = { name = "Stormray",                     quality = COMMON,   expansion = "Legion" }
FishData[124111] = { name = "Runescale Koi",                quality = COMMON,   expansion = "Legion" }
FishData[124112] = { name = "Black Barracuda",              quality = COMMON,   expansion = "Legion" }

-- Special
FishData[143748] = { name = "Leyscale Koi",                 quality = UNCOMMON, expansion = "Legion" }

-- Rare fish (Bigger Fish to Fry achievement)
-- Azsuna
FishData[133725] = { name = "Leyshimmer Blenny",            quality = COMMON,   expansion = "Legion" }
FishData[133726] = { name = "Nar'thalas Hermit",            quality = COMMON,   expansion = "Legion" }
FishData[133727] = { name = "Ghostly Queenfish",            quality = COMMON,   expansion = "Legion" }
-- Highmountain
FishData[133733] = { name = "Ancient Highmountain Salmon",  quality = COMMON,   expansion = "Legion" }
FishData[133732] = { name = "Coldriver Carp",               quality = COMMON,   expansion = "Legion" }
FishData[133731] = { name = "Mountain Puffer",              quality = COMMON,   expansion = "Legion" }
-- Stormheim
FishData[133736] = { name = "Thundering Stormray",          quality = COMMON,   expansion = "Legion" }
FishData[133734] = { name = "Oodelfjisk",                   quality = COMMON,   expansion = "Legion" }
FishData[133735] = { name = "Graybelly Lobster",            quality = COMMON,   expansion = "Legion" }
-- Val'sharah
FishData[133730] = { name = "Ancient Mossgill",             quality = COMMON,   expansion = "Legion" }
FishData[133728] = { name = "Terrorfin",                    quality = COMMON,   expansion = "Legion" }
FishData[133729] = { name = "Thorned Flounder",             quality = COMMON,   expansion = "Legion" }
-- Suramar
FishData[133739] = { name = "Tainted Runescale Koi",        quality = COMMON,   expansion = "Legion" }
FishData[133738] = { name = "Seerspine Puffer",             quality = COMMON,   expansion = "Legion" }
FishData[133737] = { name = "Magic-Eater Frog",             quality = COMMON,   expansion = "Legion" }
-- Ocean
FishData[133741] = { name = "Seabottom Squid",              quality = COMMON,   expansion = "Legion" }
FishData[133740] = { name = "Axefish",                      quality = COMMON,   expansion = "Legion" }
FishData[133742] = { name = "Ancient Black Barracuda",      quality = COMMON,   expansion = "Legion" }

-- Dalaran (Legion)
FishData[138967] = { name = "Big Fountain Goldfish",        quality = COMMON,   expansion = "Legion" }

-------------------------------------------------------------------------------
-- BFA
-------------------------------------------------------------------------------
-- Main fish
FishData[152547] = { name = "Great Sea Catfish",            quality = COMMON,   expansion = "BFA" }
FishData[152549] = { name = "Redtail Loach",                quality = COMMON,   expansion = "BFA" }
FishData[152544] = { name = "Slimy Mackerel",               quality = COMMON,   expansion = "BFA" }
FishData[152543] = { name = "Sand Shifter",                 quality = COMMON,   expansion = "BFA" }
FishData[152548] = { name = "Tiragarde Perch",              quality = COMMON,   expansion = "BFA" }
FishData[152546] = { name = "Lane Snapper",                 quality = COMMON,   expansion = "BFA" }
FishData[152545] = { name = "Frenzied Fangtooth",           quality = COMMON,   expansion = "BFA" }
FishData[162515] = { name = "Midnight Salmon",              quality = COMMON,   expansion = "BFA" }

-- Patch 8.2 (Nazjatar / Mechagon)
FishData[168302] = { name = "Viper Fish",                   quality = COMMON,   expansion = "BFA" }
FishData[168646] = { name = "Mauve Stinger",                quality = COMMON,   expansion = "BFA" }
FishData[167562] = { name = "Ionized Minnow",               quality = COMMON,   expansion = "BFA" }

-- Patch 8.3 (Visions)
FishData[174328] = { name = "Aberrant Voidfin",             quality = COMMON,   expansion = "BFA" }
FishData[174327] = { name = "Malformed Gnasher",            quality = COMMON,   expansion = "BFA" }

-- U'taka / Rasboralus (special rare fish)
FishData[162516] = { name = "Rasboralus",                   quality = COMMON,   expansion = "BFA" }
FishData[162517] = { name = "U'taka",                       quality = COMMON,   expansion = "BFA" }

-- Mechagon fish (Secret Fish of Mechagon achievement)
FishData[167654] = { name = "Bottom Feeding Stinkfish",     quality = COMMON,   expansion = "BFA" }
FishData[167655] = { name = "Bolted Steelhead",             quality = COMMON,   expansion = "BFA" }
FishData[167656] = { name = "Pond Hopping Springfish",      quality = COMMON,   expansion = "BFA" }
FishData[167657] = { name = "Shadowy Cave Eel",             quality = COMMON,   expansion = "BFA" }
FishData[167658] = { name = "Mechanical Blowfish",          quality = COMMON,   expansion = "BFA" }
FishData[167659] = { name = "Spitting Clownfish",           quality = COMMON,   expansion = "BFA" }
FishData[167660] = { name = "Sludge-fouled Carp",           quality = COMMON,   expansion = "BFA" }
FishData[167661] = { name = "Energized Lightning Cod",      quality = COMMON,   expansion = "BFA" }
FishData[167662] = { name = "Solarsprocket Barbel",         quality = COMMON,   expansion = "BFA" }
FishData[167663] = { name = "Tasty Steelfin",               quality = COMMON,   expansion = "BFA" }

-- Secret Fish (catchable anywhere / various zones)
FishData[167705] = { name = "Mechanized Mackerel",          quality = COMMON,   expansion = "BFA" }
FishData[167706] = { name = "Jade Story Fish",              quality = COMMON,   expansion = "BFA" }
FishData[167707] = { name = "Kirin Tor Clown",              quality = COMMON,   expansion = "BFA" }
FishData[167708] = { name = "Ancient Mana Fin",             quality = COMMON,   expansion = "BFA" }
FishData[167709] = { name = "Drowned Goldfish",             quality = COMMON,   expansion = "BFA" }
FishData[167710] = { name = "Barbed Fjord Fin",             quality = COMMON,   expansion = "BFA" }
FishData[167711] = { name = "Dead Fel Bone",                quality = COMMON,   expansion = "BFA" }
FishData[167712] = { name = "Rotted Blood Cod",             quality = COMMON,   expansion = "BFA" }
FishData[167713] = { name = "Veiled Ghost",                 quality = COMMON,   expansion = "BFA" }
FishData[167714] = { name = "Travelling Goby",              quality = COMMON,   expansion = "BFA" }
FishData[167715] = { name = "Elusive Moonfish",             quality = COMMON,   expansion = "BFA" }
FishData[167716] = { name = "Unseen Mimmic",                quality = COMMON,   expansion = "BFA" }
FishData[167717] = { name = "Camouflaged Snark",            quality = COMMON,   expansion = "BFA" }
FishData[167718] = { name = "Collectable Saltfin",          quality = COMMON,   expansion = "BFA" }
FishData[167719] = { name = "Golden Sunsoaker",             quality = COMMON,   expansion = "BFA" }
FishData[167720] = { name = "Very Tiny Whale",              quality = COMMON,   expansion = "BFA" }
FishData[167721] = { name = "Invisible Smelt",              quality = COMMON,   expansion = "BFA" }
FishData[167722] = { name = "Prisoner Fish",                quality = COMMON,   expansion = "BFA" }
FishData[167723] = { name = "Thunderous Flounder",          quality = COMMON,   expansion = "BFA" }
FishData[167724] = { name = "Tortollan Tank Dweller",       quality = COMMON,   expansion = "BFA" }
FishData[167725] = { name = "Spiritual Salmon",             quality = COMMON,   expansion = "BFA" }
FishData[167726] = { name = "Quiet Floater",                quality = COMMON,   expansion = "BFA" }
FishData[167727] = { name = "Deadeye Wally",                quality = COMMON,   expansion = "BFA" }
FishData[167728] = { name = "Queen's Delight",              quality = COMMON,   expansion = "BFA" }
FishData[167729] = { name = "Deceptive Maw",                quality = COMMON,   expansion = "BFA" }
FishData[167730] = { name = "Inconspicuous Catfish",        quality = COMMON,   expansion = "BFA" }
FishData[169870] = { name = "Displaced Scrapfin",           quality = COMMON,   expansion = "BFA" }
FishData[169884] = { name = "Green Roughy",                 quality = COMMON,   expansion = "BFA" }
FishData[169897] = { name = "Thin Air Flounder",            quality = COMMON,   expansion = "BFA" }
FishData[169898] = { name = "Well Lurker",                  quality = COMMON,   expansion = "BFA" }

-- Great Sea Ray (mount)
FishData[163131] = { name = "Great Sea Ray",                quality = EPIC,     expansion = "BFA" }

-------------------------------------------------------------------------------
-- Shadowlands
-------------------------------------------------------------------------------
FishData[173032] = { name = "Lost Sole",                    quality = COMMON,   expansion = "Shadowlands" }
FishData[173033] = { name = "Iridescent Amberjack",         quality = COMMON,   expansion = "Shadowlands" }
FishData[173034] = { name = "Silvergill Pike",              quality = COMMON,   expansion = "Shadowlands" }
FishData[173035] = { name = "Pocked Bonefish",              quality = COMMON,   expansion = "Shadowlands" }
FishData[173036] = { name = "Spinefin Piranha",             quality = COMMON,   expansion = "Shadowlands" }
FishData[173037] = { name = "Elysian Thade",                quality = COMMON,   expansion = "Shadowlands" }

-- Patch 9.2 (Zereth Mortis)
FishData[187702] = { name = "Precursor Placoderm",          quality = COMMON,   expansion = "Shadowlands" }

-- Pond Nettle (mount)
FishData[187872] = { name = "Pond Nettle",                  quality = EPIC,     expansion = "Shadowlands" }

-------------------------------------------------------------------------------
-- Dragonflight
-------------------------------------------------------------------------------
-- Common fish (all waters)
FishData[194730] = { name = "Scalebelly Mackerel",          quality = COMMON,   expansion = "Dragonflight" }

-- Freshwater
FishData[194966] = { name = "Thousandbite Piranha",         quality = COMMON,   expansion = "Dragonflight" }
FishData[194969] = { name = "Temporal Dragonhead",          quality = COMMON,   expansion = "Dragonflight" }

-- Saltwater / coastal
FishData[194967] = { name = "Aileron Seamoth",              quality = COMMON,   expansion = "Dragonflight" }
FishData[194968] = { name = "Cerulean Spinefish",           quality = COMMON,   expansion = "Dragonflight" }

-- Rare (all waters)
FishData[194970] = { name = "Islefin Dorado",               quality = UNCOMMON, expansion = "Dragonflight" }

-- Specialty / reputation-locked
FishData[199344] = { name = "Magma Thresher",               quality = RARE,     expansion = "Dragonflight" }
FishData[200061] = { name = "Prismatic Leaper",             quality = RARE,     expansion = "Dragonflight" }
FishData[200074] = { name = "Frosted Rimefin Tuna",         quality = RARE,     expansion = "Dragonflight" }

-- Clam
FishData[198395] = { name = "Dull Spined Clam",             quality = UNCOMMON, expansion = "Dragonflight" }

-- Mollusk meat (by-catch)
FishData[197742] = { name = "Ribbed Mollusk Meat",          quality = COMMON,   expansion = "Dragonflight" }

-------------------------------------------------------------------------------
-- TWW (The War Within)
-------------------------------------------------------------------------------
-- Common fish
FishData[220134] = { name = "Dilly-Dally Dace",             quality = COMMON,   expansion = "TWW" }
FishData[220135] = { name = "Bloody Perch",                 quality = COMMON,   expansion = "TWW" }
FishData[220136] = { name = "Crystalline Sturgeon",         quality = COMMON,   expansion = "TWW" }
FishData[220137] = { name = "Bismuth Bitterling",           quality = COMMON,   expansion = "TWW" }
FishData[220143] = { name = "Dornish Pike",                 quality = COMMON,   expansion = "TWW" }

-- Uncommon fish
FishData[220138] = { name = "Nibbling Minnow",              quality = UNCOMMON, expansion = "TWW" }
FishData[220139] = { name = "Whispering Stargazer",         quality = UNCOMMON, expansion = "TWW" }
FishData[220141] = { name = "Specular Rainbowfish",         quality = UNCOMMON, expansion = "TWW" }
FishData[220142] = { name = "Quiet River Bass",             quality = UNCOMMON, expansion = "TWW" }
FishData[220144] = { name = "Roaring Anglerseeker",         quality = UNCOMMON, expansion = "TWW" }
FishData[220145] = { name = "Arathor Hammerfish",           quality = UNCOMMON, expansion = "TWW" }
FishData[220147] = { name = "Kaheti Slum Shark",            quality = UNCOMMON, expansion = "TWW" }
FishData[220148] = { name = "Pale Huskfish",                quality = UNCOMMON, expansion = "TWW" }
FishData[222533] = { name = "Goldengill Trout",             quality = UNCOMMON, expansion = "TWW" }

-- Rare fish
FishData[220146] = { name = "Regal Dottyback",              quality = RARE,     expansion = "TWW" }
FishData[220149] = { name = "Sanguine Dogfish",             quality = RARE,     expansion = "TWW" }
FishData[220150] = { name = "Spiked Sea Raven",             quality = RARE,     expansion = "TWW" }
FishData[220151] = { name = "Queen's Lurefish",             quality = RARE,     expansion = "TWW" }
FishData[220152] = { name = "Cursed Ghoulfish",             quality = RARE,     expansion = "TWW" }
FishData[220153] = { name = "Awoken Coelacanth",            quality = RARE,     expansion = "TWW" }
FishData[227673] = { name = "\"Gold\" Fish",                quality = RARE,     expansion = "TWW" }

-- Kah, Legend of the Deep (mount — Derby Dash achievement)
FishData[223286] = { name = "Kah, Legend of the Deep",      quality = EPIC,     expansion = "TWW" }

-- Angler's Guide (teaches Find Fish spell)
FishData[228954] = { name = "Angler's Guide",               quality = RARE,     expansion = "TWW" }

-- Alternate item IDs (Source 1 variants)
FishData[222534] = { name = "Kaheti Slum Shark",            quality = COMMON,   expansion = "TWW" }

-------------------------------------------------------------------------------
-- Helper: get fish info (fills from cache if name unknown)
-------------------------------------------------------------------------------
function ns.GetFishInfo(itemID)
    local static = FishData[itemID]
    if static then return static end
    -- For fish not in static DB, return a minimal entry
    return { name = nil, quality = COMMON, expansion = "Unknown" }
end
