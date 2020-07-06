--[[
	NOTE: Synopses pertain to the code directly above them!
	© 2020 iamlightsky
]]

-- Namespace Variables
local addon, addonTbl = ...;

-- Module-Local Variables
local eventFrame = CreateFrame("Frame");

for _, event in ipairs(addonTbl.events) do
	frame:RegisterEvent(event);
end
-- Synopsis: Registers all events that the addon cares about using the events table in the corresponding table file.

local function IsPlayerInCombat()
	-- Maps can't be updated while the player is in combat.
	if UnitAffectingCombat(L["IS_PLAYER"]) then
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
	if event == "PLAYER_LOGIN" then
		addonTbl.InitializeSavedVars(); -- Initialize the tables if they're nil. This is usually only for players that first install the addon.
		addonTbl.LoadSettings(true);
		addonTbl.SetLocale(MidasSettings["locale"]); MidasSettings["locale"] = addonTbl["locale"];
		addonTbl.GetCurrentMap();
		playerName = UnitName("player");
		print(L["ADDON_NAME"] .. L["INFO_MSG_ADDON_LOAD_SUCCESSFUL"]);
	end
end);