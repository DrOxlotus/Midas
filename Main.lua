--[[
	NOTE: Synopses pertain to the code directly above them!
	© 2020 iamlightsky
]]

-- Namespace Variables
local addon, addonTbl = ...;

-- Module-Local Variables
local eventFrame = CreateFrame("Frame");
local isPlayerInCombat;
local L = addonTbl.L;
local currentMoney = 0;

for _, event in ipairs(addonTbl.events) do
	eventFrame:RegisterEvent(event);
end
-- Synopsis: Registers all events that the addon cares about using the events table in the corresponding table file.

local function IsPlayerInCombat()
	-- Maps can't be updated while the player is in combat.
	if UnitAffectingCombat(L["PLAYER"]) then
		isPlayerInCombat = true;
	else
		isPlayerInCombat = false;
	end
end
--[[
	Synopsis: Checks to see if the player is in combat.
	Use Cases:
		- Maps can't be updated while the player is in combat.
]]

eventFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "INSTANCE_GROUP_SIZE_CHANGED" or "ZONE_CHANGED_NEW_AREA" then
		if IsPlayerInCombat() then -- Maps can't be updated in combat.
			while isPlayerInCombat do
				C_Timer.After(0, function() C_Timer.After(3, function() IsPlayerInCombat() end); end);
			end
		end
		
		C_Timer.After(0, function() C_Timer.After(3, function() addonTbl.GetCurrentMap() end); end); -- Wait 3 seconds before asking the game for the new map.
	end
	-- Synopsis: Get the player's map when they change zones or enter instances.
	
	if event == "MAIL_CLOSED" then
		if MailFrameTab2.sendMailButton then
			MailFrameTab2.sendMailButton:Hide();
		end
	end
	
	if event == "MAIL_INBOX_UPDATE" then
		if MailFrame:IsShown() then -- To avoid any possible nils
			MailFrameTab1:SetScript("OnClick", function(self)
				MailFrameTab_OnClick(self, 1);
				if MailFrameTab2.sendMailButton then
					MailFrameTab2.sendMailButton:Hide();
				end
			end);
			MailFrameTab2:SetScript("OnClick", function(self)
				MailFrameTab_OnClick(self, 2);
				if not MailFrameTab2.sendMailButton then -- Don't want the button to be created over and over
					addonTbl.CreateWidget("Button", "sendMailButton", "Interface\\Minimap\\Tracking\\mailbox", MailFrameTab2, "CENTER", MailFrameTab2, "RIGHT", 40, 400, 30, 30);
					MailFrameTab2.sendMailButton:SetScript("OnClick", function(self)
						if addonTbl[addonTbl.realmName].mailCharacter ~= nil then
							local money = addonTbl.moneyObtainedThisSession;
							local moneyLength = string.len(money);
							if money ~= 0 then
								SendMailNameEditBox:SetText(addonTbl[addonTbl.realmName].mailCharacter);
								SendMailSubjectEditBox:SetText(addon); addonTbl.mailSubject = addon;
								SendMailMoney.copper:SetText(string.sub(money, moneyLength-1, moneyLength-0));
								if money >= 100 then
									SendMailMoney.silver:SetText(string.sub(money, moneyLength-3, moneyLength-2));
								end
								if money >= 10000 then
									SendMailMoney.gold:SetText(string.sub(money, 0, moneyLength-4));
								end
							else
								print(L["ADDON_NAME"] .. L["ERR_MSG_NO_MONEY_TO_SEND"]);
							end
						else
							print(L["ADDON_NAME"] .. L["ERR_MSG_MAIL_CHARACTER_NOT_SET"]);
						end
					end);
					MailFrameTab2.sendMailButton:SetScript("OnEnter", function(self) addonTbl.ShowTooltip(self, L["SEND_MAIL_BUTTON"], nil) end);
					MailFrameTab2.sendMailButton:SetScript("OnLeave", function(self) addonTbl.HideTooltip(self) end);
				else
					MailFrameTab2.sendMailButton:Show();
				end
			end);
		end
	end
	
	if event == "MAIL_SEND_SUCCESS" then
		if addonTbl.mailSubject == addon then
			currentMoney = GetMoney() - (addonTbl.moneyObtainedThisSession + 30); addonTbl.currentMoney = currentMoney; -- The 30 is the cost for sending the mail
			addonTbl.moneyObtainedThisSession = 0;
			addonTbl.UpdateWidget("money", addonTbl.frame, GetCoinTextureString(0));
			addonTbl.recorderState = 0;
		end
		addonTbl.mailSubject = ""; 
	end
	
	if event == "PLAYER_LOGIN" then
		print(L["ADDON_NAME"] .. L["INFO_MSG_ADDON_LOAD_SUCCESSFUL"]);
		
		-- The player's realm name is apparently nil at login. So ask again.
		_, addonTbl.realmName = UnitFullName(L["PLAYER"]);
		addonTbl.InitializeSavedVars(); -- Initialize the tables if they're nil. This is usually only for players that first install the addon.
		addonTbl.LoadSettings(true);
		addonTbl.SetLocale(MidasSettings["locale"]); MidasSettings["locale"] = addonTbl["locale"];
		addonTbl.GetCurrentMap();
		currentMoney = GetMoney(); addonTbl.currentMoney = currentMoney;
		
		addonTbl[addonTbl.realmName] = MidasRealms[addonTbl.realmName];
	end
	-- Synopsis: Loads data in after the player logs in or reloads.
	
	if event == "PLAYER_LOGOUT" then
		if addonTbl.moneyObtainedThisSession > 0 then MidasCharacterHistory.moneyObtainedLastSession = addonTbl.moneyObtainedThisSession end;
		MidasCharacterHistory.playerMoneyLastSession = currentMoney;
	end
	-- Synopsis: Writes data to the cache.
	
	if event == "PLAYER_MONEY" then
		if addonTbl.recorderState == 1 then
			if currentMoney > GetMoney() then return end; -- The event fired because the player lost money.
			local rawMoneyObtained = GetMoney() - currentMoney;
			addonTbl.moneyObtainedThisSession = addonTbl.moneyObtainedThisSession + rawMoneyObtained;
			addonTbl.UpdateWidget("money", addonTbl.frame, GetCoinTextureString(addonTbl.moneyObtainedThisSession));
			currentMoney = GetMoney(); addonTbl.currentMoney = currentMoney;
			
			if addonTbl.isInInstance then
				if not MidasCharacterHistory["Instances"][addonTbl.currentMap] then MidasCharacterHistory["Instances"][addonTbl.currentMap] = 0 end; -- To prevent arithmetic nil errors on the next step.
				MidasCharacterHistory["Instances"][addonTbl.currentMap] = MidasCharacterHistory["Instances"][addonTbl.currentMap] + rawMoneyObtained;
			end
		end
	end
	-- Synopsis: Tracks the money the player accrues from various sources. (eg. looting enemies, completing quests, etc.)
end);