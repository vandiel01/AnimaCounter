	local vAC_AppTitle = "|CFF00CCFF"..strsub(GetAddOnMetadata("AnimaCounter", "Title"),49).."|r"
	local vAC_PlayerLevel = UnitLevel("player")
	local vAC_DEBUG = false
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
			
			if vAC_DEBUG and (iName ~= nil or AnimaCount ~= 0) then
				print(iName.." ["..AnimaCount.."]")
				vAC_DEBUG = false
			end
		end
		
		-- Test Number
		-- vVa.Text:SetText("9,999 (9,999,999)")
		vVa.Text:SetText((BreakUpLargeNumbers(TotalPiece) or 0).." ("..(BreakUpLargeNumbers(TotalCount) or 0)..")")
		vVb.Text:SetText(BreakUpLargeNumbers(AnimaReservoir) or 0)
		vVc.Text:SetText(BreakUpLargeNumbers(TotalCount + AnimaReservoir) or 0)
		vVd.Text:SetText(BreakUpLargeNumbers(35000-(AnimaReservoir+TotalCount)) or 0)
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
	
	local l,r,t,b,h,w,hS,wS,HdrPos = 0,0,0,0,0,0,0,0,0
	-- 1 Kyrian, 2 Venthyr, 3 NightFae, 4 Necrolord
	-- Left, Width, Height
	local CovPic = {{ 926,52,85, }, { 856,60,83, }, { 770,75,75, }, { 696,70,90, }}
