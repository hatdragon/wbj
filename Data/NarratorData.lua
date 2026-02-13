local _, ns = ...

-------------------------------------------------------------------------------
-- NarratorData — NPC narrator definitions + flavor text
--
-- Each narrator has:
--   id          = unique string key
--   name        = NPC display name
--   title       = title/subtitle
--   displayID   = creature display ID (for SetPortraitTextureFromCreatureDisplayID)
--   expansion   = expansion tag
--   quotes      = { section/context keyed flavor strings }
-------------------------------------------------------------------------------
local Narrators = {}
ns.Narrators = Narrators

-- Narrator IDs (constants for referencing)
ns.NARRATOR = {
    NAT_PAGLE           = "nat_pagle",
    CATHERINE_LELAND    = "catherine_leland",
    LUMAK               = "lumak",
    GRIMNUR_STONEBRAND  = "grimnur_stonebrand",
    ASTAIA              = "astaia",
    ARMAND_CROMWELL     = "armand_cromwell",
    OLD_MAN_BARLO       = "old_man_barlo",
    JUNO_DUFRAIN        = "juno_dufrain",
    MARCIA_CHASE        = "marcia_chase",
    OLD_MAN_ROBERT      = "old_man_robert",
    ELDER_CLEARWATER    = "elder_clearwater",
    BEN_OF_BOOMING      = "ben_of_booming",
    NAT_PAGLE_GARRISON  = "nat_pagle_garrison",
    RON_ASHTON          = "ron_ashton",
    CONJURER_MARGOSS    = "conjurer_margoss",
    SHALETH             = "shaleth",
    MARCIA_CHASE_LEGION = "marcia_chase_legion",
    RAZGAR              = "razgar",
    ALAN                = "alan",
    AULARRYNAR          = "aularrynar",
    TUSKARR_ELDER       = "tuskarr_elder",
}

local N = ns.NARRATOR

-------------------------------------------------------------------------------
-- Narrator Definitions
-------------------------------------------------------------------------------
Narrators[N.NAT_PAGLE] = {
    id = N.NAT_PAGLE,
    name = "Nat Pagle",
    title = "Master Angler",
    displayID = 13099,
    expansion = "Classic",
    quotes = {
        catchLog = {
            "Every fish has a story, friend. Some just take longer to tell.",
            "That's a fine haul you've got there. I'm almost impressed.",
            "You know what they say\226\128\148the best fisherman is the one who caught the most fish.",
            "I've seen a lot of catches in my day. Yours are... gettin' there.",
            "Keep at it. The fish ain't goin' nowhere. Well, they might, but you get the idea.",
        },
        spotGuide = {
            "Now that's a spot I know well. Pull up a chair and cast a line.",
            "Good water there. I've spent many a lazy afternoon in those parts.",
        },
        collections = {
            "Collectin' things, are ya? I've got a shed full of stuff I've pulled out of the water.",
            "Some of the rarest catches take patience. Years of it, sometimes.",
        },
        default = {
            "Mornin'. Or evenin'. Hard to tell when you've been fishin' all day.",
            "The secret to fishin'? There ain't one. Just fish.",
        },
    },
}

Narrators[N.CATHERINE_LELAND] = {
    id = N.CATHERINE_LELAND,
    name = "Catherine Leland",
    title = "Fishing Supplier, Stormwind",
    displayID = 99496,
    expansion = "Classic",
    quotes = {
        spotGuide = {
            "The canals of Stormwind are teeming with fish, if you know where to look.",
            "Eastern Kingdoms waters are rich and varied. A good net helps, but patience helps more.",
        },
        default = {
            "Welcome to my shop, friend. Looking for bait, or just advice?",
            "The harbor's been busy lately, but the fish don't seem to mind.",
        },
    },
}

Narrators[N.LUMAK] = {
    id = N.LUMAK,
    name = "Lumak",
    title = "Fishing Trainer, Orgrimmar",
    displayID = 1332,
    expansion = "Classic",
    quotes = {
        spotGuide = {
            "Kalimdor's waters run deep and wild. You want fish? You earn them.",
            "The oases of the Barrens hold more than you'd think, greenskin.",
        },
        default = {
            "Fishing is about strength and patience. You need both.",
            "The rivers of Durotar are harsh, but the fish are worth it.",
        },
    },
}

