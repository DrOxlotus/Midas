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
local playerName;
local realmName;

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
	
	if event == "PLAYER_LOGIN" then
		print(L["ADDON_NAME"] .. L["INFO_MSG_ADDON_LOAD_SUCCESSFUL"]);
		addonTbl.InitializeSavedVars(); -- Initialize the tables if they're nil. This is usually only for players that first install the addon.
		addonTbl.LoadSettings(true);
		addonTbl.SetLocale(MidasSettings["locale"]); MidasSettings["locale"] = addonTbl["locale"];
		addonTbl.GetCurrentMap();
		currentMoney = GetMoney(); addonTbl.currentMoney = currentMoney;
		playerName, realmName = UnitFullName(L["PLAYER"]); addonTbl.realmName = realmName;
		
		addonTbl[realmName] = MidasRealms[realmName];
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