local Units = {unitFrames = {}}
local vehicleMonitor = CreateFrame("Frame", nil, nil, "SecureHandlerBaseTemplate")
local unitEvents, loadedUnits, queuedCombat, inCombat = {}, {}, {}
local unitFrames = Units.unitFrames
local FRAME_LEVEL_MAX = 5
local _G = getfenv(0)

ShadowUF.Units = Units
ShadowUF:RegisterModule(Units, "units")

-- Frame shown, do a full update
local function FullUpdate(self)
	for i=1, #(self.fullUpdates), 2 do
		local handler = self.fullUpdates[i]
		handler[self.fullUpdates[i + 1]](handler, self)
	end
end

-- Register an event that should always call the frame
local function RegisterNormalEvent(self, event, handler, func)
	-- Make sure the handler/func exists
	if( not handler[func] ) then
		error(string.format("Invalid handler/function passed for %s on event %s, the function %s does not exist.", self:GetName() or tostring(self), event, func), 3)
		return
	end

	self:RegisterEvent(event)
	self.registeredEvents[event] = self.registeredEvents[event] or {}
	
	-- Each handler can only register an event once per a frame.
	if( self.registeredEvents[event][handler] ) then
		return
	end
			
	self.registeredEvents[event][handler] = func
end

-- Unregister an event
local function UnregisterEvent(self, event, handler)
	if( self and self.registeredEvents[handler] ) then
		self.registeredEvents[event][handler] = nil
	end
end

-- Register an event thats only called if it's for the actual unit
local function RegisterUnitEvent(self, event, handler, func)
	unitEvents[event] = true
	RegisterNormalEvent(self, event, handler, func)
end

-- Register a function to be called in an OnUpdate if it's an invalid unit (targettarget/etc)
local function RegisterUpdateFunc(self, handler, func)
	if( not handler[func] ) then
		error(string.format("Invalid handler/function passed to RegisterUpdateFunc for %s, the function %s does not exist.", self:GetName() or tostring(self), event, func), 3)
		return
	end

	for i=1, #(self.fullUpdates), 2 do
		local data = self.fullUpdates[i]
		if( data == handler and self.fullUpdates[i + 1] == func ) then
			return
		end
	end
	
	table.insert(self.fullUpdates, handler)
	table.insert(self.fullUpdates, func)
end

-- Used when something is disabled, removes all callbacks etc to it
local function UnregisterAll(self, handler)
	for i=#(self.fullUpdates), 1, -1 do
		if( self.fullUpdates[i] == handler ) then
			table.remove(self.fullUpdates, i + 1)
			table.remove(self.fullUpdates, i)
		end
	end

	for event, list in pairs(self.registeredEvents) do
		list[handler] = nil
		
		local totalEvents = 0
		for _ in pairs(list) do
			totalEvents = totalEvents + 1
		end
		
		if( totalEvents == 0 ) then
			self:UnregisterEvent(event)
		end
	end
end

-- Event handling
local function OnEvent(self, event, unit, ...)
	if( not unitEvents[event] or self.unit == unit ) then
		for handler, func in pairs(self.registeredEvents[event]) do
			handler[func](handler, self, event, unit, ...)
		end
	end
end

-- Do a full update OnShow, and stop watching for events when it's not visible
local function OnShow(self)
	-- Reset the event handler
	self:SetScript("OnEvent", OnEvent)
	Units:CheckUnitGUID(self)
end

local function OnHide(self)
	self:SetScript("OnEvent", nil)
	
	-- If it's a non-static unit like target or focus, will reset the flag and force an update when it's shown.
	if( self.unitType ~= "party" and self.unitType ~= "partypet" and self.unitType ~= "partytarget" and self.unitType ~= "player" and self.unitType ~= "raid" ) then
		self.unitGUID = nil
	end
end

-- For targettarget/focustarget/etc units that don't give us real events
local function TargetUnitUpdate(self, elapsed)
	self.timeElapsed = self.timeElapsed + elapsed
	
	if( self.timeElapsed >= 0.50 ) then
		self.timeElapsed = 0
		self:FullUpdate()
	end
end

