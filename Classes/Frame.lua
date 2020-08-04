-- Variables
local addon, addonTbl = ...;
local frame;
local isFrameVisible;
local L = addonTbl.L;

addonTbl.ShowTooltip = function(self, text, state)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	
	-- Recorder button
	if state == 1 then
		GameTooltip:SetText(text .. "\n" .. L["ENABLED"]);
	elseif state == 0 then
		GameTooltip:SetText(text .. "\n" .. L["DISABLED"]);
	else
		GameTooltip:SetText(text);
	end
	
	-- Mail Character EditBox
	if addonTbl[addonTbl.realmName].mailCharacter ~= nil and (self:GetName() == "mailCharacterEditBox") then
		GameTooltip:SetText(text .. "\n" .. L["CURRENT"] .. addonTbl[addonTbl.realmName].mailCharacter);
	elseif addonTbl[addonTbl.realmName].mailCharacter == nil and (self:GetName() == "mailCharacterEditBox") then
		GameTooltip:SetText(text .. "\n" .. L["MAIL_CHARACTER_NOT_FOUND"]);
	end
	
	GameTooltip:Show();
end
-- Displays a custom tooltip.
--[[
	self:			This is the instance of the GameTooltip object
	text:			Text to display when the tooltip is shown
]]

addonTbl.HideTooltip = function(self)
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

local function OnMouseDown(self)
    if not self.isMoving then   
        self:StartMoving();
        self.isMoving = true;
    end
end

local function OnMouseUp(self)
    if self.isMoving then
        self:StopMovingOrSizing();
        self.isMoving = false;
		
		MidasPosition[1], MidasPosition[2], MidasPosition[3], MidasPosition[4], MidasPosition[5] = self:GetPoint(1);
    end
end

local function Show(frame)
	if isFrameVisible then
		Hide(frame);
	else
		isFrameVisible = true;
		
		-- WIDGETS
		if not frame["title"] then -- If title doesn't exist, then it's likely that none of the other widgets exist.
			addonTbl.CreateWidget("FontString", "title", L["RELEASE"] .. L["ADDON_NAME_SETTINGS"], frame, "CENTER", frame.TitleBg, "CENTER", 5, 0, nil, nil);
			addonTbl.CreateWidget("Button", "stopAndStartButton", "Interface\\Icons\\inv_misc_pocketwatch_02", frame, "CENTER", frame, "CENTER", -110, 5, 30, 30);
			addonTbl.CreateWidget("Button", "newSessionButton", "Interface\\Icons\\spell_chargepositive", frame, "CENTER", frame, "CENTER", -70, 5, 30, 30);
			addonTbl.CreateWidget("Button", "reloadLastSessionButton", "Interface\\Icons\\inv_letter_18", frame, "CENTER", frame, "CENTER", -30, 5, 30, 30);
			addonTbl.CreateWidget("CheckButton", "activeRecorderReminderCheckButton", "", frame, "CENTER", frame, "CENTER", -110, -30, nil, nil);
			addonTbl.CreateWidget("EditBox", "mailCharacterEditBox", "", frame, "CENTER", frame, "CENTER", 75, 5, 120, 30);
			addonTbl.CreateWidget("FontString", "money", GetCoinTextureString(GetMoney()), frame, "CENTER", frame, "CENTER", 60, -30, nil, nil);
		end
			
		if frame then
			frame:SetMovable(true);
			frame:EnableMouse(true);
			frame:SetScript("OnMouseDown", OnMouseDown);
			frame:SetScript("OnMouseUp", OnMouseUp);
			
			if MidasPosition[1] then
				frame:ClearAllPoints();
				frame:SetPoint(MidasPosition[1], "WorldFrame", MidasPosition[3], MidasPosition[4], MidasPosition[5]);
			else
				frame:ClearAllPoints();
				frame:SetPoint("CENTER");
			end
		end
			
		-- FRAME BEHAVIORS
			-- Settings Frame X Button
		frame.CloseButton:SetScript("OnClick", function(self) Hide(frame) end); -- When the player selects the X on the frame, hide it. Same behavior as typing the command consecutively.
			-- Start and Stop Button
		frame.stopAndStartButton:SetScript("OnEnter", function(self) addonTbl.ShowTooltip(self, L["STOP_AND_START"], addonTbl.recorderState) end);
		frame.stopAndStartButton:SetScript("OnLeave", function(self) addonTbl.HideTooltip(self) end);
		frame.stopAndStartButton:SetScript("OnClick", function(self) addonTbl.StartAndPause() end);
			-- New Session Button
		frame.newSessionButton:SetScript("OnEnter", function(self) addonTbl.ShowTooltip(self, L["NEW_SESSION"], nil) end);
		frame.newSessionButton:SetScript("OnLeave", function(self) addonTbl.HideTooltip(self) end);
		frame.newSessionButton:SetScript("OnClick", function(self) addonTbl.NewSession() end);
			-- Reload Last Session Button
		frame.reloadLastSessionButton:SetScript("OnEnter", function(self) addonTbl.ShowTooltip(self, L["RELOAD_LAST_SESSION"], nil) end);
		frame.reloadLastSessionButton:SetScript("OnLeave", function(self) addonTbl.HideTooltip(self) end);
		frame.reloadLastSessionButton:SetScript("OnClick", function(self) addonTbl.LoadLastSession() end);
			-- Active Recorder Reminder CheckButton
		frame.activeRecorderReminderCheckButton:SetScript("OnEnter", function(self) addonTbl.ShowTooltip(self, L["ACTIVE_RECORDER_REMINDER"], nil) end);
		frame.activeRecorderReminderCheckButton:SetScript("OnLeave", function(self) addonTbl.HideTooltip(self) end);
		if MidasSettings["activeRecorderReminder"] then
			frame.activeRecorderReminderCheckButton:SetChecked(true);
			addonTbl.activeRecorderReminder = true;
		else
			frame.activeRecorderReminderCheckButton:SetChecked(false);
			addonTbl.activeRecorderReminder = false;
		end
		frame.activeRecorderReminderCheckButton:SetScript("OnClick", function(self)
			if self:GetChecked() then
				addonTbl.activeRecorderReminder = true;
				MidasSettings.activeRecorderReminder = true;
			else
				addonTbl.activeRecorderReminder = false;
				MidasSettings.activeRecorderReminder = false;
			end
		end);
			-- Mail Character Edit Box
		frame.mailCharacterEditBox:SetScript("OnEnter", function(self) addonTbl.ShowTooltip(self, L["MAIL_CHARACTER_EDITBOX"], nil) end);
		frame.mailCharacterEditBox:SetScript("OnLeave", function(self) addonTbl.HideTooltip(self) end);
		frame.mailCharacterEditBox:SetScript("OnEnterPressed", function(self) addonTbl.SetMailCharacter(frame.mailCharacterEditBox:GetText(), frame.mailCharacterEditBox) end);
		
		frame:Show();
	end
end
-- Synopsis: Displays the provided frame on screen.
--[[
	frame:			Name of the frame to display
]]

addonTbl.CreateFrame = function(name, height, width)
	if not frame then -- A frame needs to be created.
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
