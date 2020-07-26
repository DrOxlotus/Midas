-- Namespace Variables
local addon, addonTbl = ...;

-- Module-Local Variables
local L = addonTbl.L;

-- ARRAYS (TABLES)

-- BOOLEANS
local isRecorderActiveStateOK								= false;
local isInInstance 											= false;
local isMidasLoaded 										= IsAddOnLoaded("Midas");
addonTbl.isRecorderActiveStateOK							= isRecorderActiveStateOK;
addonTbl.isInInstance 										= isInInstance;
addonTbl.isMidasLoaded 										= isMidasLoaded;

-- INTEGERS
local moneyObtainedThisSession								= 0;
addonTbl.moneyObtainedThisSession							= moneyObtainedThisSession;

-- STRINGS
local currentMap 											= "";
local playerName											= UnitName(L["PLAYER"]);
local _, realmName											= UnitFullName(L["PLAYER"]);
addonTbl.currentMap 										= currentMap;
addonTbl.playerName											= playerName;
addonTbl.realmName											= realmName;