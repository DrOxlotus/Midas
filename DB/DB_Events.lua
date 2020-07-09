-- Namespace Variables
local addon, addonTbl = ...;

-- Module-Local Variables
local L = addonTbl.L;

local events = {
	"INSTANCE_GROUP_SIZE_CHANGED",
	"MAIL_INBOX_UPDATE",
	"MERCHANT_CLOSED",
	"MERCHANT_SHOW",
	"MODIFIER_STATE_CHANGED",
	"PLAYER_LOGIN",
	"PLAYER_MONEY",
	"ZONE_CHANGED_NEW_AREA"
};
-- Synopsis: These are events that must occur before the addon will take action. Each event is documented in main.lua.

addonTbl.events = events;