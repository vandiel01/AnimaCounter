	local vAC_AppTitle = "|CFF00CCFF"..strsub(GetAddOnMetadata("AnimaCounter", "Title"),49).."|r"
	local vAC_PlayerLevel = UnitLevel("player")
------------------------------------------------------------------------
-- Anima Counts
------------------------------------------------------------------------	
	function AnimaCount()
		
		local AnimaID = {
			181368, 181377, 181477, 181478, 181479, 181540, 181541,	181544,	181545, 181546,
			181547, 181548, 181549, 181550, 181551, 181552, 181621, 181622, 181642, 181643,
			181644, 181645, 181646, 181647, 181648, 181649, 181650, 181743, 181744, 181745,
			
			182749, 
			
			183723, 183727, 
			
			184146, 184147, 184148,	184149, 184150, 184151, 184152, 184286, 184293, 184294,
			184305, 184306, 184307, 184315, 184360, 184362, 184363, 184371, 184373, 184374,
			184378, 184379, 184380, 184381,	184382, 184383,	184384, 184385,	184386, 184387,
			184388, 184389, 184519, 184763, 184764, 184765, 184766, 184767, 184768, 184769,
			184770, 184771, 184772,	184773, 184774, 184775, 184776, 184777,
			
			186200,	186201,	186202, 186204,	186205, 186206,
			
			187175, 187347, 187349, 187517,
		}
		local TotalCount, TotalPiece = 0, 0
		local AnimaReservoir = C_CurrencyInfo.GetCurrencyInfo(1813).quantity
		
		for a = 1, #AnimaID do
			local AnimaCount = GetItemCount(AnimaID[a],true,true)
				TotalPiece = TotalPiece + AnimaCount
			
			local iName, _, iRare = GetItemInfo(AnimaID[a])		
			local tCnt = 0

			if iRare == 2 then tCnt = AnimaCount*5 end
			if iRare == 3 then tCnt = AnimaCount*35 end
			if iRare == 4 then tCnt = AnimaCount*250 end
			TotalCount = TotalCount + tCnt
		end
		
		_G["vAV1"].Text:SetText((TotalPiece or 0).." ("..(TotalCount or 0)..")")
		_G["vAV2"].Text:SetText((AnimaReservoir or 0))
		_G["vAV3"].Text:SetText(((TotalCount + AnimaReservoir) or 0))
		_G["vAV5"].Text:SetText(((35000-(AnimaReservoir+TotalCount)) or 0))
	end
------------------------------------------------------------------------
-- Color Choice
------------------------------------------------------------------------
	function Colors(c,t,e)
		-- 1R 2G 3B 4Y 5B 6W 7Custom 8Inputs
		if c == 8 then
			ColorChoice = ExpacColor[e]
		else
			local ColorSelect = { "FF0000", "00FF00", "0000FF", "FFFF00", "000000", "FFFFFF", "CCCC66", }
			ColorChoice = ColorSelect[c]
		end
		return "|cFF"..ColorChoice..(t == nil and "" or t).."|r"
	end
	
------------------------------------------------------------------------
-- Table of Frame Backdrops
------------------------------------------------------------------------
	local Backdrop_A = {
		edgeFile = "Interface\\ToolTips\\UI-Tooltip-Border",
		bgFile = "Interface\\BlackMarket\\BlackMarketBackground-Tile",
		tileEdge = true,
		tileSize = 16,
		edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 }
	}

	local Font_Lg = 14		--Large Font Size
	local Font_Md = 12		--Medium Font Size
	local Font_Sm = 10		--Small/Normal Font Size
	local FontStyle = { "Fonts\\FRIZQT__.TTF", "Fonts\\ARIALN.ttf", "Fonts\\MORPHEUS.ttf", "Fonts\\skurri.ttf", }
	
	local l,r,t,b,h,w,HdrPos = 0,0,0,0,0,0,0
	-- 1 Kyrian, 2 Venthyr, 3 NightFae, 4 Necrolord
	-- Left, Width, Height
	local CovPic = {{ 926,52,85, }, { 856,60,83, }, { 770,75,75, }, { 696,70,90, }}
