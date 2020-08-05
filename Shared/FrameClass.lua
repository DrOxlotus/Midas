-- Variables
local addon, tbl = ...;
local frame;
local isFrameVisible;
local GlobalStrings = tbl.GlobalStrings;

tbl.CreateFrame = function(name, height, width)
	if not frame then -- A frame needs to be created.
		frame = CreateFrame("Frame", name, UIParent, "BasicFrameTemplateWithInset"); tbl.frame = frame;
		frame:SetSize(height, width);
		tbl.MidasMainFrameUI_OnLoad(frame);
	end
end
-- Synopsis: Responsible for building a frame.
--[[
	name:			Name of the frame
	height:			The height, in pixels, of the frame
	width:			The width or length, in pixels, of the frame
]]