-- Deal with enabling modules inside a zone
local function SetVisibility(self)
	local layoutUpdate
	local zone = select(2, IsInInstance())
	-- Selectively disable modules
	for _, module in pairs(ShadowUF.moduleOrder) do
		if( module.OnEnable and module.OnDisable ) then
			local key = module.moduleKey
			local enabled = ShadowUF.db.profile.units[self.unitType][key] and ShadowUF.db.profile.units[self.unitType][key].enabled
			
			-- Make sure at least one option is enabled if it's an aura or indicator
			if( key == "auras" or key == "indicators" ) then
				enabled = false
				for _, option in pairs(ShadowUF.db.profile.units[self.unitType][key]) do
					if( option.enabled ) then
						enabled = true
						break
					end
				end
			end
					
			if( zone ~= "none" ) then
				if( ShadowUF.db.profile.visibility[zone][self.unitType .. key] == false ) then
					enabled = false
				elseif( ShadowUF.db.profile.visibility[zone][self.unitType .. key] == true ) then
					enabled = true
				end
			end
			
			-- Options changed, will need to do a layout update
			local wasEnabled = self.visibility[key]
			if( self.visibility[key] ~= enabled ) then
				layoutUpdate = true
			end
			
			self.visibility[key] = enabled
			
			-- Module isn't enabled all the time, only in this zone so we need to force it to be enabled
			if( enabled and ( not self[key] or self[key].disabled )) then
				module:OnEnable(self)
			elseif( not enabled and wasEnabled ) then
				module:OnDisable(self)
				if( self[key] ) then self[key].disabled = true end
			end
		end
	end
	
	-- We had a module update, so redo everything
	if( layoutUpdate ) then
		ShadowUF.Layout:Load(self)
	end
end

-- Annoying, but a pure OnUpdate seems to be the most accurate way of ensuring we got data if it was delayed
local function checkVehicleData(self, elapsed)
	self.timeElapsed = self.timeElapsed + elapsed
	if( self.timeElapsed >= 0.20 ) then
		self.timeElapsed = 0
		self.dataAttempts = self.dataAttempts + 1
		
		-- Either we got data already, or it took over 5 seconds (25 tries) to get it
		if( UnitIsConnected(self.unit) or UnitHealthMax(self.unit) > 0 or self.dataAttempts >= 25 ) then
			self:SetScript("OnUpdate", nil)
			self:FullUpdate()
		end
	end
end

-- Check if a unit entered a vehicle
function Units:CheckVehicleStatus(frame, event, unit)
	if( event and frame.unitOwner ~= unit ) then return end
	
	-- Not in a vehicle yet, and they entered one that has a UI 
	if( not frame.inVehicle and UnitHasVehicleUI(frame.unitOwner) and not ShadowUF.db.profile.units[frame.unitType].disableVehicle ) then
		frame.inVehicle = true
		frame.unit = frame.unitOwner == "player" and "vehicle" or frame.unitType == "party" and "partypet" .. frame.unitID or frame.unitType == "raid" and "raidpet" .. frame.unitID

		if( not UnitIsConnected(frame.unit) or UnitHealthMax(frame.unit) == 0 ) then
			frame.timeElapsed = 0
			frame.dataAttempts = 0
			frame:SetScript("OnUpdate", checkVehicleData)
		else
			frame:FullUpdate()
		end
		
		-- Keep track of what the players current unit is supposed to be, so things like auras can figure it out
		if( frame.unitOwner == "player" ) then ShadowUF.playerUnit = frame.unit end
		
	-- Was in a vehicle, no longer has a UI
	elseif( frame.inVehicle and ( not UnitHasVehicleUI(frame.unitOwner) or ShadowUF.db.profile.units[frame.unitType].disableVehicle ) ) then
		frame.inVehicle = false
		frame.unit = frame.unitOwner
		frame.unitGUID = UnitGUID(frame.unit)
		frame:FullUpdate()

		if( frame.unitOwner == "player" ) then ShadowUF.playerUnit = frame.unitOwner end
	end
end

-- When a frames GUID changes,
-- Handles checking for GUID changes for doing a full update, this fixes frames sometimes showing the wrong unit when they change
local guid
function Units:CheckUnitGUID(frame)
	guid = frame.unit and UnitGUID(frame.unit)
	if( guid and guid ~= frame.unitGUID ) then
		frame:FullUpdate()
	end
	
	frame.unitGUID = guid
end

-- The argument from UNIT_PET is the pets owner, so the player summoning a new pet gets "player", party1 summoning a new pet gets "party1" and so on
function Units:CheckUnitUpdated(frame, event, unit)
	if( unit ~= frame.unitRealOwner or not UnitExists(unit) ) then return end
	frame:FullUpdate()
