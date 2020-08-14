-- Namespace Variables
local addon, tbl = ...;

-- Module-Local Variables
local GlobalStrings = setmetatable({}, { __index = function(t, k)
	local text = tostring(k);
	rawset(t, k, text);
	return text;
end });

tbl.SetLocale = function(locale)
	tbl["locale"] = locale;
	if locale == "enUS" then -- English (US)
		tbl.GlobalStrings = GlobalStrings;
		
		GlobalStrings["ACTIVE_RECORDER"]						= "Your recorder is active. Would you like to disable it?";
		GlobalStrings["ACTIVE_RECORDER_REMINDER"]				= "When entering instances, tell me if my recorder is active.";
		GlobalStrings["ADDON_LOAD_SUCCESSFUL"]					= "Loaded successfully!";
		GlobalStrings["ADDON_NAME"] 							= "|cff00ccff" .. addon .. "|r: ";
		GlobalStrings["ADDON_NAME_SETTINGS"] 					= "|cff00ccff" .. addon .. "|r";
		GlobalStrings["COMMAND_DISCORD"]						= "discord";
		GlobalStrings["COMMAND_SEARCH"]							= "search";
		GlobalStrings["CURRENT"]								= "|cffffffffCurrent|r: ";
		GlobalStrings["DATE"]									= date("%m/%d/%Y");
		GlobalStrings["MAIL_CHARACTER_EDITBOX"]					= "The character you want Midas to send your excess gold to. Use ! to reset the character for this realm.";
		GlobalStrings["MAIL_CHARACTER_NOT_FOUND"]				= "|cffffffffNo mail character found for this realm|r.";
		GlobalStrings["MAIL_CHARACTER_RESET"]					= "Successfully reset your mail character to factory default.";
		GlobalStrings["MAIL_CHARACTER_SET"]						= "Successfully set your mail character to ";
		GlobalStrings["MAP_NOT_SUPPORTED"]						= "Map not found. The map was temporarily added to the instances table so data can log. Please report the following map ID: ";
		GlobalStrings["NEW_SESSION"]							= "Starts a new session.\n|cffffffffWARNING|r: This is the equivalent of a fresh start! (Instance data remains intact.)";
		GlobalStrings["NEW_SESSION_CONFIRM"]					= "Are you sure you want to start a new session?";
		GlobalStrings["NO"]										= "No";
		GlobalStrings["NO_LAST_SESSION"]						= "No last session found.";
		GlobalStrings["NO_MONEY_TO_SEND"]						= "You must loot money while the recorder is active to use this feature!";
		GlobalStrings["OPEN_MENU"]								= "Open Menu";
		GlobalStrings["PLAYER"]									= "Player";
		GlobalStrings["PREVIOUS_SESSION_DETECTED"]				= "You have a previous session. Would you like to load that instead?";
		GlobalStrings["RELEASE"] 								= "[" .. GetAddOnMetadata(addon, "Version") .. "] ";
		GlobalStrings["RELOAD_LAST_SESSION"]					= "Pick up where you left off.";
		GlobalStrings["SEND_MAIL"]								= "Send mail to your designated mail character.";
		GlobalStrings["SLASH_COMMAND_MIDAS1"]					= "/midas";
		GlobalStrings["STOP_AND_START"]							= "Enables and disables the recorder.";
		GlobalStrings["YES"]									= "Yes";
	end
end

tbl.SetLocale("enUS");