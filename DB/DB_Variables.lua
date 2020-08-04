-- Namespace Variables
local addon, addonTbl = ...;

-- Module-Local Variables
local L = addonTbl.L;

-- ARRAYS (TABLES)

-- BOOLEANS
local isRecorderActiveStateOK								= false;
local isInInstance 											= false;
local isMidasLoaded 										= IsAddOnLoaded("Midas");
local recorderState											= 0;
addonTbl.isRecorderActiveStateOK							= isRecorderActiveStateOK;
addonTbl.isInInstance 										= isInInstance;
addonTbl.isMidasLoaded 										= isMidasLoaded;
addonTbl.recorderState										= recorderState;

-- CONSTANTS
local numTabs												= 2;
addonTbl.numTabs											= numTabs;

-- INTEGERS
local currentMoney											= 0;
local moneyObtainedThisSession								= 0;
addonTbl.currentMoney										= currentMoney;
addonTbl.moneyObtainedThisSession							= moneyObtainedThisSession;

-- STRINGS
local currentMap 											= "";
local mailSubject											= "";
local playerName											= UnitName(L["PLAYER"]);
local _, realmName											= UnitFullName(L["PLAYER"]);
addonTbl.currentMap 										= currentMap;
addonTbl.mailSubject										= mailSubject;
addonTbl.playerName											= playerName;
addonTbl.realmName											= realmName;