-------------------------------------------------------------------------------
-- SmartSell
-- Created by Aeldra (EU-Proudmoore)
--
-- Adds additional item information to any tooltip
-------------------------------------------------------------------------------

-- Store original SetTooltipMoney
local SetTooltipMoney_Base = SetTooltipMoney;

local Title = "SmartSell";
local Version = "1.13.2d";
local TitleVersion = Title.." "..Version;

local SmartSell = {};
local L = SMARTSELL_LOCALS;
local O;
local _;
local isInit = false;
local iconGold, iconSilver, iconCopper;

local M_AH = 10;
local M_AC = 11;
local M_RI = 12;
local M_SI = 13;


-- Returns a chat color code string
local function BCC(r, g, b)
  return string.format("|cff%02x%02x%02x", (r*255), (g*255), (b*255));
end

local BL  = BCC(0.1, 0.1, 1.0);
local BLD = BCC(0.0, 0.0, 0.7);
local BLL = BCC(0.5, 0.8, 1.0);
local GR  = BCC(0.1, 1.0, 0.1);
local GRD = BCC(0.0, 0.7, 0.0);
local GRL = BCC(0.25, 0.75, 0.25);
local RD  = BCC(1.0, 0.1, 0.1);
local RDD = BCC(0.7, 0.0, 0.0);
local RDL = BCC(1.0, 0.3, 0.3);
local YL  = BCC(1.0, 1.0, 0.0);
local YLD = BCC(0.7, 0.7, 0.0);
local YLL = BCC(1.0, 1.0, 0.5);
local OR  = BCC(1.0, 0.5, 0.25);
local ORD = BCC(0.7, 0.5, 0.0);
local ORL = BCC(1.0, 0.6, 0.3);
local WH  = BCC(1.0, 1.0, 1.0);
local CY  = BCC(0.5, 1.0, 1.0);
local GY  = BCC(0.5, 0.5, 0.5);
local GYD = BCC(0.35, 0.35, 0.35);
local GYL = BCC(0.65, 0.65, 0.65);
local GYLS= BCC(0.85, 0.85, 0.85);
local GBL = BCC(0.2, 1.0, 0.6);
local GOL = BCC(1.0, 0.84, 0.0);
local SIL = BCC(0.78, 0.78, 0.78);
local COP = BCC(0.84, 0.5, 0.37);
local GB  = BCC(0.32, 0.81, 0.73);

-- Converts a string to number
local function StrToNum(s, nDef, nMin, nMax)
  local n = nDef;
  if (s) then
    n = tonumber(s);
    if (n == nil) then
      n = nDef;
    elseif (nMin and n < nMin) then
      n = nMin;
    elseif (nMax and n > nMax) then
      n = nMax;
    end
  end
  return n;
end

-- Splits a string
local function Split(msg, char)
  local arr = { };
  while (string.find(msg, char)) do
    local iStart, iEnd = string.find(msg, char);
    tinsert(arr, strsub(msg, 1, iStart - 1));
    msg = strsub(msg, iEnd + 1, strlen(msg));
  end
  if (strlen(msg) > 0) then
    tinsert(arr, msg);
  end
  return arr;
end

local function bShow(b)
  if (b == nil or not b) then
    return RD.."Off";
  else
    return GR.."On";    
  end
end

local function Msg(txt, showAddon)
  if (showAddon) then
    if (txt == "") then
      print(GBL..TitleVersion);
    else
      print(GBL..Title..YLL..format(": %s", tostring(txt)));
    end
  else
    print(YLL..tostring(txt));
  end
end

local function CheckInit()
  if (not isInit) then SmartSell_Init() end
end

