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

    -- Sub-achievements for Accomplished Angler (14 criteria)
    { id = 130,  name = "Grand Master Fisherman",           description = "Obtain 75 skill points in Northrend fishing.", category = "salty" },
    { id = 1257, name = "The Scavenger",                    description = "Successfully fish in each of the junk nodes listed.", category = "salty" },
    { id = 306,  name = "Master Angler of Azeroth",         description = "Win the Stranglethorn Fishing Extravaganza.", category = "salty" },
    { id = 878,  name = "One That Didn't Get Away",         description = "Catch one of the rare fish in the list.", category = "salty" },
    { id = 144,  name = "The Lurker Above",                 description = "Fish up The Lurker Below in Serpentshrine Cavern.", category = "salty" },
    { id = 1517, name = "Northrend Angler",                 description = "Catch from ten Northrend-specific fishing pools.", category = "salty" },
    { id = 1561, name = "1000 Fish",                        description = "Catch 1000 fish.", category = "salty" },
    { id = 153,  name = "The Old Gnome and the Sea",        description = "Successfully catch fish from fishing pools.", category = "salty" },
    { id = 150,  name = "The Fishing Diplomat",             description = "Fish in Orgrimmar and Stormwind.", category = "salty" },
    { id = 726,  name = "Mr. Pinchy's Magical Crawdad Box", description = "Fish up Mr. Pinchy in Terokkar Forest and grant a wish.", category = "salty" },
    { id = 905,  name = "Old Man Barlowned",                description = "Complete each of Old Man Barlo's fishing daily quests.", category = "salty" },
    { id = 1225, name = "Outland Angler",                   description = "Catch from six Outland-specific fishing pools.", category = "salty" },
    { id = 1243, name = "Fish Don't Leave Footprints",      description = "Learn the Find Fish ability.", category = "salty" },
    { id = 2096, name = "The Coin Master",                  description = "Complete the copper, silver, and gold coin achievements.", category = "salty" },

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
    { id = 12753, name = "Kul Tiran Fisherman",           description = "Become a Kul Tiran Fisherman.", category = "skill", faction = "Alliance" },
    { id = 12754, name = "Zandalari Fisherman",           description = "Become a Zandalari Fisherman.", category = "skill", faction = "Horde" },
    { id = 14333, name = "Shadowlands Fisherman",        description = "Obtain 200 skill points in Shadowlands fishing.", category = "skill" },
    { id = 16632, name = "Dragon Isles Fisherman",       description = "Obtain 100 skill points in Dragon Isles fishing.", category = "skill" },
    { id = 19415, name = "Algari Fisherman",              description = "Obtain 300 skill points in Khaz Algar fishing.", category = "skill" },
    { id = 42797, name = "Fishing at Midnight",           description = "Obtain 300 skill points in Midnight Fishing.", category = "skill" },

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
    { id = 5476,  name = "Fish or Cut Bait: Stormwind",   description = "Complete the Stormwind fishing daily.", category = "daily", faction = "Alliance" },
    { id = 5477,  name = "Fish or Cut Bait: Orgrimmar",   description = "Complete the Orgrimmar fishing daily.", category = "daily", faction = "Horde" },
    { id = 5847,  name = "Fish or Cut Bait: Ironforge",   description = "Complete the Ironforge fishing daily.", category = "daily", faction = "Alliance" },
    { id = 5848,  name = "Fish or Cut Bait: Darnassus",   description = "Complete the Darnassus fishing daily.", category = "daily", faction = "Alliance" },
    { id = 5849,  name = "Fish or Cut Bait: Thunder Bluff", description = "Complete the Thunder Bluff fishing daily.", category = "daily", faction = "Horde" },
    { id = 5850,  name = "Fish or Cut Bait: Undercity",   description = "Complete the Undercity fishing daily.", category = "daily", faction = "Horde" },
    { id = 3217,  name = "Chasing Marcia",                description = "Complete each of Marcia Chase's fishing daily quests.", category = "daily" },
    { id = 7614,  name = "Locking Down the Docks",        description = "Complete the Anglers fishing dailies in Pandaria.", category = "daily" },
    { id = 10598, name = "Fishing 'Round the Isles",      description = "Complete the Legion fishing world quests.", category = "daily" },

    -- ================================================================
    -- Dalaran Fountain Coins
    -- ================================================================
    { id = 2094,  name = "A Penny For Your Thoughts",     description = "Fish up all copper coins from the Dalaran fountain.", category = "fountain" },
    { id = 2095,  name = "Silver in the City",            description = "Fish up all silver coins from the Dalaran fountain.", category = "fountain" },
    { id = 1957,  name = "There's Gold In That There Fountain", description = "Fish up all gold coins from the Dalaran fountain.", category = "fountain" },

    -- ================================================================
    -- Rare Catches & Mounts
    -- ================================================================
    { id = 1836,  name = "Old Crafty",                    description = "Fish up Old Crafty in Orgrimmar.", category = "rare" },
    { id = 1837,  name = "Old Ironjaw",                   description = "Fish up Old Ironjaw in Ironforge.", category = "rare" },
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
    { id = 12758, name = "Baiting the Enemy",              description = "Fish up an U'taka within Dazar'alor in Zuldazar.", category = "expansion", expansion = "BFA", faction = "Alliance" },
    { id = 12759, name = "Baiting the Enemy",              description = "Fish up a Rasboralus within Proudmoore Keep in Tiragarde Sound.", category = "expansion", expansion = "BFA", faction = "Horde" },
    { id = 13489, name = "Secret Fish of Mechagon",       description = "Catch and deliver all secret fish of Mechagon to Danielle Anglers.", category = "expansion", expansion = "BFA" },
    { id = 13502, name = "Secret Fish and Where to Find Them", description = "Use the Secret Fish Goggles to collect all the secret fish.", category = "expansion", expansion = "BFA" },

    -- ================================================================
    -- Expansion Achievements — Dragonflight
    -- ================================================================
    { id = 16553, name = "Taking From Nature",             description = "Unlock 5 different fishing nets in Tuskarr Fishing Holes.", category = "expansion", expansion = "Dragonflight" },
    { id = 16550, name = "Giving Back to Nature",          description = "Restock 100 fish in Tuskarr Fishing Holes.", category = "expansion", expansion = "Dragonflight" },
    { id = 16561, name = "Lunkers, Lunkers Everywhere",    description = "Find 100 Lunkers while fishing with an Iskaaran Harpoon.", category = "expansion", expansion = "Dragonflight" },
    { id = 15889, name = "River Rapids Wrangler",          description = "Collect 40 fish during one session of Ruriq's River Rapids Ride.", category = "expansion", expansion = "Dragonflight" },
    { id = 17207, name = "Discombobberlated",              description = "Catch 100 fish with the Oversized Bobber.", category = "expansion", expansion = "Dragonflight" },
    { id = 17367, name = "Deadliest Cache",                description = "Fish up a Gurubashi Cache in Zul'Gurub.", category = "expansion", expansion = "Dragonflight" },

    -- ================================================================
    -- Expansion Achievements — TWW
    -- ================================================================
    { id = 40539, name = "The Derby Dash",               description = "Catch all 20 Algari fish during the Hallowfall Fishing Derby.", category = "expansion", expansion = "TWW" },

    -- ================================================================
    -- Expansion Achievements — Midnight: Abyss Anglers
    -- ================================================================

    -- Diving (11) — dive mechanics, breath, points, traversal
    { id = 62218, name = "Abyss Anglers: Even The Best",           description = "Run out of breath during an Abyss Anglers dive.",                        category = "abyss_anglers_diving", expansion = "Midnight" },
    { id = 62220, name = "Abyss Anglers: Proper Procedure",        description = "Exit an Abyss Anglers dive by swimming to the surface.",                 category = "abyss_anglers_diving", expansion = "Midnight" },
    { id = 62774, name = "Abyss Anglers: Not Done Yet",            description = "Abyss Anglers diving feat.",                                             category = "abyss_anglers_diving", expansion = "Midnight" },
    { id = 62221, name = "Abyss Anglers: Fresh Depth Nets",        description = "Swim through 25 Schools of Fish during a single Abyss Anglers dive.",    category = "abyss_anglers_diving", expansion = "Midnight" },
    { id = 62762, name = "Abyss Anglers: Top of the Class",        description = "Abyss Anglers diving feat.",                                             category = "abyss_anglers_diving", expansion = "Midnight" },
    { id = 62222, name = "Abyss Anglers: Free Transport",          description = "Get knocked away by a Brakpuffer during a dive.",                        category = "abyss_anglers_diving", expansion = "Midnight" },
    { id = 62219, name = "Abyss Anglers: No Sea Can Hold Me",      description = "Attempt to swim beyond the dive boundaries.",                            category = "abyss_anglers_diving", expansion = "Midnight" },
    { id = 62829, name = "Abyss Anglers: Don't Know What You Expected", description = "Abyss Anglers diving feat.",                                        category = "abyss_anglers_diving", expansion = "Midnight" },
    { id = 62777, name = "Abyss Anglers: Pearls to the Abyss",     description = "Abyss Anglers diving feat.",                                             category = "abyss_anglers_diving", expansion = "Midnight" },
    { id = 62272, name = "Abyss Anglers: Certified Depthdiver",    description = "Earn 250,000 points in cumulative Abyss Anglers dives.",                 category = "abyss_anglers_diving", expansion = "Midnight" },
    { id = 62761, name = "Abyss Anglers: One with the Depths",     description = "Earn 1,000,000 points in cumulative Abyss Anglers dives.",               category = "abyss_anglers_diving", expansion = "Midnight" },

    -- Fish (12) — catch counts, bait/dive suit gear unlocks
    { id = 62207, name = "Abyss Anglers: Reinforced Joints",       description = "Complete 10 successful dives in Abyss Anglers.",                         category = "abyss_anglers_fish", expansion = "Midnight" },
    { id = 62208, name = "Abyss Anglers: Depth Grease",            description = "Unlock Dive Suit Tier 3 (Swim Speed 150%).",                             category = "abyss_anglers_fish", expansion = "Midnight" },
    { id = 62271, name = "Abyss Anglers: Trench Berserker",        description = "Catch 100 creatures in Abyss Anglers.",                                  category = "abyss_anglers_fish", expansion = "Midnight" },
    { id = 62209, name = "Abyss Anglers: Pahk Trench Fins",        description = "Unlock Dive Suit Tier 4 (Swim Speed 200%).",                             category = "abyss_anglers_fish", expansion = "Midnight" },
    { id = 62760, name = "Abyss Anglers: Angler Physics",          description = "Abyss Anglers fish feat.",                                               category = "abyss_anglers_fish", expansion = "Midnight" },
    { id = 62117, name = "Abyss Anglers: Finnow Chum",             description = "Unlock Fishing Bait Tier 2 (Uncommon fish from Abyss Bubbles).",         category = "abyss_anglers_fish", expansion = "Midnight" },
    { id = 62118, name = "Abyss Anglers: Plecofin Bait",           description = "Unlock Fishing Bait Tier 3 (Rare fish from Abyss Bubbles).",             category = "abyss_anglers_fish", expansion = "Midnight" },
    { id = 62119, name = "Abyss Anglers: Murkskimmer Meat",        description = "Unlock Fishing Bait Tier 4.",                                            category = "abyss_anglers_fish", expansion = "Midnight" },
    { id = 62772, name = "Abyss Anglers: Now That's Anglin'",      description = "Abyss Anglers fish feat.",                                               category = "abyss_anglers_fish", expansion = "Midnight" },
    { id = 62776, name = "Abyss Anglers: All Blue Angler",         description = "Abyss Anglers fish feat.",                                               category = "abyss_anglers_fish", expansion = "Midnight" },
    { id = 62778, name = "Abyss Anglers: Luck of the Loa",         description = "Abyss Anglers fish feat.",                                               category = "abyss_anglers_fish", expansion = "Midnight" },
    { id = 62832, name = "Abyss Anglers: Reservation for One",     description = "Abyss Anglers fish feat.",                                               category = "abyss_anglers_fish", expansion = "Midnight" },

    -- Creatures (9) — harpoon upgrades, oxygen upgrades, rare catches
    { id = 62215, name = "Abyss Anglers: Heavy Harpoon Cannon",    description = "Unlock Harpoon upgrade.",                                                category = "abyss_anglers_creatures", expansion = "Midnight" },
    { id = 62216, name = "Abyss Anglers: Hollowcore Harpoon Turret", description = "Unlock advanced Harpoon upgrade.",                                     category = "abyss_anglers_creatures", expansion = "Midnight" },
    { id = 62775, name = "Abyss Anglers: Delicate Diver",          description = "Abyss Anglers creatures feat.",                                          category = "abyss_anglers_creatures", expansion = "Midnight" },
    { id = 62210, name = "Abyss Anglers: Depthdiver's Used Tank",  description = "Unlock Oxygen Tank Tier 2 (Max Oxygen 250).",                            category = "abyss_anglers_creatures", expansion = "Midnight" },
    { id = 62211, name = "Abyss Anglers: Fathom-Tested Tank",      description = "Unlock Oxygen Tank Tier 3 (Max Oxygen 300).",                            category = "abyss_anglers_creatures", expansion = "Midnight" },
    { id = 62212, name = "Abyss Anglers: Nalorakk's Breath Tank",  description = "Unlock Oxygen Tank Tier 4 (Max Oxygen 350).",                            category = "abyss_anglers_creatures", expansion = "Midnight" },
    { id = 62506, name = "Abyss Anglers: Pressurized Eyeglass",    description = "Unlock ability to find Ancient Treasures during dives.",                 category = "abyss_anglers_creatures", expansion = "Midnight" },
    { id = 62342, name = "Abyss Anglers: The Finest of Fish",      description = "Catch a Golden creature during an Abyss Anglers dive.",                  category = "abyss_anglers_creatures", expansion = "Midnight" },
    { id = 62343, name = "Abyss Anglers: Myths from Beneath",      description = "Catch a Mythic creature 6 times from Abyss Anglers dives.",              category = "abyss_anglers_creatures", expansion = "Midnight" },

    -- Relics (6) — net upgrades, treasure/relic feats, meta
    { id = 62759, name = "Abyss Anglers: History Below",           description = "Abyss Anglers relics feat.",                                             category = "abyss_anglers_relics", expansion = "Midnight" },
    { id = 62213, name = "Abyss Anglers: Shallows Net",            description = "Unlock Small Net Tier 1 (Barbed Crawlers, Thorny Seashorses).",          category = "abyss_anglers_relics", expansion = "Midnight" },
    { id = 62214, name = "Abyss Anglers: Triple-Thread Net",       description = "Unlock Small Net Tier 2 (Deep Whelks, Bilejellies).",                    category = "abyss_anglers_relics", expansion = "Midnight" },
    { id = 62763, name = "Abyss Anglers: Vintage Collector",       description = "Abyss Anglers relics feat.",                                             category = "abyss_anglers_relics", expansion = "Midnight" },
    { id = 62773, name = "Abyss Anglers: Jeju's New Rival",        description = "Abyss Anglers relics feat.",                                             category = "abyss_anglers_relics", expansion = "Midnight" },
    { id = 62217, name = "Abyss Anglers: Idol of the Depths",      description = "Complete all Abyss Anglers achievements.",                               category = "abyss_anglers_relics", expansion = "Midnight", isMeta = true },

    -- ================================================================
    -- Expansion Achievements — Midnight: Cursed Fishing (12.1)
    -- Meta is "Tokka's Terrible Trials" (63635) -> Title: Bloodsworn Mariner
    -- ================================================================
    { id = 63635, name = "Tokka's Terrible Trials",       description = 'Complete the Cursed Fishing achievements below. Rewards the "Bloodsworn Mariner" title.', category = "cursed_fishing", expansion = "Midnight", isMeta = true },
    { id = 63629, name = "Angler of The Coiled Isle",     description = "Catch every fish from The Coiled Isle. Rewards the Sinful Pearl.",                       category = "cursed_fishing", expansion = "Midnight" },
    { id = 63632, name = "Toxic Trophies",                description = "Reach Trophy rank \226\128\148 the top Catch Rank \226\128\148 with all 8 fish listed.",  category = "cursed_fishing", expansion = "Midnight" },
    { id = 63631, name = "Captain Tokka's Crew",          description = 'Reach "Bloodsworn Crew" with Captain Tokka.',                                            category = "cursed_fishing", expansion = "Midnight" },
    { id = 63634, name = "Where Did You Get That?",       description = "Speak with Captain Tokka while The Coiled Huntress is equipped.",                        category = "cursed_fishing", expansion = "Midnight" },

    -- Related Coiled Isle fishing achievements (not part of the meta)
    { id = 63512, name = "Treasures of the Damned",       description = "Fish up all 10 artifacts from Tokka's departed crewmates on the Coiled Isle.",           category = "cursed_fishing", expansion = "Midnight" },

    -- ================================================================
    -- Expansion Achievements — Midnight (Fishing Journal)
    -- ================================================================
    { id = 63510, name = "The Briny Best",                description = 'Reach 2500 Midnight Anglin\' Score in the Fishing Journal. Rewards the "Briny" title.',  category = "expansion", expansion = "Midnight" },

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
        itemID = 23720,
        name = "Riding Turtle",
        spellID = 30174,
        source = "TCG Loot Card (unobtainable)",
        zones = "N/A",
        expansion = "Classic",
    },
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
        itemID = 166471,
        name = "Saltwater Seahorse",
        spellID = 288711,
        source = "Island Expeditions (500 Seafarer's Dubloons)",
        zones = "Island Expeditions vendor",
        expansion = "BFA",
    },
    {
        itemID = 152912,
        name = "Pond Nettle",
        spellID = 253711,
        source = "Rare catch from Argus fel pools",
        zones = "Krokuun, Antoran Wastes (Argus)",
        expansion = "Legion",
    },
    {
        itemID = 187676,
        name = "Deepstar Aurelid",
        spellID = 342680,
        source = "Zereth Mortis — defeat Hirukon with Aurelid Lure",
        zones = "Zereth Mortis",
        expansion = "Shadowlands",
    },
    {
        itemID = 223286,
        name = "Kah, Legend of the Deep",
        spellID = 448850,
        source = "The Derby Dash achievement (Hallowfall Fishing Derby)",
        zones = "Hallowfall",
        expansion = "TWW",
    },
    {
        itemID = 275653,
        name = "Sea-Dwelling Isle Serpent",
        spellID = 1297216,
        source = "Second Mate Sluggs \226\128\148 2,500 Coiled Filament (Bloodsworn Crew)",
        zones = "The Coiled Isle",
        expansion = "Midnight",
    },
}

