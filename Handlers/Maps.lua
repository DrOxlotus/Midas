-- Namespace Variables
local addon, addonTbl = ...;

-- Module-Local Variables
local isRecorderActiveStateOK;
local L = addonTbl.L;

addonTbl.GetCurrentMap = function()
	local uiMapID = C_Map.GetBestMapForUnit("player");
	addonTbl.isInInstance = IsInInstance();
	
	if uiMapID then -- A map ID was found and is usable.
		addonTbl.uiMapID = uiMapID;
		local uiMap = C_Map.GetMapInfo(uiMapID);
		if not uiMap.mapID then return end;
		if not MidasMaps[uiMap.mapID] then
			MidasMaps[uiMap.mapID] = uiMap.name;
		end
		
		if addonTbl.isInInstance then
			if addonTbl.activeRecorderReminder and addonTbl.recorderState == 1 and isRecorderActiveStateOK == false then
				StaticPopupDialogs["Midas_ActiveRecorderReminder"] = {
					text = L["INFO_MSG_ACTIVE_RECORDER"],
					button1 = L["YES"],
					button2 = L["NO"],
					OnAccept = function()
						addonTbl.StartAndPause();
					end,
					OnDecline = function()
						isRecorderActiveStateOK = true;
					end,
					timeout = 0,
					whileDead = true,
					hideOnEscape = true,
					preferredIndex = 3,
				};
				
				StaticPopup_Show("Midas_ActiveRecorderReminder");
			end
			if not addonTbl.maps[addonTbl.uiMapID] and not addonTbl.ignoredMaps[addonTbl.uiMapID] then -- The map isn't in either maps table
				addonTbl.maps[uiMapID] = uiMap.name;
				print(L["ADDON_NAME"] .. L["ERR_MSG_MAP_NOT_SUPPORTED"] .. addonTbl.uiMapID .. " (" .. uiMap.name .. ", " .. UnitClass("player") .. ", " .. UnitLevel("player") .. ")");
			end
		end

		addonTbl.currentMap = uiMap.name;
	else
		C_Timer.After(3, addonTbl.GetCurrentMap); -- Recursively call the function every 3 seconds until a map ID is found.
	end
	
	return addonTbl.currentMap;
end
-- Synopsis: Gets the player's current map so an item can be accurately recorded.