--[[ red range ]]
function redrange()
hooksecurefunc("ActionButton_OnEvent",function(self, event, ...)
	if ( event == "PLAYER_TARGET_CHANGED" ) then
		self.newTimer = self.rangeTimer
	end
end)
hooksecurefunc("ActionButton_UpdateUsable",function(self)
	local icon = _G[self:GetName().."Icon"]
	local valid = IsActionInRange(self.action)
	if ( valid == false ) then
	  icon:SetVertexColor(1.0, 0.1, 0.1)
	end
end)
hooksecurefunc("ActionButton_OnUpdate",function(self, elapsed)
	local rangeTimer = self.newTimer
	if ( rangeTimer ) then
	  rangeTimer = rangeTimer - elapsed
		if ( rangeTimer <= 0 ) then
		  ActionButton_UpdateUsable(self)
		  rangeTimer = TOOLTIP_UPDATE_TIME
		end
	  self.newTimer = rangeTimer
	end
end)
end

--[[ show fps/latency ]]
function lagbar()
	local MAX_INTERVAL = 5
	local UPDATE_INTERVAL = 0
	local bag = MainMenuBarBackpackButton
	local f=CreateFrame("Frame")
		f:SetPoint("BOTTOMLEFT", CharacterBag3Slot, "TOPLEFT")
		f:SetPoint("TOPRIGHT", bag, "TOPLEFT")
		f.text = f:CreateFontString(nil,"ARTWORK")
		f.text:SetFont("Fonts\\FRIZQT__.TTF", 8, "OUTLINE")
		f.text:SetPoint("CENTER")
		f:Show()
		f:SetScript("OnUpdate", function(self,arg1)
			if (UPDATE_INTERVAL > 0) then
				UPDATE_INTERVAL = UPDATE_INTERVAL - arg1
			else
				UPDATE_INTERVAL = MAX_INTERVAL;
			local fps=floor(GetFramerate())
			local home=select(3,GetNetStats())
			f.text:SetText(fps.." fps".." | "..home.." ms")
		end
	end)
		
	local b=CreateFrame("Frame")
	b:SetPoint("BOTTOMLEFT", CharacterBag3Slot)
	b:SetPoint("TOPRIGHT", bag)	--fixme
	b:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
		tile = true, tileSize = 16, edgeSize = 8, 
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
		})
	b:SetBackdropColor(0,0,0,1)
	b:SetBackdropBorderColor(.4,.4,.4,1)
	b:Show()
end

--[[ bag bar ]]
function bags() 
local f=CreateFrame("Frame")
	local bag = MainMenuBarBackpackButton
	bag:ClearAllPoints()
	bag:SetPoint("BOTTOMRIGHT",UIPARENT,0,0)
	bag:SetScale(1.5)
	CharacterBag0Slot:ClearAllPoints()
	CharacterBag0Slot:SetPoint("BOTTOMRIGHT", bag, "BOTTOMLEFT")
	CharacterBag0Slot:SetScale(0.8)
	CharacterBag1Slot:ClearAllPoints()
	CharacterBag1Slot:SetPoint("BOTTOMRIGHT", CharacterBag0Slot, "BOTTOMLEFT")
	CharacterBag1Slot:SetScale(0.8)
	CharacterBag2Slot:ClearAllPoints()
	CharacterBag2Slot:SetPoint("BOTTOMRIGHT", CharacterBag1Slot, "BOTTOMLEFT")
	CharacterBag2Slot:SetScale(0.8)
	CharacterBag3Slot:ClearAllPoints()
	CharacterBag3Slot:SetPoint("BOTTOMRIGHT", CharacterBag2Slot, "BOTTOMLEFT")
	CharacterBag3Slot:SetScale(0.8)
end

