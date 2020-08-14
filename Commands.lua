-- Namespace Variables
local addon, tbl = ...;

-- Module-Local Variables
local GlobalStrings = tbl.GlobalStrings;

SLASH_Midas1 = GlobalStrings["SLASH_COMMAND_MIDAS1"];
SlashCmdList["Midas"] = function(cmd, editbox)
	local _, _, cmd, args = string.find(cmd, "%s?(%w+)%s?(.*)");

	if not cmd or cmd == "" then
		tbl.LoadSettings(false);
	elseif cmd == GlobalStrings["COMMAND_DISCORD"] then
		print(GlobalStrings["ADDON_NAME"] .. "https://discord.gg/7Ve8JQv");
	elseif (cmd == GlobalStrings["COMMAND_SEARCH"] or cmd == "s") and args ~= "" and tonumber(args) ~= true then
		tbl.Search(args);
	end
end