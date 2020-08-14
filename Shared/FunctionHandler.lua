-- Namespace Variables
local addon, tbl = ...;

-- Module-Local Variables
local GlobalStrings = tbl.GlobalStrings;
local shouldAskAboutLastSession = true;

tbl.InitializeSavedVars = function()
	-- SavedVars
	if MidasMaps == nil then MidasMaps = {} end;
	if MidasSettings == nil then MidasSettings = {} end;
	if MidasPosition == nil then MidasPosition = {} end;
	if MidasRealms == nil then MidasRealms = {} end;
	if MidasRealms[tbl.realmName] == nil then MidasRealms[tbl.realmName] = {} end;
	-- Character SavedVars
	if MidasCharacterHistory == nil then MidasCharacterHistory = {} end;
	if MidasCharacterHistory["Instances"] == nil then MidasCharacterHistory["Instances"] = {} end;
end

tbl.StartAndPause = function()
	if MidasCharacterHistory.moneyObtainedLastSession ~= 0 and MidasCharacterHistory.moneyObtainedLastSession ~= nil and shouldAskAboutLastSession == true then -- A previous session was detected
		StaticPopupDialogs["Midas_Previous_Session_Detected"] = {
			text = GlobalStrings["PREVIOUS_SESSION_DETECTED"],
			button1 = GlobalStrings["YES"],
			button2 = GlobalStrings["NO"],
			OnAccept = function()
				tbl.LoadLastSession();
			end,
			OnCancel = function()
				shouldAskAboutLastSession = false;
				tbl.recorderState = 1;
				tbl.UpdateWidget("money", tbl.frame, GetCoinTextureString(0), "update-text");
				tbl.UpdateWidget("stopAndStartButton", tbl.frame, "Interface\\Icons\\inv_misc_pocketwatch_01", "update-icon");
			end,
			timeout = 0,
			whileDead = true,
			hideOnEscape = true,
			preferredIndex = 3,
		};
	
		StaticPopup_Show("Midas_Previous_Session_Detected");
	else
		if tbl.recorderState == 1 then -- Recorder is active so pause it.
			tbl.recorderState = 0;
			tbl.UpdateWidget("money", tbl.frame, GetCoinTextureString(GetMoney()), "update-text");
			tbl.UpdateWidget("stopAndStartButton", tbl.frame, "Interface\\Icons\\inv_misc_pocketwatch_02", "update-icon");
		else -- Recorder is paused so start it.
			tbl.recorderState = 1;
			tbl.currentMoney = GetMoney(); -- This value needs to be updated to only account for the money obtained while the recorder is active.
			tbl.UpdateWidget("money", tbl.frame, GetCoinTextureString(tbl.moneyObtainedThisSession), "update-text");
			tbl.UpdateWidget("stopAndStartButton", tbl.frame, "Interface\\Icons\\inv_misc_pocketwatch_01", "update-icon");
		end
	end
end

tbl.NewSession = function()
	StaticPopupDialogs["Midas_NewSessionConfirm"] = {
		text = GlobalStrings["NEW_SESSION_CONFIRM"],
		button1 = GlobalStrings["YES"],
		button2 = GlobalStrings["NO"],
		OnAccept = function()
			MidasCharacterHistory.moneyObtainedLastSession = 0; tbl.moneyObtainedThisSession = MidasCharacterHistory.moneyObtainedLastSession;
			tbl.recorderState = 0;
			tbl.UpdateWidget("money", tbl.frame, GetCoinTextureString(GetMoney()), "update-text");
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3,
	};
	
	StaticPopup_Show("Midas_NewSessionConfirm");
end

tbl.LoadLastSession = function()
	if MidasCharacterHistory.moneyObtainedLastSession == 0 or MidasCharacterHistory.moneyObtainedLastSession == nil then
		print(GlobalStrings["ADDON_NAME"] .. GlobalStrings["NO_LAST_SESSION"]);
		return;
	end
	tbl.recorderState = 1;
	tbl.moneyObtainedThisSession = MidasCharacterHistory.moneyObtainedLastSession;
	tbl.UpdateWidget("money", tbl.frame, GetCoinTextureString(MidasCharacterHistory.moneyObtainedLastSession), "update-text");
	tbl.UpdateWidget("stopAndStartButton", tbl.frame, "Interface\\Icons\\inv_misc_pocketwatch_01", "update-icon");
end

tbl.SetMailCharacter = function(mailCharacter, editBox)
	if mailCharacter == "" then return end; -- To prevent setting the character to blank.
	if mailCharacter == "!" then
		tbl[tbl.realmName].mailCharacter = nil;
		MidasRealms[tbl.realmName].mailCharacter = nil;
		print(GlobalStrings["ADDON_NAME"] .. GlobalStrings["MAIL_CHARACTER_RESET"]);
		editBox:SetText("");
		return;
	end
	
	MidasRealms[tbl.realmName].mailCharacter = mailCharacter;
	tbl[tbl.realmName].mailCharacter = mailCharacter;
	
	editBox:SetText("");
	
	print(GlobalStrings["ADDON_NAME"] .. GlobalStrings["MAIL_CHARACTER_SET"] .. mailCharacter .. "!");
end

tbl.Search = function(instance)
	if MidasCharacterHistory["Instances"] == {} or MidasCharacterHistory["Instances"] == nil then return end;
	for k, v in pairs(MidasCharacterHistory["Instances"]) do
		if string.find(string.lower(k), string.lower(instance)) then
			print(GlobalStrings["ADDON_NAME"] .. GetCoinTextureString(v) .. " - " .. k);
		end
	end
end