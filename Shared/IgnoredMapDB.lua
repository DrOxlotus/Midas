-- Namespace Variables
local addon, tbl = ...;

-- Module-Local Variables
local GlobalStrings = tbl.GlobalStrings;

local ignoredMaps = {
	[118]	= "Icecrown",				-- Class Trials
	[671]	= "The Cove of Nashal",		-- Stormheim Intro (Alliance)
	[717]	= "Dreadscar Rift",			-- Warlock Class Hall
	[718]	= "Dreadscar Rift",			-- Warlock Class Hall Unlock
	[745]	= "Ulduar",					-- BM Hunter Artifact
	[773]	= "Tol Barad",				-- Destruction Warlock Artifact
	[774]	= "Baradin Hold",			-- Destruction Warlock Artifact
	[1469]	= "Vision of Orgrimmar",	-- Horrific Visions
	[1538]	= "Blackwing Descent",		-- BfA Legendary Cloak Scenario
	[1539]	= "Blackwing Descent",		-- BfA Legendary Cloak Scenario
	[1540]	= "Halls of Origination",	-- BfA Legendary Cloak Scenario
	[1541]	= "Halls of Origination",	-- BfA Legendary Cloak Scenario
	[1542]	= "Halls of Origination",	-- BfA Legendary Cloak Scenario
	[1544]	= "Mogu'Shan Palace",		-- BfA Legendary Cloak Scenario
	[1545]	= "Mogu'Shan Palace",		-- BfA Legendary Cloak Scenario
	[1549]	= "Mogu'Shan Palace",		-- BfA Legendary Cloak Scenario
	[1604]	= "Chamber of Heart",		-- Horrific Visions
};

tbl.ignoredMaps = ignoredMaps;