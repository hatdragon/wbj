local ADDON_NAME, ns = ...

-------------------------------------------------------------------------------
-- Namespace
-------------------------------------------------------------------------------
ns.ADDON_NAME = ADDON_NAME
ns.VERSION = "2.0.0"

-------------------------------------------------------------------------------
-- Fishing Profession
-------------------------------------------------------------------------------
ns.FISHING_PROFESSION = Enum.Profession.Fishing  -- 10
ns.FISHING_SKILL_LINE = 356
ns.FISHING_VARIANT_SKILL_LINES = {
    2592, -- Classic
    2591, -- TBC
    2590, -- WotLK
    2589, -- Cata
    2588, -- MoP
    2587, -- WoD
    2586, -- Legion
    2585, -- BFA
    2754, -- Shadowlands
    2826, -- Dragonflight
    2871, -- TWW
}

-------------------------------------------------------------------------------
-- Layout
-------------------------------------------------------------------------------
ns.JOURNAL_PAGE_WIDTH = 942
ns.JOURNAL_PAGE_HEIGHT = 560

ns.NARRATOR_PANEL_HEIGHT = 80
ns.SECTION_NAV_HEIGHT = 32
ns.SEARCH_BAR_HEIGHT = 28
ns.CONTENT_INSET = 12

-------------------------------------------------------------------------------
-- Colors (AARRGGBB or CreateColor)
-------------------------------------------------------------------------------
ns.COLORS = {
    PARCHMENT_TEXT  = CreateColor(0.90, 0.85, 0.75, 1),  -- warm cream (light for dark bg)
    HEADER_TEXT     = CreateColor(0.95, 0.80, 0.40, 1),  -- warm gold
    RARE_CATCH      = CreateColor(0.00, 0.44, 0.87, 1),  -- blue (rare)
    EPIC_CATCH      = CreateColor(0.64, 0.21, 0.93, 1),  -- purple (epic)
    COMMON_CATCH    = CreateColor(0.62, 0.62, 0.62, 1),  -- grey
    UNCAUGHT        = CreateColor(0.55, 0.55, 0.55, 0.7),
    CAUGHT          = CreateColor(0.20, 0.80, 0.20, 1),
    HIGHLIGHT       = CreateColor(1, 1, 1, 0.10),
    NAV_ACTIVE      = CreateColor(0.85, 0.65, 0.13, 1),  -- gold
    NAV_INACTIVE    = CreateColor(0.60, 0.50, 0.35, 1),
}

-------------------------------------------------------------------------------
-- Fonts
-------------------------------------------------------------------------------
ns.HEADER_FONT = "Fonts\\MORPHEUS.TTF"
ns.BODY_FONT = "GameFontNormal"

-------------------------------------------------------------------------------
-- Section IDs
-------------------------------------------------------------------------------
ns.SECTION_CATCH_LOG   = 1
ns.SECTION_SPOT_GUIDE  = 2
ns.SECTION_COLLECTIONS = 3

ns.SECTION_NAMES = {
    [1] = "Catch Log",
    [2] = "Spot Guide",
    [3] = "Collections",
}

-------------------------------------------------------------------------------
-- Catch Log Sort Modes
-------------------------------------------------------------------------------
ns.SORT_RECENT    = "recent"
ns.SORT_COUNT     = "count"
ns.SORT_NAME      = "name"
ns.SORT_RARITY    = "rarity"

-------------------------------------------------------------------------------
-- Item Quality Mapping
-------------------------------------------------------------------------------
ns.QUALITY_ORDER = {
    [Enum.ItemQuality.Poor]      = 0,
    [Enum.ItemQuality.Common]    = 1,
    [Enum.ItemQuality.Uncommon]  = 2,
    [Enum.ItemQuality.Rare]      = 3,
    [Enum.ItemQuality.Epic]      = 4,
    [Enum.ItemQuality.Legendary] = 5,
}