-- Splits the money string into gold, silver and copper part
local function SplitMoney(money)
  local g = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
  return g, floor((money - (g * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER), money % COPPER_PER_SILVER;
end

local function GetMoneyText(money, style, icons, color)
  money = money or 0;
  local col = color or WH;
  local g, s, c, t;  
  
  local gi, si, ci = "g", "s", "c";
  if (icons) then
    gi, si, ci = iconGold, iconSilver, iconCopper;
  end
  
  t = "";  
  if (style == 3 or style == 4) then    
    g, s, c = SplitMoney(money);
    --print(g.."/"..s.."/"..c);
    if (g > 0) then
      t = col..g..GOL..gi;
    end

    if (s > 0) then
      if (t ~= "") then t = t.." " end
      t = t..col..s..SIL..si;
    end

    if (c > 0) then
      if (t ~= "") then t = t.." " end
      t = t..col..c..COP..ci;
    end
    
  elseif (style == 5 or style == 6) then
    if (money >= 10000) then
      t = col..format("%.2f", money/10000)..GOL..gi;
    elseif (money >= 100) then
      t = col..format("%.2f", money/100)..SIL..si;
    else
      t = col..format("%d", money)..COP..ci;
    end
  end
  
  return t;
end

-- Format coin icons as string
local function SetIconSize()
  local n = O.CoinIconSize;
  iconGold   = string.format("\124TInterface\\MoneyFrame\\UI-GoldIcon:%d:%d:1:0\124t", n, n);
  iconSilver = string.format("\124TInterface\\MoneyFrame\\UI-SilverIcon:%d:%d:1:0\124t", n, n);
  iconCopper = string.format("\124TInterface\\MoneyFrame\\UI-CopperIcon:%d:%d:1:0\124t", n, n);
end

-- Clear money table on object
local function ClearMoneyCount(self)
  if (self and self.MoneyCount) then    
    wipe(self.MoneyCount);
  end
end


local recipe = 0;

local function AddToTooltip(self, itemLinkId, itemCount, mode)
  CheckInit();
  
  if (self == nil or itemLinkId == nil or O == nil) then
    ClearMoneyCount(self);
    return;
  end
  
  local itemName, itemLink, _, itemLevel, _, itemType, itemSubType, itemStackCount, _, itemTex, itemValue, classId, subclassId = GetItemInfo(itemLinkId);
  --print(itemName, itemType, classId, itemSubType, subclassId, itemStackCount, itemValue);
  
  -- Recipe, not Book, not Enchanting
  if (classId == 9 and subclassId ~= 0 and subclassId ~= 8) then
    --print(classId, subclassId);
    recipe = recipe + 1;
    -- Skip first to avoid display of double money count
    if (recipe % 2 == 1) then return end
  else
    recipe = 0;
  end
  
  if (itemStackCount == nil) then itemStackCount = 0 end
  
  if (itemStackCount > 1) then
    local count = 0;
    local f = GetMouseFocus();
    if (f) then
      local fc = nil;
      local name = f:GetName();
      if (name) then fc = (name.."Count") end
      count = f.count or (f.Count and f.Count:GetText()) or (f.Quantity and f.Quantity:GetText()) or (fc and _G[fc] and _G[fc]:GetText());
      count = tonumber(count) or 0;
      if (count < 1) then count = 0 end
    end
    itemCount = count;
  end
  
  
  if (itemLevel == nil) then
    ClearMoneyCount(self);
    return
  end
  if (self.MoneyCount == nil) then self.MoneyCount = { } end
  
  local mc;
  local s = "";
  local t = "";
  local m = mode or 0;
  local sty = O.Style;
  local displayCount = itemCount;
  
  if (O.ShowItemIcons and itemTex) then
    t = _G[self:GetName().."TextLeft1"];
    if (t) then
      local text = t:GetText() or "";
      -- Remove existing icon
      text = string.gsub(text, "|T.*|t ", "");
      t:SetFormattedText('|T%s:%d|t %s', itemTex, O.ItemIconSize, text);
    end
  end
      
  if (itemCount == nil or itemCount == 0) then
    itemCount = 1;
    displayCount = 0;
  end
  
  -- Check if the item value and the preset tooltip value are equal
  -- If not...Houston, we have a problem...use the preset value from blizzard
  if (m == 0) then
    mc = self.MoneyCount[1];
    if (mc and mc[1]) then
      --print(itemName.." value: "..mc[1]..", "..(itemValue*itemCount));
      if (mc[1] ~= (itemValue*itemCount)) then
        --print(itemName.." value not equal: "..mc[1].." != "..(itemValue*itemCount));
        itemValue = mc[1]/itemCount;
      end
    end
  end
  
  if (not O.ShowStackValue) then
    itemCount = 1;
  end
  
  if (itemName) then
    if (O.ShowBlankLine or classId == 9) then
      local o = _G[self:GetName().."TextLeft"..self:NumLines()];
      if (not o or (o and o:GetText() ~= " ")) then
        self:AddLine(" ");
      end      
    end
    
    if (O.ShowItemType and itemType) then
      if (O.ShowItemSubType and itemSubType and itemType ~= itemSubType) then
        s = L.ItemType..WH..itemType.."|r / "..WH..itemSubType;
      else
        s = L.ItemType..WH..itemType.."|r";
      end
      self:AddLine(s);
    end
    
    s = "";
    if (O.ShowItemLevel) then
      if (sty <= 1) then
        self:AddLine(L.ItemLevel..WH..itemLevel.."|r");
      else
        s = "lvl"..WH..itemLevel.."|r";
      end
    end
    
    if (O.ShowItemStackCount and itemStackCount > 1 and itemStackCount < 10000 and displayCount > 0) then
      if (sty <= 1) then
        self:AddLine(L.ItemStackCount..WH..displayCount.."|r/"..WH..itemStackCount.."|r");
      else
        if (s ~= "") then s = s.." - " end
        s = s.."stk"..WH..displayCount;
        if (m ~= M_AC and m ~= M_RI and displayCount <= itemStackCount) then
          s = s.."|r/"..WH..itemStackCount.."|r";
        end
      end
    end
    
    local _, _, itemID = string.find(itemLink, "item:(%d+)");
    if (itemID) then
      if (O.ShowItemID) then
        if (sty <= 1) then
          self:AddLine(L.ItemID..WH..itemID.."|r");
        else
          if (s ~= "") then s = s.." - " end
          s = s.."id"..WH..itemID.."|r";          
        end
      end
      
      if (sty == 2) then
        self:AddLine(s);
        s = "";
      end
      
      t = "";
      itemID = tonumber(itemID);
      if (itemID and O.ShowItemValue) then        
        if (itemValue == nil) then
          if (sty <= 2) then
            self:AddLine(L.ValueUnknown);
          else
            t = RD.."?";
          end
        else          
          if (itemValue == 0) then
            if (sty <= 2) then
              self:AddLine(ITEM_UNSELLABLE);
            else
              t = OR.."x";
            end
          else
            if (sty <= 2) then
              t = "";
              if (itemCount > 1 and O.ShowPieceValue and m ~= M_AH and #self.MoneyCount <= 1) then
                t = "|r ("..GetMoneyText(itemValue, 3, O.ShowCoinIcons, GYLS).."|r)";
              end
              mc = self.MoneyCount[1];
              if (sty == 0 and mc and mc[1]) then
                if (O.ShowPieceValue) then
                  t = GetMoneyText(itemValue * itemCount, 3, O.ShowCoinIcons)..t
                  if (mc[3]) then t = mc[3].." "..t; end
                  if (mc[4]) then t = t..mc[4]; end
                  self:AddDoubleLine(t, " ");
                else
                  SetTooltipMoney_Base(self, itemValue * itemCount, mc[2], mc[3], mc[4]);
                end
              else
                if (O.ShowPieceValue) then
                  self:AddDoubleLine(GetMoneyText(itemValue * itemCount, 3, O.ShowCoinIcons)..t, " ");
                else
                  SetTooltipMoney_Base(self, itemValue * itemCount);
                end
              end
            else                
              t = GetMoneyText(itemValue * itemCount, sty, O.ShowCoinIcons);
              if (itemCount > 1 and O.ShowPieceValue and O.ShowStackValue) then
                if (sty == 4 or sty == 6) then
                  t = "|r("..GetMoneyText(itemValue, sty, O.ShowCoinIcons, GYLS).."|r)  "..t;
                else
                  t = t.."|r  ("..GetMoneyText(itemValue, sty, O.ShowCoinIcons, GYLS).."|r)";
                end
              end                
            end
          end
        end
      end
    end
    
    if (sty > 2 and (s ~= "" or t ~= "")) then
      if (s == "") then s = " " end
      if (t == "") then t = " " end
      if (sty == 4 or sty == 6) then
        self:AddDoubleLine(s, t);        
      else
        self:AddDoubleLine(t, s);
      end
    end
    
    -- AH mode or more than 1 money count
    if ((m == M_AH and #self.MoneyCount > 0) or #self.MoneyCount > 1) then
      if (O.ShowBlankLine) then self:AddLine(" "); end
      if (m == M_AH) then self:AddLine(GB..BUTTON_LAG_AUCTIONHOUSE..":"); end
      for i = 1, #self.MoneyCount do
        mc = self.MoneyCount[i];
        if (mc and mc[1]) then
          if (sty <= 2) then
            SetTooltipMoney_Base(self, mc[1], mc[2], mc[3], mc[4]);
          else
            --if (t ~= "") then t = t..GY.."/"; end
            s = mc[3] or " ";
            s = string.gsub(s, ":", "");
            t = GetMoneyText(mc[1], sty, O.ShowCoinIcons);
            if (sty == 4 or sty == 6) then
              self:AddDoubleLine(s, t);        
            else
              self:AddDoubleLine(t, s);
            end            
          end
        end        
      end      
    end
  end
  -- Clear money table on object
  ClearMoneyCount(self);
  -- And show it again to apply the new size
  self:Show();
end


local function LoadSettings(reset)
  if (reset) then wipe(O) end
  if (O.FirstStart == nil) then O.FirstStart = Version end
  if (O.Style == nil) then O.Style = 3 end
  if (O.ShowItemLevel == nil) then O.ShowItemLevel = true end
  if (O.ShowItemID == nil) then O.ShowItemID = false end
  if (O.ShowItemStackCount == nil) then O.ShowItemStackCount = true end
  if (O.ShowItemValue == nil) then O.ShowItemValue = true end
  if (O.ShowItemType == nil) then O.ShowItemType = true end
  if (O.ShowItemSubType == nil) then O.ShowItemSubType = true end
  if (O.QuestOnly == nil) then O.QuestOnly = false end
  if (O.ShowStackValue == nil) then O.ShowStackValue = true end
  if (O.ShowPieceValue == nil) then O.ShowPieceValue = true end
  if (O.ShowInCombat == nil) then O.ShowInCombat = false end
  if (O.ShowBlankLine == nil) then O.ShowBlankLine = false end
  if (O.ShowCoinIcons == nil) then O.ShowCoinIcons = true end
  if (O.CoinIconSize == nil) then O.CoinIconSize = 14 end
  if (O.ShowItemIcons == nil) then O.ShowItemIcons = true end
  if (O.ItemIconSize == nil) then O.ItemIconSize = 24 end  
  SetIconSize();
end


function SmartSell_Init()
  if (isInit) then return end
  if (SmartSellDB == nil) then SmartSellDB = { } end
  O = SmartSellDB;
  
  local b = false;
  if (O.FirstStart ~= Version) then  
    O.FirstStart = Version;
    -- Upgrade to 4.0b
    if (Version == "v4.0b") then
      print(RDL.."New "..TitleVersion.." version initialized.");
      print(RDL.."A reset to default is recommended. Type in chat:");
      print(RDL.."/ssell rs");
      --b = true
    end
  end
  LoadSettings(b);  
  isInit = true;
  --Msg(TitleVersion.." initialized");
end


function SmartSell_Command(msgIn)
  CheckInit();
  
  local msgs = Split(msgIn, " ");
  local msg = msgs[1];

  if (msg == "ci") then
    O.ShowCoinIcons = not O.ShowCoinIcons;
    Msg("Show coin icons = "..bShow(O.ShowCoinIcons));
  elseif (msg == "cis") then
    O.CoinIconSize = StrToNum(msgs[2], 12, 4, 24);
    Msg("Coin icon size = "..WH..O.CoinIconSize);
    SetIconSize();
  elseif (msg == "ii") then
    O.ShowItemIcons = not O.ShowItemIcons;
    Msg("Show item icons = "..bShow(O.ShowItemIcons));
  elseif (msg == "iis") then
    O.ItemIconSize = StrToNum(msgs[2], 24, 12, 48);
    Msg("Item icon size = "..WH..O.ItemIconSize);    
  elseif (msg == "ic") then
    O.ShowInCombat = not O.ShowInCombat;
    Msg("Show in combat = "..bShow(O.ShowInCombat));
  elseif (msg == "lvl") then
    O.ShowItemLevel = not O.ShowItemLevel;
    Msg("Show item level = "..bShow(O.ShowItemLevel));
  elseif (msg == "id") then
    O.ShowItemID = not O.ShowItemID;
    Msg("Show item id = "..bShow(O.ShowItemID));
  elseif (msg == "sc") then
    O.ShowItemStackCount = not O.ShowItemStackCount;
    Msg("Show item stack count = "..bShow(O.ShowItemStackCount));
  elseif (msg == "pp") then
    O.ShowPieceValue = not O.ShowPieceValue;
    Msg("Show price per piece= "..bShow(O.ShowPieceValue));
  elseif (msg == "sp") then
    O.ShowStackValue = not O.ShowStackValue;
    Msg("Show stack price = "..bShow(O.ShowStackValue));
  elseif (msg == "val") then
    O.ShowItemValue = not O.ShowItemValue;
    Msg("Show item value = "..bShow(O.ShowItemValue));
  elseif (msg == "t") then
    O.ShowItemType = not O.ShowItemType;
    Msg("Show item type = "..bShow(O.ShowItemType));    
  elseif (msg == "st") then
    O.ShowItemSubType = not O.ShowItemSubType;
    Msg("Show item sub type = "..bShow(O.ShowItemSubType));    
  elseif (msg == "qo") then
    O.QuestOnly = not O.QuestOnly;
    Msg("Show info only for quest rewards = "..bShow(O.QuestOnly));
  elseif (msg == "bl") then
    O.ShowBlankLine = not O.ShowBlankLine;
    Msg("Add a blank line before the info text = "..bShow(O.ShowBlankLine));    
  elseif (msg == "rs") then
    LoadSettings(true);
    Msg("Reset SmartSell to default");
  elseif (msg == "sty") then
    O.Style = O.Style + 1;
    if (O.Style > 6) then O.Style = 0 end
    Msg("Style = "..GR..tostring(O.Style));
  elseif (tonumber(msg)) then
    local i = tonumber(msg);
    if (i < 0 or i > 6) then i = 0 end
    O.Style = i;
    Msg("Style = "..GR..tostring(i));
  else
    Msg("", true);
    Msg("Syntax: /ssell [command] or /smartsell [command]");
    Msg(GBL.."0-6"..YLL.."   -  ".."Change display style, current style = "..WH..tostring(O.Style));
    Msg(GBL.."sty"..YLL.."    -  ".."Cycles through all styles, current style = "..WH..tostring(O.Style));
    Msg(GBL.."ii"..YLL.."      -  ".."Toggle display of item icons = "..bShow(O.ShowItemIcons));
    Msg(GBL.."iis #"..YLL.."  -  ".."Item icon size = "..WH..O.ItemIconSize);    
    Msg(GBL.."ci"..YLL.."       -  ".."Toggle display of coin icons = "..bShow(O.ShowCoinIcons));
    Msg(GBL.."cis #"..YLL.."   -  ".."Coin icon size = "..WH..O.CoinIconSize);    
    --Msg(GBL.."ic"..YLL.."      -  ".."Toggle display in combat = "..bShow(O.ShowInCombat));
    Msg(GBL.."lvl"..YLL.."     -  ".."Toggle display of the item level = "..bShow(O.ShowItemLevel));
    Msg(GBL.."id"..YLL.."      -  ".."Toggle display of the item id = "..bShow(O.ShowItemID));
    Msg(GBL.."sc"..YLL.."      -  ".."Toggle display of the item stack count = "..bShow(O.ShowItemStackCount));
    Msg(GBL.."sp"..YLL.."     -  ".."Toggle display of the stack price = "..bShow(O.ShowStackValue));
    Msg(GBL.."pp"..YLL.."     -  ".."Toggle display of price per piece = "..bShow(O.ShowPieceValue));
    Msg(GBL.."val"..YLL.."    -  ".."Toggle display of the item value = "..bShow(O.ShowItemValue));
    Msg(GBL.."t"..YLL.."       -  ".."Toggle display of the item type = "..bShow(O.ShowItemType));
    Msg(GBL.."st"..YLL.."      -  ".."Toggle display of the item sub type = "..bShow(O.ShowItemSubType));
    Msg(GBL.."qo"..YLL.."     -  ".."Toggle display of info only for quest rewards = "..bShow(O.QuestOnly));
    Msg(GBL.."bl"..YLL.."      -  ".."Toggle add of a blank line before the info text = "..bShow(O.ShowBlankLine));
    Msg(GBL.."rs"..YLL.."      -  ".."Reset all settings to default");
  end
end


function SmartSell_SetTooltipMoney(self, money, type, prefixText, suffixText)
  CheckInit();
  if (self and self:GetItem()) then
    if (self.MoneyCount == nil) then self.MoneyCount = { }; end
    tinsert(self.MoneyCount, {money, type, prefixText, suffixText});
  else
    SetTooltipMoney_Base(self, money, type, prefixText, suffixText);
  end
end


function SmartSell_ToolTipHook(self)
  local name, link = self:GetItem()
  AddToTooltip(self, link);
end


-- Chat slash commands
SLASH_SMARTSELL1 = "/ssell";
SLASH_SMARTSELL2 = "/smartsell";
SlashCmdList["SMARTSELL"] = SmartSell_Command;

-- Replace original SetTooltipMoney
SetTooltipMoney = SmartSell_SetTooltipMoney;

-- Secure hooks
GameTooltip:HookScript("OnTooltipSetItem", SmartSell_ToolTipHook);
ItemRefTooltip:HookScript("OnTooltipSetItem", SmartSell_ToolTipHook);
ShoppingTooltip1:HookScript("OnTooltipSetItem", SmartSell_ToolTipHook)
ShoppingTooltip2:HookScript("OnTooltipSetItem", SmartSell_ToolTipHook);
ItemRefShoppingTooltip1:HookScript("OnTooltipSetItem", SmartSell_ToolTipHook);
ItemRefShoppingTooltip2:HookScript("OnTooltipSetItem", SmartSell_ToolTipHook);

Msg(TitleVersion.." loaded");