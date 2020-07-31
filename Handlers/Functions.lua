-- Namespace Variables
local addon, addonTbl = ...;

-- Module-Local Variables
local L = addonTbl.L;

addonTbl.InitializeSavedVars = function()
	-- SavedVars
	if MidasMaps == nil then MidasMaps = {} end;
	if MidasSettings == nil then MidasSettings = {} end;
	if MidasPosition == nil then MidasPosition = {} end;
	if MidasRealms == nil then MidasRealms = {} end;
	if MidasRealms[addonTbl.realmName] == nil then MidasRealms[addonTbl.realmName] = {} end;
	-- Character SavedVars
	if MidasCharacterHistory == nil then MidasCharacterHistory = {} end;
	if MidasCharacterHistory["Instances"] == nil then MidasCharacterHistory["Instances"] = {} end;
end

addonTbl.StartAndPause = function()
	if MidasCharacterHistory.moneyObtainedLastSession ~= 0 and MidasCharacterHistory.moneyObtainedLastSession ~= nil then -- A previous session was detected
		StaticPopupDialogs["Midas_Previous_Session_Detected"] = {
			text = L["INFO_MSG_PREVIOUS_SESSION_DETECTED"],
			button1 = L["YES"],
			button2 = L["NO"],
			OnAccept = function()
				addonTbl.LoadLastSession();
			end,
			OnCancel = function()
				addonTbl.recorderState = 1;
				addonTbl.UpdateWidget("money", addonTbl.frame, GetCoinTextureString(0));
			end,
			timeout = 0,
			whileDead = true,
			hideOnEscape = true,
			preferredIndex = 3,
		};
	
		StaticPopup_Show("Midas_Previous_Session_Detected");
	else
		if addonTbl.recorderState == 1 then -- Recorder is active so pause it.
			addonTbl.recorderState = 0;
			addonTbl.UpdateWidget("money", addonTbl.frame, GetCoinTextureString(GetMoney()));
		else -- Recorder is paused so start it.
			addonTbl.recorderState = 1;
			addonTbl.UpdateWidget("money", addonTbl.frame, GetCoinTextureString(addonTbl.moneyObtainedThisSession));
		end
		addonTbl.recorderState = recorderState;
	end
end

addonTbl.NewSession = function()
	StaticPopupDialogs["Midas_NewSession"] = {
		text = L["INFO_MSG_NEW_SESSION"],
		button1 = L["YES"],
		button2 = L["NO"],
		OnAccept = function()
			MidasCharacterHistory.moneyObtainedLastSession = 0; addonTbl.moneyObtainedThisSession = MidasCharacterHistory.moneyObtainedLastSession;
			adonnTbl.recorderState = 0;
			addonTbl.UpdateWidget("money", addonTbl.frame, GetCoinTextureString(GetMoney()));
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3,
	};
	
	StaticPopup_Show("Midas_NewSession");
end

addonTbl.LoadLastSession = function()
	if MidasCharacterHistory.moneyObtainedLastSession == 0 or MidasCharacterHistory.moneyObtainedLastSession == nil then
		print(L["ADDON_NAME"] .. L["ERR_MSG_NO_LAST_SESSION"]);
		return;
	end
	addonTbl.recorderState = 1;
	addonTbl.moneyObtainedThisSession = MidasCharacterHistory.moneyObtainedLastSession;
	addonTbl.UpdateWidget("money", addonTbl.frame, GetCoinTextureString(MidasCharacterHistory.moneyObtainedLastSession));
end

--[[addonTbl.LoadSetting = function(setting)
	
end]]

addonTbl.SetMailCharacter = function(mailCharacter, editBox)
	if mailCharacter == "" then return end; -- To prevent setting the character to blank.
	if mailCharacter == "!" then
		addonTbl[addonTbl.realmName].mailCharacter = nil;
		MidasRealms[addonTbl.realmName].mailCharacter = nil;
		print(L["ADDON_NAME"] .. L["INFO_MSG_MAIL_CHARACTER_RESET"]);
		editBox:SetText("");
		return;
	end
	
	MidasRealms[addonTbl.realmName].mailCharacter = mailCharacter;
	addonTbl[addonTbl.realmName].mailCharacter = mailCharacter;
	
	editBox:SetText("");
	
	print(string.format(L["ADDON_NAME"] .. L["INFO_MSG_MAIL_CHARACTER_SET"], mailCharacter));
end