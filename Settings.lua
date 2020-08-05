-- Namespace Variables
local addon, tbl = ...;

-- Module-Local Variables
local GlobalStrings = tbl.GlobalStrings;

local function GetOptions(arg)
	if MidasSettings[arg] ~= nil then
		tbl[arg] = MidasSettings[arg];
		return tbl[arg];
	else
		if arg == "activeRecorderReminder" then
			MidasSettings[arg] = false; tbl[arg] = MidasSettings[arg];
			return tbl[arg];
		end
		if arg == "locale" then
			MidasSettings[arg] = "enUS"; tbl[arg] = MidasSettings[arg];
			return tbl[arg];
		end
	end
end
-- Synopsis: When the addon is loaded into memory after login, the addon will ask the cache for the last known
-- value of the mode, rarity, and lootFast variables.

tbl.LoadSettings = function(doNotOpen)
	if doNotOpen then
		MidasSettings = {activeRecorderReminder = GetOptions("activeRecorderReminder"), locale = GetOptions("locale")};
	else
		--tbl.CreateFrame("MidasMainFrame", 275, 100);
	end
end
--[[
	Synopsis: Loads either the settings from the cache or loads the settings frame.
	Use Case(s):
		true: If 'doNotOpen' is true, then the addon made the call so it can load the settings from the cache.
		false: If 'doNotOpen' is false, then the player made the call so the settings menu should be shown (or closed if already open.)
]]