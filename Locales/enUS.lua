local addon, addonTbl = ...;

local L = setmetatable({}, { __index = function(t, k)
	local text = tostring(k);
	rawset(t, k, text);
	return text;
end });

local LOCALE = GetLocale();

if LOCALE == "enUS" then
	addonTbl.L = L;
	
	-- Keybindings
	L["MIDAS_OPEN_CLOSE_OPTIONS"] = "Open/Close Options";
end