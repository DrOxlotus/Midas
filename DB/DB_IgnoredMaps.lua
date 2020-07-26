-- Namespace Variables
local addon, addonTbl = ...;

-- Module-Local Variables
local L = addonTbl.L;

local ignoredMaps = {
	[717]	= "Dreadscar Rift",			-- Warlock Class Hall
	[718]	= "Dreadscar Rift",			-- Warlock Class Hall Unlock
	[773]	= "Tol Barad",				-- Destruction Warlock Artifact
};

addonTbl.ignoredMaps = ignoredMaps;