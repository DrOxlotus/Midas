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
		
		-- BUTTON / FIELD DESCRIPTIONS
		L["MAIL_CHARACTER_EDITBOX"]					= "The character you want Midas to send your excess gold to. Use ! to reset the character for this realm.";
		L["NEW_SESSION_BUTTON"]						= "Starts a new session.\n|cffffffffWARNING|r: This is the equivalent of a fresh start! (Instance data remains intact.)";
		L["RELOAD_LAST_SESSION_BUTTON"]				= "Pick up where you left off.";
		L["SEND_MAIL_BUTTON"]						= "Send mail to your designated mail character.";
		L["STOP_AND_START_BUTTON"]					= "Enables and disables the recorder.";
	
		-- COMMANDS
		L["SLASH_CMD_1"]							= "/midas";
		
		-- ERROR MESSAGES
		L["ERR_MSG_MAIL_CHARACTER_NOT_SET"]			= "No mail character set for this realm!";
		L["ERR_MSG_MAP_NOT_SUPPORTED"]				= "Map not found. The map was temporarily added to the instances table so data can log. Please report the following map ID: ";
		L["ERR_MSG_NO_MONEY_TO_SEND"]				= "You must record your gold acquisition to use this feature!";
		
		-- GENERAL
		L["ADDON_NAME"] 							= "|cffCCA6F0" .. addon .. "|r: ";
		L["ADDON_NAME_SETTINGS"] 					= "|cffCCA6F0" .. addon .. "|r";
		L["RELEASE"] 								= "[" .. GetAddOnMetadata(addon, "Version") .. "] ";
		L["DATE"]									= date("%m/%d/%Y");
		
		-- GLOBAL STRINGS
		L["KEYBIND_SETTING_OPEN_MENU"]				= "Open Menu";
		L["NO"]										= "No";
		L["YES"]									= "Yes";
		
		-- INFORMATIONAL MESSAGES
		L["INFO_MSG_ADDON_LOAD_SUCCESSFUL"]			= "Loaded successfully!";
		L["INFO_MSG_DISABLED"]						= "|cffffffffCurrent State|r: Disabled";
		L["INFO_MSG_ENABLED"]						= "|cffffffffCurrent State|r: Enabled";
		L["INFO_MSG_CURRENT_MAIL_CHARACTER"]		= "|cffffffffCurrent|r: %s";
		L["INFO_MSG_NEW_SESSION"]					= "Are you sure you want to start a new session?";
		L["INFO_MSG_MAIL_CHARACTER_SET"]			= "Successfully set your mail character to %s!";
		L["INFO_MSG_MAIL_CHARACTER_RESET"]			= "Successfully reset your mail character to factory default.";
		L["INFO_MSG_MAIL_CHARACTER_NOT_SET"]		= "|cffffffffNo mail character set for this realm|r.";
		
		-- MODE NAMES
		
		-- DESCRIPTIONS
		
		-- OBJECT TYPES
		L["PLAYER"]									= "Player";
		
		-- OTHER
	end
end

addonTbl.SetLocale("enUS");