end

local function ShowMenu(self)
	FriendsDropDown.displayMode = "MENU"
	FriendsDropDown.initialize = RaidFrameDropDown_Initialize
	FriendsDropDown.userData = self.unitID

	HideDropDownMenu(1)
	FriendsDropDown.unit = self.unit
	FriendsDropDown.name = UnitName(self.unit)
	FriendsDropDown.id = self.unitID
	ToggleDropDownMenu(1, nil, FriendsDropDown, "cursor")
end

-- Attribute set, something changed
local function OnAttributeChanged(self, name, unit)
	if( name ~= "unit" or not unit or unit == self.unitOwner ) then return end
	
	-- In combat, queue it for update when we leave it
	if( inCombat ) then
		queuedCombat[self] = true
		
		if( not self.unit ) then
			return
		end
	end
	
	-- Unit already exists, we're going to update our information on them but we're not going to do a full update and recheck things
	-- we don't have to because frames are ALWAYS going to be the same type, a raid frame will not magically turn into a target frame.
	if( self.unit ) then
		self.unit = unit
		self.unitID = tonumber(string.match(unit, "([0-9]+)"))
		self.unitOwner = unit

		Units:CheckUnitGUID(self)
		return
	end
		
	-- Setup identification data
	self.unit = unit
	self.unitID = tonumber(string.match(unit, "([0-9]+)"))
	self.unitType = string.gsub(unit, "([0-9]+)", "")
	self.unitOwner = unit
	
	-- Add to Clique
	ClickCastFrames = ClickCastFrames or {}
	ClickCastFrames[self] = true

	-- Store it for later
	unitFrames[self.unit] = self
	
	-- Pet changed, going from pet -> vehicle for one
	if( self.unit == "pet" or self.unitType == "partypet" ) then
		self.unitRealOwner = self.unit == "pet" and "player" or ShadowUF.partyUnits[self.unitID]
		self:RegisterNormalEvent("UNIT_PET", Units, "CheckUnitUpdated")
		
		if( self.unit == "pet" ) then
			self.dropdownMenu = PetFrameDropDown
			self:SetAttribute("_menu", PetFrame.menu)
		end
	
		-- Logged out in a vehicle
		if( UnitHasVehicleUI(self.unitRealOwner) ) then
			self:SetAttribute("unitIsVehicle", true)
		end
		
		self:SetAttribute("disableVehicleSwap", ShadowUF.db.profile.units[self.unit == "pet" and "player" or "party"].disableVehicle)

		-- Hide any pet that became a vehicle, we detect this by the owner being untargetable but we have a pet out
		RegisterStateDriver(self, "vehicleupdated", string.format("[target=%s, nohelp, noharm] vehicle; [target=%s, exists] pet", self.unitRealOwner, self.unit))
		vehicleMonitor:WrapScript(self, "OnAttributeChanged", [[
			if( name == "state-vehicleupdated" ) then
				self:SetAttribute("unitIsVehicle", value == "vehicle" and true or false)
			elseif( name == "state-unitexists" ) then
				if( not value or ( not self:GetAttribute("disableVehicleSwap") and self:GetAttribute("unitIsVehicle") ) ) then
					self:Hide()
				elseif( value ) then
					self:Show()
				end
			elseif( name == "disablevehicleswap" ) then
				if( value and self:GetAttribute("state-unitexists") ) then
					self:Show()
				elseif( not self:GetAttribute("state-unitexists") or ( not value and self:GetAttribute("unitIsVehicle") ) ) then 
					self:Hide()
				end
			end
		]])

	-- Automatically do a full update on target change
	elseif( self.unit == "target" ) then
		self.dropdownMenu = TargetFrameDropDown
		self:SetAttribute("_menu", TargetFrame.menu)
		self:RegisterNormalEvent("PLAYER_TARGET_CHANGED", Units, "CheckUnitGUID")

	-- Automatically do a full update on focus change
	elseif( self.unit == "focus" ) then
		self.dropdownMenu = FocusFrameDropDown
		self:SetAttribute("_menu", FocusFrame.menu)
		self:RegisterNormalEvent("PLAYER_FOCUS_CHANGED", Units, "CheckUnitGUID")
				
	-- When a player is force ressurected by releasing in naxx/tk/etc then they might freeze
	elseif( self.unit == "player" ) then
		self.dropdownMenu = PlayerFrameDropDown
		self:SetAttribute("_menu", PlayerFrame.menu)
		self:RegisterNormalEvent("PLAYER_ALIVE", self, "FullUpdate")
	
	-- Check for a unit guid to do a full update
	elseif( self.unitType == "raid" ) then
		self.dropdownMenu = FriendsDropDown
		self.menu = ShowMenu
		self:RegisterNormalEvent("RAID_ROSTER_UPDATE", Units, "CheckUnitGUID")
		
	-- Party members need to watch for changes
	elseif( self.unitType == "party" ) then
		self.dropdownMenu = _G["PartyMemberFrame" .. self.unitID .. "DropDown"]
		self:SetAttribute("_menu", _G["PartyMemberFrame" .. self.unitID].menu)
		self:RegisterNormalEvent("PARTY_MEMBERS_CHANGED", Units, "CheckUnitGUID")

		-- Party frame has been loaded, so initialize it's sub-frames if they are enabled
		if( loadedUnits.partypet ) then
			Units:LoadPartyChildUnit(ShadowUF.db.profile.units.partypet, SUFHeaderparty, "partypet", "partypet" .. self.unitID)
		end
		
		if( loadedUnits.partytarget ) then
			Units:LoadPartyChildUnit(ShadowUF.db.profile.units.partytarget, SUFHeaderparty, "partytarget", "party" .. self.unitID .. "target")
		end

	-- *target units are not real units, thus they do not receive events and must be polled for data
	elseif( string.match(self.unit, "%w+target") ) then
		self.timeElapsed = 0
		self:SetScript("OnUpdate", TargetUnitUpdate)
		
		-- This speeds up updating of fake units, if party1 changes target than party1target is force updated, if target changes target, then targettarget and targettarget are force updated
		-- same goes for focus changing target, focustarget is forced to update.
		self.unitRealOwner = self.unitType == "partytarget" and ShadowUF.partyUnits[self.unitID] or self.unitType == "focustarget" and "focus" or "target"
		self:RegisterNormalEvent("UNIT_TARGET", Units, "CheckUnitUpdated")
		
		-- Another speed up, if the focus changes then of course the focustarget has to be force updated
		if( self.unit == "focustarget" ) then
			self:RegisterNormalEvent("PLAYER_FOCUS_CHANGED", Units, "CheckUnitGUID")
		-- If the player changes targets, then we know the targettarget and targettargettarget definitely changed
		elseif( self.unit == "targettarget" or self.unit == "targettargettarget" ) then
			self:RegisterNormalEvent("PLAYER_TARGET_CHANGED", Units, "CheckUnitGUID")
		end
	end

	-- You got to love programming without documentation, ~3 hours spent making this work with raids and such properly, turns out? It's a simple attribute
	-- and all you have to do is set it up so the unit variables are properly changed based on being in a vehicle... which is what will do now
	if( self.unit == "player" or self.unitType == "party" or self.unitType == "raid" ) then
		self:RegisterNormalEvent("UNIT_ENTERED_VEHICLE", Units, "CheckVehicleStatus")
		self:RegisterNormalEvent("UNIT_EXITED_VEHICLE", Units, "CheckVehicleStatus")
		self:RegisterUpdateFunc(Units, "CheckVehicleStatus")
		
		-- This unit can be a vehicle, so will want to be able to target the vehicle if they enter one
		self:SetAttribute("toggleForVehicle", true)
				
		-- Check if they are in a vehicle
		Units:CheckVehicleStatus(self)
	end	
	
	-- Update module status
	self:SetVisibility()