Narrators[N.GRIMNUR_STONEBRAND] = {
    id = N.GRIMNUR_STONEBRAND,
    name = "Grimnur Stonebrand",
    title = "Fishing Trainer, Ironforge",
    displayID = 3096,
    expansion = "Classic",
    quotes = {
        spotGuide = {
            "The Forlorn Pool's got some fine specimens, if ye can stand the cold.",
            "Loch Modan's a bonny fishing spot. Bring a warm ale.",
        },
        default = {
            "Ach, another angler! Good to see. The loch won't fish itself.",
        },
    },
}

Narrators[N.ASTAIA] = {
    id = N.ASTAIA,
    name = "Astaia",
    title = "Fishing Trainer, Darnassus",
    displayID = 2211,
    expansion = "Classic",
    quotes = {
        spotGuide = {
            "The moonwells hold ancient fish, blessed by Elune's light.",
            "Teldrassil's waters are serene. Fish here, and find peace.",
        },
        default = {
            "The waters of Teldrassil remember what the land has forgotten.",
        },
    },
}

Narrators[N.ARMAND_CROMWELL] = {
    id = N.ARMAND_CROMWELL,
    name = "Armand Cromwell",
    title = "Fishing Trainer, Undercity",
    displayID = 2612,
    expansion = "Classic",
    quotes = {
        spotGuide = {
            "The green waters of the Undercity yield... unique catches.",
            "Tirisfal's ponds are quiet. The fish there have seen better days. So have I.",
        },
        default = {
            "Don't let the smell put you off. Some of the best catches come from the worst water.",
        },
    },
}

Narrators[N.OLD_MAN_BARLO] = {
    id = N.OLD_MAN_BARLO,
    name = "Old Man Barlo",
    title = "Fishing Daily, Terokkar Forest",
    displayID = 23548,
    expansion = "TBC",
    quotes = {
        spotGuide = {
            "Outland's waters are strange, friend. Fish with scales that shimmer like nether-light.",
            "Zangarmarsh is a fisherman's paradise\226\128\148if you don't mind the spores.",
            "Terokkar's lakes hold secrets. Fish patiently, and they'll share them.",
        },
        catchLog = {
            "You've been busy. I can tell by the state of your boots.",
            "A good day's haul. Reminds me of my younger years by Silmyr Lake.",
        },
        default = {
            "Pull up a stool, young one. The fish'll wait. They always do.",
            "I've fished every body of water in Outland. Some of 'em even had water.",
        },
    },
}

Narrators[N.JUNO_DUFRAIN] = {
    id = N.JUNO_DUFRAIN,
    name = "Juno Dufrain",
    title = "Fishing Trainer, Zangarmarsh",
    displayID = 18320,
    expansion = "TBC",
    quotes = {
        spotGuide = {
            "The marshlands are alive with fish. Just watch out for the bog lords.",
        },
        default = {
            "Zangarmarsh may look murky, but the fishing here is second to none.",
        },
    },
}

Narrators[N.MARCIA_CHASE] = {
    id = N.MARCIA_CHASE,
    name = "Marcia Chase",
    title = "Fishing Daily, Dalaran",
    displayID = 25655,
    expansion = "WotLK",
    quotes = {
        spotGuide = {
            "Northrend's waters are frigid but bountiful. Dress warmly.",
            "The Dalaran fountain holds more coins than fish, but don't tell anyone I said that.",
        },
        collections = {
            "You're making excellent progress. I keep careful records, you know.",
            "Organization is key. I've catalogued every fish in the Dalaran fountain.",
            "The Salty title isn't earned overnight. But you're on the right track.",
        },
        catchLog = {
            "A tidy log is a sign of a serious angler. Well done.",
        },
        default = {
            "Good morning! I have today's fishing daily ready, if you're interested.",
            "The fountain's been generous today. Or maybe that's just the tourists.",
        },
    },
}

Narrators[N.OLD_MAN_ROBERT] = {
    id = N.OLD_MAN_ROBERT,
    name = "Old Man Robert",
    title = "Howling Fjord",
    displayID = 24291,
    expansion = "WotLK",
    quotes = {
        spotGuide = {
            "The fjords are cold, but the fish are plentiful if you know the currents.",
        },
        default = {
            "In my day, we fished through ice three feet thick. Uphill both ways.",
        },
    },
}

Narrators[N.RAZGAR] = {
    id = N.RAZGAR,
    name = "Razgar",
    title = "Fishing Trainer, Orgrimmar",
    displayID = 35301,
    expansion = "Cataclysm",
    quotes = {
        spotGuide = {
            "The Cataclysm changed the waters. New fish in old places, old fish in new ones.",
        },
        default = {
            "The world broke, but the fish adapted. So should you.",
        },
    },
}

