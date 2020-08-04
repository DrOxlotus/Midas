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
		
		L["ACTIVE_RECORDER"]						= "Your recorder is active. Would you like to disable it?";
		L["ACTIVE_RECORDER_REMINDER"]				= "When entering instances, tell me if my recorder is active.";
		L["ADDON_LOAD_SUCCESSFUL"]					= "Loaded successfully!";
		L["ADDON_NAME"] 							= "|cffCCA6F0" .. addon .. "|r: ";
		L["ADDON_NAME_SETTINGS"] 					= "|cffCCA6F0" .. addon .. "|r";
		L["COMMAND_DISCORD"]						= "discord";
		L["COMMAND_HISTORY"]						= "history";
		L["CURRENT"]								= "|cffffffffCurrent|r: ";
		L["DATE"]									= date("%m/%d/%Y");
		L["DISABLED"]								= "|cffffffffCurrent State|r: Disabled";
		L["ENABLED"]								= "|cffffffffCurrent State|r: Enabled";
		L["MAIL_CHARACTER_EDITBOX"]					= "The character you want Midas to send your excess gold to. Use ! to reset the character for this realm.";
		L["MAIL_CHARACTER_NOT_FOUND"]				= "|cffffffffNo mail character found for this realm|r.";
		L["MAIL_CHARACTER_RESET"]					= "Successfully reset your mail character to factory default.";
		L["MAIL_CHARACTER_SET"]						= "Successfully set your mail character to ";
		L["MAP_NOT_SUPPORTED"]						= "Map not found. The map was temporarily added to the instances table so data can log. Please report the following map ID: ";
		L["NEW_SESSION"]							= "Starts a new session.\n|cffffffffWARNING|r: This is the equivalent of a fresh start! (Instance data remains intact.)";
		L["NEW_SESSION_CONFIRM"]					= "Are you sure you want to start a new session?";
		L["NO"]										= "No";
		L["NO_LAST_SESSION"]						= "No last session found.";
		L["NO_MONEY_TO_SEND"]						= "You must loot money while the recorder is active to use this feature!";
		L["OPEN_MENU"]								= "Open Menu";
		L["PLAYER"]									= "Player";
		L["PREVIOUS_SESSION_DETECTED"]				= "You have a previous session. Would you like to load that instead?";
		L["RELEASE"] 								= "[" .. GetAddOnMetadata(addon, "Version") .. "] ";
		L["RELOAD_LAST_SESSION"]					= "Pick up where you left off.";
		L["SEND_MAIL"]								= "Send mail to your designated mail character.";
		L["SLASH_COMMAND_MIDAS1"]					= "/midas";
		L["STOP_AND_START"]							= "Enables and disables the recorder.";
		L["YES"]									= "Yes";
	end
end

addonTbl.SetLocale("enUS");