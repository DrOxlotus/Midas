-- Namespace Variables
local addon, addonTbl = ...;

-- Module-Local Variables
local L = setmetatable({}, { __index = function(t, k)
	local text = tostring(k);
	rawset(t, k, text);
	return text;
end });

addonTbl.SetLocale = function(locale)
	addonTbl["locale"] = locale;
	if locale == "enUS" then -- English (US)
		addonTbl.L = L;
	
		-- COMMANDS
		L["SLASH_CMD_1"]							= "/midas";
		
		-- ERROR MESSAGES
		L["ERR_MSG_MAP_NOT_SUPPORTED"]				= "Map not found. The map was temporarily added to the instances table so data can log. Please report the following map ID: ";
		
		-- GENERAL
		L["ADDON_NAME"] 							= "|cffCCA6F0" .. addon .. "|r: ";
		L["ADDON_NAME_SETTINGS"] 					= "|cffCCA6F0" .. addon .. "|r";
		L["RELEASE"] 								= "[" .. GetAddOnMetadata(addon, "Version") .. "] ";
		L["DATE"]									= date("%m/%d/%Y");
		
		-- GLOBAL STRINGS
		L["KEYBIND_SETTING_OPEN_MENU"]				= "Open Menu";
		L["BUTTON_OPTIONS"]							= "Options";
		L["BUTTON_RELOAD_LAST_SESSION"]				= "|cffffffffLoad Previous Session|r: Pick up where you left off.";
		L["BUTTON_NEW_SESSION"]						= "|cffffffffNew Session|r: Start a new session. This WILL wipe your last session's data!";
		L["BUTTON_START_AND_STOP"]					= "|cffffffffRecorder|r: Enables and disables the recorder.";
		L["NO"]										= "No";
		L["YES"]									= "Yes";
		
		-- INFORMATIONAL MESSAGES
		L["INFO_MSG_ADDON_LOAD_SUCCESSFUL"]			= "Loaded successfully!";
		L["INFO_MSG_DISABLED"]						= "|cffffffffCurrent State|r: Disabled";
		L["INFO_MSG_ENABLED"]						= "|cffffffffCurrent State|r: Enabled";
		L["INFO_MSG_NEW_SESSION"]					= "Are you sure you want to start a new session?";
		
		-- MODE NAMES
		
		-- DESCRIPTIONS
		
		-- OBJECT TYPES
		L["PLAYER"]									= "Player";
		
		-- OTHER
	end
end

addonTbl.SetLocale("enUS");