end

function Units:LoadUnit(config, unit)
	-- Already be loaded, just enable
	if( unitFrames[unit] ) then
		RegisterUnitWatch(unitFrames[unit], unit == "pet")
		return
	end
	
	local frame = CreateFrame("Button", "SUFUnit" .. unit, UIParent, "SecureUnitButtonTemplate")
	self:CreateUnit(frame)
	frame:SetAttribute("unit", unit)

	unitFrames[unit] = frame
		
	-- Annd lets get this going
	RegisterUnitWatch(frame, unit == "pet")
end

-- Show tooltip
local function OnEnter(...)
	if( not ShadowUF.db.profile.tooltipCombat or not inCombat ) then
		UnitFrame_OnEnter(...)
	end
end

-- Reset the fact that we clamped the dropdown to the screen to be safe
DropDownList1:HookScript("OnHide", function(self)
	self:SetClampedToScreen(false)
end)

-- Create the generic things that we want in every secure frame regardless if it's a button or a header
function Units:CreateUnit(frame,  hookVisibility)
	frame.barFrame = CreateFrame("Frame", nil, frame)
	frame.secondBarFrame = CreateFrame("Frame", nil, frame)
	frame:Hide()
	
	frame.fullUpdates = {}
	frame.registeredEvents = {}
	frame.visibility = {}
	frame.RegisterNormalEvent = RegisterNormalEvent
	frame.RegisterUnitEvent = RegisterUnitEvent
	frame.RegisterUpdateFunc = RegisterUpdateFunc
	frame.UnregisterAll = UnregisterAll
	frame.FullUpdate = FullUpdate
	frame.SetVisibility = SetVisibility
	frame.topFrameLevel = FRAME_LEVEL_MAX
	
	-- Ensures that text is the absolute highest thing there is
	frame.highFrame = CreateFrame("Frame", nil, frame)
	frame.highFrame:SetFrameLevel(frame.topFrameLevel + 1)
	frame.highFrame:SetAllPoints(frame)
	
	frame:SetScript("OnAttributeChanged", OnAttributeChanged)
	frame:SetScript("OnEnter", 	OnEnter)
	frame:SetScript("OnLeave", 	UnitFrame_OnLeave)
	frame:SetScript("OnEvent", OnEvent)

	frame:RegisterForClicks("AnyUp")	
	frame:SetAttribute("*type1", "target")
	frame:SetAttribute("*type2", "menu")
	frame:SetScript("PostClick", function(self)
		if( UIDROPDOWNMENU_OPEN_MENU == self.dropdownMenu and DropDownList1:IsShown() )	 then
			DropDownList1:ClearAllPoints()
			DropDownList1:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, 0)
			DropDownList1:SetClampedToScreen(true)
		end
	end)
	
	-- allowVehicleTarget
	--[16:42] <+alestane> Shadowed: It says whether a unit defined as, for instance, "party1target" should be remapped to "partypet1target" when party1 is in a vehicle.
	--frame.menu = ShowMenu

	if( hookVisibility ) then
		frame:HookScript("OnShow", OnShow)
		frame:HookScript("OnHide", OnHide)
	else
		frame:SetScript("OnShow", OnShow)
		frame:SetScript("OnHide", OnHide)
	end