------------------------------------------------------------------------
-- Mini Window for Anima Counter
------------------------------------------------------------------------

	local vAC_Main = CreateFrame("Frame", "vAC_Main", UIParent, BackdropTemplateMixin and "BackdropTemplate")
		vAC_Main:SetBackdrop(Backdrop_A)
		vAC_Main:SetSize(160,120)
		vAC_Main:ClearAllPoints()
		vAC_Main:SetPoint("CENTER", UIParent, 0, 0)
		vAC_Main:EnableMouse(true)
		vAC_Main:SetMovable(true)
		vAC_Main:RegisterForDrag("LeftButton")
		vAC_Main:SetScript("OnDragStart", function() vAC_Main:StartMoving() end)
		vAC_Main:SetScript("OnDragStop", function() vAC_Main:StopMovingOrSizing() end)
		vAC_Main:SetClampedToScreen(true)

	local vAC_Title = CreateFrame("Frame", "vAC_Title", vAC_Main, BackdropTemplateMixin and "BackdropTemplate")
		vAC_Title:SetSize(vAC_Main:GetWidth()-5,24)
		vAC_Title:ClearAllPoints()
		vAC_Title:SetPoint("TOP", vAC_Main, 0, -3)

		vAC_Title.Text = vAC_Title:CreateFontString("T")
		vAC_Title.Text:SetFont(FontStyle[1], Font_Lg, "OUTLINE")
		vAC_Title.Text:SetPoint("LEFT", vAC_Title, 20, 0)
		vAC_Title.Text:SetText(vAC_AppTitle)
		
		local vAC_TitleX = CreateFrame("Button", "vAC_TitleX", vAC_Title, "UIPanelCloseButton")
			vAC_TitleX:SetSize(26,26)
			vAC_TitleX:SetPoint("RIGHT", vAC_Title, 3, 3)
			vAC_TitleX:SetScript("OnClick", function() vAC_Main:Hide() end)

	local AnimaRow = { "In Bag/Bank:", "In Reservoir:", "Total:", "", "Til Cap:" }
		HdrPos = -26
		for i = 1, #AnimaRow do
			local vAR = CreateFrame("Frame","vAR"..i,vAC_Main,BackdropTemplateMixin and "BackdropTemplate")
				if i == 4 then x = 10 else x = 22 end
				vAR:SetSize(80,x)
				vAR:SetPoint("TOPLEFT",vAC_Main,2,HdrPos)
					vAR.Text = vAR:CreateFontString("vAR"..i)
					vAR.Text:SetFont(FontStyle[1], Font_Sm)
					vAR.Text:SetPoint("RIGHT", "vAR"..i, -4, 0)
					vAR.Text:SetText(Colors(6,AnimaRow[i]))
			if i == 3 then HdrPos = HdrPos - 8 else HdrPos = HdrPos - 19 end
		end
		HdrPos = -26
		for i = 1, 5 do
			local vAV = CreateFrame("Frame","vAV"..i,vAC_Main,BackdropTemplateMixin and "BackdropTemplate")
				if i == 4 then x = 10 else x = 22 end
				vAV:SetSize(80,x)
				vAV:SetPoint("TOPLEFT",vAC_Main,82,HdrPos)
					vAV.Text = vAV:CreateFontString("vAV"..i)
					vAV.Text:SetFont(FontStyle[1], Font_Sm)
					vAV.Text:SetPoint("LEFT", "vAV"..i, 4, 0)
					vAV.Text:SetText("")
			if i == 3 then HdrPos = HdrPos - 8 else HdrPos = HdrPos - 19 end
		end
		
------------------------------------------------------------------------
-- Fire Up Events
------------------------------------------------------------------------
	local vAC_OnUpdate = CreateFrame("Frame")
	vAC_OnUpdate:RegisterEvent("ADDON_LOADED")
	vAC_OnUpdate:SetScript("OnEvent", function(self, event, ...)
		if event == "ADDON_LOADED" then
			local TheEvents = {
				"PLAYER_MONEY",				-- Listen for Anima Amount Changes
				"CURRENCY_DISPLAY_UPDATE",	-- Currency Updater
				"BAG_UPDATE",				-- Fire when there new Anima in the BAG
			}
			for ev = 1, #TheEvents do
				vAC_OnUpdate:RegisterEvent(TheEvents[ev])
			end
			vAC_OnUpdate:UnregisterEvent("ADDON_LOADED")
			vAC_OnUpdate:RegisterEvent("PLAYER_LOGIN")
		end
		if event == "PLAYER_LOGIN" then
			DEFAULT_CHAT_FRAME:AddMessage("Loaded: "..vAC_AppTitle)
			SLASH_AnimaCounter1 = '/ac'
			SLASH_AnimaCounter2 = '/acount'
			SLASH_AnimaCounter3 = '/animacounter'
			SlashCmdList["AnimaCounter"] = function(cmd)
				if not vAC_Main:IsVisible() then vAC_Main:Show() else vAC_Main:Hide() end
			end
		
			if (vAC_PlayerLevel <= 49) then
				vAC_Main:Hide()
			else
				local cID = C_Covenants.GetActiveCovenantID()
				if (cID == 0 or cID == nil) then cID = 1 end
				w, h, l, r, t, b = 1024, 512, CovPic[cID][1], CovPic[cID][1]+CovPic[cID][2], 362, CovPic[cID][3]+362
				vAC_Title.Logo = vAC_Title:CreateTexture(nil, "ARTWORK")
				vAC_Title.Logo:SetSize(CovPic[cID][2]*.55,CovPic[cID][3]*.55)
				vAC_Title.Logo:SetPoint("TOPLEFT", vAC_Title, -15, 20)
				vAC_Title.Logo:SetTexture("Interface\\CovenantChoice\\CovenantChoiceCelebration")
				vAC_Title.Logo:SetTexCoord(l/w, r/w, t/h, b/h)
				Status = xpcall(AnimaCount(),err)
			end
			vAC_OnUpdate:UnregisterEvent("PLAYER_LOGIN")
		end
		if (event == "PLAYER_MONEY") or (event == "CURRENCY_DISPLAY_UPDATE") or (event == "BAG_UPDATE") then
			if vAC_Main:IsVisible() then Status = xpcall(AnimaCount(),err) end
		end
	end)