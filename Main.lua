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
		addonTbl.InitializeSavedVars(); -- Initialize the tables if they're nil. This is usually only for players that first install the addon.
		addonTbl.LoadSettings(true);
		addonTbl.SetLocale(MidasSettings["locale"]); MidasSettings["locale"] = addonTbl["locale"];
		addonTbl.GetCurrentMap();
		playerName, realmName = UnitName(L["PLAYER"]);
		print(L["ADDON_NAME"] .. L["INFO_MSG_ADDON_LOAD_SUCCESSFUL"]);
	end
	
	if event == "PLAYER_MONEY" then
		if addonTbl.money > GetMoney() then return end; -- The event fired because the player lost money.
		local moneyObtainedFromSource = GetMoney() - addonTbl.money;
		print("You had " .. GetCoinTextureString(addonTbl.money) .. ".");
		print("You gained " .. GetCoinTextureString(moneyObtainedFromSource) .. ".");
		print("You now have " .. GetCoinTextureString((addonTbl.money + moneyObtainedFromSource)) .. ".");
		addonTbl.money = GetMoney();
	end
	-- Synopsis: Tracks the money the player accrues from various sources. (eg. looting enemies, completing quests, etc.)
end);