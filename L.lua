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
		L["BUTTON_RELOAD_LAST_SESSION"]				= "Pick up from where you left off before you logged or reloaded.";
		L["BUTTON_RESET"]							= "Resets the current session. It's almost like a session was never started.";
		L["BUTTON_START_AND_STOP"]					= "Tells Midas to start and stop recording.";
		
		-- INFORMATIONAL MESSAGES
		L["INFO_MSG_ADDON_LOAD_SUCCESSFUL"]			= "Loaded successfully!";
		
		-- MODE NAMES
		
		-- DESCRIPTIONS
		
		-- OBJECT TYPES
		L["PLAYER"]									= "Player";
		
		-- OTHER
	end
end

addonTbl.SetLocale("enUS");