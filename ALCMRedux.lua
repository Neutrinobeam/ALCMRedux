local _G = getfenv(0)

local ALCDB = _G.AtlasLoot.ItemDB.Storage
local ALCLoader = _G.AtlasLoot.Loader
local ALCGUIFrame = _G["AtlasLoot_GUI-ItemFrame"]

local addonName = "ALCMRedux"
local chatName = "|cFFCC99EE" .. addonName .. "|r"
local defaultALCModules = {"AtlasLootClassic_DungeonsAndRaids", "AtlasLootClassic_Crafting", "AtlasLootClassic_Factions", "AtlasLootClassic_PvP", "AtlasLootClassic_Collections"}

local pvpMapNames = {"AlteracValley", "WarsongGulch", "ArathiBasin"}

local wowcImageSubfolder = "WoWC\\"
local tbccImageSubfolder = "TBCC\\"
local wowcPvEMapTable = {
	["Ragefire"] = "Ragefire",
	["WailingCaverns"] = "WailingCaverns",
	["TheDeadmines"] = "TheDeadmines",
	["ShadowfangKeep"] = "ShadowfangKeep",
	["BlackfathomDeeps"] = "BlackfathomDeeps",
	["TheStockade"] = "TheStockade",
	["Gnomeregan"] = "Gnomeregan",
	["RazorfenKraul"] = "RazorfenKraul",
	["ScarletMonasteryGraveyard"] = "ScarletMonasteryGraveyard",
	["ScarletMonasteryLibrary"] = "ScarletMonasteryLibrary",
	["ScarletMonasteryArmory"] = "ScarletMonasteryArmory",
	["ScarletMonasteryCathedral"] = "ScarletMonasteryCathedral",
	["RazorfenDowns"] = "RazorfenDowns",
	["Uldaman"] = "Uldaman",
	["Zul'Farrak"] = "ZulFarrak",
	["Maraudon"] = "Maraudon",
	["TheTempleOfAtal'Hakkar"] = "TheTempleOfAtalHakkar",
	["BlackrockDepths"] = "BlackrockDepths",
	["LowerBlackrockSpire"] = "LowerBlackrockSpire",

	["UpperBlackrockSpire"] = "UpperBlackrockSpire",
	["DireMaulEast"] = "DireMaulEast",
	["DireMaulWest"] = "DireMaulWest",
	["DireMaulNorth"] = "DireMaulNorth",
	["Scholomance"] = "Scholomance",
	["Stratholme"] = "Stratholme",
	["MoltenCore"] = "MoltenCore",
	["Onyxia"] = "OnyxiasLair",
	["Zul'Gurub"] = "ZulGurub",
	["BlackwingLair"] = "BlackwingLair",

	["TheRuinsofAhnQiraj"] = "RuinsofAhnQiraj",
	["TheTempleofAhnQiraj"] = "AhnQiraj",
	["Naxxramas"] = "Naxxramas"
}
local tbccPvEMapTable = {
	["HellfireRamparts"] = "HellfireRamparts",
	["TheBloodFurnace"] = "TheBloodFurnace",
	["TheShatteredHalls"] = "TheShatteredHalls",
	["Mana-Tombs"] = "ManaTombs",
	["AuchenaiCrypts"] = "AuchenaiCrypts",
	["SethekkHalls"] = "SethekkHalls",
	["ShadowLabyrinth"] = "ShadowLabyrinth",
	["TheSlavePens"] = "TheSlavePens",
	["TheUnderbog"] = "TheUnderbog",
	["TheSteamvault"] = "TheSteamvault",
	["OldHillsbradFoothills"] = "CoTHillsbradFoothills",
	["TheBlackMorass"] = "CoTTheBlackMorass",
	["TheArcatraz"] = "TheArcatraz",
	["TheBotanica"] = "TheBotanica",
	["TheMechanar"] = "TheMechanar",
	["MagistersTerrace"] = "MagistersTerrace",
	["Karazhan"] = "Karazhan",
	["ZulAman"] = "ZulAman",

	["MagtheridonsLair"] = "MagtheridonsLair",
	["GruulsLair"] = "GruulsLair",
	["SerpentshrineCavern"] = "CoilfangReservoir",
	["TempestKeep"] = "TempestKeep",
	["HyjalSummit"] = "CoTMountHyjal",
	["BlackTemple"] = "BlackTemple",
	["SunwellPlateau"] = "SunwellPlateau"
}
local wowcPvEBossMapTable = {
	["BlackfathomDeeps"] = {4, 5, 6, 7}, 
--[[
data["BlackfathomDeeps"] = {
	items = {
		{ -- BFDGhamoora
		},
		{ -- BFDLadySarevess
		},
		{ -- BFDGelihast
		},
		{ -- BFDBaronAquanis
			AtlasMapFile = {"CL_BlackfathomDeepsB", "CL_BlackfathomDeepsEnt"},
		},
		{ -- BFDTwilightLordKelris
			AtlasMapFile = {"CL_BlackfathomDeepsB", "CL_BlackfathomDeepsEnt"},
		},
		{ -- BFDOldSerrakis
			AtlasMapFile = {"CL_BlackfathomDeepsC", "CL_BlackfathomDeepsEnt"},
		},
		{ -- BFDAkumai
			AtlasMapFile = {"CL_BlackfathomDeepsB", "CL_BlackfathomDeepsEnt"},
		},
		{ -- BFDTrash
		},
	},
}
]]--	
	["Maraudon"] = {12, 13, 14, 15},
--[[
data["Maraudon"] = {
	items = {
		{ -- MaraKhanVeng
		},
		{ -- MaraNoxxion
		},
		{ -- MaraRazorlash
		},
		{ -- MaraKhanMaraudos
		},
		{ -- MaraLordVyletongue
		},
		{ -- MaraMeshlok
		},
		{ -- MaraCelebras
		},
		{ -- MaraLandslide
		},
		{ -- MaraTinkererGizlock
		},
		{ -- MaraRotgrip
		},
		{ -- MaraPrincessTheradras
		},
		{ -- MaraNamelesProphet
			AtlasMapFile = "CL_MaraudonEnt",
		},
		{ -- MaraKhanKolk
			AtlasMapFile = "CL_MaraudonEnt",
		},
		{ -- MaraKhanGelk
			AtlasMapFile_AL = "MaraudonEnt",
		},
		{ -- MaraKhanMagra
			AtlasMapFile = "CL_MaraudonEnt",
		},
	},
}
]]--
	["WorldBosses"] = {1, 2, 3, 4, 5, 6}
--[[
data["WorldBosses"] = {
	items = {
		{ -- AAzuregos
			AtlasMapFile = "Azuregos",
		},
		{ -- KKazzak
			AtlasMapFile = "LordKazzak",
		},
		{ -- DLethon
			AtlasMapFile = "FourDragons",
		},
		{ -- DEmeriss
			AtlasMapFile = "FourDragons",
		},
		{ -- DTaerar
			AtlasMapFile = "FourDragons",
		},
		{ -- DYsondre
			AtlasMapFile = "FourDragons",
		},
	}
}
]]--
	}
