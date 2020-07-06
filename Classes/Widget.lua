-- Namespace Variables
local addon, addonTbl = ...;

-- Module-Local Variables
local L = addonTbl.L;

addonTbl.CreateWidget = function(type, name, text, frameName, point, parent, relativePos, xOffset, yOffset)
	if type == "CheckButton" then
		frameName[name] = CreateFrame("CheckButton", name, parent, "UICheckButtonTemplate");
		frameName[name]:SetPoint(point, parent, relativePos, xOffset, yOffset);
		frameName[name].text:SetText(text);
	elseif type == "FontString" then
		frameName[name] = frameName:CreateFontString(nil, "OVERLAY");
		frameName[name]:SetFontObject("GameFontHighlight");
		frameName[name]:SetPoint(point, parent, relativePos, xOffset, yOffset);
		frameName[name]:SetText(text);
	end
end
-- Synopsis: Creates a widget.
--[[
	name: 			Widget's name
	type: 			Widget's type (see below for supported widget types)
	text:			The text, if necessary, to use
	frameName: 		Name of the frame the widget will be added to after its creation
	point:			The position on the screen the frame should be placed. Left, Center, etc.
	parent:			The parent frame's name
	relativePos:	The position, relative to the parent, that the frame should be placed
	xOffset:		From the final position, how many pixels left or right to offset the frame
	yOffset:		From the final position, how many pixels up or down to offset the frame
	height:			The height of the widget (optional arg)
	width:			The height of the widget (optional arg)
	
	Supported Widgets:
	- CheckButton
	- FontString
]]

addonTbl.UpdateWidget = function(name, frameName, text)
	frameName[name]:SetText(text);
end
-- Synopsis: Updates a widget's text.
--[[
	name: 			Widget's name
	frameName		Name of the frame that the widget sits on
	text:			The text, if necessary, to use
]]