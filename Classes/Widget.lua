-- Namespace Variables
local addon, addonTbl = ...;

-- Module-Local Variables
local L = addonTbl.L;

addonTbl.CreateWidget = function(type, name, text, frameName, point, parent, relativePos, xOffset, yOffset, length, width)
	if type == "Button" then
		frameName[name] = CreateFrame("Button", name, parent, "SecureHandlerClickTemplate");
		frameName[name]:RegisterForClicks("AnyUp");
		frameName[name]:SetPoint(point, parent, relativePos, xOffset, yOffset);
		frameName[name]:SetSize(length, width);
		frameName[name]:SetNormalTexture(text);
	elseif type == "CheckButton" then
		frameName[name] = CreateFrame("CheckButton", name, parent, "UICheckButtonTemplate");
		frameName[name]:SetPoint(point, parent, relativePos, xOffset, yOffset);
		frameName[name].text:SetText(text);
	elseif type == "EditBox" then
		frameName[name] = CreateFrame("EditBox", name, parent, "InputBoxTemplate");
		frameName[name]:SetPoint(point, parent, relativePos, xOffset, yOffset);
		frameName[name]:SetMaxLetters(12);
		frameName[name]:SetAutoFocus(false);
		frameName[name]:SetFontObject("GameFontNormal");
		frameName[name]:SetCursorPosition(3);
		frameName[name]:SetSize(100, 35);
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
	length:			From the final position, how many pixels up or down to offset the frame
	width:			From the final position, how many pixels up or down to offset the frame
	
	Supported Widgets:
	- Button
	- CheckButton
	- EditBox
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