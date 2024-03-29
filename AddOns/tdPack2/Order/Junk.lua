-- Junk.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/31/2019, 11:10:04 PM

---@type ns
local ns = select(2, ...)

---- LUA
local wipe = table.wipe or wipe
local type, ipairs = type, ipairs

---- NS
local Search = ns.Search

---- WOW
local GetItemInfo = GetItemInfo

---- LOCAL
local LE_ITEM_QUALITY_POOR = LE_ITEM_QUALITY_POOR
local CONJURED_ITEM_MATCHS = 'tip:' .. ITEM_CONJURED

local JunkOrder = ns.Addon:NewClass('JunkOrder', ns.Order)

function JunkOrder:Constructor()
    self.orders = {}
end

function JunkOrder:Build()
    wipe(self.orders)
    for i, v in ipairs(self.profile) do
        if type(v) == 'number' then
            self.orders[v] = true
        end
    end
end

function JunkOrder:GetOrder(item)
    return self:IsInCustomRule(item) and '0' or self:IsJunk(item) and '9' or self:IsConjuredItem(item) and '8' or '0'
end

function JunkOrder:IsInCustomRule(item)
    return self.orders[item:GetItemId()]
end

function JunkOrder:IsJunk(item)
    local itemId = item:GetItemId()
    if Scrap then
        return Scrap:IsJunk(itemId)
    else
        local _, _, quality, _, _, _, _, _, _, _, price = GetItemInfo(itemId)
        return quality == LE_ITEM_QUALITY_POOR and price and price > 0
    end
end

local IsConjuredItem = ns.memorizenilable(function(itemId)
    return Search:Matches('item:' .. itemId, CONJURED_ITEM_MATCHS)
end)

function JunkOrder:IsConjuredItem(item)
    return IsConjuredItem(item:GetItemId())
end