local tbccPvEBossMapTable = {
	["Karazhan"] = {10, 11, 12, 13, 14, 15}, 
--[[
data["Karazhan"] = {
	items = {
        { -- KaraAttumen
        },
        { -- KaraNamed
        },
        { -- KaraNamed
        },
        { -- KaraNamed
        },
        { -- KaraMoroes
        },
        { -- KaraMaiden
        },
        { -- KaraOperaEvent
        },
        { -- KaraOperaEvent
        },
        { -- KaraOperaEvent
        },
        { -- KaraCurator
            AtlasMapFile = KARA_MAPDATA_END,
        },
        { -- KaraIllhoof
            AtlasMapFile = KARA_MAPDATA_END,
        },
        { -- KaraAran
            AtlasMapFile = KARA_MAPDATA_END,
        },
        { -- KaraNetherspite
            AtlasMapFile = KARA_MAPDATA_END,
        },
        { -- KaraChess
            AtlasMapFile = KARA_MAPDATA_END,
        },
        { -- KaraPrince
            AtlasMapFile = KARA_MAPDATA_END,
        },
        { -- KaraNightbane
        },
        { -- KaraTrash
        },
    }
}]]--
	["BlackTemple"] = {4, 5, 6, 7, 8, 9}
--[[
data["BlackTemple"] = {
	items = {
        { -- BTNajentus
        },
        { -- BTSupremus
        },
        { -- BTAkama
        },
        { -- BTBloodboil
            AtlasMapFile = "CL_BlackTempleBasement",
        },
        { -- BTEssencofSouls
            AtlasMapFile = "CL_BlackTempleBasement",
        },
        { -- BTGorefiend
            AtlasMapFile = "CL_BlackTempleBasement",
        },
        { -- BTShahraz
            AtlasMapFile = "CL_BlackTempleTop",
        },
        { -- BTCouncil
            AtlasMapFile = "CL_BlackTempleTop",
        },
        { -- BTIllidanStormrage
            AtlasMapFile = "CL_BlackTempleTop",
        },
        { -- BTTrash
        },
        { -- BTPatterns
        },
    }
}
]]--
}


