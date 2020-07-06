-- Namespace Variables
local addon, addonTbl = ...;

-- Module-Local Variables
local L = addonTbl.L;

local function GetOptions(arg)
	if MidasSettings[arg] ~= nil then
		addonTbl[arg] = MidasSettings[arg];
		return addonTbl[arg];
	else
		if arg == "locale" then
			MidasSettings[arg] = "enUS"; addonTbl[arg] = MidasSettings[arg];
			return addonTbl[arg];
		end
	end
end
-- Synopsis: When the addon is loaded into memory after login, the addon will ask the cache for the last known
-- value of the mode, rarity, and lootFast variables.

addonTbl.LoadSettings = function(doNotOpen)
	if doNotOpen then
		MidasSettings = {locale = GetOptions("locale")};
	else
		addonTbl.CreateFrame("MidasMainFrame", 200, 125);
	end
end
--[[
	Synopsis: Loads either the settings from the cache or loads the settings frame.
	Use Case(s):
		true: If 'doNotOpen' is true, then the addon made the call so it can load the settings from the cache.
		false: If 'doNotOpen' is false, then the player made the call so the settings menu should be shown (or closed if already open.)
]]