end

function Units:ReloadHeader(type)
	if( not unitFrames[type] or unitFrames[type].unit ) then return end
	
	-- Update the main header
	local frame = unitFrames[type]
	if( frame ) then
		self:SetFrameAttributes(frame, type)
		ShadowUF.Layout:AnchorFrame(UIParent, frame, ShadowUF.db.profile.positions[type])
	end

	-- Now update it's children
	if( type == "partypet" or type == "partytarget" ) then
		for _, frame in pairs(unitframes) do
			if( frame.unitType == type ) then
				self:SetFrameAttributes(frame, type)
				if( UnitExists(frame.unit) ) then
					frame:SetAttribute("framePositioned", false)
					frame:Hide()
					frame:Show()
				end
			end
		end
	end
end

function Units:ProfileChanged()
	-- Reset the anchors for all frames to prevent X is dependant on Y
	for _, frame in pairs(unitFrames) do
		if( frame:GetAttribute("unit") ) then
			frame:ClearAllPoints()
		end
	end
	
	-- Force all of the module changes
	for _, frame in pairs(unitFrames) do
		if( frame:GetAttribute("unit") ) then
			-- Force all enabled modules to disable
			for key, module in pairs(ShadowUF.modules) do
				if( frame[key] and frame[key].disabled ) then
					frame[key].disabled = true
					module:OnDisable(frame)
				end
			end
			
			-- Now enable whatever we need to
			frame:SetVisibility()
			ShadowUF.Layout:Load(frame)
			frame:FullUpdate()
		end
	end
	
	-- Force headers to update
	self:ReloadHeader("raid")
	self:ReloadHeader("party")
end

