-- Namespace Variables
local addon, addonTbl = ...;

-- Module-Local Variables
local L = addonTbl.L;

-- ARRAYS (TABLES)
local icons = {
	{
		["iconID"] = 134377, -- Clockwork Heart
	},
	{
		["iconID"] = 134149, -- Save Krennan
	},
	{
		["iconID"] = 252180, -- Passenger Loaded
	},
};
addonTbl.icons												= icons;

-- BOOLEANS
local isInInstance 											= false;
local isMidasLoaded 										= IsAddOnLoaded("Midas");
addonTbl.isInInstance 										= isInInstance;
addonTbl.isMidasLoaded 										= isMidasLoaded;

-- INTEGERS
local money													= GetMoney();
addonTbl.money												= money;

-- STRINGS
local currentMap 											= "";
addonTbl.currentMap 										= currentMap;