--[[ misc slash cmd, options, etc]]
function misc()
	print("Ode's UI Scripts Loaded.")
	SlashCmdList["RELOADUI"] = function() ReloadUI() end
	SLASH_RELOADUI1 = "/rl"
	SlashCmdList["READYCHECK"] = function() DoReadyCheck() end
    SLASH_READYCHECK1 = '/rc'
	SetCVar ("chatClassColorOverride", 0)
	SetCVar ("scriptErrors", 0)
	SetCVar ("ActionButtonUseKeyDown", 1)
end

--[[ Hide Stuff ]]--
function hide() 
	for i, v in pairs ({
		PlayerFrameGroupIndicator,
		MainMenuBarPerformanceBar,
		MainMenuBarPerformanceBarFrame,
		CharacterMicroButton,
		SpellbookMicroButton,
		QuestLogMicroButton,
		SocialsMicroButton,
		WorldMapMicroButton,
		MainMenuMicroButton,
		HelpMicroButton,
		ActionBarUpButton,
		ActionBarDownButton,
		GameTimeFrame,
		MinimapZoomIn,
		MinimapZoomOut,
		})
	do 
		v:Hide()
		hooksecurefunc("UpdateMicroButtons",function(...) if TalentMicroButton then TalentMicroButton:Hide() end end) -- hide store button
		-- put alphas/offscreens here
		MainMenuBarPageNumber:SetAlpha(0)
		TargetFrameTextureFramePVPIcon:SetAlpha(0)
	end
end

--[[ Reposition ]]--
function move()
	MainMenuBarTexture0:SetPoint("BOTTOMLEFT", MainMenuBarArtFrame)
	MainMenuBarTexture1:SetPoint("BOTTOMRIGHT", MainMenuBarArtFrame, "BOTTOMRIGHT")
	MainMenuBarTexture2:Hide()
	MainMenuBarTexture3:Hide()
	MainMenuBar:SetWidth(MainMenuBarTexture0:GetWidth()*2)
	MainMenuBarArtFrame:SetWidth(MainMenuBarTexture0:GetWidth()*2)
	MainMenuBarArtFrame:SetPoint("BOTTOM", MainMenuExpBar, "TOP")
	MultiBarBottomLeft:ClearAllPoints()
	MultiBarBottomLeft:SetPoint("BOTTOMLEFT", ActionButton1, "TOPLEFT", 0, 7.5)
	MultiBarBottomLeft.SetPoint = function() end
	MultiBarBottomRight:ClearAllPoints()
	MultiBarBottomRight:SetPoint("BOTTOMLEFT", MultiBarBottomLeftButton1, "TOPLEFT", 0, 7.5)
	MainMenuExpBar:ClearAllPoints()
	MainMenuExpBar:SetPoint("BOTTOM", UIPARENT, "BOTTOM")
	MainMenuExpBar:SetWidth(MainMenuBarTexture1:GetWidth()*2)
	MainMenuXPBarTexture0:Hide()
	MainMenuXPBarTexture1:SetPoint("BOTTOMLEFT", MainMenuExpBar, "BOTTOMLEFT")
	MainMenuXPBarTexture1:SetHeight(MainMenuExpBar:GetHeight())
	MainMenuXPBarTexture2:SetPoint("BOTTOMLEFT", MainMenuXPBarTexture1, "BOTTOMRIGHT")
	MainMenuXPBarTexture2:SetHeight(MainMenuExpBar:GetHeight())
	MainMenuXPBarTexture3:Hide()
	ReputationWatchBar:ClearAllPoints()
	ReputationWatchBar:SetPoint("BOTTOM", 0, 2)
	ReputationWatchBar.SetPoint = function() end
	ReputationWatchBar.StatusBar:SetWidth(ReputationWatchBar.StatusBar.XPBarTexture1:GetWidth()*2)
	ReputationWatchBar.StatusBar.XPBarTexture0:SetHeight(ReputationWatchBar.StatusBar:GetHeight())
	ReputationWatchBar.StatusBar.XPBarTexture1:SetHeight(ReputationWatchBar.StatusBar:GetHeight())
	ReputationWatchBar.StatusBar.XPBarTexture2:SetAlpha(0)
	ReputationWatchBar.StatusBar.XPBarTexture3:SetAlpha(0)
	MainMenuBarRightEndCap:ClearAllPoints()
	MainMenuBarRightEndCap:SetPoint("BOTTOMLEFT", MainMenuExpBar, "BOTTOMRIGHT", -30, 0)
	MainMenuBarRightEndCap:SetScale(1)
	MainMenuBarLeftEndCap:ClearAllPoints()
	MainMenuBarLeftEndCap:SetPoint("BOTTOMRIGHT", MainMenuExpBar, "BOTTOMLEFT", 30, 0)
	MainMenuBarLeftEndCap:SetScale(1)
	StanceBarFrame:SetPoint("RIGHT",PlayerFrame,"LEFT",0,0)
