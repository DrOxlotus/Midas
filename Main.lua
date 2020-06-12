-- Namespace Variables
local addonName, addonTbl = ...;

-- Keybindings
BINDING_HEADER_MIDAS = "MIDAS";
BINDING_NAME_MIDAS_OPEN_CLOSE_OPTIONS = L["MIDAS_OPEN_CLOSE_OPTIONS"];

-- Event Registrations
local eventFrame = CreateFrame("Frame");
local mouseFrame = CreateFrame("Frame", "MouseFrame", UIParent);

function MidasKeyPressHandler(key)
	if key == GetBindingKey("MIDAS_OPEN_CLOSE_OPTIONS") then
		-- do something, obviously
	end
end

eventFrame:SetScript("OnEvent", function(self, event, ...)
	-- events are captured, sir, now what??
end);

mouseFrame:SetScript("OnKeyDown", MidasKeyPressHandler);
mouseFrame:SetPropagateKeyboardInput(true);