local _, ns = ...

local Util = {}
ns.Util = Util

-------------------------------------------------------------------------------
-- Table helpers
-------------------------------------------------------------------------------
function Util.DeepCopy(orig)
    if type(orig) ~= "table" then return orig end
    local copy = {}
    for k, v in pairs(orig) do
        copy[Util.DeepCopy(k)] = Util.DeepCopy(v)
    end
    return setmetatable(copy, getmetatable(orig))
end

function Util.TableCount(t)
    local n = 0
    for _ in pairs(t) do n = n + 1 end
    return n
end

-------------------------------------------------------------------------------
-- Time formatting
-------------------------------------------------------------------------------
function Util.FormatTimestamp(timestamp)
    if not timestamp then return "Unknown" end
    return date("%Y-%m-%d %H:%M", timestamp)
end

function Util.FormatRelativeTime(timestamp)
    if not timestamp then return "never" end
    local diff = time() - timestamp
    if diff < 60 then return "just now" end
    if diff < 3600 then return floor(diff / 60) .. "m ago" end
    if diff < 86400 then return floor(diff / 3600) .. "h ago" end
    if diff < 604800 then return floor(diff / 86400) .. "d ago" end
    return date("%b %d", timestamp)
end

-------------------------------------------------------------------------------
-- Number formatting
-------------------------------------------------------------------------------
function Util.FormatCount(n)
    if n >= 1000000 then
        return format("%.1fM", n / 1000000)
    elseif n >= 1000 then
        return format("%.1fK", n / 1000)
    end
    return tostring(n)
end

-------------------------------------------------------------------------------
-- Item helpers
-------------------------------------------------------------------------------
function Util.ParseItemID(link)
    if not link then return nil end
    return tonumber(link:match("item:(%d+)"))
end

function Util.GetItemQualityColor(quality)
    if quality and ITEM_QUALITY_COLORS[quality] then
        return ITEM_QUALITY_COLORS[quality].color
    end
    return ns.COLORS.COMMON_CATCH
end

-------------------------------------------------------------------------------
-- Zone helpers
-------------------------------------------------------------------------------
function Util.GetPlayerMapID()
    return C_Map.GetBestMapForUnit("player")
end

function Util.GetPlayerSubZone()
    return GetSubZoneText() or ""
end

function Util.GetMapName(mapID)
    if not mapID then return "Unknown" end
    local info = C_Map.GetMapInfo(mapID)
    return info and info.name or "Unknown"
end