-- Function to override contentFrame.map.SetMap in order to enable ALC to display our maps
function ALCMRedux_SetMapReimplement(self, map, entranceMap)
	
	-- Duplicating the desired behavior within updateFrames
	if not self.atlasMapModule then	-- was niled by updateFrames right before the call
		local db = _G.AtlasLoot.db.GUI
		local moduleData = ALCDB[db.selected[1]]
		local dataID = db.selected[2]
		local bossID = db.selected[3]
		
		self.atlasMapModule = addonName or "ErrorMapModule"
		self.atlasMapFile = moduleData[dataID].items[bossID].AtlasMapFile or moduleData[dataID].AtlasMapFile

		-- No map for this selection
		if not self.atlasMapFile then
			self:Hide()
			self.overlay:Hide()
			return
		end

		ALCGUIFrame.mapButton:Show()
	-- Default behavior
	elseif self.map == map and self.entranceMap == entranceMap then -- Ignore a cached map
		self:ShowOverlay(true)
		return
	elseif  type(map) == "table" then -- Unpack a multi-map
		return ALCMRedux_SetMapReimplement(self, unpack(map))
	elseif map then -- Cache and display a non-null map
		self:Show()

		self.map = map
		self.atlasModule = self.atlasMapModule
		self.entranceMap = entranceMap

		self:ShowEntranceMap(false, true, true)
		return
	else -- nil map argument with a non nil self.atlasMapModule?
		self:Hide()
		self.overlay:Hide()
		return	
	end
	-- Tail positioned fall-through of custom behavior to invoke default behavior, self.atlasMapModule has been set to a non nil
	return ALCMRedux_SetMapReimplement(self, self.atlasMapFile)
end	

-- Check for other map providers that are enabled
local function ConflictCheck() 

	local info
	local conflictingPrefix = "Atlas_"
	local conflictingNames = {
		["AtlasLootClassic_Maps"] = true
		}
	local playerName = UnitName("player")

	for n = 1,GetNumAddOns() do
		info = {GetAddOnInfo(n)}
		local at, _ = string.find(info[1], "Atlas_", 1, true) 
		if (at == 1 or conflictingNames[info[1]]) and GetAddOnEnableState(playerName, n) ~= 0 then
			return true, " Found a conflicting map provider addon: " .. info[1]
		end
	end

	return false, ""
end

-- Functions to do work
local function FixPvPMapFiles(errString)

	local pvpModuleIndex = 4
	local forceError = false
	local pvpFailure = false
 
	-- Check that the pvp module exists
	if not ALCLoader.IsModuleLoaded(defaultALCModules[pvpModuleIndex]) then
		forceError = ALCLoader:LoadModule(defaultALCModules[pvpModuleIndex], function() end)
	end

	if type(forceError) == "string" then
		pvpFailure = true
		errString = errString .. " Loading PvP database failed: " .. forceError
	end

	if not pvpFailure then
		for n,id in ipairs(pvpMapNames) do
			ALCDB[defaultALCModules[pvpModuleIndex]][id].AtlasMapID = nil
		end
	end
	
	return errString
end

local function FixPvEMapFiles(errString) 

	local pveFailure = false
	local pveModuleIndex = 1

	-- Check  that the dungeon and raid module exists
	if not ALCLoader.IsModuleLoaded(defaultALCModules[pveModuleIndex]) then
		forceError = ALCLoader:LoadModule(defaultALCModules[pveModuleIndex], function() end)
	end

	if type(forceError) == "string" then
		pveFailure = true
		errString = errString .. " Loading Instance database failed: " .. forceError
	end

	if not pveFailure then

		for id,fileName in pairs(wowcPvEMapTable) do
			ALCDB[defaultALCModules[pveModuleIndex]][id].AtlasMapFile = wowcImageSubfolder .. fileName
		end

		for id,fileName in pairs(tbccPvEMapTable) do
			ALCDB[defaultALCModules[pveModuleIndex]][id].AtlasMapFile = tbccImageSubfolder .. fileName		
		end
	
		-- Could probably roll this into the first for loop, but want to separate responsibilities
		ALCDB[defaultALCModules[pveModuleIndex]].WorldBosses.AtlasMapFile = nil

		for id,list in pairs(wowcPvEBossMapTable) do
			for n,index in ipairs(list) do 
				ALCDB[defaultALCModules[pveModuleIndex]][id].items[index].AtlasMapFile = nil
			end
		end

		for id,list in pairs(tbccPvEBossMapTable) do
			for n,index in ipairs(list) do 
				ALCDB[defaultALCModules[pveModuleIndex]][id].items[index].AtlasMapFile = nil
			end
		end
	end
	
	return errString
end

local function InjectIntoALC()
	ALCGUIFrame.map.SetMap = ALCMRedux_SetMapReimplement
end

local skipExecution, errString = ConflictCheck()
if not skipExecution then
	errString = FixPvPMapFiles(errString)
	errString = FixPvEMapFiles(errString)
	if #errString == 0 then
		InjectIntoALC()
	end
end

local ALCMRFrame = CreateFrame("FRAME")
ALCMRFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
ALCMRFrame:SetScript("OnEvent", function(self, event) 

	if event == "PLAYER_ENTERING_WORLD" then
		if skipExecution then
			print(chatName .. " failed to load: " .. errString)
		elseif #errString ~= 0 then
			print(chatName .. " encountered errors attaching to ALC: " .. errString .. " Please reload.")
		else
			print(chatName .." loaded successfully.")
		end
		
		ALCMRFrame:SetScript("OnEvent", nil)
	end
end)
