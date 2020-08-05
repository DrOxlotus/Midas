-- Namespace Variables
local addon, tbl = ...;

-- Module-Local Variables
local GlobalStrings = tbl.GlobalStrings;

tbl.GetCurrentMap = function()
	local uiMapID = C_Map.GetBestMapForUnit("player");
	tbl.isInInstance = IsInInstance();
	
	if uiMapID then -- A map ID was found and is usable.
		tbl.uiMapID = uiMapID;
		local uiMap = C_Map.GetMapInfo(uiMapID);
		if not uiMap.mapID then return end;
		if not MidasMaps[uiMap.mapID] then
			MidasMaps[uiMap.mapID] = uiMap.name;
		end
		
		if tbl.isInInstance then
			if tbl.isRecorderActiveStateOK ~= true then
				if tbl.activeRecorderReminder and tbl.recorderState == 1 then
					StaticPopupDialogs["Midas_ActiveRecorderReminder"] = {
						text = GlobalStrings["ACTIVE_RECORDER"],
						button1 = GlobalStrings["YES"],
						button2 = GlobalStrings["NO"],
						OnAccept = function()
							tbl.StartAndPause();
						end,
						OnCancel = function()
							tbl.isRecorderActiveStateOK = true;
						end,
						timeout = 0,
						whileDead = true,
						hideOnEscape = true,
						preferredIndex = 3,
					};
					
					StaticPopup_Show("Midas_ActiveRecorderReminder");
				end
			end
			if not tbl.maps[tbl.uiMapID] and not tbl.ignoredMaps[tbl.uiMapID] then -- The map isn't in either maps table
				tbl.maps[uiMapID] = uiMap.name;
				print(GlobalStrings["ADDON_NAME"] .. GlobalStrings["MAP_NOT_SUPPORTED"] .. tbl.uiMapID .. " (" .. uiMap.name .. ", " .. UnitClass("player") .. ", " .. UnitLevel("player") .. ") - Please report in the Midas section here: https://discord.gg/7Ve8JQv");
			end
		else
			tbl.isRecorderActiveStateOK = false;
		end

		tbl.currentMap = uiMap.name;
	else
		C_Timer.After(3, tbl.GetCurrentMap); -- Recursively call the function every 3 seconds until a map ID is found.
	end
	
	return tbl.currentMap;
end
-- Synopsis: Gets the player's current map so an item can be accurately recorded.