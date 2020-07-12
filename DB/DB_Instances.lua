-- Namespace Variables
local addon, addonTbl = ...;

-- Module-Local Variables
local L = addonTbl.L;

local instances = {
	[67]	= "Maraudon",
	[68]	= "Maraudon",
	[129]	= "The Nexus",
	[130]	= "The Culling of Stratholme",
	[131]	= "The Culling of Stratholme",
	[132]	= "Ahn'kahet, The Old Kingdom",
	[133]	= "Utgarde Keep",
	[134]	= "Utgarde Keep",
	[135]	= "Utgarde Keep",
	[136]	= "Utgarde Pinnacle",
	[137]	= "Utgarde Pinnacle",
	[138]	= "Halls of Lightning",
	[139]	= "Halls of Lightning",
	[140]	= "Halls of Stone",
	[141]	= "The Eye of Eternity",
	[142]	= "The Oculus",
	[143]	= "The Oculus",
	[144]	= "The Oculus",
	[145]	= "The Oculus",
	[146]	= "The Oculus",
	[148]	= "Ulduar",
	[149]	= "Ulduar",
	[150]	= "Ulduar",
	[151]	= "Ulduar",
	[152]	= "Ulduar",
	[153]	= "Gundrak",
	[154]	= "Gundrak",
	[155]	= "The Obsidian Sanctum",
	[156]	= "Vault of Archavon",
	[157]	= "Azjol-Nerub",
	[160]	= "Drak'Tharon Keep",
	[161]	= "Drak'Tharon Keep",
	[162]	= "Naxxramas",
	[163]	= "Naxxramas",
	[164]	= "Naxxramas",
	[165]	= "Naxxramas",
	[166]	= "Naxxramas",
	[167]	= "Naxxramas",
	[168]	= "The Violet Hold (WotLK)",
	[171]	= "Trial of the Champion",
	[172]	= "Trial of the Crusader",
	[173]	= "Trial of the Crusader",
	[183]	= "The Forge of Souls",
	[184]	= "Pit of Saron",
	[185]	= "Halls of Reflection",
	[186]	= "Icecrown Citadel",
	[187]	= "Icecrown Citadel",
	[188]	= "Icecrown Citadel",
	[189]	= "Icecrown Citadel",
	[190]	= "Icecrown Citadel",
	[191]	= "Icecrown Citadel",
	[192]	= "Icecrown Citadel",
	[193]	= "Icecrown Citadel",
	[200]	= "The Ruby Sanctum",
	[213]	= "Ragefire Chasm",
	[219]	= "Zul'Farrak",
	[220] 	= "The Temple of Atal'hakkar",
	[221] 	= "Blackfathom Deeps",
	[222] 	= "Blackfathom Deeps",
	[223] 	= "Blackfathom Deeps",
	[225] 	= "The Stockade",
	[226] 	= "Gnomeregan",
	[227] 	= "Gnomeregan",
	[228] 	= "Gnomeregan",
	[229] 	= "Gnomeregan",
	[230] 	= "Uldaman",
	[231] 	= "Uldaman",
	[232] 	= "Molten Core",
	[234] 	= "Dire Maul",
	[242] 	= "Blackrock Depths",
	[243] 	= "Blackrock Depths",
	[246]	= "The Shattered Halls",
	[247]	= "Ruins of Ahn'Qiraj",
	[248] 	= "Onyxia's Lair",
	[250] 	= "Lower Blackrock Spire",
	[251] 	= "Lower Blackrock Spire",
	[252] 	= "Lower Blackrock Spire",
	[253] 	= "Lower Blackrock Spire",
	[254] 	= "Lower Blackrock Spire",
	[255] 	= "Lower Blackrock Spire",
	[256]	= "Auchenai Crypts",
	[257]	= "Auchenai Crypts",
	[258]	= "Sethekk Halls",
	[259]	= "Sethekk Halls",
	[260]	= "Shadow Labyrinth",
	[261]	= "The Blood Furnace",
	[262]	= "The Underbog",
	[263]	= "The Steamvault",
	[264]	= "The Steamvault",
	[265]	= "The Slave Pens",
	[266]	= "The Botanica",
	[267]	= "The Mechanar",
	[268]	= "The Mechanar",
	[269]	= "The Arcatraz",
	[270]	= "The Arcatraz",
	[271]	= "The Arcatraz",
	[272]	= "Mana Tombs",
	[273]	= "The Black Morass",
	[274]	= "Old Hillsbrad Foothills",
	[277]	= "Lost City of the Tol'vir",
	[279] 	= "Wailing Caverns",
	[281]	= "Maraudon",
	[282]	= "Baradin Hold",
	[283]	= "Blackrock Caverns",
	[284]	= "Blackrock Caverns",
	[285]	= "Blackwing Descent",
	[286]	= "Blackwing Descent",
	[287]	= "Blackwing Lair",
	[288]	= "Blackwing Lair",
	[289]	= "Blackwing Lair",
	[290]	= "Blackwing Lair",
	[291] 	= "The Deadmines",
	[292] 	= "The Deadmines",
	[293]	= "Grim Batol",
	[294]	= "The Bastion of Twilight",
	[295]	= "The Bastion of Twilight",
	[296]	= "The Bastion of Twilight",
	[297]	= "Halls of Origination",
	[298]	= "Halls of Origination",
	[299]	= "Halls of Origination",
	[300]	= "Razorfen Downs",
	[301]	= "Razorfen Kraul",
	[310]	= "Shadowfang Keep",
	[311]	= "Shadowfang Keep",
	[312]	= "Shadowfang Keep",
	[313]	= "Shadowfang Keep",
	[314]	= "Shadowfang Keep",
	[315]	= "Shadowfang Keep",
	[316]	= "Shadowfang Keep",
	[317]	= "Stratholme",
	[318]	= "Stratholme",
	[319]	= "Temple of Ahn'Qiraj",
	[320]	= "Temple of Ahn'Qiraj",
	[321]	= "Temple of Ahn'Qiraj",
	[322]	= "Throne of the Tides",
	[323]	= "Throne of the Tides",
	[324]	= "The Stonecore",
	[325]	= "The Vortex Pinnacle",
	[328]	= "Throne of the Four Winds",
	[329]	= "The Battle for Mount Hyjal",
	[330]	= "Gruul's Lair",
	[331]	= "Magtheridon's Lair",
	[332]	= "Serpentshrine Cavern",
	[333]	= "Zul'Aman",
	[334]	= "The Eye",
	[335]	= "Sunwell Plateau",
	[336]	= "Sunwell Plateau",
	[337]	= "Zul'Gurub",
	[339]	= "Black Temple",
	[340]	= "Black Temple",
	[341]	= "Black Temple",
	[342]	= "Black Temple",
	[343]	= "Black Temple",
	[344]	= "Black Temple",
	[345]	= "Black Temple",
	[346]	= "Black Temple",
	[347]	= "Hellfire Ramparts",
	[348]	= "Magisters' Terrace",
	[349]	= "Magisters' Terrace",
	[350]	= "Karazhan (Raid)",
	[351]	= "Karazhan (Raid)",
	[352]	= "Karazhan (Raid)",
	[353]	= "Karazhan (Raid)",
	[354]	= "Karazhan (Raid)",
	[355]	= "Karazhan (Raid)",
	[356]	= "Karazhan (Raid)",
	[357]	= "Karazhan (Raid)",
	[358]	= "Karazhan (Raid)",
	[359]	= "Karazhan (Raid)",
	[360]	= "Karazhan (Raid)",
	[361]	= "Karazhan (Raid)",
	[362]	= "Karazhan (Raid)",
	[363]	= "Karazhan (Raid)",
	[364]	= "Karazhan (Raid)",
	[365]	= "Karazhan (Raid)",
	[366]	= "Karazhan (Raid)",
	[367]	= "Firelands",
	[368]	= "Firelands",
	[369]	= "Firelands",
	[398]	= "Well of Eternity",
	[399]	= "Hour of Twilight",
	[400]	= "Hour of Twilight",
	[401]	= "End Time",
	[402]	= "End Time",
	[403]	= "End Time",
	[404]	= "End Time",
	[405]	= "End Time",
	[406]	= "End Time",
	[409]	= "Dragon Soul",
	[410]	= "Dragon Soul",
	[411]	= "Dragon Soul",
	[412]	= "Dragon Soul",
	[413]	= "Dragon Soul",
	[414]	= "Dragon Soul",
	[415]	= "Dragon Soul",
	[429]	= "Temple of the Jade Serpent",
	[430]	= "Temple of the Jade Serpent",
	[431]	= "Scarlet Halls",
	[432]	= "Scarlet Halls",
	[435]	= "Scarlet Monastery",
	[436]	= "Scarlet Monastery",
	[437]	= "Gate of the Setting Sun",
	[438]	= "Gate of the Setting Sun",
	[439]	= "Stormstout Brewery",
	[440]	= "Stormstout Brewery",
	[441]	= "Stormstout Brewery",
	[442]	= "Stormstout Brewery",
	[443]	= "Shado-Pan Monastery",
	[444]	= "Shado-Pan Monastery",
	[445]	= "Shado-Pan Monastery",
	[446]	= "Shado-Pan Monastery",
	[453]	= "Mogu'shan Palace",
	[454]	= "Mogu'shan Palace",
	[455]	= "Mogu'shan Palace",
	[456]	= "Terrace of Endless Spring",
	[457]	= "Siege of Niuzao Temple",
	[458]	= "Siege of Niuzao Temple",
	[459]	= "Siege of Niuzao Temple",
	[471]	= "Mogu'shan Vaults",
	[472]	= "Mogu'shan Vaults",
	[473]	= "Mogu'shan Vaults",
	[474]	= "Heart of Fear",
	[475]	= "Heart of Fear",
	[476]	= "Scholomance",
	[477]	= "Scholomance",
	[478]	= "Scholomance",
	[479]	= "Scholomance",
	[508]	= "Throne of Thunder",
	[509]   = "Throne of Thunder",
	[510]   = "Throne of Thunder",
	[511]   = "Throne of Thunder",
	[512]   = "Throne of Thunder",
	[513]   = "Throne of Thunder",
	[514]   = "Throne of Thunder",
	[515]   = "Throne of Thunder",
	[557]	= "Siege of Orgrimmar",
	[558]   = "Siege of Orgrimmar",
	[559]   = "Siege of Orgrimmar",
	[560]   = "Siege of Orgrimmar",
	[561]   = "Siege of Orgrimmar",
	[562]   = "Siege of Orgrimmar",
	[563]   = "Siege of Orgrimmar",
	[564]   = "Siege of Orgrimmar",
	[565]   = "Siege of Orgrimmar",
	[566]   = "Siege of Orgrimmar",
	[567]   = "Siege of Orgrimmar",
	[568]   = "Siege of Orgrimmar",
	[569]   = "Siege of Orgrimmar",
	[570]   = "Siege of Orgrimmar",
	[616]	= "Upper Blackrock Spire",
	[617]	= "Upper Blackrock Spire",
	[618]	= "Upper Blackrock Spire",
};

addonTbl.instances = instances;