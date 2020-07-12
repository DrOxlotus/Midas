-- Namespace Variables
local addon, addonTbl = ...;

addonTbl.InitializeSavedVars = function()
	-- SavedVars
	if MidasMaps == nil then MidasMaps = {} end;
	if MidasSettings == nil then MidasSettings = {} end;
	-- Character SavedVars
	if MidasCharacterHistory == nil then MidasCharacterHistory = {} end;
end

addonTbl.StartAndPause = function()
	if recorderState == 1 then -- Recorder is active so pause it.
		recorderState = 0;
		addonTbl.UpdateWidget("money", frame, GetCoinTextureString(GetMoney()));
	else -- Recorder is paused so start it.
		recorderState = 1;
		addonTbl.UpdateWidget("money", frame, GetCoinTextureString(addonTbl.moneyObtainedThisSession));
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
			addonTbl.UpdateWidget("money", frame, GetCoinTextureString(GetMoney()));
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
	addonTbl.UpdateWidget("money", frame, GetCoinTextureString(MidasCharacterHistory.moneyObtainedLastSession));
end