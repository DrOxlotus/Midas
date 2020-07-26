-- Namespace Variables
local addon, addonTbl = ...;

-- Module-Local Variables
local L = addonTbl.L;

local ignoredMaps = {
	[671]	= "The Cove of Nashal",		-- Stormheim Intro (Alliance)
	[717]	= "Dreadscar Rift",			-- Warlock Class Hall
	[718]	= "Dreadscar Rift",			-- Warlock Class Hall Unlock
	[773]	= "Tol Barad",				-- Destruction Warlock Artifact
	[774]	= "Baradin Hold",			-- Destruction Warlock Artifact
};

addonTbl.ignoredMaps = ignoredMaps;