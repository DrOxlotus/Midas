-- Namespace Variables
local addon, addonTbl = ...;

addonTbl.InitializeSavedVars = function()
	-- SavedVars
	if MidasMaps == nil then MidasMaps = {} end;
	if MidasSettings == nil then MidasSettings = {} end;
	-- Character SavedVars
	if MidasCharacterHistory == nil then MidasCharacterHistory = {} end;
end