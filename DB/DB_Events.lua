-- Namespace Variables
local addon, addonTbl = ...;

-- Module-Local Variables
local L = addonTbl.L;

local events = {
	"INSTANCE_GROUP_SIZE_CHANGED",
	"MAIL_CLOSED",
	"MAIL_INBOX_UPDATE",
	"MAIL_SEND_SUCCESS",
	"MERCHANT_CLOSED",
	"MERCHANT_SHOW",
	"MODIFIER_STATE_CHANGED",
	"PLAYER_LOGIN",
	"PLAYER_LOGOUT",
	"PLAYER_MONEY",
	"ZONE_CHANGED_NEW_AREA"
};
-- Synopsis: These are events that must occur before the addon will take action. Each event is documented in main.lua.

addonTbl.events = events;