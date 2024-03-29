-- RuleView.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/28/2019, 1:35:42 PM

---@type ns
local ns = select(2, ...)
local L = ns.L
local UI = ns.UI
local ItemInfoCache = ns.ItemInfoCache

---- LUA
local format = string.format
local select, type = select, type
local tContains = tContains

---- WOW
local ClearCursor = ClearCursor
local CreateFrame = CreateFrame
local GetCursorInfo = GetCursorInfo
local GetItemIcon = GetItemIcon
local GetItemQualityColor = GetItemQualityColor

---- UI
local GameTooltip = GameTooltip
local UIParent = UIParent

---- LOCAL
local RED_FONT_COLOR_HEX = RED_FONT_COLOR:GenerateHexColor()
local DEFAULT_ICON = 134400

local RuleView = UI:NewClass('RuleView', UI.TreeView)

LibStub('AceEvent-3.0'):Embed(RuleView)

function RuleView:Constructor()
    self:SetItemTemplate('tdPack2RuleItemTemplate')
    self:SetCallback('OnItemFormatting', self.OnItemFormatting)
    self:SetCallback('OnItemEnter', self.OnItemEnter)
    self:SetCallback('OnItemLeave', GameTooltip_Hide)
    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.OnHide)
end

function RuleView:OnShow()
    self:RegisterEvent('GET_ITEM_INFO_RECEIVED', 'Refresh')
    self:RegisterEvent('CURSOR_UPDATE')
    self:CURSOR_UPDATE()
end

function RuleView:OnHide()
    self:UnregisterAllEvents()
end

function RuleView:CURSOR_UPDATE()
    local cursorType, itemId, itemLink = GetCursorInfo()
    if cursorType == 'item' then
        self:StartCursorCatching(itemId)
    else
        self:StopCursorCatching()
    end
end

function RuleView:OnItemFormatting(button, item, depth)
    local name, icon, rule, hasChild = ns.GetRuleInfo(item)
    button.Status:SetPoint('LEFT', 5 + 20 * (depth - 1), 0)
    button.Text:SetFontObject((ns.IsAdvanceRule(item) and not rule) and 'GameFontDisable' or 'GameFontNormal')
    button.Text:SetText(format('|T%s:14|t %s', icon, name))
    button.Rule:SetText(rule or '')
    button.Status:SetShown(hasChild)
    button.Status:SetTexture(self:IsItemExpend(item) and [[Interface\Buttons\UI-MinusButton-UP]] or
                                 [[Interface\Buttons\UI-PlusButton-Up]])
end

function RuleView:OnItemEnter(button)
    local item = button.item
    GameTooltip:SetOwner(button, 'ANCHOR_RIGHT')
    if type(item) == 'number' then
        GameTooltip:SetHyperlink('item:' .. item)
    elseif ns.IsAdvanceRule(item) then
        if item.comment then
            GameTooltip:AddLine(item.comment)
        end
        if item.rule then
            GameTooltip:AddLine(item.rule, 1, 1, 1)
        end
    end
    GameTooltip:Show()
end

function RuleView:StartCursorCatching(item)
    local catcher = self.cursorCatcher or self:CreateCursorCatcher()
    local exists = tContains(self:GetItemTree(), item)
    catcher.item = item
    catcher.exists = exists
    catcher.bg:SetShown(exists)
    catcher:SetText(exists and L['Already exists'] or '')
    catcher:Show()
end

function RuleView:StopCursorCatching()
    if self.cursorCatcher then
        self.cursorCatcher:Hide()
        self:StopSorting()
    end
end

function RuleView:CreateCursorCatcher()
    local catcher = CreateFrame('Button', nil, self)
    catcher:RegisterForClicks('LeftButtonUp')
    catcher:SetAllPoints(self.mouseHolder or self)
    catcher:SetFrameLevel(self:GetFrameLevel() + 100)
    catcher:SetNormalFontObject('GameFontHighlightHuge')
    catcher.bg = catcher:CreateTexture(nil, 'BACKGROUND')
    catcher.bg:SetAllPoints(self)
    catcher.bg:SetColorTexture(0.3, 0, 0, 0.9)

    local function OnClick(catcher)
        if catcher.exists then
            return
        end
        self:CommitSorting()
        ClearCursor()
    end

    local function OnEnter(catcher)
        if not catcher.item or catcher.exists then
            return
        end
        local x, y = ns.GetCursorPosition()
        local button = self:AllocButton()

        button.index = nil
        button.parent = nil
        button.item = catcher.item
        button:SetWidth(self:GetWidth(), self.itemHeight)
        button:SetParent(UIParent)
        button:ClearAllPoints()
        button:SetPoint('BOTTOMLEFT', x - button:GetWidth() / 2, y - button:GetHeight() / 2)

        self:OnItemFormatting(button, button.item, 1)
        self:StartSorting(button)
    end

    local function OnLeave()
        if catcher:IsShown() then
            self:StopSorting()
        end
    end

    catcher:SetScript('OnClick', OnClick)
    catcher:SetScript('OnReceiveDrag', OnClick)
    catcher:SetScript('OnEnter', OnEnter)
    catcher:SetScript('OnLeave', OnLeave)
    self:SetCallback('OnSortingOut', OnLeave)

    self.cursorCatcher = catcher
    return catcher
end