-------------------------------------------------------------------------------
-- Fishing Pets
-------------------------------------------------------------------------------
AchievementData.PETS = {
    {
        itemID = 27445,
        name = "Magical Crawdad",
        speciesID = 132,
        source = "Mr. Pinchy wish (Terokkar Forest highland mixed schools)",
        expansion = "TBC",
    },
    {
        itemID = 43698,
        name = "Giant Sewer Rat",
        speciesID = 193,
        source = "Fished from Dalaran sewers (Northrend)",
        expansion = "WotLK",
    },
    {
        itemID = 35348,
        name = "Chuck",
        speciesID = 174,
        source = "Fishing daily reward bag (Shattrath)",
        expansion = "TBC",
    },
    {
        itemID = 35349,
        name = "Muckbreath",
        speciesID = 164,
        source = "Fishing daily reward bag (Shattrath)",
        expansion = "TBC",
    },
    {
        itemID = 33818,
        name = "Toothy",
        speciesID = 163,
        source = "Fishing daily reward bag (Shattrath)",
        expansion = "TBC",
    },
    {
        itemID = 35350,
        name = "Snarly",
        speciesID = 173,
        source = "Fishing daily reward bag (Shattrath)",
        expansion = "TBC",
    },
    {
        itemID = 44983,
        name = "Strand Crawler",
        speciesID = 211,
        source = "Fishing daily reward bag (Dalaran)",
        expansion = "WotLK",
    },
    {
        itemID = 73953,
        name = "Sea Pony",
        speciesID = 340,
        source = "Darkmoon Island shipwreck debris",
        expansion = "Cataclysm",
    },
    {
        itemID = 94932,
        name = "Tiny Red Carp",
        speciesID = 1206,
        source = "Rare catch from Townlong Steppes / Dread Wastes",
        expansion = "MoP",
    },
    {
        itemID = 94933,
        name = "Tiny Blue Carp",
        speciesID = 1207,
        source = "Rare catch from Vale of Eternal Blossoms",
        expansion = "MoP",
    },
    {
        itemID = 94934,
        name = "Tiny Green Carp",
        speciesID = 1208,
        source = "Rare catch from Jade Forest / Valley of Four Winds / Krasarang Wilds",
        expansion = "MoP",
    },
    {
        itemID = 94935,
        name = "Tiny White Carp",
        speciesID = 1209,
        source = "Rare catch from Kun-Lai Summit",
        expansion = "MoP",
    },
    {
        itemID = 84105,
        name = "Fishy",
        speciesID = 847,
        source = "Quest reward (Krasarang Wilds)",
        expansion = "MoP",
    },
    {
        itemID = 117404,
        name = "Land Shark",
        speciesID = 115,
        source = "Nat Pagle — Garrison Fishing Shack (Nat's Lucky Coins)",
        expansion = "WoD",
    },
    {
        itemID = 114919,
        name = "Sea Calf",
        speciesID = 1448,
        source = "Nat Pagle — Garrison Fishing Shack (Nat's Lucky Coins)",
        expansion = "WoD",
    },
    {
        itemID = 127856,
        name = "Left Shark",
        speciesID = 1687,
        source = "Garrison Shipyard mission",
        expansion = "WoD",
    },
    {
        itemID = 152555,
        name = "Ghost Shark",
        speciesID = 2077,
        source = "Ilyssia of the Waters (Good Friend rep)",
        expansion = "Legion",
    },
    {
        itemID = 138810,
        name = "Sting Ray Pup",
        speciesID = 1911,
        source = "Conjurer Margoss (Good Friend, 50 Mana)",
        expansion = "Legion",
    },
    {
        itemID = 143842,
        name = "Trashy",
        speciesID = 2004,
        source = "Conjurer Margoss (Best Friend, 50 Mana)",
        expansion = "Legion",
    },
    {
        itemID = 260942,
        name = "Bubbly Snapling",
        speciesID = 4951,
        source = "Patient Treasure (random spawn while fishing Midnight pools)",
        expansion = "Midnight",
    },
    {
        itemID = 274266,
        name = "Ka'bubb",
        speciesID = 5065,
        source = "Depthdiver Tu'nakit (2500 Angler Pearls)",
        expansion = "Midnight",
    },
    {
        itemID = 275020,
        name = "Venom Elemental",
        speciesID = 5070,
        source = "Second Mate Sluggs (Captain Tokka \226\128\148 Venom Trawler)",
        expansion = "Midnight",
    },
}