end

--[[ Hide Bar Text ]]--
function hidebartext()
	for i=1, 12 do
		_G["ActionButton"..i.."HotKey"]:SetAlpha(0)
		_G["MultiBarBottomRightButton"..i.."HotKey"]:SetAlpha(0)
		_G["MultiBarBottomLeftButton"..i.."HotKey"]:SetAlpha(0)
		_G["MultiBarRightButton"..i.."HotKey"]:SetAlpha(0)
		_G["MultiBarLeftButton"..i.."HotKey"]:SetAlpha(0)
	end
	for i=1, 10 do
		_G["PetActionButton"..i.."HotKey"]:SetAlpha(0)
	end
	for i=1, 12 do
		_G["ActionButton"..i.."Name"]:SetAlpha(0)
		_G["MultiBarBottomRightButton"..i.."Name"]:SetAlpha(0)
		_G["MultiBarBottomLeftButton"..i.."Name"]:SetAlpha(0)
		_G["MultiBarRightButton"..i.."Name"]:SetAlpha(0)
		_G["MultiBarLeftButton"..i.."Name"]:SetAlpha(0)
	end
end

--[[ Mouseovers ]]--
function mouseover()
	for i=1,12 do
		_G["MultiBarBottomRightButton"..i]:SetAlpha(.0) 
		_G["MultiBarRightButton"..i]:SetAlpha(.0)
		_G["MultiBarLeftButton"..i]:SetAlpha(.0)
		_G["MultiBarBottomRightButton"..i]:SetScript("OnEnter", function(self) for u=1,12 do _G["MultiBarBottomRightButton"..u]:SetAlpha(1) end end) --
		_G["MultiBarBottomRightButton"..i]:SetScript("OnLeave", function(self) for u=1,12 do _G["MultiBarBottomRightButton"..u]:SetAlpha(.0) end end) --
		_G["MultiBarRightButton"..i]:SetScript("OnLeave", function(self) for u=1,12 do _G["MultiBarRightButton"..u]:SetAlpha(.0)end end)
		_G["MultiBarRightButton"..i]:SetScript("OnEnter", function(self) for u=1,12 do _G["MultiBarRightButton"..u]:SetAlpha(1) end end)
		_G["MultiBarLeftButton"..i]:SetScript("OnEnter", function(self) for u=1,12 do _G["MultiBarLeftButton"..u]:SetAlpha(1) end end)                                                                             
		_G["MultiBarLeftButton"..i]:SetScript("OnLeave", function(self) for u=1,12 do _G["MultiBarLeftButton"..u]:SetAlpha(.0)end end)                                                                             
	end
	do
		MultiBarBottomRight:SetScript("OnEnter", function(self) for i=1,12 do _G["MultiBarBottomRightButton"..i]:SetAlpha(1) end end) -- use
		MultiBarBottomRight:SetScript("OnLeave", function(self) for i=1,12 do _G["MultiBarBottomRightButton"..i]:SetAlpha(.0) end end) -- use
		MultiBarRight:SetScript("OnEnter", function(self) for i=1,12 do _G["MultiBarRightButton"..i]:SetAlpha(1) end end)
		MultiBarRight:SetScript("OnLeave", function(self) for i=1,12 do _G["MultiBarRightButton"..i]:SetAlpha(.0) end end)
		MultiBarLeft:SetScript("OnEnter", function(self) for i=1,12 do _G["MultiBarLeftButton"..i]:SetAlpha(1)end end)
		MultiBarLeft:SetScript("OnLeave", function(self) for i=1,12 do _G["MultiBarLeftButton"..i]:SetAlpha(.0)end end)
	end
