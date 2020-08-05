local addon, tbl = ...;

tbl.frameTabs = {
	{
		["tab"]			= "Tab1",
		["text"]		= "Main",
		["height"]		= 308,
		["width"]		= 500,
		["point"]		= "TOPLEFT",
		["parent"]		= tbl.frame,
		["relativeTo"]	= "BOTTOMLEFT",
		["x"]			= 5,
		["y"]			= 1,
	},
	{
		["tab"]			= "Tab2",
		["text"]		= "History",
		["height"]		= 308,
		["width"]		= 500,
		["point"]		= "TOPLEFT",
		["parent"]		= "MidasMainFrameTab1",
		["relativeTo"]	= "RIGHT",
		["x"]			= 0,
		["y"]			= 0,
	},
};