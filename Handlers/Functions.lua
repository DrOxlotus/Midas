-- Namespace Variables
local addon, addonTbl = ...;

-- Module-Local Variables
local L = addonTbl.L;
local recorderState = 0;
local _, realmName = UnitFullName(L["PLAYER"]); addonTbl.realmName = realmName;

addonTbl.InitializeSavedVars = function()
	-- SavedVars
	if MidasMaps == nil then MidasMaps = {} end;
	if MidasSettings == nil then MidasSettings = {} end;
	if MidasRealms == nil then MidasRealms = {} end;
	if MidasRealms[realmName] == nil then MidasRealms[realmName] = {} end;
	-- Character SavedVars
	if MidasCharacterHistory == nil then MidasCharacterHistory = {} end;
	if MidasCharacterHistory["Instances"] == nil then MidasCharacterHistory["Instances"] = {} end;
end

addonTbl.StartAndPause = function()
	if recorderState == 1 then -- Recorder is active so pause it.
		recorderState = 0;
		addonTbl.UpdateWidget("money", addonTbl.frame, GetCoinTextureString(GetMoney()));
	else -- Recorder is paused so start it.
		recorderState = 1;
		addonTbl.UpdateWidget("money", addonTbl.frame, GetCoinTextureString(addonTbl.moneyObtainedThisSession));
	end
	addonTbl.recorderState = recorderState;
end

addonTbl.NewSession = function()
	StaticPopupDialogs["Midas_NewSession"] = {
		text = L["INFO_MSG_NEW_SESSION"],
		button1 = L["YES"],
		button2 = L["NO"],
		OnAccept = function()
			MidasCharacterHistory.moneyObtainedLastSession = 0; addonTbl.moneyObtainedThisSession = MidasCharacterHistory.moneyObtainedLastSession;
			recorderState = 0; addonTbl.recorderState = recorderState;
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
	if MidasCharacterHistory.moneyObtainedLastSession == 0 or MidasCharacterHistory.moneyObtainedLastSession == nil then return end;
	recorderState = 1; addonTbl.recorderState = recorderState;
	addonTbl.moneyObtainedThisSession = MidasCharacterHistory.moneyObtainedLastSession;
	addonTbl.UpdateWidget("money", addonTbl.frame, GetCoinTextureString(MidasCharacterHistory.moneyObtainedLastSession));
end

addonTbl.SetMailCharacter = function(mailCharacter, editBox)
	if mailCharacter == "" then return end; -- To prevent setting the character to blank.
	if mailCharacter == "!" then
		addonTbl[realmName].mailCharacter = nil;
		MidasRealms[realmName].mailCharacter = nil;
		print(L["ADDON_NAME"] .. L["INFO_MSG_MAIL_CHARACTER_RESET"]);
		editBox:SetText("");
		return;
	end
	
	MidasRealms[addonTbl.realmName].mailCharacter = mailCharacter;
	addonTbl[addonTbl.realmName].mailCharacter = mailCharacter;
	
	editBox:SetText("");
	
	print(string.format(L["ADDON_NAME"] .. L["INFO_MSG_MAIL_CHARACTER_SET"], mailCharacter));
end