end

--[[ Cast Bars ]]--
function castbars() 
	CastingBarFrame:ClearAllPoints()
	CastingBarFrame:SetPoint("BOTTOMLEFT",PlayerPortrait,"TOPRIGHT", 0, 0)
	CastingBarFrame:SetScale(1.4)
	CastingBarFrame.Text:ClearAllPoints()
	CastingBarFrame.Text:SetPoint("CENTER", CastingBarFrame)
	CastingBarFrame.Border:Hide()
	CastingBarFrame.Flash:SetTexture(nil)
	CastingBarFrame:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
		insets = { left = -2, right = -2, top = -2, bottom = -2 }
		})
	CastingBarFrame:SetBackdropColor(0,0,0,1)
	CastingBarFrame.Text.SetPoint = function() end
	CastingBarFrame.SetPoint = function() end
end

--[[ Unit Frames ]]
function uf()
	PlayerFrame:ClearAllPoints()
	PlayerFrame:SetPoint("RIGHT", UIParent, "CENTER", -10, -250)		
	PlayerFrame:SetUserPlaced(true)
	TargetFrame:ClearAllPoints()
	TargetFrame:SetPoint("LEFT", UIParent, "CENTER", 10, -250)
	TargetFrame:SetUserPlaced(true)
	for i=1,4 do
		p = _G["PartyMemberFrame"..i]
		p:ClearAllPoints()
		p:SetScale(1.25)
		p:SetPoint("RIGHT", UIParent, "CENTER", -200, i*50-200)
		p:SetUserPlaced(true)
		i = _G["PartyMemberFrame"..i.."PVPIcon"]
		i:SetAlpha(0)
	end
end

--[[ Flat Raid Statusbar Textures ]]
function styleraid()
hooksecurefunc("CompactUnitFrame_UpdateName", function(self)
	for g=1, NUM_RAID_GROUPS do
		for m = 1,6 do
			local frame = _G["CompactRaidGroup"..g.."Member"..m.."HealthBar"]
			if frame then
				select(2,frame:GetRegions()):SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
				local n = _G["CompactRaidGroup"..g.."Member"..m].name
				if hideraidnames then n:Hide() else
					n:SetFont("Fonts\\FRIZQT__.TTF", 16, "OUTLINE")
				end
			end	
			local frame = _G["CompactRaidFrame"..m.."HealthBar"]
			if frame then
				select(2,frame:GetRegions()):SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
				local n = _G["CompactRaidFrame"..m].name
				if hideraidnames then n:Hide() else
					n:SetFont("Fonts\\FRIZQT__.TTF", 16, "OUTLINE")
				end
			end
		end		
	end
end)
end

--[[ Flat other statusbar textures ]]	
function stylemisc()			
	for _, BarTextures in pairs({ TargetFrameNameBackground}) do
		BarTextures:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
	end
end		

--[[ Class Icons ]]--
function classicons()
	hooksecurefunc("UnitFramePortrait_Update",function(self)
		if self.portrait then
			if UnitIsPlayer(self.unit) then                         
				local t = CLASS_ICON_TCOORDS[select(2, UnitClass(self.unit))]
				if t then
					self.portrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
					self.portrait:SetTexCoord(unpack(t))
				end
			else
			self.portrait:SetTexCoord(0,1,0,1)
			end
		end
	end)
end

