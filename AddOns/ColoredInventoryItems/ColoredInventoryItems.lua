local addonName = 'ColoredInventoryItems';
local version = '1.2.2';
local addon = CreateFrame('Button', addonName);

config = {
    ['bags'] = 1,
    ['bank'] = 1,
    ['char'] = 1,
    ['inspect'] = 1,
    ['intensity'] = 0.49,
}

addon:RegisterEvent('ADDON_LOADED');
addon:RegisterEvent('PLAYER_ENTERING_WORLD');
addon:RegisterEvent('INSPECT_READY');
addon:RegisterEvent('BAG_UPDATE');
addon:RegisterEvent('BANKFRAME_OPENED');
addon:RegisterEvent('PLAYERBANKSLOTS_CHANGED');

addon:SetScript('OnEvent', function(self, event, arg1) self[event](self, arg1) end);

function addon:ADDON_LOADED(arg1)
    if (arg1 == addonName) then
        print('|cFFFFFF00ColoredInventoryItem v' .. version .. ':|cFFFFFFFF Type /cii for configuration');
    end
end

function addon:OPENALLBAGS()
    print('open all');
end
function addon:PLAYER_ENTERING_WORLD()
    hooksecurefunc('ToggleCharacter', function() addon:characterFrame_OnToggle() end);
    hooksecurefunc('ToggleBackpack', function() addon:backpack_OnShow() end);
    hooksecurefunc('ToggleBag', function(id) addon:bag_OnToggle(id) end);
end

---
-- character frame events
function addon:characterFrame_OnToggle()
    if (CharacterFrame:IsShown()) then
        addon:characterFrame_OnShow();
    else    
        addon:characterFrame_OnHide();
    end
end

function addon:characterFrame_OnShow()
    addon:RegisterEvent("UNIT_INVENTORY_CHANGED");
    addon:charFrame_UpdateBorders('player', 'Character', config.char);
end

function addon:characterFrame_OnHide()
	addon:UnregisterEvent("UNIT_INVENTORY_CHANGED")
end

---
-- update player inventory
function addon:UNIT_INVENTORY_CHANGED()
    addon:charFrame_UpdateBorders('player', 'Character', config.char);
end

---
-- bag update event
function addon:BAG_UPDATE(arg1)
    addon:refreshBag(arg1);
end

---
-- inspect frame event
function addon:INSPECT_READY()
    addon:charFrame_UpdateBorders('target', 'Inspect', config.inspect);
end

---
-- bank frame opened
function addon:BANKFRAME_OPENED()
    addon:bankbags_UpdateBorders();
end

---
-- bank slots updated
function addon:PLAYERBANKSLOTS_CHANGED()
    addon:bankbags_UpdateBorders();
end

---
-- backpack opened
function addon:backpack_OnShow()
    local containerFrame = _G['ContainerFrame1'];

    if (containerFrame.allBags == true) then
        addon:refreshAllBags()
    end
end

function addon:refreshAllBags()
    for bagId = 0, NUM_BAG_SLOTS do
        OpenBag(bagId);
        addon:refreshBag(bagId);
    end
end

---
-- open/close a bag
function addon:bag_OnToggle(bagId)
    addon:refreshBag(bagId);
end

---
-- refresh a single bag content
function addon:refreshBag(bagId)
    local frameId = IsBagOpen(bagId);

    if (frameId) then
        local nbSlots = GetContainerNumSlots(bagId);

        for slot = 1, nbSlots do
            slotFrameId = nbSlots + 1 - slot;
            local slotFrameName = 'ContainerFrame' .. frameId .. 'Item' .. slotFrameId;
            addon:updateContainerSlot(bagId, slot, slotFrameName, config.bags);
        end
    end
end

---
-- update bank bag borders
function addon:bankbags_UpdateBorders()
    local container = BANK_CONTAINER;

    for slot = 1, GetContainerNumSlots(container) do
        addon:updateContainerSlot(container, slot, 'BankFrameItem' .. slot, config.bank);
    end
end

---
-- update border for a container' slot (bank and bag slots)
function addon:updateContainerSlot(containerId, slotId, slotFrameName, show)
    local show = show or 1;

    item = _G[slotFrameName];

    if (not item.qborder) then
        item.qborder = addon:createBorder(slotFrameName, item, 68, 68);
    end

    local itemId = GetContainerItemID(containerId, slotId);

    if (itemId and show == 1) then
        local _, _, locked, quality, readable, _, itemLink = GetContainerItemInfo(containerId, slotId);
        local itemType, _, _, _, _, _, classId = select(6, GetItemInfo(itemId));

        item.qborder:SetAlpha(config.intensity);

        -- green or better item, or quest item
        if (quality > 1) then 
            local r, g, b, _ = GetItemQualityColor(quality)
            item.qborder:SetVertexColor(r, g, b);
            item.qborder:Show();
        elseif (classId == 12) then
            local r, g, b = 1, 1, 0;
            item.qborder:SetVertexColor(r, g, b);
            item.qborder:Show();
        else
            item.qborder:Hide();
        end
    else
        item.qborder:Hide();
    end