function Units:SetFrameAttributes(frame, type)
	local config = ShadowUF.db.profile.units[type]
	if( not config ) then
		return
	end
	
	if( type == "raid" or type == "party" ) then
		frame:SetAttribute("point", config.attribPoint)
		frame:SetAttribute("initial-width", config.width)
		frame:SetAttribute("initial-height", config.height)
		frame:SetAttribute("initial-scale", config.scale)
		frame:SetAttribute("showRaid", type == "raid" and true or false)
		frame:SetAttribute("showParty", type == "party" and true or false)
		frame:SetAttribute("xOffset", config.xOffset)
		frame:SetAttribute("yOffset", config.yOffset)
		
		if( type == "raid" ) then
			local filter
			for id, enabled in pairs(config.filters) do
				if( enabled ) then
					if( filter ) then
						filter = filter .. "," .. id
					else
						filter = id
					end
				end
			end
		
			frame:SetAttribute("sortMethod", "INDEX")
			frame:SetAttribute("sortDir", config.sortOrder)
			frame:SetAttribute("maxColumns", config.maxColumns)
			frame:SetAttribute("unitsPerColumn", config.unitsPerColumn)
			frame:SetAttribute("columnSpacing", config.columnSpacing)
			frame:SetAttribute("columnAnchorPoint", config.attribAnchorPoint)
			frame:SetAttribute("groupFilter", filter or "1,2,3,4,5,6,7,8")
			
			if( config.groupBy == "CLASS" ) then
				frame:SetAttribute("groupingOrder", "DEATHKNIGHT,DRUID,HUNTER,MAGE,PALADIN,PRIEST,ROGUE,SHAMAN,WARLOCK,WARRIOR")
				frame:SetAttribute("groupBy", "CLASS")
			else
				frame:SetAttribute("groupingOrder", "1,2,3,4,5,6,7,8")
				frame:SetAttribute("groupBy", "GROUP")
			end
		end
	elseif( type == "partypet" or type == "partytarget" ) then
		frame:SetAttribute("framePositioned", false)
		frame:SetAttribute("framePoint", ShadowUF.Layout:GetPoint(ShadowUF.db.profile.positions[type].anchorPoint))
		frame:SetAttribute("frameRelative", ShadowUF.Layout:GetRelative(ShadowUF.db.profile.positions[type].anchorPoint))
		frame:SetAttribute("frameX", ShadowUF.db.profile.positions[type].x)
		frame:SetAttribute("frameY", ShadowUF.db.profile.positions[type].y)
	end
end

local function initializeUnit(self)
	self.ignoreAnchor = true
	Units:CreateUnit(self)
end

function Units:LoadGroupHeader(config, type)
	if( unitFrames[type] ) then
		self:SetFrameAttributes(unitFrames[type], type)
		unitFrames[type]:Show()
		return
	end
	
	local headerFrame = CreateFrame("Frame", "SUFHeader" .. type, UIParent, "SecureGroupHeaderTemplate")
	self:SetFrameAttributes(headerFrame, type)
	
	headerFrame:SetAttribute("template", "SecureUnitButtonTemplate")
	headerFrame:SetAttribute("initial-unitWatch", true)
	headerFrame.initialConfigFunction = initializeUnit
	headerFrame.unitType = type
	headerFrame:Show()

	unitFrames[type] = headerFrame
	ShadowUF.Layout:AnchorFrame(UIParent, headerFrame, ShadowUF.db.profile.positions[type])
end

function Units:LoadPartyChildUnit(config, parentHeader, type, unit)
	if( unitFrames[unit] ) then
		self:SetFrameAttributes(unitFrames[unit], unitFrames[unit].unitType)
		RegisterUnitWatch(unitFrames[unit], type == "partypet")
		return
	end
	
	local frame = CreateFrame("Button", "SUFUnit" .. unit, UIParent, "SecureUnitButtonTemplate,SecureHandlerShowHideTemplate")
	frame.ignoreAnchor = true
	frame:Hide()

	self:SetFrameAttributes(frame, type)
		
	self:CreateUnit(frame, true)
	frame:SetFrameRef("partyHeader",  parentHeader)
	frame:SetAttribute("unit", unit)
	frame:SetAttribute("unitOwner", "party" .. (string.match(unit, "(%d+)")))
	frame:SetAttribute("_onshow", [[
		if( self:GetAttribute("framePositioned") ) then return end
		
		local children = table.new(self:GetFrameRef("partyHeader"):GetChildren())
		for _, child in pairs(children) do
			if( child:GetAttribute("unit") == self:GetAttribute("unitOwner") ) then
				self:SetParent(child)
				self:ClearAllPoints()
				self:SetPoint(self:GetAttribute("framePoint"), child, self:GetAttribute("frameRelative"), self:GetAttribute("frameX"), self:GetAttribute("frameY"))
				self:SetAttribute("framePositioned", true)
			end
		end
	]])
	
	unitFrames[unit] = frame

	-- Annd lets get this going
	RegisterUnitWatch(frame, type == "partypet")