--[[ Class colored statusbars ]]--
function classcolors()
	local function colour(statusbar, unit)
		local _, class, c
			if UnitIsPlayer(unit) and UnitIsConnected(unit) and unit == statusbar.unit and UnitClass(unit) then
				_, class = UnitClass(unit)
				c = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
				statusbar:SetStatusBarColor(c.r, c.g, c.b)
			end
		end
	hooksecurefunc("UnitFrameHealthBar_Update", colour)
	hooksecurefunc("HealthBar_OnValueChanged", function(self)
		colour(self, self.unit)
	end)

--[[ Class colored Target/PlayerFrame ]]--
hooksecurefunc("TargetFrame_CheckFaction", function(self)
	if UnitIsPlayer("target") then
		t = RAID_CLASS_COLORS[select(2, UnitClass("target"))]
		self.nameBackground:SetVertexColor(t.r*0.4, t.g*0.4, t.b*0.4, 1);
	else
		self.nameBackground:SetAlpha(0.5);
	end
	if PlayerFrame:IsShown() and not PlayerFrame.bg then
		t = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
		bg=PlayerFrame:CreateTexture()
		bg:SetPoint("TOPLEFT",PlayerFrameBackground)
		bg:SetPoint("BOTTOMRIGHT",PlayerFrameBackground,0,22)
		bg:SetTexture(TargetFrameNameBackground:GetTexture())
		bg:SetVertexColor(t.r*0.4, t.g*0.4, t.b*0.4, 1)
		PlayerFrame.bg=true
	end
end)
end

--[[ Class colored Nameplates ]]--
function classplates()
	SetCVar("ShowClassColorInNameplate", 1)
	SetCVar("ShowClassColorInFriendlyNameplate", 1)
end	

--[[ Minimap Mousewheel support ]]
function minimap()
	Minimap:EnableMouseWheel(true)
	Minimap:SetScript('OnMouseWheel', function(self, delta)
		if delta > 0 then
			Minimap_ZoomIn()
		else
			Minimap_ZoomOut()
		end
	end)
end

--[[ Darken UI ]]--
function darken()
	local f = CreateFrame("Frame")
	f:RegisterEvent("PLAYER_ENTERING_WORLD")
	f:SetScript("OnEvent", function()  
		for i, v in pairs({
			PlayerFrameTexture, PetFrameTexture, TargetFrameTextureFrameTexture, TargetFrameToTTextureFrameTexture,
			PartyMemberFrame1Texture, PartyMemberFrame2Texture, PartyMemberFrame3Texture, PartyMemberFrame4Texture,
			PartyMemberFrame1PetFrameTexture, PartyMemberFrame2PetFrameTexture, PartyMemberFrame3PetFrameTexture, PartyMemberFrame4PetFrameTexture, 
			--CastingBarFrame.Border,  TargetFrameSpellBar.Border, 
			MainMenuBarTexture0, MainMenuBarTexture1, MainMenuBarTexture2, MainMenuBarTexture3,
			MinimapBorder, MiniMapTrackingButtonBorder, MiniMapLFGFrameBorder, MiniMapBattlefieldBorder, MiniMapMailBorder, MinimapBorderTop, 
			select(1, TimeManagerClockButton:GetRegions()),
			CompactRaidFrameManagerBg,
			--not sure
			BonusActionBarFrameTexture0, BonusActionBarFrameTexture1, BonusActionBarFrameTexture2, BonusActionBarFrameTexture3, BonusActionBarFrameTexture4,  
			MainMenuMaxLevelBar0, MainMenuMaxLevelBar1, MainMenuMaxLevelBar2, MainMenuMaxLevelBar3, 
			--temp
			--CodexBrowserIcon.overlay,
		}) do
			v:SetVertexColor(.2, .2, .2)
			select(2, TimeManagerClockButton:GetRegions()):SetTextColor(1,1,1,1)
		end
		for i, v in pairs({
			MainMenuXPBarTexture1,MainMenuXPBarTexture2, ReputationWatchBar.StatusBar.XPBarTexture0, ReputationWatchBar.StatusBar.XPBarTexture1,
			MainMenuBarLeftEndCap, MainMenuBarRightEndCap, StanceBarLeft, StanceBarMiddle, StanceBarRight, -- classic
		}) do
			v:SetVertexColor(.4, .4, .4)
		end
		for i=1, 5 do
			local cf = "ContainerFrame"
			local bg = "Background"
			_G[cf..i..bg.."Top"]:SetVertexColor(.4, .4, .4)
			_G[cf..i..bg.."Middle1"]:SetVertexColor(.4, .4, .4)
			_G[cf..i..bg.."Bottom"]:SetVertexColor(.4, .4, .4)
		end	
		for i=1,12 do 
			_G["ActionButton"..i.."NormalTexture"]:SetAlpha(0)	--:SetVertexColor(.2, .2, .2, 1)
			_G["ActionButton"..i]:SetBackdrop({
				edgeFile = "Interface/Tooltips/UI-Tooltip-Background", 
				edgeSize = 3, 
				})
			_G["ActionButton"..i]:SetBackdropBorderColor(0,0,0,1)			
			_G["MultiBarBottomLeftButton"..i.."NormalTexture"]:SetAlpha(0)	--:SetVertexColor(.2, .2, .2, 1)
			_G["MultiBarBottomLeftButton"..i]:SetBackdrop({
				edgeFile = "Interface/Tooltips/UI-Tooltip-Background", 
				edgeSize = 3, 
				})
			_G["MultiBarBottomLeftButton"..i]:SetBackdropBorderColor(0,0,0,1)
			_G["MultiBarBottomLeftButton"..i.."FloatingBG"]:SetVertexColor(.2, .2, .2, 1)
		end	
	f:UnregisterEvent("PLAYER_ENTERING_WORLD")
	f:SetScript("OnEvent", nil)
	end)
