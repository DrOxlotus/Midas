--[[
	NOTE: Synopses pertain to the code directly above them!
	© 2020 iamlightsky
]]

-- Namespace Variables
local addon, tbl = ...;

-- Module-Local Variables
local eventFrame = CreateFrame("Frame");
local isPlayerInCombat;
local GlobalStrings = tbl.GlobalStrings;

for _, event in ipairs(tbl.events) do
	eventFrame:RegisterEvent(event);
end
-- Synopsis: Registers all events that the addon cares about using the events table in the corresponding table file.

local function IsPlayerInCombat()
	-- Maps can't be updated while the player is in combat.
	if UnitAffectingCombat(GlobalStrings["PLAYER"]) then
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
		
		C_Timer.After(0, function() C_Timer.After(3, function() tbl.GetCurrentMap() end); end); -- Wait 3 seconds before asking the game for the new map.
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
					tbl.CreateWidget("Button", "sendMailButton", "Interface\\Minimap\\Tracking\\mailbox", MailFrameTab2, "CENTER", MailFrameTab2, "RIGHT", 40, 400, 30, 30);
					MailFrameTab2.sendMailButton:SetScript("OnClick", function(self)
						if tbl[tbl.realmName].mailCharacter ~= nil then
							local money = tbl.moneyObtainedThisSession;
							local moneyLength = string.len(money);
							if money ~= 0 then
								SendMailNameEditBox:SetText(tbl[tbl.realmName].mailCharacter);
								SendMailSubjectEditBox:SetText(addon); tbl.mailSubject = addon;
								SendMailMoney.copper:SetText(string.sub(money, moneyLength-1, moneyLength-0));
								if money >= 100 then
									SendMailMoney.silver:SetText(string.sub(money, moneyLength-3, moneyLength-2));
								end
								if money >= 10000 then
									SendMailMoney.gold:SetText(string.sub(money, 0, moneyLength-4));
								end
							else
								print(GlobalStrings["ADDON_NAME"] .. GlobalStrings["NO_MONEY_TO_SEND"]);
							end
						else
							print(GlobalStrings["ADDON_NAME"] .. GlobalStrings["MAIL_CHARACTER_NOT_SET"]);
						end
					end);
					MailFrameTab2.sendMailButton:SetScript("OnEnter", function(self) tbl.ShowTooltip(self, GlobalStrings["SEND_MAIL"], nil) end);
					MailFrameTab2.sendMailButton:SetScript("OnLeave", function(self) tbl.HideTooltip(self) end);
				else
					MailFrameTab2.sendMailButton:Show();
				end
			end);
		end
	end
	
	if event == "MAIL_SEND_SUCCESS" then
		if tbl.mailSubject == addon then
			tbl.currentMoney = GetMoney() - (tbl.moneyObtainedThisSession + 30); -- The 30 is the cost for sending the mail
			tbl.UpdateWidget("money", tbl.frame, GetCoinTextureString(tbl.currentMoney), "update-text");
			tbl.moneyObtainedThisSession = 0;
			tbl.recorderState = 0;
		end
		tbl.mailSubject = ""; 
	end
	
	if event == "PLAYER_LOGIN" then
		print(GlobalStrings["ADDON_NAME"] .. GlobalStrings["ADDON_LOAD_SUCCESSFUL"]);
		
		-- Create the main frame
		tbl.CreateFrame("MidasMainFrameUI", 275, 100);
		
		-- The player's realm name is apparently nil at login. So ask again.
		_, tbl.realmName = UnitFullName(GlobalStrings["PLAYER"]);
		tbl.InitializeSavedVars(); -- Initialize the tables if they're nil. This is usually only for players that first install the addon.
		tbl.LoadSettings(true);
		tbl.SetLocale(MidasSettings["locale"]); MidasSettings["locale"] = tbl["locale"];
		tbl.GetCurrentMap();
		tbl.currentMoney = GetMoney();
		
		tbl[tbl.realmName] = MidasRealms[tbl.realmName];
	end
	-- Synopsis: Loads data in after the player logs in or reloads.
	
	if event == "PLAYER_LOGOUT" then
		if tbl.moneyObtainedThisSession > 0 then MidasCharacterHistory.moneyObtainedLastSession = tbl.moneyObtainedThisSession end;
		MidasCharacterHistory.playerMoneyLastSession = tbl.currentMoney;
	end
	-- Synopsis: Writes data to the cache.
	
	if event == "PLAYER_MONEY" then
		if tbl.currentMoney > GetMoney() then return end; -- The event fired because the player lost money.
		if tbl.recorderState and tbl.recorderState ~= 0 then
			local rawMoneyObtained = GetMoney() - tbl.currentMoney;
			tbl.moneyObtainedThisSession = tbl.moneyObtainedThisSession + rawMoneyObtained;
			tbl.UpdateWidget("money", tbl.frame, GetCoinTextureString(tbl.moneyObtainedThisSession), "update-text");
			tbl.currentMoney = GetMoney();
			
			if tbl.isInInstance then
				if not MidasCharacterHistory["Instances"][tbl.currentMap] then MidasCharacterHistory["Instances"][tbl.currentMap] = 0 end; -- To prevent arithmetic nil errors on the next step.
				MidasCharacterHistory["Instances"][tbl.currentMap] = MidasCharacterHistory["Instances"][tbl.currentMap] + rawMoneyObtained;
			end
		end
	end
	-- Synopsis: Tracks the money the player accrues from various sources. (eg. looting enemies, completing quests, etc.)
end);