end

local CharacterFrameSlotTypes = {
    'Head',
    'Neck',
    'Shoulder',
    'Back',
    'Chest',
    'Shirt',
    'Tabard',
    'Wrist',
    'Hands',
    'Waist',
    'Legs',
    'Feet',
    'Finger0',
    'Finger1',
    'Trinket0',
    'Trinket1',
    'MainHand',
    'SecondaryHand',
    'Ranged',
    'Ammo',
};

---
-- Update characters frame item border
function addon:charFrame_UpdateBorders(unit, frameType, show)
    local show = show or 1;

    for _, charSlot in ipairs(CharacterFrameSlotTypes) do
        local id, _ = GetInventorySlotInfo(charSlot .. 'Slot');
        local quality = GetInventoryItemQuality(unit, id);

        local slotName = frameType .. charSlot .. 'Slot';
        
        if (_G[slotName]) then
            slot = _G[slotName];

            -- create border if not done yet
            if (not slot.qborder) then
                local height = 68;
                local width = 68;

                if charSlot == 'Ammo' then
                    height = 58
                    width = 58
                end

                slot.qborder = addon:createBorder(slotName, _G[slotName], width, height);
            end

            -- update border color
            if (quality and show == 1) then
                local r, g, b, _ = GetItemQualityColor(quality)
                slot.qborder:Show();
                slot.qborder:SetAlpha(config.intensity);
                slot.qborder:SetVertexColor(r, g, b);
            else
                slot.qborder:Hide();
            end
        end
    end
end

---
-- create a border texture for an inventory slot
function addon:createBorder(name, parent, width, height)
    local border = parent:CreateTexture(name .. 'Quality', 'OVERLAY');

    border:SetTexture("Interface\\Buttons\\UI-ActionButton-Border");
    border:SetBlendMode("ADD");
    border:SetAlpha(config.intensity);
    border:SetHeight(height);
    border:SetWidth(width);
    border:SetPoint("CENTER", parent, "CENTER", 0, 1);
    border:Hide();

    return border;
end

--- Slash commands
SLASH_COLOREDINVENTORYITEMS1 = "/cii"
SlashCmdList["COLOREDINVENTORYITEMS"] = function(msg)
    msg = string.lower(msg);

    local _, _, cmd, args = string.find(msg, '%s?(%w+)%s?(.*)')

    if (cmd == 'help' or not cmd) then
        addon:printHelp();
    elseif (cmd == 'bags') then
        if (config.bags == 1) then config.bags = 0 else config.bags = 1 end
        addon:printStatus('Bags', config.bags);
    elseif (cmd == 'bank') then
        if (config.bank == 1) then config.bank = 0 else config.bank = 1 end
        addon:printStatus('Bank', config.bank);
    elseif (cmd == 'char') then
        if (config.char == 1) then config.char = 0 else config.char = 1 end
        addon:printStatus('Character', config.char);
    elseif (cmd == 'inspect') then
        if (config.inspect == 1) then config.inspect = 0 else config.inspect = 1 end
        addon:printStatus('Inspect', config.inspect);
    elseif (cmd == 'intensity' or cmd == 'int') then
        if (not args or args == '') then
            print('Current intensity : ' .. config.intensity)
        else
            local value = tonumber(args);
            if (value ~= nil) then
                if (value > 1) then value = 1 end
                if (value < .1) then value = .1 end
                config.intensity = value;
            else
                print('Value is not a number');
            end
        end;
    end
end

function addon:printStatus(element, status)
    statustext = 'shown';
    if (status == 0) then
        statustext = 'hidden';
    end

    print(element .. ' item borders are ' .. statustext)
end

function addon:printHelp()
    print('===== ColorInventoryItems v' .. version .. ' usage:');
    print('/cii help    : this help message');
    print('/cii bags    : toggle item border display in bags. (current = '.. config.bags ..')');
    print('/cii bank    : toggle item border display in bank. (current = '.. config.bank ..')');
    print('/cii char    : toggle item border display in character frame. (current = '.. config.char ..')');
    print('/cii inspect : toggle item border display in inspect frame. (current = '.. config.inspect ..')');
    print('/cii intensity VALUE or /cii int VALUE :');
    print('        Define border intensity (float VALUE between 0 and 1).')
    print('        default = 0.49, current = ' .. config.intensity);
end
