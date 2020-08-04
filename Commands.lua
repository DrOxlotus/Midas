-- Namespace Variables
local addon, addonTbl = ...;

-- Module-Local Variables
local L = addonTbl.L;

SLASH_Midas1 = L["SLASH_CMD_1"];
SlashCmdList["Midas"] = function(cmd, editbox)
	local _, _, cmd, args = string.find(cmd, "%s?(%w+)%s?(.*)");

	if not cmd or cmd == "" then
		addonTbl.LoadSettings(false);
	elseif cmd == L["CMD_DISCORD"] then
		print(L["ADDON_NAME"] .. "https://discord.gg/7Ve8JQv");
	end
end