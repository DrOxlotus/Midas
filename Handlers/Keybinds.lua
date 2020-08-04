-- Namespace Variables
local addon, addonTbl = ...;

-- Module-Local Variables
local L = addonTbl.L;

-- Keybindings
BINDING_HEADER_MIDAS = addon;
BINDING_NAME_MIDAS_OPEN_MENU = L["OPEN_MENU"];

function MidasKeyPressHandler(key)
	if key == GetBindingKey("MIDAS_OPEN_MENU") then
		addonTbl.LoadSettings(false);
	end
end