Narrators[N.ELDER_CLEARWATER] = {
    id = N.ELDER_CLEARWATER,
    name = "Elder Clearwater",
    title = "The Anglers, Krasarang Wilds",
    displayID = 23657,
    expansion = "MoP",
    quotes = {
        spotGuide = {
            "Pandaria's waters are as deep as its mysteries. Cast carefully.",
            "The Krasarang coast has fed my people for generations.",
            "Every fish in Pandaria has a lesson to teach, if you are willing to listen.",
        },
        catchLog = {
            "Your catches honor the tradition of the Anglers. Well done, friend.",
        },
        collections = {
            "The Anglers welcome all who respect the water. Your reputation grows.",
        },
        default = {
            "Patience is the first lesson of the angler. The fish is the reward.",
            "Welcome, friend. The Anglers are always glad to meet a fellow fisher.",
        },
    },
}

Narrators[N.BEN_OF_BOOMING] = {
    id = N.BEN_OF_BOOMING,
    name = "Ben of the Booming Voice",
    title = "The Anglers",
    displayID = 48038,
    expansion = "MoP",
    quotes = {
        catchLog = {
            "THAT'S what I'm talking about! Look at the SIZE of that haul!",
            "You call that a catch? I've seen BIGGER! ...Just kidding, that's GREAT!",
        },
        default = {
            "FISH! FISH! FISH! There's nothing better in this world!",
            "You want to be an Angler? Then FISH HARDER!",
        },
    },
}

Narrators[N.NAT_PAGLE_GARRISON] = {
    id = N.NAT_PAGLE_GARRISON,
    name = "Nat Pagle",
    title = "Fishing Shack, Garrison",
    displayID = 13099,
    expansion = "WoD",
    quotes = {
        spotGuide = {
            "Draenor's got some mighty fine fishing holes. Reminds me of the old days.",
            "Them lunkers ain't gonna catch themselves. Well, they might, but where's the fun in that?",
            "The Garrison pond's small, but it's mine. And the fish know it.",
        },
        collections = {
            "My Lucky Coins? Earned every one of 'em. Well, found most of 'em.",
            "The Fishing Shack's the best building in the whole garrison. Don't let anyone tell you different.",
        },
        default = {
            "Life in the garrison's pretty good. Good pond, good company, good fish.",
            "Draenor reminds me of home. 'Cept for the Iron Horde. And the demons. And the\226\128\148well, the fishin's good.",
        },
    },
}

Narrators[N.RON_ASHTON] = {
    id = N.RON_ASHTON,
    name = "Ron Ashton",
    title = "Garrison Fishing Shack",
    displayID = 54035,
    expansion = "WoD",
    quotes = {
        spotGuide = {
            "I've got work orders for fish, if you're interested. The garrison always needs supplies.",
        },
        default = {
            "The fishing shack's coming along nicely. Nat seems to like it here.",
        },
    },
}

Narrators[N.CONJURER_MARGOSS] = {
    id = N.CONJURER_MARGOSS,
    name = "Conjurer Margoss",
    title = "Dalaran Underbelly",
    displayID = 28006,
    expansion = "Legion",
    quotes = {
        spotGuide = {
            "The Broken Isles teem with rare fish. Each one a key to something... greater.",
            "Fish the ley lines, friend. The magic runs through the water too.",
        },
        collections = {
            "The Underlight Angler chose you for a reason. Honor it.",
            "Bigger Fish to Fry\226\128\148a worthy pursuit. Each rare catch brings you closer.",
            "My drowned mana has many uses. The fish seem drawn to it.",
        },
        catchLog = {
            "Fascinating catches. I can sense the arcane residue on some of these.",
        },
        default = {
            "Ah, a fellow connoisseur of the aquatic arts. Welcome to my island.",
            "The underbelly's waters are... unique. As are their inhabitants.",
        },
    },
}

Narrators[N.SHALETH] = {
    id = N.SHALETH,
    name = "Sha'leth",
    title = "Suramar Fishing",
    displayID = 68661,
    expansion = "Legion",
    quotes = {
        spotGuide = {
            "The waters of Suramar have been sustained by the Nightwell's energy for millennia.",
        },
        default = {
            "An illusion? No\226\128\148just a very clever fish.",
        },
    },
}