end

function Units:InitializeFrame(config, type)
	if( loadedUnits[type] ) then return end
	loadedUnits[type] = true
	
	if( type == "party" ) then
		self:LoadGroupHeader(config, type)
	elseif( type == "raid" ) then
		self:LoadGroupHeader(config, type)
	-- Since I delay the partypet/partytarget creation until the owners were loaded, we don't want to actually initialize them here
	-- unless the pets were already loaded, this mainly accounts for the fact that you might enable a unit in arenas, but not in raids, etc.
	elseif( type == "partypet" ) then
		for id, unit in pairs(ShadowUF.partyUnits) do
			if( unitFrames[unit] ) then
				Units:LoadPartyChildUnit(ShadowUF.db.profile.units.partypet, SUFHeaderparty, "partypet", "partypet" .. id)
			end
		end
	elseif( type == "partytarget" ) then
		for id, unit in pairs(ShadowUF.partyUnits) do
			if( unitFrames[unit] ) then
				Units:LoadPartyChildUnit(ShadowUF.db.profile.units.partytarget, SUFHeaderparty, "partytarget", "party" .. id .. "target")
			end
		end
	else
		self:LoadUnit(config, type)
	end
end

function Units:UninitializeFrame(config, type)
	if( not loadedUnits[type] ) then return end
	loadedUnits[type] = nil
	
	-- We're trying to disable a header
	if( unitFrames[type] ) then
		UnregisterUnitWatch(unitFrames[type])
		unitFrames[type]:Hide()
		return
	end
	
	-- Otherwise, we're disabling a specific unit
	for _, frame in pairs(unitFrames) do
		if( frame.unitType == type ) then
			UnregisterUnitWatch(frame)

			frame:SetAttribute("framePositioned", nil)
			frame:Hide()
		end
	end
end

function Units:CreateBar(parent)
	local frame = CreateFrame("StatusBar", nil, parent)
	frame:SetFrameLevel(FRAME_LEVEL_MAX)
	frame.parent = parent
	frame.background = frame:CreateTexture(nil, "BORDER")
	frame.background:SetHeight(1)
	frame.background:SetWidth(1)
	frame.background:SetAllPoints(frame)
	
	--[[
	local OrigSetMinMax = frame.SetMinMaxValues
	frame.SetMinMaxValues = function(self, min, max)
		OrigSetMinMax(self, max, min)
	end

	local OrigSetValue = frame.SetValue
	frame.SetValue = function(self, value)
		local min, max = self:GetMinMaxValues()
		--value = min - value
		
		OrigSetValue(self, value)
	end
	]]
	
	return frame
end

-- Handles events related to all units and not a specific one
local headerUpdated = {}
local centralFrame = CreateFrame("Frame")
centralFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
centralFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
centralFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
centralFrame:SetScript("OnEvent", function(self, event, unit)
	if( event == "ZONE_CHANGED_NEW_AREA" ) then
		for _, frame in pairs(unitFrames) do
			if( frame:GetAttribute("unit") ) then
				frame:SetVisibility()
				
				if( UnitExists(frame.unit) ) then
					frame:FullUpdate()
				end
			end
		end
		
	elseif( event == "PLAYER_REGEN_ENABLED" ) then
		inCombat = nil
	
		for k in pairs(headerUpdated) do headerUpdated[k] = nil end
		
		for frame in pairs(queuedCombat) do
			queuedCombat[frame] = nil
			if( not frame.unit ) then
				OnAttributeChanged(frame, "unit", frame:GetAttribute("unit"))
			else
				frame:SetVisibility()
			end
			
			-- When parties change in combat, the overall height/width of the secure header will change, we need to force a secure group update
			-- in order for all of the sizing information to be set correctly.
			if( frame.unitType ~= frame.unit and not headerUpdated[frame.unitType] ) then
				local header = unitFrames[frame.unitType]
				if( header and header:GetHeight() <= 0 and header:GetWidth() <= 0 ) then
					SecureGroupHeader_Update(header)
				end
				
				headerUpdated[frame.unitType] = true
			end
		end
	elseif( event == "PLAYER_REGEN_DISABLED" ) then
		inCombat = true
	end
end)