end	

--[[ Autosell Trash ]]
function vendor()
	local f = CreateFrame("Frame")
	f:RegisterEvent("MERCHANT_SHOW")
	f:SetScript("OnEvent", function()  
		local bag, slot
		for bag = 0, 4 do
			for slot = 0, GetContainerNumSlots(bag) do
				local link = GetContainerItemLink(bag, slot)
				if link and (select(3, GetItemInfo(link)) == 0) then
					UseContainerItem(bag, slot)
				end
			end
		end
		if(CanMerchantRepair()) then
			local cost = GetRepairAllCost()
		if cost > 0 then
			local money = GetMoney()
				if money > cost then
					RepairAllItems()
					print(format("|cffead000Repair cost: %.1fg|r", cost * 0.0001))
				else
					print("Not enough gold to cover the repair cost.")
				end
			end
		end
	end)
end

--[[ Int ]]--
local frame=CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if (addon == "odeUI") then
		RAID_CLASS_COLORS["SHAMAN"] = CreateColor(0, 0.44, 0.87, 1);
		if db == nil then db = {
			hideraidnames = false,
			stylemisc = true,
			styleraid = true,
			hide = true,
			move = true,
			bags = true,
			lagbar = true,
			hidebartext = true,
			mouseover = true,
			castbars = true,
			uf = true,
			classicons = true,
			classcolors = true,
			classplates = true,
			minimap = true,
			redrange = true,
			darken = true,
			vendor = false,
			}
		end 
	end		
	if (addon == "Blizzard_TimeManager") then
		do		
			if db.darken then darken() end
			if db.stylemisc then stylemisc() end
			if db.styleraid then styleraid() end
			if db.hide then hide() end
			if db.move then move() end
			if db.hidebartext then hidebartext() end
			if db.mouseover then mouseover() end
			if db.uf then uf() end
			if db.classicons then classicons() end
			if db.classcolors then classcolors() end
			if db.classplates then classplates() end
			if db.minimap then minimap() end
			if db.lagbar then lagbar() end
			if db.castbars then castbars() end
			if db.bags then bags() end
			if db.redrange then redrange() end
			if db.vendor then vendor() end
			misc()
		end
		self:UnregisterEvent("ADDON_LOADED")
		frame:SetScript("OnEvent", nil)
	end
end) 
