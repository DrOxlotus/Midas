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
		
		-- GENERAL
		L["ADDON_NAME"] 							= "|cffCCA6F0" .. addon .. "|r: ";
		L["ADDON_NAME_SETTINGS"] 					= "|cffCCA6F0" .. addon .. "|r";
		L["RELEASE"] 								= "[" .. GetAddOnMetadata(addon, "Version") .. "] ";
		L["DATE"]									= date("%m/%d/%Y");
		
		-- GLOBAL STRINGS
		L["KEYBIND_SETTING_OPEN_MENU"]				= "Open Menu";
		L["BUTTON_OPTIONS"]							= "Options";
		L["BUTTON_RELOAD_LAST_SESSION"]				= "|cffffffffLoad Previous Session|r: Pick up where you left off.";
		L["BUTTON_RESET"]							= "|cffffffffNew Session|r: Start a new session. It's like logging off without logging off.";
		L["BUTTON_START_AND_STOP"]					= "|cffffffffRecorder|r: Enables and disables the recorder.";
		
		-- INFORMATIONAL MESSAGES
		L["INFO_MSG_ADDON_LOAD_SUCCESSFUL"]			= "Loaded successfully!";
		L["INFO_MSG_DISABLED"]						= "|cffffffffCurrent State|r: Disabled";
		L["INFO_MSG_ENABLED"]						= "|cffffffffCurrent State|r: Enabled";
		
		-- MODE NAMES
		
		-- DESCRIPTIONS
		
		-- OBJECT TYPES
		L["PLAYER"]									= "Player";
		
		-- OTHER
	end
end

addonTbl.SetLocale("enUS");