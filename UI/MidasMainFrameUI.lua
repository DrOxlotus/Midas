local addon, tbl = ...;
local GlobalStrings = tbl.GlobalStrings;
local isFrameVisible;

local function MidasMainFrameUI_OnMouseDown(self)
    if not self.isMoving then   
        self:StartMoving();
        self.isMoving = true;
    end
end

local function MidasMainFrameUI_OnMouseUp(self)
    if self.isMoving then
        self:StopMovingOrSizing();
        self.isMoving = false;
		
		MidasPosition[1], MidasPosition[2], MidasPosition[3], MidasPosition[4], MidasPosition[5] = self:GetPoint(1);
    end
end

tbl.ShowTooltip = function(self, text)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	
	GameTooltip:SetText(text);
	
	-- Mail Character EditBox
	if tbl[tbl.realmName].mailCharacter ~= nil and (self:GetName() == "mailCharacterEditBox") then
		GameTooltip:SetText(text .. "\n" .. GlobalStrings["CURRENT"] .. tbl[tbl.realmName].mailCharacter);
	elseif tbl[tbl.realmName].mailCharacter == nil and (self:GetName() == "mailCharacterEditBox") then
		GameTooltip:SetText(text .. "\n" .. GlobalStrings["MAIL_CHARACTER_NOT_FOUND"]);
	end
	
	GameTooltip:Show();
end
-- Displays a custom tooltip.
--[[
	self:			This is the instance of the GameTooltip object
	text:			Text to display when the tooltip is shown
]]

tbl.HideTooltip = function(self)
	if GameTooltip:GetOwner() == self then
		GameTooltip:Hide();
	end
end

tbl.MidasMainFrameUI_OnLoad = function(self)
	if MidasSettings == nil then MidasSettings = {} end;
	if not self["title"] then -- If title doesn't exist, then it's likely that none of the other widgets exist.
		tbl.CreateWidget("Button", "stopAndStartButton", "Interface\\Icons\\inv_misc_pocketwatch_02", self, "CENTER", self, "CENTER", -110, 5, 30, 30);
		tbl.CreateWidget("Button", "newSessionButton", "Interface\\Icons\\spell_chargepositive", self, "CENTER", self, "CENTER", -70, 5, 30, 30);
		tbl.CreateWidget("Button", "reloadLastSessionButton", "Interface\\Icons\\inv_letter_18", self, "CENTER", self, "CENTER", -30, 5, 30, 30);
		tbl.CreateWidget("CheckButton", "activeRecorderReminderCheckButton", "", self, "CENTER", self, "CENTER", -110, -30, nil, nil);
		tbl.CreateWidget("EditBox", "mailCharacterEditBox", "", self, "CENTER", self, "CENTER", 75, 5, 120, 30);
		tbl.CreateWidget("FontString", "title", GlobalStrings["RELEASE"] .. GlobalStrings["ADDON_NAME_SETTINGS"], self, "CENTER", self.TitleBg, "CENTER", 5, 0, nil, nil);
		tbl.CreateWidget("FontString", "money", GetCoinTextureString(GetMoney()), self, "CENTER", self, "CENTER", 60, -30, nil, nil);
	end
			
	if self then
		self:SetMovable(true);
		self:EnableMouse(true);
		self:SetScript("OnMouseDown", MidasMainFrameUI_OnMouseDown);
		self:SetScript("OnMouseUp", MidasMainFrameUI_OnMouseUp);
	end

	self.activeRecorderReminderCheckButton:SetScript("OnClick", function(self)
		if self:GetChecked() then
			tbl.activeRecorderReminder = true;
			MidasSettings.activeRecorderReminder = true;
		else
			tbl.activeRecorderReminder = false;
			MidasSettings.activeRecorderReminder = false;
		end
	end);
	self.CloseButton:SetScript("OnClick", function(self) tbl.MidasMainFrameUI_OnHide(self:GetParent()) end); -- When the player selects the X on the self, hide it. Same behavior as typing the command consecutively.
	self.newSessionButton:SetScript("OnClick", function(self) tbl.NewSession() end);
	self.reloadLastSessionButton:SetScript("OnClick", function(self) tbl.LoadLastSession() end);
	self.stopAndStartButton:SetScript("OnClick", function(self) tbl.StartAndPause() end);
	
	self.activeRecorderReminderCheckButton:SetScript("OnEnter", function(self) tbl.ShowTooltip(self, GlobalStrings["ACTIVE_RECORDER_REMINDER"]) end);
	self.mailCharacterEditBox:SetScript("OnEnter", function(self) tbl.ShowTooltip(self, GlobalStrings["MAIL_CHARACTER_EDITBOX"]) end);
	self.mailCharacterEditBox:SetScript("OnEnterPressed", function(self) tbl.SetMailCharacter(self:GetText(), self) end);
	self.newSessionButton:SetScript("OnEnter", function(self) tbl.ShowTooltip(self, GlobalStrings["NEW_SESSION"]) end);
	self.reloadLastSessionButton:SetScript("OnEnter", function(self) tbl.ShowTooltip(self, GlobalStrings["RELOAD_LAST_SESSION"]) end);
	self.stopAndStartButton:SetScript("OnEnter", function(self) tbl.ShowTooltip(self, GlobalStrings["STOP_AND_START"]) end);
	
	self.activeRecorderReminderCheckButton:SetScript("OnLeave", function(self) tbl.HideTooltip(self) end);
	self.mailCharacterEditBox:SetScript("OnLeave", function(self) tbl.HideTooltip(self) end);
	self.newSessionButton:SetScript("OnLeave", function(self) tbl.HideTooltip(self) end);
	self.reloadLastSessionButton:SetScript("OnLeave", function(self) tbl.HideTooltip(self) end);
	self.stopAndStartButton:SetScript("OnLeave", function(self) tbl.HideTooltip(self) end);
	
	if MidasSettings["activeRecorderReminder"] then
		self.activeRecorderReminderCheckButton:SetChecked(true);
		tbl.activeRecorderReminder = true;
	else
		self.activeRecorderReminderCheckButton:SetChecked(false);
		tbl.activeRecorderReminder = false;
	end

	isFrameVisible = false;
end
-- When the addon loads, we want to pre-build the self.

tbl.MidasMainFrameUI_OnHide = function(self)
	self:Hide();
	isFrameVisible = false;
	PlaySound(SOUNDKIT.ACHIEVEMENT_MENU_CLOSE);
end

tbl.MidasMainFrameUI_OnShow = function(self)
	if isFrameVisible then
		tbl.MidasMainFrameUI_OnHide(self);
	else
		if MidasPosition[1] then
			self:ClearAllPoints();
			self:SetPoint(MidasPosition[1], "WorldFrame", MidasPosition[3], MidasPosition[4], MidasPosition[5]);
		else
			self:ClearAllPoints();
			self:SetPoint("CENTER");
		end
		self:Show();
		isFrameVisible = true;
	end
	PlaySound(SOUNDKIT.ACHIEVEMENT_MENU_OPEN);
end