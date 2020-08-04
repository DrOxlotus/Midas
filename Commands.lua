-- Namespace Variables
local addon, addonTbl = ...;

-- Module-Local Variables
local L = addonTbl.L;

SLASH_Midas1 = L["SLASH_COMMAND_MIDAS1"];
SlashCmdList["Midas"] = function(cmd, editbox)
	local _, _, cmd, args = string.find(cmd, "%s?(%w+)%s?(.*)");

	if not cmd or cmd == "" then
		addonTbl.LoadSettings(false);
	elseif cmd == L["COMMAND_DISCORD"] then
		print(L["ADDON_NAME"] .. "https://discord.gg/7Ve8JQv");
	elseif cmd == L["COMMAND_HISTORY"] then
		addonTbl.CreateFrame("MidasHistoryFrame", 300, 600);
	end
end