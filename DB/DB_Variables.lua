-- Namespace Variables
local addon, addonTbl = ...;

-- Module-Local Variables
local L = addonTbl.L;

-- ARRAYS (TABLES)

-- BOOLEANS
local isInInstance 											= false;
local isMidasLoaded 										= IsAddOnLoaded("Midas");
addonTbl.isInInstance 										= isInInstance;
addonTbl.isMidasLoaded 										= isMidasLoaded;

-- INTEGERS
local moneyObtainedThisSession								= 0;
addonTbl.moneyObtainedThisSession							= moneyObtainedThisSession;

-- STRINGS
local currentMap 											= "";
addonTbl.currentMap 										= currentMap;