Narrators[N.MARCIA_CHASE_LEGION] = {
    id = N.MARCIA_CHASE_LEGION,
    name = "Marcia Chase",
    title = "Fishing Daily, Dalaran (Broken Isles)",
    displayID = 25655,
    expansion = "Legion",
    quotes = {
        spotGuide = {
            "The Broken Isles offer fishing opportunities unlike anything we've seen before.",
            "I've relocated to the new Dalaran. The fishing's even better up here!",
        },
        default = {
            "Welcome back! I've got new dailies for the Broken Isles.",
        },
    },
}

Narrators[N.ALAN] = {
    id = N.ALAN,
    name = "Alan",
    title = "Fishing Trainer, Boralus",
    displayID = 84583,
    expansion = "BFA",
    quotes = {
        spotGuide = {
            "Kul Tiras is a nation built on the sea. The fishing here is legendary.",
            "Zandalar's coasts are wild and dangerous. The fish are worth the risk.",
        },
        catchLog = {
            "A fine day's fishing! The harbor masters would be impressed.",
        },
        default = {
            "The seas around Kul Tiras are rough, but the catches are unmatched.",
            "Welcome to Boralus, angler. The Great Sea awaits.",
        },
    },
}

Narrators[N.AULARRYNAR] = {
    id = N.AULARRYNAR,
    name = "Au'larrynar",
    title = "Shadowlands Fishing",
    displayID = 93579,
    expansion = "Shadowlands",
    quotes = {
        spotGuide = {
            "The waters of the Shadowlands flow with anima. The fish here are... different.",
            "Death has not diminished these waters. If anything, they are more vibrant.",
        },
        catchLog = {
            "Your catches from beyond the veil are most impressive.",
        },
        default = {
            "Even in death, the waters call to those who listen.",
            "Fishing in the afterlife. Who would have thought?",
        },
    },
}

Narrators[N.TUSKARR_ELDER] = {
    id = N.TUSKARR_ELDER,
    name = "Tuskarr Elder",
    title = "Iskaara Tuskarr",
    displayID = 105782,
    expansion = "Dragonflight",
    quotes = {
        spotGuide = {
            "The Dragon Isles hold ancient fishing grounds. We Tuskarr have fished them for ages.",
            "Come, friend! The community feast needs fish, and the best spots are just ahead.",
            "Iskaara welcomes all who fish with respect for the water.",
        },
        collections = {
            "Our renown grows with every fish shared. The community feasts bring us together.",
        },
        catchLog = {
            "A bountiful catch! The Tuskarr approve. Let us prepare a feast!",
        },
        default = {
            "The water provides for all who are patient. Welcome, friend of the Tuskarr.",
            "Fishing is more than a skill\226\128\148it is how we feed our families and honor the sea.",
        },
    },
}

-------------------------------------------------------------------------------
-- Section default narrators
-------------------------------------------------------------------------------
ns.SECTION_NARRATORS = {
    [ns.SECTION_CATCH_LOG]   = N.NAT_PAGLE,
    [ns.SECTION_SPOT_GUIDE]  = N.NAT_PAGLE,       -- overridden per-zone
    [ns.SECTION_COLLECTIONS] = N.MARCIA_CHASE,
}

-------------------------------------------------------------------------------
-- Expansion fallback narrators
-------------------------------------------------------------------------------
ns.EXPANSION_NARRATORS = {
    ["Classic"]       = N.NAT_PAGLE,
    ["TBC"]           = N.OLD_MAN_BARLO,
    ["WotLK"]         = N.MARCIA_CHASE,
    ["Cataclysm"]     = N.RAZGAR,
    ["MoP"]           = N.ELDER_CLEARWATER,
    ["WoD"]           = N.NAT_PAGLE_GARRISON,
    ["Legion"]        = N.CONJURER_MARGOSS,
    ["BFA"]           = N.ALAN,
    ["Shadowlands"]   = N.AULARRYNAR,
    ["Dragonflight"]  = N.TUSKARR_ELDER,
}

-------------------------------------------------------------------------------
-- Helper: get a random quote for a narrator + context
-------------------------------------------------------------------------------
function ns.GetNarratorQuote(narratorID, context)
    local narrator = Narrators[narratorID]
    if not narrator then return nil end

    local pool = narrator.quotes[context] or narrator.quotes.default
    if not pool or #pool == 0 then
        pool = narrator.quotes.default
    end
    if not pool or #pool == 0 then return nil end

    return pool[math.random(#pool)]
end
