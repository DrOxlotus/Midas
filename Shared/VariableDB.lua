-- Namespace Variables
local addon, tbl = ...;

-- Module-Local Variables
local GlobalStrings = tbl.GlobalStrings;

-- ARRAYS (TABLES)

-- BOOLEANS
local isRecorderActiveStateOK								= false;
local isInInstance 											= false;
local isMidasLoaded 										= IsAddOnLoaded("Midas");
local recorderState											= 0;
tbl.isRecorderActiveStateOK									= isRecorderActiveStateOK;
tbl.isInInstance 											= isInInstance;
tbl.isMidasLoaded 											= isMidasLoaded;
tbl.recorderState											= recorderState;

-- CONSTANTS
local numTabs												= 2;
tbl.numTabs													= numTabs;

-- INTEGERS
local currentMoney											= 0;
local moneyObtainedThisSession								= 0;
tbl.currentMoney											= currentMoney;
tbl.moneyObtainedThisSession								= moneyObtainedThisSession;

-- STRINGS
local currentMap 											= "";
local mailSubject											= "";
local playerName											= UnitName(GlobalStrings["PLAYER"]);
local _, realmName											= UnitFullName(GlobalStrings["PLAYER"]);
tbl.currentMap 												= currentMap;
tbl.mailSubject												= mailSubject;
tbl.playerName												= playerName;
tbl.realmName												= realmName;