-- Namespace Variables
local addon, tbl = ...;

-- Module-Local Variables
local GlobalStrings = tbl.GlobalStrings;

-- Keybindings
BINDING_HEADER_MIDAS = addon;
BINDING_NAME_MIDAS_OPEN_MENU = GlobalStrings["OPEN_MENU"];

function MidasKeyPressHandler(key)
	if key == GetBindingKey("MIDAS_OPEN_MENU") then
		tbl.MidasMainFrameUI_OnShow(tbl.frame);
	end
end