------------------------------------------------------------------------
-- Window for Anima Counter
------------------------------------------------------------------------

	local vAC_Main = CreateFrame("Frame", "vAC_Main", UIParent, BackdropTemplateMixin and "BackdropTemplate")
		vAC_Main:SetBackdrop(Backdrop_A)
		vAC_Main:SetSize(175,95)
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
		vAC_Title.Text:SetPoint("CENTER", vAC_Title, 0, 0)
		vAC_Title.Text:SetText(vAC_AppTitle)
		
		local vAC_TitleX = CreateFrame("Button", "vAC_TitleX", vAC_Title, "UIPanelCloseButton")
			vAC_TitleX:SetSize(26,26)
			vAC_TitleX:SetPoint("RIGHT", vAC_Title, 3, 3)
			vAC_TitleX:SetScript("OnClick", function() vAC_Main:Hide() end)

	local AnimaRow = { "In Bag/Bank:", "In Reservoir:", "Total:", "Til Cap:" }
	local vTa = CreateFrame("Frame","vTa",vAC_Main,BackdropTemplateMixin and "BackdropTemplate")
	--	vTa:SetBackdrop(Backdrop_A)
		vTa:SetSize(75,20)
		vTa:SetPoint("TOPLEFT",vAC_Main,2,-22)
		vTa.Text = vTa:CreateFontString("vTa")
		vTa.Text:SetFont(FontStyle[1], Font_Sm)
		vTa.Text:SetPoint("RIGHT", "vTa", -4, 0)
		vTa.Text:SetText(Colors(7,AnimaRow[1]))
		local vVa = CreateFrame("Frame","vVa",vAC_Main,BackdropTemplateMixin and "BackdropTemplate")
	--		vVa:SetBackdrop(Backdrop_A)
			vVa:SetSize(84,20)
			vVa:SetPoint("TOPLEFT",vAC_Main,72,-22)
			vVa.Text = vVa:CreateFontString("vVa")
			vVa.Text:SetFont(FontStyle[1], Font_Sm)
			vVa.Text:SetPoint("LEFT", "vVa", 4, 0)
			vVa.Text:SetText("--- (---)")
			
	local vTb = CreateFrame("Frame","vTb",vAC_Main,BackdropTemplateMixin and "BackdropTemplate")
	--	vTb:SetBackdrop(Backdrop_A)
		vTb:SetSize(75,20)
		vTb:SetPoint("TOPLEFT",vAC_Main,2,-38)
		vTb.Text = vTb:CreateFontString("vTb")
		vTb.Text:SetFont(FontStyle[1], Font_Sm)
		vTb.Text:SetPoint("RIGHT", "vTb", -4, 0)
		vTb.Text:SetText(Colors(7,AnimaRow[2]))
		local vVb = CreateFrame("Frame","vVb",vAC_Main,BackdropTemplateMixin and "BackdropTemplate")
	--		vVb:SetBackdrop(Backdrop_A)
			vVb:SetSize(84,20)
			vVb:SetPoint("TOPLEFT",vAC_Main,72,-38)
			vVb.Text = vVb:CreateFontString("vVb")
			vVb.Text:SetFont(FontStyle[1], Font_Sm)
			vVb.Text:SetPoint("LEFT", "vVb", 4, 0)
			vVb.Text:SetText("---")
			
	local vTc = CreateFrame("Frame","vTc",vAC_Main,BackdropTemplateMixin and "BackdropTemplate")
	--	vTc:SetBackdrop(Backdrop_A)
		vTc:SetSize(75,18)
		vTc:SetPoint("TOPLEFT",vAC_Main,2,-54)
		vTc.Text = vTc:CreateFontString("vTc")
		vTc.Text:SetFont(FontStyle[1], Font_Sm)
		vTc.Text:SetPoint("RIGHT", "vTc", -4, 0)
		vTc.Text:SetText(Colors(7,AnimaRow[3]))
		local vVc = CreateFrame("Frame","vVc",vAC_Main,BackdropTemplateMixin and "BackdropTemplate")
	--		vVc:SetBackdrop(Backdrop_A)
			vVc:SetSize(84,18)
			vVc:SetPoint("TOPLEFT",vAC_Main,72,-54)
			vVc.Text = vVc:CreateFontString("vVc")
			vVc.Text:SetFont(FontStyle[1], Font_Sm)
			vVc.Text:SetPoint("LEFT", "vVc", 4, 0)
			vVc.Text:SetText("---")

	local vAC_Line = vAC_Main:CreateTexture("vAC_Line")
		vAC_Line:SetSize(165,2)
		vAC_Line:SetTexture("Interface\\BUTTONS\\WHITE8X8")
		vAC_Line:SetColorTexture(.6,.6,.6,.2)
		vAC_Line:SetPoint("TOPLEFT",vAC_Main,8,-71)

	local vTd = CreateFrame("Frame","vTd",vAC_Main,BackdropTemplateMixin and "BackdropTemplate")
	--	vTd:SetBackdrop(Backdrop_A)
		vTd:SetSize(75,18)
		vTd:SetPoint("TOPLEFT",vAC_Main,2,-73)
		vTd.Text = vTd:CreateFontString("vTd")
		vTd.Text:SetFont(FontStyle[1], Font_Sm)
		vTd.Text:SetPoint("RIGHT", "vTd", -4, 0)
		vTd.Text:SetText(Colors(7,AnimaRow[4]))
		local vVd = CreateFrame("Frame","vVd",vAC_Main,BackdropTemplateMixin and "BackdropTemplate")
	--		vVd:SetBackdrop(Backdrop_A)
			vVd:SetSize(84,18)
			vVd:SetPoint("TOPLEFT",vAC_Main,72,-73)
			vVd.Text = vVd:CreateFontString("vVd")
			vVd.Text:SetFont(FontStyle[1], Font_Sm)
			vVd.Text:SetPoint("LEFT", "vVd", 4, 0)
			vVd.Text:SetText("---")
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
				if cmd == "miss" then
					vAC_DEBUG = true
					Status = xpcall(AnimaCount(),err)
				else
					if not vAC_Main:IsVisible() then vAC_Main:Show() else vAC_Main:Hide() end
				end
			end
		
			if (vAC_PlayerLevel <= 49) then
				vAC_Main:Hide()
			else
				vAC_Title.Logo = vAC_Title:CreateTexture(nil, "ARTWORK")
				local cID = C_Covenants.GetActiveCovenantID()
				w, h = 1024, 512
				if (cID == 0 or cID == nil) then
					l, r, t, b, wS, hS = 434, 540, 372, 475, 106, 103
					vAC_Title.Logo:SetPoint("TOPLEFT", vAC_Title, -21, 21)
				else
					l, r, t, b, wS, hS = CovPic[cID][1], CovPic[cID][1]+CovPic[cID][2], 362, CovPic[cID][3]+362, CovPic[cID][2], CovPic[cID][3]
					vAC_Title.Logo:SetPoint("TOPLEFT", vAC_Title, -12, 12)
				end
				vAC_Title.Logo:SetTexture("Interface\\CovenantChoice\\CovenantChoiceCelebration")
				vAC_Title.Logo:SetSize(wS*.40,hS*.40)
				vAC_Title.Logo:SetTexCoord(l/w, r/w, t/h, b/h)
				Status = xpcall(AnimaCount(),err)
			end
			vAC_OnUpdate:UnregisterEvent("PLAYER_LOGIN")
		end
		if (event == "PLAYER_MONEY") or (event == "CURRENCY_DISPLAY_UPDATE") or (event == "BAG_UPDATE") then
			if vAC_Main:IsVisible() then Status = xpcall(AnimaCount(),err) end
		end
	end)