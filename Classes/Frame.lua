-- Namespace Variables
local addon, addonTbl = ...;

-- Module-Local Variables
local frame;
local isFrameVisible;
local L = addonTbl.L;

local function ShowTooltip(self, text, state)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	if state == 1 then
		GameTooltip:SetText(text .. "\n" .. L["INFO_MSG_ENABLED"]);
	elseif state == 0 then
		GameTooltip:SetText(text .. "\n" .. L["INFO_MSG_DISABLED"]);
	else
		GameTooltip:SetText(text);
	end
	GameTooltip:Show();
end
-- Displays a custom tooltip.
--[[
	self:			This is the instance of the GameTooltip object
	text:			Text to display when the tooltip is shown
]]

local function HideTooltip(self)
	if GameTooltip:GetOwner() == self then
		GameTooltip:Hide();
	end
end
-- Synopsis: Hides a custom tooltip.
--[[
	self:			This is the instance of the GameTooltip object
]]

local function Hide(frame)
	isFrameVisible = false;
	frame:Hide();
end
-- Synopsis: Hides the provided frame from the screen.
--[[
	frame:			Name of the frame to hide
]]

local function Show(frame)
	if isFrameVisible then
		Hide(frame);
	else
		isFrameVisible = true;
		
		-- WIDGETS
		if not frame["title"] then -- If title doesn't exist, then it's likely that none of the other widgets exist.
			addonTbl.CreateWidget("FontString", "title", L["RELEASE"] .. L["ADDON_NAME_SETTINGS"], frame, "CENTER", frame.TitleBg, "CENTER", 5, 0, nil, nil);
			addonTbl.CreateWidget("Button", "stopAndStartButton", "|T"..addonTbl.icons[1]["iconID"]..":16|t", frame, "CENTER", frame, "CENTER", -110, 5, 30, 30);
			addonTbl.CreateWidget("Button", "newSessionButton", "|T"..addonTbl.icons[2]["iconID"]..":16|t", frame, "CENTER", frame, "CENTER", -80, 5, 30, 30);
			addonTbl.CreateWidget("Button", "reloadLastSessionButton", "|T"..addonTbl.icons[3]["iconID"]..":16|t", frame, "CENTER", frame, "CENTER", -50, 5, 30, 30);
			addonTbl.CreateWidget("Button", "openOptionsButton", L["BUTTON_OPTIONS"], frame, "CENTER", frame, "CENTER", 90, 5, 75, 30);
			addonTbl.CreateWidget("FontString", "money", GetCoinTextureString(addonTbl.currentMoney), frame, "CENTER", frame, "CENTER", 60, -30, nil, nil);
		end
		
		if frame then
			frame:SetMovable(true);
			frame:EnableMouse(true);
			frame:RegisterForDrag("LeftButton");
			frame:SetScript("OnDragStart", frame.StartMoving);
			frame:SetScript("OnDragStop", frame.StopMovingOrSizing);
			frame:ClearAllPoints();
			frame:SetPoint("CENTER", PlayerFrame, "CENTER", 50, -100);
		end
		
		-- FRAME BEHAVIORS
			-- Settings Frame X Button
		frame.CloseButton:SetScript("OnClick", function(self) Hide(frame) end); -- When the player selects the X on the frame, hide it. Same behavior as typing the command consecutively.
			-- Start and Stop Button
		frame.stopAndStartButton:SetScript("OnEnter", function(self) ShowTooltip(self, L["BUTTON_START_AND_STOP"], recorderState) end);
		frame.stopAndStartButton:SetScript("OnLeave", function(self) HideTooltip(self) end);
		frame.stopAndStartButton:SetScript("OnClick", function(self) addonTbl.StartAndPause() end);
			-- New Session Button
		frame.newSessionButton:SetScript("OnEnter", function(self) ShowTooltip(self, L["BUTTON_NEW_SESSION"], nil) end);
		frame.newSessionButton:SetScript("OnLeave", function(self) HideTooltip(self) end);
		frame.newSessionButton:SetScript("OnClick", function(self) addonTbl.NewSession() end);
			-- Reload Last Session Button
		frame.reloadLastSessionButton:SetScript("OnEnter", function(self) ShowTooltip(self, L["BUTTON_RELOAD_LAST_SESSION"], nil) end);
		frame.reloadLastSessionButton:SetScript("OnLeave", function(self) HideTooltip(self) end);
		frame.reloadLastSessionButton:SetScript("OnClick", function(self) addonTbl.LoadLastSession() end);
		
		frame:Show();
	end
end
-- Synopsis: Displays the provided frame on screen.
--[[
	frame:			Name of the frame to display
]]

addonTbl.CreateFrame = function(name, height, width)
	-- If the frame is already created, then call the Show function instead.
	if not frame then
		frame = CreateFrame("Frame", name, UIParent, "BasicFrameTemplateWithInset");
		frame:SetSize(height, width);
		Show(frame);
	else
		Show(frame);
	end
	addonTbl.frame = frame;
end
-- Synopsis: Responsible for building a frame.
--[[
	name:			Name of the frame
	height:			The height, in pixels, of the frame
	width:			The width or length, in pixels, of the frame
]]