-------------------------------------------------------------------------------
-- Underlight Angler (Legion Artifact Fishing Pole)
-------------------------------------------------------------------------------
AchievementData.UNDERLIGHT_ANGLER = {
    itemID = 133755,
    achievementID = 10596,  -- Bigger Fish to Fry
    questline = {
        { questID = 40960, name = "Luminous Pearl",        description = "Fish up the Luminous Pearl from any Legion rare fish pool (requires Bigger Fish to Fry)" },
        { questID = 40961, name = "The Dalaran Fountain",  description = "Bring the Luminous Pearl to the Dalaran fountain" },
        { questID = 41010, name = "Fish Frenzy",           description = "Complete the Fish Frenzy scenario to receive the Underlight Angler" },
    },
    rareFish = {
        { zone = "Azsuna", fish = {
            { itemID = 133725, name = "Leyshimmer Blenny",   baitID = 133701, baitName = "Skrog Toenail" },
            { itemID = 133726, name = "Nar'thalas Hermit",   baitID = 133703, baitName = "Pearlescent Conch" },
            { itemID = 133727, name = "Ghostly Queenfish",   baitID = 133704, baitName = "Rusty Queenfish Brooch" },
        }},
        { zone = "Val'sharah", fish = {
            { itemID = 133730, name = "Ancient Mossgill",    baitID = 133705, baitName = "Rotten Fishbone" },
            { itemID = 133728, name = "Terrorfin",           baitID = 133707, baitName = "Nightmare Nightcrawler" },
            { itemID = 133729, name = "Thorned Flounder",    baitID = 133708, baitName = "Drowned Thistleleaf" },
        }},
        { zone = "Highmountain", fish = {
            { itemID = 133731, name = "Mountain Puffer",            baitID = 133711, baitName = "Swollen Murloc Egg" },
            { itemID = 133732, name = "Coldriver Carp",             baitID = 133712, baitName = "Frost Worm" },
            { itemID = 133733, name = "Ancient Highmountain Salmon", baitID = 133709, baitName = "Funky Sea Snail" },
        }},
        { zone = "Stormheim", fish = {
            { itemID = 133734, name = "Oodelfjisk",          baitID = 133715, baitName = "Ancient Vrykul Ring" },
            { itemID = 133735, name = "Graybelly Lobster",   baitID = 133716, baitName = "Soggy Drakescale" },
            { itemID = 133736, name = "Thundering Stormray", baitID = 133713, baitName = "Moosehorn Hook" },
        }},
        { zone = "Suramar", fish = {
            { itemID = 133737, name = "Magic-Eater Frog",      baitID = 133717, baitName = "Enchanted Lure" },
            { itemID = 133738, name = "Seerspine Puffer" },
            { itemID = 133739, name = "Tainted Runescale Koi", baitID = 133720, baitName = "Demonic Detritus" },
        }},
        { zone = "Open Ocean", fish = {
            { itemID = 133740, name = "Axefish",                baitID = 133722, baitName = "Axefish Lure" },
            { itemID = 133741, name = "Seabottom Squid" },
            { itemID = 133742, name = "Ancient Black Barracuda", baitID = 133724, baitName = "Decayed Whale Blubber" },
        }},
    },
    arcaneLure = { itemID = 139175, name = "Arcane Lure", source = "Conjurer Margoss (1 Drowned Mana)" },
    tips = {
        "Baits are tradeable — check the Auction House before farming.",
        "Ghostly Queenfish and Oodelfjisk pools never despawn, great for power-leveling the artifact.",
    },
    traits = {
        { name = "Surface Tension",        description = "Walk on water while the line is not cast (disabled in combat)" },
        { name = "Undercurrent",           description = "Chance to swim faster while fishing" },
        { name = "Way of the Flounder",    description = "Stealth effect with reduced aggro range while line is cast" },
        { name = "Fishrender's Blessing",  description = "Transform into a fish for underwater speed" },
        { name = "Better Lucky Than Good", description = "Chance to find rare fish" },
        { name = "Wish Upon a Fish",       description = "Chance to catch additional fish" },
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
-- Cursed Fishing — The Coiled Isle (Midnight 12.1)
--
-- Loop: clear a Curse Surge to open cursed water at that spot (warband-wide),
-- fish it, then siphon the venom off The Coiled Huntress into Coiled Filament
-- and spend it with Second Mate Sluggs.
-------------------------------------------------------------------------------
AchievementData.CURSED_FISHING = {
    mapID        = 2512,               -- The Coiled Isle
    factionID    = 2773,               -- Captain Tokka (friendship reputation)
    factionName  = "Captain Tokka",
    currencyID   = 3546,               -- Coiled Filament
    currencyName = "Coiled Filament",
    metaAchievementID = 63635,         -- Tokka's Terrible Trials
    anglerAchievementID = 63629,       -- Angler of The Coiled Isle
    trophyAchievementID = 63632,       -- Toxic Trophies
    treasureAchievementID = 63512,     -- Treasures of the Damned
    rodItemID    = 244790,             -- The Coiled Huntress

    -- The rod's venom balance has no currency and no aura. It lives in a
    -- character data element that is only surfaced through the description of
    -- The Coiled Huntress's on-equip effect ("Prof Gear Venom Bonus"), which
    -- the client substitutes at render time as "+N Venom".
    venomSpellID = 1305168,

    -- Friendship ranks, in order. Sluggs gates his stock on these.
    ranks = {
        "Stranger",
        "Doomed Sailor",
        "Cursed Angler",
        "Venom Trawler",
        "Bloodsworn Crew",
    },

    -- The 14 "Angler of The Coiled Isle" criteria, in achievement order
    achievementFish = {
        274587, -- Spotted Killifish
        274589, -- Ula'tek Snakehead
        274591, -- Coiled Stargorger
        274594, -- Polluted Puffer
        279091, -- Oozing Goby
        279094, -- Grotesque Sturgeon
        279105, -- Twin-Headed Snipefish
        274592, -- Dirty Darter
        274590, -- Sulfurous Sludgefish
        274588, -- Toxic Tlhapi
        274593, -- Blightswarmer
        279093, -- Giggling Skull
        279100, -- Many-Eyed Flounder
        279106, -- Loathsome Anglerfish
    },

    -- "Toxic Trophies" (63632) — reach Trophy rank, the 5th and top Catch Rank,
    -- with each of these 8. The rank is readable: the fishing journal prints it
    -- in each fish's recipe description, which ProfessionDataProvider parses.
    trophyFish = {
        274592, -- Dirty Darter
        274587, -- Spotted Killifish
        274588, -- Toxic Tlhapi
        274594, -- Polluted Puffer
        274590, -- Sulfurous Sludgefish
        274593, -- Blightswarmer
        274591, -- Coiled Stargorger
        274589, -- Ula'tek Snakehead
    },

    -- "Treasures of the Damned" (63512) — 10 artifacts fished out of the isle
    treasures = {
        { itemID = 279384, name = "Bonemail Gauntlet" },
        { itemID = 278001, name = "Forgotten Amani Fishing Rod" },
        { itemID = 277989, name = "Ghostcaller's Bell" },
        { itemID = 277997, name = "Malevolent Fishing Codex" },
        { itemID = 277998, name = "Lump of Crystalline Malachite" },
        { itemID = 277999, name = "Ritual Dagger" },
        { itemID = 278000, name = "Sealed Vial of Mysterious Green Liquid" },
        { itemID = 277991, name = "Shrieking Tacklebox" },
        { itemID = 277993, name = "Spiritsurge Incense" },
        { itemID = 277996, name = "Summoning Salt" },
    },

    -- Second Mate Sluggs, Tokka's Folly (/way #2512 51.6 49.8).
    -- rank = required Captain Tokka rank (1 = Stranger .. 5 = Bloodsworn Crew).
    -- cost = Coiled Filament, where the price is confirmed.
    --
    -- rewards: permanent collectibles, so we can show real collected state.
    rewards = {
        { itemID = 275653, name = "Sea-Dwelling Isle Serpent", rank = 5, cost = 2500, checkType = "mount",    spellID = 1297216 },
        { itemID = 244790, name = "The Coiled Huntress",       rank = 5,              checkType = "transmog" },
        { itemID = 274814, name = "Envenomed Game Ripper",     rank = 5, cost = 1000, checkType = "transmog" },
        { itemID = 274802, name = "Envenomed Gavel",           rank = 5, cost = 500,  checkType = "transmog" },
        { itemID = 274796, name = "Envenomed Deathblade",      rank = 5,              checkType = "transmog" },
        { itemID = 275020, name = "Venom Elemental",           rank = 4,              checkType = "pet",      speciesID = 5070 },
    },

    -- supplies: consumables, recipes and rod materials. There is no reliable
    -- "do you own this" check for a learned recipe or a spent consumable, so
    -- these are listed for reference only — never with a collected state.
    supplies = {
        { itemID = 281022, name = "Eerie Lure",                     rank = 1 },
        { itemID = 262792, name = "Shredded Bloomline",             rank = 1, cost = 10 },
        { itemID = 262797, name = "Shredded Glimmerline",           rank = 1, cost = 10 },
        { itemID = 278332, name = "Recipe: Puffer Plate",           rank = 2 },
        { itemID = 275018, name = "Recipe: Coiled Stargorger Lure", rank = 3 },
        { itemID = 271891, name = "Recipe: Alluring Nostrum",       rank = 3 },
        { itemID = 275012, name = "Recipe: Tokka's Multi-Ward",     rank = 4 },
        { itemID = 275301, name = "Recipe: Feast of Knowledge",     rank = 4 },
        { itemID = 278391, name = "Eerie Bauble",                   rank = 4 },
    },
}

-------------------------------------------------------------------------------
-- Anglers Reputation (MoP)
-------------------------------------------------------------------------------
AchievementData.ANGLERS = {
    factionID = 1302,
    name = "The Anglers",
    friendshipItems = {
        { itemID = 88710, name = "Nat's Hat",           repRequired = "Best Friend" },
        { itemID = 86596, name = "Nat's Fishing Chair", repRequired = "Best Friend" },
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
        local _, _, _, _, _, _, _, _, _, icon = C_Item.GetItemInfo(itemID)
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

--- Read a friendship-style reputation (Captain Tokka, Nat Pagle, Margoss...).
--- Returns rankIndex (1-based, nil if unknown), rankName, current, needed.
--- current/needed describe progress within the current rank.
function ns.GetFriendshipRank(factionID, rankNames)
    if not C_GossipInfo or not C_GossipInfo.GetFriendshipReputation then return nil end
    local info = C_GossipInfo.GetFriendshipReputation(factionID)
    if not info or not info.friendshipFactionID or info.friendshipFactionID == 0 then return nil end

    local rankIndex
    if rankNames then
        for i, name in ipairs(rankNames) do
            if name == info.reaction then
                rankIndex = i
                break
            end
        end
    end

    local floor_ = info.reactionThreshold or 0
    local cap = info.nextThreshold
    local current = (info.standing or 0) - floor_
    local needed = cap and (cap - floor_) or nil

    return rankIndex, info.reaction, current, needed
end

--- Venom currently banked in The Coiled Huntress, or nil if it can't be read.
---
--- There is no currency or aura for this. The only place the game exposes the
--- number is the rod's on-equip effect description, where "$@cdataelem592" is
--- substituted client-side into "+N Venom". Spell descriptions are lazily
--- loaded, so an early call can legitimately come back empty — callers should
--- treat nil as "unknown", not as zero.
function ns.GetRodVenom()
    local spellID = AchievementData.CURSED_FISHING.venomSpellID
    local desc
    if C_Spell and C_Spell.GetSpellDescription then
        desc = C_Spell.GetSpellDescription(spellID)
    elseif GetSpellDescription then
        desc = GetSpellDescription(spellID)
    end
    if not desc or desc == "" then return nil end

    local amount = desc:match("%+%s*([%d,]+)%s+Venom")
    if not amount then return nil end
    return tonumber((amount:gsub(",", "")))
end

--- Has the player collected this item's transmog appearance?
function ns.HasTransmogAppearance(itemID)
    if not C_TransmogCollection or not C_TransmogCollection.PlayerHasTransmogByItemInfo then
        return false
    end
    local ok, has = pcall(C_TransmogCollection.PlayerHasTransmogByItemInfo, itemID)
    return ok and has or false
end
